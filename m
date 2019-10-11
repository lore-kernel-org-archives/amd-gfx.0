From: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 0/3] RAS Support for GFX blocks
Date: Fri, 11 Oct 2019 03:52:30 +0000
Message-ID: <DM5PR12MB14189C1B342B9054D5F8B451FC970@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20191011024922.9018-1-Dennis.Li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191011024922.9018-1-Dennis.Li-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>, "Chen, Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>
Cc: "Li, Dennis" <Dennis.Li-5C7GfCeVMHo@public.gmane.org>

U2VyaWVzIGlzDQoNClJldmlld2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFt
ZC5jb20+DQoNClJlZ2FyZHMsDQpIYXdraW5nDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogRGVubmlzIExpIDxEZW5uaXMuTGlAYW1kLmNvbT4gDQpTZW50OiAyMDE55bm0MTDmnIgx
MeaXpSAxMDo0OQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaG91MSwgVGFvIDxUYW8uWmhv
dTFAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBDaGVu
LCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+DQpDYzogTGksIERlbm5pcyA8RGVubmlzLkxp
QGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggMC8zXSBSQVMgU3VwcG9ydCBmb3IgR0ZYIGJsb2Nr
cw0KDQoxLiBBZGQgdGhlIEVEQyBjb3VudCBmcm9tIGhhcmR3YXJlLg0KMi4gQWRkIFJBUyBzdXBw
b3J0IGZvciBWTUwyIGFtZCBBVENMMiBzdWIgYmxvY2tzLg0KDQpEZW5uaXMgTGkgKDMpOg0KICBk
cm0vYW1kZ3B1OiBjaGFuZ2UgdG8gcXVlcnkgdGhlIGFjdHVhbCBFREMgY291bnRlcg0KICBkcm0v
YW1kL2luY2x1ZGU6IGFkZCByZWdpc3RlciBkZWZpbmUgZm9yIFZNTDIgYW5kIEFUQ0wyDQogIGRy
bS9hbWRncHU6IGFkZCBSQVMgc3VwcG9ydCBmb3IgVk1MMiBhbmQgQVRDTDINCg0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgICAgICAgICB8IDk4NiArKysrKysrKysrKyst
LS0tLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5oICAgICAgICAgICAgfCAg
IDIgKw0KIC4uLi9hbWQvaW5jbHVkZS9hc2ljX3JlZy9nYy9nY185XzBfb2Zmc2V0LmggICB8ICAx
OCArLQ0KIC4uLi9hbWQvaW5jbHVkZS9hc2ljX3JlZy9nYy9nY185XzBfc2hfbWFzay5oICB8ICAx
OCArLQ0KIDQgZmlsZXMgY2hhbmdlZCwgNjk1IGluc2VydGlvbnMoKyksIDMyOSBkZWxldGlvbnMo
LSkNCg0KLS0gDQoyLjE3LjENCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4
