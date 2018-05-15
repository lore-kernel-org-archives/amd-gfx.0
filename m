From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 33/57] drm/amd/display: Add BIOS smu_info v3_3 support for
 Vega20
Date: Tue, 15 May 2018 09:59:09 -0500
Message-ID: <20180515145933.12063-34-alexander.deucher@amd.com>
References: <20180515145933.12063-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180515145933.12063-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, "Jerry (Fangzhi) Zuo" <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>

RnJvbTogIkplcnJ5IChGYW5nemhpKSBadW8iIDxKZXJyeS5adW9AYW1kLmNvbT4KClNpZ25lZC1v
ZmYtYnk6IEplcnJ5IChGYW5nemhpKSBadW8gPEplcnJ5Llp1b0BhbWQuY29tPgpSZXZpZXdlZC1i
eTogSGVyc2VuIFd1IDxoZXJzZW54cy53dUBhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEZlaWZlaSBYdSA8
RmVpZmVpLlh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jp
b3MvYmlvc19wYXJzZXIyLmMgfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlv
c19wYXJzZXIyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9iaW9zX3Bh
cnNlcjIuYwppbmRleCAxMGE1ODA3YTdlOGIuLjQ1NjE2NzNhMGZlNiAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJzZXIyLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJzZXIyLmMKQEAgLTEzMzAs
NiArMTMzMCwxMSBAQCBzdGF0aWMgZW51bSBicF9yZXN1bHQgYmlvc19wYXJzZXJfZ2V0X2Zpcm13
YXJlX2luZm8oCiAJCQljYXNlIDI6CiAJCQkJcmVzdWx0ID0gZ2V0X2Zpcm13YXJlX2luZm9fdjNf
MihicCwgaW5mbyk7CiAJCQkJYnJlYWs7CisJCQljYXNlIDM6CisjaWZkZWYgQ09ORklHX0RSTV9B
TURfRENfVkcyMAorCQkJCXJlc3VsdCA9IGdldF9maXJtd2FyZV9pbmZvX3YzXzIoYnAsIGluZm8p
OworI2VuZGlmCisJCQkJYnJlYWs7CiAJCQlkZWZhdWx0OgogCQkJCWJyZWFrOwogCQkJfQotLSAK
Mi4xMy42CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
