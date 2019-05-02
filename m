From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/amdgpu: Add MEM_LOAD to amdgpu_pm_info debugfs file
Date: Thu, 2 May 2019 14:22:49 +0000
Message-ID: <20190502142239.22322-1-tom.stdenis@amd.com>
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
Cc: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPg0KLS0tDQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtLmMgfCA0ICsrKysNCiAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9wbS5jDQppbmRleCA1ZTJkMDM5ZTA5YWQuLmUwNzg5ZjBmMjY3MCAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jDQorKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYw0KQEAgLTI5NTUsNiArMjk1NSwxMCBAQCBzdGF0aWMg
aW50IGFtZGdwdV9kZWJ1Z2ZzX3BtX2luZm9fcHAoc3RydWN0IHNlcV9maWxlICptLCBzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYQ0KIAkvKiBHUFUgTG9hZCAqLw0KIAlpZiAoIWFtZGdwdV9kcG1fcmVh
ZF9zZW5zb3IoYWRldiwgQU1ER1BVX1BQX1NFTlNPUl9HUFVfTE9BRCwgKHZvaWQgKikmdmFsdWUs
ICZzaXplKSkNCiAJCXNlcV9wcmludGYobSwgIkdQVSBMb2FkOiAldSAlJVxuIiwgdmFsdWUpOw0K
KwkvKiBNRU0gTG9hZCAqLw0KKwlpZiAoIWFtZGdwdV9kcG1fcmVhZF9zZW5zb3IoYWRldiwgQU1E
R1BVX1BQX1NFTlNPUl9NRU1fTE9BRCwgKHZvaWQgKikmdmFsdWUsICZzaXplKSkNCisJCXNlcV9w
cmludGYobSwgIk1FTSBMb2FkOiAldSAlJVxuIiwgdmFsdWUpOw0KKw0KIAlzZXFfcHJpbnRmKG0s
ICJcbiIpOw0KIA0KIAkvKiBTTUMgZmVhdHVyZSBtYXNrICovDQotLSANCjIuMjAuMQ0KDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
