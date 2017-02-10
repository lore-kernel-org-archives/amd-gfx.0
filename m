From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/8] drm/amdgpu: Add a few members to support DAL atomic
 refactor.
Date: Fri, 10 Feb 2017 11:26:27 -0500
Message-ID: <20170210162630.18157-6-harry.wentland@amd.com>
References: <20170210162630.18157-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170210162630.18157-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, daniel.vetter-/w4YWyX8dFk@public.gmane.org, dc_upstream-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

RnJvbTogQW5kcmV5IEdyb2R6b3Zza3kgPEFuZHJleS5Hcm9kem92c2t5QGFtZC5jb20+CgpTaWdu
ZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW9kZS5oIHwgNCArKysrCiAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21vZGUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9tb2RlLmgKaW5kZXggZmRhNTNmYTAzMTNmLi4xZTc3MTM2ZDZmMGMgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tb2RlLmgKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21vZGUuaApAQCAtMzIyLDYgKzMyMiw5IEBAIHN0
cnVjdCBhbWRncHVfZGlzcGxheV9mdW5jcyB7CiBzdHJ1Y3QgYW1kZ3B1X2ZyYW1lYnVmZmVyIHsK
IAlzdHJ1Y3QgZHJtX2ZyYW1lYnVmZmVyIGJhc2U7CiAJc3RydWN0IGRybV9nZW1fb2JqZWN0ICpv
Ymo7CisKKwkvKiBjYWNoaW5nIGZvciBsYXRlciB1c2UgKi8KKwl1aW50NjRfdCBhZGRyZXNzOwog
fTsKIAogc3RydWN0IGFtZGdwdV9mYmRldiB7CkBAIC00NDcsNiArNDUwLDcgQEAgc3RydWN0IGFt
ZGdwdV9jcnRjIHsKIAl1aW50MzJfdCBmbGlwX2ZsYWdzOwogCS8qIEFmdGVyIFNldCBNb2RlIHN0
cmVhbSB3aWxsIGJlIG5vbi1OVUxMICovCiAJY29uc3Qgc3RydWN0IGRjX3N0cmVhbSAqc3RyZWFt
OworCXN0cnVjdCBkcm1fcGVuZGluZ192YmxhbmtfZXZlbnQgKmV2ZW50OwogfTsKIAogc3RydWN0
IGFtZGdwdV9lbmNvZGVyX2F0b21fZGlnIHsKLS0gCjIuOS4zCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
