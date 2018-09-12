From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 17/21] drm/amdgpu: enable vcn powergating for PCO
Date: Wed, 12 Sep 2018 13:56:28 -0500
Message-ID: <20180912185632.30062-18-alexander.deucher@amd.com>
References: <20180912185632.30062-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180912185632.30062-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Kenneth Feng <kenneth.feng-5C7GfCeVMHo@public.gmane.org>

RnJvbTogS2VubmV0aCBGZW5nIDxrZW5uZXRoLmZlbmdAYW1kLmNvbT4KCmVuYWJsZSB2Y24gcGcK
ClNpZ25lZC1vZmYtYnk6IEtlbm5ldGggRmVuZyA8a2VubmV0aC5mZW5nQGFtZC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jIHwgNCArKystCiAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Nv
YzE1LmMKaW5kZXggNTMxNTlmMWQ3YTM5Li43ODM3ZjBjYzc1YjIgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc29jMTUuYwpAQCAtNzQwLDcgKzc0MCw5IEBAIHN0YXRpYyBpbnQgc29jMTVfY29tbW9u
X2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQogCQkJQU1EX0NHX1NVUFBPUlRfU0RNQV9NR0NHIHwK
IAkJCUFNRF9DR19TVVBQT1JUX1NETUFfTFM7CiAKLQkJYWRldi0+cGdfZmxhZ3MgPSBBTURfUEdf
U1VQUE9SVF9TRE1BIHwgQU1EX1BHX1NVUFBPUlRfTU1IVUI7CisJCWFkZXYtPnBnX2ZsYWdzID0g
QU1EX1BHX1NVUFBPUlRfU0RNQSB8CisJCQkJCQlBTURfUEdfU1VQUE9SVF9NTUhVQiB8CisJCQkJ
CQlBTURfUEdfU1VQUE9SVF9WQ047CiAKIAkJaWYgKGFkZXYtPnBvd2VycGxheS5wcF9mZWF0dXJl
ICYgUFBfR0ZYT0ZGX01BU0spCiAJCQlhZGV2LT5wZ19mbGFncyB8PSBBTURfUEdfU1VQUE9SVF9H
RlhfUEcgfAotLSAKMi4xMy42CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
