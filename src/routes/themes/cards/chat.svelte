<script lang="ts">
	import Check from "svelte-radix/Check.svelte";
	import PaperPlane from "svelte-radix/PaperPlane.svelte";
	import Plus from "svelte-radix/Plus.svelte";
	import { cn } from "$lib/utils.js";
	import * as Avatar from "$lib/components/ui/avatar/index.js";
	import * as Card from "$lib/components/ui/card/index.js";
	import * as Command from "$lib/components/ui/command/index.js";
	import * as Dialog from "$lib/components/ui/dialog/index.js";
	import * as Tooltip from "$lib/components/ui/tooltip/index.js";
	import { Button } from "$lib/components/ui/button/index.js";
	import { Input } from "$lib/components/ui/input/index.js";

	const users = [
		{
			name: "Olivia Martin",
			email: "m@example.com",
			avatar: "/avatars/01.png",
		},
		{
			name: "Isabella Nguyen",
			email: "isabella.nguyen@email.com",
			avatar: "/avatars/03.png",
		},
		{
			name: "Emma Wilson",
			email: "emma@example.com",
			avatar: "/avatars/05.png",
		},
		{
			name: "Jackson Lee",
			email: "lee@example.com",
			avatar: "/avatars/02.png",
		},
		{
			name: "William Kim",
			email: "will@email.com",
			avatar: "/avatars/04.png",
		},
	] as const;

	type User = (typeof users)[number];

	let open = false;
	let selectedUsers: User[] = [];

	let messages = [
		{
			role: "agent",
			content: "Hi, how can I help you today?",
		},
		{
			role: "user",
			content: "Hey, I'm having trouble with my account.",
		},
		{
			role: "agent",
			content: "What seems to be the problem?",
		},
		{
			role: "user",
			content: "I can't log in.",
		},
	];

	let input = "";
	$: inputLength = input.trim().length;
</script>

<Card.Root>
	<Card.Header class="flex flex-row items-center">
		<div class="flex items-center space-x-4">
			<Avatar.Root>
				<Avatar.Image src="/avatars/01.png" alt="Image" />
				<Avatar.Fallback>OM</Avatar.Fallback>
			</Avatar.Root>
			<div>
				<p class="text-sm font-medium leading-none">Sofia Davis</p>
				<p class="text-muted-foreground text-sm">m@example.com</p>
			</div>
		</div>
		<!--
		<Tooltip.Root openDelay={0}>
			<Tooltip.Trigger asChild>
				<Button
					size="icon"
					variant="outline"
					class="ml-auto rounded-full"
					on:click={() => (open = true)}
				>
					<Plus class="h-4 w-4" />
					<span class="sr-only">New message</span>
				</Button>
			</Tooltip.Trigger>
			<Tooltip.Content sideOffset={10}>New message</Tooltip.Content>
		</Tooltip.Root>
		-->
	</Card.Header>
	<Card.Content>
		<div class="space-y-4">
			{#each messages as message}
				<div
					class={cn(
						"flex w-max max-w-[75%] flex-col gap-2 rounded-lg px-3 py-2 text-sm",
						message.role === "user"
							? "bg-primary text-primary-foreground ml-auto"
							: "bg-muted"
					)}
				>
					{message.content}
				</div>
			{/each}
		</div>
	</Card.Content>
	<Card.Footer>
		<form
			on:submit={(event) => {
				event.preventDefault();
				if (inputLength === 0) return;
				messages = [
					...messages,
					{
						role: "user",
						content: input,
					},
				];
				input = "";
			}}
			class="flex w-full items-center space-x-2"
		>
			<Input
				id="message"
				placeholder="Type your message..."
				class="flex-1"
				autocomplete="off"
				bind:value={input}
			/>
			<Button type="submit" size="icon" disabled={inputLength === 0}>
				<PaperPlane class="h-4 w-4" />
				<span class="sr-only">Send</span>
			</Button>
		</form>
	</Card.Footer>
</Card.Root>
<Dialog.Root bind:open>
	<Dialog.Content class="gap-0 p-0 outline-none">
		<Dialog.Header class="px-4 pb-4 pt-5">
			<Dialog.Title>New message</Dialog.Title>
			<Dialog.Description>
				Invite a user to this thread. This will create a new group message.
			</Dialog.Description>
		</Dialog.Header>
		<Command.Root class="overflow-hidden rounded-t-none border-t bg-transparent">
			<Command.Input placeholder="Search user..." />
			<Command.List>
				<Command.Empty>No users found.</Command.Empty>
				<Command.Group class="p-2">
					{#each users as user}
						<Command.Item
							class="flex items-center px-2"
							onSelect={() => {
								if (selectedUsers.includes(user)) {
									selectedUsers = selectedUsers.filter(
										(selectedUser) => selectedUser !== user
									);
								} else {
									selectedUsers = [...users].filter((u) =>
										[...selectedUsers, user].includes(u)
									);
								}
							}}
						>
							<Avatar.Root>
								<Avatar.Image src={user.avatar} alt="Image" />
								<Avatar.Fallback>{user.name[0]}</Avatar.Fallback>
							</Avatar.Root>
							<div class="ml-2">
								<p class="text-sm font-medium leading-none">
									{user.name}
								</p>
								<p class="text-muted-foreground text-sm">
									{user.email}
								</p>
							</div>
							{#if selectedUsers.includes(user)}
								<Check class="text-primary ml-auto flex h-5 w-5" />
							{/if}
						</Command.Item>
					{/each}
				</Command.Group>
			</Command.List>
		</Command.Root>
		<Dialog.Footer class="flex items-center border-t p-4 sm:justify-between">
			{#if selectedUsers.length}
				<div class="flex -space-x-2 overflow-hidden">
					{#each selectedUsers as user}
						<Avatar.Root class="border-background inline-block border-2">
							<Avatar.Image src={user.avatar} />
							<Avatar.Fallback>{user.name[0]}</Avatar.Fallback>
						</Avatar.Root>
					{/each}
				</div>
			{:else}
				<p class="text-muted-foreground text-sm">Select users to add to this thread.</p>
			{/if}
			<Button disabled={selectedUsers.length < 2} on:click={() => (open = false)}>
				Continue
			</Button>
		</Dialog.Footer>
	</Dialog.Content>
</Dialog.Root>
