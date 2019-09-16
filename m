From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdkfd: Delete unused KFD_IS_DGPU macro
Date: Mon, 16 Sep 2019 16:26:36 +0000
Message-ID: <20190916162622.23356-1-Yong.Zhao@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>

VGhpcyB3YXMgZGVsZXRlZCBiZWZvcmUsIGJ1dCBzb21laG93IHNob3dlZCB1cCBhZ2Fpbi4gRGVs
ZXRlIGl0IGFnYWluLgoKQ2hhbmdlLUlkOiBJMTliMzA2MzkzMjM4MGNiNzRhMDFkNTA1ZThlOTJm
ODk3YTJjMmNiNwpTaWduZWQtb2ZmLWJ5OiBZb25nIFpoYW8gPFlvbmcuWmhhb0BhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmggfCAzIC0tLQogMSBmaWxl
IGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX3ByaXYuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2
LmgKaW5kZXggMDZiYjJkN2E5YjM5Li42ZWQzMWE3NmRmZGEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3ByaXYuaApAQCAtMTgwLDkgKzE4MCw2IEBAIGVudW0gY2FjaGVfcG9saWN5IHsK
IH07CiAKICNkZWZpbmUgS0ZEX0lTX1ZJKGNoaXApICgoY2hpcCkgPj0gQ0hJUF9DQVJSSVpPICYm
IChjaGlwKSA8PSBDSElQX1BPTEFSSVMxMSkKLSNkZWZpbmUgS0ZEX0lTX0RHUFUoY2hpcCkgKCgo
Y2hpcCkgPj0gQ0hJUF9UT05HQSAmJiBcCi0JCQkgICAoY2hpcCkgPD0gQ0hJUF9OQVZJMTApIHx8
IFwKLQkJCSAgIChjaGlwKSA9PSBDSElQX0hBV0FJSSkKICNkZWZpbmUgS0ZEX0lTX1NPQzE1KGNo
aXApICgoY2hpcCkgPj0gQ0hJUF9WRUdBMTApCiAKIHN0cnVjdCBrZmRfZXZlbnRfaW50ZXJydXB0
X2NsYXNzIHsKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4
