## File contains all API keys for OpenHub
# Source it to wherever you need keys

# API keys
# Sayali's key
oh_key_sp <- "f4b26446fe7946dc11e35e1e34e99aa9c2362b4294ce5d9799913fb6edcb7487"

# Sayali's other key
oh_key_ssp <- "8d65198778b2c33c216cc560af86d3d730ac3a936ead6cc297212b5b13bc01ae"

# Alex's key
oh_key_old <- "d32768dd2ec65efd004d19a9f3c7262d7f30cd8959d9009ce4f9b8e7e19ff0ef&v=1"

# Ben's key
oh_key_bjs <- "ea13e69a9fe006292249cffce39e96a5781088724a61cda6dba72fd9e71ecc06"

# Lata's key
oh_key_lk <- "60ec34006651da0607103a505cc688a4bdbf09b076798f5a31a330b4ac20bb32"

# Kyle's key
oh_key_km <- "95fd35a60145093710ed0dee5c2e39d1db1e54fbf09d4093ac29e1e613899bd6"

# Claire's key
oh_key_ck <- "352e2f22da39903451ab880c1fcbf5ce048d811b1b643d6d7bad879215d5f9fd"

# Kim's key
oh_key_kl <- "c35d07a8fdaf3d4e8e751c8bb6c4a83526d59a01b3bc8dddce86c79a385826d1"

# Lori's key
oh_key_lc <- "b1d57a7b8eee53271e35c5bfe6dc5c22238e8f0fed4b3543255c815e55db1014"

# Simu's key
oh_key_hs <- "8da56929b785b7a5035ed04472b05b94301c374da3cf98f3218b28acfe068f70"

# Zarni's key
oh_key_zh <- "e3fcef6534731f1268be86d5e5f5bfaf54f870a426ce0346fd94ef261adbad45"

# Eirik's key
oh_key_ei <- "789849b1179587e1333f41990a1542f48ae139dd43c3cfbf414618278a247380"

# Chanida's key
oh_key_cl <- "5c32fe933ee240ff26192dd1c1e1eb6b5f44b6a0b80d3ed5f75a0a0ca425f212"

# Gizem's key
oh_key_gk <- "f5e0d9a3818409f1a676f4b1e15323e574ec337a760b79e97960dd270ddc6704"

# Craig's key
oh_key_cm <- "94ad08fef0f6d41303d99d70a1c80cf96f539592262af8cd10011c6bba562236"

# Sean's key
oh_key_sep <- "44f8e85c82a77af8b28731b8ade12c6adc40b4ca6fd9a93c2e8b3f20d32af096"

# Ronnie's key
oh_key_rf <- "7ce2bd34d8e5426fd0e9cd828ac1b13e4ecfcfdf7d975d5fdd1f9ad879c4bc4d"

# Maddie's key 1
oh_key_ma1 <- "5a19c11b1e2698257900a213568fdde7a9d7bdda9e2cfa4ff245eb8ba06f6168"

# Maddie's key 2
oh_key_ma2 <- "5d21e94b455dcf2be1c4d007f3e23c47fb81e33b279626739208d0cd972cc3ad"

# Maddie's key 3
oh_key_ma3 <- "cdb55288a662d478dfde7b98c27cdfbe92ddca9511c52d084a84dd51331ef41b"

# Daniel's key
oh_key_dc <- "af70ae2a1ec5f8a79e2aa6a80835467fe4a383b4ebc22384914160934634f239"

# David H's key
oh_key_dh <- "e155740ba9caa5ecbb43715c17b2f17392eb8bbf87bea522b40676f31b4815a2"



## Test api pull
# Run this on each new key to make sure it works
# library(httr)
# test_pull <- function(path, page_no, api_key){
#   info <- GET(sprintf('https://www.openhub.net%s.xml?%s&api_key=%s',
#                       path, #page URL
#                       page_no, #must be in form "page=n"
#                       api_key))
#   return(info)
# }
#
# blah <- test_pull("/projects/firefox", "", oh_key_dh)
# check that blah has status code 200



