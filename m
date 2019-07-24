From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v3 3/3] drm/amd: enable S/G for RAVEN chip
Date: Wed, 24 Jul 2019 14:52:59 +0000
Message-ID: <5b2a81a4-8be1-0846-7f5b-ef9cfa934780@amd.com>
References: <1563977442-4809-1-git-send-email-andrey.grodzovsky@amd.com>
 <1563977442-4809-4-git-send-email-andrey.grodzovsky@amd.com>
 <492b52b5-36e0-f957-88e1-c2479f8c56c4@amd.com>
 <e8a4de40-e60c-152a-ba4b-9ef7b1b553c1@amd.com>
 <fc3eb460-934a-afed-b654-b33021d32aa0@amd.com>
 <3d0c5357-52b9-80fb-61ff-363e13086aa8@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3d0c5357-52b9-80fb-61ff-363e13086aa8-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
Content-ID: <9554994FBFC3C84F93D9A388BADB292E-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wu,
 Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>

DQpPbiA3LzI0LzE5IDEwOjUwIEFNLCBNaWNoZWwgRMOkbnplciB3cm90ZToNCj4gT24gMjAxOS0w
Ny0yNCA0OjQxIHAubS4sIEtvZW5pZywgQ2hyaXN0aWFuIHdyb3RlOg0KPj4gQW0gMjQuMDcuMTkg
dW0gMTY6MzIgc2NocmllYiBHcm9kem92c2t5LCBBbmRyZXk6DQo+Pj4gT24gNy8yNC8xOSAxMDoy
NSBBTSwgS29lbmlnLCBDaHJpc3RpYW4gd3JvdGU6DQo+Pj4+IEFtIDI0LjA3LjE5IHVtIDE2OjEw
IHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6DQo+Pj4+PiBGcm9tOiBTaGlyaXNoIFMgPHNoaXJp
c2guc0BhbWQuY29tPg0KPj4+Pj4NCj4+Pj4+IGVuYWJsZXMgZ3B1X3ZtX3N1cHBvcnQgaW4gZG0g
YW5kIGFkZHMNCj4+Pj4+IEFNREdQVV9HRU1fRE9NQUlOX0dUVCBhcyBzdXBwb3J0ZWQgZG9tYWlu
DQo+Pj4+Pg0KPj4+Pj4gdjI6DQo+Pj4+PiBNb3ZlIEJPIHBsYWNlbWVudCBsb2dpYyBpbnRvIGFt
ZGdwdV9kaXNwbGF5X3N1cHBvcnRlZF9kb21haW5zDQo+Pj4+Pg0KPj4+Pj4gdjM6DQo+Pj4+PiBV
c2UgYW1kZ3B1X2JvX3ZhbGlkYXRlX3Vzd2MgaW4gYW1kZ3B1X2Rpc3BsYXlfc3VwcG9ydGVkX2Rv
bWFpbnMuDQo+Pj4+Pg0KPj4+Pj4gQ2hhbmdlLUlkOiBJZjM0MzAwYmVhYTYwYmUyZDM2MTcwYjdi
NWIwOTZlYzY0NDUwMmIyMA0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogU2hpcmlzaCBTIDxzaGlyaXNo
LnNAYW1kLmNvbT4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRy
ZXkuZ3JvZHpvdnNreUBhbWQuY29tPg0KPj4+PiBBY3R1YWxseSB0aGF0IGRvZXNuJ3QgbG9vayBs
aWtlIGEgZ29vZCBpZGVhIHRvIG1lLg0KPj4+Pg0KPj4+PiBJdCBpcyBzdGlsbCBwZXJmZWN0bHkg
cG9zc2libGUgKGFuZCB3YW50ZWQhKSB0aGF0IHRoZSBVU1dDIGZsYWcgd2FzIG5vdA0KPj4+PiBz
ZXQgaW4gdGhlIGZpcnN0IHBsYWNlIGJ5IHVzZXJzcGFjZS4NCj4+Pj4NCj4+Pj4gSXMgdGhhdCBz
dGlsbCBjaGVja2VkIHNvbWV3aGVyZT8NCj4+Pj4NCj4+Pj4gUmVnYXJkcywNCj4+Pj4gQ2hyaXN0
aWFuLg0KPj4+IE5vdCBzdXJlIEkgdW5kZXJzdGFuZCBoZXJlLCBjYW4geW91IGVsYWJvcmF0ZSA/
DQo+PiBJdCdzIHN0aWxsIHBvc3NpYmxlIHRoYXQgdXNlcnNwYWNlIGRvZXNuJ3Qgc2V0IHRoZSBV
U1dDIGZsYWcgYW5kIHRoZXJlDQo+PiBhY3R1YWxseSBtaWdodCBiZSBnb29kIHJlYXNvbnMgZm9y
IHRoYXQuDQo+Pg0KPj4gRG8gd2Ugc3RpbGwgaGF2ZSBhIGNoZWNrIGZvciB0aGlzIGNhc2Ugc29t
ZXdoZXJlPw0KPiBJdCBzb3VuZHMgbGlrZSB5b3UncmUgbWlzdW5kZXJzdGFuZGluZyB3aGF0IHRo
aXMgcGF0Y2ggZG9lcywgcHJvYmFibHkNCj4gZHVlIHRvIHRoZSB3ZWlyZCBhbWRncHVfYm9fdmFs
aWRhdGVfdXN3YyBBUEkuDQo+IGFtZGdwdV9kaXNwbGF5X3N1cHBvcnRlZF9kb21haW5zIGRvZXNu
J3Qgc2V0IHRoZSBmbGFnIGZvciB0aGUgQk8gaXRzZWxmLg0KPiBDaGFuZ2luZyB0aGUgaGVscGVy
IEFQSSB0byB3aGF0IHdlIHN1Z2dlc3RlZCBzaG91bGQgY2xlYXIgdGhpcyB1cC4NCj4NCj4gKE1h
eWJlIHRoZSBuZXcgaGVscGVyIGZ1bmN0aW9uIHNob3VsZCBiZSB1c2VkIGluDQo+IGFtZGdwdV9k
aXNwbGF5X3N1cHBvcnRlZF9kb21haW5zIGluIHBhdGNoIDIgYWxyZWFkeSwgb3IgaW4geWV0IGFu
b3RoZXINCj4gc2VwYXJhdGUgcGF0Y2g/KQ0KDQoNClllYSwgYWdyZWUsIGxldCBtZSBzZW5kIHRo
ZSBWNCB3aXRoIGJvb2wgQVBJIHRvIG1ha2UgdGhpbmdzIGNsZWFyZXIgYW5kIA0KSSB3aWxsIGlu
ZGVlZCBzZXBhcmF0ZSB0aGlzIGNoYW5nZSBmcm9tIFMvRyBlbmFibGluZy4NCg0KQW5kcmV5DQoN
Cj4NCj4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
