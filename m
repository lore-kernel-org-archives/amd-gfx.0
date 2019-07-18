From: "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: use VCN firmware offset for cache window
Date: Thu, 18 Jul 2019 15:49:57 +0000
Message-ID: <20190718154945.15004-1-leo.liu@amd.com>
References: <20190718154616.14841-1-leo.liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190718154616.14841-1-leo.liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>

U2luY2Ugd2UgYXJlIHVzaW5nIHRoZSBzaWduZWQgRlcgbm93LCBhbmQgYWxzbyB1c2luZyBQU1Ag
ZmlybXdhcmUgbG9hZGluZywKYnV0IGl0J3Mgc3RpbGwgcG90ZW50aWFsIHRvIGJyZWFrIGRyaXZl
ciB3aGVuIGxvYWRpbmcgRlcgZGlyZWN0bHkKaW5zdGVhZCBvZiBQU1AsIHNvIHdlIHNob3VsZCBh
ZGQgb2Zmc2V0LgoKU2lnbmVkLW9mZi1ieTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml8wLmMgfCAzIC0tLQogMSBmaWxlIGNo
YW5nZWQsIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdmNuX3YyXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml8wLmMK
aW5kZXggM2NiNjJlNDQ4YTM3Li44OGUzZGVkY2Y5MjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmNuX3YyXzAuYwpAQCAtMzc5LDExICszNzksOCBAQCBzdGF0aWMgdm9pZCB2Y25fdjJfMF9t
Y19yZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCVdSRUczMl9TT0MxNShVVkQs
IDAsIG1tVVZEX0xNSV9WQ1BVX0NBQ0hFXzY0QklUX0JBUl9ISUdILAogCQkJdXBwZXJfMzJfYml0
cyhhZGV2LT52Y24uaW5zdC0+Z3B1X2FkZHIpKTsKIAkJb2Zmc2V0ID0gc2l6ZTsKLQkJLyogTm8g
c2lnbmVkIGhlYWRlciBmb3Igbm93IGZyb20gZmlybXdhcmUKIAkJV1JFRzMyX1NPQzE1KFVWRCwg
MCwgbW1VVkRfVkNQVV9DQUNIRV9PRkZTRVQwLAogCQkJQU1ER1BVX1VWRF9GSVJNV0FSRV9PRkZT
RVQgPj4gMyk7Ci0JCSovCi0JCVdSRUczMl9TT0MxNShVVkQsIDAsIG1tVVZEX1ZDUFVfQ0FDSEVf
T0ZGU0VUMCwgMCk7CiAJfQogCiAJV1JFRzMyX1NPQzE1KFVWRCwgMCwgbW1VVkRfVkNQVV9DQUNI
RV9TSVpFMCwgc2l6ZSk7Ci0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
