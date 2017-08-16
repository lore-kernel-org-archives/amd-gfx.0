From: Xiangliang.Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/1] drm/ttm: Fix accounting error when fail to get pages for
 pool
Date: Wed, 16 Aug 2017 15:20:46 +0800
Message-ID: <1502868046-32511-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: "Xiangliang.Yu" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>

V2hlbiBmYWlsIHRvIGdldCBuZWVkZWQgcGFnZSBmb3IgcG9vbCwgbmVlZCB0byBwdXQgYWxsb2Nh
dGVkIHBhZ2VzCmludG8gcG9vbC4gQnV0IGN1cnJlbnQgY29kZSBoYXMgYSBtaXNjYWxjdWxhdGlv
biBvZiBhbGxvY2F0ZWQgcGFnZXMsCmNvcnJlY3QgaXQuCgpTaWduZWQtb2ZmLWJ5OiBYaWFuZ2xp
YW5nLll1IDxYaWFuZ2xpYW5nLll1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3R0bS90
dG1fcGFnZV9hbGxvYy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9h
bGxvYy5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jCmluZGV4IGVlZGRj
MWUuLjg3MTU5OTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxs
b2MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMKQEAgLTYxNSw3
ICs2MTUsNyBAQCBzdGF0aWMgdm9pZCB0dG1fcGFnZV9wb29sX2ZpbGxfbG9ja2VkKHN0cnVjdCB0
dG1fcGFnZV9wb29sICpwb29sLAogCQl9IGVsc2UgewogCQkJcHJfZXJyKCJGYWlsZWQgdG8gZmls
bCBwb29sICglcClcbiIsIHBvb2wpOwogCQkJLyogSWYgd2UgaGF2ZSBhbnkgcGFnZXMgbGVmdCBw
dXQgdGhlbSB0byB0aGUgcG9vbC4gKi8KLQkJCWxpc3RfZm9yX2VhY2hfZW50cnkocCwgJnBvb2wt
Pmxpc3QsIGxydSkgeworCQkJbGlzdF9mb3JfZWFjaF9lbnRyeShwLCAmbmV3X3BhZ2VzLCBscnUp
IHsKIAkJCQkrK2NwYWdlczsKIAkJCX0KIAkJCWxpc3Rfc3BsaWNlKCZuZXdfcGFnZXMsICZwb29s
LT5saXN0KTsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
