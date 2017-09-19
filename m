From: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/4] drm/amd/powerplay: change alert temperature range
Date: Tue, 19 Sep 2017 14:06:48 -0400
Message-ID: <1505844408-9731-5-git-send-email-JinHuiEric.Huang@amd.com>
References: <1505844408-9731-1-git-send-email-JinHuiEric.Huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1505844408-9731-1-git-send-email-JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlIHRvIG1vcmUgbWVhbmluZ2Z1bCByYW5nZSB0aGF0IHRyaWdnZXJzIHRoZXJtYWwKaW50
ZXJydXB0cy4KClNpZ25lZC1vZmYtYnk6IEVyaWMgSHVhbmcgPEppbkh1aUVyaWMuSHVhbmdAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9oYXJkd2FyZW1h
bmFnZXIuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21n
ci9oYXJkd2FyZW1hbmFnZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdy
L2hhcmR3YXJlbWFuYWdlci5jCmluZGV4IGNlMzc4YmQuLjE1YmIzMmEgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL2hhcmR3YXJlbWFuYWdlci5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL2hhcmR3YXJlbWFuYWdlci5jCkBA
IC0yNyw4ICsyNyw4IEBACiAjaW5jbHVkZSAicG93ZXJfc3RhdGUuaCIKIAogCi0jZGVmaW5lIFRF
TVBfUkFOR0VfTUlOICg5MCAqIDEwMDApCi0jZGVmaW5lIFRFTVBfUkFOR0VfTUFYICgxMjAgKiAx
MDAwKQorI2RlZmluZSBURU1QX1JBTkdFX01JTiAoMCkKKyNkZWZpbmUgVEVNUF9SQU5HRV9NQVgg
KDgwICogMTAwMCkKIAogI2RlZmluZSBQSE1fRlVOQ19DSEVDSyhodykgXAogCWRvIHsJCQkJCQkJ
XAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
