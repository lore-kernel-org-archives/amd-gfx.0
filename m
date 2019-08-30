From: Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V2] drm/amd/powerplay: SMU_MSG_OverridePcieParameters is
 unsupport for APU
Date: Fri, 30 Aug 2019 10:10:24 +0800
Message-ID: <1567131024-7241-1-git-send-email-aaron.liu@amd.com>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Ray.Huang-5C7GfCeVMHo@public.gmane.org, Aaron Liu <aaron.liu-5C7GfCeVMHo@public.gmane.org>

Rm9yIGFwdSwgU01VX01TR19PdmVycmlkZVBjaWVQYXJhbWV0ZXJzIGlzIHVuc3VwcG9ydC4KU28g
cmV0dXJuIGRpcmVjdGx5IGluIHNtdV9vdmVycmlkZV9wY2llX3BhcmFtZXRlcnMgZnVuY3Rpb24u
CgpTaWduZWQtb2ZmLWJ5OiBBYXJvbiBMaXUgPGFhcm9uLmxpdUBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyB8IDMgKysrCiAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvYW1kZ3B1X3NtdS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1k
Z3B1X3NtdS5jCmluZGV4IDhjNjE3NzguLmI3MjY1NjUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9hbWRncHVfc211LmMKQEAgLTEwMDEsNiArMTAwMSw5IEBAIHN0YXRpYyBpbnQg
c211X292ZXJyaWRlX3BjaWVfcGFyYW1ldGVycyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKIAl1
aW50MzJfdCBwY2llX2dlbiA9IDAsIHBjaWVfd2lkdGggPSAwLCBzbXVfcGNpZV9hcmc7CiAJaW50
IHJldDsKIAorCWlmIChhZGV2LT5mbGFncyAmIEFNRF9JU19BUFUpCisJCXJldHVybiAwOworCiAJ
aWYgKGFkZXYtPnBtLnBjaWVfZ2VuX21hc2sgJiBDQUlMX1BDSUVfTElOS19TUEVFRF9TVVBQT1JU
X0dFTjQpCiAJCXBjaWVfZ2VuID0gMzsKIAllbHNlIGlmIChhZGV2LT5wbS5wY2llX2dlbl9tYXNr
ICYgQ0FJTF9QQ0lFX0xJTktfU1BFRURfU1VQUE9SVF9HRU4zKQotLSAKMi43LjQKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
