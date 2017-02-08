From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 07/11] drm/amdgpu:new field in_resete introduced for gfx
Date: Wed, 8 Feb 2017 17:26:55 +0800
Message-ID: <1486546019-31045-7-git-send-email-Monk.Liu@amd.com>
References: <1486546019-31045-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1486546019-31045-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

dXNlIGl0IHRvIHNlcGVyYXRlIGRyaXZlciBsb2FkIGFuZCBncHUgcmVzZXQvcmVzdW1lCmJlY2F1
c2UgZ2Z4IElQIG5lZWQgZGlmZmVyZW50IGFwcHJvYWNoIGZvciBkaWZmZXJlbnQKaHdfaW5pdCB0
cmlnZ2VyIHNvdXJjZQoKQ2hhbmdlLUlkOiBJOTkxZTBkYTUyY2NkMTk3NzE2ZDI3OWJmOTAxNGRl
NDZkMzlhY2ZlYQpTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCB8IDEgKwogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAppbmRleCA3
NGJmZmNhOC4uYWNkOTk3MCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKQEAgLTkw
MSw2ICs5MDEsNyBAQCBzdHJ1Y3QgYW1kZ3B1X2dmeCB7CiAJLyogcmVzZXQgbWFzayAqLwogCXVp
bnQzMl90ICAgICAgICAgICAgICAgICAgICAgICAgZ3JibV9zb2Z0X3Jlc2V0OwogCXVpbnQzMl90
ICAgICAgICAgICAgICAgICAgICAgICAgc3JibV9zb2Z0X3Jlc2V0OworCWJvb2wgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaW5fcmVzZXQ7CiB9OwogCiBpbnQgYW1kZ3B1X2liX2dldChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0sCi0tIAoyLjcuNAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
