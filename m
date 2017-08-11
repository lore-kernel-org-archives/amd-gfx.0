From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 02/19] drm/amdkfd: Fix typo in dbgdev_wave_reset_wavefronts
Date: Fri, 11 Aug 2017 17:56:12 -0400
Message-ID: <1502488589-30272-3-git-send-email-Felix.Kuehling@amd.com>
References: <1502488589-30272-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1502488589-30272-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RiZ2Rldi5jIHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RiZ2Rldi5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2RiZ2Rldi5jCmluZGV4IGQ1ZTE5YjUuLjhiMTRhNGUgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kYmdkZXYuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfZGJnZGV2LmMKQEAgLTgyMyw3ICs4MjMsNyBAQCBpbnQgZGJn
ZGV2X3dhdmVfcmVzZXRfd2F2ZWZyb250cyhzdHJ1Y3Qga2ZkX2RldiAqZGV2LCBzdHJ1Y3Qga2Zk
X3Byb2Nlc3MgKnApCiAJZm9yICh2bWlkID0gZmlyc3Rfdm1pZF90b19zY2FuOyB2bWlkIDw9IGxh
c3Rfdm1pZF90b19zY2FuOyB2bWlkKyspIHsKIAkJaWYgKGRldi0+a2ZkMmtnZC0+Z2V0X2F0Y192
bWlkX3Bhc2lkX21hcHBpbmdfdmFsaWQKIAkJCQkoZGV2LT5rZ2QsIHZtaWQpKSB7Ci0JCQlpZiAo
ZGV2LT5rZmQya2dkLT5nZXRfYXRjX3ZtaWRfcGFzaWRfbWFwcGluZ192YWxpZAorCQkJaWYgKGRl
di0+a2ZkMmtnZC0+Z2V0X2F0Y192bWlkX3Bhc2lkX21hcHBpbmdfcGFzaWQKIAkJCQkJKGRldi0+
a2dkLCB2bWlkKSA9PSBwLT5wYXNpZCkgewogCQkJCXByX2RlYnVnKCJLaWxsaW5nIHdhdmUgZnJv
bnRzIG9mIHZtaWQgJWQgYW5kIHBhc2lkICVkXG4iLAogCQkJCQkJdm1pZCwgcC0+cGFzaWQpOwot
LSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
