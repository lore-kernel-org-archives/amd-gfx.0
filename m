From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 22/37] drm/amdgpu: enable BIF clock gating for rn
Date: Wed, 21 Aug 2019 17:23:44 -0500
Message-ID: <20190821222359.13578-23-alexander.deucher@amd.com>
References: <20190821222359.13578-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190821222359.13578-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Prike Liang <Prike.Liang-5C7GfCeVMHo@public.gmane.org>

RnJvbTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+CgpFbmFibGUgQklGIGxpZ2h0
IHNsZWVwIGNsb2NrIGdhdGluZy4KClNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5M
aWFuZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyB8IDMgKyst
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NvYzE1LmMKaW5kZXggNjc1MWM1ZjU3OTEzLi4yNWY1NWM3OTNmZWIgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYwpAQCAtMTE2NCw3ICsxMTY0LDggQEAgc3RhdGlj
IGludCBzb2MxNV9jb21tb25fZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpCiAJCQkJIEFNRF9DR19T
VVBQT1JUX01DX01HQ0cgfAogCQkJCSBBTURfQ0dfU1VQUE9SVF9NQ19MUyB8CiAJCQkJIEFNRF9D
R19TVVBQT1JUX1NETUFfTUdDRyB8Ci0JCQkJIEFNRF9DR19TVVBQT1JUX1NETUFfTFM7CisJCQkJ
IEFNRF9DR19TVVBQT1JUX1NETUFfTFMgfAorCQkJCSBBTURfQ0dfU1VQUE9SVF9CSUZfTFM7CiAJ
CWFkZXYtPnBnX2ZsYWdzID0gMDsKIAkJYWRldi0+ZXh0ZXJuYWxfcmV2X2lkID0gYWRldi0+cmV2
X2lkICsgMHg5MTsKIAotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
