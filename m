From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 18/19] drm/amdgpu: Disable GFX PG on CZ
Date: Fri, 11 Aug 2017 17:56:28 -0400
Message-ID: <1502488589-30272-19-git-send-email-Felix.Kuehling@amd.com>
References: <1502488589-30272-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1502488589-30272-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

SXQncyBjYXVzaW5nIHByb2JsZW1zIHdpdGggdXNlciBtb2RlIHF1ZXVlcyBhbmQgdGhlIEhJUSwg
YW5kIGNhbgpsZWFkIHRvIGhhcmQgaGFuZ3MgZHVyaW5nIGJvb3QgYWZ0ZXIgcHJvZ3JhbW1pbmcg
UkxDX0NQX1NDSEVEVUxFUlMuCgpTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXgu
S3VlaGxpbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jIHwg
MyArLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdmkuYwppbmRleCAxOGJiM2NiLi40OTVjOGEzIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3ZpLmMKQEAgLTEwMjksOCArMTAyOSw3IEBAIHN0YXRpYyBpbnQgdmlfY29tbW9uX2Vh
cmx5X2luaXQodm9pZCAqaGFuZGxlKQogCQkvKiByZXYwIGhhcmR3YXJlIHJlcXVpcmVzIHdvcmth
cm91bmRzIHRvIHN1cHBvcnQgUEcgKi8KIAkJYWRldi0+cGdfZmxhZ3MgPSAwOwogCQlpZiAoYWRl
di0+cmV2X2lkICE9IDB4MDAgfHwgQ1pfUkVWX0JSSVNUT0woYWRldi0+cGRldi0+cmV2aXNpb24p
KSB7Ci0JCQlhZGV2LT5wZ19mbGFncyB8PSBBTURfUEdfU1VQUE9SVF9HRlhfUEcgfAotCQkJCUFN
RF9QR19TVVBQT1JUX0dGWF9TTUcgfAorCQkJYWRldi0+cGdfZmxhZ3MgfD0gQU1EX1BHX1NVUFBP
UlRfR0ZYX1NNRyB8CiAJCQkJQU1EX1BHX1NVUFBPUlRfR0ZYX1BJUEVMSU5FIHwKIAkJCQlBTURf
UEdfU1VQUE9SVF9DUCB8CiAJCQkJQU1EX1BHX1NVUFBPUlRfVVZEIHwKLS0gCjIuNy40CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
