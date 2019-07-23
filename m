From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] drm/amd/display: remove duplicated comparison
Date: Tue, 23 Jul 2019 14:32:19 +0100
Message-ID: <20190723133219.27877-1-colin.king@canonical.com>
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
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KClRoZSBjb21w
YXJpc29uIG9mIHN1cmZhY2VfcGl0Y2ggaXMgZHVwbGljYXRlZCBhbmQgaGVuY2Ugb25lIG9mIHRo
ZXNlCmNvbXBhcmlzb25zIGlzIHJlZHVuZGFudCBhbmQgY2FuIGJlIHJlbW92ZWQuICBSZW1vdmUg
aXQuCgpBZGRyZXNzZXMtQ292ZXJpdHk6ICgiU2FtZSBvbiBib3RoIHNpZGVzIikKRml4ZXM6IDEy
ZTJiMmQ0YzY1ZiAoImRybS9hbWQvZGlzcGxheTogYWRkIGRjYyBwcm9ncmFtbWluZyBmb3IgZHVh
bCBwbGFuZSIpClNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9u
aWNhbC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYyB8
IDEgLQogMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2NvcmUvZGMuYwppbmRleCA5NGYxMjZkMjMzMWMuLjE2OGY0YTdkZmZkZiAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCkBAIC0xMzc5LDcgKzEzNzks
NiBAQCBzdGF0aWMgZW51bSBzdXJmYWNlX3VwZGF0ZV90eXBlIGdldF9wbGFuZV9pbmZvX3VwZGF0
ZV90eXBlKGNvbnN0IHN0cnVjdCBkY19zdXJmYQogCX0KIAogCWlmICh1LT5wbGFuZV9pbmZvLT5w
bGFuZV9zaXplLnN1cmZhY2VfcGl0Y2ggIT0gdS0+c3VyZmFjZS0+cGxhbmVfc2l6ZS5zdXJmYWNl
X3BpdGNoCi0JCQl8fCB1LT5wbGFuZV9pbmZvLT5wbGFuZV9zaXplLnN1cmZhY2VfcGl0Y2ggIT0g
dS0+c3VyZmFjZS0+cGxhbmVfc2l6ZS5zdXJmYWNlX3BpdGNoCiAJCQl8fCB1LT5wbGFuZV9pbmZv
LT5wbGFuZV9zaXplLmNocm9tYV9waXRjaCAhPSB1LT5zdXJmYWNlLT5wbGFuZV9zaXplLmNocm9t
YV9waXRjaCkgewogCQl1cGRhdGVfZmxhZ3MtPmJpdHMucGxhbmVfc2l6ZV9jaGFuZ2UgPSAxOwog
CQllbGV2YXRlX3VwZGF0ZV90eXBlKCZ1cGRhdGVfdHlwZSwgVVBEQVRFX1RZUEVfTUVEKTsKLS0g
CjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
ZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
