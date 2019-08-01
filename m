From: Tao Zhou <tao.zhou1-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/5] drm/amdgpu: only uncorrectable error needs gpu reset
Date: Thu, 1 Aug 2019 19:54:53 +0800
Message-ID: <20190801115454.21867-5-tao.zhou1@amd.com>
References: <20190801115454.21867-1-tao.zhou1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190801115454.21867-1-tao.zhou1-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, hawking.zhang-5C7GfCeVMHo@public.gmane.org, dennis.li-5C7GfCeVMHo@public.gmane.org, guchun.chen-5C7GfCeVMHo@public.gmane.org, xinhui.pan-5C7GfCeVMHo@public.gmane.org
Cc: Tao Zhou <tao.zhou1-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgfCA2ICsrKysrLQogMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjlfMC5jCmluZGV4IDA1Y2JkOTBkOWI2Yy4uYjZlZGFkOGJiMzFjIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKQEAgLTI1MCw3ICsyNTAsMTEgQEAgc3RhdGljIGludCBn
bWNfdjlfMF9wcm9jZXNzX3Jhc19kYXRhX2NiKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAog
CSAqLwogCWlmIChhZGV2LT51bWMuZnVuY3MtPnF1ZXJ5X3Jhc19lcnJvcl9hZGRyZXNzKQogCQlh
ZGV2LT51bWMuZnVuY3MtPnF1ZXJ5X3Jhc19lcnJvcl9hZGRyZXNzKGFkZXYsIGVycl9kYXRhKTsK
LQlhbWRncHVfcmFzX3Jlc2V0X2dwdShhZGV2LCAwKTsKKwkKKwkvKiBvbmx5IHVuY29ycmVjdGFi
bGUgZXJyb3IgbmVlZHMgZ3B1IHJlc2V0ICovCisJaWYgKGVycl9kYXRhLT51ZV9jb3VudCkKKwkJ
YW1kZ3B1X3Jhc19yZXNldF9ncHUoYWRldiwgMCk7CisKIAlyZXR1cm4gQU1ER1BVX1JBU19VRTsK
IH0KIAotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
