From: "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: Re: [WIP PATCH 01/15] drm/dp_mst: Remove bogus
 conditional in drm_dp_update_payload_part1()
Date: Mon, 17 Dec 2018 20:09:03 +0000
Message-ID: <1c77ddfa-df9c-8e6f-eb11-1069780360b2@amd.com>
References: <20181214012604.13746-1-lyude@redhat.com>
 <20181214012604.13746-2-lyude@redhat.com>
 <20181214084220.GL21184@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20181214084220.GL21184@phenom.ffwll.local>
Content-Language: en-US
Content-ID: <002FE8D0B2FDB64AA024230F1F72EB76@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Lyude Paul <lyude@redhat.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>, "Zuo,
 Jerry" <Jerry.Zuo@amd.com>, Juston Li <juston.li@intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

DQoNCk9uIDIwMTgtMTItMTQgMzo0MiBhLm0uLCBEYW5pZWwgVmV0dGVyIHdyb3RlOg0KPiBPbiBU
aHUsIERlYyAxMywgMjAxOCBhdCAwODoyNTozMFBNIC0wNTAwLCBMeXVkZSBQYXVsIHdyb3RlOg0K
Pj4gVGhlcmUncyBubyByZWFzb24gd2UgbmVlZCB0aGlzLCBpdCdzIGp1c3QgY29uZnVzaW5nIGxv
b2tpbmcuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTHl1ZGUgUGF1bCA8bHl1ZGVAcmVkaGF0LmNv
bT4NCj4+IENjOiBKdXN0b24gTGkgPGp1c3Rvbi5saUBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICBk
cml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jIHwgNCArLS0tDQo+PiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYw0KPj4gaW5kZXggYWQwZmI2ZDAwM2JlLi45YjFiNWM5
YjFmYTAgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9n
eS5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jDQo+PiBA
QCAtMTg5Niw5ICsxODk2LDcgQEAgaW50IGRybV9kcF91cGRhdGVfcGF5bG9hZF9wYXJ0MShzdHJ1
Y3QgZHJtX2RwX21zdF90b3BvbG9neV9tZ3IgKm1ncikNCj4+ICAJCQlyZXFfcGF5bG9hZC5udW1f
c2xvdHMgPSAwOw0KPj4gIAkJfQ0KPj4gIA0KPj4gLQkJaWYgKG1nci0+cGF5bG9hZHNbaV0uc3Rh
cnRfc2xvdCAhPSByZXFfcGF5bG9hZC5zdGFydF9zbG90KSB7DQo+PiAtCQkJbWdyLT5wYXlsb2Fk
c1tpXS5zdGFydF9zbG90ID0gcmVxX3BheWxvYWQuc3RhcnRfc2xvdDsNCj4+IC0JCX0NCj4+ICsJ
CW1nci0+cGF5bG9hZHNbaV0uc3RhcnRfc2xvdCA9IHJlcV9wYXlsb2FkLnN0YXJ0X3Nsb3Q7DQo+
IA0KPiBFbnRlcnRhaW5pbmchDQo+IA0KPiBSZXZpZXdlZC1ieTogRGFuaWVsIFZldHRlciA8ZGFu
aWVsLnZldHRlckBmZndsbC5jaD4NCj4gDQoNClJldmlld2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8
aGFycnkud2VudGxhbmRAYW1kLmNvbT4NCg0KSGFycnkNCg0KPj4gIAkJLyogd29yayBvdXQgd2hh
dCBpcyByZXF1aXJlZCB0byBoYXBwZW4gd2l0aCB0aGlzIHBheWxvYWQgKi8NCj4+ICAJCWlmICht
Z3ItPnBheWxvYWRzW2ldLm51bV9zbG90cyAhPSByZXFfcGF5bG9hZC5udW1fc2xvdHMpIHsNCj4+
ICANCj4+IC0tIA0KPj4gMi4xOS4yDQo+Pg0KPiANCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2ludGVsLWdmeAo=
