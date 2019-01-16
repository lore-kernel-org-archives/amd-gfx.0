From: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: update amdgpu_drm.h
Date: Wed, 16 Jan 2019 16:55:45 +0000
Message-ID: <97419d6c-d74a-182a-7623-5330489733d2@amd.com>
References: <20190115192527.11581-1-maraeo@gmail.com>
 <92ca5d38-50d3-f00a-3750-b00fd11b6851@gmail.com>
 <CAAxE2A4Xz3DC7C7YV+GRSqznrRGBk7TCvpVk7pS+z+w80++XLA@mail.gmail.com>
 <7b174535-ed89-9137-b204-dc21ca4ce896@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7b174535-ed89-9137-b204-dc21ca4ce896-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <079EB17C7D18954FA3E1D2AA55EE5195-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, =?utf-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMS8xNi8xOSAxMToyNCBBTSwgS29lbmlnLCBDaHJpc3RpYW4gd3JvdGU6DQo+IEFtIDE2LjAx
LjE5IHVtIDE3OjE1IHNjaHJpZWIgTWFyZWsgT2zFocOhazoNCj4+IE9uIFdlZCwgSmFuIDE2LCAy
MDE5IGF0IDI6MzcgQU0gQ2hyaXN0aWFuIEvDtm5pZyANCj4+IDxja29lbmlnLmxlaWNodHp1bWVy
a2VuQGdtYWlsLmNvbSANCj4+IDxtYWlsdG86Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5j
b20+PiB3cm90ZToNCj4+DQo+PiAgICAgQW0gMTUuMDEuMTkgdW0gMjA6MjUgc2NocmllYiBNYXJl
ayBPbMWhw6FrOg0KPj4gICAgID4gRnJvbTogTWFyZWsgT2zFocOhayA8bWFyZWsub2xzYWtAYW1k
LmNvbSA8bWFpbHRvOm1hcmVrLm9sc2FrQGFtZC5jb20+Pg0KPj4NCj4+ICAgICBNYXliZSBub3Rl
IGluIHRoZSBjb21taXQgbWVzc2FnZSBmcm9tIHdoaWNoIHVwc3RyZWFtIGtlcm5lbC4NCj4+DQo+
Pg0KPj4gTm8gdXBzdHJlYW0ga2VybmVsLiBJdCdzIGZyb20gYW1kLXN0YWdpbmctZHJtLW5leHQu
DQo+IA0KPiBUaGF0J3MgYSBwcm9ibGVtLCBzZWUgdGhlIHJ1bGVzIGZvciB1cGRhdGluZyB0aGlz
Lg0KPiANCj4gSUlSQyB0aGUgY29kZSBtdXN0IGxhbmQgaW4gYW4gdXBzdHJlYW0ga2VybmVsIGJl
Zm9yZSBpdCBjYW4gYmUgY29tbWl0dGVkIA0KPiB0byBsaWJkcm0uDQo+IA0KPiBDaHJpc3RpYW4u
DQo+IA0KPj4NCj4+IE1hcmVrDQoNClRoZSBEQ0MgZmxhZ3Mgc2hvdWxkIGJlIGluIDUuMC4NCg0K
TmljaG9sYXMgS2F6bGF1c2thcw0KDQo+Pg0KPiANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0KPiANCg0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
