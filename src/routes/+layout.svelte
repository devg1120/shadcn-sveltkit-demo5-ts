<script lang="ts">
	import '../app.css';
	
	let { children } = $props();

</script>

<style>
.menu {
    display: flex;
    list-style: none;
}

.menu li {
    margin: 6px  6px;
    padding: 4px 15px;
    border: 1px solid #000000;
    height: 35px;
}
</style>

<ul class="menu">
 <li><a href="/">top</a></li>
 <li><a href="/mail">mail</a></li>
 <li><a href="/dashboard">dashboard</a></li>                                    
 <li><a href="/auth">auth</a></li>
 <li><a href="/cards">cards</a></li>
 <li><a href="/colors">colors</a></li>
 <li><a href="/music">music</a></li>
 <li><a href="/tasks">tasks</a></li>
 <li><a href="/themes">themes</a></li>
</ul>

{@render children()}
