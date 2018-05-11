From: Junwei Zhang <Jerry.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: set ttm bo priority before initialization
Date: Fri, 11 May 2018 12:58:00 +0800
Message-ID: <1526014680-4644-2-git-send-email-Jerry.Zhang@amd.com>
References: <1526014680-4644-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1526014680-4644-1-git-send-email-Jerry.Zhang@amd.com>
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
Cc: Junwei Zhang <Jerry.Zhang@amd.com>, christian.koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

U2lnbmVkLW9mZi1ieTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyB8IDUgKystLS0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCmluZGV4IGU2MjE1M2EuLjZhOWU0NmEgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKQEAgLTQxOSw2ICs0
MTksOCBAQCBzdGF0aWMgaW50IGFtZGdwdV9ib19kb19jcmVhdGUoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsCiAKIAliby0+dGJvLmJkZXYgPSAmYWRldi0+bW1hbi5iZGV2OwogCWFtZGdwdV90
dG1fcGxhY2VtZW50X2Zyb21fZG9tYWluKGJvLCBicC0+ZG9tYWluKTsKKwlpZiAoYnAtPnR5cGUg
PT0gdHRtX2JvX3R5cGVfa2VybmVsKQorCQliby0+dGJvLnByaW9yaXR5ID0gMTsKIAogCXIgPSB0
dG1fYm9faW5pdF9yZXNlcnZlZCgmYWRldi0+bW1hbi5iZGV2LCAmYm8tPnRibywgc2l6ZSwgYnAt
PnR5cGUsCiAJCQkJICZiby0+cGxhY2VtZW50LCBwYWdlX2FsaWduLCAmY3R4LCBhY2Nfc2l6ZSwK
QEAgLTQzNCw5ICs0MzYsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV9ib19kb19jcmVhdGUoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJZWxzZQogCQlhbWRncHVfY3NfcmVwb3J0X21vdmVkX2J5
dGVzKGFkZXYsIGN0eC5ieXRlc19tb3ZlZCwgMCk7CiAKLQlpZiAoYnAtPnR5cGUgPT0gdHRtX2Jv
X3R5cGVfa2VybmVsKQotCQliby0+dGJvLnByaW9yaXR5ID0gMTsKLQogCWlmIChicC0+ZmxhZ3Mg
JiBBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NMRUFSRUQgJiYKIAkgICAgYm8tPnRiby5tZW0ucGxh
Y2VtZW50ICYgVFRNX1BMX0ZMQUdfVlJBTSkgewogCQlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZTsK
LS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
