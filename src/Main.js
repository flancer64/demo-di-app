/**
 * The factory function to create new app function objects.
 *
 * @param {Sample_Lib_Config} Config - inject as ESM
 * @param {Sample_Lib_Service} service - inject the default export as a singleton.
 */
export default function (
    {
        Sample_Lib_Config: Config,
        Sample_Lib_Service$: service,
    }
) {
    // VARS
    /** @type {{default: Sample_Lib_Service}}} */
    const {
        default: config
    } = Config; // destruct the Module and get the default export

    // MAIN
    // modify injected environment (config is also singleton object defined on the ES module level)
    config.name = 'Sample App';

    // create application
    return function (name) {
        // use singleton instance
        service.exec(name);
    };
}