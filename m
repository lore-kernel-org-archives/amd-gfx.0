From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH 3/6] drm/ttm: move initializing ttm->sg into ttm_tt_init_fields
Date: Tue,  6 Mar 2018 15:43:44 +0100
Message-ID: <20180306144347.1702-3-christian.koenig@amd.com>
References: <20180306144347.1702-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180306144347.1702-1-christian.koenig@amd.com>
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

QmV0dGVyIHRvIHNldCB0aGlzIHdpdGggYWxsIG90aGVyIGZpZWxkcyBhcyB3ZWxsLgoKU2lnbmVk
LW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3R0LmMgfCA0ICstLS0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vdHRtL3R0bV90dC5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fdHQuYwppbmRleCA2NTk3
NjIzOGQyNGIuLjdlNjcyYmU5ODdiNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90
dG1fdHQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV90dC5jCkBAIC03Nyw5ICs3Nyw2
IEBAIGludCB0dG1fdHRfY3JlYXRlKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sIGJvb2wg
emVyb19hbGxvYykKIAlpZiAodW5saWtlbHkoYm8tPnR0bSA9PSBOVUxMKSkKIAkJcmV0dXJuIC1F
Tk9NRU07CiAKLQlpZiAoYm8tPnR5cGUgPT0gdHRtX2JvX3R5cGVfc2cpCi0JCWJvLT50dG0tPnNn
ID0gYm8tPnNnOwotCiAJcmV0dXJuIDA7CiB9CiAKQEAgLTI0NSw2ICsyNDIsNyBAQCB2b2lkIHR0
bV90dF9pbml0X2ZpZWxkcyhzdHJ1Y3QgdHRtX3R0ICp0dG0sIHN0cnVjdCB0dG1fYnVmZmVyX29i
amVjdCAqYm8sCiAJdHRtLT5wYWdlX2ZsYWdzID0gcGFnZV9mbGFnczsKIAl0dG0tPnN0YXRlID0g
dHRfdW5wb3B1bGF0ZWQ7CiAJdHRtLT5zd2FwX3N0b3JhZ2UgPSBOVUxMOworCXR0bS0+c2cgPSBi
by0+c2c7CiB9CiAKIGludCB0dG1fdHRfaW5pdChzdHJ1Y3QgdHRtX3R0ICp0dG0sIHN0cnVjdCB0
dG1fYnVmZmVyX29iamVjdCAqYm8sCi0tIAoyLjE0LjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
