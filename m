From: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: always consider virualised device for
 checking post
Date: Wed, 18 Oct 2017 09:13:38 +0000
Message-ID: <BLUPR12MB044974CC987AEE95C5912347844D0@BLUPR12MB0449.namprd12.prod.outlook.com>
References: <1508222267-18627-1-git-send-email-Pixel.Ding@amd.com>
 <1508222267-18627-2-git-send-email-Pixel.Ding@amd.com>
 <BLUPR12MB04492724C9C66EF3ABA7C295844C0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <77D84CB4-2676-4DBC-AB49-431923E87EAC@amd.com>
 <BLUPR12MB0449C0C378B70A73A44579CC844C0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <BA0191B9-16C3-43D8-9816-BF77301CE5D5@amd.com>
 <9035FC71-9AB1-406C-9A0B-8B050E51C7F4@amd.com>
 <83AE16CE-43F8-44E7-AEF6-6FA581134C7A@amd.com>,
 <b3d8df4b-38f9-2bc2-3340-782069591058@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1136509541=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b3d8df4b-38f9-2bc2-3340-782069591058-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Ding, Pixel" <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Sun, Gary" <Gary.Sun-5C7GfCeVMHo@public.gmane.org>, "Li, Bingley" <Bingley.Li-5C7GfCeVMHo@public.gmane.org>

--===============1136509541==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BLUPR12MB044974CC987AEE95C5912347844D0BLUPR12MB0449namp_"

--_000_BLUPR12MB044974CC987AEE95C5912347844D0BLUPR12MB0449namp_
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64

