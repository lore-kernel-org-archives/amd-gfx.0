From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add the checking to avoid NULL pointer
 dereference
Date: Thu, 22 Nov 2018 12:25:04 +0100
Message-ID: <b8284caa-3f1d-5672-6317-36be83907e9d@gmail.com>
References: <20181122065523.5510-1-Deepak.Sharma@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181122065523.5510-1-Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>
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
To: "Sharma, Deepak" <Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

QW0gMjIuMTEuMTggdW0gMDc6NTYgc2NocmllYiBTaGFybWEsIERlZXBhazoKPiB3aGVuIHJldHVy
bmVkIGZlbmNlIGlzIG5vdCB2YWxpZCBtb3N0bHkgZHVlIHRvIHVzZXJzcGFjZSBpZ25vcmVkCj4g
cHJldmlvdXMgZXJyb3IgY2F1c2VzIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZS4KCkFnYWluLCB0
aGlzIGlzIGNsZWFybHkgaW5jb3JyZWN0LiBUaGUgbXkgb3RoZXIgbWFpbHMgb24gdGhlIGVhcmxp
ZXIgcGF0Y2guCgpJZiB5b3UgaGF2ZSBhbHJlYWR5IHB1c2hlZCB0aGUgcGF0Y2ggdGhlbiBwbGVh
c2UgcmV2ZXJ0LgoKQ2hyaXN0aWFuLgoKPgo+IFNpZ25lZC1vZmYtYnk6IERlZXBhayBTaGFybWEg
PERlZXBhay5TaGFybWFAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9jcy5jIHwgMiArKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPiBpbmRleCAwMjRkZmJk
ODdmMTEuLjE0MTY2Y2Q4YTEyZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfY3MuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9jcy5jCj4gQEAgLTE0MDMsNiArMTQwMyw4IEBAIHN0YXRpYyBzdHJ1Y3QgZG1hX2ZlbmNlICph
bWRncHVfY3NfZ2V0X2ZlbmNlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCj4gICAJ
ZmVuY2UgPSBhbWRncHVfY3R4X2dldF9mZW5jZShjdHgsIGVudGl0eSwgdXNlci0+c2VxX25vKTsK
PiAgIAlhbWRncHVfY3R4X3B1dChjdHgpOwo+ICsJaWYoIWZlbmNlKQo+ICsJCXJldHVybiBFUlJf
UFRSKC1FSU5WQUwpOwo+ICAgCj4gICAJcmV0dXJuIGZlbmNlOwo+ICAgfQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
