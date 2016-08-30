From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 10/14] drm/amdgpu: add rv770_get_memory_type to set the GDDR5
 flag
Date: Tue, 30 Aug 2016 19:50:07 +0800
Message-ID: <1472557811-8015-11-git-send-email-ray.huang@amd.com>
References: <1472557811-8015-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472557811-8015-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Hui Yu <Hui.Yu-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

QWRkIHJ2NzcwX2dldF9tZW1vcnlfdHlwZSB0byBzZXQgbWVtX2dkZHI1IGZsYWcsIGJlY2F1c2Ug
aXQgd2lsbCBiZQp1c2VkIG9uIHRoZSB3aG9sZSBzaSBkcG0gcGFydC4KCkNoYW5nZS1JZDogSTYw
ZjdlZjM4Nzc1YzNiMjdlNDc1ZjM4ZjkzOTkwNTQ4M2ZiYjU2ZjUKU2lnbmVkLW9mZi1ieTogSHVh
bmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zaV9kcG0uYyB8IDE2ICsrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBt
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYwppbmRleCA1ZjFlNWZlLi41
NjNhZWVhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYwpAQCAtNjQzMyw4ICs2NDMz
LDI0IEBAIHN0YXRpYyB2b2lkIHNpX3NldF9wY2llX2xhbmVfd2lkdGhfaW5fc21jKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LAogCX0KIH0KIAordm9pZCBydjc3MF9nZXRfbWVtb3J5X3R5cGUo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCit7CisJc3RydWN0IHJ2N3h4X3Bvd2VyX2luZm8g
KnBpID0gcnY3NzBfZ2V0X3BpKGFkZXYpOworCXUzMiB0bXA7CisKKwl0bXAgPSBSUkVHMzIoTUNf
U0VRX01JU0MwKTsKKworCWlmICgoKHRtcCAmIE1DX1NFUV9NSVNDMF9HRERSNV9NQVNLKSA+PiBN
Q19TRVFfTUlTQzBfR0REUjVfU0hJRlQpID09CisJICAgIE1DX1NFUV9NSVNDMF9HRERSNV9WQUxV
RSkKKwkJcGktPm1lbV9nZGRyNSA9IHRydWU7CisJZWxzZQorCQlwaS0+bWVtX2dkZHI1ID0gZmFs
c2U7CisKK30KKwogc3RhdGljIHZvaWQgc2lfZHBtX3NldHVwX2FzaWMoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpCiB7CisJcnY3NzBfZ2V0X21lbW9yeV90eXBlKGFkZXYpOwogCXNpX3JlYWRf
Y2xvY2tfcmVnaXN0ZXJzKGFkZXYpOwogCXNpX2VuYWJsZV9hY3BpX3Bvd2VyX21hbmFnZW1lbnQo
YWRldik7CiB9Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
