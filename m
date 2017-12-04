From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH 1/2] drm/ttm: swap consecutive allocated cached pages v2
Date: Mon,  4 Dec 2017 13:12:32 +0100
Message-ID: <20171204121233.9164-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Hongbo.He@amd.com, ckoenig.leichtzumerken@gmail.com
List-Id: amd-gfx.lists.freedesktop.org

V2hlbiB3ZSBkZXRlY3QgY29uc2VjdXRpdmUgYWxsb2NhdGlvbiBvZiBwYWdlcyBzd2FwIHRoZW0g
dG8gYXZvaWQKYWNjaWRlbnRhbGx5IGZyZWVpbmcgdGhlbSBhcyBodWdlIHBhZ2UuCgp2MjogdXNl
IHN3YXAKClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMgfCA0ICsr
KysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9w
YWdlX2FsbG9jLmMKaW5kZXggYzgyZDk0Y2JiYWJjLi5iNmM1MTQ4NjA3ZTkgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2MuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMKQEAgLTkyMSw2ICs5MjEsMTAgQEAgc3RhdGljIGludCB0
dG1fZ2V0X3BhZ2VzKHN0cnVjdCBwYWdlICoqcGFnZXMsIHVuc2lnbmVkIG5wYWdlcywgaW50IGZs
YWdzLAogCQkJCXJldHVybiAtRU5PTUVNOwogCQkJfQogCisJCQkvKiBTd2FwIHRoZSBwYWdlcyBp
ZiB3ZSBkZXRlY3QgY29uc2VjdXRpdmUgb3JkZXIgKi8KKwkJCWlmIChpICYmIHBhZ2VzW2kgLSAx
XSA9PSBwIC0gMSkKKwkJCQlzd2FwKHAsIHBhZ2VzW2kgLSAxXSk7CisKIAkJCXBhZ2VzW2krK10g
PSBwOwogCQkJLS1ucGFnZXM7CiAJCX0KLS0gCjIuMTEuMAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
