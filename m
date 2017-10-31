From: Pixel Ding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu: return error when sriov access requests get
 timeout (v2)
Date: Tue, 31 Oct 2017 16:17:06 +0800
Message-ID: <1509437826-15668-1-git-send-email-Pixel.Ding@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org
Cc: pding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>

RnJvbTogcGRpbmcgPFBpeGVsLkRpbmdAYW1kLmNvbT4KCnYyOgogLSByZWFkYWJsZQoKUmVwb3J0
ZWQtYnk6IFN1biBHYXJ5IDxHYXJ5LlN1bkBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBwZGluZyA8
UGl4ZWwuRGluZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1
X3ZpLmMgfCA2ICsrKystLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV92
aS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfdmkuYwppbmRleCA4MThlYzBm
Li4yYjQzNWMwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV92
aS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X3ZpLmMKQEAgLTQ0Niw4
ICs0NDYsMTAgQEAgc3RhdGljIGludCB4Z3B1X3ZpX3NlbmRfYWNjZXNzX3JlcXVlc3RzKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LAogCQlyZXF1ZXN0ID09IElESF9SRVFfR1BVX0ZJTklfQUND
RVNTIHx8CiAJCXJlcXVlc3QgPT0gSURIX1JFUV9HUFVfUkVTRVRfQUNDRVNTKSB7CiAJCXIgPSB4
Z3B1X3ZpX3BvbGxfbXNnKGFkZXYsIElESF9SRUFEWV9UT19BQ0NFU1NfR1BVKTsKLQkJaWYgKHIp
Ci0JCQlwcl9lcnIoIkRvZXNuJ3QgZ2V0IGFjayBmcm9tIHBmLCBjb250aW51ZVxuIik7CisJCWlm
IChyKSB7CisJCQlwcl9lcnIoIkRvZXNuJ3QgZ2V0IGFjayBmcm9tIHBmLCBnaXZlIHVwXG4iKTsK
KwkJCXJldHVybiByOworCQl9CiAJfQogCiAJcmV0dXJuIDA7Ci0tIAoyLjkuNQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
