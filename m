From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/5] drm/amdgpu/psp: Enable mode 0 reset for XGMI.
Date: Wed, 21 Nov 2018 13:10:18 -0500
Message-ID: <1542823821-15631-3-git-send-email-andrey.grodzovsky@amd.com>
References: <1542823821-15631-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1542823821-15631-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, Monk.Liu-5C7GfCeVMHo@public.gmane.org

SW4gY2FzZSBvZiBhY3RpdmUgWEdNSSBoaXZlIGRvIG1vZGUgMCByZXNldCBhcyByZXF1c3RlZApi
eSBkZXNpZ24uCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6
b3Zza3lAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNw
LmMgfCA2ICsrKysrLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3Au
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwppbmRleCBlMDVkYzY2
Li5iZWZlZTEyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cHNwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCkBAIC03
MzMsNyArNzMzLDExIEBAIGludCBwc3BfZ3B1X3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQogCWlmIChhZGV2LT5maXJtd2FyZS5sb2FkX3R5cGUgIT0gQU1ER1BVX0ZXX0xPQURfUFNQ
KQogCQlyZXR1cm4gMDsKIAotCXJldHVybiBwc3BfbW9kZTFfcmVzZXQoJmFkZXYtPnBzcCk7CisK
KwlpZiAoYWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2FsX25vZGVzID4gMSkKKwkJcmV0dXJuIHBz
cF9tb2RlMF9yZXNldCgmYWRldi0+cHNwKTsKKwllbHNlCisJCXJldHVybiBwc3BfbW9kZTFfcmVz
ZXQoJmFkZXYtPnBzcCk7CiB9CiAKIHN0YXRpYyBib29sIHBzcF9jaGVja19md19sb2FkaW5nX3N0
YXR1cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKLS0gCjIuNy40CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
