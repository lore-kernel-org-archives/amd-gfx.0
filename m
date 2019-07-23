From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] drm/amdgpu/powerplay/vega12: call PrepareMp1ForUnload in
 power_off_asic
Date: Tue, 23 Jul 2019 12:00:49 -0500
Message-ID: <20190723170049.9143-3-alexander.deucher@amd.com>
References: <20190723170049.9143-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190723170049.9143-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

TmVlZGVkIHRvIG1ha2Ugc3VyZSB0aGUgc211IGlzIGlkbGUgd2hlbiByZXNldHRpbmcuIFRoaXMg
bWF5IGZpeApzcG9yYXRpYyBmYWlsdXJlcyB3aXRoIEdQVSByZXNldC4KClNpZ25lZC1vZmYtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTJfaHdtZ3IuYyB8IDUgKysrKysKIDEgZmls
ZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9od21nci92ZWdhMTJfaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl9od21nci5jCmluZGV4IGVmYjZkMzc2MmZlYi4uM2QzNTA0
NDExYjYzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92
ZWdhMTJfaHdtZ3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92
ZWdhMTJfaHdtZ3IuYwpAQCAtMjQ2OCw2ICsyNDY4LDExIEBAIHN0YXRpYyBpbnQgdmVnYTEyX3Bv
d2VyX29mZl9hc2ljKHN0cnVjdCBwcF9od21nciAqaHdtZ3IpCiAJCQkpOwogCWRhdGEtPndhdGVy
X21hcmtzX2JpdG1hcCAmPSB+KFdhdGVyTWFya3NMb2FkZWQpOwogCisJUFBfQVNTRVJUX1dJVEhf
Q09ERSgocmVzdWx0ID0gc211bV9zZW5kX21zZ190b19zbWMoaHdtZ3IsCisJCQlQUFNNQ19NU0df
UHJlcGFyZU1wMUZvclVubG9hZCkpID09IDAsCisJCQkiW1ByZXBhcmVNcDFGb3JVbmxvYWRdIEZh
aWxlZCEiLAorCQkJcmV0dXJuIHJlc3VsdCk7CisKIAlyZXR1cm4gcmVzdWx0OwogfQogCi0tIAoy
LjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
