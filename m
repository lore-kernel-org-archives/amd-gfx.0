From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/2] drm/amdgpu: Replace ttm_bo_reference with ttm_bo_get
Date: Tue, 31 Jul 2018 09:12:35 +0200
Message-ID: <20180731071236.3707-2-tzimmermann@suse.de>
References: <20180731071236.3707-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180731071236.3707-1-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>
List-Id: amd-gfx.lists.freedesktop.org

VGhlIGZ1bmN0aW9uIHR0bV9ib19nZXQgYWNxdWlyZXMgYSByZWZlcmVuY2Ugb24gYSBUVE0gYnVm
ZmVyIG9iamVjdC4gVGhlCmZ1bmN0aW9uJ3MgbmFtZSBpcyBtb3JlIGFsaWduZWQgdG8gdGhlIExp
bnV4IGtlcm5lbCBjb252ZW50aW9uIG9mIG5hbWluZwpyZWYtY291bnRpbmcgZnVuY3Rpb24gX2dl
dCBhbmQgX3B1dC4KCnYyOgogKiBjaGFuZ2VkIHByZWZpeCB0byBkcm0vYW1kZ3B1CgpTaWduZWQt
b2ZmLWJ5OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgfCAyICstCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKaW5kZXggYjEyNTI2Y2UxYTlkLi5mNTRkMzAxODZmZDYg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKQEAgLTgyMyw3
ICs4MjMsNyBAQCBzdHJ1Y3QgYW1kZ3B1X2JvICphbWRncHVfYm9fcmVmKHN0cnVjdCBhbWRncHVf
Ym8gKmJvKQogCWlmIChibyA9PSBOVUxMKQogCQlyZXR1cm4gTlVMTDsKIAotCXR0bV9ib19yZWZl
cmVuY2UoJmJvLT50Ym8pOworCXR0bV9ib19nZXQoJmJvLT50Ym8pOwogCXJldHVybiBibzsKIH0K
IAotLSAKMi4xOC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2
ZWwK
