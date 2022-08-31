Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D07BECAAD4
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Aug 2022 15:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E11B210E454;
	Wed, 31 Aug 2022 15:43:49 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04A2F10E43B;
 Wed, 31 Aug 2022 15:39:47 +0000 (UTC)
Received: from dimapc.. (109-252-119-13.nat.spd-mgts.ru [109.252.119.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id E84C66601DF5;
 Wed, 31 Aug 2022 16:39:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1661960385;
 bh=/oF5kgcekO75Xv0wAeHKpq3Pgp50WSiycM6oE7wSKRk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Sl51L1bR+Y9SxOT89Q/0nVkX+TLwDp7OcA2pgpm4I/3SumRue+tVnK1q3Vw+RbjOE
 Xl6atoNl+C31e92BVfqyqVAKhtHD6pK31qCu8j0Uno1FBRl+Xnj8l7hTvW36MZfXLi
 kMxfgy3gfal5jhWoFiCx8em30aMFpWCXq0oZzUxpaNj57iukLilYisYbjMXYFNRDzp
 tG9ew+QPiTBRtgqpD4xjf85rqFOoNtYODtXw+U5QgdYnxMPA+B0E74wOPuZ76PdATv
 levx+u2+qDHOjLZIoeA6U5Vu7faXHIfhzUMg9Cz0ga92kx/uZARd8jrxI2uVDGG2GD
 SZaDsJp2+o7cw==
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Clark <robdclark@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
 Qiang Yu <yuq825@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Tomi Valkeinen <tomba@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Lucas Stach <l.stach@pengutronix.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH v4 10/21] RDMA/umem: Prepare to dynamic dma-buf locking
 specification
Date: Wed, 31 Aug 2022 18:37:46 +0300
Message-Id: <20220831153757.97381-11-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831153757.97381-1-dmitry.osipenko@collabora.com>
References: <20220831153757.97381-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 31 Aug 2022 15:43:46 +0000
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
Cc: linux-rdma@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com,
 linux-media@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Prepare InfiniBand drivers to the common dynamic dma-buf locking
convention by starting to use the unlocked versions of dma-buf API
functions.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/infiniband/core/umem_dmabuf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index 04c04e6d24c3..43b26bc12288 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -26,7 +26,8 @@ int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf)
 	if (umem_dmabuf->sgt)
 		goto wait_fence;
 
-	sgt = dma_buf_map_attachment(umem_dmabuf->attach, DMA_BIDIRECTIONAL);
+	sgt = dma_buf_map_attachment_unlocked(umem_dmabuf->attach,
+					      DMA_BIDIRECTIONAL);
 	if (IS_ERR(sgt))
 		return PTR_ERR(sgt);
 
@@ -102,8 +103,8 @@ void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf)
 		umem_dmabuf->last_sg_trim = 0;
 	}
 
-	dma_buf_unmap_attachment(umem_dmabuf->attach, umem_dmabuf->sgt,
-				 DMA_BIDIRECTIONAL);
+	dma_buf_unmap_attachment_unlocked(umem_dmabuf->attach, umem_dmabuf->sgt,
+					  DMA_BIDIRECTIONAL);
 
 	umem_dmabuf->sgt = NULL;
 }
-- 
2.37.2

