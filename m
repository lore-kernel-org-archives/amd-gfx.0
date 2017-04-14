From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix to print incorrect wptr address
Date: Fri, 14 Apr 2017 10:50:03 +0800
Message-ID: <1492138203-24349-1-git-send-email-ray.huang@amd.com>
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
Cc: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2Rt
YV92NF8wLmMKaW5kZXggZGE0NTU5Yi4uNDczNjE5NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc2RtYV92NF8wLmMKQEAgLTMyNiw4ICszMjYsOCBAQCBzdGF0aWMgdm9pZCBzZG1hX3Y0XzBf
cmluZ19zZXRfd3B0cihzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCiAJCQkJIm1tU0RNQSVpX0dG
WF9SQl9XUFRSID09IDB4JTA4eCAiCiAJCQkJIm1tU0RNQSVpX0dGWF9SQl9XUFRSX0hJID09IDB4
JTA4eCBcbiIsCiAJCQkJbWUsCi0JCQkJbWUsCiAJCQkJbG93ZXJfMzJfYml0cyhyaW5nLT53cHRy
IDw8IDIpLAorCQkJCW1lLAogCQkJCXVwcGVyXzMyX2JpdHMocmluZy0+d3B0ciA8PCAyKSk7CiAJ
CVdSRUczMihzZG1hX3Y0XzBfZ2V0X3JlZ19vZmZzZXQobWUsIG1tU0RNQTBfR0ZYX1JCX1dQVFIp
LCBsb3dlcl8zMl9iaXRzKHJpbmctPndwdHIgPDwgMikpOwogCQlXUkVHMzIoc2RtYV92NF8wX2dl
dF9yZWdfb2Zmc2V0KG1lLCBtbVNETUEwX0dGWF9SQl9XUFRSX0hJKSwgdXBwZXJfMzJfYml0cyhy
aW5nLT53cHRyIDw8IDIpKTsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
