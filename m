From: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 01/35] drm/amd/display: Use udelay when waiting between
 aux retries
Date: Mon, 4 Feb 2019 15:43:36 +0000
Message-ID: <e7211c67-8ea3-e8f5-8f91-d7af94c1a603@amd.com>
References: <20190201152847.11151-1-Bhawanpreet.Lakha@amd.com>
 <20190201152847.11151-2-Bhawanpreet.Lakha@amd.com>
 <20190201173141.GA3838@freedom>
 <fda8f6ec-5a75-6456-3034-f3714b304b77@amd.com>
 <20190201200830.GA7069@freedom> <20190201204706.GA8286@freedom>
 <058665e8-0241-8fc1-8a2a-9f1d7484b29e@amd.com>
 <20190201225559.GA1064@freedom>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190201225559.GA1064@freedom>
Content-Language: en-US
Content-ID: <242DE76598AF5A43A8344BB9CCE77136-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "sylvain.bertrand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <sylvain.bertrand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Barberiz, John" <John.Barberiz-5C7GfCeVMHo@public.gmane.org>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS0wMi0wMSA1OjU1IHAubS4sIHN5bHZhaW4uYmVydHJhbmRAZ21haWwuY29tIHdyb3Rl
Og0KPiBPbiBGcmksIEZlYiAwMSwgMjAxOSBhdCAwOToyMDo1NlBNICswMDAwLCBXZW50bGFuZCwg
SGFycnkgd3JvdGU6DQo+PiBEUk0ncyBBVVggY29kZSB1c2VzIHVzbGVlcF9yYW5nZSBpbiBkcm1f
ZHBfZHBjZF9hY2Nlc3MuDQo+IA0KPiBNeSBiYWQsIGZvcmdvdCBhYm91dCB0aGUgdXNsZWVwX3Jh
bmdlIHN3aXRjaC4gVGhhdCBzYWlkIEFVWF9SRVRSWV9JTlRFUlZBTCBpcw0KPiA1MDAgdXMsIHdp
dGggYSB1c2xlZXBfcmFuZ2UgdG9wIGJvdW5kIG9mIDYwMCB1cy4NCj4gDQo+IFRoZW4sIGl0IHdv
dWxkIG1lYW4gREMgRFAgdGltZW91dCByZXRyaWVzIHdvdWxkIGhhcHBlbiBhZnRlciB+MW1zLCBh
bmQgZHJtDQo+IH42MDB1cy4gQWRkaXRpb25hbHksIGl0IHNlZW1zIHRoYXQgdGhlIG51bWJlciBv
ZiByZXRyaWVzIGFyZSAzIGluIGRybSBjb2RlIGFuZA0KPiA3IGluIERDIGNvZGUuIA0KPiANCg0K
RFJNIGFjdHVhbGx5IGJ1bXBlZCB0aGlzIHRvIDMyIGR1ZSB0byBhbiBpc3N1ZSB3aXRoIGEgRGVs
bCA0ayBkaXNwbGF5Lg0KDQo+IEkgbWF5IGJlIHdyb25nLCBidXQgaXQgc2VlbXMgREMgY29kZSBp
cyBtdWNoIG1vcmUgImluc2lzdGluZyIgb24gYXV4Y2hhbm5lbA0KPiAoZWRpZCByZXRyaWV2YWwp
IGFuZCBtdWNoIG1vcmUgZm9yZ2l2aW5nIG9uIG1vbml0b3IgYWJpbGl0eSB0byB0aW1lb3V0IGlu
DQo+IHRpbWUgKH4xbXMpLg0KPiANCj4gSWYgSSBkaWQgcmVhZCB0aGUgY29kZSB0aGUgcmlnaHQg
d2F5LCBpdCBtYXkgYmUgbW9yZSByZWFzb25hYmxlIHRvIGhhdmUgc2ltaWxhcg0KPiBiZWhhdmlv
ciBpbiBkcm0gY29kZSB0aGFuIGluIERDIGNvZGUsIHJpZ2h0Pw0KPiANCg0KSXQgZGVwZW5kcy4g
SSB3b3VsZG4ndCBjYWxsIG9uZSBvciB0aGUgb3RoZXIgbW9yZSBjb3JyZWN0LiBJIHNlZW0gdG8g
cmVtZW1iZXIgdGhhdCB0aGUgRFAgc3BlYyBpcyBxdWl0ZSB2YWd1ZSBvbiB0aGVzZSByZXRyaWVz
IGJ1dCBJIGNvdWxkIGJlIG1pc3Rha2VuLiBTaW5jZSBvdXIgZHJpdmVyIGhhc24ndCBzaG93IGFu
eSBwcm9ibGVtcyB3aXRoIHRoZSBEUk0gY29kZSBhbmQgSSBiZWxpZXZlIG90aGVycyAoc3VjaCBh
cyBpOTE1KSBhbHNvIHBhc3MgRFAgY29tcGxpYW5jZSB3aXRob3V0IGlzc3VlcyBJIHdvdWxkbid0
IHByb2FjdGl2ZWx5IGNoYW5nZSB0aGlzLg0KDQpIYXJyeQ0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
