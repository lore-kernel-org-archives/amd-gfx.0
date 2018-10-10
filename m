From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/amdgpu/rlc: unify rlc function into structure
Date: Wed, 10 Oct 2018 14:04:36 +0200
Message-ID: <f049396d-cec9-a6a1-e56f-2c9fac3bf060@gmail.com>
References: <1539171776-8157-1-git-send-email-likun.gao@amd.com>
 <1539171776-8157-2-git-send-email-likun.gao@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1539171776-8157-2-git-send-email-likun.gao-5C7GfCeVMHo@public.gmane.org>
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
To: likun Gao <likun.gao-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTAuMTAuMjAxOCB1bSAxMzo0MiBzY2hyaWViIGxpa3VuIEdhbzoKPiBGcm9tOiBMaWt1biBH
YW8gPExpa3VuLkdhb0BhbWQuY29tPgo+Cj4gUHV0IGZ1bmN0aW9uIHJsY19pbml0LHJsY19maW5p
LHJsY19yZXN1bWUscmxjX3N0b3AscmxjX3N0YXJ0IGludG8gc3RydWN0dXJlCj4gYW1kZ3B1X3Js
Y19mdW5jcy4KPgo+IFNpZ25lZC1vZmYtYnk6IExpa3VuIEdhbyA8TGlrdW4uR2FvQGFtZC5jb20+
Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmggfCA2ICsr
KysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguaCBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguaAo+IGluZGV4IGI2MWI1YzEuLmJiN2IxYWQgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oCj4gQEAgLTQxLDYgKzQxLDEy
IEBACj4gICBzdHJ1Y3QgYW1kZ3B1X3JsY19mdW5jcyB7Cj4gICAJdm9pZCAoKmVudGVyX3NhZmVf
bW9kZSkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwo+ICAgCXZvaWQgKCpleGl0X3NhZmVf
bW9kZSkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwo+ICsJaW50ICAoKnJsY19pbml0KShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7Cj4gKwl2b2lkICgqcmxjX2ZpbmkpKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KTsKPiArCWludCAgKCpybGNfcmVzdW1lKShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldik7Cj4gKwl2b2lkICgqcmxjX3N0b3ApKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KTsKPiArCXZvaWQgKCpybGNfcmVzZXQpKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KTsKPiArCXZvaWQgKCpybGNfc3RhcnQpKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKClBs
ZWFzZSBkcm9wIHRoZSBybGNfIHByZWZpeCB0byBhbGwgdGhvc2UgbWVtYmVycy4gVGhlIHN0cnVj
dHVyZSBuYW1lIAphbHJlYWR5IGRlbm90ZXMgaXQgYXMgcmxjIGZ1bmN0aW9ucy4KCkNocmlzdGlh
bi4KCj4gICB9Owo+ICAgCj4gICBzdHJ1Y3QgYW1kZ3B1X3JsYyB7CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
