From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 09/31] drm/amd/display: Allow MPO on Raven
Date: Fri, 12 May 2017 11:20:42 -0400
Message-ID: <20170512152104.5354-10-harry.wentland@amd.com>
References: <20170512152104.5354-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170512152104.5354-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Leon Elazar <leon.elazar-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTGVvbiBFbGF6YXIgPGxlb24uZWxhemFyQGFtZC5jb20+CgpDaGFuZ2UtSWQ6IEliODNi
Y2MxZDJjYjIzYjQwOWFmODc2NWI3MjVmODJkNWVjNWNhNTc0ClNpZ25lZC1vZmYtYnk6IExlb24g
RWxhemFyIDxsZW9uLmVsYXphckBhbWQuY29tPgpSZXZpZXdlZC1ieTogVG9ueSBDaGVuZyA8VG9u
eS5DaGVuZ0BhbWQuY29tPgpBY2tlZC1ieTogSGFycnkgV2VudGxhbmQgPEhhcnJ5LldlbnRsYW5k
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEw
X3Jlc291cmNlLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX3Jlc291
cmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfcmVzb3Vy
Y2UuYwppbmRleCAxMjFlYjMwMDk0NDUuLjQxNjEzYWI1Y2E2OSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX3Jlc291cmNlLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX3Jlc291cmNlLmMKQEAgLTEy
OTIsNiArMTI5Miw4IEBAIHN0YXRpYyBib29sIGNvbnN0cnVjdCgKIAlkYy0+cHVibGljLmNhcHMu
aTJjX3NwZWVkX2luX2toeiA9IDEwMDsKIAlkYy0+cHVibGljLmNhcHMubWF4X2N1cnNvcl9zaXpl
ID0gMjU2OwogCisJZGMtPnB1YmxpYy5jYXBzLm1heF9zbGF2ZV9wbGFuZXMgPSAxOworCiAJaWYg
KGRjLT5jdHgtPmRjZV9lbnZpcm9ubWVudCA9PSBEQ0VfRU5WX1BST0RVQ1RJT05fRFJWKQogCQlk
Yy0+cHVibGljLmRlYnVnID0gZGVidWdfZGVmYXVsdHNfZHJ2OwogCWVsc2UKLS0gCjIuMTEuMAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
