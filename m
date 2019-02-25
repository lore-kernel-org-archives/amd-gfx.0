From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 24/26] drm/amd/powerplay: move setting allowed mask and
 feature enabling together
Date: Mon, 25 Feb 2019 20:12:30 +0800
Message-ID: <1551096752-18205-25-git-send-email-ray.huang@amd.com>
References: <1551096752-18205-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1551096752-18205-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, Kevin Wang <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Chengming Gui <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

VGhpcyBwYXRjaCBtb3ZlcyBzZXR0aW5nIGFsbG93ZWQgbWFzayBhbmQgZmVhdHVyZSBlbmFibGlu
ZyB0b2dldGhlciB0byByZWZpbmUKdGhlIHByb2dyYW1taW5nIHNlcXVlbmNlLgoKU2lnbmVkLW9m
Zi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEhhd2tpbmcg
WmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9hbWRncHVfc211LmMgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L2FtZGdwdV9zbXUuYwppbmRleCA4NzZiNjg4Li41ZTdlOTg4IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCkBAIC01OTAsMTAgKzU5MCw2IEBAIHN0YXRpYyBp
bnQgc211X3NtY190YWJsZV9od19pbml0KHN0cnVjdCBzbXVfY29udGV4dCAqc211LAogCWlmIChy
ZXQpCiAJCXJldHVybiByZXQ7CiAKLQlyZXQgPSBzbXVfZmVhdHVyZV9zZXRfYWxsb3dlZF9tYXNr
KHNtdSk7Ci0JaWYgKHJldCkKLQkJcmV0dXJuIHJldDsKLQogCWlmIChpbml0aWFsaXplKSB7CiAJ
CXJldCA9IHNtdV9yZWFkX3BwdGFibGVfZnJvbV92YmlvcyhzbXUpOwogCQlpZiAocmV0KQpAQCAt
NjU4LDYgKzY1NCwxMCBAQCBzdGF0aWMgaW50IHNtdV9zbWNfdGFibGVfaHdfaW5pdChzdHJ1Y3Qg
c211X2NvbnRleHQgKnNtdSwKIAlpZiAocmV0KQogCQlyZXR1cm4gcmV0OwogCisJcmV0ID0gc211
X2ZlYXR1cmVfc2V0X2FsbG93ZWRfbWFzayhzbXUpOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7
CisKIAlyZXQgPSBzbXVfc3lzdGVtX2ZlYXR1cmVzX2NvbnRyb2woc211LCB0cnVlKTsKIAlpZiAo
cmV0KQogCQlyZXR1cm4gcmV0OwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
