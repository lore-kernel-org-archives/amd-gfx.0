From: Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/8] drm/amdgpu: add new member in amdgpu_mc for zfb support
Date: Thu, 15 Mar 2018 14:11:58 +0800
Message-ID: <1521094324-23252-2-git-send-email-Feifei.Xu@amd.com>
References: <1521094324-23252-1-git-send-email-Feifei.Xu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1521094324-23252-1-git-send-email-Feifei.Xu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Feifei.Xu-5C7GfCeVMHo@public.gmane.org, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJODI1M2M4ZmY4MGUwY2JkMWYxMmU1ZWU4MDE2MDBlNzYxOWU2NzE4ZgpTaWdu
ZWQtb2ZmLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+ClNpZ25lZC1v
ZmYtYnk6IEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+CkFja2VkLWJ5OiBKb2huIEJyaWRn
bWFuIDxqb2huLmJyaWRnbWFuQGFtZC5jb20+ClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dtYy5oIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmggYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmgKaW5kZXggODkzYzI0OS4uOGYzNWY3
ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaApAQCAtMTA3LDYgKzEw
Nyw5IEBAIHN0cnVjdCBhbWRncHVfZ21jIHsKIAlib29sCQkJdHJhbnNsYXRlX2Z1cnRoZXI7CiAK
IAljb25zdCBzdHJ1Y3QgYW1kZ3B1X2dtY19mdW5jcwkqZ21jX2Z1bmNzOworICAgIC8qIHplcm8g
ZnJhbWUgYnVmZmVyICovCisgICAgdTY0IHpmYl9waHlzX2FkZHI7CisgICAgdTY0IHpmYl9zaXpl
OwogfTsKIAogI2VuZGlmCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
