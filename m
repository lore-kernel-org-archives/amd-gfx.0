From: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/gmc10: apply the 'invalidation from sdma'
 workaround for navi
Date: Thu, 26 Sep 2019 08:08:08 +0000
Message-ID: <20190926080746.20765-1-xiaojie.yuan@amd.com>
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
Cc: "alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Yuan,
 Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

Rml4ZXM6IDc2N2FjYWJkYWM4MSAoImRybS9hbWQvcG93ZXJwbGF5OiBhZGQgYmFjbyBzbXUgcmVz
ZXQgZnVuY3Rpb24gZm9yIHNtdTExIikKU2lnbmVkLW9mZi1ieTogWGlhb2ppZSBZdWFuIDx4aWFv
amllLnl1YW5AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEw
XzAuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nbWNfdjEwXzAuYwppbmRleCBjYjNmNjE4NzNiYWEuLmRjMmU2OGUwMTllYiAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKQEAgLTI5Miw2ICsyOTIsNyBA
QCBzdGF0aWMgdm9pZCBnbWNfdjEwXzBfZmx1c2hfZ3B1X3RsYihzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwgdWludDMyX3Qgdm1pZCwKIAogCWlmICghYWRldi0+bW1hbi5idWZmZXJfZnVuY3Nf
ZW5hYmxlZCB8fAogCSAgICAhYWRldi0+aWJfcG9vbF9yZWFkeSB8fAorCSAgICAhKGFkZXYtPmFz
aWNfdHlwZSA+PSBDSElQX05BVkkxMCAmJiBhZGV2LT5hc2ljX3R5cGUgPD0gQ0hJUF9OQVZJMTIp
IHx8CiAJICAgIGFkZXYtPmluX2dwdV9yZXNldCkgewogCQlnbWNfdjEwXzBfZmx1c2hfdm1faHVi
KGFkZXYsIHZtaWQsIEFNREdQVV9HRlhIVUJfMCwgMCk7CiAJCW11dGV4X3VubG9jaygmYWRldi0+
bW1hbi5ndHRfd2luZG93X2xvY2spOwotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=
