From: zhengbin <zhengbin13-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/5] drm/amd/powerplay: Remove unneeded variable
Date: Wed, 27 Nov 2019 17:33:37 +0800
Message-ID: <1574847222-51515-1-git-send-email-zhengbin13@huawei.com>
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
To: alexander.deucher-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, David1.Zhou-5C7GfCeVMHo@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, rex.zhu-5C7GfCeVMHo@public.gmane.org, evan.quan-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: zhengbin13-hv44wF8Li93QT0dZR+AlfA@public.gmane.org

emhlbmdiaW4gKDUpOgogIGRybS9hbWQvcG93ZXJwbGF5OiBSZW1vdmUgdW5uZWVkZWQgdmFyaWFi
bGUgJ3Jlc3VsdCcgaW4gc211MTBfaHdtZ3IuYwogIGRybS9hbWQvcG93ZXJwbGF5OiBSZW1vdmUg
dW5uZWVkZWQgdmFyaWFibGUgJ3Jlc3VsdCcgaW4gdmVnYTEwX2h3bWdyLmMKICBkcm0vYW1kL3Bv
d2VycGxheTogUmVtb3ZlIHVubmVlZGVkIHZhcmlhYmxlICdyZXQnIGluIHNtdTdfaHdtZ3IuYwog
IGRybS9hbWQvcG93ZXJwbGF5OiBSZW1vdmUgdW5uZWVkZWQgdmFyaWFibGUgJ3Jlc3VsdCcgaW4g
dmVnYTEyX2h3bWdyLmMKICBkcm0vYW1kL3Bvd2VycGxheTogUmVtb3ZlIHVubmVlZGVkIHZhcmlh
YmxlICdyZXQnIGluIGFtZGdwdV9zbXUuYwoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L2FtZGdwdV9zbXUuYyAgICAgICAgIHwgOCArKystLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvaHdtZ3Ivc211MTBfaHdtZ3IuYyAgfCAzICstLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jICAgfCA0ICstLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jIHwgMyArLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl9od21nci5jIHwgNCArLS0tCiA1IGZpbGVz
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCgotLQoyLjcuNAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