eWVhaCwgdGhpcyBwYXRjaCBpcyBjb3JyZWN0DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQpGcm9tOiBLb2VuaWcsIENocmlzdGlhbg0KU2VudDogV2VkbmVzZGF5LCBPY3RvYmVy
IDE4LCAyMDE3IDM6MjM6MDQgUE0NClRvOiBEaW5nLCBQaXhlbDsgTGl1LCBNb25rOyBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFN1biwgR2FyeTsgTGksIEJpbmdsZXkNClN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMS8zXSBkcm0vYW1kZ3B1OiBhbHdheXMgY29uc2lkZXIgdmlydWFsaXNl
ZCBkZXZpY2UgZm9yIGNoZWNraW5nIHBvc3QNCg0KSSd2ZSBhbHJlYWR5IGRpZCwgYnV0IGhvbmVz
dGx5IGhhdmUgbm8gaWRlYSB3aGF0IHlvdSBkbyBoZXJlLg0KDQpBU0lDIHBvc3QgaXMgbm90IHNv
bWV0aGluZyBJJ3ZlIGV2ZXJ5IHdvcmtlZCBvbi4NCg0KSXQgbG9va3Mgb2RkIHRoYXQgeW91IGFk
ZC9yZW1vdmUgc29tZSBzdGF0aWMga2V5d29yZCBoZXJlLCBidXQgSSBjYW4ndA0KanVkZ2UgdGhl
IHRlY2huaWNhbCBjb3JyZWN0bmVzcy4NCg0KTW9uaywgQWxleCB3aGF0IGRvIHlvdSB0aGluayBv
ZiB0aGlzPw0KDQpTb3JyeSwNCkNocmlzdGlhbi4NCg0KQW0gMTguMTAuMjAxNyB1bSAwOToxOSBz
Y2hyaWViIERpbmcsIFBpeGVsOg0KPiBIaSBDaHJpc3RpYW4sDQo+DQo+IFdvdWxkIHlvdSBwbGVh
c2UgdGFrZSBhIGxvb2sgYXQgdGhpcyBjaGFuZ2U/IEl0oaZzIHRvIHVuaWZ5IHRoZSBWQklPUyBw
b3N0IGNoZWNraW5nLg0KPiChWA0KPiBTaW5jZXJlbHkgWW91cnMsDQo+IFBpeGVsDQo+DQo+DQo+
DQo+DQo+DQo+DQo+DQo+DQo+IE9uIDE4LzEwLzIwMTcsIDEwOjI1IEFNLCAiRGluZywgUGl4ZWwi
IDxQaXhlbC5EaW5nQGFtZC5jb20+IHdyb3RlOg0KPg0KPj4gSGkgYWxsLA0KPj4NCj4+IENvdWxk
IHNvbWVvbmUgcmV2aWV3IHRoaXMgcGF0Y2g/DQo+Pg0KPj4goVgNCj4+IFNpbmNlcmVseSBZb3Vy
cywNCj4+IFBpeGVsDQo+Pg0KPj4NCj4+DQo+Pg0KPj4NCj4+DQo+Pg0KPj4gT24gMTcvMTAvMjAx
NywgNDowNiBQTSwgImFtZC1nZnggb24gYmVoYWxmIG9mIERpbmcsIFBpeGVsIiA8YW1kLWdmeC1i
b3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZyBvbiBiZWhhbGYgb2YgUGl4ZWwuRGluZ0BhbWQu
Y29tPiB3cm90ZToNCj4+DQo+Pj4geW91IGNhbiBzZWUgdGhlIGRpZmZlcmVuY2Ugb2YgZnVuY3Rp
b24gYW1kZ3B1X25lZWRfcG9zdC4gR2VuZXJhbGx5IHNwZWFraW5nLCB0aGVyZSB3ZXJlIDIgZnVu
Y3Rpb25zIHRvIGNoZWNrIFZCSU9TIHBvc3RpbmcsIG9uZSBjb25zaWRlcnMgVkYgYW5kIHBhc3N0
aHJ1IHdoaWxlIHRoZSBvdGhlciBkb2VzbqGmdC4gSW4gZmFjdCB3ZSBzaG91bGQgYWx3YXlzIGNv
bnNpZGVyIFZGIGFuZCBQVCBmb3IgY2hlY2tpbmcsIHJpZ2h0PyBGb3IgZXhhbXBsZSwgdGhpcyBj
aGVja2luZyBoZXJlIGJlbGlldmUgVkYgbmVlZHMgYSBwb3N0aW5nIGJlY2F1c2UgU0NSQVRDSCBy
ZWdpc3RlcnMgYXJlIG5vdCB0aGUgZXhwZWN0ZWQgdmFsdWUuIElzIGl0IGNsZWFyPw0KPj4+IKFY
DQo+Pj4gU2luY2VyZWx5IFlvdXJzLA0KPj4+IFBpeGVsDQo+Pj4NCj4+Pg0KPj4+DQo+Pj4NCj4+
Pg0KPj4+DQo+Pj4NCj4+Pg0KPj4+IE9uIDE3LzEwLzIwMTcsIDU6MDAgUE0sICJMaXUsIE1vbmsi
IDxNb25rLkxpdUBhbWQuY29tPiB3cm90ZToNCj4+Pg0KPj4+ID5Gcm9tIHRoZSBwYXRjaCBpdHNl
bGYgSSBzdGlsbCBjb3VsZG4ndCB0ZWxsIHRoZSBkaWZmZXJlbmNlDQo+Pj4+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+Pj4+IEZyb206IERpbmcsIFBpeGVsDQo+Pj4+IFNlbnQ6IDIwMTem
fjEwpOsxN6TpIDE1OjU0DQo+Pj4+IFRvOiBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+OyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlh
bi5Lb2VuaWdAYW1kLmNvbT4NCj4+Pj4gQ2M6IExpLCBCaW5nbGV5IDxCaW5nbGV5LkxpQGFtZC5j
b20+OyBTdW4sIEdhcnkgPEdhcnkuU3VuQGFtZC5jb20+DQo+Pj4+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMS8zXSBkcm0vYW1kZ3B1OiBhbHdheXMgY29uc2lkZXIgdmlydWFsaXNlZCBkZXZpY2UgZm9y
IGNoZWNraW5nIHBvc3QNCj4+Pj4NCj4+Pj4gSXQgZml4ZXMgYSBpc3N1ZSBoaWRkZW4gaW46DQo+
Pj4+DQo+Pj4+IDk1IHN0YXRpYyBib29sIGlncF9yZWFkX2Jpb3NfZnJvbV92cmFtKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQ0KPj4+PiA5NiB7DQo+Pj4+IDk3IHVpbnQ4X3QgX19pb21lbSAq
YmlvczsNCj4+Pj4gOTggcmVzb3VyY2Vfc2l6ZV90IHZyYW1fYmFzZTsNCj4+Pj4gOTkgcmVzb3Vy
Y2Vfc2l6ZV90IHNpemUgPSAyNTYgKiAxMDI0OyAvKiA/Pz8gKi8NCj4+Pj4gMTAwDQo+Pj4+IDEw
MSAgICAgICAgaWYgKCEoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKSkNCj4+Pj4gMTAyICAgICAg
ICAgICAgICAgIGlmIChhbWRncHVfbmVlZF9wb3N0KGFkZXYpKQ0KPj4+PiAxMDMgICAgICAgICAg
ICAgICAgcmV0dXJuIGZhbHNlOw0KPj4+Pg0KPj4+Pg0KPj4+PiBUaGlzIG1ha2VzIGJpb3MgcmVh
ZGluZyBmYWxsYmFjayB0byBTTUMgSU5ERVgvREFUQSByZWdpc3RlciBjYXNlLg0KPj4+Pg0KPj4+
PiChWA0KPj4+PiBTaW5jZXJlbHkgWW91cnMsDQo+Pj4+IFBpeGVsDQo+Pj4+DQo+Pj4+DQo+Pj4+
DQo+Pj4+DQo+Pj4+DQo+Pj4+DQo+Pj4+DQo+Pj4+DQo+Pj4+IE9uIDE3LzEwLzIwMTcsIDM6NDgg
UE0sICJMaXUsIE1vbmsiIDxNb25rLkxpdUBhbWQuY29tPiB3cm90ZToNCj4+Pj4NCj4+Pj4+IEkg
ZG9uJ3QgdW5kZXJzdGFuZCBob3cgdGhpcyBwYXRjaCB3b3Jrcz8/PyBMb29rcyBsaWtlIGp1c3Qg
cmVuYW1lIHZwb3N0X25lZWRlZCB0byBjaGVja19wb3N0DQo+Pj4+Pg0KPj4+Pj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4+IEZyb206IFBpeGVsIERpbmcgW21haWx0bzpQaXhlbC5E
aW5nQGFtZC5jb21dDQo+Pj4+PiBTZW50OiAyMDE3pn4xMKTrMTek6SAxNDozOA0KPj4+Pj4gVG86
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5j
b20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPj4+Pj4g
Q2M6IExpLCBCaW5nbGV5IDxCaW5nbGV5LkxpQGFtZC5jb20+OyBTdW4sIEdhcnkgPEdhcnkuU3Vu
QGFtZC5jb20+OyBEaW5nLCBQaXhlbCA8UGl4ZWwuRGluZ0BhbWQuY29tPg0KPj4+Pj4gU3ViamVj
dDogW1BBVENIIDEvM10gZHJtL2FtZGdwdTogYWx3YXlzIGNvbnNpZGVyIHZpcnVhbGlzZWQgZGV2
aWNlIGZvciBjaGVja2luZyBwb3N0DQo+Pj4+Pg0KPj4+Pj4gRnJvbTogcGRpbmcgPFBpeGVsLkRp
bmdAYW1kLmNvbT4NCj4+Pj4+DQo+Pj4+PiBUaGUgcG9zdCBjaGVja2luZyBvbiBzY3JhdGNoIHJl
Z2lzdGVycyBpc24ndCByZWxpYWJsZSBmb3IgdmlydHVhbCBmdW5jdGlvbi4NCj4+Pj4+DQo+Pj4+
PiBTaWduZWQtb2ZmLWJ5OiBwZGluZyA8UGl4ZWwuRGluZ0BhbWQuY29tPg0KPj4+Pj4gLS0tDQo+
Pj4+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA4ICsrKyst
LS0tDQo+Pj4+PiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNl
LmMNCj4+Pj4+IGluZGV4IDY4Mzk2NWIuLmFiOGYwZDYgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+Pj4+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPj4+Pj4gQEAgLTY2OSw3ICs2
NjksNyBAQCB2b2lkIGFtZGdwdV9nYXJ0X2xvY2F0aW9uKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LCBzdHJ1Y3QgYW1kZ3B1X21jICptYykNCj4+Pj4+ICAgKiBvciBwb3N0IGlzIG5lZWRlZCBp
ZiAgaHcgcmVzZXQgaXMgcGVyZm9ybWVkLg0KPj4+Pj4gICAqIFJldHVybnMgdHJ1ZSBpZiBuZWVk
IG9yIGZhbHNlIGlmIG5vdC4NCj4+Pj4+ICAgKi8NCj4+Pj4+IC1ib29sIGFtZGdwdV9uZWVkX3Bv
c3Qoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+Pj4+PiArc3RhdGljIGJvb2wgYW1kZ3B1
X2NoZWNrX3Bvc3Qoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+Pj4+PiB7DQo+Pj4+PiAg
ICB1aW50MzJfdCByZWc7DQo+Pj4+Pg0KPj4+Pj4gQEAgLTY5Miw3ICs2OTIsNyBAQCBib29sIGFt
ZGdwdV9uZWVkX3Bvc3Qoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+Pj4+Pg0KPj4+Pj4g
fQ0KPj4+Pj4NCj4+Pj4+IC1zdGF0aWMgYm9vbCBhbWRncHVfdnBvc3RfbmVlZGVkKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQ0KPj4+Pj4gK2Jvb2wgYW1kZ3B1X25lZWRfcG9zdChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikNCj4+Pj4+IHsNCj4+Pj4+ICAgIGlmIChhbWRncHVfc3Jpb3Zf
dmYoYWRldikpDQo+Pj4+PiAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+Pj4+IEBAIC03MTYs
NyArNzE2LDcgQEAgc3RhdGljIGJvb2wgYW1kZ3B1X3Zwb3N0X25lZWRlZChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikNCj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiB0
cnVlOw0KPj4+Pj4gICAgICAgICAgICB9DQo+Pj4+PiAgICB9DQo+Pj4+PiAtIHJldHVybiBhbWRn
cHVfbmVlZF9wb3N0KGFkZXYpOw0KPj4+Pj4gKyByZXR1cm4gYW1kZ3B1X2NoZWNrX3Bvc3QoYWRl
dik7DQo+Pj4+PiB9DQo+Pj4+Pg0KPj4+Pj4gLyoqDQo+Pj4+PiBAQCAtMjIwOCw3ICsyMjA4LDcg
QEAgaW50IGFtZGdwdV9kZXZpY2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4+
Pj4+ICAgIGFtZGdwdV9kZXZpY2VfZGV0ZWN0X3NyaW92X2Jpb3MoYWRldik7DQo+Pj4+Pg0KPj4+
Pj4gICAgLyogUG9zdCBjYXJkIGlmIG5lY2Vzc2FyeSAqLw0KPj4+Pj4gLSBpZiAoYW1kZ3B1X3Zw
b3N0X25lZWRlZChhZGV2KSkgew0KPj4+Pj4gKyBpZiAoYW1kZ3B1X25lZWRfcG9zdChhZGV2KSkg
ew0KPj4+Pj4gICAgICAgICAgICBpZiAoIWFkZXYtPmJpb3MpIHsNCj4+Pj4+ICAgICAgICAgICAg
ICAgICAgICBkZXZfZXJyKGFkZXYtPmRldiwgIm5vIHZCSU9TIGZvdW5kXG4iKTsNCj4+Pj4+ICAg
ICAgICAgICAgICAgICAgICBhbWRncHVfdmZfZXJyb3JfcHV0KEFNREdJTV9FUlJPUl9WRl9OT19W
QklPUywgMCwgMCk7DQo+Pj4+PiAtLQ0KPj4+Pj4gMi45LjUNCj4+Pj4+DQo+Pj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+PiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdA0KPj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+Pj4gaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQoNCg0K

