From: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amd/powerplay: add one smc message for Vega10
Date: Thu, 19 Oct 2017 15:14:58 -0400
Message-ID: <1508440499-19321-2-git-send-email-JinHuiEric.Huang@amd.com>
References: <1508440499-19321-1-git-send-email-JinHuiEric.Huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1508440499-19321-1-git-send-email-JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>

VGhpcyBpcyB1c2VkIHRvIGZpeCBwZXJmb3JtYW5jZSBkcm9wIGNhdXNlZCBieSB1cGRhdGVkIFNN
VSBGVy4KClNpZ25lZC1vZmYtYnk6IEVyaWMgSHVhbmcgPEppbkh1aUVyaWMuSHVhbmdAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvdmVnYTEwX3Bwc21jLmgg
fCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy92ZWdhMTBfcHBz
bWMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy92ZWdhMTBfcHBzbWMuaApp
bmRleCBkMDZlY2U0Li4yNDdjOTczIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9pbmMvdmVnYTEwX3Bwc21jLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvaW5jL3ZlZ2ExMF9wcHNtYy5oCkBAIC0xMzEsNyArMTMxLDggQEAgdHlwZWRlZiB1aW50
MTZfdCBQUFNNQ19SZXN1bHQ7CiAjZGVmaW5lIFBQU01DX01TR19SdW5BY2dJbk9wZW5Mb29wICAg
ICAgICAgICAgICAgMHg1RQogI2RlZmluZSBQUFNNQ19NU0dfSW5pdGlhbGl6ZUFjZyAgICAgICAg
ICAgICAgICAgIDB4NUYKICNkZWZpbmUgUFBTTUNfTVNHX0dldEN1cnJQa2dQd3IgICAgICAgICAg
ICAgICAgICAweDYxCi0jZGVmaW5lIFBQU01DX01lc3NhZ2VfQ291bnQgICAgICAgICAgICAgICAg
ICAgICAgMHg2MgorI2RlZmluZSBQUFNNQ19NU0dfVXBkYXRlUGtnUHdyUGlkQWxwaGEgICAgICAg
ICAgIDB4NjgKKyNkZWZpbmUgUFBTTUNfTWVzc2FnZV9Db3VudCAgICAgICAgICAgICAgICAgICAg
ICAweDY5CiAKIAogdHlwZWRlZiBpbnQgUFBTTUNfTXNnOwotLSAKMi43LjQKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
