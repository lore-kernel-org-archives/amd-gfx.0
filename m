From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 03/39] drm/amd/dal: correcting the wait for
 DP_MSE_RATE_UPDATE_PENDING reset
Date: Wed, 23 Nov 2016 21:02:32 -0500
Message-ID: <20161124020308.28124-4-harry.wentland@amd.com>
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
Cc: Reza Amini <reza.amini-5C7GfCeVMHo@public.gmane.org>

RnJvbTogUmV6YSBBbWluaSA8cmV6YS5hbWluaUBhbWQuY29tPgoKQ2hhbmdlLUlkOiBJYjkwZmZm
ZTM0MzgzMDY1ZGU3YzJjNzRkMDVjM2ViN2M0NTFjNDNlMgpTaWduZWQtb2ZmLWJ5OiBSZXphIEFt
aW5pIDxyZXphLmFtaW5pQGFtZC5jb20+CkFja2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnku
d2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9kY2UvZGNl
X3N0cmVhbV9lbmNvZGVyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9k
Y2UvZGNlX3N0cmVhbV9lbmNvZGVyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9kY2Uv
ZGNlX3N0cmVhbV9lbmNvZGVyLmMKaW5kZXggOTNjZTQ5NjdlNTZiLi4xNzczOTNkZjIyZWMgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGFsL2RjL2RjZS9kY2Vfc3RyZWFtX2VuY29k
ZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9kY2UvZGNlX3N0cmVhbV9lbmNv
ZGVyLmMKQEAgLTQ1Niw3ICs0NTYsNyBAQCBzdGF0aWMgdm9pZCBkY2UxMTBfc3RyZWFtX2VuY29k
ZXJfc2V0X21zdF9iYW5kd2lkdGgoCiAJLyogaS5lLiBEUF9NU0VfUkFURV9VUERBVEVfUEVORElO
RyBmaWVsZCAocmVhZCBvbmx5KSAqLwogCS8qIGlzIHJlc2V0IHRvIDAgKG5vdCBwZW5kaW5nKSAq
LwogCVJFR19XQUlUKERQX01TRV9SQVRFX1VQREFURSwgRFBfTVNFX1JBVEVfVVBEQVRFX1BFTkRJ
TkcsCi0JCQkxLAorCQkJMCwKIAkJCTEwLCBEUF9NU1RfVVBEQVRFX01BWF9SRVRSWSk7CiB9CiAK
LS0gCjIuMTAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
