From: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgu/vce_v3: start vce block before ring test
Date: Mon, 4 Feb 2019 12:44:06 +0000
Message-ID: <1549284230-32705-1-git-send-email-shirish.s@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "S,
 Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>

dmNlIHJpbmcgdGVzdCBmYWlscyBkdXJpbmcgcmVzdW1lIHNpbmNlIG1tVkNFX1JCX1JQVFIqCmlz
IG5vdCBpbnRpdGFsaXplZC91cGRhdGVkLgoKSGVuY2Ugc3RhcnQgdmNlIGJsb2NrIGJlZm9yZSBy
aW5nIHRlc3QuCgpTaWduZWQtb2ZmLWJ5OiBTaGlyaXNoIFMgPHNoaXJpc2guc0BhbWQuY29tPgot
LS0KKiB2Y2VfdjRfMC5jJ3MgaHdfaW5pdCBzZXF1ZW5jZSBhbHJlYWR5IGhhcyB0aGlzIGNoYW5n
ZS4KCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjNfMC5jIHwgNCArKysrCiAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmNlX3YzXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92
M18wLmMKaW5kZXggNmVjNjVjZjEuLmQ4MDljMTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3ZjZV92M18wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dmNlX3YzXzAuYwpAQCAtNDY5LDYgKzQ2OSwxMCBAQCBzdGF0aWMgaW50IHZjZV92M18wX2h3X2lu
aXQodm9pZCAqaGFuZGxlKQogCWludCByLCBpOwogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOwogCisJciA9IHZjZV92M18wX3N0YXJ0
KGFkZXYpOworCWlmIChyKQorCQlyZXR1cm4gcjsKKwogCXZjZV92M18wX292ZXJyaWRlX3ZjZV9j
bG9ja19nYXRpbmcoYWRldiwgdHJ1ZSk7CiAKIAlhbWRncHVfYXNpY19zZXRfdmNlX2Nsb2Nrcyhh
ZGV2LCAxMDAwMCwgMTAwMDApOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