--_000_BLUPR12MB044974CC987AEE95C5912347844D0BLUPR12MB0449namp_
Content-Type: text/html; charset="big5"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dbig5">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p>yeah, this patch is correct <br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Koenig, Christian<b=
r>
<b>Sent:</b> Wednesday, October 18, 2017 3:23:04 PM<br>
<b>To:</b> Ding, Pixel; Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Sun, Gary; Li, Bingley<br>
<b>Subject:</b> Re: [PATCH 1/3] drm/amdgpu: always consider virualised devi=
ce for checking post</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">I've already did, but honestly have no idea what y=
ou do here.<br>
<br>
ASIC post is not something I've every worked on.<br>
<br>
It looks odd that you add/remove some static keyword here, but I can't <br>
judge the technical correctness.<br>
<br>
Monk, Alex what do you think of this?<br>
<br>
Sorry,<br>
Christian.<br>
<br>
Am 18.10.2017 um 09:19 schrieb Ding, Pixel:<br>
&gt; Hi Christian,<br>
&gt;<br>
&gt; Would you please take a look at this change? It=A1=A6s to unify the VB=
IOS post checking.<br>
&gt; =A1X<br>
&gt; Sincerely Yours,<br>
&gt; Pixel<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On 18/10/2017, 10:25 AM, &quot;Ding, Pixel&quot; &lt;Pixel.Ding-urvtwAKJhsc@public.gmane.org=
m&gt; wrote:<br>
&gt;<br>
&gt;&gt; Hi all,<br>
&gt;&gt;<br>
&gt;&gt; Could someone review this patch?<br>
&gt;&gt;<br>
&gt;&gt; =A1X<br>
&gt;&gt; Sincerely Yours,<br>
&gt;&gt; Pixel<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On 17/10/2017, 4:06 PM, &quot;amd-gfx on behalf of Ding, Pixel&quo=
t; &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org on behalf of Pixel.Ding-urvtwAKJhsc@public.gmane.org=
m&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;&gt; you can see the difference of function amdgpu_need_post. Gener=
ally speaking, there were 2 functions to check VBIOS posting, one considers=
 VF and passthru while the other doesn=A1=A6t. In fact we should always con=
