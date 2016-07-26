From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/4] drm/amd/amdgpu: Add GFX and UVD PG for Stoney
Date: Tue, 26 Jul 2016 11:38:31 -0400
Message-ID: <20160726153832.15191-4-tom.stdenis@amd.com>
References: <20160726153832.15191-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160726153832.15191-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

RW5hYmxlcyBHRlggUEcgYW5kIFVWRCBzdGF0aWMgUEcgb24gU3RvbmV5IGNsYXNzCmFzaWNzLgoK
U2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMgfCA2ICsrKysrKwogMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3ZpLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jCmluZGV4IDI4OWE0YzRhYzll
Ny4uNzhmZWE5NDBkMTIwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92
aS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMKQEAgLTE2MDYsNiArMTYw
NiwxMiBAQCBzdGF0aWMgaW50IHZpX2NvbW1vbl9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKIAkJ
CUFNRF9DR19TVVBQT1JUX0hEUF9MUyB8CiAJCQlBTURfQ0dfU1VQUE9SVF9TRE1BX01HQ0cgfAog
CQkJQU1EX0NHX1NVUFBPUlRfU0RNQV9MUzsKKwkJYWRldi0+cGdfZmxhZ3MgfD0gQU1EX1BHX1NV
UFBPUlRfR0ZYX1BHIHwKKwkJCUFNRF9QR19TVVBQT1JUX0dGWF9TTUcgfAorCQkJQU1EX1BHX1NV
UFBPUlRfR0ZYX1BJUEVMSU5FOworCQkvKiBwb3dlcnBsYXkgVVZEIFBHIGRvZXNuJ3Qgd29yayB5
ZXQgKi8KKwkJaWYgKCFhbWRncHVfcG93ZXJwbGF5KQorCQkJYWRldi0+cGdfZmxhZ3MgfD0gQU1E
X1BHX1NVUFBPUlRfVVZEOwogCQlhZGV2LT5leHRlcm5hbF9yZXZfaWQgPSBhZGV2LT5yZXZfaWQg
KyAweDE7CiAJCWJyZWFrOwogCWRlZmF1bHQ6Ci0tIAoyLjkuMgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
