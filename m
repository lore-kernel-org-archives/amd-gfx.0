From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 05/11] drm/amd/dal/dc: fix warning in
 dal_display_clock_dce112_construct
Date: Tue, 22 Nov 2016 11:57:22 -0500
Message-ID: <1479833848-14275-5-git-send-email-alexander.deucher@amd.com>
References: <1479833848-14275-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1479833848-14275-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

UmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwvZGMvZ3B1L2RjZTExMi9kaXNwbGF5X2Nsb2NrX2RjZTEx
Mi5jIHwgMSAtCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGFsL2RjL2dwdS9kY2UxMTIvZGlzcGxheV9jbG9ja19kY2UxMTIu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGFsL2RjL2dwdS9kY2UxMTIvZGlzcGxheV9jbG9ja19k
Y2UxMTIuYwppbmRleCA2MDBhMDljLi5lODE5NzI1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2RhbC9kYy9ncHUvZGNlMTEyL2Rpc3BsYXlfY2xvY2tfZGNlMTEyLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kYWwvZGMvZ3B1L2RjZTExMi9kaXNwbGF5X2Nsb2NrX2RjZTExMi5j
CkBAIC04NDMsNyArODQzLDYgQEAgYm9vbCBkYWxfZGlzcGxheV9jbG9ja19kY2UxMTJfY29uc3Ry
dWN0KAogCXN0cnVjdCBkaXNwbGF5X2Nsb2NrX2RjZTExMiAqZGMxMTIsCiAJc3RydWN0IGRjX2Nv
bnRleHQgKmN0eCkKIHsKLQlzdHJ1Y3QgZG1fcHBfc3RhdGljX2Nsb2NrX2luZm8gKnN0YXRpY19j
bGtfaW5mbyA9IHswfTsKIAlzdHJ1Y3QgZGlzcGxheV9jbG9jayAqZGNfYmFzZSA9ICZkYzExMi0+
ZGlzcF9jbGtfYmFzZTsKIAogCS8qaWYgKE5VTEwgPT0gYXMpCi0tIAoyLjUuNQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
