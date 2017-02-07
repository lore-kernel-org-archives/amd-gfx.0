From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/7] drm/amd/display: Fixed color temperature corruption.
Date: Mon, 6 Feb 2017 19:18:10 -0500
Message-ID: <20170207001812.6099-6-harry.wentland@amd.com>
References: <20170207001812.6099-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170207001812.6099-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Yongqiang Sun <yongqiang.sun-5C7GfCeVMHo@public.gmane.org>

RnJvbTogWW9uZ3FpYW5nIFN1biA8eW9uZ3FpYW5nLnN1bkBhbWQuY29tPgoKQ2hhbmdlLUlkOiBJ
MzYwMDkwZjBiOWM5MjAwYThlYmMwY2EzZDc1ZTM3MGI4MGE4ZjZjYwpTaWduZWQtb2ZmLWJ5OiBZ
b25ncWlhbmcgU3VuIDx5b25ncWlhbmcuc3VuQGFtZC5jb20+ClJldmlld2VkLWJ5OiBKb3JkYW4g
TGF6YXJlIDxKb3JkYW4uTGF6YXJlQGFtZC5jb20+CkFja2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8
SGFycnkuV2VudGxhbmRAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvaW5jL2h3L2h3X3NoYXJlZC5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2luYy9ody9od19zaGFyZWQuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9pbmMvaHcvaHdfc2hhcmVkLmgKaW5kZXggYjg3MzViMjdlOWJjLi5kZmU1OTAxOThhMzMgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9pbmMvaHcvaHdfc2hhcmVk
LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2luYy9ody9od19zaGFyZWQu
aApAQCAtNjUsNyArNjUsNyBAQCBzdHJ1Y3QgcHdsX3Jlc3VsdF9kYXRhIHsKIH07CiAKIHN0cnVj
dCBwd2xfcGFyYW1zIHsKLQlzdHJ1Y3QgZ2FtbWFfY3VydmUgYXJyX2N1cnZlX3BvaW50c1sxNl07
CisJc3RydWN0IGdhbW1hX2N1cnZlIGFycl9jdXJ2ZV9wb2ludHNbMzRdOwogCXN0cnVjdCBjdXJ2
ZV9wb2ludHMgYXJyX3BvaW50c1szXTsKIAlzdHJ1Y3QgcHdsX3Jlc3VsdF9kYXRhIHJnYl9yZXN1
bHRlZFsyNTYgKyAzXTsKIAl1aW50MzJfdCBod19wb2ludHNfbnVtOwotLSAKMi45LjMKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
