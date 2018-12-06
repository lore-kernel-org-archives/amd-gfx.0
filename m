From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Add fast path for cursor plane updates
Date: Thu, 6 Dec 2018 16:12:42 +0000
Message-ID: <1bf03154-6afa-61b7-df7d-5889c3ffd464@amd.com>
References: <20181205195907.9501-1-nicholas.kazlauskas@amd.com>
 <8b305d43-56e1-5505-95d3-35e92f3f8494@amd.com>
 <6352276b-5d47-94ea-2dd1-0f955ceed408@amd.com>
 <73996dfc-1cd6-e707-9e2b-48a5c89d6cac@amd.com>
 <5c4c64a1-cc84-e9c2-6275-ca8ac76237b1@amd.com>
 <a7bad892-8215-16a8-65a6-328533395d03@amd.com>
 <13f4b0bc-fcda-be57-2416-aa3ba5ff065c@amd.com>
 <78e6ff7a-c7f4-324b-7fb2-9df282cb2c7e@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <78e6ff7a-c7f4-324b-7fb2-9df282cb2c7e-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <DE1131043A989546AAC70406BADB5251-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>"Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

T2sgLSB0aGUgY2hhbmdlIGlzIEFja2VkLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdy
b2R6b3Zza3lAYW1kLmNvbT4NCg0KQW5kcmV5DQoNCg0KT24gMTIvMDYvMjAxOCAxMDo1OSBBTSwg
TmljaG9sYXMgS2F6bGF1c2thcyB3cm90ZToNCj4gT24gMjAxOC0xMi0wNiAxMDozNiBhLm0uLCBH
cm9kem92c2t5LCBBbmRyZXkgd3JvdGU6DQo+PiBOb3QgYW4gZXhwZXJ0IG9uIEZyZWVzeW5jIHNv
IG1heWJlIHN0dXBpZCBxdWVzdGlvbiBidXQgZnJvbSBoZSBjb21tZW50DQo+PiBsb29rcyBsaWtl
IHRoaXMgcGlwZSBsb2NraW5nIGlzIG9ubHkgZm9yIHRoZSBzYWtlIG9mIEZyZWVzeW5jIG1vZGUg
dGhlcmUNCj4+IC0gd2h5IGlzIGl0IHRoZW4gY2FsbGVkIHVuY29uZGl0aW9uYWxseSB3L28gY2hl
Y2tpbmcgaWYgeW91IGV2ZW4gcnVuIGluDQo+PiBGcmVlc3luYyBtb2RlID8NCj4+DQo+PiBBbmRy
ZXkNCj4gSSBkb24ndCB0aGluayB0aGVyZSdzIGFueSBzb3J0IG9mIHN0YXRlIHRyYWNraW5nIGRv
bmUgaW4gREMgZm9yIEZyZWVTeW5jDQo+IHN0YXRlIGNoYW5nZXMgb24gYSBzdHJlYW0gc28gaXQg
d2FzIHByb2JhYmx5IGVhc2llciB0byBkbyB0aGlzLiBHaXZlbg0KPiB0aGUgYWdlIG9mIHRoZSBw
aXBlIGxvY2sgYWRkaXRpb24gSSB3b3VsZCBiZSB3b3JyaWVkIGFib3V0IG90aGVyDQo+IGJlaGF2
aW9yIHJlbHlpbmcgb24gaXQgbm93IGlmIGl0IHdhcyBqdXN0IGNvbmRpdGlvbmFsbHkgZG9uZSBv
biB0aGF0Lg0KPg0KPiBJbiBwcmFjdGljZSBJIHRoaW5rIHRoZSB3b3JzdCBjYXNlIGVmZmVjdCBv
ZiBndWFyZGluZyB0aGVzZSBjYWxscyB3aXRoIGENCj4gbXV0ZXggaXMgPDEwMHVzIG9mIGRlbGF5
LiBUaGF0J3MgZm9yIHR3byBzZXBhcmF0ZSB0aHJlYWRzIGlzc3VpbmcgdHdvDQo+IGNvbW1pdHMg
YXQgdGhlIHNhbWUgdGltZSB3aXRoIHRoZSBwbGFuZXMgY2hhbmdlZC4NCj4NCj4gTmljaG9sYXMg
S2F6bGF1c2thcw0KPg0KPj4NCj4+IE9uIDEyLzA2LzIwMTggMDg6NDIgQU0sIEthemxhdXNrYXMs
IE5pY2hvbGFzIHdyb3RlOg0KPj4+IEEgcmVhZGVyL3dyaXRlciBsb2NrIHdvdWxkbid0IGhlbHAg
aGVyZSwgYWN0dWFsbHkuDQo+Pj4NCj4+PiBGYXN0IHVwZGF0ZXMgKGFuZCBwYWdlIGZsaXBzIGlu
IHBhcnRpY3VsYXIpIG5lZWQgdG8gbG9jayB0aGUgcGlwZSBhcw0KPj4+IHdlbGwsIHNlZTogY29t
bWl0X3BsYW5lc19mb3Jfc3RyZWFtLg0KPj4+DQo+Pj4gTmljaG9sYXMgS2F6bGF1c2thcw0KPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBhbWQtZ2Z4
IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngNCg0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
