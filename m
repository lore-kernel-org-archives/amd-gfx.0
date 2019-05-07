From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/4] drm/amd/powerplay: avoid repeat AVFS
 enablement/disablement
Date: Tue, 7 May 2019 14:08:58 +0800
Message-ID: <20190507060859.27650-3-evan.quan@amd.com>
References: <20190507060859.27650-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190507060859.27650-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
Cc: yanik-4pJZyYNR0dgOIzVOb1FTxg@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

Tm8gbmVlZCB0byBlbmFibGUgb3IgZGlzYWJsZSBBVkZTIGlmIGl0J3MgYWxyZWFkeSBpbiB3YW50
ZWQKc3RhdGUuCgpDaGFuZ2UtSWQ6IEk4NjJjMGMzZDY0MmU2YTBkYzdiYjM0ZTA0YzVhNTlmMTdi
NmI4ZGViClNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmMgfCA0ICsr
KysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jCmluZGV4IDEwM2Y3ZTNmMDc4
My4uZjRiODFmNTBiMTg1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9od21nci92ZWdhMTBfaHdtZ3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9od21nci92ZWdhMTBfaHdtZ3IuYwpAQCAtMjM2NCw2ICsyMzY0LDEwIEBAIHN0YXRpYyBpbnQg
dmVnYTEwX2F2ZnNfZW5hYmxlKHN0cnVjdCBwcF9od21nciAqaHdtZ3IsIGJvb2wgZW5hYmxlKQog
CXN0cnVjdCB2ZWdhMTBfaHdtZ3IgKmRhdGEgPSBod21nci0+YmFja2VuZDsKIAogCWlmIChkYXRh
LT5zbXVfZmVhdHVyZXNbR05MRF9BVkZTXS5zdXBwb3J0ZWQpIHsKKwkJLyogQWxyZWFkeSBlbmFi
bGVkIG9yIGRpc2FibGVkICovCisJCWlmICghKGVuYWJsZSBeIGRhdGEtPnNtdV9mZWF0dXJlc1tH
TkxEX0FWRlNdLmVuYWJsZWQpKQorCQkJcmV0dXJuIDA7CisKIAkJaWYgKGVuYWJsZSkgewogCQkJ
UFBfQVNTRVJUX1dJVEhfQ09ERSghdmVnYTEwX2VuYWJsZV9zbWNfZmVhdHVyZXMoaHdtZ3IsCiAJ
CQkJCXRydWUsCi0tIAoyLjIxLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
