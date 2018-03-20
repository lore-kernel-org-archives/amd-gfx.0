From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 16/34] drm/amd/display: Change wb_h/vratio to double
Date: Tue, 20 Mar 2018 15:12:41 -0400
Message-ID: <20180320191259.14453-17-harry.wentland@amd.com>
References: <20180320191259.14453-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180320191259.14453-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Eric Bernstein <eric.bernstein-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRXJpYyBCZXJuc3RlaW4gPGVyaWMuYmVybnN0ZWluQGFtZC5jb20+CgpTaWduZWQtb2Zm
LWJ5OiBFcmljIEJlcm5zdGVpbiA8ZXJpYy5iZXJuc3RlaW5AYW1kLmNvbT4KUmV2aWV3ZWQtYnk6
IERteXRybyBMYWt0eXVzaGtpbiA8RG15dHJvLkxha3R5dXNoa2luQGFtZC5jb20+CkFja2VkLWJ5
OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2Rpc3BsYXlfbW9kZV9zdHJ1Y3RzLmggfCA0ICsrLS0K
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kaXNwbGF5X21vZGVfc3Ry
dWN0cy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kaXNwbGF5X21vZGVf
c3RydWN0cy5oCmluZGV4IDA5YWZmYTE2Y2M0My4uZTI5NmRlNmNhNTAyIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2Rpc3BsYXlfbW9kZV9zdHJ1Y3RzLmgK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kaXNwbGF5X21vZGVfc3Ry
dWN0cy5oCkBAIC0yMTUsOCArMjE1LDggQEAgc3RydWN0IHdyaXRlYmFja19zdCB7CiAJaW50IHdi
X3Z0YXBzX2x1bWE7CiAJaW50IHdiX2h0YXBzX2Nocm9tYTsKIAlpbnQgd2JfdnRhcHNfY2hyb21h
OwotCWludCB3Yl9ocmF0aW87Ci0JaW50IHdiX3ZyYXRpbzsKKwlkb3VibGUgd2JfaHJhdGlvOwor
CWRvdWJsZSB3Yl92cmF0aW87CiB9OwogCiBzdHJ1Y3QJX3Zjc19kcGlfZGlzcGxheV9vdXRwdXRf
cGFyYW1zX3N0CXsKLS0gCjIuMTQuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
