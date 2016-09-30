From: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] tests/amdgpu: update vce encRefPic addr mode to tiled
Date: Fri, 30 Sep 2016 13:20:55 -0400
Message-ID: <1475256055-2546-1-git-send-email-leo.liu@amd.com>
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
Cc: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>

QWRhcHQgdG8gcmVjZW50IGZpcm13YXJlIHVwZGF0ZSwgaXQncyBhbHNvIGNvbXBhdGlibGUgd2l0
aCBwcmV2aW91cwpmaXJ3bWFyZSB2ZXJzaW9uCgpTaWduZWQtb2ZmLWJ5OiBMZW8gTGl1IDxsZW8u
bGl1QGFtZC5jb20+Ci0tLQogdGVzdHMvYW1kZ3B1L3ZjZV9pYi5oIHwgMiArLQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMv
YW1kZ3B1L3ZjZV9pYi5oIGIvdGVzdHMvYW1kZ3B1L3ZjZV9pYi5oCmluZGV4IGJkMGJmOTQuLjgw
YWIxNzkgMTAwNjQ0Ci0tLSBhL3Rlc3RzL2FtZGdwdS92Y2VfaWIuaAorKysgYi90ZXN0cy9hbWRn
cHUvdmNlX2liLmgKQEAgLTUzLDcgKzUzLDcgQEAgc3RhdGljIGNvbnN0IHVpbnQzMl90IHZjZV9j
cmVhdGVbXSA9IHsKIAkweDAwMDAwMGEwLAogCTB4MDAwMDAwYTAsCiAJMHgwMDAwMDAxMCwKLQkw
eDAwMDAwMDAwLAorCTB4MDAwMDAyMDEsCiB9OwogCiBzdGF0aWMgY29uc3QgdWludDMyX3QgdmNl
X3JhdGVfY3RybFtdID0gewotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
