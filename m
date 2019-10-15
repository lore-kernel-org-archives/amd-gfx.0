From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Subject: Re: [PATCH] drm/amdgpu/display: fix build error casused by
 CONFIG_DRM_AMD_DC_DCN2_1
Date: Tue, 15 Oct 2019 16:58:00 +0000
Message-ID: <545dfe83-b122-4733-f751-3655d7d56ba8@amd.com>
References: <20191015165117.31195-1-hersenxs.wu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191015165117.31195-1-hersenxs.wu@amd.com>
Content-Language: en-US
Content-ID: <5B40C21C1B80114F9B9720762E62F30C@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Wu, Hersen" <hersenxs.wu@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

UmV2aWV3ZWQtYnk6IEJoYXdhbnByZWV0IExha2hhIDxCaGF3YW5wcmVldC5MYWtoYUBhbWQuY29t
Pg0KDQpPbiAyMDE5LTEwLTE1IDEyOjUxIHAubS4sIEhlcnNlbiBXdSB3cm90ZToNCj4gd2hlbiBD
T05GSUdfRFJNX0FNRF9EQ19EQ04yXzEgaXMgbm90IGVuYWJsZSBpbiAuY29uZmlnLA0KPiB0aGVy
ZSBpcyBidWlsZCBlcnJvci4gc3RydWN0IGRwbV9jbG9ja3Mgc2hvdWQgbm90IGJlDQo+IGd1YXJk
ZWQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEhlcnNlbiBXdSA8aGVyc2VueHMud3VAYW1kLmNvbT4N
Cj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtX3BwX3NtdS5oIHwg
MyAtLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbV9wcF9zbXUuaCBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbV9wcF9zbXUuaA0KPiBpbmRleCAyNGQ2NWRiYmQ3NDku
LmVmN2RmOWVmNmQ3ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RtX3BwX3NtdS5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
bV9wcF9zbXUuaA0KPiBAQCAtMjQ5LDggKzI0OSw2IEBAIHN0cnVjdCBwcF9zbXVfZnVuY3NfbnYg
ew0KPiAgIH07DQo+ICAgI2VuZGlmDQo+ICAgDQo+IC0jaWYgZGVmaW5lZChDT05GSUdfRFJNX0FN
RF9EQ19EQ04yXzEpDQo+IC0NCj4gICAjZGVmaW5lIFBQX1NNVV9OVU1fU09DQ0xLX0RQTV9MRVZF
TFMgIDgNCj4gICAjZGVmaW5lIFBQX1NNVV9OVU1fRENGQ0xLX0RQTV9MRVZFTFMgIDgNCj4gICAj
ZGVmaW5lIFBQX1NNVV9OVU1fRkNMS19EUE1fTEVWRUxTICAgIDQNCj4gQEAgLTI4OCw3ICsyODYs
NiBAQCBzdHJ1Y3QgcHBfc211X2Z1bmNzX3JuIHsNCj4gICAJZW51bSBwcF9zbXVfc3RhdHVzICgq
Z2V0X2RwbV9jbG9ja190YWJsZSkgKHN0cnVjdCBwcF9zbXUgKnBwLA0KPiAgIAkJCXN0cnVjdCBk
cG1fY2xvY2tzICpjbG9ja190YWJsZSk7DQo+ICAgfTsNCj4gLSNlbmRpZg0KPiAgIA0KPiAgIHN0
cnVjdCBwcF9zbXVfZnVuY3Mgew0KPiAgIAlzdHJ1Y3QgcHBfc211IGN0eDsNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxp
c3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
