From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amdgpu/gfx10: Fix missing break in switch statement
Date: Sun, 21 Jul 2019 17:39:49 -0500
Message-ID: <20190721223949.GA13591@embeddedor>
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
To: Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

QWRkIG1pc3NpbmcgYnJlYWsgc3RhdGVtZW50IGluIG9yZGVyIHRvIHByZXZlbnQgdGhlIGNvZGUg
ZnJvbSBmYWxsaW5nCnRocm91Z2ggdG8gY2FzZSBBTURHUFVfSVJRX1NUQVRFX0VOQUJMRS4KClRo
aXMgYnVnIHdhcyBmb3VuZCB0aGFua3MgdG8gdGhlIG9uZ29pbmcgZWZmb3J0cyB0byBlbmFibGUK
LVdpbXBsaWNpdC1mYWxsdGhyb3VnaC4KCkZpeGVzOiBhNjQ0ZDg1YTVjZDQgKCJkcm0vYW1kZ3B1
OiBhZGQgZ2Z4IHYxMCBpbXBsZW1lbnRhdGlvbiAodjEwKSIpCkNjOiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnClNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9AZW1iZWRk
ZWRvci5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCAx
ICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3YxMF8wLmMKaW5kZXggMTY3NWQ1ODM3YzNjLi4zNWU4ZTI5MTM5YjEgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCkBAIC00NjExLDYgKzQ2MTEsNyBAQCBnZnhf
djEwXzBfc2V0X2dmeF9lb3BfaW50ZXJydXB0X3N0YXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LAogCQljcF9pbnRfY250bCA9IFJFR19TRVRfRklFTEQoY3BfaW50X2NudGwsIENQX0lOVF9D
TlRMX1JJTkcwLAogCQkJCQkgICAgVElNRV9TVEFNUF9JTlRfRU5BQkxFLCAwKTsKIAkJV1JFRzMy
KGNwX2ludF9jbnRsX3JlZywgY3BfaW50X2NudGwpOworCQlicmVhazsKIAljYXNlIEFNREdQVV9J
UlFfU1RBVEVfRU5BQkxFOgogCQljcF9pbnRfY250bCA9IFJSRUczMihjcF9pbnRfY250bF9yZWcp
OwogCQljcF9pbnRfY250bCA9IFJFR19TRVRfRklFTEQoY3BfaW50X2NudGwsIENQX0lOVF9DTlRM
X1JJTkcwLAotLSAKMi4yMi4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9k
cmktZGV2ZWw=
