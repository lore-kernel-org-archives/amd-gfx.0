From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix double reference dropping
Date: Wed, 6 Nov 2019 09:59:14 +0000
Message-ID: <b7b3c444-9ece-dd08-cb4c-c7ac4009373b@amd.com>
References: <1573033994-17102-1-git-send-email-bianpan2016@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1573033994-17102-1-git-send-email-bianpan2016@163.com>
Content-Language: en-US
Content-ID: <77E364CC8E10554AB20F379E5D40C4B0@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Pan Bian <bianpan2016@163.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

QW0gMDYuMTEuMTkgdW0gMTA6NTMgc2NocmllYiBQYW4gQmlhbjoNCj4gQWZ0ZXIgZHJvcHBpbmcg
dGhlIHJlZmVyZW5jZSBvZiBvYmplY3QgZmVuY2UgaW4gdGhlIGxvb3AsIGl0IHNob3VsZCBiZQ0K
PiBzZXQgdG8gTlVMTCB0byBwcm90ZWN0aW5nIGRyb3BwaW5nIGl0cyByZWZlcmVuY2UgYWdhaW4g
b3V0c2lkZSB0aGUgbG9vcC4NCg0KTkFLLCB0aGUgYWN0dWFsIGJ1ZyBpcyB0aGF0IHdlIHNob3Vs
ZG4ndCBkcm9wIHRoZSBmZW5jZSBvdXRzaWRlIHRoZSBsb29wIA0KaW4gdGhlIGZpcnN0IHBsYWNl
Lg0KDQpKdXN0IG1vdmUgdGhlIGRtYV9mZW5jZV9wdXQoZmVuY2UpOyB0d28gbGluZXMgdXAgYW5k
IGRyb3AgaW5pdGlhbGl6aW5nIA0KZmVuY2UgdG8gTlVMTC4NCg0KUmVnYXJkcywNCkNocmlzdGlh
bi4NCg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBQYW4gQmlhbiA8YmlhbnBhbjIwMTZAMTYzLmNvbT4N
Cj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JlbmNobWFyay5j
IHwgMSArDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmVuY2htYXJrLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmVuY2htYXJrLmMNCj4gaW5kZXggNjQ5ZTY4
YzQ0NzliLi4zMTc0MDkzZjM1ZjMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9iZW5jaG1hcmsuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYmVuY2htYXJrLmMNCj4gQEAgLTQ3LDYgKzQ3LDcgQEAgc3RhdGljIGludCBh
bWRncHVfYmVuY2htYXJrX2RvX21vdmUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVuc2ln
bmVkIHNpemUsDQo+ICAgCQlpZiAocikNCj4gICAJCQlnb3RvIGV4aXRfZG9fbW92ZTsNCj4gICAJ
CWRtYV9mZW5jZV9wdXQoZmVuY2UpOw0KPiArCQlmZW5jZSA9IE5VTEw7DQo+ICAgCX0NCj4gICAJ
ZW5kX2ppZmZpZXMgPSBqaWZmaWVzOw0KPiAgIAlyID0gamlmZmllc190b19tc2VjcyhlbmRfamlm
ZmllcyAtIHN0YXJ0X2ppZmZpZXMpOw0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcmktZGV2ZWw=
