/**
 * Created by jonathanjackson on 13/11/14.
 */

var client = contentful.createClient({
    accessToken: '2a82b5b2834fa236a7931acf8c231537328be48d13afa026a3874622047cc228',
    space: 'mft2fbi95x0j'
});

var log = console.log.bind(console); // wat

//Get Contacts

function contcts() {
    client.entries({
        content_type: '4ygwXLGXPWWuWcQGiSeyGa'
    }).then(function (result) {
        $("#listview").kendoMobileListView({
            dataSource: kendo.data.DataSource.create({data: result, group: "fields.lastName.charAt(0)", sort: {field: "fields.lastName", dir: "asc"}}),
            template: "" +
            "<img class='item-photo' src=http:${fields.image.fields.file.url}>" +
            "<h2>${fields.firstName} ${fields.lastName}</h2>" +
            "<br>" +
            "<h4>${fields.title} (${fields.practice})</h4>" +
            "<h4>${fields.office.fields.name} (${fields.office.fields.country})</h4>" +
            "<p>tel:${fields.telephone}</p>" +
            "<p>mob:${fields.mobile}</p>" +
            "<p>${fields.email}</p>",
            filterable: {
                field: "fields.office.fields.country",
                operator: "startswith",
                placeholder: "Search by Country..."
            },
            fixedHeaders: true
        });
    });
}