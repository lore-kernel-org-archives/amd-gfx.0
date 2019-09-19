From: "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 17/21] drm/amdgpu: add ras fini for xgmi
Date: Thu, 19 Sep 2019 07:13:07 +0000
Message-ID: <20190919071115.16552-18-tao.zhou1@amd.com>
References: <20190919071115.16552-1-tao.zhou1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190919071115.16552-1-tao.zhou1-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Chen,
 Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>

YWRkIHJhcyBmaW5pIGZvciB4Z21pIHRvIGNsZWFudXAgeGdtaSByYXMgZnJhbWV3b3JrCgpTaWdu
ZWQtb2ZmLWJ5OiBUYW8gWmhvdSA8dGFvLnpob3UxQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIHwgMTEgKysrKysrKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCAxMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dtYy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dt
Yy5jCmluZGV4IDU4YTk1YTY3MzM2YS4uNGNkMjA2ZWUzZTBiIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dtYy5jCkBAIC0zMjksNCArMzI5LDE1IEBAIHZvaWQgYW1kZ3B1X2dt
Y19yYXNfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJYW1kZ3B1X3Jhc19sYXRl
X2ZpbmkoYWRldiwgcmFzX2lmLCAmaWhfaW5mbyk7CiAJCWtmcmVlKHJhc19pZik7CiAJfQorCisJ
aWYgKGFtZGdwdV9yYXNfaXNfc3VwcG9ydGVkKGFkZXYsIEFNREdQVV9SQVNfQkxPQ0tfX1hHTUlf
V0FGTCkgJiYKKwkJCWFkZXYtPmdtYy54Z21pLnJhc19pZikgeworCQlzdHJ1Y3QgcmFzX2NvbW1v
bl9pZiAqcmFzX2lmID0gYWRldi0+Z21jLnhnbWkucmFzX2lmOworCQlzdHJ1Y3QgcmFzX2loX2lm
IGloX2luZm8gPSB7CisJCQkuY2IgPSBOVUxMLAorCQl9OworCisJCWFtZGdwdV9yYXNfbGF0ZV9m
aW5pKGFkZXYsIHJhc19pZiwgJmloX2luZm8pOworCQlrZnJlZShyYXNfaWYpOworCX0KIH0KLS0g
CjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
