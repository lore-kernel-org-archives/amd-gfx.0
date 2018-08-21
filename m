From: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/sriov: Only sriov runtime support use kiq
Date: Tue, 21 Aug 2018 13:02:32 +0800
Message-ID: <1534827752-6300-1-git-send-email-Emily.Deng@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>

Rm9yIHNyaW92LCBkb24ndCB1c2Uga2lxIGluIGV4Y2x1c2l2ZSBtb2RlLCBhcyBkb24ndCBrbm93
IGhvdyBsb25nIHRpbWUKaXQgd2lsbCB0YWtlLCBzb21lIHRpbWVzIGl0IHdpbGwgb2NjdXIgZXhj
bHVzaXZlIHRpbWVvdXQuCgpTaWduZWQtb2ZmLWJ5OiBFbWlseSBEZW5nIDxFbWlseS5EZW5nQGFt
ZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyB8IDIgKy0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCmluZGV4IGY3MTYxNWUuLjA2MjM5MWUgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwpAQCAtMzIwLDcgKzMyMCw3IEBAIHNpZ25lZCBs
b25nICBhbWRncHVfa2lxX3JlZ193cml0ZV9yZWdfd2FpdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwKIAlzdHJ1Y3QgYW1kZ3B1X2tpcSAqa2lxID0gJmFkZXYtPmdmeC5raXE7CiAJc3RydWN0
IGFtZGdwdV9yaW5nICpyaW5nID0gJmtpcS0+cmluZzsKIAotCWlmICghcmluZy0+cmVhZHkpCisJ
aWYgKCFyaW5nLT5yZWFkeSB8fCAhYW1kZ3B1X3NyaW92X3J1bnRpbWUoYWRldikgJiYgYW1kZ3B1
X3NyaW92X3ZmKGFkZXYpKQogCQlyZXR1cm4gLUVJTlZBTDsKIAogCXNwaW5fbG9ja19pcnFzYXZl
KCZraXEtPnJpbmdfbG9jaywgZmxhZ3MpOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
