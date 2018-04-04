From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 11/19] Don't leak a AMDGPUEntRec instance if
 amdgpu_device_setup fails
Date: Wed,  4 Apr 2018 15:29:46 +0100
Message-ID: <20180404142954.31360-12-emil.l.velikov@gmail.com>
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

RnJvbTogRW1pbCBWZWxpa292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KClNlZW1zIGxp
a2Ugd2UndmUgYmVlbiBsZWFraW5nIHRoaXMgZm9yIHllYXJzLiBJdCBiZWNhbWUgbW9yZSBvYnZp
b3VzCndpdGggdGhlIHJlY2VudCByZWZhY3RvcmluZy4KClNpZ25lZC1vZmYtYnk6IEVtaWwgVmVs
aWtvdiA8ZW1pbC52ZWxpa292QGNvbGxhYm9yYS5jb20+Ci0tLQogc3JjL2FtZGdwdV9wcm9iZS5j
IHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Ny
Yy9hbWRncHVfcHJvYmUuYyBiL3NyYy9hbWRncHVfcHJvYmUuYwppbmRleCA1MzdkNDRjLi41ODg4
OTFjIDEwMDY0NAotLS0gYS9zcmMvYW1kZ3B1X3Byb2JlLmMKKysrIGIvc3JjL2FtZGdwdV9wcm9i
ZS5jCkBAIC0yNDMsNiArMjQzLDggQEAgYW1kZ3B1X3Byb2JlKFNjcm5JbmZvUHRyIHBTY3JuLCBp
bnQgZW50aXR5X251bSwKIAlyZXR1cm4gVFJVRTsKIAogZXJyb3I6CisJZnJlZShwUHJpdi0+cHRy
KTsKKwlwUHJpdi0+cHRyID0gTlVMTDsKIAlyZXR1cm4gRkFMU0U7CiB9CiAKLS0gCjIuMTYuMAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
