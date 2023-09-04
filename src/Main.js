/**
 * The factory function to create new app function objects.
 *
 * @param {typeof Sample_Lib_Config} config - The default export as a singleton object.
 * @param {Sample_Lib_Service} service - Use the default export to create a singleton instance.
 */
export default function (
    {
        Sample_Lib_Config: config,
        Sample_Lib_Service$: service,
    }
) {
    // modify injected environment (singleton object)
    config.name = 'Sample App';

    // create application
    return function (name) {
        // use singleton instance
        service.exec(name);
    };
}