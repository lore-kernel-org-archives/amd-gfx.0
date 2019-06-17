From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 018/459] drm/amdgpu: add GDDR6 vram type
Date: Mon, 17 Jun 2019 14:09:39 -0500
Message-ID: <20190617191700.17899-7-alexander.deucher@amd.com>
References: <20190617191700.17899-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190617191700.17899-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

RnJvbTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KClNpZ25lZC1vZmYtYnk6IEh1YW5n
IFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+ClJldmlld2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5n
LlpoYW5nQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRl
dWNoZXJAYW1kLmNvbT4KLS0tCiBpbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaCB8IDEgKwog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBp
L2RybS9hbWRncHVfZHJtLmggYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaAppbmRleCAw
ZjVlY2NiZDUyYmEuLjM0NGMzNmU4OTkyMyAxMDA2NDQKLS0tIGEvaW5jbHVkZS91YXBpL2RybS9h
bWRncHVfZHJtLmgKKysrIGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgKQEAgLTkxNSw2
ICs5MTUsNyBAQCBzdHJ1Y3QgZHJtX2FtZGdwdV9pbmZvX2Zpcm13YXJlIHsKICNkZWZpbmUgQU1E
R1BVX1ZSQU1fVFlQRV9IQk0gICA2CiAjZGVmaW5lIEFNREdQVV9WUkFNX1RZUEVfRERSMyAgNwog
I2RlZmluZSBBTURHUFVfVlJBTV9UWVBFX0REUjQgIDgKKyNkZWZpbmUgQU1ER1BVX1ZSQU1fVFlQ
RV9HRERSNiA5CiAKIHN0cnVjdCBkcm1fYW1kZ3B1X2luZm9fZGV2aWNlIHsKIAkvKiogUENJIERl
dmljZSBJRCAqLwotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=
