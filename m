From: "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: Re: [PATCH 0/3] drm/amdgpu: Fix suspend/resume issues with MST
Date: Tue, 8 Jan 2019 17:32:45 +0000
Message-ID: <5db84bb9-6d2d-391d-3699-2331bdc75118@amd.com>
References: <20190108005651.25967-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190108005651.25967-1-lyude@redhat.com>
Content-Language: en-US
Content-ID: <D189261AF3BD10469EF045FA58182B75@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Lyude Paul <lyude@redhat.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, Maxime Ripard <maxime.ripard@bootlin.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Francis,
 David" <David.Francis@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "S,
 Shirish" <Shirish.S@amd.com>, "Li, Sun
 peng (Leo)" <Sunpeng.Li@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Cheng,
 Tony" <Tony.Cheng@amd.com>, David Airlie <airlied@linux.ie>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Mikita Lipski <mikita.lipski@amd.com>, Sean Paul <sean@poorly.run>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOS0wMS0wNyA3OjU2IHAubS4sIEx5dWRlIFBhdWwgd3JvdGU6DQo+IEZpeCB0aGUgc3Vz
cGVuZC9pc3N1ZXMgdGhhdCBKZXJyeSBadW8gZm91bmQgaW4gYW1kZ3B1LCBhbmQgYWRkIHNvbWUN
Cj4gY29tcGlsZXIgd2FybmluZ3MgZm9yIGRyaXZlcnMgaWdub3JpbmcgdGhlIHJldHVybiBjb2Rl
IG9mDQo+IGRybV9kcF9tc3RfdG9wb2xvZ3lfbWdyX3Jlc3VtZSgpIHRvIGhlbHAgZW5zdXJlIHdl
IGRvbid0IG5lZWQgdG8gZml4DQo+IHRoaXMgYWdhaW4gaW4gdGhlIGZ1dHVyZSBmb3Igc29tZW9u
ZSBlbHNlJ3MgZHJpdmVyLg0KPiANCj4gQ2M6IEplcnJ5IFp1byA8SmVycnkuWnVvQGFtZC5jb20+
DQoNCldpdGggdGhlIHNtYWxsIGNoYW5nZSBEYW5pZWwgbWVudGlvbmVkIHRoaXMgc2VyaWVzIGlz
DQpSZXZpZXdlZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+DQoN
CkhhcnJ5DQoNCj4gDQo+IEx5dWRlIFBhdWwgKDMpOg0KPiAgIGRybS9hbWRncHU6IERvbid0IGln
bm9yZSByYyBmcm9tIGRybV9kcF9tc3RfdG9wb2xvZ3lfbWdyX3Jlc3VtZSgpDQo+ICAgZHJtL2Ft
ZGdwdTogRG9uJ3QgZmFpbCByZXN1bWUgcHJvY2VzcyBpZiByZXN1bWluZyBhdG9taWMgc3RhdGUg
ZmFpbHMNCj4gICBkcm0vZHBfbXN0OiBBZGQgX19tdXN0X2NoZWNrIHRvIGRybV9kcF9tc3RfdG9w
b2xvZ3lfbWdyX3Jlc3VtZSgpDQo+IA0KPiAgLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1
X2RtL2FtZGdwdV9kbS5jIHwgMzcgKysrKysrKysrKysrKy0tLS0tLQ0KPiAgZHJpdmVycy9ncHUv
ZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYyAgICAgICAgIHwgIDMgKy0NCj4gIGluY2x1ZGUvZHJt
L2RybV9kcF9tc3RfaGVscGVyLmggICAgICAgICAgICAgICB8ICAzICstDQo+ICAzIGZpbGVzIGNo
YW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiANCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxp
c3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
