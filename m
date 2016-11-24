From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 33/39] drm/amd/dal: fix warning in dce110_resource.c
Date: Wed, 23 Nov 2016 21:03:02 -0500
Message-ID: <20161124020308.28124-34-harry.wentland@amd.com>
References: <20161124020308.28124-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161124020308.28124-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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

RnJvbTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKQ2hhbmdlLUlk
OiBJNDU0ZTU4ZmY4Nzg5MTc3ZTZjNzVkZjU5ZDEwZWQ4MzAxOTg3MDgxOQpTaWduZWQtb2ZmLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkFja2VkLWJ5OiBIYXJy
eSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2RhbC9kYy9kY2UxMTAvZGNlMTEwX3Jlc291cmNlLmMgfCAxIC0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwvZGMv
ZGNlMTEwL2RjZTExMF9yZXNvdXJjZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwvZGMvZGNl
MTEwL2RjZTExMF9yZXNvdXJjZS5jCmluZGV4IGRhYzUzZGYyY2I4Ni4uOWQ3ZmI4MzJkZDE1IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9kY2UxMTAvZGNlMTEwX3Jlc291
cmNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwvZGMvZGNlMTEwL2RjZTExMF9yZXNv
dXJjZS5jCkBAIC0xMjQyLDcgKzEyNDIsNiBAQCBzdGF0aWMgYm9vbCBjb25zdHJ1Y3QoCiAJc3Ry
dWN0IGZpcm13YXJlX2luZm8gaW5mbzsKIAlzdHJ1Y3QgZGNfYmlvcyAqYnA7CiAJc3RydWN0IGRt
X3BwX3N0YXRpY19jbG9ja19pbmZvIHN0YXRpY19jbGtfaW5mbyA9IHswfTsKLQlzdHJ1Y3QgcmVz
b3VyY2Vfc3RyYXBzIHN0cmFwcyA9IHswfTsKIAogCWN0eC0+ZGNfYmlvcy0+cmVncyA9ICZiaW9z
X3JlZ3M7CiAKLS0gCjIuMTAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
