From: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 01/11] drm/amdgpu/virt: bypass cg and pg setting for SRIOV
Date: Mon, 24 Apr 2017 14:57:59 +0800
Message-ID: <1493017089-23101-2-git-send-email-Xiangliang.Yu@amd.com>
References: <1493017089-23101-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1493017089-23101-1-git-send-email-Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Frank Min <Frank.Min-5C7GfCeVMHo@public.gmane.org>, Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>

R1BVIGh5cGVydmlzb3IgY292ZXIgYWxsIHNldHRpbmdzIG9mIENHIGFuZCBQRywgc28gZ3Vlc3Qg
ZG9lc24ndApuZWVkIHRvIGRvIGFueXRoaW5nLiBCeXBhc3MgaXQuCgpTaWduZWQtb2ZmLWJ5OiBG
cmFuayBNaW4gPEZyYW5rLk1pbkBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBYaWFuZ2xpYW5nIFl1
IDxYaWFuZ2xpYW5nLll1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZpcnQuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYwppbmRleCBiZTQzODIzLi43ZmNl
N2I1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmMKQEAgLTEwNSw2
ICsxMDUsOCBAQCB2b2lkIGFtZGdwdV92aXJ0X2luaXRfc2V0dGluZyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKIAkvKiBlbmFibGUgdmlydHVhbCBkaXNwbGF5ICovCiAJYWRldi0+bW9kZV9p
bmZvLm51bV9jcnRjID0gMTsKIAlhZGV2LT5lbmFibGVfdmlydHVhbF9kaXNwbGF5ID0gdHJ1ZTsK
KwlhZGV2LT5jZ19mbGFncyA9IDA7CisJYWRldi0+cGdfZmxhZ3MgPSAwOwogCiAJbXV0ZXhfaW5p
dCgmYWRldi0+dmlydC5sb2NrX2tpcSk7CiAJbXV0ZXhfaW5pdCgmYWRldi0+dmlydC5sb2NrX3Jl
c2V0KTsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
