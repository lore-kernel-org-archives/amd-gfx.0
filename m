From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amd/powerplay: remove uncessary extra gfxoff control
 call
Date: Tue, 12 Jun 2018 17:07:44 +0800
Message-ID: <1528794464-30951-2-git-send-email-evan.quan@amd.com>
References: <1528794464-30951-1-git-send-email-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1528794464-30951-1-git-send-email-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
Cc: ray.huang-5C7GfCeVMHo@public.gmane.org, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

R2Z4b2ZmIGlzIGFscmVhZHkgZW5hYmxlZCBpbiBhbWRncHVfZGV2aWNlX2lwX3NldF9wb3dlcmdh
dGluZ19zdGF0ZS4KU28sIG5vIG5lZWQgdG8gZW5hYmxlIGl0IGFnYWluIGluIHBwX2xhdGVfaW5p
dC4KCkNoYW5nZS1JZDogSWQzM2QyZGFjMTkyNjQ1ZmM5ZGNkZmFmNTgyNTQyMDA5M2E4N2Y4MTQK
U2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMgfCA4IC0tLS0tLS0tCiAxIGZp
bGUgY2hhbmdlZCwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9hbWRfcG93ZXJwbGF5LmMKaW5kZXggMDk2OWI2NS4uYzZhYTdkMCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYwpAQCAtMTkxLDE0ICsxOTEs
NiBAQCBzdGF0aWMgaW50IHBwX2xhdGVfaW5pdCh2b2lkICpoYW5kbGUpCiAJaWYgKGFkZXYtPnBt
LnNtdV9wcnZfYnVmZmVyX3NpemUgIT0gMCkKIAkJcHBfcmVzZXJ2ZV92cmFtX2Zvcl9zbXUoYWRl
dik7CiAKLQlpZiAoaHdtZ3IgJiYgaHdtZ3ItPmh3bWdyX2Z1bmMgJiYKLQkgICAgaHdtZ3ItPmh3
bWdyX2Z1bmMtPmdmeF9vZmZfY29udHJvbCAmJgotCSAgICAoaHdtZ3ItPmZlYXR1cmVfbWFzayAm
IFBQX0dGWE9GRl9NQVNLKSkgewotCQlyZXQgPSBod21nci0+aHdtZ3JfZnVuYy0+Z2Z4X29mZl9j
b250cm9sKGh3bWdyLCB0cnVlKTsKLQkJaWYgKHJldCkKLQkJCXByX2VycigiZ2Z4IG9mZiBlbmFi
bGluZyBmYWlsZWQhXG4iKTsKLQl9Ci0KIAlyZXR1cm4gMDsKIH0KIAotLSAKMi43LjQKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
