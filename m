From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: cleanup useless extern functions
Date: Mon, 19 Dec 2016 17:55:10 +0800
Message-ID: <1482141310-9933-2-git-send-email-ray.huang@amd.com>
References: <1482141310-9933-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1482141310-9933-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS92aV9kcG0uaCB8IDQgLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmlf
ZHBtLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aV9kcG0uaAppbmRleCBmYzEyMGJh
Li5jNDNlMDNmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aV9kcG0u
aAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aV9kcG0uaApAQCAtMjksOCArMjks
NCBAQCBpbnQgY3pfc211X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwogaW50IGN6
X3NtdV9zdGFydChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CiBpbnQgY3pfc211X2Zpbmko
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwogCi1leHRlcm4gY29uc3Qgc3RydWN0IGFtZF9p
cF9mdW5jcyB0b25nYV9kcG1faXBfZnVuY3M7Ci1leHRlcm4gY29uc3Qgc3RydWN0IGFtZF9pcF9m
dW5jcyBmaWppX2RwbV9pcF9mdW5jczsKLWV4dGVybiBjb25zdCBzdHJ1Y3QgYW1kX2lwX2Z1bmNz
IGljZWxhbmRfZHBtX2lwX2Z1bmNzOwotCiAjZW5kaWYKLS0gCjIuNy40CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
