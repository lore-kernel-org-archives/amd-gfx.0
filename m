From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: bypass vce clock if vce is idle on Fiji.
Date: Sat, 24 Sep 2016 16:38:34 +0800
Message-ID: <1474706314-30663-1-git-send-email-Rex.Zhu@amd.com>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJNzRiZGYzOWFmMzMyZWIzNjllODdjOTg5YjM0NGYzZTA2Y2JmYzcxNApTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmNlX3YzXzAuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdmNlX3YzXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92M18wLmMK
aW5kZXggYTZiNGUyNy4uNDNiMjZlYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdmNlX3YzXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjNf
MC5jCkBAIC03MTYsNyArNzE2LDggQEAgc3RhdGljIGludCB2Y2VfdjNfMF9zZXRfY2xvY2tnYXRp
bmdfc3RhdGUodm9pZCAqaGFuZGxlLAogCWludCBpOwogCiAJaWYgKChhZGV2LT5hc2ljX3R5cGUg
PT0gQ0hJUF9QT0xBUklTMTApIHx8Ci0JICAgIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9UT05H
QSkpCisJICAgIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9UT05HQSkgfHwKKwkgICAoYWRldi0+
YXNpY190eXBlID09IENISVBfRklKSSkpCiAJCXZjZV92M18wX3NldF9ieXBhc3NfbW9kZShhZGV2
LCBlbmFibGUpOwogCiAJaWYgKCEoYWRldi0+Y2dfZmxhZ3MgJiBBTURfQ0dfU1VQUE9SVF9WQ0Vf
TUdDRykpCi0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
