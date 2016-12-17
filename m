From: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 20/23] drm/amdgpu/mxgpu: enable VI virtualization
Date: Sun, 18 Dec 2016 00:16:42 +0800
Message-ID: <1481991405-30422-21-git-send-email-Xiangliang.Yu@amd.com>
References: <1481991405-30422-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1481991405-30422-1-git-send-email-Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dl.SRDC_SW_GPUVirtualization-5C7GfCeVMHo@public.gmane.org
Cc: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>

Q2FsbCB2aSBpcCBibG9jayBzZXR1cCBmdW5jdGlvbiB0byBlbmFibGUgdmkgdmlydHVhbGl6YXRp
b24uCgpTaWduZWQtb2ZmLWJ5OiBYaWFuZ2xpYW5nIFl1IDxYaWFuZ2xpYW5nLll1QGFtZC5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9teGdwdS9hbWRfbXhncHUuYyB8IDEgKwogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9teGdwdS9hbWRfbXhncHUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvbXhncHUvYW1kX214Z3B1
LmMKaW5kZXggNzI0NjllMi4uN2NhY2FiNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9teGdwdS9hbWRfbXhncHUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL214Z3B1L2FtZF9t
eGdwdS5jCkBAIC02Miw2ICs2Miw3IEBAIHN0YXRpYyBpbnQgYW1kX3hncHVfaW5pdF9pcF9ibG9j
a3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJY2FzZSBDSElQX1RPTkdBOgogCWNhc2Ug
Q0hJUF9GSUpJOgogCQkvKiBhZGQgSVAgYmxvY2tzKi8KKwkJeGdwdV92aV9hZGRfaXBfYmxvY2tz
KGFkZXYpOwogCQlicmVhazsKIAlkZWZhdWx0OgogCQlEUk1fRVJST1IoIkRvZXMgbm90IHN1cHBv
cnQgdGhpcyBjaGlwLlxuIik7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
