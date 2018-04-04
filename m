From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 02/19] Guard ODEV_ATTRIB_FD usage with the
 correct ifdef
Date: Wed,  4 Apr 2018 15:29:37 +0100
Message-ID: <20180404142954.31360-3-emil.l.velikov@gmail.com>
References: <20180404142954.31360-1-emil.l.velikov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180404142954.31360-1-emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

RnJvbTogRW1pbCBWZWxpa292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KClNpZ25lZC1v
ZmYtYnk6IEVtaWwgVmVsaWtvdiA8ZW1pbC52ZWxpa292QGNvbGxhYm9yYS5jb20+Ci0tLQogc3Jj
L2FtZGdwdV9wcm9iZS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2FtZGdwdV9wcm9iZS5jIGIvc3JjL2FtZGdw
dV9wcm9iZS5jCmluZGV4IDA3NWU1YzEuLmU2NWM4M2IgMTAwNjQ0Ci0tLSBhL3NyYy9hbWRncHVf
cHJvYmUuYworKysgYi9zcmMvYW1kZ3B1X3Byb2JlLmMKQEAgLTEyMCw3ICsxMjAsNyBAQCBzdGF0
aWMgaW50IGFtZGdwdV9rZXJuZWxfb3Blbl9mZChTY3JuSW5mb1B0ciBwU2NybiwKIAljaGFyICpi
dXNpZDsKIAlpbnQgZmQ7CiAKLSNpZmRlZiBYRjg2X1BERVZfU0VSVkVSX0ZECisjaWZkZWYgT0RF
Vl9BVFRSSUJfRkQKIAlpZiAocGxhdGZvcm1fZGV2KSB7CiAJCWZkID0geGY4Nl9nZXRfcGxhdGZv
cm1fZGV2aWNlX2ludF9hdHRyaWIocGxhdGZvcm1fZGV2LAogCQkJCQkJCSBPREVWX0FUVFJJQl9G
RCwgLTEpOwotLSAKMi4xNi4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
