From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/5] drm/amdgpu: check scratch registers to see if we
 need post
Date: Thu, 6 Jul 2017 14:07:34 +0800
Message-ID: <595DD3A6.2060804@amd.com>
References: <1498858359-11352-1-git-send-email-alexander.deucher@amd.com>
 <1498858359-11352-4-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1498858359-11352-4-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

T24gMDcvMDEvMjAxNyAwNTozMiBBTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IFJhdGhlciB0aGFu
IGNoZWNraW5nIHRoZSBDT05HSUdfTUVNU0laRSByZWdpc3RlciBhcyB0aGF0IG1heQo+IG5vdCBi
ZSByZWxpYWJsZSBvbiBzb21lIEFQVXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAxMCArLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDkgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gaW5kZXggNjNmNGJlZC4uOWQwOGY1MyAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBAQCAtNzE2LDIw
ICs3MTYsMTIgQEAgdm9pZCBhbWRncHVfZ3R0X2xvY2F0aW9uKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X21jICptYykKPiAgICAqLwo+ICAgYm9vbCBhbWRncHVfbmVl
ZF9wb3N0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgewo+IC0JdWludDMyX3QgcmVn
Owo+IC0KPiAgIAlpZiAoYWRldi0+aGFzX2h3X3Jlc2V0KSB7Cj4gICAJCWFkZXYtPmhhc19od19y
ZXNldCA9IGZhbHNlOwo+ICAgCQlyZXR1cm4gdHJ1ZTsKPiAgIAl9Cj4gLQkvKiB0aGVuIGNoZWNr
IE1FTV9TSVpFLCBpbiBjYXNlIHRoZSBjcnRjcyBhcmUgb2ZmICovCj4gLQlyZWcgPSBhbWRncHVf
YXNpY19nZXRfY29uZmlnX21lbXNpemUoYWRldik7CgpEbyB3ZSBzdGlsbCBuZWVkIGl0IGZvciBT
ST8KCkplcnJ5Cgo+IC0KPiAtCWlmICgocmVnICE9IDApICYmIChyZWcgIT0gMHhmZmZmZmZmZikp
Cj4gLQkJcmV0dXJuIGZhbHNlOwo+IC0KPiAtCXJldHVybiB0cnVlOwo+Cj4gKwlyZXR1cm4gYW1k
Z3B1X2F0b21iaW9zX3NjcmF0Y2hfbmVlZF9hc2ljX2luaXQoYWRldik7Cj4gICB9Cj4KPiAgIHN0
YXRpYyBib29sIGFtZGdwdV92cG9zdF9uZWVkZWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
