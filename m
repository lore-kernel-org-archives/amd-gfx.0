From: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: KASAN caught amdgpu / HMM use-after-free
Date: Wed, 27 Feb 2019 18:05:36 +0000
Message-ID: <35d7e134-6eef-9732-8ebf-83256e40eb65@amd.com>
References: <e8466985-a66b-468b-5fff-6e743180da67@daenzer.net>
 <83fde7eb-abab-e770-efd5-89bc9c39fdff@amd.com>
 <c26fa310-38d1-acba-cf82-bc6dc2f782c0@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c26fa310-38d1-acba-cf82-bc6dc2f782c0-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
Content-ID: <4B97951C6861FF4681AFBA5D9CE2BADB-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

YW1kLXN0YWdpbmctZHJtLW5leHQgd2lsbCByZWJhc2UgdG8ga2VybmVsIDUuMSB0byBwaWNrdXAg
dGhpcyBmaXggDQphdXRvbWF0aWNhbGx5LiBBcyBhIHNob3J0LXRlcm0gd29ya2Fyb3VuZCwgcGxl
YXNlIGNoZXJyeS1waWNrIHRoaXMgZml4IA0KaW50byB5b3VyIGxvY2FsIHJlcG9zaXRvcnkuDQoN
ClJlZ2FyZHMsDQpQaGlsaXANCg0KT24gMjAxOS0wMi0yNyAxMjozMyBwLm0uLCBNaWNoZWwgRMOk
bnplciB3cm90ZToNCj4gT24gMjAxOS0wMi0yNyA2OjE0IHAubS4sIFlhbmcsIFBoaWxpcCB3cm90
ZToNCj4+IEhpIE1pY2hlbCwNCj4+DQo+PiBZZXMsIEkgZm91bmQgdGhlIHNhbWUgaXNzdWUgYW5k
IHRoZSBidWcgaGFzIGJlZW4gZml4ZWQgYnkgSmVyb21lOg0KPj4NCj4+IDg3NmI0NjIxMjBhYSBt
bS9obW06IHVzZSByZWZlcmVuY2UgY291bnRpbmcgZm9yIEhNTSBzdHJ1Y3QNCj4+DQo+PiBUaGUg
Zml4IGlzIG9uIGhtbS1mb3ItNS4xIGJyYW5jaCwgSSBjaGVycnktcGljayBpdCBpbnRvIG15IGxv
Y2FsIGJyYW5jaA0KPj4gdG8gd29ya2Fyb3VuZCB0aGUgaXNzdWUuDQo+IA0KPiBQbGVhc2UgcHVz
aCBpdCB0byBhbWQtc3RhZ2luZy1kcm0tbmV4dCwgc28gdGhhdCBvdGhlcnMgZG9uJ3QgcnVuIGlu
dG8NCj4gdGhlIGlzc3VlIGFzIHdlbGwuDQo+IA0KPiANCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
