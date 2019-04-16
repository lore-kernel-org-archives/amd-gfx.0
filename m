From: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Expose support for DRM_FORMAT_RGB565
Date: Tue, 16 Apr 2019 13:28:22 +0000
Message-ID: <443f6bcf-4fa6-fc84-2b73-a0d5b647ef6e@amd.com>
References: <20190415142750.22444-1-nicholas.kazlauskas@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190415142750.22444-1-nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <156F6AADE13FC4439F7BF2B764492799-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOS0wNC0xNSAxMDoyNyBhLm0uLCBOaWNob2xhcyBLYXpsYXVza2FzIHdyb3RlOg0KPiBE
QyBhbmQgRE0gYWxyZWFkeSBzdXBwb3J0IERSTV9GT1JNQVRfUkdCNTY1LCBpdCdzIGp1c3QgbWlz
c2luZyBmcm9tIHRoZQ0KPiBsaXN0IG9mIHZhbGlkIGZvcm1hdHMuDQo+IA0KPiBDYzogSGFycnkg
V2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+DQo+IENjOiBMZW8gTGkgPHN1bnBlbmcu
bGlAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9s
YXMua2F6bGF1c2thc0BhbWQuY29tPg0KDQpSZXZpZXdlZC1ieTogSGFycnkgV2VudGxhbmQgPGhh
cnJ5LndlbnRsYW5kQGFtZC5jb20+DQoNCkhhcnJ5DQoNCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDEgKw0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQo+IGluZGV4IDQ0YThiZjhlYWQ3OS4uYTVj
YWNmODQ2ZTFiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1k
Z3B1X2RtL2FtZGdwdV9kbS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9h
bWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4gQEAgLTQyNzQsNiArNDI3NCw3IEBAIHN0YXRpYyBjb25z
dCB1aW50MzJfdCByZ2JfZm9ybWF0c1tdID0gew0KPiAgIAlEUk1fRk9STUFUX0FCR1IyMTAxMDEw
LA0KPiAgIAlEUk1fRk9STUFUX1hCR1I4ODg4LA0KPiAgIAlEUk1fRk9STUFUX0FCR1I4ODg4LA0K
PiArCURSTV9GT1JNQVRfUkdCNTY1LA0KPiAgIH07DQo+ICAgDQo+ICAgc3RhdGljIGNvbnN0IHVp
bnQzMl90IG92ZXJsYXlfZm9ybWF0c1tdID0gew0KPiANCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
