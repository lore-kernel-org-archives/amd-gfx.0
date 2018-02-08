From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 2/4] amdgpu/dc/calcs: Consolidate redundant CFLAGS
Date: Thu,  8 Feb 2018 12:53:14 -0800
Message-ID: <20180208205316.93330-2-mka@chromium.org>
References: <20180208205316.93330-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180208205316.93330-1-mka@chromium.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Harry Wentland <harry.wentland@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Cc: Craig Bergstrom <craigb@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Justin TerAvest <teravest@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, amd-gfx@lists.freedesktop.org, Guenter Roeck <groeck@chromium.org>
List-Id: amd-gfx.lists.freedesktop.org

VXNlIGEgdmFyaWFibGUgZm9yIGNvbW1vbiBDRkxBR1MgaW5zdGVhZCBvZiBzcGVjaWZ5aW5nIHRo
ZSBzYW1lIGZsYWdzCmZvciBldmVyeSBzb3VyY2UgZmlsZS4KClNpZ25lZC1vZmYtYnk6IE1hdHRo
aWFzIEthZWhsY2tlIDxta2FAY2hyb21pdW0ub3JnPgotLS0KQ2hhbmdlcyBpbiB2MzoKLSBwYXRj
aCBhZGRlZAoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jYWxjcy9NYWtlZmlsZSB8
IDggKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NhbGNzL01h
a2VmaWxlIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NhbGNzL01ha2VmaWxlCmlu
ZGV4IDc5NTllMzgyZWQyOC4uYWYwZjQ1MmYzYzlmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvY2FsY3MvTWFrZWZpbGUKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2NhbGNzL01ha2VmaWxlCkBAIC0yNCw5ICsyNCwxMSBAQAogIyBJdCBjYWxj
dWxhdGVzIEJhbmR3aWR0aCBhbmQgV2F0ZXJtYXJrcyB2YWx1ZXMgZm9yIEhXIHByb2dyYW1taW5n
CiAjCiAKLUNGTEFHU19kY25fY2FsY3MubyA6PSAtbWhhcmQtZmxvYXQgLW1zc2UgLW1wcmVmZXJy
ZWQtc3RhY2stYm91bmRhcnk9NAotQ0ZMQUdTX2Rjbl9jYWxjX2F1dG8ubyA6PSAtbWhhcmQtZmxv
YXQgLW1zc2UgLW1wcmVmZXJyZWQtc3RhY2stYm91bmRhcnk9NAotQ0ZMQUdTX2Rjbl9jYWxjX21h
dGgubyA6PSAtbWhhcmQtZmxvYXQgLW1zc2UgLW1wcmVmZXJyZWQtc3RhY2stYm91bmRhcnk9NCAt
V25vLXRhdXRvbG9naWNhbC1jb21wYXJlCitjYWxjc19jY2ZsYWdzIDo9IC1taGFyZC1mbG9hdCAt
bXNzZSAtbXByZWZlcnJlZC1zdGFjay1ib3VuZGFyeT00CisKK0NGTEFHU19kY25fY2FsY3MubyA6
PSAkKGNhbGNzX2NjZmxhZ3MpCitDRkxBR1NfZGNuX2NhbGNfYXV0by5vIDo9ICQoY2FsY3NfY2Nm
bGFncykKK0NGTEFHU19kY25fY2FsY19tYXRoLm8gOj0gJChjYWxjc19jY2ZsYWdzKSAtV25vLXRh
dXRvbG9naWNhbC1jb21wYXJlCiAKIEJXX0NBTENTID0gZGNlX2NhbGNzLm8gYndfZml4ZWQubyBj
dXN0b21fZmxvYXQubwogCi0tIAoyLjE2LjAucmMxLjIzOC5nNTMwZDY0OWE3OS1nb29nCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFp
bGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
