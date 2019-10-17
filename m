From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] drm/amdgpu/vi: silence an uninitialized variable warning
Date: Thu, 17 Oct 2019 12:12:16 +0300
Message-ID: <20191017091216.GA31278@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Rex Zhu <rex.zhu@amd.com>, Jim Qu <Jim.Qu@amd.com>
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

U21hdGNoIGNvbXBsYWlucyB0aGF0IHdlIG5lZWQgdG8gaW5pdGlhbGl6ZWQgIipjYXAiIG90aGVy
d2lzZSBpdCBjYW4KbGVhZCB0byBhbiB1bmluaXRpYWxpemVkIHZhcmlhYmxlIGJ1ZyBpbiB0aGUg
Y2FsbGVyLiAgVGhpcyBzZWVtcyBsaWtlIGEKcmVhc29uYWJsZSB3YXJuaW5nIGFuZCBpdCBkb2Vz
bid0IGh1cnQgdG8gc2lsZW5jZSBpdCBhdCBsZWFzdC4KCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3ZpLmM6NzY3IHZpX2FzaWNfcmVzZXRfbWV0aG9kKCkgZXJyb3I6IHVuaW5pdGlhbGl6ZWQg
c3ltYm9sICdiYWNvX3Jlc2V0Jy4KCkZpeGVzOiA0MjVkYjI1NTNlNDMgKCJkcm0vYW1kZ3B1OiBl
eHBvc2UgQkFDTyBpbnRlcmZhY2VzIHRvIHVwcGVyIGxldmVsIGZyb20gUFAiKQpTaWduZWQtb2Zm
LWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kX3Bvd2VycGxheS5jIHwgMSArCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9hbWRfcG93ZXJwbGF5LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9h
bWRfcG93ZXJwbGF5LmMKaW5kZXggODMxOTZiNzllZGQ1Li5mNGZmMTUzNzhlNjEgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMKQEAgLTE0MjEsNiAr
MTQyMSw3IEBAIHN0YXRpYyBpbnQgcHBfZ2V0X2FzaWNfYmFjb19jYXBhYmlsaXR5KHZvaWQgKmhh
bmRsZSwgYm9vbCAqY2FwKQogewogCXN0cnVjdCBwcF9od21nciAqaHdtZ3IgPSBoYW5kbGU7CiAK
KwkqY2FwID0gZmFsc2U7CiAJaWYgKCFod21ncikKIAkJcmV0dXJuIC1FSU5WQUw7CiAKLS0gCjIu
MjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJp
LWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
