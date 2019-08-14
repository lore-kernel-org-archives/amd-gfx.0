From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/3] Add mode 2 GPU reset for RV2/Picasso
Date: Wed, 14 Aug 2019 15:53:31 -0400
Message-ID: <1565812414-26117-1-git-send-email-andrey.grodzovsky@amd.com>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, evan.quan-5C7GfCeVMHo@public.gmane.org, Shirish.S-5C7GfCeVMHo@public.gmane.org

VGhpcyBwYXRjaHNldCBhZGRzIG1vZGUgMiByZXNldCB0aHJvdWdoIFNNVSBmb3IgUlYyIGFuZCBQ
aWNhc3NvLgoKQW5kcmV5IEdyb2R6b3Zza3kgKDMpOgogIGRybS9hbWQvcG93ZXJwbGF5OiBGaXgg
bWVhbmluZyBvZiAweDFFIFBQU01DX01TRwogIGRybS9hbWQvcG93ZXJwbGF5OiBBZGQgc3VwcG9y
dCBmb3IgbW9kZTIgQVNJQyByZXNldC4KICBkcm0vYW1kZ3B1OiBVc2UgbmV3IG1vZGUyIHJlc2V0
IGludGVyZmFjZSBmb3IgUlYuCgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jICAgICAgICB8ICAxICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMg
ICAgICAgICAgICAgICAgfCAyMSArKysrKysrKysrKysrLS0tLS0tLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvaW5jbHVkZS9rZ2RfcHBfaW50ZXJmYWNlLmggICAgfCAgMSArCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMgICAgIHwgMjEgKysrKysrKysrKysrKysr
KysrKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXUxMF9od21nci5j
IHwgIDcgKysrKysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2h3bWdyLmgg
ICAgICAgICB8ICA5ICsrKysrKysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5j
L3J2X3Bwc21jLmggICAgICB8ICAyICstCiA3IGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMo
KyksIDkgZGVsZXRpb25zKC0pCgotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
