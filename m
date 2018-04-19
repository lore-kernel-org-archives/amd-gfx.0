From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 17/20] drm/amdgpu: it should disable gfxoff when system is
 going to suspend
Date: Thu, 19 Apr 2018 08:22:33 +0800
Message-ID: <1524097356-4974-18-git-send-email-ray.huang@amd.com>
References: <1524097356-4974-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1524097356-4974-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6
IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA2ICsrKysrKwogMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YwppbmRleCA4ZTYzODMyLi5mNTA5ZDMyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jCkBAIC0xOTAyLDYgKzE5MDIsMTIgQEAgaW50IGFtZGdwdV9kZXZpY2Vf
aXBfc3VzcGVuZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAlpZiAoYW1kZ3B1X3NyaW92
X3ZmKGFkZXYpKQogCQlhbWRncHVfdmlydF9yZXF1ZXN0X2Z1bGxfZ3B1KGFkZXYsIGZhbHNlKTsK
IAorCS8qIHVuZ2F0ZSBTTUMgYmxvY2sgcG93ZXJnYXRpbmcgKi8KKwlpZiAoYWRldi0+cG93ZXJw
bGF5LnBwX2ZlYXR1cmUgJiBQUF9HRlhPRkZfTUFTSykKKwkJYW1kZ3B1X2RldmljZV9pcF9zZXRf
cG93ZXJnYXRpbmdfc3RhdGUoYWRldiwKKwkJCQkJCSAgICAgICBBTURfSVBfQkxPQ0tfVFlQRV9T
TUMsCisJCQkJCQkgICAgICAgQU1EX0NHX1NUQVRFX1VOR0FURSk7CisKIAkvKiB1bmdhdGUgU01D
IGJsb2NrIGZpcnN0ICovCiAJciA9IGFtZGdwdV9kZXZpY2VfaXBfc2V0X2Nsb2NrZ2F0aW5nX3N0
YXRlKGFkZXYsIEFNRF9JUF9CTE9DS19UWVBFX1NNQywKIAkJCQkJCSAgIEFNRF9DR19TVEFURV9V
TkdBVEUpOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
