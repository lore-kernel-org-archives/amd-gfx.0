From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/9] drm/amdkfd: Simplify execute and unmap queue APIs
Date: Tue, 10 Oct 2017 17:21:13 -0400
Message-ID: <6fe9d800-41d8-2256-47cb-094e7a5d78d0@amd.com>
References: <1506485396-6326-1-git-send-email-Felix.Kuehling@amd.com>
 <1506485396-6326-3-git-send-email-Felix.Kuehling@amd.com>
 <CAFCwf11tnqjDPVUyCTyzHMqmhTCQ3DXnQLOeDQ3H+CZ2iDzs1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFCwf11tnqjDPVUyCTyzHMqmhTCQ3DXnQLOeDQ3H+CZ2iDzs1g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-CA
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

Ck9uIDIwMTctMTAtMDggMDg6MDIgQU0sIE9kZWQgR2FiYmF5IHdyb3RlOgo+IFRoaXMgcGF0Y2gg
aXMgYmFzaWNhbGx5IGZpbmUsIGJ1dCBpdCBhY3R1YWxseSBjb250YWlucyB0d28gc2VwYXJhdGUK
PiBjaGFuZ2VzIHRoYXQgYXJlIG5vdCByZWxhdGVkIHRvIGVhY2ggb3RoZXIuIEl0IG1ha2VzIHRo
ZSBwYXRjaCBoYXJkIHRvCj4gdW5kZXJzdGFuZCBhbmQgZm9sbG93IGFuZCBtYWtlcyBmdXR1cmUg
YmlzZWN0aW5nIGhhcmRlci4KPiBUaGVyZWZvcmUsIEkgdG9vayB0aGUgcGF0Y2ggYnV0IHNwbGl0
IGl0IHRvIHR3byBwYXRjaGVzLiBQbGVhc2UgdGVsbAo+IG1lIGlmIHlvdSBoYXZlIGFueSBvYmpl
Y3Rpb24uCgpObyBwcm9ibGVtLCB0aGFua3MuIEkgdGhpbmsgaXQgd2FzIGxhemluZXNzIG9uIG15
IHBhcnQuIFNpbmNlIHRoZQpwYXRjaGVzIGFmZmVjdGVkIHRoZSBzYW1lIHVubWFwIGludGVyZmFj
ZSwgaXQgd2FzIGVhc2llciB0byBzcXVhc2ggdGhlbQphbmQgcmVzb2x2ZSB0aGUgY29uZmxpY3Rz
IG9ubHkgb25jZS4KClJlZ2FyZHMsCsKgIEZlbGl4Cgo+Cj4gT2RlZAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
