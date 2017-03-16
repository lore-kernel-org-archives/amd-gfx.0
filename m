From: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/4] amdgpu: set va flag with input parameter
Date: Thu, 16 Mar 2017 11:56:39 +0800
Message-ID: <1489636601-31486-3-git-send-email-Jerry.Zhang@amd.com>
References: <1489636601-31486-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1489636601-31486-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgotLS0KIGFt
ZGdwdS9hbWRncHVfYm8uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FtZGdwdS9hbWRncHVfYm8uYyBiL2FtZGdwdS9h
bWRncHVfYm8uYwppbmRleCA2MTg5ZTVhLi44MDBiNzdhIDEwMDY0NAotLS0gYS9hbWRncHUvYW1k
Z3B1X2JvLmMKKysrIGIvYW1kZ3B1L2FtZGdwdV9iby5jCkBAIC05NDEsNyArOTQxLDcgQEAgaW50
IGFtZGdwdV9ib192YV9vcChhbWRncHVfYm9faGFuZGxlIGJvLAogCW1lbXNldCgmdmEsIDAsIHNp
emVvZih2YSkpOwogCXZhLmhhbmRsZSA9IGJvLT5oYW5kbGU7CiAJdmEub3BlcmF0aW9uID0gb3Bz
OwotCXZhLmZsYWdzID0gQU1ER1BVX1ZNX1BBR0VfUkVBREFCTEUgfAorCXZhLmZsYWdzID0gZmxh
Z3MgfCBBTURHUFVfVk1fUEFHRV9SRUFEQUJMRSB8CiAJCSAgIEFNREdQVV9WTV9QQUdFX1dSSVRF
QUJMRSB8CiAJCSAgIEFNREdQVV9WTV9QQUdFX0VYRUNVVEFCTEU7CiAJdmEudmFfYWRkcmVzcyA9
IGFkZHI7Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
