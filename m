From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Change AMDGPU_CSA_SIZE to 128K
Date: Wed, 24 Oct 2018 20:09:26 +0800
Message-ID: <1540382966-2038-1-git-send-email-Rex.Zhu@amd.com>
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

SW4gb3JkZXIgdG8gc3VwcG9ydCBuZXcgYXNpY3MgYW5kIE1DQlAgZmVhdHVyZQplbmFibGVtZW50
IG9uIGJhcmVtZXRhbC4KClNpZ25lZC1vZmYtYnk6IFJleCBaaHUgPFJleC5aaHVAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3NhLmggfCAyICstCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3NhLmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfY3NhLmgKaW5kZXggZWYyZGZiMC4uNTI0YjQ0MyAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzYS5oCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jc2EuaApAQCAtMjUsNyArMjUsNyBAQAogI2lmbmRl
ZiBBTURHUFVfQ1NBX01BTkFHRVJfSAogI2RlZmluZSBBTURHUFVfQ1NBX01BTkFHRVJfSAogCi0j
ZGVmaW5lIEFNREdQVV9DU0FfU0laRQkJKDggKiAxMDI0KQorI2RlZmluZSBBTURHUFVfQ1NBX1NJ
WkUJCSgxMjggKiAxMDI0KQogCiB1aW50MzJfdCBhbWRncHVfZ2V0X3RvdGFsX2NzYV9zaXplKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKIHVpbnQ2NF90IGFtZGdwdV9jc2FfdmFkZHIoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
