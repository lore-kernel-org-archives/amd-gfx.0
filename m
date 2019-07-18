From: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 07/87] drm/amd/display: move bw calc code into helpers
Date: Thu, 18 Jul 2019 16:20:09 +0000
Message-ID: <46cd89f7-2671-7f2c-d24e-b8aaac18e2c0@amd.com>
References: <20190715212049.4584-1-sunpeng.li@amd.com>
 <20190715212049.4584-8-sunpeng.li@amd.com>
 <66c6c4d7-34b3-b73b-4e21-f745fff470cd@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <66c6c4d7-34b3-b73b-4e21-f745fff470cd-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
Content-ID: <4C127B440F19944DABE0918607305B08-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
Cc: "Darbehani, Fatemeh" <Fatemeh.Darbehani-5C7GfCeVMHo@public.gmane.org>, "Yang,
 Eric" <Eric.Yang2-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

DQoNCk9uIDIwMTktMDctMTggMTA6NDkgYS5tLiwgTWljaGVsIETDpG56ZXIgd3JvdGU6DQo+IE9u
IDIwMTktMDctMTUgMTE6MTkgcC5tLiwgc3VucGVuZy5saUBhbWQuY29tIHdyb3RlOg0KPj4gRnJv
bTogRXJpYyBZYW5nIDxFcmljLllhbmcyQGFtZC5jb20+DQo+Pg0KPj4gW1doeV0NCj4+IEZvciBi
ZXR0ZXIgcmVhZGFiaWxpdHkgYW5kIHJldXNhYmlsaXR5DQo+Pg0KPj4gW0hvd10NCj4+IE1vdmUg
c25pcHBldHMgb2YgQlcgY2FsY3VsYXRpb24gY29kZSBpbnRvIGhlbHBlcnMuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogRXJpYyBZYW5nIDxFcmljLllhbmcyQGFtZC5jb20+DQo+PiBSZXZpZXdlZC1i
eTogRmF0ZW1laCBEYXJiZWhhbmkgPEZhdGVtZWguRGFyYmVoYW5pQGFtZC5jb20+DQo+PiBBY2tl
ZC1ieTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+DQo+PiAtLS0NCj4+ICBbLi4uXQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNl
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+IGluZGV4
IDA4NmQyZjNiMGRiMy4uZTljY2Y0MWUzMWVlIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+IEBAIC0xMjYsNiArMTI2LDcgQEAgc3RhdGlj
IERFVklDRV9BVFRSKHBjaWVfcmVwbGF5X2NvdW50LCBTX0lSVUdPLA0KPj4gIAkJYW1kZ3B1X2Rl
dmljZV9nZXRfcGNpZV9yZXBsYXlfY291bnQsIE5VTEwpOw0KPj4gIA0KPj4gIHN0YXRpYyB2b2lk
IGFtZGdwdV9kZXZpY2VfZ2V0X3BjaWVfaW5mbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7
DQo+PiArc3RhdGljIHZvaWQgYW1kZ3B1X2RldmljZV9wYXJzZV9mYWtlZF9kaWQoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpOw0KPiANCj4gVGhpcyBmdW5jdGlvbiBpc24ndCBkZWZpbmVkIGFu
eXdoZXJlLCBwcm9kdWNpbmcgYSB3YXJuaW5nOg0KPiANCj4gZHJpdmVycy9ncHUvZHJtLy9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYzoxMzE6MTM6IHdhcm5pbmc6IOKAmGFtZGdwdV9kZXZpY2Vf
cGFyc2VfZmFrZWRfZGlk4oCZIGRlY2xhcmVkIOKAmHN0YXRpY+KAmSBidXQgbmV2ZXIgZGVmaW5l
ZCBbLVd1bnVzZWQtZnVuY3Rpb25dDQo+ICBzdGF0aWMgdm9pZCBhbWRncHVfZGV2aWNlX3BhcnNl
X2Zha2VkX2RpZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7DQo+ICAgICAgICAgICAgICBe
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KDQpPb3BzLCBJIGRvbid0IGtub3cgaG93IHRo
YXQgbWFuYWdlZCB0byBnZXQgaW4gdGhlcmUuIEl0J3Mgbm90IGV2ZW4gaW4NCnRoZSBkaXNwbGF5
IGRpci4uLg0KDQpTZW50IGEgZml4Lg0KDQpMZW8NCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
