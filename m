From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 01/13] drm/amdgpu: introduce and honour DRM_FORCE_AUTH
 workaround
Date: Tue, 4 Jun 2019 11:24:38 +0000
Message-ID: <1b697f02-a6cf-0bc1-9149-3acd71eb4e30@amd.com>
References: <20190527081741.14235-1-emil.l.velikov@gmail.com>
 <3c9b5688-5e83-f173-00e3-6e139e05d466@amd.com>
 <20190527132041.GP21222@phenom.ffwll.local>
 <20190527132607.GH15067@arch-x1c3>
 <0426fb3e-e7bc-2464-cb42-4d5753956d23@amd.com>
 <CAKMK7uE_pRro8PxTwUq+pC_1GVVT7nUxan1T-kqSYT=BMHTf2g@mail.gmail.com>
 <d12a7dd4-595b-d0aa-a87d-527392fb0384@amd.com>
 <CAKMK7uE1ZWjCeg3q7qDrbcj89+DuPQwfjMqC8hTjDAMU5bhh-w@mail.gmail.com>
 <98c3d891-6966-2043-9709-4e718dbc6bac@amd.com>
 <ee1b8980-3d78-aa6d-fe46-2c0d45c2bbdd@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ee1b8980-3d78-aa6d-fe46-2c0d45c2bbdd-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
Content-ID: <4F9F40EEF4528C428DC8C64DDE2EE26C-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMDQuMDYuMTkgdW0gMTI6NTAgc2NocmllYiBNaWNoZWwgRMOkbnplcjoNCj4gT24gMjAxOS0w
NS0yOCAxMDowMyBhLm0uLCBLb2VuaWcsIENocmlzdGlhbiB3cm90ZToNCj4+IEkgcmF0aGVyIHRo
aW5rIHRoYXQgd2Ugc2hvdWxkIGdvIGRvd24gdGhlIHJvdXRlIG9mIGNvbXBsZXRlbHkgZHJvcHBp
bmcNCj4+IGNvbW1hbmQgc3VibWlzc2lvbiBhbmQgYnVmZmVyIGFsbG9jYXRpb24gdGhyb3VnaCB0
aGUgcHJpbWFyeSBub2RlIGZvcg0KPj4gbm9uIG1hc3RlciBjbGllbnRzLiBBbmQgdGhlbiBhcyBu
ZXh0IHN0ZXAgYXQgc29tZSBwb2ludCBkcm9wIHN1cHBvcnQgZm9yDQo+PiBhdXRoZW50aWNhdGlv
bi9mbGluay4NCj4gS2VlcCBpbiBtaW5kIHRoYXQgZXZlbiBkaXNwbGF5IHNlcnZlcnMgYXJlbid0
IERSTSBtYXN0ZXIgd2hpbGUgdGhlaXIgVlQNCj4gaXNuJ3QgYWN0aXZlLCBzbyB0aGlzIG1pZ2h0
IGJlIHByb2JsZW1hdGljIGlmIGEgZGlzcGxheSBzZXJ2ZXIgbmVlZHMgdG8NCj4gZG8gc29tZSBj
b21tYW5kIHN1Ym1pc3Npb24gLyBidWZmZXIgYWxsb2NhdGlvbiBkdXJpbmcgdGhhdCB0aW1lLg0K
DQpJZiBJIHVuZGVyc3RhbmQgaXQgY29ycmVjdGx5IHRoZSBEUk0gZmQgc3RheXMgbWFzdGVyIGV2
ZW4gd2hlbiB0aGUgVlQgaXMgDQpzd2l0Y2hlZCBhd2F5LCBpdCdzIGp1c3Qgbm90IHRoZSBjdXJy
ZW50IG1hc3RlciBhbnkgbW9yZS4NCg0KU28gaW4gdGhpcyBjYXNlIGZwcml2LT5pc19tYXN0ZXIg
c3RheXMgdHJ1ZSwgYnV0IA0KZHJtX2lzX2N1cnJlbnRfbWFzdGVyKGZwcml2KSByZXR1cm5zIGZh
bHNlLg0KDQpBbmQgeWVzIHdlIG1peGVkIHRoYXQgdXAgaW4gYW1kZ3B1LCBpOTE1IGFuZCB2bXdn
ZnguIFNvbWVib2R5IHNob3VsZCANCnByb2JhYmx5IHdyaXRlIHBhdGNoZXMgdG8gZml4IHRoaXMu
DQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
