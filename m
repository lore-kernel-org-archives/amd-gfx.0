From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Avoid fault when allocating an empty
 buffer object
Date: Mon, 17 Sep 2018 14:11:06 -0400
Message-ID: <7c6591c4-906f-d5f3-05a5-a1a0e514ffbc@amd.com>
References: <20180917180711.29594-1-tom.stdenis@amd.com>
 <9d13625d-f0da-cf16-2e0a-78db28dc7a1a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9d13625d-f0da-cf16-2e0a-78db28dc7a1a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wOS0xNyAyOjA4IHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTcu
MDkuMjAxOCB1bSAyMDowNyBzY2hyaWViIFRvbSBTdCBEZW5pczoKPj4gU2lnbmVkLW9mZi1ieTog
VG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgo+IAo+IFJldmlld2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gCj4gWW91IHdhcyBmYXN0
ZXIgdGhhbiBtZSA6KQoKQmVlbiBhIHdoaWxlIHNpbmNlIEkgZ290IGEgcGF0Y2ggb24gdGhlIGtl
cm5lbCBzaWRlLi4uIG5lZWQgdG8ga2VlcCB1cCAKbnVtYmVycyA6LSkKClRvbQoKPiAKPj4gLS0t
Cj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyB8IDMgKyst
Cj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3Qu
YyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPj4gaW5k
ZXggODRkODJkNTM4MmY5Li5jMTM4N2VmYzBjOTEgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPj4gQEAgLTM0OCw3ICszNDgsOCBAQCBpbnQgYW1k
Z3B1X2JvX2NyZWF0ZV9rZXJuZWwoc3RydWN0IGFtZGdwdV9kZXZpY2UgCj4+ICphZGV2LAo+PiDC
oMKgwqDCoMKgIGlmIChyKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHI7Cj4+IC3CoMKg
wqAgYW1kZ3B1X2JvX3VucmVzZXJ2ZSgqYm9fcHRyKTsKPj4gK8KgwqDCoCBpZiAoKmJvX3B0cikK
Pj4gK8KgwqDCoMKgwqDCoMKgIGFtZGdwdV9ib191bnJlc2VydmUoKmJvX3B0cik7Cj4+IMKgwqDC
oMKgwqAgcmV0dXJuIDA7Cj4+IMKgIH0KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
