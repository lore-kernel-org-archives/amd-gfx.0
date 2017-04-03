From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 15/16] drm/amd/display: Log clock source in error condition
Date: Mon, 3 Apr 2017 19:43:17 -0400
Message-ID: <20170403234318.26100-16-harry.wentland@amd.com>
References: <20170403234318.26100-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170403234318.26100-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Jordan Lazare <Jordan.Lazare-5C7GfCeVMHo@public.gmane.org>

RnJvbTogSm9yZGFuIExhemFyZSA8Sm9yZGFuLkxhemFyZUBhbWQuY29tPgoKQ2hhbmdlLUlkOiBJ
NmE3ODcxNjJkOWVmNTc0NzE3NDNlNzg2YzZkOWYzYjhiOGRjMjczZQpTaWduZWQtb2ZmLWJ5OiBK
b3JkYW4gTGF6YXJlIDxKb3JkYW4uTGF6YXJlQGFtZC5jb20+ClJldmlld2VkLWJ5OiBIYXJyeSBX
ZW50bGFuZCA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNlL2RjZV9od3NlcS5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9od3NlcS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjZS9kY2VfaHdzZXEuYwppbmRleCAxN2NkZDcwYTJjMjcuLjM0YzE4NzEyOTcwYyAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfaHdzZXEu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9od3NlcS5jCkBA
IC0xODcsNiArMTg3LDcgQEAgdm9pZCBkY2VfY3J0Y19zd2l0Y2hfdG9fY2xrX3NyYyhzdHJ1Y3Qg
ZGNlX2h3c2VxICpod3MsCiAJCQlSRUdfVVBEQVRFKFBIWVBMTF9QSVhFTF9SQVRFX0NOVExbdGdf
aW5zdF0sCiAJCQkJCVBJWEVMX1JBVEVfUExMX1NPVVJDRSwgMSk7CiAJfSBlbHNlIHsKLQkJRENf
RVJSKCJ1bmtub3duIGNsb2NrIHNvdXJjZSIpOworCQlEQ19FUlIoIlVua25vd24gY2xvY2sgc291
cmNlLiBjbGtfc3JjIGlkOiAlZCwgVEdfaW5zdDogJWQiLAorCQkgICAgICAgY2xrX3NyYy0+aWQs
IHRnX2luc3QpOwogCX0KIH0KLS0gCjIuMTEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
