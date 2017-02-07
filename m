From: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 7/7] drm/amd/gfx6: update gb_addr_config
Date: Tue, 7 Feb 2017 16:13:39 +0800
Message-ID: <1486455219-12495-7-git-send-email-Flora.Cui@amd.com>
References: <1486455219-12495-1-git-send-email-Flora.Cui@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1486455219-12495-1-git-send-email-Flora.Cui-5C7GfCeVMHo@public.gmane.org>
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
To: Hawking.Zhang-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJM2I4NjZhNzE5ZTk5YWYyZWVkNDYxZmQ2MTgzNDhiYTZhMjhlMWY4MQpTaWdu
ZWQtb2ZmLWJ5OiBGbG9yYSBDdWkgPEZsb3JhLkN1aUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92Nl8wLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
Nl8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjZfMC5jCmluZGV4IDc2NWM1
ZTMuLjc4MjE5MGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
Nl8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y2XzAuYwpAQCAtMTcx
MCw2ICsxNzEwLDkgQEAgc3RhdGljIHZvaWQgZ2Z4X3Y2XzBfZ3B1X2luaXQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCiAJCWdiX2FkZHJfY29uZmlnIHw9IDIgPDwgR0JfQUREUl9DT05GSUdf
X1JPV19TSVpFX19TSElGVDsKIAkJYnJlYWs7CiAJfQorCWdiX2FkZHJfY29uZmlnICY9IH5HQl9B
RERSX0NPTkZJR19fTlVNX1NIQURFUl9FTkdJTkVTX01BU0s7CisJaWYgKGFkZXYtPmdmeC5jb25m
aWcubWF4X3NoYWRlcl9lbmdpbmVzID09IDIpCisJCWdiX2FkZHJfY29uZmlnIHw9IDEgPDwgR0Jf
QUREUl9DT05GSUdfX05VTV9TSEFERVJfRU5HSU5FU19fU0hJRlQ7CiAJYWRldi0+Z2Z4LmNvbmZp
Zy5nYl9hZGRyX2NvbmZpZyA9IGdiX2FkZHJfY29uZmlnOwogCiAJV1JFRzMyKG1tR0JfQUREUl9D
T05GSUcsIGdiX2FkZHJfY29uZmlnKTsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
