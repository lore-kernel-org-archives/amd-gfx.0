From: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/psp: silence response status warning
Date: Tue, 24 Sep 2019 09:18:21 +0000
Message-ID: <1569316680-12374-1-git-send-email-shirish.s@amd.com>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "S,
 Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>

bG9nIHRoZSByZXNwb25zZSBzdGF0dXMgcmVsYXRlZCBlcnJvciB0byB0aGUgZHJpdmVyJ3MKZGVi
dWcgbG9nIHNpbmNlICBwc3AgcmVzcG9uc2Ugc3RhdHVzIGlzIG5vdCAwIGV2ZW4gdGhvdWdoCnRo
ZXJlIHdhcyBubyBwcm9ibGVtIHdoaWxlIHRoZSBjb21tYW5kIHdhcyBzdWJtaXR0ZWQuCgpUaGlz
IHdhcm5pbmcgbWlzbGVhZHMsIGhlbmNlIHRoaXMgY2hhbmdlLgoKU2lnbmVkLW9mZi1ieTogU2hp
cmlzaCBTIDxzaGlyaXNoLnNAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcHNwLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKaW5kZXgg
NzZjNTlkNS4uMzdmZmVkNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3BzcC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3Au
YwpAQCAtMTcwLDcgKzE3MCw3IEBAIHBzcF9jbWRfc3VibWl0X2J1ZihzdHJ1Y3QgcHNwX2NvbnRl
eHQgKnBzcCwKIAkJaWYgKHVjb2RlKQogCQkJRFJNX1dBUk4oImZhaWxlZCB0byBsb2FkIHVjb2Rl
IGlkICglZCkgIiwKIAkJCQkgIHVjb2RlLT51Y29kZV9pZCk7Ci0JCURSTV9XQVJOKCJwc3AgY29t
bWFuZCAoMHglWCkgZmFpbGVkIGFuZCByZXNwb25zZSBzdGF0dXMgaXMgKDB4JVgpXG4iLAorCQlE
Uk1fREVCVUdfRFJJVkVSKCJwc3AgY29tbWFuZCAoMHglWCkgZmFpbGVkIGFuZCByZXNwb25zZSBz
dGF0dXMgaXMgKDB4JVgpXG4iLAogCQkJIHBzcC0+Y21kX2J1Zl9tZW0tPmNtZF9pZCwKIAkJCSBw
c3AtPmNtZF9idWZfbWVtLT5yZXNwLnN0YXR1cyAmIEdGWF9DTURfU1RBVFVTX01BU0spOwogCQlp
ZiAoIXRpbWVvdXQpIHsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
