From: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/sdma5: do not execute 0-sized IBs (v2)
Date: Tue, 22 Oct 2019 17:22:11 +0000
Message-ID: <20191022172136.15391-1-pierre-eric.pelloux-prayer@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer-5C7GfCeVMHo@public.gmane.org>

VGhpcyBzZWVtcyB0byBoZWxwIHdpdGggaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy9zaG93
X2J1Zy5jZ2k/aWQ9MTExNDgxLgoKdjI6IGluc2VydCBhIE5PUCBpbnN0ZWFkIG9mIHNraXBwaW5n
IGFsbCAwLXNpemVkIElCcyB0byBhdm9pZCBicmVha2luZyBvbGRlciBodwoKU2lnbmVkLW9mZi1i
eTogUGllcnJlLUVyaWMgUGVsbG91eC1QcmF5ZXIgPHBpZXJyZS1lcmljLnBlbGxvdXgtcHJheWVy
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgfCAx
ICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ21jX3YxMF8wLmMKaW5kZXggZmI0ODYyMmMyYWJkLi42ZTFiMjViZDFmZTcgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCkBAIC0zMDksNiArMzA5LDcgQEAgc3RhdGlj
IHZvaWQgZ21jX3YxMF8wX2ZsdXNoX2dwdV90bGIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
IHVpbnQzMl90IHZtaWQsCiAKIAlqb2ItPnZtX3BkX2FkZHIgPSBhbWRncHVfZ21jX3BkX2FkZHIo
YWRldi0+Z2FydC5ibyk7CiAJam9iLT52bV9uZWVkc19mbHVzaCA9IHRydWU7CisJam9iLT5pYnMt
PnB0cltqb2ItPmlicy0+bGVuZ3RoX2R3KytdID0gcmluZy0+ZnVuY3MtPm5vcDsKIAlhbWRncHVf
cmluZ19wYWRfaWIocmluZywgJmpvYi0+aWJzWzBdKTsKIAlyID0gYW1kZ3B1X2pvYl9zdWJtaXQo
am9iLCAmYWRldi0+bW1hbi5lbnRpdHksCiAJCQkgICAgICBBTURHUFVfRkVOQ0VfT1dORVJfVU5E
RUZJTkVELCAmZmVuY2UpOwotLSAKMi4yMy4wLnJjMQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4
