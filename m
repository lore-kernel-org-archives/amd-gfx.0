From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] amdgpu: kfd: use modern ktime accessors
Date: Mon, 18 Jun 2018 17:35:11 +0200
Message-ID: <20180618153649.2015346-2-arnd@arndb.de>
References: <20180618153649.2015346-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180618153649.2015346-1-arnd@arndb.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: Yong Zhao <yong.zhao@amd.com>, amd-gfx@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, Philip Yang <Philip.Yang@amd.com>, y2038@lists.linaro.org, Felix Kuehling <Felix.Kuehling@amd.com>, Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Andres Rodriguez <andres.rodriguez@amd.com>, Kent Russell <kent.russell@amd.com>, Shaoyun Liu <Shaoyun.Liu@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Z2V0cmF3bW9ub3RvbmljNjQoKSBhbmQgZ2V0X21vbm90b25pY19ib290dGltZTY0KCkgYXJlIGRl
cHJlY2F0ZWQKYmVjYXVzZSBvZiB0aGUgbm9uc3RhbmRhcmQgbmFtaW5nLgoKVGhlIHJlcGxhY2Vt
ZW50IGZ1bmN0aW9ucyBrdGltZV9nZXRfcmF3X25zKCkgYW5kIGt0aW1lX2dldF9ib290X25zKCkK
YWxzbyBzaW1wbGlmeSB0aGUgY2FsbGVycy4KClNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4g
PGFybmRAYXJuZGIuZGU+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJk
ZXYuYyB8IDggKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDYgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2No
YXJkZXYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMKaW5kZXgg
ZjY0YzU1NTFjZGJhLi43ZTcxNzcxNmI5MGUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX2NoYXJkZXYuYwpAQCAtNzU0LDcgKzc1NCw2IEBAIHN0YXRpYyBpbnQga2ZkX2lvY3RsX2dl
dF9jbG9ja19jb3VudGVycyhzdHJ1Y3QgZmlsZSAqZmlsZXAsCiB7CiAJc3RydWN0IGtmZF9pb2N0
bF9nZXRfY2xvY2tfY291bnRlcnNfYXJncyAqYXJncyA9IGRhdGE7CiAJc3RydWN0IGtmZF9kZXYg
KmRldjsKLQlzdHJ1Y3QgdGltZXNwZWM2NCB0aW1lOwogCiAJZGV2ID0ga2ZkX2RldmljZV9ieV9p
ZChhcmdzLT5ncHVfaWQpOwogCWlmIChkZXYpCkBAIC03NjYsMTEgKzc2NSw4IEBAIHN0YXRpYyBp
bnQga2ZkX2lvY3RsX2dldF9jbG9ja19jb3VudGVycyhzdHJ1Y3QgZmlsZSAqZmlsZXAsCiAJCWFy
Z3MtPmdwdV9jbG9ja19jb3VudGVyID0gMDsKIAogCS8qIE5vIGFjY2VzcyB0byByZHRzYy4gVXNp
bmcgcmF3IG1vbm90b25pYyB0aW1lICovCi0JZ2V0cmF3bW9ub3RvbmljNjQoJnRpbWUpOwotCWFy
Z3MtPmNwdV9jbG9ja19jb3VudGVyID0gKHVpbnQ2NF90KXRpbWVzcGVjNjRfdG9fbnMoJnRpbWUp
OwotCi0JZ2V0X21vbm90b25pY19ib290dGltZTY0KCZ0aW1lKTsKLQlhcmdzLT5zeXN0ZW1fY2xv
Y2tfY291bnRlciA9ICh1aW50NjRfdCl0aW1lc3BlYzY0X3RvX25zKCZ0aW1lKTsKKwlhcmdzLT5j
cHVfY2xvY2tfY291bnRlciA9IGt0aW1lX2dldF9yYXdfbnMoKTsKKwlhcmdzLT5zeXN0ZW1fY2xv
Y2tfY291bnRlciA9IGt0aW1lX2dldF9ib290X25zKCk7CiAKIAkvKiBTaW5jZSB0aGUgY291bnRl
ciBpcyBpbiBuYW5vLXNlY29uZHMgd2UgdXNlIDFHSHogZnJlcXVlbmN5ICovCiAJYXJncy0+c3lz
dGVtX2Nsb2NrX2ZyZXEgPSAxMDAwMDAwMDAwOwotLSAKMi45LjAKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
