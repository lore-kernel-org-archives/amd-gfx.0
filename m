From: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/6] drm: fourcc byteorder: adapt bochs-drm to
 drm_mode_legacy_fb_format update
Date: Mon, 24 Apr 2017 08:25:30 +0200
Message-ID: <20170424062532.26722-5-kraxel@redhat.com>
References: <20170424062532.26722-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170424062532.26722-1-kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ilia Mirkin <imirkin-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

U2lnbmVkLW9mZi1ieTogR2VyZCBIb2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2JvY2hzL2JvY2hzX21tLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
Ym9jaHMvYm9jaHNfbW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9ib2Nocy9ib2Noc19tbS5jCmluZGV4
IDg1Nzc1NWFjMmQuLjc4MWQzNWJkZmYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9ib2No
cy9ib2Noc19tbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9ib2Nocy9ib2Noc19tbS5jCkBAIC01
MDgsNyArNTA4LDcgQEAgYm9jaHNfdXNlcl9mcmFtZWJ1ZmZlcl9jcmVhdGUoc3RydWN0IGRybV9k
ZXZpY2UgKmRldiwKIAkgICAgICAgKG1vZGVfY21kLT5waXhlbF9mb3JtYXQgPj4gMTYpICYgMHhm
ZiwKIAkgICAgICAgKG1vZGVfY21kLT5waXhlbF9mb3JtYXQgPj4gMjQpICYgMHhmZik7CiAKLQlp
ZiAobW9kZV9jbWQtPnBpeGVsX2Zvcm1hdCAhPSBEUk1fRk9STUFUX1hSR0I4ODg4KQorCWlmICht
b2RlX2NtZC0+cGl4ZWxfZm9ybWF0ICE9IERSTV9GT1JNQVRfQ1BVX1hSR0I4ODg4KQogCQlyZXR1
cm4gRVJSX1BUUigtRU5PRU5UKTsKIAogCW9iaiA9IGRybV9nZW1fb2JqZWN0X2xvb2t1cChmaWxw
LCBtb2RlX2NtZC0+aGFuZGxlc1swXSk7Ci0tIAoyLjkuMwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
