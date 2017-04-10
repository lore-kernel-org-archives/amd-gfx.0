From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: bump version number to note race fix and new
 fence functionality
Date: Mon, 10 Apr 2017 15:43:25 -0400
Message-ID: <1491853405-12292-2-git-send-email-alexander.deucher@amd.com>
References: <1491853405-12292-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1491853405-12292-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

Zml4ZWQgaW46ICJkcm0vYW1kZ3B1OmZpeCByYWNlIGNvbmRpdGlvbiIKClNpZ25lZC1vZmYtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kcnYuYwppbmRleCA0ZTBmN2QyLi5iYjQ3ZmIzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2Rydi5jCkBAIC02Myw5ICs2MywxMCBAQAogICogLSAzLjExLjAgLSBBZGQg
c3VwcG9ydCBmb3Igc2Vuc29yIHF1ZXJ5IGluZm8gKGNsb2NrcywgdGVtcCwgZXRjKS4KICAqIC0g
My4xMi4wIC0gQWRkIHF1ZXJ5IGZvciBkb3VibGUgb2ZmY2hpcCBMRFMgYnVmZmVycwogICogLSAz
LjEzLjAgLSBBZGQgUFJUIHN1cHBvcnQKKyAqIC0gMy4xNC4wIC0gRml4IHJhY2UgaW4gYW1kZ3B1
X2N0eF9nZXRfZmVuY2UoKSBhbmQgbm90ZSBuZXcgZnVuY3Rpb25hbGl0eQogICovCiAjZGVmaW5l
IEtNU19EUklWRVJfTUFKT1IJMwotI2RlZmluZSBLTVNfRFJJVkVSX01JTk9SCTEzCisjZGVmaW5l
IEtNU19EUklWRVJfTUlOT1IJMTQKICNkZWZpbmUgS01TX0RSSVZFUl9QQVRDSExFVkVMCTAKIAog
aW50IGFtZGdwdV92cmFtX2xpbWl0ID0gMDsKLS0gCjIuNS41CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
