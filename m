From: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdkfd: avoid calling execute_queues_cpsch() when
 destroying an unactive queue
Date: Tue,  2 Jan 2018 13:10:50 -0500
Message-ID: <1514916650-7042-2-git-send-email-yong.zhao@amd.com>
References: <1514916650-7042-1-git-send-email-yong.zhao@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1514916650-7042-1-git-send-email-yong.zhao-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogWW9uZyBaaGFvIDx5b25nLnpoYW9AYW1kLmNvbT4KUmV2aWV3ZWQtYnk6
IE9hayBaZW5nIDxvYWsuemVuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jIHwgMTAgKysrKystLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jCmluZGV4IGFj
ZmIxMjEuLmIyMTI4NWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jCkBAIC0xMDEzLDEzICsxMDEzLDEzIEBAIHN0YXRp
YyBpbnQgZGVzdHJveV9xdWV1ZV9jcHNjaChzdHJ1Y3QgZGV2aWNlX3F1ZXVlX21hbmFnZXIgKmRx
bSwKIAogCWxpc3RfZGVsKCZxLT5saXN0KTsKIAlxcGQtPnF1ZXVlX2NvdW50LS07Ci0JaWYgKHEt
PnByb3BlcnRpZXMuaXNfYWN0aXZlKQorCWlmIChxLT5wcm9wZXJ0aWVzLmlzX2FjdGl2ZSkgewog
CQlkcW0tPnF1ZXVlX2NvdW50LS07Ci0KLQlyZXR2YWwgPSBleGVjdXRlX3F1ZXVlc19jcHNjaChk
cW0sCisJCXJldHZhbCA9IGV4ZWN1dGVfcXVldWVzX2Nwc2NoKGRxbSwKIAkJCQlLRkRfVU5NQVBf
UVVFVUVTX0ZJTFRFUl9EWU5BTUlDX1FVRVVFUywgMCk7Ci0JaWYgKHJldHZhbCA9PSAtRVRJTUUp
Ci0JCXFwZC0+cmVzZXRfd2F2ZWZyb250cyA9IHRydWU7CisJCWlmIChyZXR2YWwgPT0gLUVUSU1F
KQorCQkJcXBkLT5yZXNldF93YXZlZnJvbnRzID0gdHJ1ZTsKKwl9CiAKIAltcWQtPnVuaW5pdF9t
cWQobXFkLCBxLT5tcWQsIHEtPm1xZF9tZW1fb2JqKTsKIAotLSAKMi43LjQKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
