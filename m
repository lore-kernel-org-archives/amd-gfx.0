From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 3/3] drm/amdgpu: update golden setting of polaris10
Date: Tue, 2 Aug 2016 13:23:34 +0800
Message-ID: <1470115414-23733-4-git-send-email-ray.huang@amd.com>
References: <1470115414-23733-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1470115414-23733-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjhfMC5jCmluZGV4IGVhMDI1YTUuLjA1YzMzNmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y4XzAuYwpAQCAtMzAxLDggKzMwMSw4IEBAIHN0YXRpYyBjb25zdCB1MzIgcG9sYXJp
czExX2dvbGRlbl9jb21tb25fYWxsW10gPQogc3RhdGljIGNvbnN0IHUzMiBnb2xkZW5fc2V0dGlu
Z3NfcG9sYXJpczEwX2ExMVtdID0KIHsKIAltbUFUQ19NSVNDX0NHLCAweDAwMGMwZmMwLCAweDAw
MGMwMjAwLAotCW1tQ0JfSFdfQ09OVFJPTCwgMHhmZmZkZjNjZiwgMHgwMDAwNzIwOCwKLQltbUNC
X0hXX0NPTlRST0xfMiwgMCwgMHgwZjAwMDAwMCwKKwltbUNCX0hXX0NPTlRST0wsIDB4MDAwMWYz
Y2YsIDB4MDAwMDcyMDgsCisJbW1DQl9IV19DT05UUk9MXzIsIDB4MGYwMDAwMDAsIDB4MGYwMDAw
MDAsCiAJbW1DQl9IV19DT05UUk9MXzMsIDB4MDAwMDAxZmYsIDB4MDAwMDAwNDAsCiAJbW1EQl9E
RUJVRzIsIDB4ZjAwZmZmZmYsIDB4MDAwMDA0MDAsCiAJbW1QQV9TQ19FTkhBTkNFLCAweGZmZmZm
ZmZmLCAweDIwMDAwMDAxLAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
