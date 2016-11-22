From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 03/11] drm/amd/dal/dc: fix warning in dce_link_encoder.c
Date: Tue, 22 Nov 2016 11:57:20 -0500
Message-ID: <1479833848-14275-3-git-send-email-alexander.deucher@amd.com>
References: <1479833848-14275-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1479833848-14275-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

UmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwvZGMvZGNlL2RjZV9saW5rX2VuY29kZXIuYyB8IDEgLQog
MSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2RhbC9kYy9kY2UvZGNlX2xpbmtfZW5jb2Rlci5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kYWwvZGMvZGNlL2RjZV9saW5rX2VuY29kZXIuYwppbmRleCA5NjhkNDE4Li4xNWE0NTMxIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9kY2UvZGNlX2xpbmtfZW5jb2Rl
ci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGFsL2RjL2RjZS9kY2VfbGlua19lbmNvZGVy
LmMKQEAgLTk2NCw3ICs5NjQsNiBAQCBib29sIGRjZTExMF9saW5rX2VuY29kZXJfY29uc3RydWN0
KAogCWNvbnN0IHN0cnVjdCBkY2UxMTBfbGlua19lbmNfYXV4X3JlZ2lzdGVycyAqYXV4X3JlZ3Ms
CiAJY29uc3Qgc3RydWN0IGRjZTExMF9saW5rX2VuY19ocGRfcmVnaXN0ZXJzICpocGRfcmVncykK
IHsKLQlzdHJ1Y3QgZ3JhcGhpY3Nfb2JqZWN0X2VuY29kZXJfY2FwX2luZm8gZW5jX2NhcF9pbmZv
ID0gezB9OwogCiAJZW5jMTEwLT5iYXNlLmZ1bmNzID0gJmRjZTExMF9sbmtfZW5jX2Z1bmNzOwog
CWVuYzExMC0+YmFzZS5jdHggPSBpbml0X2RhdGEtPmN0eDsKLS0gCjIuNS41CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
