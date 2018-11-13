From: Oak Zeng <ozeng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/4] drm/amdkfd: Add sdma allocation debug message
Date: Tue, 13 Nov 2018 19:11:22 +0000
Message-ID: <1542136254-5561-4-git-send-email-ozeng@amd.com>
References: <1542136254-5561-1-git-send-email-ozeng@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1542136254-5561-1-git-send-email-ozeng-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>

RnJvbTogT2FrIFplbmcgPE9hay5aZW5nQGFtZC5jb20+CgpDaGFuZ2UtSWQ6IEk0N2VjNzllY2Vh
YzgxMGY3MDMxZWFmODhkMjY3ZmM4MzcwNTAxYzI3ClNpZ25lZC1vZmYtYnk6IE9hayBaZW5nIDxP
YWsuWmVuZ0BhbWQuY29tPgpSZXZpZXdkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxp
bmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1
ZXVlX21hbmFnZXIuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9t
YW5hZ2VyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21h
bmFnZXIuYwppbmRleCBiYzhmOTU1Li4xMTZhZmVmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwpAQCAtMTE5Nyw2ICsx
MTk3LDkgQEAgc3RhdGljIGludCBjcmVhdGVfcXVldWVfY3BzY2goc3RydWN0IGRldmljZV9xdWV1
ZV9tYW5hZ2VyICpkcW0sIHN0cnVjdCBxdWV1ZSAqcSwKIAkJCXEtPnNkbWFfaWQgLyBnZXRfbnVt
X3NkbWFfZW5naW5lcyhkcW0pOwogCQlxLT5wcm9wZXJ0aWVzLnNkbWFfZW5naW5lX2lkID0KIAkJ
CXEtPnNkbWFfaWQgJSBnZXRfbnVtX3NkbWFfZW5naW5lcyhkcW0pOworCQlwcl9kZWJ1ZygiU0RN
QSBpZCBpczogICAgJWRcbiIsIHEtPnNkbWFfaWQpOworCQlwcl9kZWJ1ZygiU0RNQSBxdWV1ZSBp
ZDogJWRcbiIsIHEtPnByb3BlcnRpZXMuc2RtYV9xdWV1ZV9pZCk7CisJCXByX2RlYnVnKCJTRE1B
IGVuZ2luZSBpZDogJWRcbiIsIHEtPnByb3BlcnRpZXMuc2RtYV9lbmdpbmVfaWQpOwogCX0KIAog
CXJldHZhbCA9IGFsbG9jYXRlX2Rvb3JiZWxsKHFwZCwgcSk7Ci0tIAoyLjcuNAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
