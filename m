From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [amdgpu] ASSERT()'s in write_i2c*retimer_setting() functions
Date: Fri, 11 Oct 2019 08:13:21 +0000
Message-ID: <223e04b0-b855-96e9-f984-70a1d47235cc@amd.com>
References: <CAEJqkgi-9_1D91GUm_MbS-=RRRwMZjqEYWhCCdk+STvc0PeYXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAEJqkgi-9_1D91GUm_MbS-=RRRwMZjqEYWhCCdk+STvc0PeYXw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <1F26EA3A7C736248A189AA55319622C6-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Gabriel C <nix.or.die-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Zeyu Fan <Zeyu.Fan-5C7GfCeVMHo@public.gmane.org>

Rm9yd2FyZGluZyB0byB0aGUgYXBwcm9wcmlhdGUgZGlzcGxheSBmb2xrcy4NCg0KQ2FuIHlvdSBn
dXlzIHRha2UgYSBsb29rPw0KDQpDaHJpc3RpYW4uDQoNCkFtIDExLjEwLjE5IHVtIDAxOjM0IHNj
aHJpZWIgR2FicmllbCBDOg0KPiBIZWxsbywNCj4NCj4gSSd2ZSBidWlsdCByZWNlbnRseSBhIG5l
dyBib3ggd2l0aCBhIFJ5emVuMyAyMjAwRyBBUFUuDQo+DQo+IEVhY2ggdGltZSBJIHBsdWcgaW4g
YW4gSERNSSBjYWJsZSAoIHRvIGEgVFYgb3IgTW9uaXRvciApLA0KPiBvciBib290IHdpdGggSERN
SSBjb25uZWN0ZWQgYSBsb3QgQVNTRVJUKCkncyBmcm9tDQo+IHdyaXRlX2kyYypyZXRpbWVyX3Nl
dHRpbmcoKSBmdW5jdGlvbnMgYXJlIHRyaWdnZXJlZC4NCj4NCj4gSSBzZWUgdGhlIHNhbWUgb24g
YSBMYXB0b3Agd2l0aCBhIFJ5emVuNyAzNzUwSCB3aXRoDQo+IGh5YnJpZCBHUFUgY29uZmlndXJh
dGlvbi4NCj4NCj4gQmVzaWRlcyB0aGUgbm9pc2UgaW4gZG1lc2cgYW5kIHRoZSBkZWxheSBvbiBi
b290LA0KPiBldmVyeXRoaW5nIGlzIHdvcmtpbmcgZmluZS4gSSBjYW5ub3QgZmluZCBhbnl0aGlu
ZyB3cm9uZw0KPiBvciBicm9rZW4uDQo+DQo+IFNpbmNlIHRoZSB3cml0ZSBlcnJvcnMgc2VlbSB0
byBub3QgYmUgZmF0YWwsIEkgdGhpbmsgYSBmcmllbmRseSBtZXNzYWdlDQo+IHdvdWxkIGhlbHAg
bW9yZSBpbnN0ZWFkIG9mIGZsb29kaW5nIHRoZSBkbWVzZyB3aXRoIGR1bXBzIHdoaWxlDQo+IGV2
ZXJ5dGhpbmcgaXMgd29ya2luZyBwcm9wZXJseS4NCj4NCj4gV2h5IGlzIEFTU0VSVCgpIHVzZWQg
dGhlcmU/DQo+DQo+IEkgaGF2ZSBhIGRtZXNnIGZyb20gdGhlIFJ5emVuMyBib3ggd2l0aCBkcm0u
ZGVidWcgYW5kIGEgc25pcHBlZA0KPiBmcm9tIHRoZSBMYXB0b3AgKCBub3QgbmVhciBtZSByaWdo
dCBub3cgKSB1cGxvYWRlZCB0aGVyZToNCj4NCj4gaHR0cHM6Ly9jcmF6eS5kZXYuZnJ1Z2Fsd2Fy
ZS5vcmcvYW1kZ3B1Lw0KPg0KPiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IG5lZWQgbW9yZSBp
bmZvcm1hdGlvbiwNCj4gSWYgbmVlZGVkIEkgY2FuIHVwbG9hZCBhIGRtZXNnIGZyb20gdGhlIExh
cHRvcCB3aXRoIGRybS5kZWJ1ZyB0b28uDQo+DQo+DQo+IEJlc3QgUmVnYXJkcywNCj4NCj4gR2Fi
cmllbCBDDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
