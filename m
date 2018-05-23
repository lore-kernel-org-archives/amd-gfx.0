From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix the missed vcn fw version report
Date: Wed, 23 May 2018 09:34:58 +0200
Message-ID: <f9486313-260c-42c0-641f-b2d1b4a42dc3@gmail.com>
References: <1527055996-32237-1-git-send-email-ray.huang@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1527055996-32237-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjMuMDUuMjAxOCB1bSAwODoxMyBzY2hyaWViIEh1YW5nIFJ1aToKPiBJdCBtaXNzZWQgdmNu
LmZ3X3ZlcnNpb24gc2V0dGluZyB3aGVuIGluaXQgdmNuIG1pY3JvY29kZSwgYW5kIGl0IHdpbGwg
YmUgdXNlZCB0bwo+IHJlcG9ydCB2Y24gdWNvZGUgdmVyc2lvbiB2aWEgYW1kZ3B1X2Zpcm13YXJl
X2luZm8gc3lzZnMgaW50ZXJmYWNlLgo+Cj4gU2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXku
aHVhbmdAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Zjbi5jIHwgMSArCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPiBpbmRleCA1OGU0OTUzLi44N2U4
OWNjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24u
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+IEBAIC04
NCw2ICs4NCw3IEBAIGludCBhbWRncHVfdmNuX3N3X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCj4gICAJfQo+ICAgCj4gICAJaGRyID0gKGNvbnN0IHN0cnVjdCBjb21tb25fZmlybXdh
cmVfaGVhZGVyICopYWRldi0+dmNuLmZ3LT5kYXRhOwo+ICsJYWRldi0+dmNuLmZ3X3ZlcnNpb24g
PSBsZTMyX3RvX2NwdShoZHItPnVjb2RlX3ZlcnNpb24pOwo+ICAgCWZhbWlseV9pZCA9IGxlMzJf
dG9fY3B1KGhkci0+dWNvZGVfdmVyc2lvbikgJiAweGZmOwo+ICAgCXZlcnNpb25fbWFqb3IgPSAo
bGUzMl90b19jcHUoaGRyLT51Y29kZV92ZXJzaW9uKSA+PiAyNCkgJiAweGZmOwo+ICAgCXZlcnNp
b25fbWlub3IgPSAobGUzMl90b19jcHUoaGRyLT51Y29kZV92ZXJzaW9uKSA+PiA4KSAmIDB4ZmY7
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
