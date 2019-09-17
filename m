From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use GPU PAGE SHIFT for umc retired page
Date: Tue, 17 Sep 2019 10:14:11 +0200
Message-ID: <37a36b18-2bfd-c737-29c5-2b146021f128@gmail.com>
References: <20190917062213.29480-1-tao.zhou1@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190917062213.29480-1-tao.zhou1-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Chen, Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMTcuMDkuMTkgdW0gMDg6MjIgc2NocmllYiBaaG91MSwgVGFvOgo+IHVtYyByZXRpcmVkIHBh
Z2UgYmVsb25ncyB0byB2cmFtIGFuZCBpdCBzaG91bGQgYmUgYWxpZ25lZCB0byBncHUgcGFnZQo+
IHNpemUKPgo+IFNpZ25lZC1vZmYtYnk6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNvbT4KClJl
dmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+
IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdW1jX3Y2XzEuYyB8IDIgKy0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3VtY192Nl8xLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS91bWNfdjZfMS5jCj4gaW5kZXggMWMwZGEzMmMxNTYxLi40N2M0Yjk2
YjE0ZDEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdW1jX3Y2XzEu
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3VtY192Nl8xLmMKPiBAQCAtMjEz
LDcgKzIxMyw3IEBAIHN0YXRpYyB2b2lkIHVtY192Nl8xX3F1ZXJ5X2Vycm9yX2FkZHJlc3Moc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCQkJPT0gMSkgewo+ICAgCQkJZXJyX3JlYy0+
YWRkcmVzcyA9IGVycl9hZGRyOwo+ICAgCQkJLyogcGFnZSBmcmFtZSBhZGRyZXNzIGlzIHNhdmVk
ICovCj4gLQkJCWVycl9yZWMtPnJldGlyZWRfcGFnZSA9IHJldGlyZWRfcGFnZSA+PiBQQUdFX1NI
SUZUOwo+ICsJCQllcnJfcmVjLT5yZXRpcmVkX3BhZ2UgPSByZXRpcmVkX3BhZ2UgPj4gQU1ER1BV
X0dQVV9QQUdFX1NISUZUOwo+ICAgCQkJZXJyX3JlYy0+dHMgPSAodWludDY0X3Qpa3RpbWVfZ2V0
X3JlYWxfc2Vjb25kcygpOwo+ICAgCQkJZXJyX3JlYy0+ZXJyX3R5cGUgPSBBTURHUFVfUkFTX0VF
UFJPTV9FUlJfTk9OX1JFQ09WRVJBQkxFOwo+ICAgCQkJZXJyX3JlYy0+Y3UgPSAwOwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
