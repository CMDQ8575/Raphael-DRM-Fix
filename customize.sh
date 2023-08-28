if [ "$(getprop ro.product.system.device)" != "raphael" ]; then
    abort "This module is for Redmi K20 Pro only"
fi
array=$(find /system/etc /vendor/etc /product/etc -name raphael.xml)
for CFG in $array
do
    [[ -f $CFG ]] && [[ ! -L $CFG ]] && {
    SELECTPATH=$CFG
    mkdir -p `dirname $MODPATH/system$CFG`
    ui_print "- Modifying $SELECTPATH"
    cp -af $SELECTPATH $MODPATH/system$SELECTPATH
    sed -i 's|<integer name="support_widevine_l1">1</integer>|<integer name="support_widevine_l1">2</integer>|g' $MODPATH/system$SELECTPATH
    }
done
set_perm_recursive "$MODPATH/system/vendor/lib64" 0 0 0755 0644 u:object_r:vendor_file:s0
