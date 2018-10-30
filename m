From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/4] drm/amdgpu: cleanup si_dma_ring_test_ib
Date: Tue, 30 Oct 2018 13:17:52 +0100
Message-ID: <20181030121753.28255-3-christian.koenig@amd.com>
References: <20181030121753.28255-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181030121753.28255-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

QWNjaWRlbnRpYWxseSBtaXNzZWQgZHVyaW5nIHRoZSBsYXN0IGNsZWFudXAuCgpTaWduZWQtb2Zm
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZG1hLmMgfCA3ICsrLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZG1hLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zaV9kbWEuYwppbmRleCA2ODcxOGRkZjZlZDAuLmJmZjY5NTRjMjE1MCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZG1hLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc2lfZG1hLmMKQEAgLTI4NiwxMyArMjg2LDEwIEBAIHN0YXRpYyBpbnQgc2lf
ZG1hX3JpbmdfdGVzdF9pYihzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIGxvbmcgdGltZW91dCkK
IAkJZ290byBlcnIxOwogCX0KIAl0bXAgPSBsZTMyX3RvX2NwdShhZGV2LT53Yi53YltpbmRleF0p
OwotCWlmICh0bXAgPT0gMHhERUFEQkVFRikgewotCQlEUk1fREVCVUcoImliIHRlc3Qgb24gcmlu
ZyAlZCBzdWNjZWVkZWRcbiIsIHJpbmctPmlkeCk7CisJaWYgKHRtcCA9PSAweERFQURCRUVGKQog
CQlyID0gMDsKLQl9IGVsc2UgewotCQlEUk1fRVJST1IoImFtZGdwdTogaWIgdGVzdCBmYWlsZWQg
KDB4JTA4WClcbiIsIHRtcCk7CisJZWxzZQogCQlyID0gLUVJTlZBTDsKLQl9CiAKIGVycjE6CiAJ
YW1kZ3B1X2liX2ZyZWUoYWRldiwgJmliLCBOVUxMKTsKLS0gCjIuMTQuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
