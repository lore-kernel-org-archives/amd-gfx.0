From: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/3] drm/amdgpu: enable psp front door loading by default on
 Arcturus
Date: Mon, 23 Sep 2019 14:28:46 +0800
Message-ID: <1569220126-4033-3-git-send-email-le.ma@amd.com>
References: <1569220126-4033-1-git-send-email-le.ma@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1569220126-4033-1-git-send-email-le.ma-5C7GfCeVMHo@public.gmane.org>
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
Cc: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJMTNhNWY1OTBkNWE0OTY1NTk2NWExM2ViN2NlNzczZDFlZmZmY2JkMApTaWdu
ZWQtb2ZmLWJ5OiBMZSBNYSA8bGUubWFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdWNvZGUuYyB8IDMgKy0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Vjb2RlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dWNvZGUuYwppbmRleCA4MmY2YjQxLi5mY2UxZjcxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdWNvZGUuYwpAQCAtMzYwLDYgKzM2MCw3IEBAIGFtZGdwdV91Y29kZV9nZXRf
bG9hZF90eXBlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBpbnQgbG9hZF90eXBlKQogCWNh
c2UgQ0hJUF9SQVZFTjoKIAljYXNlIENISVBfVkVHQTEyOgogCWNhc2UgQ0hJUF9WRUdBMjA6CisJ
Y2FzZSBDSElQX0FSQ1RVUlVTOgogCWNhc2UgQ0hJUF9SRU5PSVI6CiAJY2FzZSBDSElQX05BVkkx
MDoKIAljYXNlIENISVBfTkFWSTE0OgpAQCAtMzY4LDggKzM2OSw2IEBAIGFtZGdwdV91Y29kZV9n
ZXRfbG9hZF90eXBlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBpbnQgbG9hZF90eXBlKQog
CQkJcmV0dXJuIEFNREdQVV9GV19MT0FEX0RJUkVDVDsKIAkJZWxzZQogCQkJcmV0dXJuIEFNREdQ
VV9GV19MT0FEX1BTUDsKLQljYXNlIENISVBfQVJDVFVSVVM6Ci0JCXJldHVybiBBTURHUFVfRldf
TE9BRF9ESVJFQ1Q7CiAKIAlkZWZhdWx0OgogCQlEUk1fRVJST1IoIlVua25vd24gZmlybXdhcmUg
bG9hZCB0eXBlXG4iKTsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
