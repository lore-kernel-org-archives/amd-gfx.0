From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 04/14] drm/amd/amdgpu: Tidy up
 gfx_v9_0_enable_save_restore_machine()
Date: Thu, 31 Aug 2017 12:06:35 -0400
Message-ID: <20170831160645.8754-5-tom.stdenis@amd.com>
References: <20170831160645.8754-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170831160645.8754-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCA2ICstLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5jCmluZGV4IDUzZWYzNzY5ZGYwYy4uZDIzNWRjMjNhNmJmIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKQEAgLTE3NTcsMTEgKzE3NTcsNyBAQCBzdGF0
aWMgaW50IGdmeF92OV8wX2luaXRfcmxjX3NhdmVfcmVzdG9yZV9saXN0KHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQogCiBzdGF0aWMgdm9pZCBnZnhfdjlfMF9lbmFibGVfc2F2ZV9yZXN0b3Jl
X21hY2hpbmUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7Ci0JdTMyIHRtcCA9IDA7Ci0K
LQl0bXAgPSBSUkVHMzIoU09DMTVfUkVHX09GRlNFVChHQywgMCwgbW1STENfU1JNX0NOVEwpKTsK
LQl0bXAgfD0gUkxDX1NSTV9DTlRMX19TUk1fRU5BQkxFX01BU0s7Ci0JV1JFRzMyKFNPQzE1X1JF
R19PRkZTRVQoR0MsIDAsIG1tUkxDX1NSTV9DTlRMKSwgdG1wKTsKKwlXUkVHMzJfRklFTEQxNShH
QywgMCwgUkxDX1NSTV9DTlRMLCBTUk1fRU5BQkxFLCAxKTsKIH0KIAogc3RhdGljIHZvaWQgcHdy
XzEwXzBfZ2Z4aXBfY29udHJvbF9vdmVyX2NncGcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
Ci0tIAoyLjEyLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
