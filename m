From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: amdgpu display corruption and hang on AMD A10-9620P
Date: Tue, 9 May 2017 17:03:12 +0000
Message-ID: <BN6PR12MB16521B41AEABD4933E63FFD0F7EF0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <CAD8Lp46UgXx4Du_cpFvvJc+xkuX2_dTC+q=RyZggUc1Ui8oQWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAD8Lp46UgXx4Du_cpFvvJc+xkuX2_dTC+q=RyZggUc1Ui8oQWg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: 'Daniel Drake' <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, Chris Chiu <chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWwgRHJha2UgW21haWx0
bzpkcmFrZUBlbmRsZXNzbS5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAwOSwgMjAxNyAxMjo1
NSBQTQ0KPiBUbzogZHJpLWRldmVsOyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1
Y2hlciwgQWxleGFuZGVyDQo+IENjOiBDaHJpcyBDaGl1OyBMaW51eCBVcHN0cmVhbWluZyBUZWFt
DQo+IFN1YmplY3Q6IGFtZGdwdSBkaXNwbGF5IGNvcnJ1cHRpb24gYW5kIGhhbmcgb24gQU1EIEEx
MC05NjIwUA0KPiANCj4gSGksDQo+IA0KPiBXZSBhcmUgd29ya2luZyB3aXRoIG5ldyBsYXB0b3Bz
IHRoYXQgaGF2ZSB0aGUgQU1EIEJyaXN0b2wgUmlkZ2UNCj4gY2hpcHNldCB3aXRoIHRoaXMgU29D
Og0KPiANCj4gQU1EIEExMC05NjIwUCBSQURFT04gUjUsIDEwIENPTVBVVEUgQ09SRVMgNEMrNkcN
Cj4gDQo+IEkgdGhpbmsgdGhpcyBpcyB0aGUgQnJpc3RvbCBSaWRnZSBjaGlwc2V0Lg0KPiANCj4g
RHVyaW5nIGJvb3QsIHRoZSBkaXNwbGF5IGJlY29tZXMgdW51c2FibGUgYXQgdGhlIHBvaW50IHdo
ZXJlIHRoZQ0KPiBhbWRncHUgZHJpdmVyIGxvYWRzLiBZb3UgY2FuIHNlZSBhdCBsZWFzdCB0d28g
aG9yaXpvbnRhbCBsaW5lcyBvZg0KPiBnYXJiYWdlIGF0IHRoaXMgcG9pbnQuIFdlIGhhdmUgcmVw
cm9kdWNlZCBvbiA0LjgsIDQuMTAgYW5kIGxpbnVzDQo+IG1hc3RlciAoZWFybHkgNC4xMikuDQo+
IA0KPiBQaG90bzogaHR0cDovL3Bhc3RlYm9hcmQuY28vcXJDOW1oNHAuanBnDQo+IA0KPiBHZXR0
aW5nIGxvZ3MgaXMgdHJpY2t5IGJlY2F1c2UgdGhlIHN5c3RlbSBhcHBlYXJzIHRvIGZyZWV6ZSBh
dCB0aGF0IHBvaW50Lg0KPiANCj4gSXMgdGhpcyBhIGtub3duIGlzc3VlPyBBbnl0aGluZyB3ZSBj
YW4gZG8gdG8gaGVscCBkaWFnbm9zaXM/DQoNCkknbSBub3QgYXdhcmUgb2YgYW55IHNwZWNpZmlj
IGlzc3Vlcy4gIFBsZWFzZSBmaWxlIGEgYnVnIGFuZCBhdHRhY2ggeW91ciBsb2dzIChodHRwczov
L2J1Z3MuZnJlZWRlc2t0b3Aub3JnKSBhbG9uZyB3aXRoIGluZm9ybWF0aW9uIGFib3V0IHRoZSBz
eXN0ZW0uDQoNCkFsZXgNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
