From: =?UTF-8?Q?Christian_K=c3=b6nig?= via amd-gfx
 <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: don't clamp debugfs register access to the
 BAR size
Date: Tue, 12 Feb 2019 11:15:04 +0100
Message-ID: <f716fc19-02fa-da3d-1d35-ba0bb23d4629@gmail.com>
References: <20190211215221.31597-1-alexander.deucher@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190211215221.31597-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMTEuMDIuMTkgdW0gMjI6NTIgc2NocmllYiBBbGV4IERldWNoZXIgdmlhIGFtZC1nZng6Cj4g
VGhpcyBwcmV2ZW50cyB1cyBmcm9tIGFjY2Vzc2luZyBleHRlbmRlZCByZWdpc3RlcnMgaW4gdG9v
bHMgbGlrZQo+IHVtci4gIFRoZSByZWdpc3RlciBhY2Nlc3MgZnVuY3Rpb25zIGFscmVhZHkgY2hl
Y2sgaWYgdGhlIG9mZnNldAo+IGlzIGJleW9uZCB0aGUgQkFSIHNpemUgYW5kIHVzZSB0aGUgaW5k
aXJlY3QgYWNjZXNzb3JzIHdpdGggbG9ja2luZwo+IHNvIHRoaXMgaXMgc2FmZS4KPgo+IFNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KClJldmll
d2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0t
LQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyB8IDMgLS0t
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYwo+IGluZGV4IGRkOWE0ZmI5Y2UzOS4uNGFlM2Zm
OWExZDRjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZWJ1Z2ZzLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdm
cy5jCj4gQEAgLTE1OCw5ICsxNTgsNiBAQCBzdGF0aWMgaW50ICBhbWRncHVfZGVidWdmc19wcm9j
ZXNzX3JlZ19vcChib29sIHJlYWQsIHN0cnVjdCBmaWxlICpmLAo+ICAgCXdoaWxlIChzaXplKSB7
Cj4gICAJCXVpbnQzMl90IHZhbHVlOwo+ICAgCj4gLQkJaWYgKCpwb3MgPiBhZGV2LT5ybW1pb19z
aXplKQo+IC0JCQlnb3RvIGVuZDsKPiAtCj4gICAJCWlmIChyZWFkKSB7Cj4gICAJCQl2YWx1ZSA9
IFJSRUczMigqcG9zID4+IDIpOwo+ICAgCQkJciA9IHB1dF91c2VyKHZhbHVlLCAodWludDMyX3Qg
KilidWYpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
