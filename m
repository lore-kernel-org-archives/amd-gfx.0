From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: [PATCH 4/8] drm/amdgpu: remove 128 NOP hack from vm_flush
Date: Wed,  5 Oct 2016 16:13:25 +0200
Message-ID: <1475676809-3061-4-git-send-email-deathsimple@vodafone.de>
References: <1475676809-3061-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1475676809-3061-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKV2l0aCB0
aGUgcGFkZGluZyByYWlzZWQgdG8gMjU2IERXIHRoYXQgc2hvdWxkbid0IGJlIG5lZWRlZCBhbnkg
bW9yZS4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jIHwgNCAt
LS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y4XzAuYwppbmRleCA4ZWZkN2RiLi45MGJiNDUxIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OF8wLmMKQEAgLTYyNTMsMTAgKzYyNTMsNiBAQCBzdGF0aWMgdm9pZCBnZnhf
djhfMF9yaW5nX2VtaXRfdm1fZmx1c2goc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAogewogCWlu
dCB1c2VwZnAgPSAocmluZy0+dHlwZSA9PSBBTURHUFVfUklOR19UWVBFX0dGWCk7CiAKLQkvKiBH
Rlg4IGVtaXRzIDEyOCBkdyBub3AgdG8gcHJldmVudCBERSBkbyB2bV9mbHVzaCBiZWZvcmUgQ0Ug
ZmluaXNoIENFSUIgKi8KLQlpZiAodXNlcGZwKQotCQlhbWRncHVfcmluZ19pbnNlcnRfbm9wKHJp
bmcsIDEyOCk7Ci0KIAlhbWRncHVfcmluZ193cml0ZShyaW5nLCBQQUNLRVQzKFBBQ0tFVDNfV1JJ
VEVfREFUQSwgMykpOwogCWFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIChXUklURV9EQVRBX0VOR0lO
RV9TRUwodXNlcGZwKSB8CiAJCQkJIFdSSVRFX0RBVEFfRFNUX1NFTCgwKSkgfAotLSAKMi41LjAK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
