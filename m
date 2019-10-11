From: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Free gamma after calculating legacy
 transfer function
Date: Fri, 11 Oct 2019 20:54:09 +0000
Message-ID: <115d3c1e-60f0-e36a-8edc-624a3d539148@amd.com>
References: <20191011162610.1112-1-nicholas.kazlauskas@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191011162610.1112-1-nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <DCAFB3CECDF98C479DBD1D377D422A9A-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, "Yang,
 Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOS0xMC0xMSAxMjoyNiBwLm0uLCBOaWNob2xhcyBLYXpsYXVza2FzIHdyb3RlOg0KPiBb
V2h5XQ0KPiBXZSdyZSBsZWFraW5nIG1lbW9yeSBieSBub3QgZnJlZWluZyB0aGUgZ2FtbWEgdXNl
ZCB0byBjYWxjdWxhdGUgdGhlDQo+IHRyYW5zZmVyIGZ1bmN0aW9uIGZvciBsZWdhY3kgZ2FtbWEu
DQo+IA0KPiBbSG93XQ0KPiBSZWxlYXNlIHRoZSBnYW1tYSBhZnRlciB3ZSdyZSBkb25lIHdpdGgg
aXQuDQo+IA0KPiBDYzogUGhpbGlwIFlhbmcgPFBoaWxpcC5ZYW5nQGFtZC5jb20+DQo+IENjOiBI
YXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4NCj4gQ2M6IEJoYXdhbnByZWV0
IExha2hhIDxCaGF3YW5wcmVldC5MYWtoYUBhbWQuY29tPg0KPiBDYzogTGVvIExpIDxzdW5wZW5n
LmxpQGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE5pY2hvbGFzIEthemxhdXNrYXMgPG5pY2hv
bGFzLmthemxhdXNrYXNAYW1kLmNvbQ0KDQpSZXZpZXdlZC1ieTogTGVvIExpIDxzdW5wZW5nLmxp
QGFtZC5jb20+DQpUaGFua3MhDQoNCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9jb2xvci5jIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2NvbG9yLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9jb2xvci5jDQo+IGluZGV4IGI0M2JiN2Y5MGU0
ZS4uMjIzM2QyOTNhNzA3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9jb2xvci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2NvbG9yLmMNCj4gQEAgLTIxMCw2ICsyMTAs
OCBAQCBzdGF0aWMgaW50IF9fc2V0X2xlZ2FjeV90ZihzdHJ1Y3QgZGNfdHJhbnNmZXJfZnVuYyAq
ZnVuYywNCj4gIAlyZXMgPSBtb2RfY29sb3JfY2FsY3VsYXRlX3JlZ2FtbWFfcGFyYW1zKGZ1bmMs
IGdhbW1hLCB0cnVlLCBoYXNfcm9tLA0KPiAgCQkJCQkJIE5VTEwpOw0KPiAgDQo+ICsJZGNfZ2Ft
bWFfcmVsZWFzZSgmZ2FtbWEpOw0KPiArDQo+ICAJcmV0dXJuIHJlcyA/IDAgOiAtRU5PTUVNOw0K
PiAgfQ0KPiAgDQo+IA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
