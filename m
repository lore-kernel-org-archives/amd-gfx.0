From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: Fix smu_table_entry.handle type
Date: Wed, 17 Jan 2018 17:35:29 -0500
Message-ID: <1516228529-14571-1-git-send-email-andrey.grodzovsky@amd.com>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, Mikita.Lipski-5C7GfCeVMHo@public.gmane.org, Rex.Zhu-5C7GfCeVMHo@public.gmane.org

SGFuZGxlIGRlc2NyaWJlcyBrZXJuZWwgbG9naWNhbCBhZGRyZXNzLCBzaG91bGQgYmUgdW5zaWdu
ZWQgbG9uZyBhbmQgbm90IHVpbnQzMl90LgpGaXhlcyBLQVNBTiBlcnJvciBhbmQgR0ZQIG9uIGRy
aXZlciB1bmxvYWQuCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdy
b2R6b3Zza3lAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVt
Z3IvcnZfc211bWdyLmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9z
bXVtZ3IvcnZfc211bWdyLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3Iv
cnZfc211bWdyLmgKaW5kZXggNTg4ODg0MC4uY2FlYmRiZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL3J2X3NtdW1nci5oCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9ydl9zbXVtZ3IuaApAQCAtNDAsNyArNDAsNyBAQCBz
dHJ1Y3Qgc211X3RhYmxlX2VudHJ5IHsKIAl1aW50MzJfdCB0YWJsZV9hZGRyX2hpZ2g7CiAJdWlu
dDMyX3QgdGFibGVfYWRkcl9sb3c7CiAJdWludDhfdCAqdGFibGU7Ci0JdWludDMyX3QgaGFuZGxl
OworCXVuc2lnbmVkIGxvbmcgaGFuZGxlOwogfTsKIAogc3RydWN0IHNtdV90YWJsZV9hcnJheSB7
Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
