From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdkfd: Implement image tiling mode support
Date: Thu, 17 Aug 2017 11:18:41 +0200
Message-ID: <dacce9ad-8784-327c-6814-fc1023e8ae84@vodafone.de>
References: <1502513265-14281-1-git-send-email-Felix.Kuehling@amd.com>
 <1502513265-14281-5-git-send-email-Felix.Kuehling@amd.com>
 <CAFCwf10iQhAvxZdwCYBK6f0fBKdpgD=f0W886awm2fJVCB=hLQ@mail.gmail.com>
 <fc37f1a8-9c12-f1da-cdab-f03b50643f19@amd.com>
 <2649fca7-9617-e434-a75a-f76d7e07d0f5@amd.com>
 <CAFCwf13bFDhL=_X-zx8AJE+0sD0Aw9z5Rku_7qDgY6VEdtS+qA@mail.gmail.com>
 <fd9a9222-f7fa-8f72-6a23-619a17a872e3@amd.com>
 <8ff456e3-94a8-7547-d01d-6aca5aaface8@daenzer.net>
 <CAFCwf11Rjt3smEjF6KAeUWCu=GCsSXAWbd1j4qA2tu+WL0C13g@mail.gmail.com>
 <f4c6d3c4-3dd9-3add-5ebc-01659a655e66@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f4c6d3c4-3dd9-3add-5ebc-01659a655e66-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTYuMDguMjAxNyB1bSAyMzo1MyBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+IE9uIDIwMTct
MDgtMTYgMDU6MjQgQU0sIE9kZWQgR2FiYmF5IHdyb3RlOgo+Pj4gVGhlIGRlYWRsaW5lIGlzIHVz
dWFsbHkgYXJvdW5kIC1yYzYgb2YgdGhlIHByZXZpb3VzIGN5Y2xlLCBzbyBmb3IgNC4xNAo+Pj4g
aXQgbWlnaHQgYmUgdGhlIGVuZCBvZiB0aGlzIHdlZWsgKGtlZXAgaW4gbWluZCB0aGF0IERhdmUn
cyBpbiBBdXN0cmFsaWEsCj4+PiBzbyBoaXMgd29yayBkYXkgaXMgb3ZlciB3aGVuIHlvdXJzIHN0
YXJ0cykuCj4+Pgo+PiBZZWFoLCBNaWNoZWwgaXMgY29ycmVjdC4gSWYgaXRzIDEgb3IgMiB0cml2
aWFsIHBhdGNoZXMgSSBjYW4gcHJvYmFibHkKPj4gZ2V0IGl0IGluIGV2ZW4gZHVyaW5nIC1yYzcg
b3Igc3RhcnQgb2YgbWVyZ2Ugd2luZG93LCBidXQgZm9yIHRoaXMKPj4gbGFyZ2UgcGF0Y2gtc2V0
IC1yYzUvNiBpcyB0aGUgc2FmZXIgd2F5IHRvIGdvLgo+IE9LLiBUaGVuIHRoaXMgaXMgaXQgZm9y
IDQuMTQuIEknbGwgdGFyZ2V0IHRoZSBuZXh0IHNldCBmb3IgNC4xNS4KPgo+IFRoZSBuZXh0IHNl
dCB3aWxsIGJlIGEgYnVuY2ggb2YgYnVnIGZpeGVzIGFuZCBzbWFsbGVyIGZlYXR1cmVzIHRoYXQK
PiBhcHBseSB0byBLViBhbmQgQ1ouIEkgd2FudCB0byBnZXQgYWxsIHRoZSBzbWFsbCBzdHVmZiBv
dXQgb2YgdGhlIHdheSBzbwo+IGl0IGNhbiBiZSByZXZpZXdlZCBwcm9wZXJseSB3aXRob3V0IGdl
dHRpbmcgY29uZm91bmRlZCB3aXRoIHRoZSBiaWcKPiBjaGFuZ2VzIGZvciBkR1BVIHN1cHBvcnQu
Cj4KPiBBZnRlciB0aGF0IEknbGwgZ2V0IHRvIHRoZSBiaWcgcGllY2VzIG9mIGRHUFUgc3VwcG9y
dCBmb3IgR0ZYNyBhbmQgR0ZYOC4KPgo+IEZpbmFsbHkgSSdsbCBhZGQgR0ZYOSAoVmVnYTEwKSBz
dXBwb3J0LgoKU291bmRzIGxpa2UgYSBwbGFuIHRvIG1lLgoKQnV0IGFzIGxvbmcgYXMgdGhleSBh
cmUganVzdCBidWcgZml4ZXMgYW5kIG1heWJlIG1pbm9yIGNsZWFudXBzIGZlZWwgCmZyZWUgdG8g
c2VuZCBpbiBldmVuIG1vcmUgZm9yIDQuMTQuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gUmVn
YXJkcywKPiAgICBGZWxpeAo+Cj4+IE9kZWQKPj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
