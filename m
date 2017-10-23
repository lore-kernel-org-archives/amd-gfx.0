From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/ttm:fix memory leak due to individualize
Date: Mon, 23 Oct 2017 10:31:36 +0800
Message-ID: <1508725896-6092-1-git-send-email-Monk.Liu@amd.com>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJNmQwNmI4MWI4Yjg5NDc3NWU1NWU0OTVlOTZmM2M5OTliODNjZjJiZQpTaWdu
ZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vdHRtL3R0bV9iby5jIHwgNSArKysrLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2Jv
LmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jCmluZGV4IDk3MTI1Y2IuLjNjOWMwZDkg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL3R0bS90dG1fYm8uYwpAQCAtNDYwLDggKzQ2MCwxMSBAQCBzdGF0aWMgdm9pZCB0dG1f
Ym9fY2xlYW51cF9yZWZzX29yX3F1ZXVlKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8pCiAJ
CWlmIChyZXNlcnZhdGlvbl9vYmplY3RfdGVzdF9zaWduYWxlZF9yY3UoJmJvLT50dG1fcmVzdiwg
dHJ1ZSkpIHsKIAkJCXR0bV9ib19kZWxfZnJvbV9scnUoYm8pOwogCQkJc3Bpbl91bmxvY2soJmds
b2ItPmxydV9sb2NrKTsKLQkJCWlmIChiby0+cmVzdiAhPSAmYm8tPnR0bV9yZXN2KQorCQkJaWYg
KGJvLT5yZXN2ICE9ICZiby0+dHRtX3Jlc3YpIHsKIAkJCQlyZXNlcnZhdGlvbl9vYmplY3RfdW5s
b2NrKCZiby0+dHRtX3Jlc3YpOworCQkJCXJlc2VydmF0aW9uX29iamVjdF9maW5pKCZiby0+dHRt
X3Jlc3YpOworCQkJfQorCiAJCQl0dG1fYm9fY2xlYW51cF9tZW10eXBlX3VzZShibyk7CiAJCQly
ZXR1cm47CiAJCX0KLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
