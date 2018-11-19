From: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Add missing firmware entry for HAINAN
Date: Mon, 19 Nov 2018 12:55:12 +0100
Message-ID: <20181119115512.18844-1-tiwai@suse.de>
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
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, David Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

RHVlIHRvIGxhY2sgb2YgTU9EVUxFX0ZJUk1XQVJFKCkgd2l0aCBoYWluYW5fbWMuYmluLCB0aGUg
ZHJpdmVyCmRvZXNuJ3Qgd29yayBwcm9wZXJseSBpbiBpbml0cmQuICBMZXQncyBhZGQgaXQuCgpC
dWd6aWxsYTogaHR0cHM6Ly9idWd6aWxsYS5zdXNlLmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTExNjIz
OQpGaXhlczogOGVhZjJiMWZhYWY0ICgiZHJtL2FtZGdwdTogc3dpdGNoIGZpcm13YXJlIHBhdGgg
Zm9yIFNJIHBhcnRzIikKQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPgpTaWduZWQtb2ZmLWJ5
OiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3Y2XzAuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y2XzAuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192Nl8wLmMKaW5kZXggZTFjMmI0ZTljN2IyLi43M2Fk
MDJhZWEyYjIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192Nl8w
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y2XzAuYwpAQCAtNDYsNiAr
NDYsNyBAQCBNT0RVTEVfRklSTVdBUkUoImFtZGdwdS90YWhpdGlfbWMuYmluIik7CiBNT0RVTEVf
RklSTVdBUkUoImFtZGdwdS9waXRjYWlybl9tYy5iaW4iKTsKIE1PRFVMRV9GSVJNV0FSRSgiYW1k
Z3B1L3ZlcmRlX21jLmJpbiIpOwogTU9EVUxFX0ZJUk1XQVJFKCJhbWRncHUvb2xhbmRfbWMuYmlu
Iik7CitNT0RVTEVfRklSTVdBUkUoImFtZGdwdS9oYWluYW5fbWMuYmluIik7CiBNT0RVTEVfRklS
TVdBUkUoImFtZGdwdS9zaTU4X21jLmJpbiIpOwogCiAjZGVmaW5lIE1DX1NFUV9NSVNDMF9fTVRf
X01BU0sgICAweGYwMDAwMDAwCi0tIAoyLjE5LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
