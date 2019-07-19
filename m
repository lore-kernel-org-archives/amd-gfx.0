From: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH AUTOSEL 5.2 026/171] drm/amd/display: Disable ABM before
 destroy ABM struct
Date: Thu, 18 Jul 2019 23:54:17 -0400
Message-ID: <20190719035643.14300-26-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190719035643.14300-1-sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Anthony Koo <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Paul Hsieh <paul.hsieh-5C7GfCeVMHo@public.gmane.org>, Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>

RnJvbTogUGF1bCBIc2llaCA8cGF1bC5oc2llaEBhbWQuY29tPgoKWyBVcHN0cmVhbSBjb21taXQg
MTA5MGQ1OGQ0ODE1YjFmY2Q5NWE4MDk4NzM5MTAwNmM4NjM5OGI0YyBdCgpbV2h5XQpXaGVuIGRp
c2FibGUgZHJpdmVyLCBPUyB3aWxsIHNldCBiYWNrbGlnaHQgb3B0aW1pemF0aW9uCnRoZW4gZG8g
c3RvcCBkZXZpY2UuICBCdXQgdGhpcyBmbGFnIHdpbGwgY2F1c2UgZHJpdmVyIHRvCmVuYWJsZSBB
Qk0gd2hlbiBkcml2ZXIgZGlzYWJsZWQuCgpbSG93XQpTZW5kIEFCTSBkaXNhYmxlIGNvbW1hbmQg
YmVmb3JlIGRlc3Ryb3kgQUJNIGNvbnN0cnVjdAoKU2lnbmVkLW9mZi1ieTogUGF1bCBIc2llaCA8
cGF1bC5oc2llaEBhbWQuY29tPgpSZXZpZXdlZC1ieTogQW50aG9ueSBLb28gPEFudGhvbnkuS29v
QGFtZC5jb20+CkFja2VkLWJ5OiBCaGF3YW5wcmVldCBMYWtoYSA8Qmhhd2FucHJlZXQuTGFraGFA
YW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYWJtLmMgfCAyICsrCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYWJtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZGNlL2RjZV9hYm0uYwppbmRleCBkYTk2MjI5ZGI1M2EuLjI5NTljM2M5MzkwYiAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYWJtLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYWJtLmMKQEAgLTQ3
Myw2ICs0NzMsOCBAQCB2b2lkIGRjZV9hYm1fZGVzdHJveShzdHJ1Y3QgYWJtICoqYWJtKQogewog
CXN0cnVjdCBkY2VfYWJtICphYm1fZGNlID0gVE9fRENFX0FCTSgqYWJtKTsKIAorCWFibV9kY2Ut
PmJhc2UuZnVuY3MtPnNldF9hYm1faW1tZWRpYXRlX2Rpc2FibGUoKmFibSk7CisKIAlrZnJlZShh
Ym1fZGNlKTsKIAkqYWJtID0gTlVMTDsKIH0KLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
