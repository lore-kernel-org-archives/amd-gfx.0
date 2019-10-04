From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH][next] drm/amdgpu: fix uninitialized variable
 pasid_mapping_needed
Date: Fri, 4 Oct 2019 07:28:52 +0000
Message-ID: <55116b72-4e15-7efe-09a6-283a7090966a@amd.com>
References: <20191003215227.23540-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191003215227.23540-1-colin.king@canonical.com>
Content-Language: en-US
Content-ID: <47E0B4F1D4595146B4BE94E6715EE50D@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Colin King <colin.king@canonical.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

QW0gMDMuMTAuMTkgdW0gMjM6NTIgc2NocmllYiBDb2xpbiBLaW5nOg0KPiBGcm9tOiBDb2xpbiBJ
YW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPg0KPiBUaGUgYm9vbGVhbiB2YXJp
YWJsZSBwYXNpZF9tYXBwaW5nX25lZWRlZCBpcyBub3QgaW5pdGlhbGl6ZWQgYW5kDQo+IHRoZXJl
IGFyZSBjb2RlIHBhdGhzIHRoYXQgZG8gbm90IGFzc2lnbiBpdCBhbnkgdmFsdWUgYmVmb3JlIGl0
IGlzDQo+IGlzIHJlYWQgbGF0ZXIuICBGaXggdGhpcyBieSBpbml0aWFsaXppbmcgcGFzaWRfbWFw
cGluZ19uZWVkZWQgdG8NCj4gZmFsc2UuDQo+DQo+IEFkZHJlc3Nlcy1Db3Zlcml0eTogKCJVbmlu
aXRpYWxpemVkIHNjYWxhciB2YXJpYWJsZSIpDQo+IEZpeGVzOiA2ODE3YmYyODNiMmIgKCJkcm0v
YW1kZ3B1OiBncmFiIHRoZSBpZCBtZ3IgbG9jayB3aGlsZSBhY2Nlc3NpbmcgcGFzc2lkX21hcHBp
bmciKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmlj
YWwuY29tPg0KDQpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiBpbmRl
eCBhMmM3OTdlMzRhMjkuLmJlMTBlNGI5YTk0ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMNCj4gQEAgLTEwNTUsNyArMTA1NSw3IEBAIGludCBhbWRncHVfdm1f
Zmx1c2goc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCBzdHJ1Y3QgYW1kZ3B1X2pvYiAqam9iLA0K
PiAgIAkJaWQtPm9hX3NpemUgIT0gam9iLT5vYV9zaXplKTsNCj4gICAJYm9vbCB2bV9mbHVzaF9u
ZWVkZWQgPSBqb2ItPnZtX25lZWRzX2ZsdXNoOw0KPiAgIAlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5j
ZSA9IE5VTEw7DQo+IC0JYm9vbCBwYXNpZF9tYXBwaW5nX25lZWRlZDsNCj4gKwlib29sIHBhc2lk
X21hcHBpbmdfbmVlZGVkID0gZmFsc2U7DQo+ICAgCXVuc2lnbmVkIHBhdGNoX29mZnNldCA9IDA7
DQo+ICAgCWludCByOw0KPiAgIA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9kcmktZGV2ZWw=
