From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 32/54] drm/amd/display: set default GPIO_ID_HPD
Date: Mon, 9 Jul 2018 20:37:10 -0400
Message-ID: <20180710003732.16836-33-harry.wentland@amd.com>
References: <20180710003732.16836-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180710003732.16836-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Charlene Liu <charlene.liu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQ2hhcmxlbmUgTGl1IDxjaGFybGVuZS5saXVAYW1kLmNvbT4KClNpZ25lZC1vZmYtYnk6
IENoYXJsZW5lIExpdSA8Y2hhcmxlbmUubGl1QGFtZC5jb20+ClJldmlld2VkLWJ5OiBEbXl0cm8g
TGFrdHl1c2hraW4gPERteXRyby5MYWt0eXVzaGtpbkBhbWQuY29tPgpBY2tlZC1ieTogSGFycnkg
V2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2dwaW8vZ3Bpb19zZXJ2aWNlLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9ncGlvL2dwaW9fc2VydmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2dw
aW8vZ3Bpb19zZXJ2aWNlLmMKaW5kZXggYWI1NDgzYzBjNTAyLi5mMjAxNjFjNTcwNmQgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9ncGlvL2dwaW9fc2VydmljZS5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9ncGlvL2dwaW9fc2VydmljZS5j
CkBAIC0zNzUsNiArMzc1LDcgQEAgc3RydWN0IGdwaW8gKmRhbF9ncGlvX2NyZWF0ZV9pcnEoCiAJ
Y2FzZSBHUElPX0lEX0dQSU9fUEFEOgogCWJyZWFrOwogCWRlZmF1bHQ6CisJCWlkID0gR1BJT19J
RF9IUEQ7CiAJCUFTU0VSVF9DUklUSUNBTChmYWxzZSk7CiAJCXJldHVybiBOVUxMOwogCX0KLS0g
CjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
