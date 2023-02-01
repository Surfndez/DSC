pub mod discovery;
pub mod dscresources;
pub mod dscerror;

use discovery::ResourceIterator;

pub struct DscManager {
    discovery: discovery::Discovery,
}

impl DscManager {
    pub fn new() -> Self {
        Self {
            discovery: discovery::Discovery::new(),
        }
    }

    pub fn find_resource(&self, name: &str) -> ResourceIterator {
        self.discovery.find_resource(name)
    }
}

impl Default for DscManager {
    fn default() -> Self {
        Self::new()
    }
}
