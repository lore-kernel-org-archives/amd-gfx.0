From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 31/37] drm/amdgpu: enable SDMA power gating for rn
Date: Wed, 21 Aug 2019 17:23:53 -0500
Message-ID: <20190821222359.13578-32-alexander.deucher@amd.com>
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

RnJvbTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+CgpFbmFibGUgU0RNQSBQRyBm
bGFnIGR1cmluZyBkZXZpY2UgaXAgZWFybHkgaW5pdC4KClJldmlld2VkLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5n
IDxQcmlrZS5MaWFuZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29j
MTUuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCmluZGV4IDZhYjQ0NGQ2YmU3Mi4uNWMyMTFm
YTAzMzI4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKQEAgLTExNzMsNyArMTE3Myw3
IEBAIHN0YXRpYyBpbnQgc29jMTVfY29tbW9uX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQogCQkJ
CSBBTURfQ0dfU1VQUE9SVF9BVEhVQl9MUyB8CiAJCQkJIEFNRF9DR19TVVBQT1JUX0FUSFVCX01H
Q0cgfAogCQkJCSBBTURfQ0dfU1VQUE9SVF9ERl9NR0NHOwotCQlhZGV2LT5wZ19mbGFncyA9IDA7
CisJCWFkZXYtPnBnX2ZsYWdzID0gQU1EX1BHX1NVUFBPUlRfU0RNQTsKIAkJYWRldi0+ZXh0ZXJu
YWxfcmV2X2lkID0gYWRldi0+cmV2X2lkICsgMHg5MTsKIAogCQlpZiAoYWRldi0+cG0ucHBfZmVh
dHVyZSAmIFBQX0dGWE9GRl9NQVNLKQotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=
