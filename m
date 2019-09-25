From: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 07/11] drm/amdgpu: add tmz bit in frame control packet
Date: Wed, 25 Sep 2019 13:45:31 +0000
Message-ID: <1569419090-5304-8-git-send-email-ray.huang@amd.com>
References: <1569419090-5304-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1569419090-5304-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <D166641A9D244B49957020511F8ADA9C-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Tuikov, Luben" <Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Liu,
 Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>

VGhpcyBwYXRjaCBhZGRzIHRteiBiaXQgaW4gZnJhbWUgY29udHJvbCBwbTQgcGFja2V0LCBhbmQg
aXQgd2lsbCB1c2VkIGluIGZ1dHVyZS4NCg0KU2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXku
aHVhbmdAYW1kLmNvbT4NClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+DQpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnZkLmggICAg
fCAxICsNCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNWQuaCB8IDEgKw0KIDIgZmls
ZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9udmQuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252ZC5oDQpp
bmRleCAxZGU5ODQ2Li5mM2Q4NzcxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvbnZkLmgNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252ZC5oDQpAQCAt
MzA2LDYgKzMwNiw3IEBADQogI2RlZmluZQlQQUNLRVQzX0dFVF9MT0RfU1RBVFMJCQkJMHg4RQ0K
ICNkZWZpbmUJUEFDS0VUM19EUkFXX01VTFRJX1BSRUFNQkxFCQkJMHg4Rg0KICNkZWZpbmUJUEFD
S0VUM19GUkFNRV9DT05UUk9MCQkJCTB4OTANCisjCQkJZGVmaW5lIEZSQU1FX1RNWgkoMSA8PCAw
KQ0KICMJCQlkZWZpbmUgRlJBTUVfQ01EKHgpICgoeCkgPDwgMjgpDQogCQkJLyoNCiAJCQkgKiB4
PTA6IHRtel9iZWdpbg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Nv
YzE1ZC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTVkLmgNCmluZGV4IGVkZmU1
MDguLjI5NWQ2OGMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2Mx
NWQuaA0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTVkLmgNCkBAIC0yODYs
NiArMjg2LDcgQEANCiAjZGVmaW5lCVBBQ0tFVDNfV0FJVF9PTl9ERV9DT1VOVEVSX0RJRkYJCQkw
eDg4DQogI2RlZmluZQlQQUNLRVQzX1NXSVRDSF9CVUZGRVIJCQkJMHg4Qg0KICNkZWZpbmUgUEFD
S0VUM19GUkFNRV9DT05UUk9MCQkJCTB4OTANCisjCQkJZGVmaW5lIEZSQU1FX1RNWgkoMSA8PCAw
KQ0KICMJCQlkZWZpbmUgRlJBTUVfQ01EKHgpICgoeCkgPDwgMjgpDQogCQkJLyoNCiAJCQkgKiB4
PTA6IHRtel9iZWdpbg0KLS0gDQoyLjcuNA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
