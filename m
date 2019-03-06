From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Add sysfs entries for xgmi hive.
Date: Wed, 6 Mar 2019 17:59:12 +0000
Message-ID: <a304f652-213d-b78b-dda0-695dea716aa2@amd.com>
References: <1551808057-26683-1-git-send-email-andrey.grodzovsky@amd.com>
 <b52a95ca-c717-c759-ccfa-559233b8fe9b@amd.com>
 <fd879112-fa02-ad17-bf85-8314670941a8@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <fd879112-fa02-ad17-bf85-8314670941a8-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <57C83698A5194D4DB6F8F6E4225263C5-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhou,
 David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOS0wMy0wNSAyOjE2IHAubS4sIEdyb2R6b3Zza3ksIEFuZHJleSB3cm90ZToNCj4gSW4g
ZWFjaCAvc3lzL2NsYXNzL2RybS9jYXJkWC9kZXZpY2UvIGRldmljZSB5b3Ugd2lsbCBzZWUgdGhl
IGZvbGxvd2luZw0KPiANCj4geGdtaV9kZXZpY2VfaWQgLyogY29udGFpbnMgdGhlIGRldmljZSBp
ZCB3aXRoaW4gdGhlIGhpdmUgKi8NCj4geGdtaV9oaXZlX2luZm8gLT4NCj4gLi4vLi4vLi4vLi4v
MDAwMDowMDowMS4xLzAwMDA6MDI6MDAuMC8wMDAwOjAzOjAwLjAvMDAwMDowNDowMC4wL3hnbWlf
aGl2ZV9pbmZvLw0KPiAvKiBoaXZlIGluZm8gZm9sZGVyICovDQo+IA0KPiBpbnNpZGUgeGdtaV9o
aXZlX2luZm8gYXJlIGJhY2sgcG9pbnRlcnMgdG8gL3N5cy9jbGFzcy9kcm0vY2FyZFgvZGV2aWNl
Lw0KPiBmb3IgZWFjaCBoaXZlIG1lbWJlciAtDQo+IA0KPiBscnd4cnd4cnd4wqAgMSByb290IHJv
b3TCoMKgwqAgMCBNYXLCoCA1IDEyOjI3IG5vZGUxIC0+IC4uLy4uLzAwMDA6MDQ6MDAuMC8NCj4g
bHJ3eHJ3eHJ3eMKgIDEgcm9vdCByb290wqDCoMKgIDAgTWFywqAgNSAxMjoyNyBub2RlMiAtPg0K
PiAuLi8uLi8uLi8uLi8uLi8wMDAwOjAwOjFiLjAvMDAwMDowNTowMC4wLzAwMDA6MDY6MDAuMC8w
MDAwOjA3OjAwLjAvDQo+IA0KPiAtci0tci0tci0twqAgMSByb290IHJvb3QgNDA5NiBNYXLCoCA1
IDEyOjI3IHhnbWlfaGl2ZV9pZCAvKiBjb250YWlucyB0aGUNCj4gaGl2ZSBpZCAqLw0KDQpDb3Vs
ZCBJIGdldCBhbiBzc2ggb24gc3VjaCBhIGJveCB0byB0ZXN0IG91dCB0aGUgdW1yIGNvZGUgKHdo
aWNoIEkgDQpoYXZlbid0IHdyaXR0ZW4geWV0KT8NCg0KVGhhbmtzLA0KVG9tDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
