From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/4] drm/amdgpu: Remove flip_flag from amdgpu_crtc
Date: Mon, 16 Jan 2017 10:44:56 -0500
Message-ID: <1484581498-32309-3-git-send-email-Andrey.Grodzovsky@amd.com>
References: <1484581498-32309-1-git-send-email-Andrey.Grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1484581498-32309-1-git-send-email-Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Harry.Wentland-5C7GfCeVMHo@public.gmane.org

Rm9sbHdpbmcgaW50cm9kdWN0aW9uIG9mIHBmbGlwX2ZsYWdzIGluIGRybV9wbGFuZV9zdGF0ZQp0
aGlzIGlzIG5vdCBuZWVkZWQgYW55bW9yZS4KClNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92
c2t5IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9tb2RlLmggfCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21vZGUuaCBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tb2RlLmgKaW5kZXggNGMwYTg2ZS4u
M2ZmM2MxNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21v
ZGUuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW9kZS5oCkBAIC00
NDMsNyArNDQzLDYgQEAgc3RydWN0IGFtZGdwdV9jcnRjIHsKIAllbnVtIGFtZGdwdV9pbnRlcnJ1
cHRfc3RhdGUgdnN5bmNfdGltZXJfZW5hYmxlZDsKIAogCWludCBvdGdfaW5zdDsKLQl1aW50MzJf
dCBmbGlwX2ZsYWdzOwogCS8qIEFmdGVyIFNldCBNb2RlIHRhcmdldCB3aWxsIGJlIG5vbi1OVUxM
ICovCiAJc3RydWN0IGRjX3RhcmdldCAqdGFyZ2V0OwogfTsKLS0gCjEuOS4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
