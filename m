From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH libdrm 4/4] test/amdgpu: fix compiler warnings
Date: Sun,  7 Jan 2018 10:11:35 +0100
Message-ID: <20180107091135.2373-4-christian.koenig@amd.com>
References: <20180107091135.2373-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180107091135.2373-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

U1dBUF8zMigpIHNob3VsZCBtYXNrIGZpcnN0IGFuZCB0aGVuIHNoaWZ0LgoKU2lnbmVkLW9mZi1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIHRlc3Rz
L2FtZGdwdS9iYXNpY190ZXN0cy5jIHwgOCArKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy9hbWRncHUvYmFz
aWNfdGVzdHMuYyBiL3Rlc3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jCmluZGV4IDQ3NGE2NzljLi45
YzkxODk1MSAxMDA2NDQKLS0tIGEvdGVzdHMvYW1kZ3B1L2Jhc2ljX3Rlc3RzLmMKKysrIGIvdGVz
dHMvYW1kZ3B1L2Jhc2ljX3Rlc3RzLmMKQEAgLTI1MywxMCArMjUzLDEwIEBAIENVX1Rlc3RJbmZv
IGJhc2ljX3Rlc3RzW10gPSB7CiAKIAogCi0jZGVmaW5lIFNXQVBfMzIobnVtKSAoKG51bT4+MjQp
JjB4ZmYpIHwgXAotCQkJKChudW08PDgpJjB4ZmYwMDAwKSB8IFwKLQkJCSgobnVtPj44KSYweGZm
MDApIHwgXAotCQkJKChudW08PDI0KSYweGZmMDAwMDAwKQorI2RlZmluZSBTV0FQXzMyKG51bSkg
KCgobnVtICYgMHhmZjAwMDAwMCkgPj4gMjQpIHwgXAorCQkgICAgICAoKG51bSAmIDB4MDAwMGZm
MDApIDw8IDgpIHwgXAorCQkgICAgICAoKG51bSAmIDB4MDBmZjAwMDApID4+IDgpIHwgXAorCQkg
ICAgICAoKG51bSAmIDB4MDAwMDAwZmYpIDw8IDI0KSkKIAogCiAvKiBTaGFkZXIgY29kZQotLSAK
Mi4xMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
