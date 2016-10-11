From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix broken UVD startup in phys mode
Date: Tue, 11 Oct 2016 15:39:17 -0400
Message-ID: <1476214757-5273-1-git-send-email-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

QWRkIHR5cGUsIGFsaWduX21hc2sgYW5kIG5vcCB0byB0aGUgcGh5c2ljYWwgbW9kZSBVVkQgZnVu
Y3MgYXMgd2VsbC4KClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjZfMC5jIHwg
MyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjZfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdXZkX3Y2XzAuYwppbmRleCAxNTcwOGY4Li44ZjhhNWRkIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjZfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3V2ZF92Nl8wLmMKQEAgLTEwMjIsNiArMTAyMiw5IEBAIGNvbnN0IHN0cnVjdCBh
bWRfaXBfZnVuY3MgdXZkX3Y2XzBfaXBfZnVuY3MgPSB7CiB9OwogCiBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGFtZGdwdV9yaW5nX2Z1bmNzIHV2ZF92Nl8wX3JpbmdfcGh5c19mdW5jcyA9IHsKKwkudHlw
ZSA9IEFNREdQVV9SSU5HX1RZUEVfVVZELAorCS5hbGlnbl9tYXNrID0gMHhmLAorCS5ub3AgPSBQ
QUNLRVQwKG1tVVZEX05PX09QLCAwKSwKIAkuZ2V0X3JwdHIgPSB1dmRfdjZfMF9yaW5nX2dldF9y
cHRyLAogCS5nZXRfd3B0ciA9IHV2ZF92Nl8wX3JpbmdfZ2V0X3dwdHIsCiAJLnNldF93cHRyID0g
dXZkX3Y2XzBfcmluZ19zZXRfd3B0ciwKLS0gCjIuNS41CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
