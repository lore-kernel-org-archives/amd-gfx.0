From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Fix bounds checking in amdgpu_ras_is_supported()
Date: Sat, 8 Jun 2019 12:23:57 +0300
Message-ID: <20190608092357.GB28890@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
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
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, xinhui pan <xinhui.pan-5C7GfCeVMHo@public.gmane.org>
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, James Zhu <James.Zhu-5C7GfCeVMHo@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

VGhlICJibG9jayIgdmFyaWFibGUgY2FuIGJlIHNldCBieSB0aGUgdXNlciB0aHJvdWdoIGRlYnVn
ZnMsIHNvIGl0IGNhbgpiZSBxdWl0ZSBsYXJnZSB3aGljaCBsZWFkcyB0byBzaGlmdCB3cmFwcGlu
ZyBoZXJlLiAgVGhpcyBtZWFucyB3ZSByZXBvcnQKYSAiYmxvY2siIGFzIHN1cHBvcnRlZCB3aGVu
IGl0J3Mgbm90LCBhbmQgdGhhdCBsZWFkcyB0byBhcnJheSBvdmVyZmxvd3MKbGF0ZXIgb24uCgpU
aGlzIGJ1ZyBpcyBub3QgcmVhbGx5IGEgc2VjdXJpdHkgaXNzdWUgaW4gcmVhbCBsaWZlLCBiZWNh
dXNlIGRlYnVnZnMgaXMKZ2VuZXJhbGx5IHJvb3Qgb25seS4KCkZpeGVzOiAzNmVhMWJkMmQwODQg
KCJkcm0vYW1kZ3B1OiBhZGQgZGVidWdmcyBjdHJsIG5vZGUiKQpTaWduZWQtb2ZmLWJ5OiBEYW4g
Q2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaAppbmRleCBjNmIz
NGZiZDY5NWYuLjk0YzY1MmY1MjY1YSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Jhcy5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yYXMuaApAQCAtMTczLDYgKzE3Myw4IEBAIHN0YXRpYyBpbmxpbmUgaW50IGFtZGdwdV9yYXNf
aXNfc3VwcG9ydGVkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogewogCXN0cnVjdCBhbWRn
cHVfcmFzICpyYXMgPSBhbWRncHVfcmFzX2dldF9jb250ZXh0KGFkZXYpOwogCisJaWYgKGJsb2Nr
ID49IEFNREdQVV9SQVNfQkxPQ0tfQ09VTlQpCisJCXJldHVybiAwOwogCXJldHVybiByYXMgJiYg
KHJhcy0+c3VwcG9ydGVkICYgKDEgPDwgYmxvY2spKTsKIH0KIAotLSAKMi4yMC4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
