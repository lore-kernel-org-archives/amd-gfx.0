From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 25/34] drm/amd/display: Add dc_lut_mode enum
Date: Tue, 20 Mar 2018 15:12:50 -0400
Message-ID: <20180320191259.14453-26-harry.wentland@amd.com>
References: <20180320191259.14453-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180320191259.14453-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Vitaly Prosyak <vitaly.prosyak-5C7GfCeVMHo@public.gmane.org>

RnJvbTogVml0YWx5IFByb3N5YWsgPHZpdGFseS5wcm9zeWFrQGFtZC5jb20+CgpTaWduZWQtb2Zm
LWJ5OiBWaXRhbHkgUHJvc3lhayA8dml0YWx5LnByb3N5YWtAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6
IFRvbnkgQ2hlbmcgPFRvbnkuQ2hlbmdAYW1kLmNvbT4KQWNrZWQtYnk6IEhhcnJ5IFdlbnRsYW5k
IDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9pbmMvaHcvaHdfc2hhcmVkLmggfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2lu
Yy9ody9od19zaGFyZWQuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9pbmMvaHcv
aHdfc2hhcmVkLmgKaW5kZXggYjIyMTU4MTkwMjYyLi4wMTVlMjA5ZTU4YmMgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9pbmMvaHcvaHdfc2hhcmVkLmgKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2luYy9ody9od19zaGFyZWQuaApAQCAtMTkx
LDQgKzE5MSw5IEBAIGVudW0gY29udHJvbGxlcl9kcF90ZXN0X3BhdHRlcm4gewogCUNPTlRST0xM
RVJfRFBfVEVTVF9QQVRURVJOX0NPTE9SU1FVQVJFU19DRUEKIH07CiAKK2VudW0gZGNfbHV0X21v
ZGUgeworCUxVVF9CWVBBU1MsCisJTFVUX1JBTV9BLAorCUxVVF9SQU1fQgorfTsKICNlbmRpZiAv
KiBfX0RBTF9IV19TSEFSRURfSF9fICovCi0tIAoyLjE0LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
