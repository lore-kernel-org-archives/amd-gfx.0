From: Harry Wentland <hwentlan@amd.com>
Subject: Re: [PATCH] drm/amd/display: Move static keyword to the front of
 declaration
Date: Thu, 5 Sep 2019 18:34:01 +0000
Message-ID: <8b5de881-2109-6f75-68e3-9c8c743b483e@amd.com>
References: <20190905183306.32670-1-kw@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190905183306.32670-1-kw@linux.com>
Content-Language: en-US
Content-ID: <5BA5A1659CF21F4D800F07B7DDEDD308@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Krzysztof Wilczynski <kw@linux.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: "Park, Chris" <Chris.Park@amd.com>, "Yang, Eric" <Eric.Yang2@amd.com>, "Li,
 Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Francis,
 David" <David.Francis@amd.com>, "Liu, Wenjing" <Wenjing.Liu@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>, Aidan Wood <Aidan.Wood@amd.com>, "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>, "Cheng,
 Tony" <Tony.Cheng@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Lei, Jun" <Jun.Lei@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Koo,
 Anthony" <Anthony.Koo@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOS0wOS0wNSAyOjMzIHAubS4sIEtyenlzenRvZiBXaWxjenluc2tpIHdyb3RlOg0KPiBN
b3ZlIHRoZSBzdGF0aWMga2V5d29yZCB0byB0aGUgZnJvbnQgb2YgZGVjbGFyYXRpb24gb2YgRENf
QlVJTERfSUQsDQo+IGFuZCByZXNvbHZlIHRoZSBmb2xsb3dpbmcgY29tcGlsZXIgd2FybmluZyB0
aGF0IGNhbiBiZSBzZWVuIHdoZW4NCj4gYnVpbGRpbmcgd2l0aCB3YXJuaW5ncyBlbmFibGVkIChX
PTEpOg0KPiANCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3Jl
L2RjLmM6NzU6MTogd2FybmluZzoNCj4gICDigJhzdGF0aWPigJkgaXMgbm90IGF0IGJlZ2lubmlu
ZyBvZiBkZWNsYXJhdGlvbiBbLVdvbGQtc3R5bGUtZGVjbGFyYXRpb25dDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBLcnp5c3p0b2YgV2lsY3p5bnNraSA8a3dAbGludXguY29tPg0KDQpSZXZpZXdlZC1i
eTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+DQoNCkhhcnJ5DQoNCj4g
LS0tDQo+IFJlbGF0ZWQ6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAxOTA4MjcyMzMwMTcu
R0s5OTg3QGdvb2dsZS5jb20NCj4gDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Y29yZS9kYy5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NvcmUvZGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMN
Cj4gaW5kZXggODdjYTVhMjkwZDEyLi5hNWE4OWJjMGUxZDEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYw0KPiBAQCAtNzIsNyArNzIsNyBAQA0KPiAgI2Rl
ZmluZSBEQ19MT0dHRVIgXA0KPiAgCWRjLT5jdHgtPmxvZ2dlcg0KPiAgDQo+IC1jb25zdCBzdGF0
aWMgY2hhciBEQ19CVUlMRF9JRFtdID0gInByb2R1Y3Rpb24tYnVpbGQiOw0KPiArc3RhdGljIGNv
bnN0IGNoYXIgRENfQlVJTERfSURbXSA9ICJwcm9kdWN0aW9uLWJ1aWxkIjsNCj4gIA0KPiAgLyoq
DQo+ICAgKiBET0M6IE92ZXJ2aWV3DQo+IA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vZHJpLWRldmVs
