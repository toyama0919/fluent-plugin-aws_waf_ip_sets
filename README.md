# fluent-plugin-aws_waf_ip_sets
<!-- [![Build Status](https://secure.travis-ci.org/toyama0919/fluent-plugin-aws_waf_ip_sets.png?branch=master)](http://travis-ci.org/toyama0919/fluent-plugin-aws_waf_ip_sets) -->
[![Gem Version](https://badge.fury.io/rb/fluent-plugin-aws_waf_ip_sets.svg)](http://badge.fury.io/rb/fluent-plugin-aws_waf_ip_sets)

AWS waf ip_sets automation plugin for fluentd

## Examples
```
<match lambda.**>
  @type aws_waf_ip_sets
  ip_address_key ip_address
  dos_threshold 1000
  ip_set_id xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
  white_list 192.168.0.1
  buffer_path /tmp/test
  time_slice_format %Y%m%d_%H%M
  time_slice_wait 10s
  buffer_type file
</match>
```

## parameter

* ip_address_key
  * ip address key of record

* dos_threshold
  * threshold

* ip_set_id
  * AWS waf ip_set_id

* white_list
  * white list ip address (comma separated values)

## Installation
```
fluent-gem install fluent-plugin-aws_waf_ip_sets
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## Information

* [Homepage](https://github.com/toyama0919/fluent-plugin-aws_waf_ip_sets)
* [Issues](https://github.com/toyama0919/fluent-plugin-aws_waf_ip_sets/issues)
* [Documentation](http://rubydoc.info/gems/fluent-plugin-aws_waf_ip_sets/frames)
* [Email](mailto:toyama0919@gmail.com)

## Copyright

Copyright (c) 2017 Hiroshi Toyama

