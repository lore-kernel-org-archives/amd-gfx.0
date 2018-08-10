From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix integer overflow test in
 amdgpu_bo_list_create()
Date: Fri, 10 Aug 2018 19:52:56 +0800
Message-ID: <20180810115255.GA22140@hr-amur2>
References: <20180810105032.cltqjuv7tqfud7n6@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180810105032.cltqjuv7tqfud7n6-vMlZ3nK25oGAIHFoDFOv9A@public.gmane.org>
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
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Bas Nieuwenhuizen <basni-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Cihangir Akturk <cakturk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Russell,
 Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

T24gRnJpLCBBdWcgMTAsIDIwMTggYXQgMDY6NTA6MzJQTSArMDgwMCwgRGFuIENhcnBlbnRlciB3
cm90ZToKPiBXZSBhY2NpZGVudGFsbHkgbGVmdCBvdXQgdGhlIHNpemUgb2YgdGhlIGFtZGdwdV9i
b19saXN0IHN0cnVjdC4gIEl0Cj4gY291bGQgbGVhZCB0byBtZW1vcnkgY29ycnVwdGlvbiBvbiAz
MiBiaXQgc3lzdGVtcy4gIFlvdSdkIGhhdmUgdG8KPiBwaWNrIHRoZSBhYnNvbHV0ZSBtYXhpbXVt
IGFuZCBzZXQgIm51bV9lbnRyaWVzID09IDU5NjUyMzIzIiB0aGVuIHNpemUKPiB3b3VsZCB3cmFw
IHRvIDE2IGJ5dGVzLgo+IAo+IEZpeGVzOiA5MjA5OTBjYjA4MGEgKCJkcm0vYW1kZ3B1OiBhbGxv
Y2F0ZSB0aGUgYm9fbGlzdCBhcnJheSBhZnRlciB0aGUgbGlzdCIpCj4gU2lnbmVkLW9mZi1ieTog
RGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPgoKTmljZSBjYXRjaCEKQWNr
ZWQtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cgo+IAo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYm9fbGlzdC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JvX2xpc3QuYwo+IGluZGV4IGQ0NzJhMmM4Mzk5Zi4uYjgw
MjQzZDM5NzJlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9ib19saXN0LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYm9f
bGlzdC5jCj4gQEAgLTY3LDcgKzY3LDggQEAgaW50IGFtZGdwdV9ib19saXN0X2NyZWF0ZShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGRybV9maWxlICpmaWxwLAo+ICAJdW5zaWdu
ZWQgaTsKPiAgCWludCByOwo+ICAKPiAtCWlmIChudW1fZW50cmllcyA+IFNJWkVfTUFYIC8gc2l6
ZW9mKHN0cnVjdCBhbWRncHVfYm9fbGlzdF9lbnRyeSkpCj4gKwlpZiAobnVtX2VudHJpZXMgPiAo
U0laRV9NQVggLSBzaXplb2Yoc3RydWN0IGFtZGdwdV9ib19saXN0KSkKPiArCQkJCS8gc2l6ZW9m
KHN0cnVjdCBhbWRncHVfYm9fbGlzdF9lbnRyeSkpCj4gIAkJcmV0dXJuIC1FSU5WQUw7Cj4gIAo+
ICAJc2l6ZSA9IHNpemVvZihzdHJ1Y3QgYW1kZ3B1X2JvX2xpc3QpOwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
