From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 10/13] drm/amdgpu: bulk move per vm bo
Date: Wed, 9 May 2018 14:45:40 +0800
Message-ID: <20180509064543.15937-11-david1.zhou@amd.com>
References: <20180509064543.15937-1-david1.zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180509064543.15937-1-david1.zhou-5C7GfCeVMHo@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Jerry.Zhang-5C7GfCeVMHo@public.gmane.org, ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Kai.Guo-5C7GfCeVMHo@public.gmane.org, Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJMGQ1ZmE3ZTVlODg1NjhmNzllODM2ZmY0N2Y5YzkxMzJjYjdkMzQ5ZQpTaWdu
ZWQtb2ZmLWJ5OiBDaHVubWluZyBaaG91IDxkYXZpZDEuemhvdUBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNSArKysrKwogMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMK
aW5kZXggNWJlZjRmZmExYzg3Li41MzdmMDRkMjU1MzUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCkBAIC0zMDcsNyArMzA3LDEyIEBAIHZvaWQgYW1kZ3B1X3ZtX2RlbF9m
cm9tX2xydShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvKQogCiB2b2lkIGFtZGdwdV92bV9t
b3ZlX3RvX2xydV90YWlsKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8pCiB7CisJc3RydWN0
IGFtZGdwdV9ibyAqYWJvID0gdHRtX3RvX2FtZGdwdV9ibyhibyk7CisJc3RydWN0IGFtZGdwdV92
bV9scnUgKnZtX2xydSA9IGFiby0+dm1fbHJ1OworCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
ID0gYW1kZ3B1X3R0bV9hZGV2KGJvLT5iZGV2KTsKIAorCWlmIChiby0+cmVzdiA9PSB2bV9scnUt
PnJlc3YpCisgICAgICAgICAgICAgICBsaXN0X21vdmVfdGFpbCgmdm1fbHJ1LT52bV9scnVfbGlz
dCwgJmFkZXYtPnZtX2xydV9saXN0KTsKIH0KIAogCi0tIAoyLjE0LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
