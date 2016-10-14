From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/7] drm/amdgpu: check min clock set by DAL before set ps.
Date: Fri, 14 Oct 2016 20:06:40 +0800
Message-ID: <1476446806-8918-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJZDcxYjlhMzMyOWE4YTE0M2ExODliMjc1OTI2YjBhMjA1NGJmMGJiOAotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2NpX2RwbS5jIHwgNiArKysrKysKIDEgZmlsZSBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9jaV9kcG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2NpX2RwbS5jCmlu
ZGV4IDFkOGMzNzUuLmZkMmZlODUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2NpX2RwbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2NpX2RwbS5jCkBA
IC05NjAsNiArOTYwLDEyIEBAIHN0YXRpYyB2b2lkIGNpX2FwcGx5X3N0YXRlX2FkanVzdF9ydWxl
cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJc2NsayA9IHBzLT5wZXJmb3JtYW5jZV9s
ZXZlbHNbMF0uc2NsazsKIAl9CiAKKwlpZiAoYWRldi0+cG0ucG1fZGlzcGxheV9jZmcubWluX2Nv
cmVfc2V0X2Nsb2NrID4gc2NsaykKKwkJc2NsayA9IGFkZXYtPnBtLnBtX2Rpc3BsYXlfY2ZnLm1p
bl9jb3JlX3NldF9jbG9jazsKKworCWlmIChhZGV2LT5wbS5wbV9kaXNwbGF5X2NmZy5taW5fbWVt
X3NldF9jbG9jayA+IG1jbGspCisJCW1jbGsgPSBhZGV2LT5wbS5wbV9kaXNwbGF5X2NmZy5taW5f
bWVtX3NldF9jbG9jazsKKwogCWlmIChycHMtPnZjZV9hY3RpdmUpIHsKIAkJaWYgKHNjbGsgPCBh
ZGV2LT5wbS5kcG0udmNlX3N0YXRlc1thZGV2LT5wbS5kcG0udmNlX2xldmVsXS5zY2xrKQogCQkJ
c2NsayA9IGFkZXYtPnBtLmRwbS52Y2Vfc3RhdGVzW2FkZXYtPnBtLmRwbS52Y2VfbGV2ZWxdLnNj
bGs7Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
