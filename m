From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: replace readq/writeq with atomic64 operations
Date: Wed, 7 Aug 2019 13:03:00 +0000
Message-ID: <c613ca25-4443-f275-ea8d-6d55af10ac77@amd.com>
References: <20190807025640.682-1-tao.zhou1@amd.com>
 <20190807070834.GA24792@infradead.org>
 <daff9fc7-ead8-40e0-9a16-cb3b90b01722@amd.com>
 <20190807104104.GA18773@infradead.org>
 <18cd9fa5-2d87-2f41-b5fa-927b9790287d@amd.com>
 <20190807130043.GA6023@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190807130043.GA6023-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Content-Language: en-US
Content-ID: <94B9D56BFBAC0F478C55FC9E5310D657-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "kernel-build-reports-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <kernel-build-reports-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "Li,
 Dennis" <Dennis.Li-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

QW0gMDcuMDguMTkgdW0gMTU6MDAgc2NocmllYiBDaHJpc3RvcGggSGVsbHdpZzoNCj4gT24gV2Vk
LCBBdWcgMDcsIDIwMTkgYXQgMTA6NTU6MDFBTSArMDAwMCwgS29lbmlnLCBDaHJpc3RpYW4gd3Jv
dGU6DQo+Pj4+IEVzc2VudGlhbGx5IHdyaXRlcS9yZWFkcSBkb2Vzbid0IHNlZW1zIHRvIGJlIGF2
YWlsYWJsZSBvbiBhbGwNCj4+Pj4gYXJjaGl0ZWN0dXJlcyBlaXRoZXIuDQo+Pj4gd3JpdGVxL3Jl
YWRxIGFyZSBwcm92aWRlZCB3aGVuZXZlciB0aGUgQ1BVIGFjdHVhbGx5IHN1cHBvcnRzIDY0LWJp
dA0KPj4+IGF0b21pYyBsb2FkcyBhbmQgc3RvcmVzLg0KPj4gSXMgdGhlcmUgYSBjb25maWcgb3B0
aW9uIHdoaWNoIHdlIGNhbiBtYWtlIHRoZSBkcml2ZXIgZGVwZW5kIG9uPw0KPj4NCj4+IEkgbWVh
biB0aGF0IEFSTSBkb2Vzbid0IHN1cHBvcnQgNjRiaXQgYXRvbWljIGxvYWRzIGFuZCBzdG9yZXMg
b24gTU1JTyBpcw0KPj4gcXVpdGUgYSBib29tZXIgZm9yIHVzLg0KPiBUaGUgbW9kZWwgaXMgdG8g
Y2hlYWNrIGlmIHJlYWRxL3dyaXRlcSBhcmUgZGVmaW5lZCwgYW5kIGlmIG5vdCB0bw0KPiBpbmNs
dWRlIHRoZSBvbmUgb2YgaW8tNjQtbm9uYXRvbWljLWhpLWxvLmggb3IgaW8tNjQtbm9uYXRvbWlj
LWxvLWhpLmguDQo+IFRoZSByZWFzb24gZm9yIHRoYXQgaXMgdGhhdCBoYXJkd2FyZSBpcyBzdXBw
b3NlZCB0byBiZSBhYmxlIHRvIGRlYWwgd2l0aA0KPiB0d28gMzItYml0IHdyaXRlcywgYnV0IGl0
IGRlcGVuZHMgb24gdGhlIGhhcmR3YXJlIGlmIHRoZSBsb3dlciBvciB1cHBlcg0KPiBoYWxmIGlz
IHdoYXQgY29tbWl0cyB0aGUgd3JpdGUuDQoNClJlYWQsIGJ1dCBhcyBJIHVuZGVyc3Rvb2QgVGFv
IGNoYW5nZSB0aGlzIGlzIG5vdCB0aGUgY2FzZSBoZXJlLiANCk90aGVyd2lzZSB3ZSB3b3VsZCBq
dXN0IHVzZSBvdXIgV1JFRzMyL1JSRUczMiBtYWNyb3MgaW4gdGhlIGRyaXZlci4NCg0KVGFvLCBw
bGVhc2UgZXhwbGFpbiB3aHkgZXhhY3RseSB3ZSBuZWVkIHRoZSBXUkVHNjQvUlJFRzY0IGNoYW5n
ZSB3aGljaCANCmNhdXNlZCB0aGlzLg0KDQpDaHJpc3RpYW4uDQoNCj4NCj4gVGhlIG9ubHkgMzIt
Yml0IHBsYXRmb3JtIHRoYXQgY2xhaW1zIHN1cHBvcnQgZm9yIHJlYWRxL3dyaXRlcSBpcyBzaCwN
Cj4gYW5kIEkgaGF2ZSBkb3VidHMgaWYgdGhhdCBhY3R1YWxseSB3b3JrcyBhcyBleHBlY3RlZC4N
Cg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
