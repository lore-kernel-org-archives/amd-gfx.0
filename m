From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amd/display: Use msleep instead of udelay for 8ms wait
Date: Tue, 25 Jun 2019 14:26:54 +0000
Message-ID: <e4dafd8a-8d14-63cb-f793-4d784051d2a0@amd.com>
References: <CAPM=9txaQ43GwOzXSE3prTRLbMt+ip=s_ssmFzWsfsTYdLssaw@mail.gmail.com>
 <20190625140046.31682-1-harry.wentland@amd.com>
 <1561471935.2587.11.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1561471935.2587.11.camel@pengutronix.de>
Content-Language: en-US
Content-ID: <8F90D05C997421459DAEF498451C0EF2@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Lucas Stach <l.stach@pengutronix.de>, "Wentland, Harry" <Harry.Wentland@amd.com>, "airlied@gmail.com" <airlied@gmail.com>, "natechancellor@gmail.com" <natechancellor@gmail.com>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Lei, Jun" <Jun.Lei@amd.com>, "Koo,
 Anthony" <Anthony.Koo@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

QW0gMjUuMDYuMTkgdW0gMTY6MTIgc2NocmllYiBMdWNhcyBTdGFjaDoNCj4gSGkgSGFycnksDQo+
DQo+IEFtIERpZW5zdGFnLCBkZW4gMjUuMDYuMjAxOSwgMTA6MDAgLTA0MDAgc2NocmllYiBIYXJy
eSBXZW50bGFuZDoNCj4+IGFybTMyJ3MgdWRlbGF5IG9ubHkgYWxsb3dzIHZhbHVlcyB1cCB0byAy
MDAwIG1pY3Jvc2Vjb25kcy4gbXNsZWVwDQo+PiBkb2VzIHRoZSB0cmljayBmb3IgdXMgaGVyZSBh
cyB0aGVyZSBpcyBubyBwcm9ibGVtIGlmIHRoaXMgaXNuJ3QNCj4+IG1pY3Jvc2Vjb25kIGFjY3Vy
YXRlIGFuZCB0YWtlcyBhIHRhZCBsb25nZXIuDQo+IEEgInRhZCIgbG9uZ2VyIGluIHRoaXMgY2Fz
ZSBtZWFucyBsaWtlbHkgZG91YmxlIHRoZSBpbnRlbmRlZCB3YWl0Lg0KPiBQbGVhc2Ugc2VlICJT
TEVFUElORyBGT1IgflVTRUNTIE9SIFNNQUxMIE1TRUNTICggMTB1cyAtIDIwbXMpIiBpbg0KPiBE
b2N1bWVudGF0aW9uL3RpbWVycy90aW1lcnMtaG93dG8udHh0Lg0KDQpPaCwgdGhhbmtzIHNvIG11
Y2ggZm9yIHRoZSBsaW5rISBJIHdhcyBzZWFyY2hpbmcgZGVzcGVyYXRlbHkgZm9yIHRoaXMgDQp0
aGUgbGFzdCB0aW1lIHRoaXMgY2FtZSB1cCBhbmQgY291bGRuJ3QgZmluZCBpdC4NCg0KQ2xlYXJs
eSBnb2luZyB0byByZW1lbWJlciBub3cgd2hlcmUgdG8gZmluZCB0aGF0Lg0KDQpUaGFua3MsDQpD
aHJpc3RpYW4uDQoNCj4NCj4gVGhlIHNsZWVwIGhlcmUgc2hvdWxkIHVzZSB1c2xlZXBfcmFuZ2Uu
IEluIGdlbmVyYWwgdGhlIERDIGNvZGUgc2VlbXMgdG8NCj4gdXNlIHF1aXRlIGEgbG90IG9mIHRo
ZSB1ZGVsYXkgYnVzeSB3YWl0cy4gSSBkb3VidCB0aGF0IG1hbnkgb2YgdGhvc2UNCj4gb2NjdXJy
ZW5jZXMgYXJlIGluIGF0b21pYyBjb250ZXh0LCBzbyBjb3VsZCBlYXNpbHkgdXNlIGEgc2xlZXBp
bmcgd2FpdC4NCj4NCj4gRGlnZ2luZyBmdXJ0aGVyIHRoaXMgc2VlbXMgdG8gYXBwbHkgYWNyb3Nz
IGFtZGdwdSwgbm90IG9ubHkgREMuDQo+DQo+IFJlZ2FyZHMsDQo+IEx1Y2FzDQo+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4NCj4+IC0t
LQ0KPj4gIMKgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jIHwg
MiArLQ0KPj4gIMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3Jl
L2RjX2xpbmsuYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19s
aW5rLmMNCj4+IGluZGV4IDRjMzE5MzBmMWNkZi4uZjVkMDJmODliM2Y5IDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jDQo+PiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMNCj4+IEBAIC01
NDgsNyArNTQ4LDcgQEAgc3RhdGljIHZvaWQNCj4+IHJlYWRfZWRwX2N1cnJlbnRfbGlua19zZXR0
aW5nc19vbl9kZXRlY3Qoc3RydWN0IGRjX2xpbmsgKmxpbmspDQo+PiAgwqAJCQlicmVhazsNCj4+
ICDCoAkJfQ0KPj4gICANCj4+IC0JCXVkZWxheSg4MDAwKTsNCj4+ICsJCW1zbGVlcCg4KTsNCj4+
ICDCoAl9DQo+PiAgIA0KPj4gIMKgCUFTU0VSVChzdGF0dXMgPT0gRENfT0spOw0KDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGlu
ZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
