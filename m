From: Lyude <cpaul@redhat.com>
Subject: [PATCH 4/7] drm/amdgpu: Don't print error on aux transaction timeouts
Date: Fri,  5 Aug 2016 20:30:36 -0400
Message-ID: <1470443443-27252-5-git-send-email-cpaul@redhat.com>
References: <1470443443-27252-1-git-send-email-cpaul@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1470443443-27252-1-git-send-email-cpaul@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, xorg-driver-ati@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, Ken Wang <Qingqing.Wang@amd.com>, Lyude <cpaul@redhat.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

U2luY2UgaXQncyBub3JtYWwgZm9yIERSTSB0byByZXRyeSBvdXIgYXV4IHRyYW5zYWN0aW9uIGhl
bHBlcnMgbXVsdGlwbGUKdGltZXMgaW4gYSByb3csIHVwIHRvIDMyIHRpbWVzIGZvciBlYWNoIGF0
dGVtcHRlZCB0cmFuc2FjdGlvbiwgd2UncmUKbWFraW5nIGEgbG90IG9mIG5vaXNlIHRoYXQgaXMg
bm8gbG9uZ2VyIG5lY2Vzc2FyeSBub3cgdGhhdCBEUk0gd2lsbCBqdXN0CnByaW50IHRoZSByZXR1
cm4gY29kZSB3ZSBnaXZlIGl0LgoKU2lnbmVkLW9mZi1ieTogTHl1ZGUgPGNwYXVsQHJlZGhhdC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbWJpb3NfZHAuYyB8IDEgLQog
MSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hdG9tYmlvc19kcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YXRvbWJpb3NfZHAuYwppbmRleCA3Zjg1YzJjLi4xNjZkYzdiIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hdG9tYmlvc19kcC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2F0b21iaW9zX2RwLmMKQEAgLTg4LDcgKzg4LDYgQEAgc3RhdGljIGludCBhbWRn
cHVfYXRvbWJpb3NfZHBfcHJvY2Vzc19hdXhfY2goc3RydWN0IGFtZGdwdV9pMmNfY2hhbiAqY2hh
biwKIAogCS8qIHRpbWVvdXQgKi8KIAlpZiAoYXJncy52Mi51Y1JlcGx5U3RhdHVzID09IDEpIHsK
LQkJRFJNX0RFQlVHX0tNUygiZHBfYXV4X2NoIHRpbWVvdXRcbiIpOwogCQlyID0gLUVUSU1FRE9V
VDsKIAkJZ290byBkb25lOwogCX0KLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9kcmktZGV2ZWwK
