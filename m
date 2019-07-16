From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 098/102] drm/amdgpu: enable all 8 sdma instances for Arcturus
 silicon
Date: Mon, 15 Jul 2019 20:27:37 -0500
Message-ID: <20190716012741.32036-8-alexander.deucher@amd.com>
References: <20190716012741.32036-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190716012741.32036-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTGUgTWEgPGxlLm1hQGFtZC5jb20+CgpUaGUgbW9yZSA2IHNkbWEgaW5zdGFuY2VzIHdv
cmsgZmluZSBub3cgd2l0aCBERiBmaXggaW4gdmJpb3M6CiAgKiBtbURGX1BJRV9BT05fTWlzY0Ns
aWVudHNFbmFibGUoMHgxYzcyOCk9MHgzZmUoREZfQUxMX0lOU1RBTkNFKQogICAgICAgWzk6NF1N
bWh1YnNFbmFibGU9M2YgKGNoYW5nZSBmcm9tIDApCgpTaWduZWQtb2ZmLWJ5OiBMZSBNYSA8bGUu
bWFAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+ClNp
Z25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYyB8IDIgKy0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc2RtYV92NF8wLmMKaW5kZXggYzY4YmJjZjUyNjAyLi4xNjZiMTk5OWRjYmYgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jCkBAIC0xNTk5LDcgKzE1OTksNyBAQCBz
dGF0aWMgaW50IHNkbWFfdjRfMF9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKIAlpZiAoYWRldi0+
YXNpY190eXBlID09IENISVBfUkFWRU4pCiAJCWFkZXYtPnNkbWEubnVtX2luc3RhbmNlcyA9IDE7
CiAJZWxzZSBpZiAoYWRldi0+YXNpY190eXBlID09IENISVBfQVJDVFVSVVMpCi0JCWFkZXYtPnNk
bWEubnVtX2luc3RhbmNlcyA9IDI7CisJCWFkZXYtPnNkbWEubnVtX2luc3RhbmNlcyA9IDg7CiAJ
ZWxzZQogCQlhZGV2LT5zZG1hLm51bV9pbnN0YW5jZXMgPSAyOwogCi0tIAoyLjIwLjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
