From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v5 2/4] drm: Add vrr_enabled property to drm CRTC
Date: Mon, 15 Oct 2018 10:47:31 +0000
Message-ID: <690c8730-f74a-e79f-36eb-db99745a075b@amd.com>
References: <20181012164458.12864-1-nicholas.kazlauskas@amd.com>
 <20181012164458.12864-3-nicholas.kazlauskas@amd.com>
 <e1feafbe-2c37-d1ff-8a45-4672b4da1264@gmail.com>
 <9811fdab-3efe-4701-92e1-0f53b323959d@daenzer.net>
 <c9afd2f9-c80c-3147-6458-14e386196fb7@gmail.com>
 <ec5d531d-e91a-ba2f-7e8e-4a875b183e97@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ec5d531d-e91a-ba2f-7e8e-4a875b183e97-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
Content-ID: <4B49F21F19F80F439CCEED37DE9166B8-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>
Cc: "daniel.vetter-/w4YWyX8dFk@public.gmane.org" <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, "Olsak,
 Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMTUuMTAuMjAxOCB1bSAxMjowNiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOg0KPiBbU05JUF0N
Cj4gQXBhcnQgZnJvbSB0aGUgYWJvdmUsIGFub3RoZXIgaXNzdWUgaXMgdGhhdCB0aGlzIHdvdWxk
IGdpdmUgZGlyZWN0DQo+IGNvbnRyb2wgdG8gdGhlIGNsaWVudCBvbiB3aGV0aGVyIG9yIG5vdCBW
UlIgc2hvdWxkIGJlIHVzZWQuIEJ1dCB3ZSB3YW50DQo+IHRvIGFsbG93IHRoZSB1c2VyIHRvIGRp
c2FibGUgVlJSIGV2ZW4gaWYgYSBjbGllbnQgd2FudHMgdG8gdXNlIGl0LCB2aWENCj4gYW4gUmFu
ZFIgb3V0cHV0IHByb3BlcnR5LiBUaGlzIHJlcXVpcmVzIHRoYXQgdGhlIFhvcmcgZHJpdmVyIGNh
biBjb250cm9sDQo+IHdoZXRoZXIgb3Igbm90IFZSUiBjYW4gYWN0dWFsbHkgYmUgdXNlZCwgdmlh
IHRoZSBDUlRDIHByb3BlcnR5IGFkZGVkIGJ5DQo+IHRoaXMgcGF0Y2guDQpPaCwgdGhhdCBpcyBh
IHJlYWxseSBnb29kIGFyZ3VtZW50IQ0KDQpObyBvYmplY3Rpb24gZnJvbSBteSBzaWRlIHRvIHRo
aXMgdGhlbiwNCkNocmlzdGlhbi4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
