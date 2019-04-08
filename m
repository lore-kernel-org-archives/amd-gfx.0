From: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Userptr broken with the latest amdgpu driver
Date: Mon, 8 Apr 2019 20:59:44 +0000
Message-ID: <295abb92-59b2-875c-82cb-cbe2be9ea6e0@amd.com>
References: <CAAxE2A7LC1btT5j0y214V8KqHN+HMm8KW-ciVyXYTdYcqe5VAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A7LC1btT5j0y214V8KqHN+HMm8KW-ciVyXYTdYcqe5VAA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <3EBE3B619F1EC142AB85E093FC50C281-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: =?utf-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SGkgTWFyZWssDQoNCkkgZ3Vlc3MgeW91IGFyZSB1c2luZyBvbGQga2VybmVsIGNvbmZpZyB3aXRo
IDUueCBrZXJuZWwsIGFuZCB0aGUga2VybmVsIA0KY29uZmlnIG9wdGlvbiBDT05GSUdfSE1NIGlz
IG1pc3NpbmcgYmVjYXVzZSB0aGUgZGVwZW5kZW5jeSBvcHRpb24gDQpDT05GSUdfWk9ORV9ERVZJ
Q0UgaXMgbWlzc2luZyBpbiBvbGQgY29uZmlnIGZpbGUuIFBsZWFzZSB1cGRhdGUgeW91ciANCmtl
cm5lbCBjb25maWcgZmlsZSB0byBlbmFibGUgb3B0aW9uIENPTkZJR19aT05FX0RFVklDRS4NCg0K
WW91IHNob3VsZCBoYXZlIHRoaXMgbWVzc2FnZSBpbiBkbWVzZyBsb2c6DQoNCiJITU1fTUlSUk9S
IGtlcm5lbCBjb25maWcgb3B0aW9uIGlzIG5vdCBlbmFibGVkLCAiDQoiYWRkIENPTkZJR19aT05F
X0RFVklDRT15IGluIGNvbmZpZyBmaWxlIHRvIGZpeA0KDQpQaGlsaXANCg0KDQpPbiAyMDE5LTA0
LTA4IDQ6NDYgcC5tLiwgTWFyZWsgT2zFocOhayB3cm90ZToNCj4gSGksDQo+IA0KPiBhbWRncHVf
bW5fcmVnaXN0ZXIgZmFpbHMgd2l0aCAtRU5PREVWIGluIGFtZGdwdV9nZW1fdXNlcnB0cl9pb2N0
bC4NCj4gDQo+IFRoZSByZWdyZXNzaW9uIGhhcHBlbmVkIHdpdGhpbiB0aGUgbGFzdCAxLTIgbW9u
dGhzLg0KPiANCj4gTWFyZWsNCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fDQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA0KPiANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
