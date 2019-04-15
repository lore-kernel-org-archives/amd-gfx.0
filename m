From: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Expose support for DRM_FORMAT_RGB565
Date: Mon, 15 Apr 2019 15:18:15 +0000
Message-ID: <a6a1ef58-cba4-5641-63c8-e197aad9e558@amd.com>
References: <20190415142750.22444-1-nicholas.kazlauskas@amd.com>
 <f8d073c8-ebd7-aa83-2b70-894460c6b46a@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f8d073c8-ebd7-aa83-2b70-894460c6b46a-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
Content-ID: <093B94AAC1A5A44AB6C79EABCDD7C59E-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gNC8xNS8xOSAxMToxMSBBTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6DQo+IE9uIDIwMTktMDQt
MTUgNDoyNyBwLm0uLCBOaWNob2xhcyBLYXpsYXVza2FzIHdyb3RlOg0KPj4gREMgYW5kIERNIGFs
cmVhZHkgc3VwcG9ydCBEUk1fRk9STUFUX1JHQjU2NSwgaXQncyBqdXN0IG1pc3NpbmcgZnJvbSB0
aGUNCj4+IGxpc3Qgb2YgdmFsaWQgZm9ybWF0cy4NCj4+DQo+PiBDYzogSGFycnkgV2VudGxhbmQg
PGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+DQo+PiBDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5j
b20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBOaWNob2xhcyBLYXpsYXVza2FzIDxuaWNob2xhcy5rYXps
YXVza2FzQGFtZC5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDEgKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmMNCj4+IGluZGV4IDQ0YThiZjhlYWQ3OS4uYTVjYWNmODQ2ZTFiIDEw
MDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRn
cHVfZG0uYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG0uYw0KPj4gQEAgLTQyNzQsNiArNDI3NCw3IEBAIHN0YXRpYyBjb25zdCB1aW50MzJf
dCByZ2JfZm9ybWF0c1tdID0gew0KPj4gICAJRFJNX0ZPUk1BVF9BQkdSMjEwMTAxMCwNCj4+ICAg
CURSTV9GT1JNQVRfWEJHUjg4ODgsDQo+PiAgIAlEUk1fRk9STUFUX0FCR1I4ODg4LA0KPj4gKwlE
Uk1fRk9STUFUX1JHQjU2NSwNCj4+ICAgfTsNCj4+ICAgDQo+PiAgIHN0YXRpYyBjb25zdCB1aW50
MzJfdCBvdmVybGF5X2Zvcm1hdHNbXSA9IHsNCj4+DQo+IA0KPiBDb3VsZCBEUk1fRk9STUFUX0FS
R0IxNTU1IC8gRFJNX0ZPUk1BVF9DOCBiZSBzdXBwb3J0ZWQgYXMgd2VsbD8NCj4gDQo+IA0KDQpJ
IHRoaW5rIERSTV9GT1JNQVRfQVJHQjE1NTUgbWlnaHQgYWxzbyBiZSBmaW5lIHRvIGFkZCAodGhv
dWdoIEkgaGF2ZW4ndCANCnRlc3RlZCBpdCkuDQoNCkRDIGRvZXNuJ3QgaGF2ZSB0aGUgcmlnaHQg
c3VwcG9ydCBmb3IgQzggaG93ZXZlci4NCg0KTmljaG9sYXMgS2F6bGF1c2thcw0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
