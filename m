From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 05/14] amdgpu: powerplay: fiji_smc: Assume display_config is
 zero
Date: Mon, 24 Jul 2017 15:35:31 +0200
Message-ID: <20170724133540.32200-6-ricardo.ribalda@gmail.com>
References: <20170724133540.32200-1-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170724133540.32200-1-ricardo.ribalda@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Rex Zhu <Rex.Zhu@amd.com>, Tom St Denis <tom.stdenis@amd.com>, Eric Huang <JinHuiEric.Huang@amd.com>, Huang Rui <ray.huang@amd.com>, Dan Carpenter <dan.carpenter@oracle.com>, Edward O'Callaghan <funfunctor@folklore1984.net>, Kees Cook <keescook@chromium.org>, "Andrew F. Davis" <afd@ti.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Baoyou Xie <baoyou.xie@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Colin Ian King <colin.king@canonical.com>, =?UTF-8?q?Nils=20Wallm=C3=A9nius?= <nils.wallmenius@gmail.com>, Joe Perches <joe@perches.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

ZGlzcGxheV9jb25maWcgaXMgbmV2ZXIgc2V0LCBzbyB3ZSBjYW4gYXNzdW1lIGl0IGlzIHplcm8u
CgpTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIFJpYmFsZGEgRGVsZ2FkbyA8cmljYXJkby5yaWJhbGRh
QGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3IvZmlq
aV9zbWMuYyB8IDkgKysrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L3NtdW1nci9maWppX3NtYy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdy
L2Zpamlfc21jLmMKaW5kZXggNmEzMjBiMjdhZWZkLi5iZWZkNWMzMDQ2MzYgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9maWppX3NtYy5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9maWppX3NtYy5jCkBAIC03NDIsMTEg
Kzc0MiwxMiBAQCBzdGF0aWMgaW50IGZpamlfcG9wdWxhdGVfc2luZ2xlX2dyYXBoaWNfbGV2ZWwo
c3RydWN0IHBwX2h3bWdyICpod21nciwKIAogCXRocmVzaG9sZCA9IGNsb2NrICogZGF0YS0+ZmFz
dF93YXRlcm1hcmtfdGhyZXNob2xkIC8gMTAwOwogCi0JZGF0YS0+ZGlzcGxheV90aW1pbmcubWlu
X2Nsb2NrX2luX3NyID0gaHdtZ3ItPmRpc3BsYXlfY29uZmlnLm1pbl9jb3JlX3NldF9jbG9ja19p
bl9zcjsKKwlkYXRhLT5kaXNwbGF5X3RpbWluZy5taW5fY2xvY2tfaW5fc3IgPSAwOwogCi0JaWYg
KHBobV9jYXBfZW5hYmxlZChod21nci0+cGxhdGZvcm1fZGVzY3JpcHRvci5wbGF0Zm9ybUNhcHMs
IFBITV9QbGF0Zm9ybUNhcHNfU2Nsa0RlZXBTbGVlcCkpCi0JCWxldmVsLT5EZWVwU2xlZXBEaXZJ
ZCA9IHNtdTdfZ2V0X3NsZWVwX2RpdmlkZXJfaWRfZnJvbV9jbG9jayhjbG9jaywKLQkJCQkJCQkJ
aHdtZ3ItPmRpc3BsYXlfY29uZmlnLm1pbl9jb3JlX3NldF9jbG9ja19pbl9zcik7CisJaWYgKHBo
bV9jYXBfZW5hYmxlZChod21nci0+cGxhdGZvcm1fZGVzY3JpcHRvci5wbGF0Zm9ybUNhcHMsCisJ
CQkgICAgUEhNX1BsYXRmb3JtQ2Fwc19TY2xrRGVlcFNsZWVwKSkKKwkJbGV2ZWwtPkRlZXBTbGVl
cERpdklkID0KKwkJCXNtdTdfZ2V0X3NsZWVwX2RpdmlkZXJfaWRfZnJvbV9jbG9jayhjbG9jaywg
MCk7CiAKIAogCS8qIERlZmF1bHQgdG8gc2xvdywgaGlnaGVzdCBEUE0gbGV2ZWwgd2lsbCBiZQot
LSAKMi4xMy4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
