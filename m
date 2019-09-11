From: "Chen, Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/4] drm/amdgpu: support pcie bif ras query and inject
Date: Wed, 11 Sep 2019 03:21:07 +0000
Message-ID: <20190911032016.10313-3-guchun.chen@amd.com>
References: <20190911032016.10313-1-guchun.chen@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190911032016.10313-1-guchun.chen-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Li, Dennis" <Dennis.Li-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>, "Li, Candice" <Candice.Li-5C7GfCeVMHo@public.gmane.org>, "Chen,
 Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>

Q2FsbCBwY2llIGJpZiByYXMgcXVlcnkvaW5qZWN0IGluIGFtZGdwdSByYXMuCgpDaGFuZ2UtSWQ6
IElkZjUwMjFlZGYyMWU3MDQzMTQzMzhhYTJlOGIwNjcxZTRkNjIyZDFkClNpZ25lZC1vZmYtYnk6
IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogR3VjaHVuIENoZW4g
PGd1Y2h1bi5jaGVuQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Jhcy5jIHwgNSArKysrKwogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwppbmRleCA4NGNhMTNiOWQ0MmUuLjVm
MDZmMWU2NDVjNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Jhcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwpAQCAt
NjU0LDYgKzY1NCwxMCBAQCBpbnQgYW1kZ3B1X3Jhc19lcnJvcl9xdWVyeShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKIAkJaWYgKGFkZXYtPm1taHViX2Z1bmNzLT5xdWVyeV9yYXNfZXJyb3Jf
Y291bnQpCiAJCQlhZGV2LT5tbWh1Yl9mdW5jcy0+cXVlcnlfcmFzX2Vycm9yX2NvdW50KGFkZXYs
ICZlcnJfZGF0YSk7CiAJCWJyZWFrOworCWNhc2UgQU1ER1BVX1JBU19CTE9DS19fUENJRV9CSUY6
CisJCWlmIChhZGV2LT5uYmlvLmZ1bmNzLT5xdWVyeV9yYXNfZXJyb3JfY291bnQpCisJCQlhZGV2
LT5uYmlvLmZ1bmNzLT5xdWVyeV9yYXNfZXJyb3JfY291bnQoYWRldiwgJmVycl9kYXRhKTsKKwkJ
YnJlYWs7CiAJZGVmYXVsdDoKIAkJYnJlYWs7CiAJfQpAQCAtNzAzLDYgKzcwNyw3IEBAIGludCBh
bWRncHVfcmFzX2Vycm9yX2luamVjdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAljYXNl
IEFNREdQVV9SQVNfQkxPQ0tfX1VNQzoKIAljYXNlIEFNREdQVV9SQVNfQkxPQ0tfX01NSFVCOgog
CWNhc2UgQU1ER1BVX1JBU19CTE9DS19fWEdNSV9XQUZMOgorCWNhc2UgQU1ER1BVX1JBU19CTE9D
S19fUENJRV9CSUY6CiAJCXJldCA9IHBzcF9yYXNfdHJpZ2dlcl9lcnJvcigmYWRldi0+cHNwLCAm
YmxvY2tfaW5mbyk7CiAJCWJyZWFrOwogCWRlZmF1bHQ6Ci0tIAoyLjE3LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
