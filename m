From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 9/9] drm/amdgpu: Enable KFD initialization on dGPUs
Date: Thu,  4 Jan 2018 17:17:48 -0500
Message-ID: <1515104268-25087-10-git-send-email-Felix.Kuehling@amd.com>
References: <1515104268-25087-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1515104268-25087-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jIHwgNSArKysrKwog
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9hbWRrZmQuYwppbmRleCAzMzVlNDU0Li43ZWJlNDMwIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jCkBAIC03OCwxMCArNzgsMTUgQEAgdm9p
ZCBhbWRncHVfYW1ka2ZkX2RldmljZV9wcm9iZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikK
IAlzd2l0Y2ggKGFkZXYtPmFzaWNfdHlwZSkgewogI2lmZGVmIENPTkZJR19EUk1fQU1ER1BVX0NJ
SwogCWNhc2UgQ0hJUF9LQVZFUkk6CisJY2FzZSBDSElQX0hBV0FJSToKIAkJa2ZkMmtnZCA9IGFt
ZGdwdV9hbWRrZmRfZ2Z4XzdfZ2V0X2Z1bmN0aW9ucygpOwogCQlicmVhazsKICNlbmRpZgogCWNh
c2UgQ0hJUF9DQVJSSVpPOgorCWNhc2UgQ0hJUF9UT05HQToKKwljYXNlIENISVBfRklKSToKKwlj
YXNlIENISVBfUE9MQVJJUzEwOgorCWNhc2UgQ0hJUF9QT0xBUklTMTE6CiAJCWtmZDJrZ2QgPSBh
bWRncHVfYW1ka2ZkX2dmeF84XzBfZ2V0X2Z1bmN0aW9ucygpOwogCQlicmVhazsKIAlkZWZhdWx0
OgotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