sider VF and PT for checking, right? For example,
 this checking here believe VF needs a posting because SCRATCH registers ar=
e not the expected value. Is it clear?<br>
&gt;&gt;&gt; =A1X<br>
&gt;&gt;&gt; Sincerely Yours,<br>
&gt;&gt;&gt; Pixel<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 17/10/2017, 5:00 PM, &quot;Liu, Monk&quot; &lt;Monk.Liu@amd=
.com&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;From the patch itself I still couldn't tell the difference=
 <br>
&gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt;&gt;&gt;&gt; From: Ding, Pixel<br>
&gt;&gt;&gt;&gt; Sent: 2017=A6~10=A4=EB17=A4=E9 15:54<br>
&gt;&gt;&gt;&gt; To: Liu, Monk &lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32mptlylMvRsHA@public.gmane.org=
desktop.org; Koenig, Christian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;&gt;&gt; Cc: Li, Bingley &lt;Bingley.Li-5C7GfCeVMHo@public.gmane.org&gt;; Sun, Gary &lt;=
Gary.Sun-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;&gt;&gt; Subject: Re: [PATCH 1/3] drm/amdgpu: always consider virua=
lised device for checking post<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; It fixes a issue hidden in:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; 95 static bool igp_read_bios_from_vram(struct amdgpu_devic=
e *adev)<br>
&gt;&gt;&gt;&gt; 96 {<br>
&gt;&gt;&gt;&gt; 97 uint8_t __iomem *bios;<br>
&gt;&gt;&gt;&gt; 98 resource_size_t vram_base;<br>
&gt;&gt;&gt;&gt; 99 resource_size_t size =3D 256 * 1024; /* ??? */<br>
&gt;&gt;&gt;&gt; 100<br>
&gt;&gt;&gt;&gt; 101&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&=
gt;flags &amp; AMD_IS_APU))<br>
&gt;&gt;&gt;&gt; 102&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_need_post(adev))<br>
&gt;&gt;&gt;&gt; 103&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; This makes bios reading fallback to SMC INDEX/DATA registe=
r case.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =A1X<br>
&gt;&gt;&gt;&gt; Sincerely Yours,<br>
&gt;&gt;&gt;&gt; Pixel<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On 17/10/2017, 3:48 PM, &quot;Liu, Monk&quot; &lt;Monk.Liu=
@amd.com&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I don't understand how this patch works??? Looks like =
just rename vpost_needed to check_post<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt;&gt;&gt;&gt;&gt; From: Pixel Ding [<a href=3D"mailto:Pixel.Ding-5C7GfCeVMHo@public.gmane.org=
">mailto:Pixel.Ding-5C7GfCeVMHo@public.gmane.org</a>]<br>
&gt;&gt;&gt;&gt;&gt; Sent: 2017=A6~10=A4=EB17=A4=E9 14:38<br>
&gt;&gt;&gt;&gt;&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Liu, Monk &lt;Monk.=
Liu-5C7GfCeVMHo@public.gmane.org&gt;; Koenig, Christian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;&gt;&gt;&gt; Cc: Li, Bingley &lt;Bingley.Li-5C7GfCeVMHo@public.gmane.org&gt;; Sun, Gary =
&lt;Gary.Sun-5C7GfCeVMHo@public.gmane.org&gt;; Ding, Pixel &lt;Pixel.Ding-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;&gt;&gt;&gt; Subject: [PATCH 1/3] drm/amdgpu: always consider virua=
lised device for checking post<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; From: pding &lt;Pixel.Ding-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; The post checking on scratch registers isn't reliable =
for virtual function.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Signed-off-by: pding &lt;Pixel.Ding-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 &#43;&#=
43;&#43;&#43;----<br>
&gt;&gt;&gt;&gt;&gt; 1 file changed, 4 insertions(&#43;), 4 deletions(-)<br=
>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.=
c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt;&gt;&gt;&gt; index 683965b..ab8f0d6 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_de=
vice.c<br>
&gt;&gt;&gt;&gt;&gt; @@ -669,7 &#43;669,7 @@ void amdgpu_gart_location(stru=
ct amdgpu_device *adev, struct amdgpu_mc *mc)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; * or post is needed if&nbsp; hw reset is p=
erformed.<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; * Returns true if need or false if not.<br=
>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt;&gt; -bool amdgpu_need_post(struct amdgpu_device *adev)<br>
&gt;&gt;&gt;&gt;&gt; &#43;static bool amdgpu_check_post(struct amdgpu_devic=
e *adev)<br>
&gt;&gt;&gt;&gt;&gt; {<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; @@ -692,7 &#43;692,7 @@ bool amdgpu_need_post(struct a=
mdgpu_device *adev)<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -static bool amdgpu_vpost_needed(struct amdgpu_device =
*adev)<br>
&gt;&gt;&gt;&gt;&gt; &#43;bool amdgpu_need_post(struct amdgpu_device *adev)=
<br>
&gt;&gt;&gt;&gt;&gt; {<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; return false;<br>
&gt;&gt;&gt;&gt;&gt; @@ -716,7 &#43;716,7 @@ static bool amdgpu_vpost_neede=
d(struct amdgpu_device *adev)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; - return amdgpu_need_post(adev);<br>
&gt;&gt;&gt;&gt;&gt; &#43; return amdgpu_check_post(adev);<br>
&gt;&gt;&gt;&gt;&gt; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; /**<br>
&gt;&gt;&gt;&gt;&gt; @@ -2208,7 &#43;2208,7 @@ int amdgpu_device_init(struc=
t amdgpu_device *adev,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; amdgpu_device_detect_sriov_bios(adev=
);<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; /* Post card if necessary */<br>
&gt;&gt;&gt;&gt;&gt; - if (amdgpu_vpost_needed(adev)) {<br>
&gt;&gt;&gt;&gt;&gt; &#43; if (amdgpu_need_post(adev)) {<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; if (!adev-&gt;bios) {<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&g=
t;dev, &quot;no vBIOS found\n&quot;);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vf_error=
_put(AMDGIM_ERROR_VF_NO_VBIOS, 0, 0);<br>
&gt;&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt;&gt; 2.9.5<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt; amd-gfx mailing list<br>
&gt;&gt;&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_BLUPR12MB044974CC987AEE95C5912347844D0BLUPR12MB0449namp_--

--===============1136509541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1136509541==--
