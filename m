From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/3] drm/amdgpu: implement raster configuration
Date: Sun, 18 Sep 2016 10:36:47 +0800
Message-ID: <1474166210-21736-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

SGkgYWxsLAoKVGhpcyBwYXRjaCBzZXQgaXMgdG8gaW50cm9kdWNlIHRoZSByYXN0ZXIgY29uZmln
dXJhdGlvbiBmb3IgYWxsIGdmeApnZW5lcmF0aW9ucy4KClRoYW5rcywKUnVpCgpIdWFuZyBSdWkg
KDMpOgogIGRybS9hbWRncHU6IGltcGxlbWVudCByYXN0ZXIgY29uZmlndXJhdGlvbiBmb3IgZ2Z4
IHY2CiAgZHJtL2FtZGdwdTogaW1wbGVtZW50IHJhc3RlciBjb25maWd1cmF0aW9uIGZvciBnZngg
djcKICBkcm0vYW1kZ3B1OiBpbXBsZW1lbnQgcmFzdGVyIGNvbmZpZ3VyYXRpb24gZm9yIGdmeCB2
OAoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Npa2QuaCAgICAgICAgICAgICB8ICAzNiAr
KysrKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92Nl8wLmMgICAgICAgICB8IDEz
MyArKysrKysrKysrKysrKysrKysrLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y3
XzAuYyAgICAgICAgIHwgMTYwICsrKysrKysrKysrKysrKysrKysrKysrLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyAgICAgICAgIHwgMTY4ICsrKysrKysrKysrKysrKysr
KysrKysrKystCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aWQuaCAgICAgICAgICAgICAg
fCAgMzcgKysrKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXNpY19yZWcvc2kvc2lk
LmggfCAgMzUgKysrKysrCiA2IGZpbGVzIGNoYW5nZWQsIDU2NiBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQoKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
