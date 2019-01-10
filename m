From: Lyude Paul <lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 12/20] drm/nouveau: Remove bogus cleanup in
 nv50_mstm_add_connector()
Date: Thu, 10 Jan 2019 14:57:46 -0500
Message-ID: <20190110195753.6234-13-lyude@redhat.com>
References: <20190110195753.6234-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190110195753.6234-1-lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Jerry Zuo <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, David Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Juston Li <juston.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

VHJ5aW5nIHRvIGRlc3Ryb3kgdGhlIGNvbm5lY3RvciB1c2luZyBtc3RjLT5jb25uZWN0b3IuZnVu
Y3MtPmRlc3Ryb3koKQppZiBjb25uZWN0b3IgaW5pdGlhbGl6YXRpb24gZmFpbHMgaXMgd3Jvbmc6
IHRoZXJlIGlzIG5vIHBvc3NpYmxlCmNvZGVwYXRoIGluIG52NTBfbXN0Y19uZXcgd2hlcmUgbnY1
MF9tc3RtX2FkZF9jb25uZWN0b3IoKSB3b3VsZCByZXR1cm4KPDAgYW5kIG1zdGMgd291bGQgYmUg
bm9uLU5VTEwuCgpTaWduZWQtb2ZmLWJ5OiBMeXVkZSBQYXVsIDxseXVkZUByZWRoYXQuY29tPgpD
YzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogRGF2aWQgQWlybGllIDxhaXJs
aWVkQHJlZGhhdC5jb20+CkNjOiBKZXJyeSBadW8gPEplcnJ5Llp1b0BhbWQuY29tPgpDYzogSGFy
cnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CkNjOiBKdXN0b24gTGkgPGp1c3Rv
bi5saUBpbnRlbC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvZGlzcG52NTAvZGlz
cC5jIHwgNSArLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L2Rpc3BudjUwL2Rpc3Au
YyBiL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L2Rpc3BudjUwL2Rpc3AuYwppbmRleCBiYzA2YWE3
OTM2M2YuLjgwMDIxM2JlNzZlYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL25vdXZlYXUv
ZGlzcG52NTAvZGlzcC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L2Rpc3BudjUwL2Rp
c3AuYwpAQCAtMTA5OCwxMSArMTA5OCw4IEBAIG52NTBfbXN0bV9hZGRfY29ubmVjdG9yKHN0cnVj
dCBkcm1fZHBfbXN0X3RvcG9sb2d5X21nciAqbWdyLAogCWludCByZXQ7CiAKIAlyZXQgPSBudjUw
X21zdGNfbmV3KG1zdG0sIHBvcnQsIHBhdGgsICZtc3RjKTsKLQlpZiAocmV0KSB7Ci0JCWlmICht
c3RjKQotCQkJbXN0Yy0+Y29ubmVjdG9yLmZ1bmNzLT5kZXN0cm95KCZtc3RjLT5jb25uZWN0b3Ip
OworCWlmIChyZXQpCiAJCXJldHVybiBOVUxMOwotCX0KIAogCXJldHVybiAmbXN0Yy0+Y29ubmVj
dG9yOwogfQotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
