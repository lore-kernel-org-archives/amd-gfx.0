From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 01/15] drm/amdgpu/si: update si firmware path
Date: Wed, 31 Aug 2016 13:23:13 +0800
Message-ID: <1472621007-17578-2-git-send-email-ray.huang@amd.com>
References: <1472621007-17578-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472621007-17578-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Hui Yu <Hui.Yu-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

U0kgZmlybXdhcmUgaXMgc2hhcmVkIHdpdGggcmFkZW9uIGZvciBub3csIHNvIHVwZGF0ZSBwYXRo
IHdpdGggdGhpcwpwYXRjaC4KClNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFt
ZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMgfCAxMCArKysr
Ky0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMKaW5kZXggMDc2ZjZjZC4uZDY2NDM1ZCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMKQEAgLTU1LDE1ICs1NSwxNSBAQAogCiAjZGVm
aW5lIEJJT1NfU0NSQVRDSF80ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHg1
Y2QKIAotTU9EVUxFX0ZJUk1XQVJFKCJhbWRncHUvdGFoaXRpX3NtYy5iaW4iKTsKK01PRFVMRV9G
SVJNV0FSRSgicmFkZW9uL3RhaGl0aV9zbWMuYmluIik7CiBNT0RVTEVfRklSTVdBUkUoInJhZGVv
bi90YWhpdGlfa19zbWMuYmluIik7Ci1NT0RVTEVfRklSTVdBUkUoImFtZGdwdS9waXRjYWlybl9z
bWMuYmluIik7CitNT0RVTEVfRklSTVdBUkUoInJhZGVvbi9waXRjYWlybl9zbWMuYmluIik7CiBN
T0RVTEVfRklSTVdBUkUoInJhZGVvbi9waXRjYWlybl9rX3NtYy5iaW4iKTsKLU1PRFVMRV9GSVJN
V0FSRSgiYW1kZ3B1L3ZlcmRlX3NtYy5iaW4iKTsKK01PRFVMRV9GSVJNV0FSRSgicmFkZW9uL3Zl
cmRlX3NtYy5iaW4iKTsKIE1PRFVMRV9GSVJNV0FSRSgicmFkZW9uL3ZlcmRlX2tfc21jLmJpbiIp
OwotTU9EVUxFX0ZJUk1XQVJFKCJhbWRncHUvb2xhbmRfc21jLmJpbiIpOworTU9EVUxFX0ZJUk1X
QVJFKCJyYWRlb24vb2xhbmRfc21jLmJpbiIpOwogTU9EVUxFX0ZJUk1XQVJFKCJyYWRlb24vb2xh
bmRfa19zbWMuYmluIik7Ci1NT0RVTEVfRklSTVdBUkUoImFtZGdwdS9oYWluYW5fc21jLmJpbiIp
OworTU9EVUxFX0ZJUk1XQVJFKCJyYWRlb24vaGFpbmFuX3NtYy5iaW4iKTsKIE1PRFVMRV9GSVJN
V0FSRSgicmFkZW9uL2hhaW5hbl9rX3NtYy5iaW4iKTsKIAogdW5pb24gcG93ZXJfaW5mbyB7Ci0t
IAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
