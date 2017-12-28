From: "He, Roger" <Hongbo.He-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/amdgpu: set gtt size according to system memory
 size only
Date: Thu, 28 Dec 2017 03:37:22 +0000
Message-ID: <MWHPR1201MB01273E8700DF0289D6A20194FD040@MWHPR1201MB0127.namprd12.prod.outlook.com>
References: <1511946723-27200-1-git-send-email-Hongbo.He@amd.com>
 <090b426c-0635-3c59-8a69-315c7f430b59@daenzer.net>
 <7b138de2-70eb-62ef-e61a-8933d77af124@amd.com>
 <915d1570-856e-09ae-63b1-5e3d2b937edc@daenzer.net>
 <MWHPR1201MB0127DE9F4391624C09F625F1FD370@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <8c70faa2-ee3e-296b-5c61-ede3ac6396f0@daenzer.net>
 <MWHPR1201MB0127C74D1BFACE3F93B79640FD010@MWHPR1201MB0127.namprd12.prod.outlook.com>
 <ad59f224-9b6f-c5e3-a932-39a00d3d783f@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ad59f224-9b6f-c5e3-a932-39a00d3d783f-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

R290IGl0LCB0aGFuayB5b3UhDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBN
aWNoZWwgRMOkbnplciBbbWFpbHRvOm1pY2hlbEBkYWVuemVyLm5ldF0gDQpTZW50OiBXZWRuZXNk
YXksIERlY2VtYmVyIDI3LCAyMDE3IDQ6NTggUE0NClRvOiBIZSwgUm9nZXIgPEhvbmdiby5IZUBh
bWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IEdy
b2R6b3Zza3ksIEFuZHJleSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZC9hbWRn
cHU6IHNldCBndHQgc2l6ZSBhY2NvcmRpbmcgdG8gc3lzdGVtIG1lbW9yeSBzaXplIG9ubHkNCg0K
T24gMjAxNy0xMi0yNSAwOTo0NSBBTSwgSGUsIFJvZ2VyIHdyb3RlOg0KPiANCj4gQ291bGQgeW91
IHRlbGwgbWUgaG93IHRvIGR1cGxpY2F0ZSB0aGlzIGlzc3VlPyAgTWF5YmUgbm93IEkgY2FuIGxv
b2sgaW50byBpdC4NCg0KSXQgaGFwcGVuZWQgZm9yIG1lIHJ1bm5pbmcNCg0KIHBpZ2xpdCBydW4g
LXggZ2x4LW11bHRpdGhyZWFkLXRleHR1cmUgLS1wcm9jZXNzLWlzb2xhdGlvbiBmYWxzZSBncHUg
cmVzdWx0cy9ncHUuPGRhdGU+DQoNCnVzaW5nIHRoZSBNZXNhIHJhZGVvbnNpIGRyaXZlciBvbiBU
b25nYSBpbiBhIFJ5emVuIDcgMTcwMCAoOCBjb3JlcywgMTYNCnRocmVhZHMpIHN5c3RlbSB3aXRo
IDE2IEdCIG9mIFJBTS4NCg0KDQotLSANCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAg
ICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20NCkxpYnJlIHNvZnR3YXJl
IGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Bl
cg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
