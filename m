From: Harry Wentland <hwentlan@amd.com>
Subject: Re: [PATCH -next] drm/amdgpu/display: fix build error without
 CONFIG_DRM_AMD_DC_DSC_SUPPORT
Date: Mon, 26 Aug 2019 13:22:08 +0000
Message-ID: <c324866d-855a-b259-4511-c69491a82c88@amd.com>
References: <20190826085707.12504-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190826085707.12504-1-yuehaibing@huawei.com>
Content-Language: en-US
Content-ID: <6A5CA012EB161B4E94AFA974BBD924A7@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "airlied@linux.ie" <airlied@linux.ie>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "Lei, Jun" <Jun.Lei@amd.com>, "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>, "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Aberback, Joshua" <Joshua.Aberback@amd.com>, "Liu, Wenjing" <Wenjing.Liu@amd.com>, "Liu, Charlene" <Charlene.Liu@amd.com>, "Leung, Martin" <Martin.Leung@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

DQoNCk9uIDIwMTktMDgtMjYgNDo1NyBhLm0uLCBZdWVIYWliaW5nIHdyb3RlOg0KPiBJZiBDT05G
SUdfRFJNX0FNRF9EQ19EU0NfU1VQUE9SVCBpcyBub3Qgc2V0LCBidWlsZCBmYWlsczoNCj4gDQo+
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdz
ZXEuYzogSW4gZnVuY3Rpb24gZGNuMjBfaHdfc2VxdWVuY2VyX2NvbnN0cnVjdDoNCj4gZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jOjIw
OTk6Mjg6DQo+ICBlcnJvcjogZGNuMjBfZHNjX3BnX2NvbnRyb2wgdW5kZWNsYXJlZCAoZmlyc3Qg
dXNlIGluIHRoaXMgZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4gZGNuMjBfZHBwX3BnX2NvbnRyb2w/
DQo+ICAgZGMtPmh3c3MuZHNjX3BnX2NvbnRyb2wgPSBkY24yMF9kc2NfcGdfY29udHJvbDsNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBkY24yMF9kcHBfcGdfY29udHJvbA0KPiANCj4gVXNlIENP
TkZJR19EUk1fQU1EX0RDX0RTQ19TVVBQT1JUIHRvIGd1YXJkIHRoaXMuDQo+IA0KPiBSZXBvcnRl
ZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5jb20+DQo+IEZpeGVzOiA4YTMxODIwYjEy
MTggKCJkcm0vYW1kL2Rpc3BsYXk6IE1ha2UgaW5pdF9odyBhbmQgaW5pdF9waXBlcyBnZW5lcmlj
IGZvciBzZWFtbGVzcyBib290IikNCj4gU2lnbmVkLW9mZi1ieTogWXVlSGFpYmluZyA8eXVlaGFp
YmluZ0BodWF3ZWkuY29tPg0KDQpSZXZpZXdlZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5Lndl
bnRsYW5kQGFtZC5jb20+DQoNCkhhcnJ5DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYyB8IDQgKysrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjbjIwL2RjbjIwX2h3c2VxLmMNCj4gaW5kZXggZTE0NmQxZC4uNTRkNjdmNiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIw
X2h3c2VxLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2Rj
bjIwX2h3c2VxLmMNCj4gQEAgLTIwOTIsNyArMjA5MiwxMSBAQCB2b2lkIGRjbjIwX2h3X3NlcXVl
bmNlcl9jb25zdHJ1Y3Qoc3RydWN0IGRjICpkYykNCj4gIAlkYy0+aHdzcy5lbmFibGVfcG93ZXJf
Z2F0aW5nX3BsYW5lID0gZGNuMjBfZW5hYmxlX3Bvd2VyX2dhdGluZ19wbGFuZTsNCj4gIAlkYy0+
aHdzcy5kcHBfcGdfY29udHJvbCA9IGRjbjIwX2RwcF9wZ19jb250cm9sOw0KPiAgCWRjLT5od3Nz
Lmh1YnBfcGdfY29udHJvbCA9IGRjbjIwX2h1YnBfcGdfY29udHJvbDsNCj4gKyNpZmRlZiBDT05G
SUdfRFJNX0FNRF9EQ19EU0NfU1VQUE9SVA0KPiAgCWRjLT5od3NzLmRzY19wZ19jb250cm9sID0g
ZGNuMjBfZHNjX3BnX2NvbnRyb2w7DQo+ICsjZWxzZQ0KPiArCWRjLT5od3NzLmRzY19wZ19jb250
cm9sID0gTlVMTDsNCj4gKyNlbmRpZg0KPiAgCWRjLT5od3NzLmRpc2FibGVfdmdhID0gZGNuMjBf
ZGlzYWJsZV92Z2E7DQo+ICANCj4gIAlpZiAoSVNfRlBHQV9NQVhJTVVTX0RDKGRjLT5jdHgtPmRj
ZV9lbnZpcm9ubWVudCkpIHsNCj4gDQo=
