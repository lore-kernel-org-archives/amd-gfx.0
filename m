From: Mikita Lipski <mlipski@amd.com>
Subject: Re: [PATCH][next] drm/amd/display: fix dereference of pointer
 aconnector when it is null
Date: Fri, 8 Nov 2019 14:42:03 +0000
Message-ID: <7155ecfc-1aff-002d-9cc6-e097525e7cb6@amd.com>
References: <20191108143814.118856-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191108143814.118856-1-colin.king@canonical.com>
Content-Language: en-US
Content-ID: <6E12F9E10193E2498B9DE2142A6106B4@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>, "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>, "Lipski, Mikita" <Mikita.Lipski@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

VGhhbmtzIQ0KDQpSZXZpZXdlZC1ieTogTWlraXRhIExpcHNraSA8bWlraXRhLmxpcHNraUBhbWQu
Y29tPg0KDQpPbiAwOC4xMS4yMDE5IDk6MzgsIENvbGluIEtpbmcgd3JvdGU6DQo+IEZyb206IENv
bGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IA0KPiBDdXJyZW50bHkg
cG9pbnRlciBhY29ubmVjdG9yIGlzIGJlaW5nIGRlcmVmZXJlbmNlZCBieSB0aGUgY2FsbCB0bw0K
PiB0b19kbV9jb25uZWN0b3Jfc3RhdGUgYmVmb3JlIGl0IGlzIGJlaW5nIG51bGwgY2hlY2tlZCwg
dGhpcyBjb3VsZA0KPiBsZWFkIHRvIGEgbnVsbCBwb2ludGVyIGRlcmVmZXJlbmNlLiAgRml4IHRo
aXMgYnkgY2hlY2tpbmcgdGhhdA0KPiBhY29ubmVjdG9yIGlzIG51bGwgYmVmb3JlIGRlcmVmZXJl
bmNpbmcgaXQuDQo+IA0KPiBBZGRyZXNzZXMtQ292ZXJpdHk6ICgiRGVyZWZlcmVuY2UgYmVmb3Jl
IG51bGwgY2hlY2siKQ0KPiBGaXhlczogNTEzM2M2MjQxZDljICgiZHJtL2FtZC9kaXNwbGF5OiBB
ZGQgTVNUIGF0b21pYyByb3V0aW5lcyIpDQo+IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5n
IDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2hlbHBlcnMuYyB8IDUgKystLS0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2Rt
X2hlbHBlcnMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtX2hlbHBlcnMuYw0KPiBpbmRleCBlM2NkYTY5ODRkMjguLjcyZTY3Nzc5NmE0OCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1f
aGVscGVycy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtX2hlbHBlcnMuYw0KPiBAQCAtMTkzLDEyICsxOTMsMTEgQEAgYm9vbCBkbV9oZWxw
ZXJzX2RwX21zdF93cml0ZV9wYXlsb2FkX2FsbG9jYXRpb25fdGFibGUoDQo+ICAgCSAqIHRoYXQg
YmxvY2tzIGJlZm9yZSBjb21taXQgZ3VhcmFudGVlaW5nIHRoYXQgdGhlIHN0YXRlDQo+ICAgCSAq
IGlzIG5vdCBnb25uYSBiZSBzd2FwcGVkIHdoaWxlIHN0aWxsIGluIHVzZSBpbiBjb21taXQgdGFp
bCAqLw0KPiAgIA0KPiAtCWRtX2Nvbm5fc3RhdGUgPSB0b19kbV9jb25uZWN0b3Jfc3RhdGUoYWNv
bm5lY3Rvci0+YmFzZS5zdGF0ZSk7DQo+IC0NCj4gLQ0KPiAgIAlpZiAoIWFjb25uZWN0b3IgfHwg
IWFjb25uZWN0b3ItPm1zdF9wb3J0KQ0KPiAgIAkJcmV0dXJuIGZhbHNlOw0KPiAgIA0KPiArCWRt
X2Nvbm5fc3RhdGUgPSB0b19kbV9jb25uZWN0b3Jfc3RhdGUoYWNvbm5lY3Rvci0+YmFzZS5zdGF0
ZSk7DQo+ICsNCj4gICAJbXN0X21nciA9ICZhY29ubmVjdG9yLT5tc3RfcG9ydC0+bXN0X21ncjsN
Cj4gICANCj4gICAJaWYgKCFtc3RfbWdyLT5tc3Rfc3RhdGUpDQo+IA0KDQotLSANClRoYW5rcywN
Ck1pa2l0YSBMaXBza2kNCm1pa2l0YS5saXBza2lAYW1kLmNvbQ0K
