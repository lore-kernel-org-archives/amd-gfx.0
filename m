From: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: Fix use of interruptible waiting
Date: Tue, 25 Apr 2017 17:25:26 -0400
Message-ID: <1493155526-28910-2-git-send-email-AlexBin.Xie@amd.com>
References: <1493155526-28910-1-git-send-email-AlexBin.Xie@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1493155526-28910-1-git-send-email-AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

MS4gVGhlIHdhaXQgaXMgc2hvcnQuIFRoZXJlIGlzIG5vdCBtdWNoIGJlbmVmaXQgYnkKaW50ZXJy
dXB0aWJsZSB3YWl0aW5nLgoyLiBJbiB0aGlzIGZ1bmN0aW9uIGFuZCBjYWxsZXIgZnVuY3Rpb25z
LCB0aGUgZXJyb3IKaGFuZGxpbmcgZm9yIHN1Y2ggaW50ZXJydXB0IGlzIGNvbXBsaWNhdGVkIGFu
ZCByaXNreS4KCkNoYW5nZS1JZDogSTI4OTY3NGVjZDNmNWVmMjBjOTNmZTYzZTMzZGY2ZDY2OGIz
YzJlZGMKU2lnbmVkLW9mZi1ieTogQWxleCBYaWUgPEFsZXhCaW4uWGllQGFtZC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyB8IDIgKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jCmluZGV4IDQzMDgyYmYuLmMwMDZjYzQgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYwpAQCAtMjI3LDcg
KzIyNyw3IEBAIGludCBhbWRncHVfY3J0Y19wcmVwYXJlX2ZsaXAoCiAJbmV3X2FibyA9IGdlbV90
b19hbWRncHVfYm8ob2JqKTsKIAogCS8qIHBpbiB0aGUgbmV3IGJ1ZmZlciAqLwotCXIgPSBhbWRn
cHVfYm9fcmVzZXJ2ZShuZXdfYWJvLCBmYWxzZSk7CisJciA9IGFtZGdwdV9ib19yZXNlcnZlKG5l
d19hYm8sIHRydWUpOwogCWlmICh1bmxpa2VseShyICE9IDApKSB7CiAJCURSTV9FUlJPUigiZmFp
bGVkIHRvIHJlc2VydmUgbmV3IGFibyBidWZmZXIgYmVmb3JlIGZsaXBcbiIpOwogCQlnb3RvIGNs
ZWFudXA7Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
