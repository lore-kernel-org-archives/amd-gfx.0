From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 11/12] drm/amdgpu/sriov:show error if ib test failed
Date: Sat, 30 Sep 2017 14:03:51 +0800
Message-ID: <1506751432-21789-12-git-send-email-Monk.Liu@amd.com>
References: <1506751432-21789-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1506751432-21789-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

Zml4IGxvb3NlIG1vZGUgZ3B1IHJlc2V0IGliIHRlc3QgcmVzdWx0IGluY29ycmVjdCBtZXNzYWdl
CgpDaGFuZ2UtSWQ6IEljNGUzYjUxZTRmZjc3YzVlMDhkMjY4YTRhNWNhMzJlN2M4ODIzNjdjClNp
Z25lZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jCmluZGV4IDEyMmUyZTEuLmMzZjEwYjUgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTI5MDIsNyArMjkwMiw4IEBAIGlu
dCBhbWRncHVfc3Jpb3ZfZ3B1X3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1
Y3QgYW1kZ3B1X2pvYiAqam9iKQogCiAJYW1kZ3B1X2lycV9ncHVfcmVzZXRfcmVzdW1lX2hlbHBl
cihhZGV2KTsKIAotCWlmIChhbWRncHVfaWJfcmluZ190ZXN0cyhhZGV2KSkKKwlyID0gYW1kZ3B1
X2liX3JpbmdfdGVzdHMoYWRldik7CisJaWYgKHIpCiAJCWRldl9lcnIoYWRldi0+ZGV2LCAiW0dQ
VV9SRVNFVF0gaWIgcmluZyB0ZXN0IGZhaWxlZCAoJWQpLlxuIiwgcik7CiAKIAkvKiByZWxlYXNl
IGZ1bGwgY29udHJvbCBvZiBHUFUgYWZ0ZXIgaWIgdGVzdCAqLwotLSAKMi43LjQKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
