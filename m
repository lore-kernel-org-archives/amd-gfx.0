From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/3] drm/amd/powerplay: update is_sw_smu_xgmi check
Date: Thu, 31 Oct 2019 07:22:38 +0000
Message-ID: <20191031072205.27537-2-evan.quan@amd.com>
References: <20191031072205.27537-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191031072205.27537-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Kim,
 Jonathan" <Jonathan.Kim-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>

QWRkIGNoZWNrIGZvciBpc19zd19zbXUgcm91dGluZSBhbmQgZHJvcCBjaGVjawpmb3IgYW1kZ3B1
X2RwbSB3aGljaCBzZWVtcyBub24tc2Vuc2UuCgpDaGFuZ2UtSWQ6IEkyYjY5NGE2MjU1YTc2ZDM1
MzA1ZmM2NGNhMzk2MjU3MzBlMzQ2M2RiClNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5x
dWFuQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3Nt
dS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCmluZGV4IDNjZTAx
ZTE5OTRmYy4uZGMyMTMwYTMxNjhjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9hbWRncHVfc211LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
YW1kZ3B1X3NtdS5jCkBAIC01MjYsNyArNTI2LDcgQEAgYm9vbCBpc19zdXBwb3J0X3N3X3NtdShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAogYm9vbCBpc19zdXBwb3J0X3N3X3NtdV94Z21p
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewotCWlmIChhbWRncHVfZHBtICE9IDEpCisJ
aWYgKCFpc19zdXBwb3J0X3N3X3NtdShhZGV2KSkKIAkJcmV0dXJuIGZhbHNlOwogCiAJaWYgKGFk
ZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZFR0EyMCkKLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
