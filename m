From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 25/57] drm/amdgpu/soc15: Add ip blocks for vega20 (v2)
Date: Tue, 15 May 2018 09:59:01 -0500
Message-ID: <20180515145933.12063-26-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRmVpZmVpIFh1IDxGZWlmZWkuWHVAYW1kLmNvbT4KClNhbWUgYXMgdmVnYTEwIG5vdy4K
CnYyOiBzcXVhc2ggaW4gdHlwbyBmaXgKClNpZ25lZC1vZmYtYnk6IEZlaWZlaSBYdSA8RmVpZmVp
Llh1QGFtZC5jb20+ClJldmlld2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFt
ZC5jb20+ClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jIHwgMSArCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zb2MxNS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYwppbmRl
eCBjMzEzM2QxNmRlNzcuLjEwMzM3ZmIzZmMxZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc29jMTUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2Mx
NS5jCkBAIC01MDgsNiArNTA4LDcgQEAgaW50IHNvYzE1X3NldF9pcF9ibG9ja3Moc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCiAJc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKIAljYXNlIENI
SVBfVkVHQTEwOgogCWNhc2UgQ0hJUF9WRUdBMTI6CisJY2FzZSBDSElQX1ZFR0EyMDoKIAkJYW1k
Z3B1X2RldmljZV9pcF9ibG9ja19hZGQoYWRldiwgJnZlZ2ExMF9jb21tb25faXBfYmxvY2spOwog
CQlhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmZ21jX3Y5XzBfaXBfYmxvY2spOwog
CQlhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmdmVnYTEwX2loX2lwX2Jsb2NrKTsK
LS0gCjIuMTMuNgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
