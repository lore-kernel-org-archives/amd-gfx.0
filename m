From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 8/8] drm/amdgpu: use paging queue for VM page table updates
Date: Mon,  8 Oct 2018 15:35:21 +0200
Message-ID: <20181008133521.3237-8-christian.koenig@amd.com>
References: <20181008133521.3237-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181008133521.3237-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

T25seSBmb3IgdGVzdGluZywgbm90IHN1cmUgaWYgd2Ugc2hvdWxkIGtlZXAgaXQgbGlrZSB0aGlz
LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jIHwgMiArLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYwppbmRleCBhMzYyOTA0ZDczZjcuLjVmYTgwYjIzMWRh
MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMKQEAgLTIwNTIsNyArMjA1
Miw3IEBAIHN0YXRpYyB2b2lkIHNkbWFfdjRfMF9zZXRfdm1fcHRlX2Z1bmNzKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQogCiAJYWRldi0+dm1fbWFuYWdlci52bV9wdGVfZnVuY3MgPSAmc2Rt
YV92NF8wX3ZtX3B0ZV9mdW5jczsKIAlmb3IgKGkgPSAwOyBpIDwgYWRldi0+c2RtYS5udW1faW5z
dGFuY2VzOyBpKyspIHsKLQkJc2NoZWQgPSAmYWRldi0+c2RtYS5pbnN0YW5jZVtpXS5yaW5nLnNj
aGVkOworCQlzY2hlZCA9ICZhZGV2LT5zZG1hLmluc3RhbmNlW2ldLnBhZ2Uuc2NoZWQ7CiAJCWFk
ZXYtPnZtX21hbmFnZXIudm1fcHRlX3Jxc1tpXSA9CiAJCQkmc2NoZWQtPnNjaGVkX3JxW0RSTV9T
Q0hFRF9QUklPUklUWV9LRVJORUxdOwogCX0KLS0gCjIuMTQuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
