From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH 02/12] dma-buf: add dma_buf_(un)map_attachment_locked variants v3
Date: Tue, 16 Apr 2019 20:38:31 +0200
Message-ID: <20190416183841.1577-3-christian.koenig@amd.com>
References: <20190416183841.1577-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416183841.1577-1-christian.koenig@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sumit.semwal@linaro.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

Add function variants which can be called with the reservation lock
already held.

v2: reordered, add lockdep asserts, fix kerneldoc
v3: rebased on sgt caching

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-buf.c | 63 +++++++++++++++++++++++++++++++++++++++
 include/linux/dma-buf.h   |  5 ++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 65161a82d4d5..ef480e5fb239 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -623,6 +623,43 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
 }
 EXPORT_SYMBOL_GPL(dma_buf_detach);
 
+/**
+ * dma_buf_map_attachment_locked - Maps the buffer into _device_ address space
+ * with the reservation lock held. Is a wrapper for map_dma_buf() of the
+ *
+ * Returns the scatterlist table of the attachment;
+ * dma_buf_ops.
+ * @attach:	[in]	attachment whose scatterlist is to be returned
+ * @direction:	[in]	direction of DMA transfer
+ *
+ * Returns sg_table containing the scatterlist to be returned; returns ERR_PTR
+ * on error. May return -EINTR if it is interrupted by a signal.
+ *
+ * A mapping must be unmapped by using dma_buf_unmap_attachment_locked(). Note
+ * that the underlying backing storage is pinned for as long as a mapping
+ * exists, therefore users/importers should not hold onto a mapping for undue
+ * amounts of time.
+ */
+struct sg_table *
+dma_buf_map_attachment_locked(struct dma_buf_attachment *attach,
+			      enum dma_data_direction direction)
+{
+	struct sg_table *sg_table;
+
+	might_sleep();
+	reservation_object_assert_held(attach->dmabuf->resv);
+
+	if (attach->sgt)
+		return attach->sgt;
+
+	sg_table = attach->dmabuf->ops->map_dma_buf(attach, direction);
+	if (!sg_table)
+		sg_table = ERR_PTR(-ENOMEM);
+
+	return sg_table;
+}
+EXPORT_SYMBOL_GPL(dma_buf_map_attachment_locked);
+
 /**
  * dma_buf_map_attachment - Returns the scatterlist table of the attachment;
  * mapped into _device_ address space. Is a wrapper for map_dma_buf() of the
@@ -659,6 +696,32 @@ struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attach,
 }
 EXPORT_SYMBOL_GPL(dma_buf_map_attachment);
 
+/**
+ * dma_buf_unmap_attachment_locked - unmaps the buffer with reservation lock
+ * held, should deallocate the associated scatterlist. Is a wrapper for
+ * unmap_dma_buf() of dma_buf_ops.
+ * @attach:	[in]	attachment to unmap buffer from
+ * @sg_table:	[in]	scatterlist info of the buffer to unmap
+ * @direction:  [in]    direction of DMA transfer
+ *
+ * This unmaps a DMA mapping for @attached obtained by
+ * dma_buf_map_attachment_locked().
+ */
+void dma_buf_unmap_attachment_locked(struct dma_buf_attachment *attach,
+				     struct sg_table *sg_table,
+				     enum dma_data_direction direction)
+{
+	might_sleep();
+	reservation_object_assert_held(attach->dmabuf->resv);
+
+	if (attach->sgt == sg_table)
+		return;
+
+	attach->dmabuf->ops->unmap_dma_buf(attach, sg_table,
+						direction);
+}
+EXPORT_SYMBOL_GPL(dma_buf_unmap_attachment_locked);
+
 /**
  * dma_buf_unmap_attachment - unmaps and decreases usecount of the buffer;might
  * deallocate the scatterlist associated. Is a wrapper for unmap_dma_buf() of
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 0d9c3c13c9fb..18a78be53541 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -395,8 +395,13 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags);
 struct dma_buf *dma_buf_get(int fd);
 void dma_buf_put(struct dma_buf *dmabuf);
 
+struct sg_table *dma_buf_map_attachment_locked(struct dma_buf_attachment *,
+					       enum dma_data_direction);
 struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *,
 					enum dma_data_direction);
+void dma_buf_unmap_attachment_locked(struct dma_buf_attachment *,
+				     struct sg_table *,
+				     enum dma_data_direction);
 void dma_buf_unmap_attachment(struct dma_buf_attachment *, struct sg_table *,
 				enum dma_data_direction);
 int dma_buf_begin_cpu_access(struct dma_buf *dma_buf,
-- 
2.17.1
