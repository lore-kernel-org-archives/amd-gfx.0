From: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use new HMM APIs and helpers
Date: Fri, 31 May 2019 17:28:29 +0000
Message-ID: <bd8f1fd6-f6c4-66fc-c0b9-c8ed36cd6027@amd.com>
References: <20190530144049.1996-1-Philip.Yang@amd.com>
 <704410a5-be01-f423-11ef-01a640cd469c@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <704410a5-be01-f423-11ef-01a640cd469c-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <D2577B7245214B4BA5967E578AF1CB58-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

DQoNCk9uIDIwMTktMDUtMzAgNjozNiBwLm0uLCBLdWVobGluZywgRmVsaXggd3JvdGU6DQo+PiAg
ICANCj4+ICAgICNpZiBJU19FTkFCTEVEKENPTkZJR19EUk1fQU1ER1BVX1VTRVJQVFIpDQo+PiAt
CWlmIChndHQtPnJhbmdlcyAmJg0KPj4gLQkgICAgdHRtLT5wYWdlc1swXSA9PSBobW1fcGZuX3Rv
X3BhZ2UoJmd0dC0+cmFuZ2VzWzBdLA0KPj4gLQkJCQkJICAgICBndHQtPnJhbmdlc1swXS5wZm5z
WzBdKSkNCj4+ICsJaWYgKGd0dC0+cmFuZ2UgJiYNCj4+ICsJICAgIHR0bS0+cGFnZXNbMF0gPT0g
aG1tX2RldmljZV9lbnRyeV90b19wYWdlKGd0dC0+cmFuZ2UsDQo+PiArCQkJCQkJICAgICAgZ3R0
LT5yYW5nZS0+cGZuc1swXSkpDQo+IEkgdGhpbmsganVzdCBjaGVja2luZyBndHQtPnJhbmdlIGhl
cmUgaXMgZW5vdWdoLiBJZiBndHQtPnJhbmdlIGlzIG5vdA0KPiBOVUxMIGhlcmUsIHdlJ3JlIGxl
YWtpbmcgbWVtb3J5Lg0KPiANCklmIGp1c3QgY2hlY2tpbmcgZ3R0LT5yYW5nZSwgdGhlcmUgaXMg
YSBmYWxzZSB3YXJuaW5nIGluIGFtZGdwdV90ZXN0IA0KdXNlcnB0ciBjYXNlIGluIGFtZGdwdV9j
c19saXN0X3ZhbGlkYXRlIHBhdGguIElmIHVzZXJwdHIgaXMgaW52YWxpZGF0ZWQsIA0KdGhlbiB0
dG0tPnBhZ2VzWzBdIGlzIG91dGRhdGVkIHBhZ2VzLCBsb2JqLT51c2VyX3BhZ2VzIGlzIG5ldyBw
YWdlcywgaXQgDQpnb2VzIHRvIHR0bV90dF91bmJpbmQgZmlyc3QgdG8gdW5waW4gb2xkIHBhZ2Vz
ICh0aGlzIGNhdXNlcyBmYWxzZSANCndhcm5pbmcpIHRoZW4gY2FsbCBhbWRncHVfdHRtX3R0X3Nl
dF91c2VyX3BhZ2VzLg0KDQpJIHdpbGwgc3VibWl0IHBhdGNoIHYyLCB0byBhZGQgcmV0cnkgaWYg
aG1tX3JhbmdlX2ZhdWx0IHJldHVybnMgLUVBR0FJTi4gDQp1c2Uga3phbGxvYyB0byBhbGxvY2F0
ZSBzbWFsbCBzaXplIHJhbmdlLg0KDQpUaGFua3MsDQpQaGlsaXANCg0KPiBSZWdhcmRzLA0KPiAg
IMKgIEZlbGl4DQo+IA0KPiANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
