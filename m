From: Chunming Zhou <david1.zhou@amd.com>
Subject: [PATCH libdrm 2/8] addr cs chunk for syncobj timeline
Date: Tue, 9 Apr 2019 17:04:31 +0800
Message-ID: <20190409090437.3485-2-david1.zhou@amd.com>
References: <20190409090437.3485-1-david1.zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190409090437.3485-1-david1.zhou@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Christian.Koenig@amd.com, lionel.g.landwerlin@intel.com, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

U2lnbmVkLW9mZi1ieTogQ2h1bm1pbmcgWmhvdSA8ZGF2aWQxLnpob3VAYW1kLmNvbT4KLS0tCiBp
bmNsdWRlL2RybS9hbWRncHVfZHJtLmggfCA5ICsrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDkg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaCBiL2lu
Y2x1ZGUvZHJtL2FtZGdwdV9kcm0uaAppbmRleCBlM2E5N2RhNC4uYWI1M2YyZTAgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaAorKysgYi9pbmNsdWRlL2RybS9hbWRncHVfZHJt
LmgKQEAgLTUyOCw2ICs1MjgsOCBAQCBzdHJ1Y3QgZHJtX2FtZGdwdV9nZW1fdmEgewogI2RlZmlu
ZSBBTURHUFVfQ0hVTktfSURfU1lOQ09CSl9PVVQgICAgIDB4MDUKICNkZWZpbmUgQU1ER1BVX0NI
VU5LX0lEX0JPX0hBTkRMRVMgICAgICAweDA2CiAjZGVmaW5lIEFNREdQVV9DSFVOS19JRF9TQ0hF
RFVMRURfREVQRU5ERU5DSUVTCTB4MDcKKyNkZWZpbmUgQU1ER1BVX0NIVU5LX0lEX1NZTkNPQkpf
VElNRUxJTkVfV0FJVCAgICAweDA4CisjZGVmaW5lIEFNREdQVV9DSFVOS19JRF9TWU5DT0JKX1RJ
TUVMSU5FX1NJR05BTCAgMHgwOQogCiBzdHJ1Y3QgZHJtX2FtZGdwdV9jc19jaHVuayB7CiAJX191
MzIJCWNodW5rX2lkOwpAQCAtNjA4LDYgKzYxMCwxMyBAQCBzdHJ1Y3QgZHJtX2FtZGdwdV9jc19j
aHVua19zZW0gewogCV9fdTMyIGhhbmRsZTsKIH07CiAKK3N0cnVjdCBkcm1fYW1kZ3B1X2NzX2No
dW5rX3N5bmNvYmogeworCV9fdTMyIGhhbmRsZTsKKwlfX3UzMiBmbGFnczsKKwlfX3U2NCBwb2lu
dDsKK307CisKKwogI2RlZmluZSBBTURHUFVfRkVOQ0VfVE9fSEFORExFX0dFVF9TWU5DT0JKCTAK
ICNkZWZpbmUgQU1ER1BVX0ZFTkNFX1RPX0hBTkRMRV9HRVRfU1lOQ09CSl9GRAkxCiAjZGVmaW5l
IEFNREdQVV9GRU5DRV9UT19IQU5ETEVfR0VUX1NZTkNfRklMRV9GRAkyCi0tIAoyLjE3LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
