From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 73/73] drm/amd/display: Fix use before initialize warning
Date: Thu, 9 Nov 2017 15:06:09 -0500
Message-ID: <20171109200609.14566-74-harry.wentland@amd.com>
References: <20171109200609.14566-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171109200609.14566-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Leo (Sunpeng) Li" <sunpeng.li-5C7GfCeVMHo@public.gmane.org>

RnJvbTogIkxlbyAoU3VucGVuZykgTGkiIDxzdW5wZW5nLmxpQGFtZC5jb20+CgpvbiBzdHJlYW1f
Zm9yX2N1cnNvci4gSW5pdGlhbGl6ZSB0byBOVUxMLgoKQ2hhbmdlLUlkOiBJYzAzMmJmZTc4YjMz
ZTQ2NmU1NjBkMzM0ODhlMGZkOGRmMDYwZjY5NApTaWduZWQtb2ZmLWJ5OiBMZW8gKFN1bnBlbmcp
IExpIDxzdW5wZW5nLmxpQGFtZC5jb20+ClJldmlld2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8SGFy
cnkuV2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGNuMTAvZGNuMTBfaHdfc2VxdWVuY2VyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfaHdfc2VxdWVuY2VyLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfaHdfc2VxdWVuY2VyLmMKaW5kZXggMzBmNDU4NzAx
ZjljLi5iNWQwNDhiMzY0YTQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY24xMC9kY24xMF9od19zZXF1ZW5jZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfaHdfc2VxdWVuY2VyLmMKQEAgLTIxMjQsNyArMjEyNCw3
IEBAIHN0YXRpYyB2b2lkIGRjbjEwX2FwcGx5X2N0eF9mb3Jfc3VyZmFjZSgKIAl9CiAKIAlpZiAo
bnVtX3BsYW5lcyA+IDApIHsKLQkJc3RydWN0IGRjX3N0cmVhbV9zdGF0ZSAqc3RyZWFtX2Zvcl9j
dXJzb3I7CisJCXN0cnVjdCBkY19zdHJlYW1fc3RhdGUgKnN0cmVhbV9mb3JfY3Vyc29yID0gTlVM
TDsKIAogCQlwcm9ncmFtX2FsbF9waXBlX2luX3RyZWUoZGMsIHRvcF9waXBlX3RvX3Byb2dyYW0s
IGNvbnRleHQpOwogCi0tIAoyLjE0LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
