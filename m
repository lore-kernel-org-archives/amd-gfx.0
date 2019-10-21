From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/5] cxgb4/cxgb4vf: Remove superfluous void * cast in debugfs_create_file() call
Date: Mon, 21 Oct 2019 16:51:46 +0200
Message-ID: <20191021145149.31657-3-geert+renesas@glider.be>
References: <20191021145149.31657-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021145149.31657-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Breno=20Leit=C3=A3o?= <leitao@debian.org>, Nayna Jain <nayna@linux.ibm.com>, Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David@rox.of.borg, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Casey Leedom <leedom@chelsio.com>, Shannon Nelson <snelson@pensando.io>, Pensando Drivers <drivers@pensando.io>, Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: amd-gfx.lists.freedesktop.org

There is no need to cast a typed pointer to a void pointer when calling
a function that accepts the latter.  Remove it, as the cast prevents
further compiler checks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
index f6fc0875d5b0a285..4a07a73c672b5996 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
@@ -2480,7 +2480,7 @@ static int setup_debugfs(struct adapter *adapter)
 	for (i = 0; i < ARRAY_SIZE(debugfs_files); i++)
 		debugfs_create_file(debugfs_files[i].name,
 				    debugfs_files[i].mode,
-				    adapter->debugfs_root, (void *)adapter,
+				    adapter->debugfs_root, adapter,
 				    debugfs_files[i].fops);
 
 	return 0;
-- 
2.17.1
