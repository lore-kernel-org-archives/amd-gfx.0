From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 018/141] drm/amd/display: Disable ABM before
 destroy ABM struct
Date: Fri, 19 Jul 2019 00:00:43 -0400
Message-ID: <20190719040246.15945-18-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Anthony Koo <Anthony.Koo@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Paul Hsieh <paul.hsieh@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

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
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
