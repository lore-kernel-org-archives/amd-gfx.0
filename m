From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Mask rptr as well in ring debugfs
Date: Thu, 1 Mar 2018 16:20:16 +0100
Message-ID: <b84439b4-ea8c-f696-a3ad-23b661b473ad@gmail.com>
References: <20180301144349.20824-1-tom.stdenis@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180301144349.20824-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDEuMDMuMjAxOCB1bSAxNTo0MyBzY2hyaWViIFRvbSBTdCBEZW5pczoKPiBUaGUgcmVhZC93
cml0ZSBwb2ludGVycyBvbiBzZG1hNCBkZXZpY2VzIGluY3JlbWVudAo+IGJleW9uZCB0aGUgcmlu
ZyBzaXplIGFuZCBzaG91bGQgYmUgbWFza2VkLiAgVGVzdGVkCj4gb24gbXkgUnl6ZW4gMjQwMEcu
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+CgpS
ZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoK
PiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMgfCAyICst
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYwo+IGluZGV4IGUyMjNiMGY2NDE3
Yi4uZDVmNTI2ZjM4ZTUwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9yaW5nLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmluZy5jCj4gQEAgLTQ4NCw3ICs0ODQsNyBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVfZGVidWdm
c19yaW5nX3JlYWQoc3RydWN0IGZpbGUgKmYsIGNoYXIgX191c2VyICpidWYsCj4gICAJcmVzdWx0
ID0gMDsKPiAgIAo+ICAgCWlmICgqcG9zIDwgMTIpIHsKPiAtCQllYXJseVswXSA9IGFtZGdwdV9y
aW5nX2dldF9ycHRyKHJpbmcpOwo+ICsJCWVhcmx5WzBdID0gYW1kZ3B1X3JpbmdfZ2V0X3JwdHIo
cmluZykgJiByaW5nLT5idWZfbWFzazsKPiAgIAkJZWFybHlbMV0gPSBhbWRncHVfcmluZ19nZXRf
d3B0cihyaW5nKSAmIHJpbmctPmJ1Zl9tYXNrOwo+ICAgCQllYXJseVsyXSA9IHJpbmctPndwdHIg
JiByaW5nLT5idWZfbWFzazsKPiAgIAkJZm9yIChpID0gKnBvcyAvIDQ7IGkgPCAzICYmIHNpemU7
IGkrKykgewoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
