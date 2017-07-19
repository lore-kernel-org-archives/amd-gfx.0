From: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: disable firmware loading for psp v10
Date: Wed, 19 Jul 2017 08:26:43 +0800
Message-ID: <1500424003-15402-1-git-send-email-Jerry.Zhang@amd.com>
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
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, sonny.jiang-5C7GfCeVMHo@public.gmane.org, Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, Hawking.Zhang-5C7GfCeVMHo@public.gmane.org

Tm93IGFzZCBmaXJtd2FyZSBpcyBub3QgcmVhZHkgZm9yIHBzcCB2MTAsIHdpbGwgZW5hYmxlIGl0
IHdoZW4gaXQncyBhdmFpbGFibGUKClNpZ25lZC1vZmYtYnk6IEp1bndlaSBaaGFuZyA8SmVycnku
WmhhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNw
LmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCmluZGV4IGM5MTk1NzkuLjFhYTQxYWYgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKQEAgLTYzLDcgKzYzLDkgQEAgc3RhdGlj
IGludCBwc3Bfc3dfaW5pdCh2b2lkICpoYW5kbGUpCiAJCXBzcC0+c211X3JlbG9hZF9xdWlyayA9
IHBzcF92M18xX3NtdV9yZWxvYWRfcXVpcms7CiAJCWJyZWFrOwogCWNhc2UgQ0hJUF9SQVZFTjoK
KyNpZiAwCiAJCXBzcC0+aW5pdF9taWNyb2NvZGUgPSBwc3BfdjEwXzBfaW5pdF9taWNyb2NvZGU7
CisjZW5kaWYKIAkJcHNwLT5wcmVwX2NtZF9idWYgPSBwc3BfdjEwXzBfcHJlcF9jbWRfYnVmOwog
CQlwc3AtPnJpbmdfaW5pdCA9IHBzcF92MTBfMF9yaW5nX2luaXQ7CiAJCXBzcC0+cmluZ19jcmVh
dGUgPSBwc3BfdjEwXzBfcmluZ19jcmVhdGU7Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
