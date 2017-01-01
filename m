From: "Yu, Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [V2 1/1] drm/amdgpu/gfx8: add support kernel interface queue(KIQ)
Date: Sun, 1 Jan 2017 14:52:08 +0000
Message-ID: <CY4PR12MB170187A56A121109C1BAF537EB6C0@CY4PR12MB1701.namprd12.prod.outlook.com>
References: <1482476904-21674-1-git-send-email-Xiangliang.Yu@amd.com>
 <CADnq5_MyKwYUfEAtkUgSjLZMbGNbmc_n3pzCwG=B8B2Xpfw+Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_MyKwYUfEAtkUgSjLZMbGNbmc_n3pzCwG=B8B2Xpfw+Zw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

PiA+IGNoYW5nZXMgaW4gdjI6DQo+ID4gMS4gdXNlIGFtZGdwdV9ib19jcmVhdGUvZnJlZV9rZXJu
ZWwgdG8gYWxsb2NhdGUgT0IuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9u
ay5MaXVAYW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBYaWFuZ2xpYW5nIFl1IDxYaWFuZ2xp
YW5nLll1QGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdS5oICAgfCAgMTMgKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djhfMC5jIHwgNjA3DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmlkLmggICAgICB8ICAgMiArDQo+ID4gIDMgZmls
ZXMgY2hhbmdlZCwgNjIwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4gaW5kZXggOWVhNWJmMC4uYzM5
Mjg4MiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUu
aA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4gQEAg
LTE4Niw2ICsxODYsMTEgQEAgZW51bSBhbWRncHVfdGhlcm1hbF9pcnEgew0KPiA+ICAgICAgICAg
QU1ER1BVX1RIRVJNQUxfSVJRX0xBU1QNCj4gPiAgfTsNCj4gPg0KPiA+ICtlbnVtIGFtZGdwdV9r
aXFfaXJxIHsNCj4gPiArICAgICAgIEFNREdQVV9DUF9LSVFfSVJRX0RSSVZFUjAgPSAwLA0KPiA+
ICsgICAgICAgQU1ER1BVX0NQX0tJUV9JUlFfTEFTVA0KPiA+ICt9Ow0KPiANCj4gSXMgdGhlcmUg
YSByZWFzb24gdG8gbWFrZSB0aGlzIGEgc2VwYXJhdGUgZW51bSByYXRoZXIgdGhhbiBqdXN0IGFk
ZGluZyBpdCB0bw0KPiBhbWRncHVfY3BfaXJxPw0KDQpPaywgSSdsbCBhZGQgQ1BfS0lRX0lSUSBp
bnRvIGFtZGdwdV9jcF9pcnEgYW5kIHJlbW92ZSB0aGUgZW51bS4gVGhhbmtzIQ0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
