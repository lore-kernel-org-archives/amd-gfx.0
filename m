From: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu: fix debug level for ppt offset/size
Date: Thu, 15 Aug 2019 09:48:31 +0000
Message-ID: <20190815094815.20819-1-xiaojie.yuan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Yuan,
 Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogWGlhb2ppZSBZdWFuIDx4aWFvamllLnl1YW5AYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUuYyB8IDQgKystLQogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5jCmluZGV4IDM1ZmQ0NmJkZmM1My4uODJmNmI0MTM3
MThiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUuYwpAQCAtODMs
OCArODMsOCBAQCB2b2lkIGFtZGdwdV91Y29kZV9wcmludF9zbWNfaGRyKGNvbnN0IHN0cnVjdCBj
b21tb25fZmlybXdhcmVfaGVhZGVyICpoZHIpCiAJCWNvbnN0IHN0cnVjdCBzbWNfZmlybXdhcmVf
aGVhZGVyX3YyXzAgKnYyX2hkciA9CiAJCQljb250YWluZXJfb2YodjFfaGRyLCBzdHJ1Y3Qgc21j
X2Zpcm13YXJlX2hlYWRlcl92Ml8wLCB2MV8wKTsKIAotCQlEUk1fSU5GTygicHB0X29mZnNldF9i
eXRlczogJXVcbiIsIGxlMzJfdG9fY3B1KHYyX2hkci0+cHB0X29mZnNldF9ieXRlcykpOwotCQlE
Uk1fSU5GTygicHB0X3NpemVfYnl0ZXM6ICV1XG4iLCBsZTMyX3RvX2NwdSh2Ml9oZHItPnBwdF9z
aXplX2J5dGVzKSk7CisJCURSTV9ERUJVRygicHB0X29mZnNldF9ieXRlczogJXVcbiIsIGxlMzJf
dG9fY3B1KHYyX2hkci0+cHB0X29mZnNldF9ieXRlcykpOworCQlEUk1fREVCVUcoInBwdF9zaXpl
X2J5dGVzOiAldVxuIiwgbGUzMl90b19jcHUodjJfaGRyLT5wcHRfc2l6ZV9ieXRlcykpOwogCX0g
ZWxzZSB7CiAJCURSTV9FUlJPUigiVW5rbm93biBTTUMgdWNvZGUgdmVyc2lvbjogJXUuJXVcbiIs
IHZlcnNpb25fbWFqb3IsIHZlcnNpb25fbWlub3IpOwogCX0KLS0gCjIuMjAuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
