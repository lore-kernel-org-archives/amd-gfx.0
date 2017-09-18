From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 18/18] drm/amdgpu/sriov:init csb for gfxv9
Date: Mon, 18 Sep 2017 14:12:02 +0800
Message-ID: <1505715122-23904-19-git-send-email-Monk.Liu@amd.com>
References: <1505715122-23904-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1505715122-23904-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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

UkxDIG5lZWQgQ1NCIHJlZ2lzdGVycyBpbml0aWF0ZWQgdW5kZXIgU1JJT1YgZHVyaW5nIHdvcmxk
IHN3aXRjaApvdGhlcndpc2UgdGhlIGNsZWFyIHN0YXRlIGJ1ZmZlciBiZWhhdiB3aWxsIG5vdCBi
ZSByZWNvdmVyZWQgdG8KY3VycmVudCBWRiBzY2hlbWUgYWZ0ZXIgc3dpdGNoIGJhY2sKCkNoYW5n
ZS1JZDogSTNhZmQ4Mjg3NTU2NGMyMzMwNjBiNzQwNzI0YmQ4MDMxMDk1NzgwZjYKU2lnbmVkLW9m
Zi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y5XzAuYyB8IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCmlu
ZGV4IGE1NzdiYmMuLjhkNjc3Y2MgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAu
YwpAQCAtMjA0NCw4ICsyMDQ0LDEwIEBAIHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfcmxjX3Jlc3VtZShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKIAlpbnQgcjsKIAotCWlmIChhbWRncHVfc3Jp
b3ZfdmYoYWRldikpCisJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkgeworCQlnZnhfdjlfMF9p
bml0X2NzYihhZGV2KTsKIAkJcmV0dXJuIDA7CisJfQogCiAJZ2Z4X3Y5XzBfcmxjX3N0b3AoYWRl
dik7CiAKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
