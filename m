From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 11/11] drm/ttm: bulk move per vm bo
Date: Thu, 12 Apr 2018 18:09:40 +0800
Message-ID: <20180412100940.25039-12-david1.zhou@amd.com>
References: <20180412100940.25039-1-david1.zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180412100940.25039-1-david1.zhou-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>, Kai.Guo-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org

Q2hhbmdlLUlkOiBJNWI2YWZiZGQ3MTVlMjhlNTI2NmI1MDk5Y2E5YTM0Mzk5ZDFmYzNhMQpTaWdu
ZWQtb2ZmLWJ5OiBDaHVubWluZyBaaG91IDxkYXZpZDEuemhvdUBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS90dG0vdHRtX2JvLmMgfCA5ICsrKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vdHRtL3R0bV9iby5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYwppbmRleCBkYzk1
NDVlZWI1ZDYuLmQ2ZTdjODM1ZjRjMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90
dG1fYm8uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jCkBAIC0yNjEsOCArMjYx
LDEzIEBAIHZvaWQgdHRtX2JvX21vdmVfdG9fbHJ1X3RhaWwoc3RydWN0IHR0bV9idWZmZXJfb2Jq
ZWN0ICpibykKIHsKIAlyZXNlcnZhdGlvbl9vYmplY3RfYXNzZXJ0X2hlbGQoYm8tPnJlc3YpOwog
Ci0JdHRtX2JvX2RlbF9mcm9tX2xydShibyk7Ci0JdHRtX2JvX2FkZF90b19scnUoYm8pOworCWlm
IChiby0+cmVzdiA9PSBiby0+cHJvY2Vzcy0+cmVzdikgeworCQlsaXN0X21vdmVfdGFpbCgmYm8t
PnByb2Nlc3MtPnByb2Nlc3NfbGlzdCwKKwkJCSAgICAgICAmYm8tPmJkZXYtPnByb2Nlc3NfbGlz
dCk7CisJfSBlbHNlIHsKKwkJdHRtX2JvX2RlbF9mcm9tX2xydShibyk7CisJCXR0bV9ib19hZGRf
dG9fbHJ1KGJvKTsKKwl9CiB9CiBFWFBPUlRfU1lNQk9MKHR0bV9ib19tb3ZlX3RvX2xydV90YWls
KTsKIAotLSAKMi4xNC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
