From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm 2/2] amdgpu: Fix segfault in deadlock test.
Date: Thu, 25 Jan 2018 13:10:59 -0500
Message-ID: <1516903859-3679-2-git-send-email-andrey.grodzovsky@amd.com>
References: <1516903859-3679-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1516903859-3679-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org

SWYgYW1kZ3B1X2NzX3F1ZXJ5X2ZlbmNlX3N0YXR1cyB0ZXJtaW5hdGVzIHByZW1hdHVyZWx5IHRo
ZSBCTwpzb21ldGltZXMgaXMgdW5tYXBwZWQgYmVmb3JlIGhlbHBlciB0aHJlYWQgd3JpdGVzIGEg
dmxhdWUKaW50byBpdCBjYXVzaW5nIGEgc2VnZmF1bHQuCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZXkg
R3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4KLS0tCiB0ZXN0cy9hbWRncHUv
ZGVhZGxvY2tfdGVzdHMuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy9hbWRncHUvZGVhZGxvY2tfdGVz
dHMuYyBiL3Rlc3RzL2FtZGdwdS9kZWFkbG9ja190ZXN0cy5jCmluZGV4IDlhNDI4ODUuLmZjNDlj
NDggMTAwNjQ0Ci0tLSBhL3Rlc3RzL2FtZGdwdS9kZWFkbG9ja190ZXN0cy5jCisrKyBiL3Rlc3Rz
L2FtZGdwdS9kZWFkbG9ja190ZXN0cy5jCkBAIC0yNDUsNiArMjQ1LDggQEAgc3RhdGljIHZvaWQg
YW1kZ3B1X2RlYWRsb2NrX2hlbHBlcih1bnNpZ25lZCBpcF90eXBlKQogCQkJQU1ER1BVX1RJTUVP
VVRfSU5GSU5JVEUsMCwgJmV4cGlyZWQpOwogCUNVX0FTU0VSVF9FUVVBTCgociA9PSAwIHx8IHIg
PT0gLUVDQU5DRUxFRCksIDEpOwogCisJcHRocmVhZF9qb2luKHN0cmVzc190aHJlYWQsIE5VTEwp
OworCiAJciA9IGFtZGdwdV9ib19saXN0X2Rlc3Ryb3koYm9fbGlzdCk7CiAJQ1VfQVNTRVJUX0VR
VUFMKHIsIDApOwogCkBAIC0yNTQsNiArMjU2LDQgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2RlYWRs
b2NrX2hlbHBlcih1bnNpZ25lZCBpcF90eXBlKQogCiAJciA9IGFtZGdwdV9jc19jdHhfZnJlZShj
b250ZXh0X2hhbmRsZSk7CiAJQ1VfQVNTRVJUX0VRVUFMKHIsIDApOwotCi0JcHRocmVhZF9qb2lu
KHN0cmVzc190aHJlYWQsIE5VTEwpOwogfQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
