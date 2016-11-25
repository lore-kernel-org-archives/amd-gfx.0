From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/5] drm/amd/dal: enhance debug print in REG_WAIT
Date: Fri, 25 Nov 2016 16:59:41 -0500
Message-ID: <20161125215941.29972-6-harry.wentland@amd.com>
References: <20161125215941.29972-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161125215941.29972-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tony Cheng <tony.cheng-5C7GfCeVMHo@public.gmane.org>

RnJvbTogVG9ueSBDaGVuZyA8dG9ueS5jaGVuZ0BhbWQuY29tPgoKQ2hhbmdlLUlkOiBJNGJjMjhk
ZDhkZjE1MzM3NjkzZTMxMWUwMjU1YjRmMGNmZWIyMjkwOQpTaWduZWQtb2ZmLWJ5OiBUb255IENo
ZW5nIDx0b255LmNoZW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBSZXZpZXdlZC1ieTogVG9ueSBD
aGVuZyA8VG9ueS5DaGVuZ0BhbWQuY29tPgpBY2tlZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5
LndlbnRsYW5kQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwvZGMvZGNfaGVs
cGVyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9kY19oZWxwZXIuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGFsL2RjL2RjX2hlbHBlci5jCmluZGV4IDIyYjcyZjBiY2Ji
Yy4uM2E4MGIwYzA4YWU0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9k
Y19oZWxwZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9kY19oZWxwZXIuYwpA
QCAtMTM4LDcgKzEzOCw3IEBAIHVpbnQzMl90IGdlbmVyaWNfcmVnX3dhaXQoY29uc3Qgc3RydWN0
IGRjX2NvbnRleHQgKmN0eCwKIAkJCXJldHVybiByZWdfdmFsOwogCX0KIAotCURDX0VSUigiUkVH
X1dBSVQgdGltZW91dCAlZHVzICogJWQgdHJpZXMgLSAiLAorCURDX0VSUigiUkVHX1dBSVQgdGlt
ZW91dCAlZHVzICogJWQgdHJpZXMgLSAlcyIsCiAJCQlkZWxheV9iZXR3ZWVuX3BvbGxfdXMsIHRp
bWVfb3V0X251bV90cmllcywgZnVuY19uYW1lKTsKIAlyZXR1cm4gcmVnX3ZhbDsKIH0KLS0gCjIu
MTAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
