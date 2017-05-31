From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/4] drm/amd/powerplay: enable CKS by default on vega10.
Date: Wed, 31 May 2017 20:16:13 +0800
Message-ID: <1496232973-30543-4-git-send-email-Rex.Zhu@amd.com>
References: <1496232973-30543-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1496232973-30543-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJMGU0MWVjMGZiOTk4N2M3M2JkMzhhN2VhZjgxNzNiNWVjNWM1MDczNApTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jCmluZGV4IDk3MWY3ODkuLjQzODEy
ZDIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2Ex
MF9od21nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2Ex
MF9od21nci5jCkBAIC0xMjQsNyArMTI0LDcgQEAgc3RhdGljIHZvaWQgdmVnYTEwX3NldF9kZWZh
dWx0X3JlZ2lzdHJ5X2RhdGEoc3RydWN0IHBwX2h3bWdyICpod21ncikKIAl9CiAKIAlkYXRhLT5y
ZWdpc3RyeV9kYXRhLmNsb2NrX3N0cmV0Y2hlcl9zdXBwb3J0ID0KLQkJCWh3bWdyLT5mZWF0dXJl
X21hc2sgJiBQUF9DTE9DS19TVFJFVENIX01BU0sgPyBmYWxzZSA6IHRydWU7CisJCQlod21nci0+
ZmVhdHVyZV9tYXNrICYgUFBfQ0xPQ0tfU1RSRVRDSF9NQVNLID8gdHJ1ZSA6IGZhbHNlOwogCiAJ
ZGF0YS0+cmVnaXN0cnlfZGF0YS51bHZfc3VwcG9ydCA9CiAJCQlod21nci0+ZmVhdHVyZV9tYXNr
ICYgUFBfVUxWX01BU0sgPyB0cnVlIDogZmFsc2U7Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
