From: Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/9] drm/amdgpu: add new member in amdgpu_mc for zfb support
Date: Wed, 7 Feb 2018 20:34:45 +0800
Message-ID: <1518006892-14121-3-git-send-email-Feifei.Xu@amd.com>
References: <1518006892-14121-1-git-send-email-Feifei.Xu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1518006892-14121-1-git-send-email-Feifei.Xu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJNDNhYjMxYTY4ZTkzZWYyNjRmYjhkOGRkOGEzZGJhNTllMjk2MmZhZApTaWdu
ZWQtb2ZmLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+CkFja2VkLWJ5
OiBKb2huIEJyaWRnbWFuIDxqb2huLmJyaWRnbWFuQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oIHwgNSArKysrKwogMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9nbWMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaAppbmRl
eCBmNGI4MmVmNy4uZmQ1Zjc2NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2dtYy5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9n
bWMuaApAQCAtMTA3LDYgKzEwNywxMSBAQCBzdHJ1Y3QgYW1kZ3B1X2dtYyB7CiAJYXRvbWljX3Qg
ICAgICAgICAgICAgICAgdm1fZmF1bHRfaW5mb191cGRhdGVkOwogCiAJY29uc3Qgc3RydWN0IGFt
ZGdwdV9nbWNfZnVuY3MJKmdtY19mdW5jczsKKworCS8qIHplcm8gZnJhbWUgYnVmZmVyICovCisJ
Ym9vbAkJZW5hYmxlX3pmYjsKKwl1NjQJCXpmYl9waHlzX2FkZHI7CisJdTY0CQl6ZmJfc2l6ZTsK
IH07CiAKICNlbmRpZgotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
