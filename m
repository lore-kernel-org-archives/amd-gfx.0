From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v5 1/2] drm/sched: Refactor ring mirror list handling.
Date: Fri, 11 Jan 2019 19:11:13 +0000
Message-ID: <8a615696-a9ff-7670-5d25-6120282e818b@amd.com>
References: <1545333815-29870-1-git-send-email-andrey.grodzovsky@amd.com>
 <c62cf367-1485-b1f4-04c2-a11dd8f35416@gmail.com>
 <fc3e12f7-55e1-bf04-b190-7393e84d22a8@amd.com>
 <109f33b9-0a24-08e3-053d-57923b4d7e7f@amd.com>
 <642bdffd-afe9-1a58-4f32-9ef7a4cb22b7@amd.com>
 <c087d565-05d6-aa24-f3ac-9a6378d9ca1b@amd.com>
 <5e256bb1-d4aa-f965-2799-d68c9f925b66@gmail.com>
 <d5a3470a-21a1-adf7-6f85-4d22fae7bb81@amd.com>
 <6a2b45d7-0fa3-38fe-98b2-a538b663c6cc@gmail.com>
 <ea37c55f-ee56-cce7-a4e1-1a599642c54c@amd.com>
 <cbd07551-4f5e-fb80-a4ef-376b19bb3655@amd.com>
 <37ad8228-355e-1d53-593f-b0cb736eadff@amd.com>
 <5434e38b-c5c6-26e8-d632-bd1b1b52a44a@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5434e38b-c5c6-26e8-d632-bd1b1b52a44a-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <976E8E47C1EC224AAD8EDE11E3B8A3F5-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org" <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "etnaviv-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <etnaviv-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

QW0gMTEuMDEuMTkgdW0gMTY6Mzcgc2NocmllYiBHcm9kem92c2t5LCBBbmRyZXk6DQo+DQo+IE9u
IDAxLzExLzIwMTkgMDQ6NDIgQU0sIEtvZW5pZywgQ2hyaXN0aWFuIHdyb3RlOg0KPj4gQW0gMTAu
MDEuMTkgdW0gMTY6NTYgc2NocmllYiBHcm9kem92c2t5LCBBbmRyZXk6DQo+Pj4gW1NOSVBdDQo+
Pj4+Pj4gQnV0IHdlIHdpbGwgbm90IGJlIGFkZGluZyB0aGUgY2IgYmFjayBpbiBkcm1fc2NoZWRf
c3RvcCBhbnltb3JlLCBub3cgd2UNCj4+Pj4+PiBhcmUgb25seSBnb2luZyB0byBhZGQgYmFjayB0
aGUgY2IgaW4gZHJtX3NjaGVkX3N0YXJ0ciBhZnRlciByZXJ1bm5pbmcNCj4+Pj4+PiB0aG9zZSBq
b2JzIGluIGRybV9zY2hlZF9yZXN1Ym1pdF9qb2JzIGFuZCBhc3NpZ24gdGhlbSBhIG5ldyBwYXJl
bnQNCj4+Pj4+PiB0aGVyZQ0KPj4+Pj4+IGFueXdheS4NCj4+Pj4+IFllYWgsIGJ1dCB3aGVuIHdl
IGZpbmQgdGhhdCB3ZSBkb24ndCBuZWVkIHRvIHJlc2V0IGFueXRoaW5nIGFueW1vcmUNCj4+Pj4+
IHRoZW4gYWRkaW5nIHRoZSBjYWxsYmFja3MgYWdhaW4gd29uJ3QgYmUgcG9zc2libGUgYW55IG1v
cmUuDQo+Pj4+Pg0KPj4+Pj4gQ2hyaXN0aWFuLg0KPj4+PiBJIGFtIG5vdCBzdXJlIEkgdW5kZXJz
dGFuZCBpdCwgY2FuIHUgcG9pbnQgbWUgdG8gZXhhbXBsZSBvZiBob3cgdGhpcw0KPj4+PiB3aWxs
IGhhcHBlbiA/IEkgYW0gYXR0YWNoaW5nIG15IGxhdGVzdCBwYXRjaGVzIHdpdGggd2FpdGluZyBv
bmx5IGZvcg0KPj4+PiB0aGUgbGFzdCBqb2IncyBmZW5jZSBoZXJlIGp1c3Qgc28gd2UgYXJlIG9u
IHNhbWUgcGFnZSByZWdhcmRpbmcgdGhlIGNvZGUuDQo+PiBXZWxsIHRoZSB3aG9sZSBpZGVhIGlz
IHRvIHByZXBhcmUgYWxsIHNjaGVkdWxlcnMsIHRoZW4gY2hlY2sgb25jZSBtb3JlDQo+PiBpZiB0
aGUgb2ZmZW5kaW5nIGpvYiBoYXNuJ3QgY29tcGxldGVkIGluIHRoZSBtZWFudGltZS4NCj4+DQo+
PiBJZiB0aGUgam9iIGNvbXBsZXRlZCB3ZSBuZWVkIHRvIGJlIGFibGUgdG8gcm9sbGJhY2sgZXZl
cnl0aGluZyBhbmQNCj4+IGNvbnRpbnVlIGFzIGlmIG5vdGhpbmcgaGFkIGhhcHBlbmVkLg0KPj4N
Cj4+IENocmlzdGlhbi4NCj4gT2gsIGJ1dCB0aGlzIHBpZWNlIG9mIGZ1bmN0aW9uYWxpdHkgLSBz
a2lwcGluZyBIVyBBU0lDIHJlc2V0IGluIGNhc2UgdGhlDQo+IGd1aWx0eSBqb2IgZG9uZSBpcyB0
b3RhbGx5IG1pc3NpbmcgZm9ybSB0aGlzIHBhdGNoIHNlcmllcyBhbmQgc28gbmVlZHMNCj4gdG8g
YmUgYWRkZWQuIFNvIHdoYXQgeW91IHNheSBhY3R1YWxseSBpcyB0aGF0IGZvciB0aGUgY2FzZSB3
ZXJlIHdlIHNraXANCj4gSFcgYXNpYyByZXNldCBiZWNhdXNlIHRoZSBndWlsdHkgam9iIGRpZCBj
b21wbGV0ZSB3ZSBhbHNvIG5lZWQgdG8gc2tpcA0KPiByZXN1Ym1pdHRpbmcgdGhlIGpvYnMgaW4g
ZHJtX3NjaGVkX3Jlc3VibWl0X2pvYnMgYW5kIGhlbmNlIHByZXNlcnZlIHRoZQ0KPiBvbGQgcGFy
ZW50IGZlbmNlIHBvaW50ZXIgZm9yIHJldXNlID8gSWYgc28gSSB3b3VsZCBsaWtlIHRvIGFkZCBh
bGwgdGhpcw0KPiBmdW5jdGlvbmFsaXR5IGFzIGEgdGhpcmQgcGF0Y2ggc2luY2UgdGhlIGZpcnN0
IDIgcGF0Y2hlcyBhcmUgbW9yZSBhYm91dA0KPiByZXNvbHZpbmcgcmFjZSBjb25kaXRpb24gd2l0
aCBqb2JzIGluIGZsaWdodCB3aGlsZSBkb2luZyByZXNldCAtIHdoYXQgZG8NCj4geW91IHRoaW5r
ID8NCg0KWWVhaCwgc291bmRzIHBlcmZlY3RseSBmaW5lIHRvIG1lLg0KDQpDaHJpc3RpYW4uDQoN
Cj4NCj4gQW5kcmV5DQo+Pj4+IEFuZHJleQ0KPj4+Pg0KPj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+PiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQoNCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
