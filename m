Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBAAD2ED0F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 14:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68CFF10E600;
	Tue, 20 Jan 2026 14:07:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HRchcWPp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D722810E5FD;
 Tue, 20 Jan 2026 14:07:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B9396011E;
 Tue, 20 Jan 2026 14:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB10C16AAE;
 Tue, 20 Jan 2026 14:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768918049;
 bh=MryhAftyHxYTop+mnKinqTb8eFJW20BmygrDTfbPY2w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HRchcWPpsUvcK+Crk3OAOK761eYKGCH0fgOBvesqeEQQlf1bYaTkU5/cAIoZz24Xg
 QZOa8k69UfgH0yHQAxr/k5AFdCcArO4JpyQS0ALF7IOK7+5MXk+zQaXz/gMMgMYxTE
 oN/OiCYRgZMn7+HHLVC8ZS7zvMFhxFJKTXEohcy6HZiZ6em6nCJZ4V8msli3NFxDPo
 ULsfYeHN5PJhqPiDXsOQsfLXaqDydvqEYPJGjBmI323H0aNfpgB/Gkg/XAf2FMSE0t
 NXBeQanufm7+6AtVifiTmQhurpZw8xuWsfKDlKQKi/x2zRXK6HWmQL9ZaTNupRUW8w
 BferpMeWKFc9A==
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
Subject: [PATCH v3 4/7] dma-buf: Add check function for revoke semantics
Date: Tue, 20 Jan 2026 16:07:04 +0200
Message-ID: <20260120-dmabuf-revoke-v3-4-b7e0b07b8214@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a6db3
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

A DMA-buf revoke mechanism that allows an exporter to explicitly
invalidate ("kill") a shared buffer after it has been handed out to
importers. Once revoked, all further CPU and device access is blocked, and
importers consistently observe failure.

This requires both importers and exporters to honor the revoke contract.

For importers, this means implementing .invalidate_mappings(). For exporters,
this means implementing the .pin() and/or .attach() callback, which check the
dma‑buf attachment for a valid revoke implementation.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/dma-buf/dma-buf.c | 37 ++++++++++++++++++++++++++++++++++++-
 include/linux/dma-buf.h   |  1 +
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index c4fa35034b92..c048c822c3e9 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1252,13 +1252,48 @@ void dma_buf_unsupported_invalidate_mappings(struct dma_buf_attachment *attach)
 }
 EXPORT_SYMBOL_FOR_MODULES(dma_buf_unsupported_invalidate_mappings, "ib_uverbs");
 
+/**
+ * dma_buf_attach_revocable - check if a DMA-buf importer implements
+ * revoke semantics.
+ * @attach: the DMA-buf attachment to check
+ *
+ * Returns true if the DMA-buf importer can handle invalidating it's mappings
+ * at any time, even after pinning a buffer.
+ */
+bool dma_buf_attach_revocable(struct dma_buf_attachment *attach)
+{
+	/*
+	 * There is no need to check existence of .invalidate_mappings() as
+	 * it always exists when importer_ops is set in dma_buf_dynamic_attach().
+	 */
+	return attach->importer_ops &&
+	       (attach->importer_ops->invalidate_mappings !=
+		&dma_buf_unsupported_invalidate_mappings);
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_attach_revocable, "DMA_BUF");
+
 /**
  * dma_buf_move_notify - notify attachments that DMA-buf is moving
  *
  * @dmabuf:	[in]	buffer which is moving
  *
  * Informs all attachments that they need to destroy and recreate all their
- * mappings.
+ * mappings. If the attachment is dynamic then the dynamic importer is expected
+ * to invalidate any caches it has of the mapping result and perform a new
+ * mapping request before allowing HW to do any further DMA.
+ *
+ * If the attachment is pinned then this informs the pinned importer that
+ * the underlying mapping is no longer available. Pinned importers may take
+ * this is as a permanent revocation so exporters should not trigger it
+ * lightly.
+ *
+ * For legacy pinned importers that cannot support invalidation this is a NOP.
+ * Drivers can call dma_buf_attach_revocable() to determine if the importer
+ * supports this.
+ *
+ * NOTE: The invalidation triggers asynchronous HW operation and the callers
+ * need to wait for this operation to complete by calling
+ * to dma_resv_wait_timeout().
  */
 void dma_buf_move_notify(struct dma_buf *dmabuf)
 {
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 7d7d0a4fb762..ac2ce1273b4c 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -602,6 +602,7 @@ void dma_buf_unmap_attachment(struct dma_buf_attachment *, struct sg_table *,
 				enum dma_data_direction);
 void dma_buf_move_notify(struct dma_buf *dma_buf);
 void dma_buf_unsupported_invalidate_mappings(struct dma_buf_attachment *attach);
+bool dma_buf_attach_revocable(struct dma_buf_attachment *attach);
 
 int dma_buf_begin_cpu_access(struct dma_buf *dma_buf,
 			     enum dma_data_direction dir);

-- 
2.52.0

