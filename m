Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD740D715E4
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jan 2026 19:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 704B710E29A;
	Sat, 24 Jan 2026 19:14:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E+qed9+U";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DD7810E288;
 Sat, 24 Jan 2026 19:14:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 23CAF440AA;
 Sat, 24 Jan 2026 19:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4919EC116D0;
 Sat, 24 Jan 2026 19:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769282085;
 bh=CetJhzK/dmJBLMz+bJ3CPsyRZ1nlFNOkolpObmDVtz0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E+qed9+Um7iVv80TsYOZWcZP/rGetC2sBL0P71rj7wOgBsepUTx+mQdMIs2O/EZks
 0kAOtfqtoLQOIBfakbep3vrzY0fCcXQtPi3z+6BArClW8bea2cOmrO23I9/bdYLNbU
 kDzk5WO5rqbVTAc7dvGF9WBPw9+Er8VHQp43qL6xnXNQqT7xLFYZSTuhUV6KsfKktO
 NipQR3kxjznWtTOeH2N9WZ8YRNAvhkFxqqMh85dhpKXlQoD71qMVuS3yPZqJOQJHop
 iqRFDRQ6q4yCHx2JhCaclV2D6e7InQZdTWQoAyo54iojwnNaZxeCC76LKq3ZFC7cYu
 g8cy/twabgHaQ==
From: Leon Romanovsky <leon@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Williamson <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: [PATCH v5 4/8] vfio: Wait for dma-buf invalidation to complete
Date: Sat, 24 Jan 2026 21:14:16 +0200
Message-ID: <20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-47773
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leon Romanovsky <leonro@nvidia.com>

dma-buf invalidation is handled asynchronously by the hardware, so VFIO
must wait until all affected objects have been fully invalidated.

In addition, the dma-buf exporter is expecting that all importers unmap any
buffers they previously mapped.

Fixes: 5d74781ebc86 ("vfio/pci: Add dma-buf export support for MMIO regions")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 71 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index d8ceafabef48..485515629fe4 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -17,6 +17,8 @@ struct vfio_pci_dma_buf {
 	struct dma_buf_phys_vec *phys_vec;
 	struct p2pdma_provider *provider;
 	u32 nr_ranges;
+	struct kref kref;
+	struct completion comp;
 	u8 revoked : 1;
 };
 
@@ -44,27 +46,46 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
 	return 0;
 }
 
+static void vfio_pci_dma_buf_done(struct kref *kref)
+{
+	struct vfio_pci_dma_buf *priv =
+		container_of(kref, struct vfio_pci_dma_buf, kref);
+
+	complete(&priv->comp);
+}
+
 static struct sg_table *
 vfio_pci_dma_buf_map(struct dma_buf_attachment *attachment,
 		     enum dma_data_direction dir)
 {
 	struct vfio_pci_dma_buf *priv = attachment->dmabuf->priv;
+	struct sg_table *ret;
 
 	dma_resv_assert_held(priv->dmabuf->resv);
 
 	if (priv->revoked)
 		return ERR_PTR(-ENODEV);
 
-	return dma_buf_phys_vec_to_sgt(attachment, priv->provider,
-				       priv->phys_vec, priv->nr_ranges,
-				       priv->size, dir);
+	ret = dma_buf_phys_vec_to_sgt(attachment, priv->provider,
+				      priv->phys_vec, priv->nr_ranges,
+				      priv->size, dir);
+	if (IS_ERR(ret))
+		return ret;
+
+	kref_get(&priv->kref);
+	return ret;
 }
 
 static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment,
 				   struct sg_table *sgt,
 				   enum dma_data_direction dir)
 {
+	struct vfio_pci_dma_buf *priv = attachment->dmabuf->priv;
+
+	dma_resv_assert_held(priv->dmabuf->resv);
+
 	dma_buf_free_sgt(attachment, sgt, dir);
+	kref_put(&priv->kref, vfio_pci_dma_buf_done);
 }
 
 static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
@@ -287,6 +308,9 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 		goto err_dev_put;
 	}
 
+	kref_init(&priv->kref);
+	init_completion(&priv->comp);
+
 	/* dma_buf_put() now frees priv */
 	INIT_LIST_HEAD(&priv->dmabufs_elm);
 	down_write(&vdev->memory_lock);
@@ -326,6 +350,8 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 	lockdep_assert_held_write(&vdev->memory_lock);
 
 	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
+		unsigned long wait;
+
 		if (!get_file_active(&priv->dmabuf->file))
 			continue;
 
@@ -333,7 +359,37 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 			dma_resv_lock(priv->dmabuf->resv, NULL);
 			priv->revoked = revoked;
 			dma_buf_invalidate_mappings(priv->dmabuf);
+			dma_resv_wait_timeout(priv->dmabuf->resv,
+					      DMA_RESV_USAGE_BOOKKEEP, false,
+					      MAX_SCHEDULE_TIMEOUT);
 			dma_resv_unlock(priv->dmabuf->resv);
+			if (revoked) {
+				kref_put(&priv->kref, vfio_pci_dma_buf_done);
+				/* Let's wait till all DMA unmap are completed. */
+				wait = wait_for_completion_timeout(
+					&priv->comp, secs_to_jiffies(1));
+				/*
+				 * If you see this WARN_ON, it means that
+				 * importer didn't call unmap in response to
+				 * dma_buf_invalidate_mappings() which is not
+				 * allowed.
+				 */
+				WARN(!wait,
+				     "Timed out waiting for DMABUF unmap, importer has a broken invalidate_mapping()");
+			} else {
+				/*
+				 * Kref is initialize again, because when revoke
+				 * was performed the reference counter was decreased
+				 * to zero to trigger completion.
+				 */
+				kref_init(&priv->kref);
+				/*
+				 * There is no need to wait as no mapping was
+				 * performed when the previous status was
+				 * priv->revoked == true.
+				 */
+				reinit_completion(&priv->comp);
+			}
 		}
 		fput(priv->dmabuf->file);
 	}
@@ -346,6 +402,8 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
 
 	down_write(&vdev->memory_lock);
 	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
+		unsigned long wait;
+
 		if (!get_file_active(&priv->dmabuf->file))
 			continue;
 
@@ -354,7 +412,14 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
 		priv->vdev = NULL;
 		priv->revoked = true;
 		dma_buf_invalidate_mappings(priv->dmabuf);
+		dma_resv_wait_timeout(priv->dmabuf->resv,
+				      DMA_RESV_USAGE_BOOKKEEP, false,
+				      MAX_SCHEDULE_TIMEOUT);
 		dma_resv_unlock(priv->dmabuf->resv);
+		kref_put(&priv->kref, vfio_pci_dma_buf_done);
+		wait = wait_for_completion_timeout(&priv->comp,
+						   secs_to_jiffies(1));
+		WARN_ON(!wait);
 		vfio_device_put_registration(&vdev->vdev);
 		fput(priv->dmabuf->file);
 	}

-- 
2.52.0

