From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 12/25] drm/amdkfd: Use per-device sched_policy
Date: Tue,  6 Feb 2018 20:32:41 -0500
Message-ID: <1517967174-21709-13-git-send-email-Felix.Kuehling@amd.com>
References: <1517967174-21709-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1517967174-21709-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

VGhpcyB3YXMgbWlzc2VkIGluIGEgcHJldmlvdXMgY29tbWl0IHRoYXQgbWFkZSB0aGUgc2NoZWR1
bGVyIHBvbGljeQphIHBlci1kZXZpY2Ugc2V0dGluZy4KClNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1
ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwppbmRleCBkY2E2MjU3Li40
N2Q0OTNlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNl
X3F1ZXVlX21hbmFnZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2
aWNlX3F1ZXVlX21hbmFnZXIuYwpAQCAtMTI5Niw3ICsxMjk2LDcgQEAgc3RydWN0IGRldmljZV9x
dWV1ZV9tYW5hZ2VyICpkZXZpY2VfcXVldWVfbWFuYWdlcl9pbml0KHN0cnVjdCBrZmRfZGV2ICpk
ZXYpCiAJCWRxbS0+b3BzLnByb2Nlc3NfdGVybWluYXRpb24gPSBwcm9jZXNzX3Rlcm1pbmF0aW9u
X25vY3BzY2g7CiAJCWJyZWFrOwogCWRlZmF1bHQ6Ci0JCXByX2VycigiSW52YWxpZCBzY2hlZHVs
aW5nIHBvbGljeSAlZFxuIiwgc2NoZWRfcG9saWN5KTsKKwkJcHJfZXJyKCJJbnZhbGlkIHNjaGVk
dWxpbmcgcG9saWN5ICVkXG4iLCBkcW0tPnNjaGVkX3BvbGljeSk7CiAJCWdvdG8gb3V0X2ZyZWU7
CiAJfQogCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
