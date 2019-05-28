From: "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: reserve stollen vram for raven series
Date: Tue, 28 May 2019 07:55:18 +0000
Message-ID: <1559030095-19673-1-git-send-email-flora.cui@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>

dG8gYXZvaWQgc2NyZWVuIGNvcnJ1cHRpb24gZHVyaW5nIG1vZHByb2JlLg0KDQpDaGFuZ2UtSWQ6
IEk4NjcxZGU2ZWQ0NjI4NTU4NWRiZTg2NjgzMmM2ZDJiODM1Y2EzN2YzDQpTaWduZWQtb2ZmLWJ5
OiBGbG9yYSBDdWkgPGZsb3JhLmN1aUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ21jX3Y5XzAuYyB8IDMgKy0tDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMN
CmluZGV4IDYwMjU5M2IuLmRiYzgzYTEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nbWNfdjlfMC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNf
djlfMC5jDQpAQCAtNjI0LDkgKzYyNCw4IEBAIHN0YXRpYyBib29sIGdtY192OV8wX2tlZXBfc3Rv
bGVuX21lbW9yeShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiAJICovDQogCXN3aXRjaCAo
YWRldi0+YXNpY190eXBlKSB7DQogCWNhc2UgQ0hJUF9WRUdBMTA6DQotCQlyZXR1cm4gdHJ1ZTsN
CiAJY2FzZSBDSElQX1JBVkVOOg0KLQkJcmV0dXJuIChhZGV2LT5wZGV2LT5kZXZpY2UgPT0gMHgx
NWQ4KTsNCisJCXJldHVybiB0cnVlOw0KIAljYXNlIENISVBfVkVHQTEyOg0KIAljYXNlIENISVBf
VkVHQTIwOg0KIAlkZWZhdWx0Og0KLS0gDQoyLjcuNA0KDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=
