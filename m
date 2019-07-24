From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v3 2/3] drm/amdgpu: Create helper to clear
 AMDGPU_GEM_CREATE_CPU_GTT_USWC
Date: Wed, 24 Jul 2019 14:33:40 +0000
Message-ID: <a3f16c33-55f8-1de4-d866-fcff67cf9f42@amd.com>
References: <1563977442-4809-1-git-send-email-andrey.grodzovsky@amd.com>
 <1563977442-4809-3-git-send-email-andrey.grodzovsky@amd.com>
 <e70a00d3-bcd3-c72e-8de8-eb6ae10abee6@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e70a00d3-bcd3-c72e-8de8-eb6ae10abee6-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
Content-ID: <F2FAA14709BB09478694EE42BCA26304-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wu, Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "S,
 Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>

DQpPbiA3LzI0LzE5IDEwOjI0IEFNLCBNaWNoZWwgRMOkbnplciB3cm90ZToNCj4gT24gMjAxOS0w
Ny0yNCA0OjEwIHAubS4sIEFuZHJleSBHcm9kem92c2t5IHdyb3RlOg0KPj4gTW92ZSB0aGUgbG9n
aWMgdG8gY2xlYXIgQU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0dUVF9VU1dDIGluDQo+PiBhbWRncHVf
Ym9fZG9fY3JlYXRlIGludG8gc3RhbmRhbG9uZSBoZWxwZXIgc28gaXQgY2FuIGJlIHJldXNlZA0K
Pj4gaW4gb3RoZXIgZnVuY3Rpb25zLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9k
em92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPg0KPj4gLS0tDQo+PiAgIFsuLi5dDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0KPj4gaW5k
ZXggOTg5YjdiNS4uNjRjNDViYyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X29iamVjdC5jDQo+PiBAQCAtNDEzLDYgKzQxMyw0MSBAQCBzdGF0aWMgYm9vbCBh
bWRncHVfYm9fdmFsaWRhdGVfc2l6ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4+ICAg
CXJldHVybiBmYWxzZTsNCj4+ICAgfQ0KPj4gICANCj4+ICt2b2lkIGFtZGdwdV9ib192YWxpZGF0
ZV91c3djKHU2NCAqYm9fZmxhZ3MpDQo+IFRoaXMgQVBJIGlzIGEgYml0IHdlaXJkLiA6KSBJJ2Qg
c3VnZ2VzdCBzb21ldGhpbmcgbGlrZQ0KPg0KPiBib29sIGFtZGdwdV91c3djX3N1cHBvcnRlZCh2
b2lkKQ0KPiB7DQo+IAlpZiAoW3ZhcmlvdXMgY29uZGl0aW9uc10pDQo+IAkJcmV0dXJuIGZhbHNl
Ow0KPg0KPiAJcmV0dXJuIHRydWU7DQo+IH0NCg0KDQpZZWEsIHRoZSBjb2RlIGlzIGNvbmZ1c2lu
ZyB3aXRoIGFsbCAjaWZkZWZzIHNvIGkgd2FudGVkIG1pbmltYWwgY2hhbmdlcyANCnRvIG5vdCBi
cmVhayBhbnl0aGluZywgYnV0IGkgY2FuIGRvIHRoaXMgd2F5IHRvLg0KDQpBbmRyZXkNCg0KDQo+
DQo+PiBAQCAtNDY2LDMzICs1MDEsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9ib19kb19jcmVhdGUo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+PiBbLi4uXQ0KPj4gKwlhbWRncHVfYm9fdmFs
aWRhdGVfdXN3YygmYm8tPmZsYWdzKTsNCj4gQW5kIHRoZW4NCj4NCj4gCWlmICghYW1kZ3B1X3Vz
d2Nfc3VwcG9ydGVkKCkpDQo+IAkJYm8tPmZsYWdzICY9IH5BTURHUFVfR0VNX0NSRUFURV9DUFVf
R1RUX1VTV0M7DQo+DQo+IGhlcmUuDQo+DQo+DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
