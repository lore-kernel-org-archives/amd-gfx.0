From: "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/6] drm/amdgpu: check no_user_fence flag for engines
Date: Wed, 8 May 2019 15:51:41 +0000
Message-ID: <20190508155100.7810-5-leo.liu@amd.com>
References: <20190508155100.7810-1-leo.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190508155100.7810-1-leo.liu-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>

VG8gcmVwbGFjZSBjaGVja2luZyByaW5nIHR5cGUgYW5kIG1ha2UgdGhlbSBnZW5lcmljDQoNClNp
Z25lZC1vZmYtYnk6IExlbyBMaXUgPGxlby5saXVAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jIHwgNiArKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfY3MuYw0KaW5kZXggZDBlMjIxYzhkOTQwLi5kNzJjYzU4M2ViZDEgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYw0KKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMNCkBAIC0xMDA4LDExICsxMDA4LDkgQEAg
c3RhdGljIGludCBhbWRncHVfY3NfaWJfZmlsbChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwN
CiAJCWorKzsNCiAJfQ0KIA0KLQkvKiBVVkQgJiBWQ0UgZncgZG9lc24ndCBzdXBwb3J0IHVzZXIg
ZmVuY2VzICovDQorCS8qIE1NIGVuZ2luZSBkb2Vzbid0IHN1cHBvcnQgdXNlciBmZW5jZXMgKi8N
CiAJcmluZyA9IHRvX2FtZGdwdV9yaW5nKHBhcnNlci0+ZW50aXR5LT5ycS0+c2NoZWQpOw0KLQlp
ZiAocGFyc2VyLT5qb2ItPnVmX2FkZHIgJiYgKA0KLQkgICAgcmluZy0+ZnVuY3MtPnR5cGUgPT0g
QU1ER1BVX1JJTkdfVFlQRV9VVkQgfHwNCi0JICAgIHJpbmctPmZ1bmNzLT50eXBlID09IEFNREdQ
VV9SSU5HX1RZUEVfVkNFKSkNCisJaWYgKHBhcnNlci0+am9iLT51Zl9hZGRyICYmIHJpbmctPmZ1
bmNzLT5ub191c2VyX2ZlbmNlKQ0KIAkJcmV0dXJuIC1FSU5WQUw7DQogDQogCXJldHVybiBhbWRn
cHVfY3R4X3dhaXRfcHJldl9mZW5jZShwYXJzZXItPmN0eCwgcGFyc2VyLT5lbnRpdHkpOw0KLS0g
DQoyLjE3LjENCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
