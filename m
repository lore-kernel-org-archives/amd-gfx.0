From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 02/18] drm/amdgpu:no kiq in IH
Date: Mon, 18 Sep 2017 14:11:46 +0800
Message-ID: <1505715122-23904-3-git-send-email-Monk.Liu@amd.com>
References: <1505715122-23904-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1505715122-23904-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJNGRlYjY1Njc1ZDI1MzEyMzZiMmY0ZTJiYzZmMDE1YzY1NzU0NjQ2NApTaWdu
ZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS92ZWdhMTBfaWguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2Ex
MF9paC5jCmluZGV4IDY3NjEwZjcuLmMyOTFlMzMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3ZlZ2ExMF9paC5jCkBAIC0yMTksOSArMjE5LDkgQEAgc3RhdGljIHUzMiB2ZWdhMTBfaWhfZ2V0
X3dwdHIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCQl3cHRyLCBhZGV2LT5pcnEuaWgu
cnB0ciwgdG1wKTsKIAkJYWRldi0+aXJxLmloLnJwdHIgPSB0bXA7CiAKLQkJdG1wID0gUlJFRzMy
KFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAwLCBtbUlIX1JCX0NOVEwpKTsKKwkJdG1wID0gUlJF
RzMyX05PX0tJUShTT0MxNV9SRUdfT0ZGU0VUKE9TU1NZUywgMCwgbW1JSF9SQl9DTlRMKSk7CiAJ
CXRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBJSF9SQl9DTlRMLCBXUFRSX09WRVJGTE9XX0NMRUFS
LCAxKTsKLQkJV1JFRzMyKFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAwLCBtbUlIX1JCX0NOVEwp
LCB0bXApOworCQlXUkVHMzJfTk9fS0lRKFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAwLCBtbUlI
X1JCX0NOVEwpLCB0bXApOwogCX0KIAlyZXR1cm4gKHdwdHIgJiBhZGV2LT5pcnEuaWgucHRyX21h
c2spOwogfQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
