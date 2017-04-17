From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 02/12] drm/amdgpu/gfx9: add additional MQD initialization
Date: Mon, 17 Apr 2017 18:00:37 -0400
Message-ID: <1492466447-27614-3-git-send-email-alexander.deucher@amd.com>
References: <1492466447-27614-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1492466447-27614-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

TmVlZCB0byBwcm9wZXJseSBzZXQgdGhlIFJPUSBzcGFjZSBzZXR0aW5nLgoKU2lnbmVkLW9mZi1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKaW5kZXgg
NmI5MTgwNS4uMmYzZTUxNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y5XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCkBA
IC0xOTk4LDYgKzE5OTgsMTEgQEAgc3RhdGljIGludCBnZnhfdjlfMF9tcWRfaW5pdChzdHJ1Y3Qg
YW1kZ3B1X3JpbmcgKnJpbmcpCiAJdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIENQX0hRRF9QRVJT
SVNURU5UX1NUQVRFLCBQUkVMT0FEX1NJWkUsIDB4NTMpOwogCW1xZC0+Y3BfaHFkX3BlcnNpc3Rl
bnRfc3RhdGUgPSB0bXA7CiAKKwkvKiBzZXQgTUlOX0lCX0FWQUlMX1NJWkUgKi8KKwl0bXAgPSBS
UkVHMzJfU09DMTUoR0MsIDAsIG1tQ1BfSFFEX0lCX0NPTlRST0wpOworCXRtcCA9IFJFR19TRVRf
RklFTEQodG1wLCBDUF9IUURfSUJfQ09OVFJPTCwgTUlOX0lCX0FWQUlMX1NJWkUsIDMpOworCW1x
ZC0+Y3BfaHFkX2liX2NvbnRyb2wgPSB0bXA7CisKIAkvKiBhY3RpdmF0ZSB0aGUgcXVldWUgKi8K
IAltcWQtPmNwX2hxZF9hY3RpdmUgPSAxOwogCi0tIAoyLjUuNQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
