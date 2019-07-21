From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amdkfd/kfd_mqd_manager_v10: Fix missing break in switch
 statement
Date: Sun, 21 Jul 2019 17:59:20 -0500
Message-ID: <20190721225920.GA18099@embeddedor>
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
To: Philip Cox <Philip.Cox@amd.com>, Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

QWRkIG1pc3NpbmcgYnJlYWsgc3RhdGVtZW50IGluIG9yZGVyIHRvIHByZXZlbnQgdGhlIGNvZGUg
ZnJvbSBmYWxsaW5nCnRocm91Z2ggdG8gY2FzZSBLRkRfTVFEX1RZUEVfQ09NUFVURS4KClRoaXMg
YnVnIHdhcyBmb3VuZCB0aGFua3MgdG8gdGhlIG9uZ29pbmcgZWZmb3J0cyB0byBlbmFibGUKLVdp
bXBsaWNpdC1mYWxsdGhyb3VnaC4KCkZpeGVzOiAxNDMyOGFhNThjZTUgKCJkcm0vYW1ka2ZkOiBB
ZGQgbmF2aTEwIHN1cHBvcnQgdG8gYW1ka2ZkLiAodjMpIikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcKU2lnbmVkLW9mZi1ieTogR3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b0BlbWJlZGRl
ZG9yLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJf
djEwLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTAuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTAuYwppbmRleCA0ZjhhNmZm
YzU3NzUuLjFkOGIxM2FkNDZmOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9tcWRfbWFuYWdlcl92MTAuYwpAQCAtNDMwLDYgKzQzMCw3IEBAIHN0cnVjdCBtcWRfbWFu
YWdlciAqbXFkX21hbmFnZXJfaW5pdF92MTAoZW51bSBLRkRfTVFEX1RZUEUgdHlwZSwKIAlzd2l0
Y2ggKHR5cGUpIHsKIAljYXNlIEtGRF9NUURfVFlQRV9DUDoKIAkJcHJfZGVidWcoIiVzQCVpXG4i
LCBfX2Z1bmNfXywgX19MSU5FX18pOworCQlicmVhazsKIAljYXNlIEtGRF9NUURfVFlQRV9DT01Q
VVRFOgogCQlwcl9kZWJ1ZygiJXNAJWlcbiIsIF9fZnVuY19fLCBfX0xJTkVfXyk7CiAJCW1xZC0+
YWxsb2NhdGVfbXFkID0gYWxsb2NhdGVfbXFkOwotLSAKMi4yMi4wCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRy
aS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
