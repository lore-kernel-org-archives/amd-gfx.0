From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 6/6] drm/amdgpu: dependency is already signaled if ctx has
 been freed
Date: Thu, 18 Aug 2016 15:50:18 +0800
Message-ID: <1471506618-29849-7-git-send-email-David1.Zhou@amd.com>
References: <1471506618-29849-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471506618-29849-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David.Mao-5C7GfCeVMHo@public.gmane.org

SXQgbWFrZXMgc3VyZSB1c2Vyc3BhY2UgY2FuIGxvb2sgdXAgZGVwZW5kZW5jeS4KCkNoYW5nZS1J
ZDogSWUyNjA4Njc3NmRlN2RmMjc2ZmEwNDFkOTc3ZjBlYTgyNjRiMzIzODcKU2lnbmVkLW9mZi1i
eTogQ2h1bm1pbmcgWmhvdSA8RGF2aWQxLlpob3VAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9jcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nz
LmMKaW5kZXggY2ZhZTY1ZC4uZjZkZDUzMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2NzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2NzLmMKQEAgLTgzMyw3ICs4MzMsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9jc19kZXBlbmRl
bmNpZXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAKIAkJCWN0eCA9IGFtZGdwdV9jdHhf
Z2V0KGRlcHNbal0uY3R4X2lkKTsKIAkJCWlmIChjdHggPT0gTlVMTCkKLQkJCQlyZXR1cm4gLUVJ
TlZBTDsKKwkJCQljb250aW51ZTs7CiAKIAkJCWZlbmNlID0gYW1kZ3B1X2N0eF9nZXRfZmVuY2Uo
Y3R4LCByaW5nLAogCQkJCQkJICAgICBkZXBzW2pdLmhhbmRsZSk7Ci0tIAoxLjkuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
