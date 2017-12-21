From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/prime: forward begin_cpu_access callback to
 drivers
Date: Thu, 21 Dec 2017 11:04:24 +0100
Message-ID: <20171221100424.GT26573@phenom.ffwll.local>
References: <1513355282-20248-1-git-send-email-Samuel.Li@amd.com>
 <BLUPR12MB06285AE51D36762F12755685F50C0@BLUPR12MB0628.namprd12.prod.outlook.com>
 <CAKMK7uHm6qp7K2jDc_nwLJH1BnSEWwgVUmGynbehuFEdTfYstg@mail.gmail.com>
 <4c0df435-913c-7569-591b-f15c212bc249@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4c0df435-913c-7569-591b-f15c212bc249-5C7GfCeVMHo@public.gmane.org>
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
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Li,
 Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>

T24gV2VkLCBEZWMgMjAsIDIwMTcgYXQgMDg6NTQ6MzNQTSArMDEwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBBbSAyMC4xMi4yMDE3IHVtIDIwOjQzIHNjaHJpZWIgRGFuaWVsIFZldHRlcjoK
PiA+IE9uIFdlZCwgRGVjIDIwLCAyMDE3IGF0IDY6MjAgUE0sIExpLCBTYW11ZWwgPFNhbXVlbC5M
aUBhbWQuY29tPiB3cm90ZToKPiA+ID4gUGluZy4uLiBjYW4gc29tZW9uZSBwbGVhc2UgcmV2aWV3
IHRoaXMgcGF0Y2g/Cj4gPiBNaWdodCBiZSBzaW1wbGVyIHRvIGltcGxlbWVudCB5b3VyIG93biBk
bWEtYnVmIGJhY2tlbmQgaW5zdGVhZCBvZgo+ID4gZ29pbmcgdGhyb3VnaCB0aGUgZHJtX3ByaW1l
IG1pZGxheWVyLiBUaGF0IHdhcyBtb3N0bHkgd3JpdHRlbiB0byBnaXZlCj4gPiBudmlkaWEgYSBz
ZXQgb2Ygbm9uLUVYUE9SVF9HUEwgc3ltYm9scyB0byBzdXBwb3J0IGRtYS1idWYuIE9yCj4gPiBz
b21ldGhpbmcgbGlrZSB0aGF0Lgo+IAo+IEFoLCB0aGF0IGV4cGxhaW5zIHRoYXQuIFdlbGwgdGhl
IGFsdGVybmF0aXZlIFNhbSBzdWdnZXN0IHdhcyB0byBleHBvcnQgbW9zdAo+IG9mIHRoZSBmdW5j
dGlvbnMgaW1wbGVtZW50aW5nIHRoYXQuCgpZZWFoIHRoYXQgc291bmRzIGxpa2UgYSBnb29kIGlk
ZWEsIG1ha2VzIGl0IGZlZWwgbGVzcyBtaWRsYXllci15LgoKPiBCdXQgdGhlbiB3ZSBoYXZlIGEg
aGFyZCB0aW1lIGhhdmluZyBhIGNvbW1vbiBkZXRlY3Rpb24gbG9naWMgaWYgYSBETUEtYnVmCj4g
aGFzIGEgR0VNIG9iamVjdCBiZWhpbmQgaXQgb3Igbm90LgoKSG0sIHdoeSBkbyB5b3UgbmVlZCB0
aGF0PyBJIGd1ZXNzIHlvdSdsbCBjYXJlIHdoZXRoZXIgaXQncyBhbgphbWRncHUtZXhwb3J0ZWQg
b25lLCBhbmQgeW91IGNhbiBzdGlsbCBkbyB0aGF0IGJ5IGNoZWNraW5nIGFnYWluc3QgeW91cgpv
d24gZG1hX2J1Zl9vcHMgdGFibGUuIFdlIGRvIHRoZSBzYW1lIGluIGk5MTUsIHdpdGhvdXQgdXNp
bmcgdGhlIGNvcmUKZHJtX3ByaW1lIGhlbHBlcnMuCgo+ID4gQWxzbyBkb24ndCBleHBlY3QgcGVv
cGxlIHRvIGxvb2sgYXQgcGF0Y2hlcyB3aGVuIENJIGJvdHMgc3BvdCBpc3N1ZXMuCj4gCj4gVGhh
dCBpcyBlaXRoZXIgYSBmYWxzZSBwb3NpdGl2ZSBvciBhIG9uZSBsaW5lci4KCkhleSBpdCdzIGhv
bGlkYXkgc2Vhc29ucywgbGVhdmUgbWUgc29tZSBjaGVhcCBleGN1c2VzIHBscyA6LSkKCkNoZWVy
cywgRGFuaWVsCi0tIApEYW5pZWwgVmV0dGVyClNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jw
b3JhdGlvbgpodHRwOi8vYmxvZy5mZndsbC5jaApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
