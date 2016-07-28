From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [Part II PATCH 06/15] drm/amdgpu: fix incorrect type of info_id
Date: Thu, 28 Jul 2016 15:24:56 +0800
Message-ID: <1469690705-877-7-git-send-email-ray.huang@amd.com>
References: <1469690705-877-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469690705-877-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2luY2x1ZGUvY2dzX2NvbW1vbi5oIHwgMTAgKysrKystLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvY2dzX2NvbW1vbi5oIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9pbmNsdWRlL2Nnc19jb21tb24uaAppbmRleCBmMzJhZjJmLi5lZDVmYTMzIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvY2dzX2NvbW1vbi5oCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvaW5jbHVkZS9jZ3NfY29tbW9uLmgKQEAgLTEyMSwxMyArMTIxLDEzIEBAIGVu
dW0gY2dzX3N5c3RlbV9pbmZvX2lkIHsKIH07CiAKIHN0cnVjdCBjZ3Nfc3lzdGVtX2luZm8gewot
CXVpbnQ2NF90ICAgICAgIHNpemU7Ci0JdWludDY0X3QgICAgICAgaW5mb19pZDsKKwl1aW50NjRf
dAkJCXNpemU7CisJZW51bSBjZ3Nfc3lzdGVtX2luZm9faWQJCWluZm9faWQ7CiAJdW5pb24gewot
CQl2b2lkICAgICAgICAgICAqcHRyOwotCQl1aW50NjRfdCAgICAgICAgdmFsdWU7CisJCXZvaWQJ
CQkqcHRyOworCQl1aW50NjRfdAkJdmFsdWU7CiAJfTsKLQl1aW50NjRfdCAgICAgICAgICAgICAg
IHBhZGRpbmdbMTNdOworCXVpbnQ2NF90CQkJcGFkZGluZ1sxM107CiB9OwogCiAvKgotLSAKMi43
LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
