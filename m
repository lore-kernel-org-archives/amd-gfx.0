From: Yrjan Skrimstad <yrjan-i8zSYrfQCDxH4x6Dk/4f9A@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay/smu7_hwmgr: replace blocking delay with
 non-blocking
Date: Thu, 30 May 2019 02:08:21 +0200
Message-ID: <20190530000819.GA25416@obi-wan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Yrjan Skrimstad <yrjan-i8zSYrfQCDxH4x6Dk/4f9A@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>, Rex Zhu <rex.zhu-5C7GfCeVMHo@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

VGhpcyBkcml2ZXIgY3VycmVudGx5IGNvbnRhaW5zIGEgcmVwZWF0ZWQgNTAwbXMgYmxvY2tpbmcg
ZGVsYXkgY2FsbAp3aGljaCBjYXVzZXMgZnJlcXVlbnQgbWFqb3IgYnVmZmVyIHVuZGVycnVucyBp
biBQdWxzZUF1ZGlvLiBUaGlzIHBhdGNoCmZpeGVzIHRoaXMgaXNzdWUgYnkgcmVwbGFjaW5nIHRo
ZSBibG9ja2luZyBkZWxheSB3aXRoIGEgbm9uLWJsb2NraW5nCnNsZWVwIGNhbGwuCgpTaWduZWQt
b2ZmLWJ5OiBZcmphbiBTa3JpbXN0YWQgPHlyamFuQHNrcmltc3RhZC5uZXQ+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jIHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jCmluZGV4IDA0ODc1N2U4ZjQ5
NC4uMzQwYWZkYmRkYzcyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9od21nci9zbXU3X2h3bWdyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
aHdtZ3Ivc211N19od21nci5jCkBAIC0zNDk0LDcgKzM0OTQsNyBAQCBzdGF0aWMgaW50IHNtdTdf
Z2V0X2dwdV9wb3dlcihzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLCB1MzIgKnF1ZXJ5KQogCQkJCQkJ
CWl4U01VX1BNX1NUQVRVU185NSwgMCk7CiAKIAlmb3IgKGkgPSAwOyBpIDwgMTA7IGkrKykgewot
CQltZGVsYXkoNTAwKTsKKwkJbXNsZWVwKDUwMCk7CiAJCXNtdW1fc2VuZF9tc2dfdG9fc21jKGh3
bWdyLCBQUFNNQ19NU0dfUG1TdGF0dXNMb2dTYW1wbGUpOwogCQl0bXAgPSBjZ3NfcmVhZF9pbmRf
cmVnaXN0ZXIoaHdtZ3ItPmRldmljZSwKIAkJCQkJCUNHU19JTkRfUkVHX19TTUMsCi0tIAoyLjIw
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
