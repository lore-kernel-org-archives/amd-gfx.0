From: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm v2] amdgpu: add REPLACE and CLEAR checking for VA op
 (v2)
Date: Wed, 22 Mar 2017 11:14:00 +0800
Message-ID: <1490152440-3721-1-git-send-email-Jerry.Zhang@amd.com>
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
To: nicolai.haehnle-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>

djI6IGZpeCBpbmRlbnQKClNpZ25lZC1vZmYtYnk6IEp1bndlaSBaaGFuZyA8SmVycnkuWmhhbmdA
YW1kLmNvbT4KLS0tCiBhbWRncHUvYW1kZ3B1X2JvLmMgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hbWRncHUvYW1k
Z3B1X2JvLmMgYi9hbWRncHUvYW1kZ3B1X2JvLmMKaW5kZXggNzFjZDY2Ni4uODUwZmU4YyAxMDA2
NDQKLS0tIGEvYW1kZ3B1L2FtZGdwdV9iby5jCisrKyBiL2FtZGdwdS9hbWRncHVfYm8uYwpAQCAt
OTUyLDcgKzk1Miw5IEBAIGludCBhbWRncHVfYm9fdmFfb3BfcmF3KGFtZGdwdV9kZXZpY2VfaGFu
ZGxlIGRldiwKIAlzdHJ1Y3QgZHJtX2FtZGdwdV9nZW1fdmEgdmE7CiAJaW50IHI7CiAKLQlpZiAo
b3BzICE9IEFNREdQVV9WQV9PUF9NQVAgJiYgb3BzICE9IEFNREdQVV9WQV9PUF9VTk1BUCkKKwlp
ZiAob3BzICE9IEFNREdQVV9WQV9PUF9NQVAgJiYgb3BzICE9IEFNREdQVV9WQV9PUF9VTk1BUCAm
JgorCSAgICBvcHMgIT0gQU1ER1BVX1ZBX09QX1JFUExBQ0UgJiYgb3BzICE9IEFNREdQVV9WQV9P
UF9DTEVBUikKKwogCQlyZXR1cm4gLUVJTlZBTDsKIAogCW1lbXNldCgmdmEsIDAsIHNpemVvZih2
YSkpOwotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
