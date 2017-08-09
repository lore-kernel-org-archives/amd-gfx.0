From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 094/120] drm/amd/display: Fix plane_atomic_check when no
 dc_state
Date: Wed, 9 Aug 2017 11:02:20 -0400
Message-ID: <20170809150246.8835-95-harry.wentland@amd.com>
References: <20170809150246.8835-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170809150246.8835-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJYmYwMTNlMDllMmNkYmMzM2ZhMGQ3MzJlN2VkYTNjOGU3MTExZDk3NApTaWdu
ZWQtb2ZmLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KUmV2aWV3
ZWQtYnk6IEFuZHJleSBHcm9kem92c2t5IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPgpBY2tl
ZC1ieTogSGFycnkgV2VudGxhbmQgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDIgKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCmluZGV4IGQyNzFjY2Vl
M2UwOS4uYjIwZWE1YTk0NWE0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKQEAgLTMzMTAsNyArMzMxMCw3IEBAIGludCBkbV9wbGFu
ZV9hdG9taWNfY2hlY2soc3RydWN0IGRybV9wbGFuZSAqcGxhbmUsCiAJc3RydWN0IGRtX3BsYW5l
X3N0YXRlICpkbV9wbGFuZV9zdGF0ZSA9IHRvX2RtX3BsYW5lX3N0YXRlKHN0YXRlKTsKIAogCWlm
ICghZG1fcGxhbmVfc3RhdGUtPmRjX3N0YXRlKQotCQlyZXR1cm4gdHJ1ZTsKKwkJcmV0dXJuIDA7
CiAKIAlpZiAoZGNfdmFsaWRhdGVfcGxhbmUoZGMsIGRtX3BsYW5lX3N0YXRlLT5kY19zdGF0ZSkp
CiAJCXJldHVybiAwOwotLSAKMi4xMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
