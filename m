From: =?UTF-8?q?Ernst=20Sj=C3=B6strand?= <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 6/6] drm/amd/amdgpu: sdma_v4_0_start: initialize r
Date: Mon, 24 Jun 2019 17:15:44 +0200
Message-ID: <20190624151544.13934-6-ernstp@gmail.com>
References: <20190624151544.13934-1-ernstp@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190624151544.13934-1-ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

UmVwb3J0ZWQgYnkgc21hdGNoOgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAu
YzoxMTY3IHNkbWFfdjRfMF9zdGFydCgpIGVycm9yOiB1bmluaXRpYWxpemVkIHN5bWJvbCAncicu
CgpTaWduZWQtb2ZmLWJ5OiBFcm5zdCBTasO2c3RyYW5kIDxlcm5zdHBAZ21haWwuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jIHwgMiArLQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zZG1hX3Y0XzAuYwppbmRleCBjMGI2MDExYjRiZDEuLjllNTcxY2EyODNjMyAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMKQEAgLTEwOTIsNyArMTA5Miw3IEBAIHN0
YXRpYyBpbnQgc2RtYV92NF8wX2xvYWRfbWljcm9jb2RlKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQogc3RhdGljIGludCBzZG1hX3Y0XzBfc3RhcnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCiB7CiAJc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nOwotCWludCBpLCByOworCWludCBpLCBy
ID0gMDsKIAogCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpIHsKIAkJc2RtYV92NF8wX2N0eF9z
d2l0Y2hfZW5hYmxlKGFkZXYsIGZhbHNlKTsKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
