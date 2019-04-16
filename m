From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH 01/12] dma-buf: add dynamic caching of sg_table
Date: Tue, 16 Apr 2019 20:38:30 +0200
Message-ID: <20190416183841.1577-2-christian.koenig@amd.com>
References: <20190416183841.1577-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416183841.1577-1-christian.koenig@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sumit.semwal@linaro.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

To allow a smooth transition from pinning buffer objects to dynamic
invalidation we first start to cache the sg_table for an attachment
unless the driver explicitly says to not do so.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-buf.c | 24 ++++++++++++++++++++++++
 include/linux/dma-buf.h   | 11 +++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 7c858020d14b..65161a82d4d5 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -573,6 +573,20 @@ struct dma_buf_attachment *dma_buf_attach(struct dma_buf *dmabuf,
 	list_add(&attach->node, &dmabuf->attachments);
 
 	mutex_unlock(&dmabuf->lock);
+
+	if (!dmabuf->ops->dynamic_sgt_mapping) {
+		struct sg_table *sgt;
+
+		sgt = dmabuf->ops->map_dma_buf(attach, DMA_BIDIRECTIONAL);
+		if (!sgt)
+			sgt = ERR_PTR(-ENOMEM);
+		if (IS_ERR(sgt)) {
+			dma_buf_detach(dmabuf, attach);
+			return ERR_CAST(sgt);
+		}
+		attach->sgt = sgt;
+	}
+
 	return attach;
 
 err_attach:
@@ -595,6 +609,10 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
 	if (WARN_ON(!dmabuf || !attach))
 		return;
 
+	if (attach->sgt)
+		dmabuf->ops->unmap_dma_buf(attach, attach->sgt,
+					   DMA_BIDIRECTIONAL);
+
 	mutex_lock(&dmabuf->lock);
 	list_del(&attach->node);
 	if (dmabuf->ops->detach)
@@ -630,6 +648,9 @@ struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attach,
 	if (WARN_ON(!attach || !attach->dmabuf))
 		return ERR_PTR(-EINVAL);
 
+	if (attach->sgt)
+		return attach->sgt;
+
 	sg_table = attach->dmabuf->ops->map_dma_buf(attach, direction);
 	if (!sg_table)
 		sg_table = ERR_PTR(-ENOMEM);
@@ -657,6 +678,9 @@ void dma_buf_unmap_attachment(struct dma_buf_attachment *attach,
 	if (WARN_ON(!attach || !attach->dmabuf || !sg_table))
 		return;
 
+	if (attach->sgt == sg_table)
+		return;
+
 	attach->dmabuf->ops->unmap_dma_buf(attach, sg_table,
 						direction);
 }
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 58725f890b5b..0d9c3c13c9fb 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -51,6 +51,16 @@ struct dma_buf_attachment;
  * @vunmap: [optional] unmaps a vmap from the buffer
  */
 struct dma_buf_ops {
+	/**
+	 * @dynamic_sgt_mapping:
+	 *
+	 * Flag controlling the caching of the sg_table in the DMA-buf helpers.
+	 * If not set the sg_table is created during device attaching, if set
+	 * the sg_table is created dynamically when dma_buf_map_attachment() is
+	 * called.
+	 */
+	bool dynamic_sgt_mapping;
+
 	/**
 	 * @attach:
 	 *
@@ -323,6 +333,7 @@ struct dma_buf_attachment {
 	struct device *dev;
 	struct list_head node;
 	void *priv;
+	struct sg_table *sgt;
 };
 
 /**
-- 
2.17.1
