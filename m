From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 2/3] drm/amdgpu: fix missed asd bo free when hw_fini
Date: Wed, 5 Jul 2017 13:32:20 +0800
Message-ID: <1499232741-4015-2-git-send-email-ray.huang@amd.com>
References: <1499232741-4015-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1499232741-4015-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCgpDaGFuZ2Vz
IGZyb20gVjEgLT4gVjIKLSBhbWRncHVfYm9fZnJlZV9rZXJuZWwgaXMgc2FmZSBldmVuIHRoZSBi
byBpcyBOVUxMLCBzbyByZW1vdmUgdGhlICJpZiIgY2hlY2suCgpUaGFua3MsClJheQoKLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgfCAyICsrCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Bz
cC5jCmluZGV4IGQwMTA0YzcuLjk1ZjVkMjUwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3BzcC5jCkBAIC00NDAsNiArNDQwLDggQEAgc3RhdGljIGludCBwc3BfaHdfZmluaSh2
b2lkICpoYW5kbGUpCiAJCQkgICAgICAmcHNwLT5md19wcmlfbWNfYWRkciwgJnBzcC0+ZndfcHJp
X2J1Zik7CiAJYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZwc3AtPmZlbmNlX2J1Zl9ibywKIAkJCSAg
ICAgICZwc3AtPmZlbmNlX2J1Zl9tY19hZGRyLCAmcHNwLT5mZW5jZV9idWYpOworCWFtZGdwdV9i
b19mcmVlX2tlcm5lbCgmcHNwLT5hc2Rfc2hhcmVkX2JvLCAmcHNwLT5hc2Rfc2hhcmVkX21jX2Fk
ZHIsCisJCQkgICAgICAmcHNwLT5hc2Rfc2hhcmVkX2J1Zik7CiAKIAlrZnJlZShwc3AtPmNtZCk7
CiAJcHNwLT5jbWQgPSBOVUxMOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
