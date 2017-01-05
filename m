From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] headers: add new context priority parameter to
 amdgpu_drm.h
Date: Wed,  4 Jan 2017 19:29:34 -0500
Message-ID: <20170105002935.5796-3-andresx7@gmail.com>
References: <20170105002935.5796-1-andresx7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170105002935.5796-1-andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: emil.l.velikov-Re5JQEeQqe8@public.gmane.org, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

VGhpcyBwYXRjaCBpcyBmb3IgcmVmZXJlbmNlIG9ubHksIGFzIHRoZSBjb3JyZXNwb25kaW5nIGtl
cm5lbCBjaGFuZ2UgaXMKc3RpbGwgdW5kZXIgcmV2aWV3LgoKU2lnbmVkLW9mZi1ieTogQW5kcmVz
IFJvZHJpZ3VleiA8YW5kcmVzeDdAZ21haWwuY29tPgotLS0KIGluY2x1ZGUvZHJtL2FtZGdwdV9k
cm0uaCB8IDYgKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oIGIvaW5jbHVkZS9k
cm0vYW1kZ3B1X2RybS5oCmluZGV4IDM5NjE4MzYuLjJkMzMxZWUgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvZHJtL2FtZGdwdV9kcm0uaAorKysgYi9pbmNsdWRlL2RybS9hbWRncHVfZHJtLmgKQEAgLTE2
MCwxMyArMTYwLDE3IEBAIHVuaW9uIGRybV9hbWRncHVfYm9fbGlzdCB7CiAvKiB1bmtub3duIGNh
dXNlICovCiAjZGVmaW5lIEFNREdQVV9DVFhfVU5LTk9XTl9SRVNFVAkzCiAKKy8qIENvbnRleHQg
cHJpb3JpdHkgbGV2ZWwgKi8KKyNkZWZpbmUgQU1ER1BVX0NUWF9QUklPUklUWV9OT1JNQUwJMAor
I2RlZmluZSBBTURHUFVfQ1RYX1BSSU9SSVRZX0hJR0gJMQorCiBzdHJ1Y3QgZHJtX2FtZGdwdV9j
dHhfaW4gewogCS8qKiBBTURHUFVfQ1RYX09QXyogKi8KIAlfX3UzMglvcDsKIAkvKiogRm9yIGZ1
dHVyZSB1c2UsIG5vIGZsYWdzIGRlZmluZWQgc28gZmFyICovCiAJX191MzIJZmxhZ3M7CiAJX191
MzIJY3R4X2lkOwotCV9fdTMyCV9wYWQ7CisJX191MzIJcHJpb3JpdHk7CiB9OwogCiB1bmlvbiBk
cm1fYW1kZ3B1X2N0eF9vdXQgewotLSAKMi45LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
