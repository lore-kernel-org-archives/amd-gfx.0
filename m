From: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: add cu info wave_front_size
Date: Fri, 28 Apr 2017 11:10:46 +0800
Message-ID: <1493349046-23232-1-git-send-email-Jerry.Zhang@amd.com>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Qingqing.Wang-5C7GfCeVMHo@public.gmane.org, Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>

bWlzc2VkIHRoYXQgZm9yIGdmeCB2OSBpbmZvIGV4cG9ydAoKU2lnbmVkLW9mZi1ieTogSnVud2Vp
IFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdS5oIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCmluZGV4IDUwMzAxMGEuLmUzMzAwMDkgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCkBAIC05ODYsNiArOTg2LDcgQEAgc3RydWN0IGFtZGdw
dV9nZnhfY29uZmlnIHsKIHN0cnVjdCBhbWRncHVfY3VfaW5mbyB7CiAJdWludDMyX3QgbnVtYmVy
OyAvKiB0b3RhbCBhY3RpdmUgQ1UgbnVtYmVyICovCiAJdWludDMyX3QgYW9fY3VfbWFzazsKKwl1
aW50MzJfdCB3YXZlX2Zyb250X3NpemU7CiAJdWludDMyX3QgYml0bWFwWzRdWzRdOwogfTsKIAot
LSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
