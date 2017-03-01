From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 14/15] drm/amd/display: Enable warnings as errors
Date: Tue, 28 Feb 2017 19:26:19 -0500
Message-ID: <20170301002620.24595-15-harry.wentland@amd.com>
References: <20170301002620.24595-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170301002620.24595-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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

Q2hhbmdlLUlkOiBJNDhkMzhlNGQwMjI0YzlmMGU1MjA1NWIzYzRkZGVmOGU4NzJiM2RhYwpTaWdu
ZWQtb2ZmLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KQWNrZWQt
Ynk6IEhhcnJ5IFdlbnRsYW5kIDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPgpSZXZpZXdlZC1ieTog
Sm9yZGFuIExhemFyZSA8Sm9yZGFuLkxhemFyZUBhbWQuY29tPgpSZXZpZXdlZC1ieTogVG9ueSBD
aGVuZyA8VG9ueS5DaGVuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9NYWtlZmlsZSB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvTWFrZWZpbGUgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvTWFrZWZpbGUKaW5kZXggOGJhMzdkZDljZjdmLi5jMjI0NzViNTU1
ODYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9NYWtlZmlsZQorKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvTWFrZWZpbGUKQEAgLTUsNiArNSw4IEBACiAK
IEFNRERBTFBBVEggPSAkKFJFTEFUSVZFX0FNRF9ESVNQTEFZX1BBVEgpCiAKK3N1YmRpci1jY2Zs
YWdzLXkgKz0gLVdlcnJvcgorCiBzdWJkaXItY2NmbGFncy15ICs9IC1JJChBTUREQUxQQVRIKS8g
LUkkKEFNRERBTFBBVEgpL2luY2x1ZGUKIAogc3ViZGlyLWNjZmxhZ3MteSArPSAtSSQoRlVMTF9B
TURfRElTUExBWV9QQVRIKS9kYy9pbmMvCi0tIAoyLjkuMwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
