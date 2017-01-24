From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: fix 64bit shift for CZ
Date: Tue, 24 Jan 2017 15:09:33 +0100
Message-ID: <1485266973-1664-2-git-send-email-deathsimple@vodafone.de>
References: <1485266973-1664-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1485266973-1664-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKRml4ZXMg
ImFjY2VzcyBzdG9sZW4gVlJBTSBkaXJlY3RseSBvbiBDWiIsIG90aGVyd2lzZSB0aGF0IHdvbid0
CndvcmsgYXMgZXhwZWN0ZWQgd2l0aCBtb3JlIHRoYW4gNEdCIFJBTS4KClNpZ25lZC1vZmYtYnk6
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjhfMC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ21jX3Y4XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192
OF8wLmMKaW5kZXggYTU2NGU4OS4uNzY2OWIzMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ21jX3Y4XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjhfMC5jCkBAIC00NzAsNyArNDcwLDcgQEAgc3RhdGljIGludCBnbWNfdjhfMF9tY19pbml0
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCiAjaWZkZWYgQ09ORklHX1g4Nl82NAogCWlm
IChhZGV2LT5mbGFncyAmIEFNRF9JU19BUFUpIHsKLQkJYWRldi0+bWMuYXBlcl9iYXNlID0gUlJF
RzMyKG1tTUNfVk1fRkJfT0ZGU0VUKSA8PCAyMlVMTDsKKwkJYWRldi0+bWMuYXBlcl9iYXNlID0g
KCh1NjQpUlJFRzMyKG1tTUNfVk1fRkJfT0ZGU0VUKSkgPDwgMjI7CiAJCWFkZXYtPm1jLmFwZXJf
c2l6ZSA9IGFkZXYtPm1jLnJlYWxfdnJhbV9zaXplOwogCX0KICNlbmRpZgotLSAKMi41LjAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
