From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 76/87] drm/amd/display: drop ASSERT() if eDP panel is not
 connected
Date: Mon, 15 Jul 2019 17:20:38 -0400
Message-ID: <20190715212049.4584-77-sunpeng.li@amd.com>
References: <20190715212049.4584-1-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190715212049.4584-1-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Zhan Liu <zhan.liu-5C7GfCeVMHo@public.gmane.org>, Nicholas Kazlauskas <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>

RnJvbTogWmhhbiBMaXUgPHpoYW4ubGl1QGFtZC5jb20+CgpbV2h5XQpGb3IgYm9hcmRzIHRoYXQg
c3VwcG9ydCBlRFAgYnV0IGRvIG5vdCBoYXZlIGEgcGh5c2ljYWwgZURQCmRpc3BsYXkgY29ubmVj
dGVkIGFuIEFTU0VSVCB3aWxsIGJlIHRocm93bi4gVGhpcyBpcyBub3QgYQpjcml0aWNhbCBmYWls
dXJlIGFuZCBzaG91bGRuJ3QgYmUgdHJlYXRlZCBhcyBzdWNoLgoKW0hvd10KRHJvcCB0aGUgYXNz
ZXJ0aW9uLgoKU2lnbmVkLW9mZi1ieTogWmhhbiBMaXUgPHpoYW4ubGl1QGFtZC5jb20+ClJldmll
d2VkLWJ5OiBOaWNob2xhcyBLYXpsYXVza2FzIDxOaWNob2xhcy5LYXpsYXVza2FzQGFtZC5jb20+
CkFja2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMgfCAyIC0tCiAxIGZpbGUgY2hhbmdlZCwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvY29yZS9kY19saW5rLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9k
Y19saW5rLmMKaW5kZXggMTQyMmU3NGE1ZmZjLi40NjcwMTZkZGZiZTggMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMKQEAgLTU1Miw4ICs1NTIsNiBA
QCBzdGF0aWMgdm9pZCByZWFkX2VkcF9jdXJyZW50X2xpbmtfc2V0dGluZ3Nfb25fZGV0ZWN0KHN0
cnVjdCBkY19saW5rICpsaW5rKQogCQltc2xlZXAoOCk7CiAJfQogCi0JQVNTRVJUKHN0YXR1cyA9
PSBEQ19PSyk7Ci0KIAkvLyBSZWFkIERQQ0QgMDAxMDBoIHRvIGZpbmQgaWYgc3RhbmRhcmQgbGlu
ayByYXRlcyBhcmUgc2V0CiAJY29yZV9saW5rX3JlYWRfZHBjZChsaW5rLCBEUF9MSU5LX0JXX1NF
VCwKIAkJCSZsaW5rX2J3X3NldCwgc2l6ZW9mKGxpbmtfYndfc2V0KSk7Ci0tIAoyLjIyLjAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
