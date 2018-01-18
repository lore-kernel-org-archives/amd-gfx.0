From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 24/24] drm/amd/display: Fix warning about misaligned code
Date: Thu, 18 Jan 2018 16:03:53 -0500
Message-ID: <20180118210353.18842-25-harry.wentland@amd.com>
References: <20180118210353.18842-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180118210353.18842-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jIHwgNCArKy0t
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYwppbmRleCA0MjBiYzJk
ODU5ZWIuLjAwMjM3NTRlMDM0YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2NvcmUvZGNfbGluay5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9jb3JlL2RjX2xpbmsuYwpAQCAtMjMxNiw4ICsyMzE2LDggQEAgdm9pZCBjb3JlX2xpbmtfZW5h
YmxlX3N0cmVhbSgKIAlpZiAocGlwZV9jdHgtPnN0cmVhbS0+c2lnbmFsID09IFNJR05BTF9UWVBF
X0RJU1BMQVlfUE9SVF9NU1QpCiAJCWFsbG9jYXRlX21zdF9wYXlsb2FkKHBpcGVfY3R4KTsKIAot
CQljb3JlX2RjLT5od3NzLnVuYmxhbmtfc3RyZWFtKHBpcGVfY3R4LAotCQkJJnBpcGVfY3R4LT5z
dHJlYW0tPnNpbmstPmxpbmstPmN1cl9saW5rX3NldHRpbmdzKTsKKwljb3JlX2RjLT5od3NzLnVu
Ymxhbmtfc3RyZWFtKHBpcGVfY3R4LAorCQkmcGlwZV9jdHgtPnN0cmVhbS0+c2luay0+bGluay0+
Y3VyX2xpbmtfc2V0dGluZ3MpOwogfQogCiB2b2lkIGNvcmVfbGlua19kaXNhYmxlX3N0cmVhbShz
dHJ1Y3QgcGlwZV9jdHggKnBpcGVfY3R4LCBpbnQgb3B0aW9uKQotLSAKMi4xNC4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
