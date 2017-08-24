From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/4] drm/amdgpu/gfx9: update mqd to include dynamic CU mask
Date: Thu, 24 Aug 2017 17:00:04 -0400
Message-ID: <1503608405-16772-3-git-send-email-alexander.deucher@amd.com>
References: <1503608405-16772-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1503608405-16772-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

TmVjZXNzYXJ5IGZvciBwcm9wZXIgb3BlcmF0aW9uIHdpdGggS0lRLgoKU2lnbmVkLW9mZi1ieTog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvaW5jbHVkZS92OV9zdHJ1Y3RzLmggfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9pbmNsdWRlL3Y5X3N0cnVjdHMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVk
ZS92OV9zdHJ1Y3RzLmgKaW5kZXggOWE5ZTZjNy4uNTZkNzlkYiAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9pbmNsdWRlL3Y5X3N0cnVjdHMuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2luY2x1ZGUvdjlfc3RydWN0cy5oCkBAIC0yODQsOCArMjg0LDggQEAgc3RydWN0IHY5X21x
ZCB7CiAJdWludDMyX3QgZ2RzX3NhdmVfbWFza19oaTsKIAl1aW50MzJfdCBjdHhfc2F2ZV9iYXNl
X2FkZHJfbG87CiAJdWludDMyX3QgY3R4X3NhdmVfYmFzZV9hZGRyX2hpOwotCXVpbnQzMl90IHJl
c2VydmVkXzEyNjsKLQl1aW50MzJfdCByZXNlcnZlZF8xMjc7CisJdWludDMyX3QgZHluYW1pY19j
dV9tYXNrX2FkZHJfbG87CisJdWludDMyX3QgZHluYW1pY19jdV9tYXNrX2FkZHJfaGk7CiAJdWlu
dDMyX3QgY3BfbXFkX2Jhc2VfYWRkcl9sbzsKIAl1aW50MzJfdCBjcF9tcWRfYmFzZV9hZGRyX2hp
OwogCXVpbnQzMl90IGNwX2hxZF9hY3RpdmU7Ci0tIAoyLjUuNQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
