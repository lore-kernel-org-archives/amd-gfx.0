From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/3] drm/amdgpu: Remove unused dc_stream from amdgpu_crtc
Date: Wed, 8 Nov 2017 10:33:38 -0500
Message-ID: <20171108153339.19723-3-harry.wentland@amd.com>
References: <20171108153339.19723-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171108153339.19723-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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

SXQncyBubyBsb25nZXIgdXNlZC4gSW4gZmFjdCwgdGhlcmUgaXMgbm8gbW9yZSBkY19zdHJlYW0g
b2JqZWN0LgoKU2lnbmVkLW9mZi1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFt
ZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21vZGUuaCB8IDIg
LS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tb2RlLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfbW9kZS5oCmluZGV4IDQwNjlhM2IyZjU1Zi4uZGQ5ZWNkM2U0MGU4IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW9kZS5oCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tb2RlLmgKQEAgLTQzNyw4ICs0MzcsNiBA
QCBzdHJ1Y3QgYW1kZ3B1X2NydGMgewogCWVudW0gYW1kZ3B1X2ludGVycnVwdF9zdGF0ZSB2c3lu
Y190aW1lcl9lbmFibGVkOwogCiAJaW50IG90Z19pbnN0OwotCS8qIEFmdGVyIFNldCBNb2RlIHN0
cmVhbSB3aWxsIGJlIG5vbi1OVUxMICovCi0JY29uc3Qgc3RydWN0IGRjX3N0cmVhbSAqc3RyZWFt
OwogCXN0cnVjdCBkcm1fcGVuZGluZ192YmxhbmtfZXZlbnQgKmV2ZW50OwogfTsKIAotLSAKMi4x
NC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
