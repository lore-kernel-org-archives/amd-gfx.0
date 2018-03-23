From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] drm/amd/pp: silence a static checker warning
Date: Fri, 23 Mar 2018 14:39:03 +0300
Message-ID: <20180323113903.GD28518@mwanda>
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
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Tom St Denis <tom.stdenis@amd.com>, David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Evan Quan <evan.quan@amd.com>, Rex Zhu <Rex.Zhu@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

VGhpcyBoYXMgYSBzdGF0aWMgY2hlY2tlciB3YXJuaW5nIGJlY2F1c2UgImZyZXYiIGFuZCAiY3Jl
diIgY2FuIGJlCnVuaW5pdGlhbGl6ZWQgaWYgImluZm8iIGlzIE5VTEwuICBJIGp1c3QgY2hhbmdl
ZCB0aGUgb3JkZXIgb2YgdGhlIGNoZWNrcwpzbyB0aGF0IHdlIGNoZWNrICJpbmZvIiBmaXJzdC4K
ClNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4K
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU4X2h3
bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU4X2h3bWdyLmMK
aW5kZXggNzVhNDY1Zjc3MWYwLi43YjI2NjA3YzY0NmEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdThfaHdtZ3IuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU4X2h3bWdyLmMKQEAgLTMxOSwxMyArMzE5LDEzIEBA
IHN0YXRpYyBpbnQgc211OF9nZXRfc3lzdGVtX2luZm9fZGF0YShzdHJ1Y3QgcHBfaHdtZ3IgKmh3
bWdyKQogCQkJR2V0SW5kZXhJbnRvTWFzdGVyVGFibGUoREFUQSwgSW50ZWdyYXRlZFN5c3RlbUlu
Zm8pLAogCQkJJnNpemUsICZmcmV2LCAmY3Jldik7CiAKLQlpZiAoY3JldiAhPSA5KSB7Ci0JCXBy
X2VycigiVW5zdXBwb3J0ZWQgSUdQIHRhYmxlOiAlZCAlZFxuIiwgZnJldiwgY3Jldik7CisJaWYg
KGluZm8gPT0gTlVMTCkgeworCQlwcl9lcnIoIkNvdWxkIG5vdCByZXRyaWV2ZSB0aGUgSW50ZWdy
YXRlZCBTeXN0ZW0gSW5mbyBUYWJsZSFcbiIpOwogCQlyZXR1cm4gLUVJTlZBTDsKIAl9CiAKLQlp
ZiAoaW5mbyA9PSBOVUxMKSB7Ci0JCXByX2VycigiQ291bGQgbm90IHJldHJpZXZlIHRoZSBJbnRl
Z3JhdGVkIFN5c3RlbSBJbmZvIFRhYmxlIVxuIik7CisJaWYgKGNyZXYgIT0gOSkgeworCQlwcl9l
cnIoIlVuc3VwcG9ydGVkIElHUCB0YWJsZTogJWQgJWRcbiIsIGZyZXYsIGNyZXYpOwogCQlyZXR1
cm4gLUVJTlZBTDsKIAl9CiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVsCg==
