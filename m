From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu/cik: expose CB chicken bit registers via read
 reg interface
Date: Mon, 12 Sep 2016 15:36:36 -0400
Message-ID: <1473708996-16827-2-git-send-email-alexander.deucher@amd.com>
References: <1473708996-16827-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1473708996-16827-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

VXNlZnVsIGZvciB2YWxpZGF0aW5nIGNlcnRhaW4gdGVzdHMgaW52b2x2aW5nIHRoZSBDQiB3aGVy
ZSB0aGUKY2hpY2tlbiBiaXQgc3RhdHVzIG1heSBoYXZlIGFuIGFmZmVjdCBvbiB0aGUgcmVzdWx0
cy4KClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaWsuYyB8IDQgKysrKwogMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2Npay5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrLmMKaW5kZXgg
ODI1ZGU4MC4uNjczZmE2YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Y2lrLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrLmMKQEAgLTEwMjEsNiAr
MTAyMSwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9hbGxvd2VkX3JlZ2lzdGVyX2Vu
dHJ5IGNpa19hbGxvd2VkX3JlYWRfcmVnaXN0ZXJzW10gPQogCXttbUdCX01BQ1JPVElMRV9NT0RF
MTMsIGZhbHNlfSwKIAl7bW1HQl9NQUNST1RJTEVfTU9ERTE0LCBmYWxzZX0sCiAJe21tR0JfTUFD
Uk9USUxFX01PREUxNSwgZmFsc2V9LAorCXttbUNCX0hXX0NPTlRST0wsIGZhbHNlfSwKKwl7bW1D
Ql9IV19DT05UUk9MXzEsIGZhbHNlfSwKKwl7bW1DQl9IV19DT05UUk9MXzIsIGZhbHNlfSwKKwl7
bW1DQl9IV19DT05UUk9MXzMsIGZhbHNlfSwKIAl7bW1DQ19SQl9CQUNLRU5EX0RJU0FCTEUsIGZh
bHNlLCB0cnVlfSwKIAl7bW1HQ19VU0VSX1JCX0JBQ0tFTkRfRElTQUJMRSwgZmFsc2UsIHRydWV9
LAogCXttbUdCX0JBQ0tFTkRfTUFQLCBmYWxzZSwgZmFsc2V9LAotLSAKMi41LjUKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
