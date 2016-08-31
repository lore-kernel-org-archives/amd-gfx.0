From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 15/15] drm/amdgpu/si: enable SI DPM by default
Date: Wed, 31 Aug 2016 13:23:27 +0800
Message-ID: <1472621007-17578-16-git-send-email-ray.huang@amd.com>
References: <1472621007-17578-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472621007-17578-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Hui Yu <Hui.Yu-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

U0kgRFBNIGlzc3VlIGlzIGZpeGVkLCBzbyBlbmFibGUgaXQgYnkgZGVmYXVsdC4KCkFja2VkLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+ClJldmlld2VkLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6
IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc2lfZHBtLmMgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zaV9kcG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jCmluZGV4IGI2
M2RkMzkuLjBjM2JjMjIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Np
X2RwbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RwbS5jCkBAIC03NjMz
LDcgKzc2MzMsNyBAQCBzdGF0aWMgaW50IHNpX2RwbV9sYXRlX2luaXQodm9pZCAqaGFuZGxlKQog
CWludCByZXQ7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKiloYW5kbGU7CiAKLQlpZiAoYW1kZ3B1X2RwbSA8PSAwKQorCWlmICghYW1kZ3B1X2Rw
bSkKIAkJcmV0dXJuIDA7CiAKIAkvKiBpbml0IHRoZSBzeXNmcyBhbmQgZGVidWdmcyBmaWxlcyBs
YXRlICovCkBAIC03NzYwLDcgKzc3NjAsNyBAQCBzdGF0aWMgaW50IHNpX2RwbV9zd19pbml0KHZv
aWQgKmhhbmRsZSkKIAlhZGV2LT5wbS5jdXJyZW50X21jbGsgPSBhZGV2LT5jbG9jay5kZWZhdWx0
X21jbGs7CiAJYWRldi0+cG0uaW50X3RoZXJtYWxfdHlwZSA9IFRIRVJNQUxfVFlQRV9OT05FOwog
Ci0JaWYgKGFtZGdwdV9kcG0gPD0gMCkKKwlpZiAoIWFtZGdwdV9kcG0pCiAJCXJldHVybiAwOwog
CiAJcmV0ID0gc2lfZHBtX2luaXRfbWljcm9jb2RlKGFkZXYpOwpAQCAtNzgwNSw3ICs3ODA1LDcg
QEAgc3RhdGljIGludCBzaV9kcG1faHdfaW5pdCh2b2lkICpoYW5kbGUpCiAKIAlzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsKIAotCWlm
IChhbWRncHVfZHBtIDw9IDApCisJaWYgKCFhbWRncHVfZHBtKQogCQlyZXR1cm4gMDsKIAogCW11
dGV4X2xvY2soJmFkZXYtPnBtLm11dGV4KTsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
