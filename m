From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu] Remove unused lut_r/g/b arrays from
 drmmode_crtc_private_rec
Date: Wed, 17 Aug 2016 18:58:21 +0900
Message-ID: <20160817095821.15018-1-michel@daenzer.net>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpGaXhlczogMTA5
MWYyOGUxZmEyICgiUmVtb3ZlIGRybW1vZGVfbG9hZF9wYWxldHRlIikKU2lnbmVkLW9mZi1ieTog
TWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Ci0tLQogc3JjL2RybW1vZGVf
ZGlzcGxheS5oIHwgMSAtCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL3NyYy9kcm1tb2RlX2Rpc3BsYXkuaCBiL3NyYy9kcm1tb2RlX2Rpc3BsYXkuaAppbmRleCA2
MTdmMmJjLi4yZTYyYThjIDEwMDY0NAotLS0gYS9zcmMvZHJtbW9kZV9kaXNwbGF5LmgKKysrIGIv
c3JjL2RybW1vZGVfZGlzcGxheS5oCkBAIC05Miw3ICs5Miw2IEBAIHR5cGVkZWYgc3RydWN0IHsK
IAl1aW50MzJfdCBkcG1zX2xhc3Rfc2VxOwogCWludCBkcG1zX2xhc3RfZnBzOwogCXVpbnQzMl90
IGludGVycG9sYXRlZF92YmxhbmtzOwotCXVpbnQxNl90IGx1dF9yWzI1Nl0sIGx1dF9nWzI1Nl0s
IGx1dF9iWzI1Nl07CiAJaW50IHByaW1lX3BpeG1hcF94OwogCiAJLyogTW9kZXNldCBuZWVkZWQg
Zm9yIERQTVMgb24gKi8KLS0gCjIuOS4zCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
