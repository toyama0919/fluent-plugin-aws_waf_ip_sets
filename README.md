# fluent-plugin-aws_waf_ip_sets
<!-- [![Build Status](https://secure.travis-ci.org/toyama0919/fluent-plugin-aws_waf_ip_sets.png?branch=master)](http://travis-ci.org/toyama0919/fluent-plugin-aws_waf_ip_sets) -->
[![Gem Version](https://badge.fury.io/rb/fluent-plugin-aws_waf_ip_sets.svg)](http://badge.fury.io/rb/fluent-plugin-aws_waf_ip_sets)

AWS waf ip_sets automation plugin for fluentd

## Examples(interval one minutes)
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

## interval

### 1 minutes

```
time_slice_format %Y%m%d_%H%M
```

### 1 hours

```
time_slice_format %Y%m%d%H
```

### 12 hours

```
time_slice_format %Y%m%d%p
```

### 1 days

```
time_slice_format %Y%m%d
```

### 1 weeks

```
time_slice_format %Y%m%w
```

* if use long interval, please set a larger `buffer_chunk_limit`.

## parameter

#### ip_address_key
  * ip address key of record

#### dos_threshold
  * threshold

#### ip_set_id
  * AWS waf ip_set_id

#### white_list
  * white list ip address (comma separated values)

#### ip_set_type
  * IPV4 or IPV6

#### api_type
  * waf or waf_regional

#### aws_access_key_id
  * support iam role.
  * support environment variables.

#### aws_secret_access_key
  * support iam role.
  * support environment variables.

#### aws_region
  * support iam role.
  * support environment variables.


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

