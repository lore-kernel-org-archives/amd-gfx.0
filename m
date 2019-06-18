From: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm 1/4] amdgpu: add navi family id
Date: Tue, 18 Jun 2019 19:40:30 +0800
Message-ID: <1560858033-1499-1-git-send-email-Hawking.Zhang@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

RnJvbTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KClNpZ25lZC1vZmYtYnk6IEh1YW5n
IFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdr
aW5nLlpoYW5nQGFtZC5jb20+Ci0tLQogaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oIHwgMSArCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9h
bWRncHVfZHJtLmggYi9pbmNsdWRlL2RybS9hbWRncHVfZHJtLmgKaW5kZXggM2QwMzE4ZS4uYjI4
ZmVlNCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oCisrKyBiL2luY2x1ZGUv
ZHJtL2FtZGdwdV9kcm0uaApAQCAtMTA0NSw2ICsxMDQ1LDcgQEAgc3RydWN0IGRybV9hbWRncHVf
aW5mb192Y2VfY2xvY2tfdGFibGUgewogI2RlZmluZSBBTURHUFVfRkFNSUxZX0NaCQkJMTM1IC8q
IENhcnJpem8sIFN0b25leSAqLwogI2RlZmluZSBBTURHUFVfRkFNSUxZX0FJCQkJMTQxIC8qIFZl
Z2ExMCAqLwogI2RlZmluZSBBTURHUFVfRkFNSUxZX1JWCQkJMTQyIC8qIFJhdmVuICovCisjZGVm
aW5lIEFNREdQVV9GQU1JTFlfTlYJCQkxNDMgLyogTmF2aTEwICovCiAKICNpZiBkZWZpbmVkKF9f
Y3BsdXNwbHVzKQogfQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
