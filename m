From: chen gong <curry.gong-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: Use mode2 mode to perform GPU RESET for Renoir
Date: Mon, 23 Sep 2019 14:14:08 +0800
Message-ID: <1569219248-29457-2-git-send-email-curry.gong@amd.com>
References: <1569219248-29457-1-git-send-email-curry.gong@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1569219248-29457-1-git-send-email-curry.gong-5C7GfCeVMHo@public.gmane.org>
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
Cc: chen gong <curry.gong-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogY2hlbiBnb25nIDxjdXJyeS5nb25nQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29j
MTUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKaW5kZXggNTg4MTg3NjEu
LjBmNjM5ZGY5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKQEAgLTUxNCw2ICs1MTQs
OCBAQCBzdGF0aWMgaW50IHNvYzE1X2FzaWNfYmFjb19yZXNldChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKIAogc3RhdGljIGludCBzb2MxNV9tb2RlMl9yZXNldChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKIHsKKwlpZiAoaXNfc3VwcG9ydF9zd19zbXUoYWRldikpCisJCXJldHVybiBz
bXVfbW9kZTJfcmVzZXQoJmFkZXYtPnNtdSk7CiAJaWYgKCFhZGV2LT5wb3dlcnBsYXkucHBfZnVu
Y3MgfHwKIAkgICAgIWFkZXYtPnBvd2VycGxheS5wcF9mdW5jcy0+YXNpY19yZXNldF9tb2RlXzIp
CiAJCXJldHVybiAtRU5PRU5UOwpAQCAtNTI4LDYgKzUzMCw3IEBAIHNvYzE1X2FzaWNfcmVzZXRf
bWV0aG9kKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCiAJc3dpdGNoIChhZGV2LT5hc2lj
X3R5cGUpIHsKIAljYXNlIENISVBfUkFWRU46CisJY2FzZSBDSElQX1JFTk9JUjoKIAkJcmV0dXJu
IEFNRF9SRVNFVF9NRVRIT0RfTU9ERTI7CiAJY2FzZSBDSElQX1ZFR0ExMDoKIAljYXNlIENISVBf
VkVHQTEyOgotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
