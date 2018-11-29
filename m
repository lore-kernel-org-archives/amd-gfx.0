From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 11/16] drm/amd/display: Add customizable tracing event
Date: Thu, 29 Nov 2018 10:52:18 -0500
Message-ID: <1543506743-4674-12-git-send-email-sunpeng.li@amd.com>
References: <1543506743-4674-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1543506743-4674-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: Chiawen Huang <chiawen.huang-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQ2hpYXdlbiBIdWFuZyA8Y2hpYXdlbi5odWFuZ0BhbWQuY29tPgoKW3doeV0KYWRkIGN1
c3RvbWl6YWJsZSBsb2cgd2l0aCBhIG1lc3NhZ2UgaW5wdXQsIHdoaWNoIGlzIGZvciBhZGRpbmcK
dGVzdCBsb2cgaW4gZGVidWdnaW5nIGFzIHByaW50ZiBmdW5jdGlvbiBpbiBFVFcuCgpbVXNhZ2Vd
CkVWRU5UX0xPR19DVVNUX01TRzEoIlRlc3RMb2ciLCJIZWxsbyBXb3JsZCAlZD0weCV4IiwgMTIz
LCBwREMpOwoKU2lnbmVkLW9mZi1ieTogQ2hpYXdlbiBIdWFuZyA8Y2hpYXdlbi5odWFuZ0BhbWQu
Y29tPgpSZXZpZXdlZC1ieTogVG9ueSBDaGVuZyA8VG9ueS5DaGVuZ0BhbWQuY29tPgpBY2tlZC1i
eTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RtX2V2ZW50X2xvZy5oIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1fZXZl
bnRfbG9nLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1fZXZlbnRfbG9nLmgK
aW5kZXggMzRhNzAxYy4uNjU2NjNmNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RtX2V2ZW50X2xvZy5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kbV9ldmVudF9sb2cuaApAQCAtMzMsNiArMzMsNyBAQAogCiAjZGVmaW5lIEVWRU5UX0xP
R19BVVhfUkVRKGRkYywgdHlwZSwgYWN0aW9uLCBhZGRyZXNzLCBsZW4sIGRhdGEpCiAjZGVmaW5l
IEVWRU5UX0xPR19BVVhfUkVQKGRkYywgdHlwZSwgcmVwbHlTdGF0dXMsIGxlbiwgZGF0YSkKKyNk
ZWZpbmUgRVZFTlRfTE9HX0NVU1RfTVNHKHRhZywgYSwgLi4uKQogCiAjZW5kaWYKIAotLSAKMi43
LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
