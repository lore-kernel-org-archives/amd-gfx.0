From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/4] drm/amdgpu: increase the MAX ring number
Date: Thu, 13 Dec 2018 08:59:14 +0000
Message-ID: <351d08f1-00d0-d498-894d-4576ea164bd8@amd.com>
References: <20181213040947.26260-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181213040947.26260-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <97DA15A6C3533B4D9721E459F39D5DEB-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zeng,
 Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>

QW0gMTMuMTIuMTggdW0gMDU6MDkgc2NocmllYiBFdmFuIFF1YW46DQo+IEFzIHR3byBtb3JlIFNE
TUEgcGFnZSBxdWV1ZSByaW5ncyBhcmUgYWRkZWQgb24gVmVnYTIwLg0KPg0KPiBDaGFuZ2UtSWQ6
IEk4YTNkOGZiYzkyNGY3YzI0YWFlYmYxN2IzZjMyOWE0YTM4ZmU1YTU2DQo+IFNpZ25lZC1vZmYt
Ynk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQoNClJldmlld2VkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IGZvciB0aGlzIG9uZS4NCg0KQW5k
IEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IGZv
ciBwYXRjaCAjMyANCmFuZCAjNC4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KPiAtLS0NCj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oIHwgMiArLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuaCBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmgNCj4gaW5kZXggNGIzMWM5NmEyYTJjLi5m
ZTY1Nzc4ODAyNGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yaW5nLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jp
bmcuaA0KPiBAQCAtMzEsNyArMzEsNyBAQA0KPiAgICNlbmRpZg0KPiAgIA0KPiAgIC8qIG1heCBu
dW1iZXIgb2YgcmluZ3MgKi8NCj4gLSNkZWZpbmUgQU1ER1BVX01BWF9SSU5HUwkJMjENCj4gKyNk
ZWZpbmUgQU1ER1BVX01BWF9SSU5HUwkJMjMNCj4gICAjZGVmaW5lIEFNREdQVV9NQVhfR0ZYX1JJ
TkdTCQkxDQo+ICAgI2RlZmluZSBBTURHUFVfTUFYX0NPTVBVVEVfUklOR1MJOA0KPiAgICNkZWZp
bmUgQU1ER1BVX01BWF9WQ0VfUklOR1MJCTMNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
