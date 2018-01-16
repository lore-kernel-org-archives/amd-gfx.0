From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH v3] drm/amdgpu: Use new TTM flag to avoid OOM triggering.
Date: Tue, 16 Jan 2018 14:50:11 -0500
Message-ID: <1516132211-32035-1-git-send-email-andrey.grodzovsky@amd.com>
References: <4a3881f0-a656-e1fa-ad93-cfb7e24bbd9e@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <4a3881f0-a656-e1fa-ad93-cfb7e24bbd9e@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, felix.kuehling@amd.com
Cc: Hongbo.He@amd.com
List-Id: amd-gfx.lists.freedesktop.org

QXZvaWQgT09NIG9uIHN5YXRlbSBwYWdlcyBhbGxvY2F0aW9ucy4KCnYyOgpSZW1vdmUgbW9kZXBy
b2JlIHBhcmFtZXRlciwgbWFrZSB0aGlzIGJlaGF2aW91ciB0aGUgb25seSBvcHRpb24uCgp2MzoK
TW92ZSBzZXR0aW5nIG5vX3JldHJ5IGZsYWcgaW50byBhbWRncHVfdHRtX2luaXQuCgpTaWduZWQt
b2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCA0ICsrKysKIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdHRtLmMKaW5kZXggMjkwY2RmMC4uZDMyZjQ4MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uYwpAQCAtMTM4Nyw2ICsxMzg3LDEwIEBAIGludCBhbWRncHVfdHRtX2lu
aXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCXJldHVybiByOwogCX0KIAlhZGV2LT5t
bWFuLmluaXRpYWxpemVkID0gdHJ1ZTsKKworCS8qIFdlIG9wdCB0byBhdm9pZCBPT00gb24gc3lz
dGVtIHBhZ2VzIGFsbG9jYXRpb25zICovCisJYWRldi0+bW1hbi5iZGV2Lm5vX3JldHJ5ID0gdHJ1
ZTsKKwogCXIgPSB0dG1fYm9faW5pdF9tbSgmYWRldi0+bW1hbi5iZGV2LCBUVE1fUExfVlJBTSwK
IAkJCQlhZGV2LT5nbWMucmVhbF92cmFtX3NpemUgPj4gUEFHRV9TSElGVCk7CiAJaWYgKHIpIHsK
LS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
