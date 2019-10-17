From: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Avoid sending abnormal VSIF
Date: Thu, 17 Oct 2019 12:45:40 +0000
Message-ID: <078d3815-a1b2-d636-6431-bba3f2df37c5@amd.com>
References: <20191017091122.8922-1-Wayne.Lin@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191017091122.8922-1-Wayne.Lin-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <31BDE8E56D12D045AD15870296C7D33E-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Lin, Wayne" <Wayne.Lin-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOS0xMC0xNyA1OjExIGEubS4sIFdheW5lIExpbiB3cm90ZToNCj4gW1doeV0NCj4gV2hp
bGUgc2V0dGluZyBoZG1pX3ZpYywgaHZfZnJhbWUudmljIGlzIG5vdCBpbml0aWFsaXplZCBhbmQg
bWlnaHQNCj4gYXNzaWduIGEgd3JvbmcgdmFsdWUgdG8gaGRtaV92aWMuIENhdXNlIHRvIHNlbmQg
b3V0IFZTSUYgd2l0aA0KPiBhYm5vcm1hbCB2YWx1ZS4NCj4gDQo+IFtIb3ddDQo+IEluaXRpYWxp
emUgaHZfZnJhbWUgYW5kIGF2aV9mcmFtZQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2F5bmUgTGlu
IDxXYXluZS5MaW5AYW1kLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IE5pY2hvbGFzIEthemxhdXNrYXMg
PG5pY2hvbGFzLmthemxhdXNrYXNAYW1kLmNvbT4NCg0KVGhhbmtzIQ0KDQo+IC0tLQ0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAzICsrKw0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0KPiBpbmRleCAxMGNj
ZTU4NDcxOWYuLjMzYTQ1NWM5MGUyNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQo+IEBAIC0zNDcyLDYgKzM0NzIsOSBA
QCBzdGF0aWMgdm9pZCBmaWxsX3N0cmVhbV9wcm9wZXJ0aWVzX2Zyb21fZHJtX2Rpc3BsYXlfbW9k
ZSgNCj4gICAJc3RydWN0IGhkbWlfdmVuZG9yX2luZm9mcmFtZSBodl9mcmFtZTsNCj4gICAJc3Ry
dWN0IGhkbWlfYXZpX2luZm9mcmFtZSBhdmlfZnJhbWU7DQo+ICAgDQo+ICsJbWVtc2V0KCZodl9m
cmFtZSwgMCwgc2l6ZW9mKGh2X2ZyYW1lKSk7DQo+ICsJbWVtc2V0KCZhdmlfZnJhbWUsIDAsIHNp
emVvZihhdmlfZnJhbWUpKTsNCj4gKw0KPiAgIAl0aW1pbmdfb3V0LT5oX2JvcmRlcl9sZWZ0ID0g
MDsNCj4gICAJdGltaW5nX291dC0+aF9ib3JkZXJfcmlnaHQgPSAwOw0KPiAgIAl0aW1pbmdfb3V0
LT52X2JvcmRlcl90b3AgPSAwOw0KPiANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
