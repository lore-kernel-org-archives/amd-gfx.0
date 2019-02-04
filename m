From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 0/6] drm/drv: Remove drm_dev_unplug()
Date: Mon, 4 Feb 2019 12:45:00 +0000
Message-ID: <3931dd51-fd72-c20c-0209-00142c9e939e@amd.com>
References: <20190203154200.61479-1-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190203154200.61479-1-noralf@tronnes.org>
Content-Language: en-US
Content-ID: <6A5E08DC0321E844B052E2DA703248C9@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?utf-8?B?Tm9yYWxmIFRyw7hubmVz?= <noralf@tronnes.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Cc: "oleksandr_andrushchenko@epam.com" <oleksandr_andrushchenko@epam.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "airlied@redhat.com" <airlied@redhat.com>, "sean@poorly.run" <sean@poorly.run>
List-Id: amd-gfx.lists.freedesktop.org

QWRkaW5nIEFuZHJleSB3aG8gbG9va2VkIGludG8gY2xlYW5pbmcgdGhpcyB1cCBhIHdoaWxlIGFn
byBhcyB3ZWxsLg0KDQpDaHJpc3RpYW4uDQoNCkFtIDAzLjAyLjE5IHVtIDE2OjQxIHNjaHJpZWIg
Tm9yYWxmIFRyw7hubmVzOg0KPiBUaGlzIHNlcmllcyByZW1vdmVzIGRybV9kZXZfdW5wbHVnKCkg
YW5kIG1vdmVzIHRoZSB1bnBsdWdnZWQgc3RhdGUNCj4gc2V0dGluZyB0byBkcm1fZGV2X3VucmVn
aXN0ZXIoKS4gQWxsIGRyaXZlcnMgd2lsbCBub3cgaGF2ZSBhY2Nlc3MgdG8gdGhlDQo+IHVucGx1
Z2dlZCBzdGF0ZSBpZiB0aGV5IHNvIGRlc2lyZS4NCj4NCj4gVGhlIGRybV9kZXZpY2UgcmVmIGhh
bmRsaW5nIHdydCB0byB0aGUgbGFzdCBmZCBjbG9zZWQgYWZ0ZXIgdW5yZWdpc3Rlcg0KPiBoYXZl
IGJlZW4gc2ltcGxpZmllZCwgd2hpY2ggYWxzbyBmaXhlZCBhIGRvdWJsZSBkcm1fZGV2X3VucmVn
aXN0ZXIoKQ0KPiBzaXR1YXRpb24uDQo+DQo+IE5vcmFsZi4NCj4NCj4gTm9yYWxmIFRyw7hubmVz
ICg2KToNCj4gICAgZHJtOiBGaXggZHJtX3JlbGVhc2UoKSBhbmQgZGV2aWNlIHVucGx1Zw0KPiAg
ICBkcm0vZHJ2OiBQcmVwYXJlIHRvIHJlbW92ZSBkcm1fZGV2X3VucGx1ZygpDQo+ICAgIGRybS9h
bWQ6IFVzZSBkcm1fZGV2X3VucmVnaXN0ZXIoKQ0KPiAgICBkcm0vdWRsOiBVc2UgZHJtX2Rldl91
bnJlZ2lzdGVyKCkNCj4gICAgZHJtL3hlbjogVXNlIGRybV9kZXZfdW5yZWdpc3RlcigpDQo+ICAg
IGRybS9kcnY6IFJlbW92ZSBkcm1fZGV2X3VucGx1ZygpDQo+DQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgIDMgKy0NCj4gICBkcml2ZXJzL2dwdS9kcm0vZHJt
X2Rydi5jICAgICAgICAgICAgICAgfCA0OCArKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2RybV9maWxlLmMgICAgICAgICAgICAgIHwgIDYgKystLQ0KPiAgIGRy
aXZlcnMvZ3B1L2RybS91ZGwvdWRsX2Rydi5jICAgICAgICAgICB8ICAzICstDQo+ICAgZHJpdmVy
cy9ncHUvZHJtL3hlbi94ZW5fZHJtX2Zyb250LmMgICAgIHwgIDcgKystLQ0KPiAgIGluY2x1ZGUv
ZHJtL2RybV9kcnYuaCAgICAgICAgICAgICAgICAgICB8IDExICsrKy0tLQ0KPiAgIDYgZmlsZXMg
Y2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgNTEgZGVsZXRpb25zKC0pDQo+DQoNCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
