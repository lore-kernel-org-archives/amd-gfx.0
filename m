From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/7] drm/dp-mst: Use connector kdev as aux device parent
Date: Thu, 16 May 2019 11:17:59 -0400
Message-ID: <1558019883-12397-4-git-send-email-sunpeng.li@amd.com>
References: <1558019883-12397-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1558019883-12397-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

RnJvbTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CgpQbGFjaW5nIHRoZSBNU1QgYXV4IGRl
dmljZSBhcyBhIGNoaWxkIG9mIHRoZSBjb25uZWN0b3IgZ2l2ZXMgdWRldiB0aGUKYWJpbGl0eSB0
byBhY2Nlc3MgdGhlIGNvbm5lY3RvciBkZXZpY2UncyBhdHRyaWJ1dGVzLiBUaGlzIHdpbGwgY29t
ZSBpbgpoYW5keSB3aGVuIHdyaXRpbmcgdWRldiBydWxlcyB0byBjcmVhdGUgbW9yZSBkZXNjcmlw
dGl2ZSBzeW1saW5rcyB0byB0aGUKTVNUIGF1eCBkZXZpY2VzLgoKQ2M6IFZpbGxlIFN5cmrDpGzD
pCA8dmlsbGUuc3lyamFsYUBsaW51eC5pbnRlbC5jb20+CkNjOiBMeXVkZSBQYXVsIDxseXVkZUBy
ZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jIHwgMyArKysKIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJt
X2RwX21zdF90b3BvbG9neS5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3ku
YwppbmRleCA1NGRhNjhlLi5jZDJmM2M0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJt
X2RwX21zdF90b3BvbG9neS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHBfbXN0X3RvcG9s
b2d5LmMKQEAgLTEyNjksNiArMTI2OSw5IEBAIHN0YXRpYyB2b2lkIGRybV9kcF9hZGRfcG9ydChz
dHJ1Y3QgZHJtX2RwX21zdF9icmFuY2ggKm1zdGIsCiAJCX0KIAkJKCptc3RiLT5tZ3ItPmNicy0+
cmVnaXN0ZXJfY29ubmVjdG9yKShwb3J0LT5jb25uZWN0b3IpOwogCisJCWlmIChwb3J0LT5jb25u
ZWN0b3ItPnJlZ2lzdHJhdGlvbl9zdGF0ZSA9PSBEUk1fQ09OTkVDVE9SX1JFR0lTVEVSRUQpCisJ
CQlwb3J0LT5hdXguZGV2ID0gcG9ydC0+Y29ubmVjdG9yLT5rZGV2OworCiAJCWRybV9kcF9hdXhf
cmVnaXN0ZXJfZGV2bm9kZSgmcG9ydC0+YXV4KTsKIAl9CiAKLS0gCjIuNy40CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
