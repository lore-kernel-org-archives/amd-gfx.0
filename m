From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/3] Enable Scatter Gather for Picasso.
Date: Tue, 23 Jul 2019 12:04:08 -0400
Message-ID: <1563897851-11501-1-git-send-email-andrey.grodzovsky@amd.com>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, hersenxs.wu-5C7GfCeVMHo@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org, shirish.s-5C7GfCeVMHo@public.gmane.org

VGhpcyBzZXJpZXMgZW5hYmxlcyBTL0cgZm9yIFBpY2Fzc28uCkZpcnN0IDIgcGF0Y2hlcyBmaXgg
YSBoYXJkIGhhbmcgaW50cm9kdWNlZCBieSBwbGFjaW5nIHRoZSBkaXNwbGF5CkJPIGluIEdUVCBt
ZW1vcnkgYmVjYXVzZSBvZiBIVyBpc3N1ZXMgd2l0aCBjYWNoZWQgbWFwcGluZ3MKYW5kIHRoZSB0
aGlyZCBwYXRjaCBlbmFibGVzIFMvRy4KCkFuZHJleSBHcm9kem92c2t5ICgyKToKICBkcm0vYW1k
Z3B1OiBGaXggaGFyZCBoYW5nIGZvciBTL0cgZGlzcGxheSBCT3MuCiAgZHJtL2FtZC9kaXNwbGF5
OiBPbmx5IGFsbG93IHMvZyB3aGVuIFVTV0MgZmxhZyBpcyBzZXQuCgpTaGlyaXNoIFMgKDEpOgog
IGRybS9hbWQ6IGVuYWJsZSBTL0cgZm9yIFJBVkVOIGNoaXAKCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGlzcGxheS5jICAgICAgIHwgIDIgKy0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9mYi5jICAgICAgICAgICAgfCAxNCArKysrKysrKysrKy0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jICAgICAgICAgICB8ICA0ICsrKy0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAgNCAr
Ky0tCiA0IGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgot
LSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
