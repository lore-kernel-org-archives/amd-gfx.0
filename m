From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 32/76] drm/amd/dal: Remove adapter service dependency in
 power_down
Date: Mon, 21 Nov 2016 18:00:52 -0500
Message-ID: <20161121230136.5208-33-harry.wentland@amd.com>
References: <20161121230136.5208-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161121230136.5208-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CkFj
a2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9kY2UvZGNlX2xpbmtfZW5jb2Rlci5jIHwgMiArLQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwvZGMvZGNlL2RjZV9saW5rX2VuY29kZXIuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGFsL2RjL2RjZS9kY2VfbGlua19lbmNvZGVyLmMKaW5kZXggNjcwZDdm
Mzk4N2QwLi5mZWY3YmM0YzMzY2IgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGFs
L2RjL2RjZS9kY2VfbGlua19lbmNvZGVyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwv
ZGMvZGNlL2RjZV9saW5rX2VuY29kZXIuYwpAQCAtMTM2MCw3ICsxMzYwLDcgQEAgdm9pZCBkY2Ux
MTBfbGlua19lbmNvZGVyX2Rpc2FibGVfb3V0cHV0KAogCXN0cnVjdCBicF90cmFuc21pdHRlcl9j
b250cm9sIGNudGwgPSB7IDAgfTsKIAllbnVtIGJwX3Jlc3VsdCByZXN1bHQ7CiAKLQlpZiAoIWlz
X2RpZ19lbmFibGVkKGVuYzExMCkgJiYKKwlpZiAoIWlzX2RpZ19lbmFibGVkKGVuYzExMCkgJiYg
ZW5jMTEwLT5iYXNlLmFkYXB0ZXJfc2VydmljZSAmJgogCQlkYWxfYWRhcHRlcl9zZXJ2aWNlX3No
b3VsZF9vcHRpbWl6ZSgKIAkJCWVuYzExMC0+YmFzZS5hZGFwdGVyX3NlcnZpY2UsCiAJCQlPRl9T
S0lQX1BPV0VSX0RPV05fSU5BQ1RJVkVfRU5DT0RFUikpIHsKLS0gCjIuMTAuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
