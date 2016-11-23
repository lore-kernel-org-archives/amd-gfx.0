From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gfx7: move eop programming per queue
Date: Wed, 23 Nov 2016 18:56:41 -0500
Message-ID: <CADnq5_NBUdZwBbPAzQJp7wPWCFwdhH=pvfLoZ9=VMR-tzAFxQg@mail.gmail.com>
References: <1479932826-3362-1-git-send-email-alexander.deucher@amd.com>
 <1479932826-3362-2-git-send-email-alexander.deucher@amd.com>
 <1479942059.4125077.797525393.1034ADD9@webmail.messagingengine.com>
 <CADnq5_OVmdTJQpGqOdxvDVhSvGeX5eAgOmJdtA-K2jEDMWaYJg@mail.gmail.com>
 <CADnq5_Pxi=xkyVS0jUDMw9Ax5vmfJcS59N-SrfvY_JnnUUpcmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_Pxi=xkyVS0jUDMw9Ax5vmfJcS59N-SrfvY_JnnUUpcmg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Jay Cornwall <jay-gJmSnxjMpeIFV7jr3Ov9Ew@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gV2VkLCBOb3YgMjMsIDIwMTYgYXQgNjo1MCBQTSwgQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hl
ckBnbWFpbC5jb20+IHdyb3RlOgo+IE9uIFdlZCwgTm92IDIzLCAyMDE2IGF0IDY6NDkgUE0sIEFs
ZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiB3cm90ZToKPj4gT24gV2VkLCBOb3Yg
MjMsIDIwMTYgYXQgNjowMCBQTSwgSmF5IENvcm53YWxsIDxqYXlAamNvcm53YWxsLm1lPiB3cm90
ZToKPj4+IE9uIFdlZCwgTm92IDIzLCAyMDE2LCBhdCAxNDoyNywgQWxleCBEZXVjaGVyIHdyb3Rl
Ogo+Pj4+IEl0J3MgcGVyIHF1ZXVlIG5vdCBwZXIgcGlwZS4KPj4+Cj4+PiBBcmUgeW91IHN1cmU/
IEkgd2FzIHVuZGVyIHRoZSBpbXByZXNzaW9uIHRoYXQgRU9QIHF1ZWV1cyB3ZXJlIHBlci1waXBl
Cj4+PiBvbiBHZng3IGFuZCBwZXItcXVldWUgb24gR2Z4OCBvbndhcmRzICh0byBzdXBwb3J0IGNv
bnRleHQgc2F2ZS9yZXN0b3JlKS4KPj4+IEl0J3MgYWxzbyBoaW50ZWQgYXQgYnkgdGhlIHJlZ2lz
dGVyIG5hbWUgKEhQRCA9PSBIYXJkd2FyZSBQaXBlCj4+PiBEZXNjcmlwdG9yLCBIUUQgPT0gSGFy
ZHdhcmUgUXVldWUgRGVzY3JpcHRvcikuCj4+Cj4+IE5vLCBJJ20gbm90IHN1cmUuICBJIGhhdmUg
YSBwYXRjaCBzZXQgZm9yIGFtZGdwdSB0byBsZWF2ZSB0aGUKPj4gZmJfbG9jYXRpb24gYXMgcHJv
Z3JhbW1lZCBieSB0aGUgdmJpb3MgcmF0aGVyIHRoYW4gcmVwcm9ncmFtbWluZyB3aGljaAo+PiBy
ZXN1bHRlZCBpbiB2cmFtIG5vdCBiZWluZyBhdCAwIGluIHRoZSBHUFUncyBhZGRyZXNzIHNwYWNl
LiAgSSB0aGVuCj4+IGdvdCByaW5nIGZhaWx1cmVzIG9uIHRoZSBjb21wdXRlIHF1ZXVlcyB1bnRp
bCBJIG1hZGUgdGhlIGVvcHMgcGVyCj4+IHF1ZXVlLiAgSXQgY291bGQgYmUgc29tZXRoaW5nIGVs
c2UsIGJ1dCB0aGlzIHNlZW1lZCB0byBmaXggaXQuCj4KPiBBY3R1YWxseSBJJ3ZlIG9ubHkgdHJp
ZWQgdGhpcyBvbiBnZng4LCBJIGp1c3QgYXNzdW1lZCBnZng3IHdhcyBhbHNvCj4gYWZmZWN0ZWQs
IGJ1dCBpdCdzIHBvc3NpYmxlIHRoaXMgaXMgbm90IG5lZWRlZCBmb3IgZ2Z4IDcuCgpjb25zaWRl
ciB0aGlzIHBhdGNoIHdpdGhkcmF3bi4KCkFsZXgKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
