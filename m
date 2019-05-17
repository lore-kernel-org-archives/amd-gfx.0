From: "Pan, Xinhui" <Xinhui.Pan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: cancel late_init_work before gpu reset
Date: Fri, 17 May 2019 03:03:41 +0000
Message-ID: <SN6PR12MB2800E10E66A5834D3A38A0E4870B0@SN6PR12MB2800.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: zh-CN
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
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Huang,
 JinHuiEric" <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>

CmdwdSByZXNldCB3aWxsIHJ1biBsYXRlX2luaXQgYW5kIHNjaGVkdWxlIHRoZSBsYXRlX2luaXRf
d29yay4gIGlmIHdlCmtlZXAgdHJpZ2dlcmluZyBncHUgcmVzZXQgaW4gYSBzaG9ydCB0aW1lLCB0
aGVyZSBhcmUgcG90ZW5pYWwgcmFjZXMuCgpTaWduZWQtb2ZmLWJ5OiB4aW5odWkgcGFuIDx4aW5o
dWkucGFuQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCBlY2I5OWFlYWI2Y2YuLjI0
MWNkMmM3NTQzMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YwpAQCAtMzYzNiw2ICszNjM2LDggQEAgaW50IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAKIAlkZXZfaW5mbyhhZGV2LT5kZXYsICJHUFUgcmVz
ZXQgYmVnaW4hXG4iKTsKIAorCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+bGF0ZV9p
bml0X3dvcmspOworCiAJaGl2ZSA9IGFtZGdwdV9nZXRfeGdtaV9oaXZlKGFkZXYsIGZhbHNlKTsK
IAogCS8qCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
