From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/5] crypto: nx - Improve debugfs_create_u{32,64}() handling for atomics
Date: Mon, 21 Oct 2019 16:51:45 +0200
Message-ID: <20191021145149.31657-2-geert+renesas@glider.be>
References: <20191021145149.31657-1-geert+renesas@glider.be>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191021145149.31657-1-geert+renesas@glider.be>
Sender: netdev-owner@vger.kernel.org
To: =?UTF-8?q?Breno=20Leit=C3=A3o?= <leitao@debian.org>, Nayna Jain <nayna@linux.ibm.com>, Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David@rox.of.borg, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Casey Leedom <leedom@chelsio.com>, Shannon Nelson <snelson@pensando.io>, Pensando Drivers <drivers@pensando.io>, Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: amd-gfx.lists.freedesktop.org

Variables of type atomic{,64}_t can be used fine with
debugfs_create_u{32,64}, when passing a pointer to the embedded counter.
This allows to get rid of the casts, which prevented compiler checks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/crypto/nx/nx_debugfs.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/nx/nx_debugfs.c b/drivers/crypto/nx/nx_debugfs.c
index e0d44a5512ab455b..1975bcbee997481e 100644
--- a/drivers/crypto/nx/nx_debugfs.c
+++ b/drivers/crypto/nx/nx_debugfs.c
@@ -38,23 +38,23 @@ void nx_debugfs_init(struct nx_crypto_driver *drv)
 	drv->dfs_root = root;
 
 	debugfs_create_u32("aes_ops", S_IRUSR | S_IRGRP | S_IROTH,
-			   root, (u32 *)&drv->stats.aes_ops);
+			   root, &drv->stats.aes_ops.counter);
 	debugfs_create_u32("sha256_ops", S_IRUSR | S_IRGRP | S_IROTH,
-			   root, (u32 *)&drv->stats.sha256_ops);
+			   root, &drv->stats.sha256_ops.counter);
 	debugfs_create_u32("sha512_ops", S_IRUSR | S_IRGRP | S_IROTH,
-			   root, (u32 *)&drv->stats.sha512_ops);
+			   root, &drv->stats.sha512_ops.counter);
 	debugfs_create_u64("aes_bytes", S_IRUSR | S_IRGRP | S_IROTH,
-			   root, (u64 *)&drv->stats.aes_bytes);
+			   root, &drv->stats.aes_bytes.counter);
 	debugfs_create_u64("sha256_bytes", S_IRUSR | S_IRGRP | S_IROTH,
-			   root, (u64 *)&drv->stats.sha256_bytes);
+			   root, &drv->stats.sha256_bytes.counter);
 	debugfs_create_u64("sha512_bytes", S_IRUSR | S_IRGRP | S_IROTH,
-			   root, (u64 *)&drv->stats.sha512_bytes);
+			   root, &drv->stats.sha512_bytes.counter);
 	debugfs_create_u32("errors", S_IRUSR | S_IRGRP | S_IROTH,
-			   root, (u32 *)&drv->stats.errors);
+			   root, &drv->stats.errors.counter);
 	debugfs_create_u32("last_error", S_IRUSR | S_IRGRP | S_IROTH,
-			   root, (u32 *)&drv->stats.last_error);
+			   root, &drv->stats.last_error.counter);
 	debugfs_create_u32("last_error_pid", S_IRUSR | S_IRGRP | S_IROTH,
-			   root, (u32 *)&drv->stats.last_error_pid);
+			   root, &drv->stats.last_error_pid.counter);
 }
 
 void
-- 
2.17.1
