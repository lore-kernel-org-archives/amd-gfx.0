From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 16/18] drm/amdgpu: fix entries index calculation
Date: Fri, 24 Mar 2017 11:16:55 +0800
Message-ID: <1490325417-26745-17-git-send-email-David1.Zhou@amd.com>
References: <1490325417-26745-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490325417-26745-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJM2U3ZWFiYzM1NzZhZjQyNjVmOGNmNTgxODdlYmU2Y2M2MjUwM2FjNgpTaWdu
ZWQtb2ZmLWJ5OiBDaHVubWluZyBaaG91IDxEYXZpZDEuWmhvdUBhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMKaW5kZXggOTcyMTU1Mi4uOGNjYzZhNCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMKQEAgLTE0NjIsOCArMTQ2Miw4IEBAIHN0YXRpYyBpbnQgYW1k
Z3B1X3ZtX2FsbG9jX2xldmVscyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJbWVtc2V0
KHBhcmVudC0+ZW50cmllcywgMCAsIHNpemVvZihzdHJ1Y3QgYW1kZ3B1X3ZtX3B0KSk7CiAJfQog
Ci0JZnJvbSA9IHNhZGRyID4+IHNoaWZ0OwotCXRvID0gZWFkZHIgPj4gc2hpZnQ7CisJZnJvbSA9
IChzYWRkciA+PiBzaGlmdCkgJSBhbWRncHVfdm1fbnVtX2VudHJpZXMoYWRldiwgbGV2ZWwpOwor
CXRvID0gKGVhZGRyID4+IHNoaWZ0KSAlIGFtZGdwdV92bV9udW1fZW50cmllcyhhZGV2LCBsZXZl
bCk7CiAKIAlpZiAodG8gPiBwYXJlbnQtPmxhc3RfZW50cnlfdXNlZCkKIAkJcGFyZW50LT5sYXN0
X2VudHJ5X3VzZWQgPSB0bzsKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
