Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8092DD2ED12
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 14:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2691A10E603;
	Tue, 20 Jan 2026 14:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NBjWhUFV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 351ED10E602;
 Tue, 20 Jan 2026 14:07:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A6D676012B;
 Tue, 20 Jan 2026 14:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29C7C2BC86;
 Tue, 20 Jan 2026 14:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768918056;
 bh=bf1696+c5PaSfpBeHHGzA+vmhqIVB4390cXN7pOou2E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NBjWhUFVYnRzWBwslbwnf3YkcH1nikmzNYEw/PthA0UmL0zyOrClkJko7UTwOtT8v
 +4VBltLl7uM7PsMb7uiam/Xlx8gM8HDQ0Obb2wlKT4rWiUMa43+tbff3bXupMyeJdx
 wDxL36aBPCKbdDA4Qb32vtAkYyS48v4pyulCvKBVUiIvLy2k5uZ24Vztos9slrw8H0
 iSkU4nGBDZZA9AsTpBEVBFMSylMfN1Vu4UliXAOwjpA735qtqBFEb1JOWHBOkDK9cq
 +5TQCt8uFqHSC+68xraxCpD7BjZyd+Vwtdp3IkygP2CS0ghFagzaiIted2cqXXfZnB
 4HpjhwEhU/B4Q==
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
Subject: [PATCH v3 6/7] vfio: Wait for dma-buf invalidation to complete
Date: Tue, 20 Jan 2026 16:07:06 +0200
Message-ID: <20260120-dmabuf-revoke-v3-6-b7e0b07b8214@nvidia.com>
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

dma-buf invalidation is performed asynchronously by hardware, so VFIO must
wait until all affected objects have been fully invalidated.

Fixes: 5d74781ebc86 ("vfio/pci: Add dma-buf export support for MMIO regions")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index d4d0f7d08c53..33bc6a1909dd 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -321,6 +321,9 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 			dma_resv_lock(priv->dmabuf->resv, NULL);
 			priv->revoked = revoked;
 			dma_buf_move_notify(priv->dmabuf);
+			dma_resv_wait_timeout(priv->dmabuf->resv,
+					      DMA_RESV_USAGE_KERNEL, false,
+					      MAX_SCHEDULE_TIMEOUT);
 			dma_resv_unlock(priv->dmabuf->resv);
 		}
 		fput(priv->dmabuf->file);
@@ -342,6 +345,8 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
 		priv->vdev = NULL;
 		priv->revoked = true;
 		dma_buf_move_notify(priv->dmabuf);
+		dma_resv_wait_timeout(priv->dmabuf->resv, DMA_RESV_USAGE_KERNEL,
+				      false, MAX_SCHEDULE_TIMEOUT);
 		dma_resv_unlock(priv->dmabuf->resv);
 		vfio_device_put_registration(&vdev->vdev);
 		fput(priv->dmabuf->file);

-- 
2.52.0

