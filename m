From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 13/18] drm/amd/display: Disable stats by default
Date: Thu, 31 May 2018 10:23:42 -0400
Message-ID: <20180531142347.4086-14-harry.wentland@amd.com>
References: <20180531142347.4086-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180531142347.4086-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Anthony Koo <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQW50aG9ueSBLb28gPEFudGhvbnkuS29vQGFtZC5jb20+CgpTaWduZWQtb2ZmLWJ5OiBB
bnRob255IEtvbyA8QW50aG9ueS5Lb29AYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IFRvbnkgQ2hlbmcg
PFRvbnkuQ2hlbmdAYW1kLmNvbT4KQWNrZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50
bGFuZEBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL3N0
YXRzL3N0YXRzLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxl
cy9zdGF0cy9zdGF0cy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvc3Rh
dHMvc3RhdHMuYwppbmRleCBmYTA2NjVkMDkwNzUuLjQ4MGViMmNkZDU1ZCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvc3RhdHMvc3RhdHMuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9zdGF0cy9zdGF0cy5jCkBAIC0yOSw3
ICsyOSw3IEBACiAjaW5jbHVkZSAiY29yZV90eXBlcy5oIgogCiAjZGVmaW5lIERBTF9TVEFUU19F
TkFCTEVfUkVHS0VZCQkJIkRhbFN0YXRzRW5hYmxlIgotI2RlZmluZSBEQUxfU1RBVFNfRU5BQkxF
X1JFR0tFWV9ERUZBVUxUCQkweDAwMDAwMDAxCisjZGVmaW5lIERBTF9TVEFUU19FTkFCTEVfUkVH
S0VZX0RFRkFVTFQJCTB4MDAwMDAwMDAKICNkZWZpbmUgREFMX1NUQVRTX0VOQUJMRV9SRUdLRVlf
RU5BQkxFRAkJMHgwMDAwMDAwMQogCiAjZGVmaW5lIERBTF9TVEFUU19FTlRSSUVTX1JFR0tFWQkJ
IkRhbFN0YXRzRW50cmllcyIKLS0gCjIuMTcuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
