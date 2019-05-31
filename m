From: Harry Wentland <hwentlan@amd.com>
Subject: Re: [PATCH][next] drm/amd/display: remove redundant assignment to
 status
Date: Fri, 31 May 2019 20:19:03 +0000
Message-ID: <a190bcd5-cda8-84c6-093a-98438a605032@amd.com>
References: <20190530161219.2507-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190530161219.2507-1-colin.king@canonical.com>
Content-Language: en-US
Content-ID: <6B414A2346E324478E8EC5C835BA381A@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, "Koo, Anthony" <Anthony.Koo@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOS0wNS0zMCAxMjoxMiBwLm0uLCBDb2xpbiBLaW5nIHdyb3RlOg0KPiBGcm9tOiBDb2xp
biBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiANCj4gVGhlIHZhcmlhYmxl
IHN0YXR1cyBpcyBpbml0aWFsaXplZCB3aXRoIGEgdmFsdWUgdGhhdCBpcyBuZXZlciByZWFkDQo+
IGFuZCBzdGF0dXMgaXMgcmVhc3NpZ25lZCBzZXZlcmFsIHN0YXRlbWVudHMgbGF0ZXIuIFRoaXMg
aW5pdGlhbGl6YXRpb24NCj4gaXMgcmVkdW5kYW50IGFuZCBjYW4gYmUgcmVtb3ZlZC4NCj4gDQo+
IEFkZHJlc3Nlcy1Db3Zlcml0eTogKCJVbnVzZWQgdmFsdWUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBD
b2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYyB8IDIgKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYw0KPiBpbmRl
eCA2NWQ2Y2FlZGJkODIuLmNmNjE2NmExYmU1MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYw0KPiBAQCAtMjM2Nyw3ICsyMzY3
LDcgQEAgc3RhdGljIGJvb2wgcmV0cmlldmVfbGlua19jYXAoc3RydWN0IGRjX2xpbmsgKmxpbmsp
DQo+ICAJdW5pb24gZG93bl9zdHJlYW1fcG9ydF9jb3VudCBkb3duX3N0cm1fcG9ydF9jb3VudDsN
Cj4gIAl1bmlvbiBlZHBfY29uZmlndXJhdGlvbl9jYXAgZWRwX2NvbmZpZ19jYXA7DQo+ICAJdW5p
b24gZHBfZG93bnN0cmVhbV9wb3J0X3ByZXNlbnQgZHNfcG9ydCA9IHsgMCB9Ow0KPiAtCWVudW0g
ZGNfc3RhdHVzIHN0YXR1cyA9IERDX0VSUk9SX1VORVhQRUNURUQ7DQo+ICsJZW51bSBkY19zdGF0
dXMgc3RhdHVzOw0KDQpOb3Qgc3VyZSB0aGlzIGltcHJvdmVzIHRoZSBzaXR1YXRpb24uDQoNCkkn
ZCBwcmVmZXIgdG8gaGF2ZSBhIGRlZmF1bHQgaGVyZSBpbiBjYXNlIHNvbWVvbmUgY2hhbmdlcyB0
aGUgY29kZSBiZWxvdw0KYW5kIGZvcmdldHMgdG8gc2V0IHRoZSBzdGF0dXMuDQoNCkhhcnJ5DQoN
Cj4gIAl1aW50MzJfdCByZWFkX2RwY2RfcmV0cnlfY250ID0gMzsNCj4gIAlpbnQgaTsNCj4gIAlz
dHJ1Y3QgZHBfc2lua19od19md19yZXZpc2lvbiBkcF9od19md19yZXZpc2lvbjsNCj4gDQo=
