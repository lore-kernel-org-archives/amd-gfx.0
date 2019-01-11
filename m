From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v5 1/2] drm/sched: Refactor ring mirror list handling.
Date: Fri, 11 Jan 2019 15:37:22 +0000
Message-ID: <5434e38b-c5c6-26e8-d632-bd1b1b52a44a@amd.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <37ad8228-355e-1d53-593f-b0cb736eadff-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <A6C854FB4AE57D4083D8F3E65734F07E-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org" <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "etnaviv-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <etnaviv-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

DQoNCk9uIDAxLzExLzIwMTkgMDQ6NDIgQU0sIEtvZW5pZywgQ2hyaXN0aWFuIHdyb3RlOg0KPiBB
bSAxMC4wMS4xOSB1bSAxNjo1NiBzY2hyaWViIEdyb2R6b3Zza3ksIEFuZHJleToNCj4+IFtTTklQ
XQ0KPj4+Pj4gQnV0IHdlIHdpbGwgbm90IGJlIGFkZGluZyB0aGUgY2IgYmFjayBpbiBkcm1fc2No
ZWRfc3RvcCBhbnltb3JlLCBub3cgd2UNCj4+Pj4+IGFyZSBvbmx5IGdvaW5nIHRvIGFkZCBiYWNr
IHRoZSBjYiBpbiBkcm1fc2NoZWRfc3RhcnRyIGFmdGVyIHJlcnVubmluZw0KPj4+Pj4gdGhvc2Ug
am9icyBpbiBkcm1fc2NoZWRfcmVzdWJtaXRfam9icyBhbmQgYXNzaWduIHRoZW0gYSBuZXcgcGFy
ZW50DQo+Pj4+PiB0aGVyZQ0KPj4+Pj4gYW55d2F5Lg0KPj4+PiBZZWFoLCBidXQgd2hlbiB3ZSBm
aW5kIHRoYXQgd2UgZG9uJ3QgbmVlZCB0byByZXNldCBhbnl0aGluZyBhbnltb3JlDQo+Pj4+IHRo
ZW4gYWRkaW5nIHRoZSBjYWxsYmFja3MgYWdhaW4gd29uJ3QgYmUgcG9zc2libGUgYW55IG1vcmUu
DQo+Pj4+DQo+Pj4+IENocmlzdGlhbi4NCj4+PiBJIGFtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCBp
dCwgY2FuIHUgcG9pbnQgbWUgdG8gZXhhbXBsZSBvZiBob3cgdGhpcw0KPj4+IHdpbGwgaGFwcGVu
ID8gSSBhbSBhdHRhY2hpbmcgbXkgbGF0ZXN0IHBhdGNoZXMgd2l0aCB3YWl0aW5nIG9ubHkgZm9y
DQo+Pj4gdGhlIGxhc3Qgam9iJ3MgZmVuY2UgaGVyZSBqdXN0IHNvIHdlIGFyZSBvbiBzYW1lIHBh
Z2UgcmVnYXJkaW5nIHRoZSBjb2RlLg0KPiBXZWxsIHRoZSB3aG9sZSBpZGVhIGlzIHRvIHByZXBh
cmUgYWxsIHNjaGVkdWxlcnMsIHRoZW4gY2hlY2sgb25jZSBtb3JlDQo+IGlmIHRoZSBvZmZlbmRp
bmcgam9iIGhhc24ndCBjb21wbGV0ZWQgaW4gdGhlIG1lYW50aW1lLg0KPg0KPiBJZiB0aGUgam9i
IGNvbXBsZXRlZCB3ZSBuZWVkIHRvIGJlIGFibGUgdG8gcm9sbGJhY2sgZXZlcnl0aGluZyBhbmQN
Cj4gY29udGludWUgYXMgaWYgbm90aGluZyBoYWQgaGFwcGVuZWQuDQo+DQo+IENocmlzdGlhbi4N
Cg0KT2gsIGJ1dCB0aGlzIHBpZWNlIG9mIGZ1bmN0aW9uYWxpdHkgLSBza2lwcGluZyBIVyBBU0lD
IHJlc2V0IGluIGNhc2UgdGhlIA0KZ3VpbHR5IGpvYiBkb25lIGlzIHRvdGFsbHkgbWlzc2luZyBm
b3JtIHRoaXMgcGF0Y2ggc2VyaWVzIGFuZCBzbyBuZWVkcyANCnRvIGJlIGFkZGVkLiBTbyB3aGF0
IHlvdSBzYXkgYWN0dWFsbHkgaXMgdGhhdCBmb3IgdGhlIGNhc2Ugd2VyZSB3ZSBza2lwIA0KSFcg
YXNpYyByZXNldCBiZWNhdXNlIHRoZSBndWlsdHkgam9iIGRpZCBjb21wbGV0ZSB3ZSBhbHNvIG5l
ZWQgdG8gc2tpcMKgIA0KcmVzdWJtaXR0aW5nIHRoZSBqb2JzIGluIGRybV9zY2hlZF9yZXN1Ym1p
dF9qb2JzIGFuZCBoZW5jZSBwcmVzZXJ2ZSB0aGUgDQpvbGQgcGFyZW50IGZlbmNlIHBvaW50ZXIg
Zm9yIHJldXNlID8gSWYgc28gSSB3b3VsZCBsaWtlIHRvIGFkZCBhbGwgdGhpcyANCmZ1bmN0aW9u
YWxpdHkgYXMgYSB0aGlyZCBwYXRjaCBzaW5jZSB0aGUgZmlyc3QgMiBwYXRjaGVzIGFyZSBtb3Jl
IGFib3V0IA0KcmVzb2x2aW5nIHJhY2UgY29uZGl0aW9uIHdpdGggam9icyBpbiBmbGlnaHQgd2hp
bGUgZG9pbmcgcmVzZXQgLSB3aGF0IGRvIA0KeW91IHRoaW5rID8NCg0KQW5kcmV5DQo+DQo+Pj4g
QW5kcmV5DQo+Pj4NCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18NCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
