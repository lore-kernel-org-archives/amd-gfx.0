From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu: always un-gate UVD REGS path.
Date: Wed, 9 Nov 2016 18:08:54 +0800
Message-ID: <1478686135-21055-1-git-send-email-Rex.Zhu@amd.com>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJOTEwYTc5YjU1MWE5Yjc5YjYzNTE2MWJiNDJhYzEyM2EyMzc4MzIyNQpTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdXZkX3Y0XzIuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y0XzIu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NF8yLmMKaW5kZXggZDJjOTZmMS4u
ZDY4Njk0NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y0XzIu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjRfMi5jCkBAIC01OTYsNyAr
NTk2LDEwIEBAIHN0YXRpYyB2b2lkIHV2ZF92NF8yX3NldF9kY20oc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsCiAJCQkgICAgIGJvb2wgc3dfbW9kZSkKIHsKIAl1MzIgdG1wLCB0bXAyOworCXUz
MiBkYXRhID0gUlJFRzMyKG1tVVZEX0NHQ19HQVRFKTsKIAorCWRhdGEgJj0gflVWRF9DR0NfR0FU
RV9fUkVHU19NQVNLOworCVdSRUczMihtbVVWRF9DR0NfR0FURSwgZGF0YSk7CiAJdG1wID0gUlJF
RzMyKG1tVVZEX0NHQ19DVFJMKTsKIAl0bXAgJj0gfihVVkRfQ0dDX0NUUkxfX0NMS19PRkZfREVM
QVlfTUFTSyB8IFVWRF9DR0NfQ1RSTF9fQ0xLX0dBVEVfRExZX1RJTUVSX01BU0spOwogCXRtcCB8
PSBVVkRfQ0dDX0NUUkxfX0RZTl9DTE9DS19NT0RFX01BU0sgfAotLSAKMS45LjEKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
