From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH 1/4] drm/ttm: don't use compound pages for now
Date: Tue, 10 Oct 2017 10:53:42 +0200
Message-ID: <1507625625-8665-1-git-send-email-deathsimple@vodafone.de>
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
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKV2UgbmVl
ZCB0byBmaWd1cmUgb3V0IGZpcnN0IGhvdyB0byBjb3JyZWN0bHkgbWFwIHRoZW0gaW50byB0aGUg
Q1BVIHBhZ2UgdGFibGVzLgoKYnVnOiBodHRwczovL2J1Z3MuZnJlZWRlc2t0b3Aub3JnL3Nob3df
YnVnLmNnaT9pZD0xMDMxMzgKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxs
b2NfZG1hLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2NfZG1hLmMgYi9kcml2ZXJzL2dw
dS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jX2RtYS5jCmluZGV4IGU1ZWYxMGQuLjk2YWQxMjkgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2NfZG1hLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9hbGxvY19kbWEuYwpAQCAtOTEzLDYgKzkxMyw3
IEBAIHN0YXRpYyBnZnBfdCB0dG1fZG1hX3Bvb2xfZ2ZwX2ZsYWdzKHN0cnVjdCB0dG1fZG1hX3R0
ICp0dG1fZG1hLCBib29sIGh1Z2UpCiAJaWYgKGh1Z2UpIHsKIAkJZ2ZwX2ZsYWdzIHw9IEdGUF9U
UkFOU0hVR0U7CiAJCWdmcF9mbGFncyAmPSB+X19HRlBfTU9WQUJMRTsKKwkJZ2ZwX2ZsYWdzICY9
IH5fX0dGUF9DT01QOwogCX0KIAogCXJldHVybiBnZnBfZmxhZ3M7Ci0tIAoyLjcuNAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxp
bmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
