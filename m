From: "Liu, Leo" <Leo.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix structurally dead code vcn_v2_5_hw_init
Date: Tue, 1 Oct 2019 22:21:20 +0000
Message-ID: <23314fce-800c-552f-e879-464f9709d12b@amd.com>
References: <20191001171635.GA17306@embeddedor>
 <192815d9-5ecb-09a7-4624-5fd36126890d@amd.com>
 <823b10a3-fe0e-2e8c-02c3-534944dbe6d2@embeddedor.com>
 <dc76a52b-09a2-7ab9-b53e-52500f4f8669@amd.com>
 <3c6ebf4a-8cba-40e2-7d70-c4d5006a160b@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3c6ebf4a-8cba-40e2-7d70-c4d5006a160b@embeddedor.com>
Content-Language: en-US
Content-ID: <6815B8CBB7A62E49A2816B454DB0BE00@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

DQpPbiAyMDE5LTEwLTAxIDU6NTcgcC5tLiwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToNCj4N
Cj4gT24gMTAvMS8xOSAxNjo0NiwgTGl1LCBMZW8gd3JvdGU6DQo+DQo+Pj4+PiArCQlyaW5nLT5z
Y2hlZC5yZWFkeSA9IHRydWU7DQo+Pj4+IFRoaXMgaXMgcmVkdW5kYW50LiBhbGwgdGhlIHNjaGVk
LT5yZWFkeSBpcyBpbml0aWFsaXplZCBhcyB0cnVlLCBwbGVhc2UNCj4+Pj4gcmVmZXIgdG8gZHJt
X3NjaGVkX2luaXQoKQ0KPj4+Pg0KPj4+IEkgc2VlLi4uIHNvIGluIHRoZSBmb2xsb3dpbmcgY29t
bWl0IDFiNjFkZTQ1ZGZhZiAoImRybS9hbWRncHU6IGFkZCBpbml0aWFsIFZDTjIuMCBzdXBwb3J0
ICh2MikiKQ0KPj4+IHRoYXQgbGluZSBpcyBhbHNvIHJlZHVuZGFudD8NCj4+IFllcy4NCj4+DQo+
IE9LLg0KPg0KPj4+Pj4gICAgIAkJciA9IGFtZGdwdV9yaW5nX3Rlc3RfcmluZyhyaW5nKTsNCj4+
Pj4+ICAgICAJCWlmIChyKSB7DQo+Pj4+PiAgICAgCQkJcmluZy0+c2NoZWQucmVhZHkgPSBmYWxz
ZTsNCj4+Pj4+IEBAIC0yNjYsOCArMjY3LDcgQEAgc3RhdGljIGludCB2Y25fdjJfNV9od19pbml0
KHZvaWQgKmhhbmRsZSkNCj4+Pj4+ICAgICANCj4+Pj4+ICAgICAJCWZvciAoaSA9IDA7IGkgPCBh
ZGV2LT52Y24ubnVtX2VuY19yaW5nczsgKytpKSB7DQo+Pj4+PiAgICAgCQkJcmluZyA9ICZhZGV2
LT52Y24uaW5zdFtqXS5yaW5nX2VuY1tpXTsNCj4+Pj4+IC0JCQlyaW5nLT5zY2hlZC5yZWFkeSA9
IGZhbHNlOw0KPj4+Pj4gLQkJCWNvbnRpbnVlOw0KPj4+Pj4gKwkJCXJpbmctPnNjaGVkLnJlYWR5
ID0gdHJ1ZTsNCj4+Pj4gQmVjYXVzZSB0aGUgVkNOIDIuNSBGVyBzdGlsbCBoYXMgaXNzdWUgZm9y
IGVuY29kZSwgc28gd2UgaGF2ZSBpdA0KPj4+PiBkaXNhYmxlZCBoZXJlLg0KPj4+Pg0KPj4+IE9L
LiBTbywgbWF5YmUgd2UgY2FuIGFkZCBhIGNvbW1lbnQgcG9pbnRpbmcgdGhhdCBvdXQ/DQo+PiBU
aGF0IGNvdWxkIGJlIGJldHRlci4NCj4+DQo+IEdyZWF0LiBJJ20gZ2xhZCBpdCdzIG5vdCBhIGJ1
Zy4gIEknbGwgd3JpdGUgYSBwYXRjaCBmb3IgdGhhdCBzbyBvdGhlcg0KPiBwZW9wbGUgZG9uJ3Qg
d2FzdGUgdGltZSB0YWtpbmcgYSBsb29rLg0KDQpUaGFua3MsIGp1c3Qgc2VudCB0d28gcGF0Y2hl
cyB0byBhZGQgY29tbWVudCwgYW5kIGxvbmcgd2l0aCB0aGUgcGF0Y2ggdG8gDQptYWtlIFZDTiBy
aW5nIHJlYWR5IHByb3Blcmx5Lg0KDQpMZW8NCg0KDQoNCg0KPg0KPiBJIGFwcHJlY2lhdGUgeW91
ciBmZWVkYmFjay4NCj4gVGhhbmtzDQo+IC0tDQo+IEd1c3Rhdm8NCg==
