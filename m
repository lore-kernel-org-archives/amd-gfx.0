From: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 09/10] drm/amdgpu: init arcturus umc callback functions and
 configurations
Date: Tue, 3 Sep 2019 00:02:21 +0000
Message-ID: <1567468894-11852-9-git-send-email-Hawking.Zhang@amd.com>
References: <1567468894-11852-1-git-send-email-Hawking.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1567468894-11852-1-git-send-email-Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhou1,
 Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>, "Chen, Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

YXJjdHVydXMgc2hhcmUgdGhlIHNhbWUgdW1jIGNhbGxiYWNrIGZ1bmN0aW9ucyBhbmQgdW1jIGNv
bmZpZ3VyYXRpb25zCmFzIHZnMjAKClNpZ25lZC1vZmYtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tp
bmcuWmhhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlf
MC5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ21jX3Y5XzAuYwppbmRleCA4NjIxM2Y2Li5hZTM3YjA4IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKQEAgLTY2NCw2ICs2NjQsNyBAQCBzdGF0aWMgdm9pZCBn
bWNfdjlfMF9zZXRfdW1jX2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewogCXN3
aXRjaCAoYWRldi0+YXNpY190eXBlKSB7CiAJY2FzZSBDSElQX1ZFR0EyMDoKKwljYXNlIENISVBf
QVJDVFVSVVM6CiAJCWFkZXYtPnVtYy5tYXhfcmFzX2Vycl9jbnRfcGVyX3F1ZXJ5ID0gVU1DX1Y2
XzFfVE9UQUxfQ0hBTk5FTF9OVU07CiAJCWFkZXYtPnVtYy5jaGFubmVsX2luc3RfbnVtID0gVU1D
X1Y2XzFfQ0hBTk5FTF9JTlNUQU5DRV9OVU07CiAJCWFkZXYtPnVtYy51bWNfaW5zdF9udW0gPSBV
TUNfVjZfMV9VTUNfSU5TVEFOQ0VfTlVNOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
