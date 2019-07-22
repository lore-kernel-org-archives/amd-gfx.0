From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/5] drm/amd/powerplay: add new sensor type for VCN powergate
 status
Date: Mon, 22 Jul 2019 11:15:27 +0800
Message-ID: <20190722031531.23437-2-evan.quan@amd.com>
References: <20190722031531.23437-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190722031531.23437-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

VkNOIGlzIHdpZGVseSB1c2VkIGluIG5ldyBBU0lDcyBhbmQgZGlmZmVyZW50IGZyb20gdHJhbmRp
dGlvbmFsClVWRCBhbmQgVkNFLgoKQ2hhbmdlLUlkOiBJMzVjOWRiNDIwNzM0MDI5ZThmODQ3ZGNk
Y2UyM2RmZjEyMDRkNzBiYwpTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2RfcHBfaW50ZXJmYWNlLmgg
fCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2RfcHBfaW50ZXJmYWNlLmggYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2luY2x1ZGUva2dkX3BwX2ludGVyZmFjZS5oCmluZGV4IDk3MzNiYmY5YmM3Mi4uMTU3
ZTg1NDY4NTVkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUva2dkX3Bw
X2ludGVyZmFjZS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2RfcHBfaW50
ZXJmYWNlLmgKQEAgLTEyMyw2ICsxMjMsNyBAQCBlbnVtIGFtZF9wcF9zZW5zb3JzIHsKIAlBTURH
UFVfUFBfU0VOU09SX0VOQUJMRURfU01DX0ZFQVRVUkVTX01BU0ssCiAJQU1ER1BVX1BQX1NFTlNP
Ul9NSU5fRkFOX1JQTSwKIAlBTURHUFVfUFBfU0VOU09SX01BWF9GQU5fUlBNLAorCUFNREdQVV9Q
UF9TRU5TT1JfVkNOX1BPV0VSLAogfTsKIAogZW51bSBhbWRfcHBfdGFzayB7Ci0tIAoyLjIyLjAK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
