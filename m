From: James Zhu <James.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu:Correct max uvd handles
Date: Tue,  6 Mar 2018 15:14:05 -0500
Message-ID: <1520367246-8734-1-git-send-email-James.Zhu@amd.com>
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

TWF4IHV2ZCBoYW5kbGVzIHNob3VsZCB1c2UgYWRldi0+dXZkLm1heF9oYW5kbGVzIGluc3RlYWQg
b2YKQU1ER1BVX01BWF9VVkRfSEFORExFUyBoZXJlLgoKU2lnbmVkLW9mZi1ieTogSmFtZXMgWmh1
IDxKYW1lcy5aaHVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdXZkLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZk
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMKaW5kZXggN2FkODE0
ZC4uOWQwMzdjYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3V2ZC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYwpAQCAt
MzAzLDcgKzMwMyw3IEBAIGludCBhbWRncHVfdXZkX3N1c3BlbmQoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCiAJCWlmIChhdG9taWNfcmVhZCgmYWRldi0+dXZkLmhhbmRsZXNbaV0pKQogCQkJ
YnJlYWs7CiAKLQlpZiAoaSA9PSBBTURHUFVfTUFYX1VWRF9IQU5ETEVTKQorCWlmIChpID09IGFk
ZXYtPnV2ZC5tYXhfaGFuZGxlcykKIAkJcmV0dXJuIDA7CiAKIAlzaXplID0gYW1kZ3B1X2JvX3Np
emUoYWRldi0+dXZkLnZjcHVfYm8pOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
