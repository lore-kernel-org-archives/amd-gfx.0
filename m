From: "Huang, JinHuiEric" <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdkfd: fix a compiling error when CONFIG_HSA_AMD disalbed
Date: Wed, 6 Mar 2019 15:59:23 +0000
Message-ID: <1551887958-3657-1-git-send-email-JinhuiEric.Huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: "Huang, JinHuiEric" <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>

SXQgZml4ZXMgYSBjb21tcGlsaW5nIGVycm9yIG9uIGNvbW1pdAo5MDMyZWEwOWUyZDJlZjBkMTBl
NWNkNzkzNzEzYmYyZWIyMTY0M2M1CmRybS9hbWRrZmQ6IGFkZCBSQVMgRUNDIGV2ZW50IHN1cHBv
cnQKCkNoYW5nZS1JZDogSTg3OTI3Njc3MjZlMjhlZWQzYTNmY2Y5MDcyZjYwODcwMWJlMTNjNzkK
U2lnbmVkLW9mZi1ieTogRXJpYyBIdWFuZyA8SmluaHVpRXJpYy5IdWFuZ0BhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYyB8IDQgKysrKwogMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmQuYwppbmRleCBmZTFkNzM2Li5hY2Y4YWUwIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jCkBAIC02NDAsNCArNjQwLDggQEAgaW50IGtn
ZDJrZmRfcG9zdF9yZXNldChzdHJ1Y3Qga2ZkX2RldiAqa2ZkKQogdm9pZCBrZ2Qya2ZkX2ludGVy
cnVwdChzdHJ1Y3Qga2ZkX2RldiAqa2ZkLCBjb25zdCB2b2lkICppaF9yaW5nX2VudHJ5KQogewog
fQorCit2b2lkIGtnZDJrZmRfc2V0X3NyYW1fZWNjX2ZsYWcoc3RydWN0IGtmZF9kZXYgKmtmZCkK
K3sKK30KICNlbmRpZgotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
