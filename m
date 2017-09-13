From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: [PATCH] drm/ttm: fix memory leak while individualizing BOs
Date: Wed, 13 Sep 2017 10:47:34 +0200
Message-ID: <1505292454-22259-1-git-send-email-deathsimple@vodafone.de>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKV2UgbmVl
ZCB0byBmcmVlIHRoZSByZXNlcnZhdGlvbiBvYmplY3QgYmVmb3JlIHdlIHRha2UgdGhlIEJPCmZy
b20gdGhlIGRlbGF5ZWQgZGVsZXRlIGxpc3QuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3R0bS90
dG1fYm8uYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90
dG1fYm8uYwppbmRleCBiZWU3N2QzLi5kNzk2MDdhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vdHRtL3R0bV9iby5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMKQEAgLTU1
Nyw2ICs1NTcsOCBAQCBzdGF0aWMgaW50IHR0bV9ib19jbGVhbnVwX3JlZnNfYW5kX3VubG9jayhz
dHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAogCX0KIAogCXR0bV9ib19kZWxfZnJvbV9scnUo
Ym8pOworCWlmICghbGlzdF9lbXB0eSgmYm8tPmRkZXN0cm95KSAmJiAoYm8tPnJlc3YgIT0gJmJv
LT50dG1fcmVzdikpCisJCXJlc2VydmF0aW9uX29iamVjdF9maW5pKCZiby0+dHRtX3Jlc3YpOwog
CWxpc3RfZGVsX2luaXQoJmJvLT5kZGVzdHJveSk7CiAJa3JlZl9wdXQoJmJvLT5saXN0X2tyZWYs
IHR0bV9ib19yZWZfYnVnKTsKIAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
