From: Helen Koike <helen.koike@collabora.com>
Subject: [PATCH v3 2/5] drm/amd: fix fb references in async update
Date: Wed, 13 Mar 2019 21:20:23 -0300
Message-ID: <20190314002027.7833-3-helen.koike@collabora.com>
References: <20190314002027.7833-1-helen.koike@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190314002027.7833-1-helen.koike@collabora.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, nicholas.kazlauskas@amd.com
Cc: =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@google.com>, Sean Paul <seanpaul@google.com>, David Airlie <airlied@linux.ie>, daniel.vetter@ffwll.ch, David Francis <David.Francis@amd.com>, Mikita Lipski <mikita.lipski@amd.com>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Tomasz Figa <tfiga@chromium.org>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Leo Li <sunpeng.li@amd.com>, Helen Koike <helen.koike@collabora.com>, boris.brezillon@collabora.com, Alex Deucher <alexander.deucher@amd.com>, kernel@collabora.com, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

QXN5bmMgdXBkYXRlIGNhbGxiYWNrcyBhcmUgZXhwZWN0ZWQgdG8gc2V0IHRoZSBvbGRfZmIgaW4g
dGhlIG5ld19zdGF0ZQpzbyBwcmVwYXJlL2NsZWFudXAgZnJhbWVidWZmZXJzIGFyZSBiYWxhbmNl
ZC4KCkNhbGxpbmcgZHJtX2F0b21pY19zZXRfZmJfZm9yX3BsYW5lKCkgKHdoaWNoIGdldHMgYSBy
ZWZlcmVuY2Ugb2YgdGhlIG5ldwpmYiBhbmQgcHV0IHRoZSBvbGQgZmIpIGlzIG5vdCByZXF1aXJl
ZCwgYXMgaXQncyB0YWtlbiBjYXJlIGJ5CmRybV9tb2RlX2N1cnNvcl91bml2ZXJzYWwoKSB3aGVu
IGNhbGxpbmcgZHJtX2F0b21pY19oZWxwZXJfdXBkYXRlX3BsYW5lKCkuCgpTdWdnZXN0ZWQtYnk6
IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGNvbGxhYm9yYS5jb20+ClNpZ25lZC1v
ZmYtYnk6IEhlbGVuIEtvaWtlIDxoZWxlbi5rb2lrZUBjb2xsYWJvcmEuY29tPgpSZXZpZXdlZC1i
eTogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgoKLS0t
CgpDaGFuZ2VzIGluIHYzOiBOb25lCkNoYW5nZXMgaW4gdjI6Ci0gYWRkZWQgcmV2aWV3ZWQtYnkg
dGFnCgogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8
IDMgKy0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMK
aW5kZXggMmYyNjU4MWI5M2ZmLi5jZTRjY2QyOGFjNWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwpAQCAtMzc2MCw4ICszNzYwLDcg
QEAgc3RhdGljIHZvaWQgZG1fcGxhbmVfYXRvbWljX2FzeW5jX3VwZGF0ZShzdHJ1Y3QgZHJtX3Bs
YW5lICpwbGFuZSwKIAlzdHJ1Y3QgZHJtX3BsYW5lX3N0YXRlICpvbGRfc3RhdGUgPQogCQlkcm1f
YXRvbWljX2dldF9vbGRfcGxhbmVfc3RhdGUobmV3X3N0YXRlLT5zdGF0ZSwgcGxhbmUpOwogCi0J
aWYgKHBsYW5lLT5zdGF0ZS0+ZmIgIT0gbmV3X3N0YXRlLT5mYikKLQkJZHJtX2F0b21pY19zZXRf
ZmJfZm9yX3BsYW5lKHBsYW5lLT5zdGF0ZSwgbmV3X3N0YXRlLT5mYik7CisJc3dhcChwbGFuZS0+
c3RhdGUtPmZiLCBuZXdfc3RhdGUtPmZiKTsKIAogCXBsYW5lLT5zdGF0ZS0+c3JjX3ggPSBuZXdf
c3RhdGUtPnNyY194OwogCXBsYW5lLT5zdGF0ZS0+c3JjX3kgPSBuZXdfc3RhdGUtPnNyY195Owot
LSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
