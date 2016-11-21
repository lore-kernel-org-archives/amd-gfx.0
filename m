From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 07/76] drm/amd/dal: Fix warning about comparing different types
Date: Mon, 21 Nov 2016 18:00:27 -0500
Message-ID: <20161121230136.5208-8-harry.wentland@amd.com>
References: <20161121230136.5208-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161121230136.5208-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CkFj
a2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9jb3JlL2RjLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2RhbC9kYy9jb3JlL2RjLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9jb3Jl
L2RjLmMKaW5kZXggZTQ5OTA5ODM5MjRlLi5hZDQ4ODRhNmY5OGQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGFsL2RjL2NvcmUvZGMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2RhbC9kYy9jb3JlL2RjLmMKQEAgLTY1MCw3ICs2NTAsNyBAQCB2b2lkIFByb2dyYW1QaXhlbER1
cmF0aW9uVih1bnNpZ25lZCBpbnQgcGl4ZWxDbG9ja0luS0h6ICkKIHN0cnVjdCBkYyAqZGNfY3Jl
YXRlKGNvbnN0IHN0cnVjdCBkY19pbml0X2RhdGEgKmluaXRfcGFyYW1zKQogIHsKIAlzdHJ1Y3Qg
Y29yZV9kYyAqY29yZV9kYyA9IGRtX2FsbG9jKHNpemVvZigqY29yZV9kYykpOwotCWludCBmdWxs
X3BpcGVfY291bnQ7CisJdW5zaWduZWQgaW50IGZ1bGxfcGlwZV9jb3VudDsKIAogCWlmIChOVUxM
ID09IGNvcmVfZGMpCiAJCWdvdG8gYWxsb2NfZmFpbDsKLS0gCjIuMTAuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
