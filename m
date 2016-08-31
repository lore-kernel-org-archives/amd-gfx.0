From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 08/15] drm/amdgpu/si: drop ASIC_IS_DCE6 macro on SI
Date: Wed, 31 Aug 2016 13:23:20 +0800
Message-ID: <1472621007-17578-9-git-send-email-ray.huang@amd.com>
References: <1472621007-17578-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472621007-17578-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Hui Yu <Hui.Yu-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

RHJvcCBBU0lDX0lTX0RDRTYgbWFjcm8sIGJlY2F1c2UgaXQgd2lsbCBjaGVjayB0aGUgYXNpYyB0
eXBlcwpleHBsaWNpdGx5IGluIGZ1dHVyZS4KCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1
YW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FzaWNfcmVnL3Np
L3NpZC5oIHwgMSAtCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hc2ljX3JlZy9zaS9zaWQuaCBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvaW5jbHVkZS9hc2ljX3JlZy9zaS9zaWQuaAppbmRleCA5NjA5MTk5Li44YzU2
MDhhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXNpY19yZWcvc2kv
c2lkLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FzaWNfcmVnL3NpL3NpZC5o
CkBAIC0xOTY4LDcgKzE5NjgsNiBAQAogI2RlZmluZSBBTURHUFVfTU1fSU5ERVgJCSAgICAgICAg
MHgwMDAwCiAjZGVmaW5lIEFNREdQVV9NTV9EQVRBCQkgICAgICAgIDB4MDAwMQogCi0jZGVmaW5l
IEFTSUNfSVNfRENFNihhZGV2KSAoKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZFUkRFKSkKICNk
ZWZpbmUgVkVSREVfTlVNX0NSVEMgNgogI2RlZmluZQlCTEFDS09VVF9NT0RFX01BU0sJCQkweDAw
MDAwMDA3CiAjZGVmaW5lCVZHQV9SRU5ERVJfQ09OVFJPTAkJCTB4QzAKLS0gCjIuNy40CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
