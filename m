From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amd/powerplay: correct smc display config for multi
 monitor
Date: Wed, 20 Jun 2018 14:08:38 +0800
Message-ID: <1529474919-8491-2-git-send-email-evan.quan@amd.com>
References: <1529474919-8491-1-git-send-email-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1529474919-8491-1-git-send-email-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
Cc: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

TmVlZCB0byB0YWtlIGludG8gYWNjb3VudCBtdWx0aS1oZWFkIHdpdGggc3luY2VkIGRpc3BsYXlz
LgoKQ2hhbmdlLUlkOiBJMmFkNTNmNDdjZTFkZmYwZmE4ZjZhZTk0NDk4NjU2NzQ0M2NjYTA0ZQpT
aWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpBY2tlZC1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl9od21nci5jIHwgMyArKy0KIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTJfaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl9od21nci5jCmluZGV4IDI4YjE3MmUuLmRm
OTFkZGUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3Zl
Z2ExMl9od21nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3Zl
Z2ExMl9od21nci5jCkBAIC0xNDAxLDcgKzE0MDEsOCBAQCBzdGF0aWMgaW50IHZlZ2ExMl9ub3Rp
Znlfc21jX2Rpc3BsYXlfY29uZmlnX2FmdGVyX3BzX2FkanVzdG1lbnQoCiAJc3RydWN0IHBwX2Rp
c3BsYXlfY2xvY2tfcmVxdWVzdCBjbG9ja19yZXE7CiAJdWludDMyX3QgY2xrX3JlcXVlc3Q7CiAK
LQlpZiAoaHdtZ3ItPmRpc3BsYXlfY29uZmlnLT5udW1fZGlzcGxheSA+IDEpCisJaWYgKChod21n
ci0+ZGlzcGxheV9jb25maWctPm51bV9kaXNwbGF5ID4gMSkgJiYKKwkJIWh3bWdyLT5kaXNwbGF5
X2NvbmZpZy0+bXVsdGlfbW9uaXRvcl9pbl9zeW5jKQogCQl2ZWdhMTJfbm90aWZ5X3NtY19kaXNw
bGF5X2NoYW5nZShod21nciwgZmFsc2UpOwogCWVsc2UKIAkJdmVnYTEyX25vdGlmeV9zbWNfZGlz
cGxheV9jaGFuZ2UoaHdtZ3IsIHRydWUpOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
