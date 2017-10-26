From: "S, Shirish" <Shirish.S@amd.com>
Subject: RE: [PATCH] drm/amd/display: assign fb_location only if bo is pinned
Date: Thu, 26 Oct 2017 10:51:32 +0000
Message-ID: <BN6PR12MB1826ED2DC27DC8F2D422345BF2450@BN6PR12MB1826.namprd12.prod.outlook.com>
References: <1508852848-17713-1-git-send-email-shirish.s12@gmail.com>
 <BN6PR12MB18268EA378DD476F38B2FED7F2470@BN6PR12MB1826.namprd12.prod.outlook.com>
 <44152644-4a1f-23b5-3b3a-81fc9bb90007@amd.com>
 <59f795cf-f25c-2b7b-9775-0f685131d7d8@amd.com>
 <41ca6c61-1ade-8bf3-cc45-c1adf8606976@amd.com>
 <21693e67-aa36-a4a9-12ac-18e6c5a32e63@daenzer.net>
 <1c36babd-69ee-e701-d857-c6eb8ebab2c3@amd.com>
 <efda8b1f-763c-939a-a1e6-5dd1ad5d3e81@daenzer.net>
 <3437290b-97c3-9c2a-a800-45321c10e0f3@amd.com>
 <d41c9d08-000d-44f4-43d5-e4cda19bc728@amd.com>
 <c270f341-c59b-7f56-eb1a-94c765673b89@daenzer.net>
 <BN6PR12MB182689AA79CD6FA9AF0E2B51F2440@BN6PR12MB1826.namprd12.prod.outlook.com>
 <328522dd-6f96-60bb-58ad-e91103dd6aef@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <328522dd-6f96-60bb-58ad-e91103dd6aef@daenzer.net>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

DQpJIGhhdmUgcmV2ZXJ0ZWQgDQpbUEFUQ0ggMi8yXSBkcm0vYW1kL2Rpc3BsYXk6IGNsZWFudXAg
YWRkUmVxIGFuZCBmaXggZmJfbG9jYXRpb24NCmFuZCBhcHBsaWVkIA0KW1BBVENIXSBkcm0vYW1k
L2Rpc3BsYXk6IGZpeCBoaWdoIHBhcnQgYWRkcmVzcyBpbiBkbV9wbGFuZV9oZWxwZXJfcHJlcGFy
ZV9mYigpDQpvbnRvIGFtZC1kcm0tc3RhZ2luZyBrZXJuZWwuDQoNCg0KUmVnYXJkcywNClNoaXJp
c2ggUw0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNaWNoZWwgRMOkbnpl
ciBbbWFpbHRvOm1pY2hlbEBkYWVuemVyLm5ldF0gDQpTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIg
MjUsIDIwMTcgMzo1NCBQTQ0KVG86IFMsIFNoaXJpc2ggPFNoaXJpc2guU0BhbWQuY29tPjsgR3Jv
ZHpvdnNreSwgQW5kcmV5IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPg0KQ2M6IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IGRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc7IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBS
ZTogW1BBVENIXSBkcm0vYW1kL2Rpc3BsYXk6IGFzc2lnbiBmYl9sb2NhdGlvbiBvbmx5IGlmIGJv
IGlzIHBpbm5lZA0KDQpPbiAyNS8xMC8xNyAxMjowNSBQTSwgUywgU2hpcmlzaCB3cm90ZToNCj4g
SGkgQWxleCwgTWljaGVsICYgQW5kcmV5LA0KPiANCj4gIFtQQVRDSF0gZHJtL2FtZC9kaXNwbGF5
OiBhc3NpZ24gZmJfbG9jYXRpb24gb25seSBpZiBibyBpcyBwaW5uZWQgIA0KPiBbUEFUQ0ggMi8y
XSBkcm0vYW1kL2Rpc3BsYXk6IGNsZWFudXAgYWRkUmVxIGFuZCBmaXggZmJfbG9jYXRpb24NCj4g
DQo+IHNob3VsZCBiZSBkcm9wcGVkIGFuZCBpbnN0ZWFkOg0KDQpTaW5jZSB5b3UgcHVzaGVkIHRo
ZSBsYXR0ZXIgdG8gYW1kLXN0YWdpbmctZHJtLW5leHQsIHBsZWFzZSByZXZlcnQgaXQgdGhlcmUs
IG9yIG1heWJlIHN1Ym1pdCBhbm90aGVyIHBhdGNoIHJlbW92aW5nIGFsbCBmYl9sb2NhdGlvbiBy
ZWxhdGVkIGNvZGUgZnJvbSBnZXRfZmJfaW5mbyBhbmQgZmlsbF9wbGFuZV9hdHRyaWJ1dGVzX2Zy
b21fZmIuDQoNCg0KPiBbUEFUQ0hdIGRybS9hbWQvZGlzcGxheTogZml4IGhpZ2ggcGFydCBhZGRy
ZXNzIGluIA0KPiBkbV9wbGFuZV9oZWxwZXJfcHJlcGFyZV9mYigpDQo+IA0KPiBzaG91bGQgYmUg
cmV2aWV3ZWQgLg0KDQpSZXZpZXdlZC1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVy
QGFtZC5jb20+DQoNCkJ1dCBwbGVhc2Ugd2FpdCBmb3IgcmV2aWV3IGZyb20gREMgZm9sa3MuDQoN
Cg0KLS0gDQpFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAg
ICAgICAgaHR0cDovL3d3dy5hbWQuY29tDQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAg
ICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXINCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QK
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
