From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: add new sensor type for VCN powergate
 status V2
Date: Mon, 22 Jul 2019 14:59:34 +0800
Message-ID: <20190722065934.21608-1-evan.quan@amd.com>
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
Cc: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>, kenneth.feng-5C7GfCeVMHo@public.gmane.org

VkNOIGlzIHdpZGVseSB1c2VkIGluIG5ldyBBU0lDcyBhbmQgZGlmZmVyZW50IGZyb20gdHJhbmRp
dGlvbmFsClVWRCBhbmQgVkNFLgoKVjI6IGEgYmV0dGVyIG5hbWluZwoKQ2hhbmdlLUlkOiBJMzVj
OWRiNDIwNzM0MDI5ZThmODQ3ZGNkY2UyM2RmZjEyMDRkNzBiYwpTaWduZWQtb2ZmLWJ5OiBFdmFu
IFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVk
ZS9rZ2RfcHBfaW50ZXJmYWNlLmggfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2RfcHBfaW50ZXJm
YWNlLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUva2dkX3BwX2ludGVyZmFjZS5oCmlu
ZGV4IDk3MzNiYmY5YmM3Mi4uYTAyZmRlZTg4MWQzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2luY2x1ZGUva2dkX3BwX2ludGVyZmFjZS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvaW5jbHVkZS9rZ2RfcHBfaW50ZXJmYWNlLmgKQEAgLTEyMyw2ICsxMjMsNyBAQCBlbnVtIGFt
ZF9wcF9zZW5zb3JzIHsKIAlBTURHUFVfUFBfU0VOU09SX0VOQUJMRURfU01DX0ZFQVRVUkVTX01B
U0ssCiAJQU1ER1BVX1BQX1NFTlNPUl9NSU5fRkFOX1JQTSwKIAlBTURHUFVfUFBfU0VOU09SX01B
WF9GQU5fUlBNLAorCUFNREdQVV9QUF9TRU5TT1JfVkNOX1BPV0VSX1NUQVRFLAogfTsKIAogZW51
bSBhbWRfcHBfdGFzayB7Ci0tIAoyLjIyLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
