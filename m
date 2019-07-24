From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v3 3/3] drm/amd: enable S/G for RAVEN chip
Date: Wed, 24 Jul 2019 14:56:33 +0000
Message-ID: <82c41cbf-4bfd-f9aa-30e5-02773912a4ee@amd.com>
References: <1563977442-4809-1-git-send-email-andrey.grodzovsky@amd.com>
 <1563977442-4809-4-git-send-email-andrey.grodzovsky@amd.com>
 <492b52b5-36e0-f957-88e1-c2479f8c56c4@amd.com>
 <e8a4de40-e60c-152a-ba4b-9ef7b1b553c1@amd.com>
 <fc3eb460-934a-afed-b654-b33021d32aa0@amd.com>
 <3d0c5357-52b9-80fb-61ff-363e13086aa8@daenzer.net>
 <5b2a81a4-8be1-0846-7f5b-ef9cfa934780@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5b2a81a4-8be1-0846-7f5b-ef9cfa934780-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <D85E896F67EB4B418BE7C92868A63BC7-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wu,
 Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>

QW0gMjQuMDcuMTkgdW0gMTY6NTIgc2NocmllYiBHcm9kem92c2t5LCBBbmRyZXk6DQo+IE9uIDcv
MjQvMTkgMTA6NTAgQU0sIE1pY2hlbCBEw6RuemVyIHdyb3RlOg0KPj4gT24gMjAxOS0wNy0yNCA0
OjQxIHAubS4sIEtvZW5pZywgQ2hyaXN0aWFuIHdyb3RlOg0KPj4+IEFtIDI0LjA3LjE5IHVtIDE2
OjMyIHNjaHJpZWIgR3JvZHpvdnNreSwgQW5kcmV5Og0KPj4+PiBPbiA3LzI0LzE5IDEwOjI1IEFN
LCBLb2VuaWcsIENocmlzdGlhbiB3cm90ZToNCj4+Pj4+IEFtIDI0LjA3LjE5IHVtIDE2OjEwIHNj
aHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6DQo+Pj4+Pj4gRnJvbTogU2hpcmlzaCBTIDxzaGlyaXNo
LnNAYW1kLmNvbT4NCj4+Pj4+Pg0KPj4+Pj4+IGVuYWJsZXMgZ3B1X3ZtX3N1cHBvcnQgaW4gZG0g
YW5kIGFkZHMNCj4+Pj4+PiBBTURHUFVfR0VNX0RPTUFJTl9HVFQgYXMgc3VwcG9ydGVkIGRvbWFp
bg0KPj4+Pj4+DQo+Pj4+Pj4gdjI6DQo+Pj4+Pj4gTW92ZSBCTyBwbGFjZW1lbnQgbG9naWMgaW50
byBhbWRncHVfZGlzcGxheV9zdXBwb3J0ZWRfZG9tYWlucw0KPj4+Pj4+DQo+Pj4+Pj4gdjM6DQo+
Pj4+Pj4gVXNlIGFtZGdwdV9ib192YWxpZGF0ZV91c3djIGluIGFtZGdwdV9kaXNwbGF5X3N1cHBv
cnRlZF9kb21haW5zLg0KPj4+Pj4+DQo+Pj4+Pj4gQ2hhbmdlLUlkOiBJZjM0MzAwYmVhYTYwYmUy
ZDM2MTcwYjdiNWIwOTZlYzY0NDUwMmIyMA0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFNoaXJpc2gg
UyA8c2hpcmlzaC5zQGFtZC5jb20+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6
b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+DQo+Pj4+PiBBY3R1YWxseSB0aGF0IGRv
ZXNuJ3QgbG9vayBsaWtlIGEgZ29vZCBpZGVhIHRvIG1lLg0KPj4+Pj4NCj4+Pj4+IEl0IGlzIHN0
aWxsIHBlcmZlY3RseSBwb3NzaWJsZSAoYW5kIHdhbnRlZCEpIHRoYXQgdGhlIFVTV0MgZmxhZyB3
YXMgbm90DQo+Pj4+PiBzZXQgaW4gdGhlIGZpcnN0IHBsYWNlIGJ5IHVzZXJzcGFjZS4NCj4+Pj4+
DQo+Pj4+PiBJcyB0aGF0IHN0aWxsIGNoZWNrZWQgc29tZXdoZXJlPw0KPj4+Pj4NCj4+Pj4+IFJl
Z2FyZHMsDQo+Pj4+PiBDaHJpc3RpYW4uDQo+Pj4+IE5vdCBzdXJlIEkgdW5kZXJzdGFuZCBoZXJl
LCBjYW4geW91IGVsYWJvcmF0ZSA/DQo+Pj4gSXQncyBzdGlsbCBwb3NzaWJsZSB0aGF0IHVzZXJz
cGFjZSBkb2Vzbid0IHNldCB0aGUgVVNXQyBmbGFnIGFuZCB0aGVyZQ0KPj4+IGFjdHVhbGx5IG1p
Z2h0IGJlIGdvb2QgcmVhc29ucyBmb3IgdGhhdC4NCj4+Pg0KPj4+IERvIHdlIHN0aWxsIGhhdmUg
YSBjaGVjayBmb3IgdGhpcyBjYXNlIHNvbWV3aGVyZT8NCj4+IEl0IHNvdW5kcyBsaWtlIHlvdSdy
ZSBtaXN1bmRlcnN0YW5kaW5nIHdoYXQgdGhpcyBwYXRjaCBkb2VzLCBwcm9iYWJseQ0KPj4gZHVl
IHRvIHRoZSB3ZWlyZCBhbWRncHVfYm9fdmFsaWRhdGVfdXN3YyBBUEkuDQo+PiBhbWRncHVfZGlz
cGxheV9zdXBwb3J0ZWRfZG9tYWlucyBkb2Vzbid0IHNldCB0aGUgZmxhZyBmb3IgdGhlIEJPIGl0
c2VsZi4NCj4+IENoYW5naW5nIHRoZSBoZWxwZXIgQVBJIHRvIHdoYXQgd2Ugc3VnZ2VzdGVkIHNo
b3VsZCBjbGVhciB0aGlzIHVwLg0KDQpZZWFoIHRoYXQgaXMgY2VydGFpbmx5IHBvc3NpYmxlLg0K
DQo+Pg0KPj4gKE1heWJlIHRoZSBuZXcgaGVscGVyIGZ1bmN0aW9uIHNob3VsZCBiZSB1c2VkIGlu
DQo+PiBhbWRncHVfZGlzcGxheV9zdXBwb3J0ZWRfZG9tYWlucyBpbiBwYXRjaCAyIGFscmVhZHks
IG9yIGluIHlldCBhbm90aGVyDQo+PiBzZXBhcmF0ZSBwYXRjaD8pDQo+DQo+IFllYSwgYWdyZWUs
IGxldCBtZSBzZW5kIHRoZSBWNCB3aXRoIGJvb2wgQVBJIHRvIG1ha2UgdGhpbmdzIGNsZWFyZXIg
YW5kDQo+IEkgd2lsbCBpbmRlZWQgc2VwYXJhdGUgdGhpcyBjaGFuZ2UgZnJvbSBTL0cgZW5hYmxp
bmcuDQoNClNvdW5kcyBnb29kIHRvIG1lLA0KQ2hyaXN0aWFuLg0KDQo+DQo+IEFuZHJleQ0KPg0K
Pj4NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
