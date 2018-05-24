From: Tom Stellard <tstellar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Use dev_info() to report amdkfd is not supported
 for this ASIC
Date: Thu, 24 May 2018 14:07:14 -0700
Message-ID: <1527196034-29268-1-git-send-email-tstellar@redhat.com>
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
Cc: oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Felix.Kuehling-5C7GfCeVMHo@public.gmane.org, Tom Stellard <tstellar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

VGhpcyBpcyBhbiBpbXBvcnRhbnQgbWVzc2FnZSwgc28gaXQgc2hvdWxkIGJlIHZpc2libGUgdG8g
dXNlcnMgd2l0aG91dApoYXZpbmcgdG8gZW5hYmxlIGV4dHJhIGRlYnVnZ2luZy4KClNpZ25lZC1v
ZmYtYnk6IFRvbSBTdGVsbGFyZCA8dHN0ZWxsYXJAcmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfYW1ka2ZkLmMKaW5kZXggNGQzNjIwM2ZmYjExLi5jMThhMzMyZTc5MGIgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKQEAgLTkzLDcgKzkzLDcg
QEAgdm9pZCBhbWRncHVfYW1ka2ZkX2RldmljZV9wcm9iZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKIAkJa2ZkMmtnZCA9IGFtZGdwdV9hbWRrZmRfZ2Z4XzhfMF9nZXRfZnVuY3Rpb25zKCk7
CiAJCWJyZWFrOwogCWRlZmF1bHQ6Ci0JCWRldl9kYmcoYWRldi0+ZGV2LCAia2ZkIG5vdCBzdXBw
b3J0ZWQgb24gdGhpcyBBU0lDXG4iKTsKKwkJZGV2X2luZm8oYWRldi0+ZGV2LCAia2ZkIG5vdCBz
dXBwb3J0ZWQgb24gdGhpcyBBU0lDXG4iKTsKIAkJcmV0dXJuOwogCX0KIAotLSAKMi4xNy4wCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
