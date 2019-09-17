From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm: add drm device name
Date: Tue, 17 Sep 2019 08:23:17 +0000
Message-ID: <7540df63-e623-19b0-dde5-b89ff2b7fb89@amd.com>
References: <20190903214040.2386-1-sonny.jiang@amd.com>
 <CAAxE2A45N4gMYrcETDpznGKyxLztuwenFasL19a81QQmBkYiww@mail.gmail.com>
 <CAF6AEGvvUUOGujJC9P3t72N93AJuxiiVt0OAk8zf226Q8WmHvg@mail.gmail.com>
 <CAKMK7uHFNhdNY4Y9ZFMNuci7gssPWCT5f5y=e4npg8s5r_jBdQ@mail.gmail.com>
 <CAAxE2A6sESsKAi3K1etAZeCwAPgexn099G6g0aJQnavTkiH+mA@mail.gmail.com>
 <87woe7eanv.fsf@intel.com> <03d31464-3968-6923-5323-f63060d70f1f@gmail.com>
 <CAKMK7uEj4FZ3YQqG-cCTa4EEaJoAk09Zaz398F9Hmo+mdXCKiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAKMK7uEj4FZ3YQqG-cCTa4EEaJoAk09Zaz398F9Hmo+mdXCKiw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <628384EB7C10204CA594E3A629A3D2B3-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: "Jiang, Sonny" <Sonny.Jiang-5C7GfCeVMHo@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?utf-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

QW0gMTcuMDkuMTkgdW0gMTA6MTcgc2NocmllYiBEYW5pZWwgVmV0dGVyOg0KPiBPbiBUdWUsIFNl
cCAxNywgMjAxOSBhdCAxMDoxMiBBTSBDaHJpc3RpYW4gS8O2bmlnDQo+IDxja29lbmlnLmxlaWNo
dHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6DQo+PiBBbSAxNy4wOS4xOSB1bSAwNzo0NyBzY2hy
aWViIEphbmkgTmlrdWxhOg0KPj4+IE9uIE1vbiwgMTYgU2VwIDIwMTksIE1hcmVrIE9sxaHDoWsg
PG1hcmFlb0BnbWFpbC5jb20+IHdyb3RlOg0KPj4+PiBUaGUgcHVycG9zZSBpcyB0byBnZXQgcmlk
IG9mIGFsbCBQQ0kgSUQgdGFibGVzIGZvciBhbGwgZHJpdmVycyBpbg0KPj4+PiB1c2Vyc3BhY2Uu
IChvciBhdCBsZWFzdCBzdG9wIHVwZGF0aW5nIHRoZW0pDQo+Pj4+DQo+Pj4+IE1lc2EgY29tbW9u
IGNvZGUgYW5kIG1vZGVzZXR0aW5nIHdpbGwgdXNlIHRoaXMuDQo+Pj4gSSdkIHRoaW5rIHRoaXMg
d291bGQgd2FycmFudCBhIGhpZ2ggbGV2ZWwgZGVzY3JpcHRpb24gb2Ygd2hhdCB5b3Ugd2FudA0K
Pj4+IHRvIGFjaGlldmUgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0KPj4gQW5kIG1heWJlIGV4cGxp
Y2l0bHkgY2FsbCBpdCB1YXBpX25hbWUgb3IgZXZlbiB1YXBpX2RyaXZlcl9uYW1lLg0KPiBJZiBp
dCdzIHVhcGlfbmFtZSwgdGhlbiB3aHkgZG8gd2UgbmVlZCBhIG5ldyBvbmUgZm9yIGV2ZXJ5IGdl
bmVyYXRpb24/DQo+IFVzZXJzcGFjZSBkcml2ZXJzIHRlbmQgdG8gc3BhbiBhIGxvdCBtb3JlIHRo
YW4ganVzdCAxIGdlbmVyYXRpb24uIEFuZA0KPiBpZiB5b3Ugd2FudCB0byBoYXZlIHBlci1nZW5l
cmF0aW9uIGRhdGEgZnJvbSB0aGUga2VybmVsIHRvIHVzZXJzcGFjZSwNCj4gdGhlbiBpbW8gdGhh
dCdzIG11Y2ggYmV0dGVyIHN1aXRlZCBpbiBzb21lIGFtZGdwdSBpb2N0bCwgaW5zdGVhZCBvZg0K
PiB0cnlpbmcgdG8gZW5jb2RlIHRoYXQgaW50byB0aGUgZHJpdmVyIG5hbWUuDQoNCldlbGwgd2Ug
YWxyZWFkeSBoYXZlIGFuIElPQ1RMIGZvciB0aGF0LCBidXQgSSB0aG91Z2h0IHRoZSBpbnRlbnRp
b24gaGVyZSANCndhcyB0byBnZXQgcmlkIG9mIHRoZSBQQ0ktSUQgdGFibGVzIGluIHVzZXJzcGFj
ZSB0byBmaWd1cmUgb3V0IHdoaWNoIA0KZHJpdmVyIHRvIGxvYWQuDQoNCkkgbWVhbiBpdCBjb3Vs
ZCBiZSBwZXJmZWN0bHkgdmFsaWQgdG8gbm90IG9ubHkgbWF0Y2ggdGhlIGtlcm5lbCwgYnV0IA0K
YWxzbyB0aGUgaGFyZHdhcmUgZ2VuZXJhdGlvbiBmb3IgdGhhdC4NCg0KQ2hyaXN0aWFuLg0KDQo+
IC1EYW5pZWwNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
