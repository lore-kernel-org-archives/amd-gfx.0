From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdkfd: Delete unused KFD_IS_* macro
Date: Mon, 16 Sep 2019 16:33:05 +0000
Message-ID: <20190916163252.23684-1-Yong.Zhao@amd.com>
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
Cc: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>

VGhlc2Ugd2VyZSBkZWxldGVkIGJlZm9yZSwgYnV0IHNvbWVob3cgc2hvd2VkIHVwIGFnYWluLiBE
ZWxldGUgdGhlbSBhZ2Fpbi4KCkNoYW5nZS1JZDogSTE5YjMwNjM5MzIzODBjYjc0YTAxZDUwNWU4
ZTkyZjg5N2EyYzJjYjcKU2lnbmVkLW9mZi1ieTogWW9uZyBaaGFvIDxZb25nLlpoYW9AYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oIHwgNCAtLS0tCiAx
IGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3ByaXYuaAppbmRleCAwNmJiMmQ3YTliMzkuLjA3NzNkYzRkZjRmZiAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfcHJpdi5oCkBAIC0xNzksMTAgKzE3OSw2IEBAIGVudW0gY2FjaGVfcG9s
aWN5IHsKIAljYWNoZV9wb2xpY3lfbm9uY29oZXJlbnQKIH07CiAKLSNkZWZpbmUgS0ZEX0lTX1ZJ
KGNoaXApICgoY2hpcCkgPj0gQ0hJUF9DQVJSSVpPICYmIChjaGlwKSA8PSBDSElQX1BPTEFSSVMx
MSkKLSNkZWZpbmUgS0ZEX0lTX0RHUFUoY2hpcCkgKCgoY2hpcCkgPj0gQ0hJUF9UT05HQSAmJiBc
Ci0JCQkgICAoY2hpcCkgPD0gQ0hJUF9OQVZJMTApIHx8IFwKLQkJCSAgIChjaGlwKSA9PSBDSElQ
X0hBV0FJSSkKICNkZWZpbmUgS0ZEX0lTX1NPQzE1KGNoaXApICgoY2hpcCkgPj0gQ0hJUF9WRUdB
MTApCiAKIHN0cnVjdCBrZmRfZXZlbnRfaW50ZXJydXB0X2NsYXNzIHsKLS0gCjIuMTcuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
