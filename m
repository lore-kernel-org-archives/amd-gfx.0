From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: fix unused variable warnings
Date: Thu,  3 Jan 2019 10:59:59 +0100
Message-ID: <20190103095959.20354-2-christian.koenig@amd.com>
References: <20190103095959.20354-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190103095959.20354-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

SnVzdCByZW1vdmUgc29tZSBsZWZ0b3ZlcnMuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y4XzAuYyB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jCmluZGV4IDE2NGZmYzkxYjY0NS4uNTdj
YjNhNTFiZGE3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhf
MC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKQEAgLTQyMzMs
NyArNDIzMyw2IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y4XzBfY3BfZ2Z4X3Jlc3VtZShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKIAl1MzIgdG1wOwogCXUzMiByYl9idWZzejsKIAl1NjQgcmJfYWRk
ciwgcnB0cl9hZGRyLCB3cHRyX2dwdV9hZGRyOwotCWludCByOwogCiAJLyogU2V0IHRoZSB3cml0
ZSBwb2ludGVyIGRlbGF5ICovCiAJV1JFRzMyKG1tQ1BfUkJfV1BUUl9ERUxBWSwgMCk7CkBAIC01
MDc1LDcgKzUwNzQsNiBAQCBzdGF0aWMgaW50IGdmeF92OF8wX3Bvc3Rfc29mdF9yZXNldCh2b2lk
ICpoYW5kbGUpCiB7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKiloYW5kbGU7CiAJdTMyIGdyYm1fc29mdF9yZXNldCA9IDA7Ci0Jc3RydWN0IGFt
ZGdwdV9yaW5nICpyaW5nOwogCiAJaWYgKCghYWRldi0+Z2Z4LmdyYm1fc29mdF9yZXNldCkgJiYK
IAkgICAgKCFhZGV2LT5nZnguc3JibV9zb2Z0X3Jlc2V0KSkKLS0gCjIuMTcuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
