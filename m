From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/3] drm/amdgpu: Fix a typo in vega10_ih_set_rptr()
Date: Wed, 6 Feb 2019 15:49:41 +0000
Message-ID: <20190206154921.14463-2-Yong.Zhao@amd.com>
References: <20190206154921.14463-1-Yong.Zhao@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190206154921.14463-1-Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>

Q2xlYXJseSwgaXQgc2hvdWxkIGJlIGEgNjQtYml0IGRvb3JiZWxsIG9wZXJhdGlvbi4KCkNoYW5n
ZS1JZDogSTY0NGEyZWJjYjE4YzJlZGUyNGVlMTU2OTJhNjE4OWVmYWQxMGEzNWMKU2lnbmVkLW9m
Zi1ieTogWW9uZyBaaGFvIDxZb25nLlpoYW9AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS92ZWdhMTBfaWguYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3ZlZ2ExMF9paC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMK
aW5kZXggNzk2MDA0ODk2NjYxLi4zNmYwZTNjYWRhMzAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3ZlZ2ExMF9paC5jCkBAIC0zNzcsNyArMzc3LDcgQEAgc3RhdGljIHZvaWQgdmVnYTEwX2lo
X3NldF9ycHRyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCWlmIChpaC0+dXNlX2Rvb3Ji
ZWxsKSB7CiAJCS8qIFhYWCBjaGVjayBpZiBzd2FwcGluZyBpcyBuZWNlc3Nhcnkgb24gQkUgKi8K
IAkJKmloLT5ycHRyX2NwdSA9IGloLT5ycHRyOwotCQlXRE9PUkJFTEwzMihpaC0+ZG9vcmJlbGxf
aWR4X2luX2R3LCBpaC0+cnB0cik7CisJCVdET09SQkVMTDY0KGloLT5kb29yYmVsbF9pZHhfaW5f
ZHcsIGloLT5ycHRyKTsKIAl9IGVsc2UgaWYgKGloID09ICZhZGV2LT5pcnEuaWgpIHsKIAkJV1JF
RzMyX1NPQzE1KE9TU1NZUywgMCwgbW1JSF9SQl9SUFRSLCBpaC0+cnB0cik7CiAJfSBlbHNlIGlm
IChpaCA9PSAmYWRldi0+aXJxLmloMSkgewotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
