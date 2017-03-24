From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 03/13] drm/amdgpu:add KIQ interrupt id
Date: Fri, 24 Mar 2017 18:38:22 +0800
Message-ID: <1490351912-10122-4-git-send-email-Monk.Liu@amd.com>
References: <1490351912-10122-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490351912-10122-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

MTc4IGlkIGlzIGZvciBHRU5FUklDMiBpbnRlcnJ1cHQgd2hpY2ggaXMgdXNlZCBieSBLSVEKCkNo
YW5nZS1JZDogSTlhYTlhOTBhOTdiMzNhZWM4Y2E4MjA3ZDE4MTRlYWVjZGM5MjY2N2QKU2lnbmVk
LW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlf
MC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwppbmRleCAwZDhmYjUx
Li5jZTZmYTAzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlf
MC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKQEAgLTEwMjMs
NiArMTAyMywxMSBAQCBzdGF0aWMgaW50IGdmeF92OV8wX3N3X2luaXQodm9pZCAqaGFuZGxlKQog
CXN0cnVjdCBhbWRncHVfa2lxICpraXE7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7CiAKKwkvKiBLSVEgZXZlbnQgKi8KKwlyID0g
YW1kZ3B1X2lycV9hZGRfaWQoYWRldiwgQU1ER1BVX0lIX0NMSUVOVElEX0dSQk1fQ1AsIDE3OCwg
JmFkZXYtPmdmeC5raXEuaXJxKTsKKwlpZiAocikKKwkJcmV0dXJuIHI7CisKIAkvKiBFT1AgRXZl
bnQgKi8KIAlyID0gYW1kZ3B1X2lycV9hZGRfaWQoYWRldiwgQU1ER1BVX0lIX0NMSUVOVElEX0dS
Qk1fQ1AsIDE4MSwgJmFkZXYtPmdmeC5lb3BfaXJxKTsKIAlpZiAocikKLS0gCjIuNy40CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
