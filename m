From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 44/76] drm/amd/dal: Fix null pointer missed in earlier refactor
Date: Mon, 21 Nov 2016 18:01:04 -0500
Message-ID: <20161121230136.5208-45-harry.wentland@amd.com>
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
ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9ncHUvZGNlMTEwL2Rpc3BsYXlfY2xvY2tfZGNlMTEwLmMg
fCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9ncHUvZGNlMTEwL2Rpc3BsYXlf
Y2xvY2tfZGNlMTEwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9ncHUvZGNlMTEwL2Rp
c3BsYXlfY2xvY2tfZGNlMTEwLmMKaW5kZXggYWYwNDM0OGQyYTdhLi45YTA5MzhkNTQ1M2EgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGFsL2RjL2dwdS9kY2UxMTAvZGlzcGxheV9j
bG9ja19kY2UxMTAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9ncHUvZGNlMTEw
L2Rpc3BsYXlfY2xvY2tfZGNlMTEwLmMKQEAgLTkzMCw3ICs5MzAsNyBAQCBzdGF0aWMgYm9vbCBk
YWxfZGlzcGxheV9jbG9ja19kY2UxMTBfY29uc3RydWN0KAogCXN0cnVjdCBhZGFwdGVyX3NlcnZp
Y2UgKmFzKQogewogCXN0cnVjdCBkaXNwbGF5X2Nsb2NrICpkY19iYXNlID0gJmRjMTEwLT5kaXNw
X2Nsa19iYXNlOwotCXN0cnVjdCBkY19iaW9zICpicCA9IGRjMTEwLT5kaXNwX2Nsa19iYXNlLmN0
eC0+ZGNfYmlvczsKKwlzdHJ1Y3QgZGNfYmlvcyAqYnAgPSBjdHgtPmRjX2Jpb3M7CiAKIAlpZiAo
TlVMTCA9PSBhcykKIAkJcmV0dXJuIGZhbHNlOwotLSAKMi4xMC4xCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
