From: Chunming Zhou <david1.zhou@amd.com>
Subject: [PATCH libdrm 2/7] addr cs chunk for syncobj timeline
Date: Fri, 7 Dec 2018 17:57:58 +0800
Message-ID: <20181207095803.2155-2-david1.zhou@amd.com>
References: <20181207095803.2155-1-david1.zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181207095803.2155-1-david1.zhou@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Christian.Koenig@amd.com, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

U2lnbmVkLW9mZi1ieTogQ2h1bm1pbmcgWmhvdSA8ZGF2aWQxLnpob3VAYW1kLmNvbT4KLS0tCiBp
bmNsdWRlL2RybS9hbWRncHVfZHJtLmggfCA5ICsrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDkg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaCBiL2lu
Y2x1ZGUvZHJtL2FtZGdwdV9kcm0uaAppbmRleCAxY2VlYzU2ZC4uYTNjMDY3ZGQgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaAorKysgYi9pbmNsdWRlL2RybS9hbWRncHVfZHJt
LmgKQEAgLTUxNyw2ICs1MTcsOCBAQCBzdHJ1Y3QgZHJtX2FtZGdwdV9nZW1fdmEgewogI2RlZmlu
ZSBBTURHUFVfQ0hVTktfSURfU1lOQ09CSl9JTiAgICAgIDB4MDQKICNkZWZpbmUgQU1ER1BVX0NI
VU5LX0lEX1NZTkNPQkpfT1VUICAgICAweDA1CiAjZGVmaW5lIEFNREdQVV9DSFVOS19JRF9CT19I
QU5ETEVTICAgICAgMHgwNgorI2RlZmluZSBBTURHUFVfQ0hVTktfSURfU1lOQ09CSl9USU1FTElO
RV9XQUlUICAgIDB4MDcKKyNkZWZpbmUgQU1ER1BVX0NIVU5LX0lEX1NZTkNPQkpfVElNRUxJTkVf
U0lHTkFMICAweDA4CiAKIHN0cnVjdCBkcm1fYW1kZ3B1X2NzX2NodW5rIHsKIAlfX3UzMgkJY2h1
bmtfaWQ7CkBAIC01OTIsNiArNTk0LDEzIEBAIHN0cnVjdCBkcm1fYW1kZ3B1X2NzX2NodW5rX3Nl
bSB7CiAJX191MzIgaGFuZGxlOwogfTsKIAorc3RydWN0IGRybV9hbWRncHVfY3NfY2h1bmtfc3lu
Y29iaiB7CisJX191MzIgaGFuZGxlOworCV9fdTMyIGZsYWdzOworCV9fdTY0IHBvaW50OworfTsK
KworCiAjZGVmaW5lIEFNREdQVV9GRU5DRV9UT19IQU5ETEVfR0VUX1NZTkNPQkoJMAogI2RlZmlu
ZSBBTURHUFVfRkVOQ0VfVE9fSEFORExFX0dFVF9TWU5DT0JKX0ZECTEKICNkZWZpbmUgQU1ER1BV
X0ZFTkNFX1RPX0hBTkRMRV9HRVRfU1lOQ19GSUxFX0ZECTIKLS0gCjIuMTcuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcg
bGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
