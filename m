From: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: set vm size as 256TB for Vega10
Date: Wed, 29 Mar 2017 16:08:32 +0800
Message-ID: <1490774912-583-2-git-send-email-Jerry.Zhang@amd.com>
References: <1490774912-583-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490774912-583-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDUgKysrKysKIDEgZmls
ZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMKaW5kZXggMWFkMTExMy4uNGFmNGVhMCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMTA4MCw2ICsxMDgwLDExIEBAIHN0YXRp
YyB2b2lkIGFtZGdwdV9nZXRfYmxvY2tfc2l6ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikK
IAogc3RhdGljIHZvaWQgYW1kZ3B1X2NoZWNrX3ZtX3NpemUoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCiB7CisJaWYgKGFkZXYtPmFzaWNfdHlwZSA+PSBDSElQX1ZFR0ExMCkgeworCQlhbWRn
cHVfdm1fc2l6ZSA9IDFVIDw8IDE4OyAvKiAyNTZUQiAqLworCQlyZXR1cm47CisJfQorCiAJaWYg
KCFhbWRncHVfY2hlY2tfcG90X2FyZ3VtZW50KGFtZGdwdV92bV9zaXplKSkgewogCQlkZXZfd2Fy
bihhZGV2LT5kZXYsICJWTSBzaXplICglZCkgbXVzdCBiZSBhIHBvd2VyIG9mIDJcbiIsCiAJCQkg
YW1kZ3B1X3ZtX3NpemUpOwotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
