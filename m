From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 06/10] drm/amdgpu:cleanup unused stack var
Date: Tue, 14 Nov 2017 12:53:03 +0100
Message-ID: <effe59a6-ecd2-1d72-fdfe-06d1fffa1e9a@gmail.com>
References: <1510650468-5708-1-git-send-email-Monk.Liu@amd.com>
 <1510650468-5708-7-git-send-email-Monk.Liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1510650468-5708-7-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTQuMTEuMjAxNyB1bSAxMDowNyBzY2hyaWViIE1vbmsgTGl1Ogo+IENoYW5nZS1JZDogSTVk
M2VhNWZhY2MyM2JjYzk0ODA2YTA5OGFlOTQ1NWNlMTU2NGZhMDkKPiBTaWduZWQtb2ZmLWJ5OiBN
b25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMyArLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMKPiBpbmRleCA5NDcxZjQ3Li5jMTNiNDkzIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+IEBAIC02ODEsNyArNjgxLDYg
QEAgaW50IGFtZGdwdV9md19yZXNlcnZlX3ZyYW1faW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKPiAgIHsKPiAgIAlpbnQgciA9IDA7Cj4gICAJaW50IGk7Cj4gLQl1NjQgZ3B1X2FkZHI7
Cj4gICAJdTY0IHZyYW1fc2l6ZSA9IGFkZXYtPm1jLnZpc2libGVfdnJhbV9zaXplOwo+ICAgCXU2
NCBvZmZzZXQgPSBhZGV2LT5md192cmFtX3VzYWdlLnN0YXJ0X29mZnNldDsKPiAgIAl1NjQgc2l6
ZSA9IGFkZXYtPmZ3X3ZyYW1fdXNhZ2Uuc2l6ZTsKPiBAQCAtNzI1LDcgKzcyNCw3IEBAIGludCBh
bWRncHVfZndfcmVzZXJ2ZV92cmFtX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4g
ICAJCQlBTURHUFVfR0VNX0RPTUFJTl9WUkFNLAo+ICAgCQkJYWRldi0+ZndfdnJhbV91c2FnZS5z
dGFydF9vZmZzZXQsCj4gICAJCQkoYWRldi0+ZndfdnJhbV91c2FnZS5zdGFydF9vZmZzZXQgKwo+
IC0JCQlhZGV2LT5md192cmFtX3VzYWdlLnNpemUpLCAmZ3B1X2FkZHIpOwo+ICsJCQlhZGV2LT5m
d192cmFtX3VzYWdlLnNpemUpLCBOVUxMKTsKPiAgIAkJaWYgKHIpCj4gICAJCQlnb3RvIGVycm9y
X3BpbjsKPiAgIAkJciA9IGFtZGdwdV9ib19rbWFwKGFkZXYtPmZ3X3ZyYW1fdXNhZ2UucmVzZXJ2
ZWRfYm8sCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
