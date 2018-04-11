From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 2/2] drm/amdgpu: Allow dma_map_sg() coalescing
Date: Wed, 11 Apr 2018 18:11:16 +0100
Message-ID: <fe9f66a7eb918a3e62473e11c29b973d2c5395ce.1523465719.git.robin.murphy@arm.com>
References: <0901c8c3b9adbcb851ba58dfca6b16d12ccbcb0f.1523465719.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <0901c8c3b9adbcb851ba58dfca6b16d12ccbcb0f.1523465719.git.robin.murphy@arm.com>
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
Cc: okaya@codeaurora.org, alexander.deucher@amd.com, christian.koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

Tm93IHRoYXQgZHJtX3ByaW1lX3NnX3RvX3BhZ2VfYWRkcl9hcnJheXMoKSB1bmRlcnN0YW5kcyB0
aGUgY2FzZSB3aGVyZQpkbWFfbWFwX3NnKCkgaGFzIGNvYWxlc2NlZCBzZWdtZW50cyBhbmQgcmV0
dXJucyAwIDwgY291bnQgPCBuZW50cywgd2UKY2FuIHJlbGF4IHRoZSBjaGVjayB0byBvbmx5IGNv
bnNpZGVyIGdlbnVpbmUgZmFpbHVyZS4KClNpZ25lZC1vZmYtYnk6IFJvYmluIE11cnBoeSA8cm9i
aW4ubXVycGh5QGFybS5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3R0bS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCmluZGV4IDIwNWRhM2Zm
OWNkMC4uZjgxZTk2YTQyNDJmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdHRtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0
bS5jCkBAIC04MTMsNyArODEzLDcgQEAgc3RhdGljIGludCBhbWRncHVfdHRtX3R0X3Bpbl91c2Vy
cHRyKHN0cnVjdCB0dG1fdHQgKnR0bSkKIAogCXIgPSAtRU5PTUVNOwogCW5lbnRzID0gZG1hX21h
cF9zZyhhZGV2LT5kZXYsIHR0bS0+c2ctPnNnbCwgdHRtLT5zZy0+bmVudHMsIGRpcmVjdGlvbik7
Ci0JaWYgKG5lbnRzICE9IHR0bS0+c2ctPm5lbnRzKQorCWlmIChuZW50cyA9PSAwKQogCQlnb3Rv
IHJlbGVhc2Vfc2c7CiAKIAlkcm1fcHJpbWVfc2dfdG9fcGFnZV9hZGRyX2FycmF5cyh0dG0tPnNn
LCB0dG0tPnBhZ2VzLAotLSAKMi4xNi4xLmRpcnR5CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9kcmktZGV2ZWwK
