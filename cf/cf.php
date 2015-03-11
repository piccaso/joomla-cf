<?php

defined( '_JEXEC' ) or die( 'Restricted access' );
require_once(__DIR__.'/lib.php');
 
jimport( 'joomla.plugin.plugin' );
 
class PlgSystemcf extends JPlugin
{
	public function __construct( &$subject, $config )
	{
		parent::__construct( $subject, $config );
	}
 
	function onAfterInitialise(){
    if (!empty($_SERVER['HTTP_CF_CONNECTING_IP'])) {
  		$cf_ip_ranges = array('204.93.240.0/24','204.93.177.0/24','199.27.128.0/21','173.245.48.0/20','103.21.244.0/22','103.22.200.0/22','103.31.4.0/22','141.101.64.0/18','108.162.192.0/18','190.93.240.0/20','188.114.96.0/20','197.234.240.0/22','198.41.128.0/17','162.158.0.0/15');
  		foreach ($cf_ip_ranges as $range) {
        if (ip_in_range($_SERVER['REMOTE_ADDR'], $range)) {
          $_SERVER['REMOTE_ADDR'] = $_SERVER['HTTP_CF_CONNECTING_IP'];
          break;
        }
  		}
    }
	}

}
