From: Tao Zhou <tao.zhou1-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/3] drm/amdgpu: support mmhub ras in amdgpu ras
Date: Thu, 8 Aug 2019 14:53:50 +0800
Message-ID: <20190808065351.510-2-tao.zhou1@amd.com>
References: <20190808065351.510-1-tao.zhou1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190808065351.510-1-tao.zhou1-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, hawking.zhang-5C7GfCeVMHo@public.gmane.org, guchun.chen-5C7GfCeVMHo@public.gmane.org, dennis.li-5C7GfCeVMHo@public.gmane.org, xinhui.pan-5C7GfCeVMHo@public.gmane.org, john.clements-5C7GfCeVMHo@public.gmane.org
Cc: Tao Zhou <tao.zhou1-5C7GfCeVMHo@public.gmane.org>

Y2FsbCBtbWh1YiByYXMgcXVlcnkvaW5qZWN0IGluIGFtZGdwdSByYXMKClNpZ25lZC1vZmYtYnk6
IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmFzLmMgfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCmluZGV4IGJjNzY2Y2Ri
ZWFhZS4uYmU1OTEwMjUyNmExIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmFzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jh
cy5jCkBAIC02MTIsNiArNjEyLDEwIEBAIGludCBhbWRncHVfcmFzX2Vycm9yX3F1ZXJ5KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LAogCQlpZiAoYWRldi0+Z2Z4LmZ1bmNzLT5xdWVyeV9yYXNf
ZXJyb3JfY291bnQpCiAJCQlhZGV2LT5nZnguZnVuY3MtPnF1ZXJ5X3Jhc19lcnJvcl9jb3VudChh
ZGV2LCAmZXJyX2RhdGEpOwogCQlicmVhazsKKwljYXNlIEFNREdQVV9SQVNfQkxPQ0tfX01NSFVC
OgorCQlpZiAoYWRldi0+bW1odWJfZnVuY3MtPnF1ZXJ5X3Jhc19lcnJvcl9jb3VudCkKKwkJCWFk
ZXYtPm1taHViX2Z1bmNzLT5xdWVyeV9yYXNfZXJyb3JfY291bnQoYWRldiwgJmVycl9kYXRhKTsK
KwkJYnJlYWs7CiAJZGVmYXVsdDoKIAkJYnJlYWs7CiAJfQpAQCAtNjU3LDYgKzY2MSw3IEBAIGlu
dCBhbWRncHVfcmFzX2Vycm9yX2luamVjdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJ
CXJldCA9IC1FSU5WQUw7CiAJCWJyZWFrOwogCWNhc2UgQU1ER1BVX1JBU19CTE9DS19fVU1DOgor
CWNhc2UgQU1ER1BVX1JBU19CTE9DS19fTU1IVUI6CiAJCXJldCA9IHBzcF9yYXNfdHJpZ2dlcl9l
cnJvcigmYWRldi0+cHNwLCAmYmxvY2tfaW5mbyk7CiAJCWJyZWFrOwogCWRlZmF1bHQ6Ci0tIAoy
LjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
