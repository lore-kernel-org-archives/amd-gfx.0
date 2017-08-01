From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Add tracepoint for DMA page mapping
Date: Tue, 1 Aug 2017 20:25:28 +0200
Message-ID: <f90e3662-52db-d702-75c7-622fe7a2a7e8@vodafone.de>
References: <20170801115131.27610-1-tom.stdenis@amd.com>
 <b4945fed-aea3-1b15-b383-26bc65307139@vodafone.de>
 <21a75bbf-e9ca-e9e9-5831-e58908911e9b@amd.com>
 <56a6ecd5-d210-cd71-0fc0-2d0ffd36ab00@vodafone.de>
 <29f09f3b-154d-70d2-f5c6-315022b408ea@amd.com>
 <67a7f3ec-fd54-e997-75a0-4d6e3d2ff908@vodafone.de>
 <ae6e3523-dd8e-a14e-9bb2-297b0114bd5e@amd.com>
 <b38d7cac-533d-7029-f73f-445a92d6b952@vodafone.de>
 <8ba09a77-9bc6-35a1-8169-246a144430e8@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8ba09a77-9bc6-35a1-8169-246a144430e8-5C7GfCeVMHo@public.gmane.org>
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

QW0gMDEuMDguMjAxNyB1bSAxOTowMCBzY2hyaWViIFRvbSBTdCBEZW5pczoKPiBPbiAwMS8wOC8x
NyAxMTo0MSBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gV2UgY2FuIHR1cm4gb2YgdGhl
IHRyYWNlIHN1YnN5c3RlbSBkdXJpbmcgY29tcGlsZSB0aW1lIGFscmVhZHkuCj4+Cj4+IEFkZGl0
aW9uYWwgdG8gdGhhdCB0aGUgdHJhY2UgcG9pbnRzIHVzZSBzZWxmIG1vZGlmeWluZyBjb2RlIHRv
IG1ha2UgCj4+IHN1cmUgdGhhdCB0aGV5IGRvbid0IGhhdmUgYW55IG92ZXJoZWFkIGFzIGxvbmcg
YXMgdGhleSBhcmUgdHVybmVkIAo+PiBvZmYuIEJ1dCBJIGRvbid0IHRoaW5rIHRoaXMgd29ya3Mg
d2l0aCB0aGUgImlmICh0cmFjZV8qX2VuYWJsZWQoKSIgYXMgCj4+IHdlbGwuCj4+Cj4+IEFueXdh
eSwgbm90IGEgcGVyZm9ybWFuY2UgY3JpdGljYWwgY29kZSBwYXRoIHNvIEkgZG9uJ3QgcmVhbGx5
IGJvdGhlci4KPgo+IFdlbGwgYXNpZGUgZnJvbSB0aGF0IHRoaXMgd2lsbCBvbmx5IHJlYWxseSBi
ZSB1c2VmdWwgaW4gdXBzdHJlYW0gCj4ga2VybmVscyB3aGVyZSB3ZSBkb24ndCBjb250cm9sIHRo
ZSBjb25maWd1cmF0aW9uLgo+Cj4gRXZlbnR1YWxseSBpZiB3ZSBjb21lIHVwIHdpdGggYSBiZXR0
ZXIgc29sdXRpb24gKHRtKSB0aGVuIHdlIGNhbiAKPiByZXZlcnQgdGhpcyBjbGVhbmx5LgoKQWN0
dWFsbHkgZXZlbiBpZiB3ZSBjb21lIHVwIHdpdGggc29tZSBvdGhlciBhcHByb2FjaCB0byBhY2Nl
c3MgdGhlIEdQVSAKVk0gb2YgYSBwcm9jZXNzIEkgd291bGQgcmF0aGVyIGxpa2UgdG8ga2VlcCB0
aGF0IHRyYWNlIHBvaW50IGJlY2F1c2UgaXQgCmlzIHJhdGhlciB1c2VmdWwgZm9yIHNvbWUgdXNl
cnB0ciBkZWJ1Z2dpbmcgYXMgd2VsbC4KCkNocmlzdGlhbi4KCj4KPiBUb20KPiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBs
aXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
