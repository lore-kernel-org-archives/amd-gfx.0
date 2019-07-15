From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 037/102] drm/amdgpu: enable 8 SDMA instances for Arcturus
Date: Mon, 15 Jul 2019 16:23:32 -0500
Message-ID: <20190715212437.31793-35-alexander.deucher@amd.com>
References: <20190715212437.31793-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190715212437.31793-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Snow Zhang <Snow.Zhang-5C7GfCeVMHo@public.gmane.org>, Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTGUgTWEgPGxlLm1hQGFtZC5jb20+CgpBbGwgdGhlIDggU0RNQSBpbnN0YW5jZXMgd29y
ayBmaW5lIG9uIHRoZSBsYXRlc3QgR29waGVyIGJ1aWxkIG1vZGVsLgoKU2lnbmVkLW9mZi1ieTog
TGUgTWEgPGxlLm1hQGFtZC5jb20+ClJldmlld2VkLWJ5OiBTbm93IFpoYW5nIDxTbm93LlpoYW5n
QGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYyB8IDIg
KysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3NkbWFfdjRfMC5jCmluZGV4IDk3NDIyOGI5MThkMi4uMGNhNDFhOGE3ZTViIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYwpAQCAtMTUzOSw2ICsxNTM5LDggQEAgc3Rh
dGljIGludCBzZG1hX3Y0XzBfZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpCiAKIAlpZiAoYWRldi0+
YXNpY190eXBlID09IENISVBfUkFWRU4pCiAJCWFkZXYtPnNkbWEubnVtX2luc3RhbmNlcyA9IDE7
CisJZWxzZSBpZiAoYWRldi0+YXNpY190eXBlID09IENISVBfQVJDVFVSVVMpCisJCWFkZXYtPnNk
bWEubnVtX2luc3RhbmNlcyA9IDg7CiAJZWxzZQogCQlhZGV2LT5zZG1hLm51bV9pbnN0YW5jZXMg
PSAyOwogCi0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
