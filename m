From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/5] drm/amdgpu: update golden setting of carrizo
Date: Tue, 2 Aug 2016 11:41:14 +0800
Message-ID: <1470109275-20989-5-git-send-email-ray.huang@amd.com>
References: <1470109275-20989-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1470109275-20989-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92OF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jCmluZGV4IDI3
NDNlNzcuLjA1YzMzNmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92OF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYwpAQCAt
NTA2LDggKzUwNiwxMCBAQCBzdGF0aWMgY29uc3QgdTMyIGN6X2dvbGRlbl9zZXR0aW5nc19hMTFb
XSA9CiAJbW1HQl9HUFVfSUQsIDB4MDAwMDAwMGYsIDB4MDAwMDAwMDAsCiAJbW1QQV9TQ19FTkhB
TkNFLCAweGZmZmZmZmZmLCAweDAwMDAwMDAxLAogCW1tUEFfU0NfTElORV9TVElQUExFX1NUQVRF
LCAweDAwMDBmZjBmLCAweDAwMDAwMDAwLAorCW1tUkxDX0NHQ0dfQ0dMU19DVFJMLCAweDAwMDAw
MDAzLCAweDAwMDAwMDNjLAogCW1tU1FfUkFORE9NX1dBVkVfUFJJLCAweDAwMWZmZmZmLCAweDAw
MDAwNmZkLAogCW1tVEFfQ05UTF9BVVgsIDB4MDAwZjAwMGYsIDB4MDAwMTAwMDAsCisJbW1UQ0Nf
Q1RSTCwgMHgwMDEwMDAwMCwgMHhmMzFmZmY3ZiwKIAltbVRDQ19FWEVfRElTQUJMRSwgMHgwMDAw
MDAwMiwgMHgwMDAwMDAwMiwKIAltbVRDUF9BRERSX0NPTkZJRywgMHgwMDAwMDAwZiwgMHgwMDAw
MDBmMywKIAltbVRDUF9DSEFOX1NURUVSX0xPLCAweGZmZmZmZmZmLCAweDAwMDAxMzAyCi0tIAoy
LjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
