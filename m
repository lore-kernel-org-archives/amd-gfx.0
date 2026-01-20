Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3CDD2ED0F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 14:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F33ED10E5F5;
	Tue, 20 Jan 2026 14:07:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ijj/wO77";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A87E10E607;
 Tue, 20 Jan 2026 14:07:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D83A440AC;
 Tue, 20 Jan 2026 14:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92D6C16AAE;
 Tue, 20 Jan 2026 14:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768918064;
 bh=+j0ekknPQd/d3gRAxiqnNNnfw0hqFAwwAjsZYhI192Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ijj/wO771lycS6FKxtpygkeK/BYUHKt2nUSEqMQc/fe3SpJqqJcZ/BWCkpIQHgiev
 S+Mf1rPln8yu+F+l0oxZG17ZYhJVhUmOOaXGRiQiIBKGtLNc0IgMJWG2CRJYDmkieP
 5a/VPKZauZJfX0w5M94s+0B+uQ1I4TbxB1ftUo/dLav7fV9nfxwwD7OdKnSh9ZF6iI
 /6dB5AHN3tBpnq0H+i2vDN0zwB0+7FapFUTpuAq/16it37Dv+DIWjBTSnV+vXDMZEJ
 wa4KiwHpfHeh/NIPj1cnYuRyh73tj+UYbl1afb2guZsXGQRwLqiccEkTVLl9YVBg3w
 6Da43ktVUa1LQ==
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
Subject: [PATCH v3 7/7] vfio: Validate dma-buf revocation semantics
Date: Tue, 20 Jan 2026 16:07:07 +0200
Message-ID: <20260120-dmabuf-revoke-v3-7-b7e0b07b8214@nvidia.com>
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

Use the new dma_buf_attach_revocable() helper to restrict attachments to
importers that support mapping invalidation.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index 33bc6a1909dd..0c7782a51912 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -31,6 +31,9 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
 	if (priv->revoked)
 		return -ENODEV;
 
+	if (!dma_buf_attach_revocable(attachment))
+		return -EOPNOTSUPP;
+
 	return 0;
 }
 

-- 
2.52.0

