From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/4] drm/amdgpu: add new DF callback for ECC setup
Date: Wed, 16 May 2018 15:51:54 -0500
Message-ID: <20180516205156.29064-2-alexander.deucher@amd.com>
References: <20180516205156.29064-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180516205156.29064-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

VGhlIEZvcmNlUGFyV3JSTVcgc2V0dGluZyBuZWVkcyB0byBiZSBlbmFibGVkIGZvciBFQ0MsIGJ1
dCBkaXNhYmxlZAp3aGVuIEVDQyBpcyBub3QgZW5hYmxlZC4KClNpZ25lZC1vZmYtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHUuaCB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCmluZGV4IDAzYTJjMGJlMGJmMi4uYTU5
YzA3NTkwY2VlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUu
aAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaApAQCAtMTQwMSw2ICsx
NDAxLDggQEAgc3RydWN0IGFtZGdwdV9kZl9mdW5jcyB7CiAJCQkJCQkgYm9vbCBlbmFibGUpOwog
CXZvaWQgKCpnZXRfY2xvY2tnYXRpbmdfc3RhdGUpKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAogCQkJCSAgICAgIHUzMiAqZmxhZ3MpOworCXZvaWQgKCplbmFibGVfZWNjX2ZvcmNlX3Bhcl93
cl9ybXcpKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAorCQkJCQkgICAgYm9vbCBlbmFibGUp
OwogfTsKIC8qIERlZmluZSB0aGUgSFcgSVAgYmxvY2tzIHdpbGwgYmUgdXNlZCBpbiBkcml2ZXIg
LCBhZGQgbW9yZSBpZiBuZWNlc3NhcnkgKi8KIGVudW0gYW1kX2h3X2lwX2Jsb2NrX3R5cGUgewot
LSAKMi4xMy42CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
