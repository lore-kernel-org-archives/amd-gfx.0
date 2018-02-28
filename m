From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH libdrm] amdgpu: fix "add AMDGPU_VA_RANGE_HIGH"
Date: Wed, 28 Feb 2018 15:41:11 +0100
Message-ID: <20180228144111.1651-1-christian.koenig@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

VGhlIDMyYml0IGFkZHJlc3MgcmFuZ2UgZW5kIGlzIGV4Y2x1c2l2ZSwgbm90IGluY2x1c2l2ZS4g
VGhpcyBmaXhlcyBjcmFzaGVzCndoZW4gMzJiaXQgYWRkcmVzc2VzIGFyZSBpbiB1c2UuCgpTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0t
LQogYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jIGIvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCA5ZmY2YWQxNi4uZmIyY2ZiNTcg
MTAwNjQ0Ci0tLSBhL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYwpAQCAtMzIzLDkgKzMyMyw5IEBAIGludCBhbWRncHVfcXVlcnlfc3dfaW5mbyhhbWRn
cHVfZGV2aWNlX2hhbmRsZSBkZXYsIGVudW0gYW1kZ3B1X3N3X2luZm8gaW5mbywKIAlzd2l0Y2gg
KGluZm8pIHsKIAljYXNlIGFtZGdwdV9zd19pbmZvX2FkZHJlc3MzMl9oaToKIAkJaWYgKGRldi0+
dmFtZ3JfaGlnaF8zMi52YV9tYXgpCi0JCQkqdmFsMzIgPSBkZXYtPnZhbWdyX2hpZ2hfMzIudmFf
bWF4ID4+IDMyOworCQkJKnZhbDMyID0gKGRldi0+dmFtZ3JfaGlnaF8zMi52YV9tYXggLSAxKSA+
PiAzMjsKIAkJZWxzZQotCQkJKnZhbDMyID0gZGV2LT52YW1ncl8zMi52YV9tYXggPj4gMzI7CisJ
CQkqdmFsMzIgPSAoZGV2LT52YW1ncl8zMi52YV9tYXggLSAxKSA+PiAzMjsKIAkJcmV0dXJuIDA7
CiAJfQogCXJldHVybiAtRUlOVkFMOwotLSAKMi4xNC4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
