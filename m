From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 20/27] drm/amd/display: Do not copy bottom pipe when map
 resource.
Date: Wed, 8 Mar 2017 16:55:00 -0500
Message-ID: <20170308215507.28079-21-harry.wentland@amd.com>
References: <20170308215507.28079-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170308215507.28079-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Yongqiang Sun <yongqiang.sun-5C7GfCeVMHo@public.gmane.org>

RnJvbTogWW9uZ3FpYW5nIFN1biA8eW9uZ3FpYW5nLnN1bkBhbWQuY29tPgoKQ2hhbmdlLUlkOiBJ
MzA2NTgyNTc4MzJiZTM4NjVmM2YzYWYwYjQ3MWZkNDkwZmFiNDQyNgpTaWduZWQtb2ZmLWJ5OiBZ
b25ncWlhbmcgU3VuIDx5b25ncWlhbmcuc3VuQGFtZC5jb20+CkFja2VkLWJ5OiBIYXJyeSBXZW50
bGFuZCA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IFRvbnkgQ2hlbmcgPFRv
bnkuQ2hlbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29y
ZS9kY19yZXNvdXJjZS5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19yZXNv
dXJjZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfcmVzb3VyY2Uu
YwppbmRleCBmMWIxZGFlNTM5OWUuLmMzOGY3MWU0NTM4MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfcmVzb3VyY2UuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19yZXNvdXJjZS5jCkBAIC0xMTM0LDYgKzExMzQs
OSBAQCBlbnVtIGRjX3N0YXR1cyByZXNvdXJjZV9tYXBfcG9vbF9yZXNvdXJjZXMoCiAJCQlpZiAo
IWFyZV9zdHJlYW1fYmFja2VuZHNfc2FtZShvbGRfcGlwZV9jdHgtPnN0cmVhbSwgc3RyZWFtKSkK
IAkJCQljb250aW51ZTsKIAorCQkJaWYgKG9sZF9waXBlX2N0eC0+dG9wX3BpcGUpCisJCQkJY29u
dGludWU7CisKIAkJCXBpcGVfY3R4LT5zdHJlYW0gPSBzdHJlYW07CiAJCQljb3B5X3BpcGVfY3R4
KG9sZF9waXBlX2N0eCwgcGlwZV9jdHgpOwogCi0tIAoyLjEwLjIKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
