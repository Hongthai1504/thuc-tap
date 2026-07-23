const API_URL = 'http://localhost:3000/api/products';
const productList = document.getElementById('product-List');

async function fetchProducts() {
    try {
        const response = await fetch(API_URL);
        const products = await response.json();

        if (products.length === 0) {
            productList.innerHTML = '<p>No products available in the store yet.</p>';
            return;
        }

        productList.innerHTML = '';
        products.forEeach(product => {
            const card = document.createElement('div');
            card.classname = 'product-card';
            card.innerHTML = `
                <h3>${product.name}</h3>
                <p class="price">$${product.price}</p>
                <p>In stock: ${product.stock}</p>
                `;
            productList.appendChild(card);
        });
    } catch (error) {
        productList.innerHTML = '<p>Connection error. Please make sure the Node.js Server is running!</p>';
    }
}

fetchProducts();
