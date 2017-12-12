From: Roger He <Hongbo.He@amd.com>
Subject: [PATCH 5/6] drm/ttm: enable eviction for Per-VM-BO
Date: Tue, 12 Dec 2017 17:33:47 +0800
Message-ID: <1513071228-29551-5-git-send-email-Hongbo.He@amd.com>
References: <1513071228-29551-1-git-send-email-Hongbo.He@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1513071228-29551-1-git-send-email-Hongbo.He@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Roger He <Hongbo.He@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Q2hhbmdlLUlkOiBJNDkxZDRjZWI4Yzk4YmIzZDhlNmUwZGRlZjIzMzAyODRjZTJmZTVmNgpTaWdu
ZWQtb2ZmLWJ5OiBSb2dlciBIZSA8SG9uZ2JvLkhlQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL3R0bS90dG1fYm8uYyB8IDcgKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0
bV9iby5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYwppbmRleCBlYjhjNTY4Li4yMmI2
Y2E1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS90dG0vdHRtX2JvLmMKQEAgLTcyMiwxMCArNzIyLDkgQEAgc3RhdGljIGludCB0
dG1fbWVtX2V2aWN0X2ZpcnN0KHN0cnVjdCB0dG1fYm9fZGV2aWNlICpiZGV2LAogCXNwaW5fbG9j
aygmZ2xvYi0+bHJ1X2xvY2spOwogCWZvciAoaSA9IDA7IGkgPCBUVE1fTUFYX0JPX1BSSU9SSVRZ
OyArK2kpIHsKIAkJbGlzdF9mb3JfZWFjaF9lbnRyeShibywgJm1hbi0+bHJ1W2ldLCBscnUpIHsK
LQkJCWlmIChiby0+cmVzdiA9PSByZXN2KSB7Ci0JCQkJaWYgKGxpc3RfZW1wdHkoJmJvLT5kZGVz
dHJveSkpCi0JCQkJCWNvbnRpbnVlOwotCQkJfSBlbHNlIHsKKwkJCWlmICghY3R4IHx8CisJCQkJ
IShjdHgtPm9uX2FsbG9jX3N0YWdlICYmCisJCQkJYm8tPnJlc3YgPT0gY3R4LT5yZXN2KSkgewog
CQkJCWxvY2tlZCA9IHJlc2VydmF0aW9uX29iamVjdF90cnlsb2NrKGJvLT5yZXN2KTsKIAkJCQlp
ZiAoIWxvY2tlZCkKIAkJCQkJY29udGludWU7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
