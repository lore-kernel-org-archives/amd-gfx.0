From: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/1] drm/amdgpu: fix no ACK from LDS read during stress test
 for Arcturus
Date: Wed, 30 Oct 2019 17:02:11 +0800
Message-ID: <1572426131-16337-1-git-send-email-le.ma@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>, jay.cornwall-5C7GfCeVMHo@public.gmane.org, hawking.zhang-5C7GfCeVMHo@public.gmane.org

U2V0IG1tU1FfQ09ORklHLkRJU0FCTEVfU01FTV9TT0ZUX0NMQVVTRSBhcyBXL1IuCgpDaGFuZ2Ut
SWQ6IEk2MjI1OTA5ZmQ2MjcwMjQyN2ZiYjgwN2UwYzZiYTZiYWZjZmE0MWQ1ClNpZ25lZC1vZmYt
Ynk6IExlIE1hIDxsZS5tYUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92OV8wLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCmluZGV4IDVlN2EwMWMuLjA3OTYyY2EgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwpAQCAtNjk5LDYgKzY5OSw3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qgc29jMTVfcmVnX2dvbGRlbiBnb2xkZW5fc2V0dGluZ3NfZ2NfOV80XzFf
YXJjdFtdID0KIAlTT0MxNV9SRUdfR09MREVOX1ZBTFVFKEdDLCAwLCBtbVRDUF9DSEFOX1NURUVS
XzNfQVJDVCwgMHgzZmZmZmZmZiwgMHgyZWJkOWZlMyksCiAJU09DMTVfUkVHX0dPTERFTl9WQUxV
RShHQywgMCwgbW1UQ1BfQ0hBTl9TVEVFUl80X0FSQ1QsIDB4M2ZmZmZmZmYsIDB4YjkwZjViMSks
CiAJU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1UQ1BfQ0hBTl9TVEVFUl81X0FSQ1Qs
IDB4M2ZmLCAweDEzNSksCisJU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1TUV9DT05G
SUcsIDB4ZmZmZmZmZmYsIDB4MDExQTAwMDApLAogfTsKIAogc3RhdGljIGNvbnN0IHUzMiBHRlhf
UkxDX1NSTV9JTkRFWF9DTlRMX0FERFJfT0ZGU0VUU1tdID0KLS0gCjIuNy40CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
