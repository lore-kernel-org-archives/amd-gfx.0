From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Revert "drm/amd/amdgpu: Disable GFX_PG on Carrizo until
 compute issues solved"
Date: Fri, 17 Mar 2017 15:29:05 -0400
Message-ID: <1489778945-21815-1-git-send-email-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

UmUtZW5hYmxlIEdGWCBQRy4gIEl0J3Mgd29ya2luZyBwcm9wZXJseSB3aXRoIE1FQyBub3cgdGhh
dCBLSVEgaXMKZW5hYmxlZC4KClRoaXMgcmV2ZXJ0cyBjb21taXQgZTllZjE5YWExYmRlYWMzODA2
NjJhMTEyZjFkMDNhN2MzNDc3NTI3Zi4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92
aS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmkuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMKaW5kZXggNGVjZmFhMS4uN2U1ZjlkZSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS92aS5jCkBAIC0xMDYyLDcgKzEwNjIsNyBAQCBzdGF0aWMgaW50IHZpX2NvbW1v
bl9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKIAkJLyogcmV2MCBoYXJkd2FyZSByZXF1aXJlcyB3
b3JrYXJvdW5kcyB0byBzdXBwb3J0IFBHICovCiAJCWFkZXYtPnBnX2ZsYWdzID0gMDsKIAkJaWYg
KGFkZXYtPnJldl9pZCAhPSAweDAwIHx8IENaX1JFVl9CUklTVE9MKGFkZXYtPnBkZXYtPnJldmlz
aW9uKSkgewotCQkJYWRldi0+cGdfZmxhZ3MgfD0KKwkJCWFkZXYtPnBnX2ZsYWdzIHw9IEFNRF9Q
R19TVVBQT1JUX0dGWF9QRyB8CiAJCQkJQU1EX1BHX1NVUFBPUlRfR0ZYX1NNRyB8CiAJCQkJQU1E
X1BHX1NVUFBPUlRfR0ZYX1BJUEVMSU5FIHwKIAkJCQlBTURfUEdfU1VQUE9SVF9DUCB8Ci0tIAoy
LjUuNQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
