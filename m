From: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] amdgpu: add REPLACE and CLEAR checking for VA op
Date: Fri, 17 Mar 2017 13:59:22 +0800
Message-ID: <1489730362-31095-3-git-send-email-Jerry.Zhang@amd.com>
References: <1489730362-31095-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1489730362-31095-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org, nicolai.haehnle-5C7GfCeVMHo@public.gmane.org

U2lnbmVkLW9mZi1ieTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgotLS0KIGFt
ZGdwdS9hbWRncHVfYm8uYyB8IDUgKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hbWRncHUvYW1kZ3B1X2JvLmMgYi9hbWRn
cHUvYW1kZ3B1X2JvLmMKaW5kZXggNzFjZDY2Ni4uOGZlM2NmZCAxMDA2NDQKLS0tIGEvYW1kZ3B1
L2FtZGdwdV9iby5jCisrKyBiL2FtZGdwdS9hbWRncHVfYm8uYwpAQCAtOTUyLDcgKzk1MiwxMCBA
QCBpbnQgYW1kZ3B1X2JvX3ZhX29wX3JhdyhhbWRncHVfZGV2aWNlX2hhbmRsZSBkZXYsCiAJc3Ry
dWN0IGRybV9hbWRncHVfZ2VtX3ZhIHZhOwogCWludCByOwogCi0JaWYgKG9wcyAhPSBBTURHUFVf
VkFfT1BfTUFQICYmIG9wcyAhPSBBTURHUFVfVkFfT1BfVU5NQVApCisJaWYgKG9wcyAhPSBBTURH
UFVfVkFfT1BfTUFQICYmIG9wcyAhPSBBTURHUFVfVkFfT1BfVU5NQVAgJiYKKwkJCW9wcyAhPSBB
TURHUFVfVkFfT1BfUkVQTEFDRSAmJgorCQkJb3BzICE9IEFNREdQVV9WQV9PUF9DTEVBUikKKwog
CQlyZXR1cm4gLUVJTlZBTDsKIAogCW1lbXNldCgmdmEsIDAsIHNpemVvZih2YSkpOwotLSAKMS45
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
