From: Roger.He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amd/amdgpu: decrease ttm bo priority number
Date: Tue, 28 Mar 2017 09:52:10 +0800
Message-ID: <1490665930-19814-2-git-send-email-Hongbo.He@amd.com>
References: <1490665930-19814-1-git-send-email-Hongbo.He@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490665930-19814-1-git-send-email-Hongbo.He-5C7GfCeVMHo@public.gmane.org>
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
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, "Roger.He" <Hongbo.He-5C7GfCeVMHo@public.gmane.org>

ZGVjcmVhc2UgYW5kIGFsc28gcmVzZXJ2ZSBwcmlvcml0eSBudW1iZXIgZm9yIEtGRCB1c2luZwoK
Q2hhbmdlLUlkOiBJOWUzNmQyOTJjOTIwYzAzNGRkY2E1M2QwZWMyODJjMTdiN2EzY2YxNgpTaWdu
ZWQtb2ZmLWJ5OiBSb2dlci5IZSA8SG9uZ2JvLkhlQGFtZC5jb20+ClJldmlld2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogaW5jbHVkZS9kcm0v
dHRtL3R0bV9ib19kcml2ZXIuaCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL3R0bS90dG1fYm9fZHJp
dmVyLmggYi9pbmNsdWRlL2RybS90dG0vdHRtX2JvX2RyaXZlci5oCmluZGV4IGMzZDc0YmUuLjc3
NzdkMTQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvZHJtL3R0bS90dG1fYm9fZHJpdmVyLmgKKysrIGIv
aW5jbHVkZS9kcm0vdHRtL3R0bV9ib19kcml2ZXIuaApAQCAtNDIsNyArNDIsNyBAQAogI2luY2x1
ZGUgPGxpbnV4L3NwaW5sb2NrLmg+CiAjaW5jbHVkZSA8bGludXgvcmVzZXJ2YXRpb24uaD4KIAot
I2RlZmluZSBUVE1fTUFYX0JPX1BSSU9SSVRZCTE2VQorI2RlZmluZSBUVE1fTUFYX0JPX1BSSU9S
SVRZCTRVCiAKIHN0cnVjdCB0dG1fYmFja2VuZF9mdW5jIHsKIAkvKioKLS0gCjIuNy40CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
