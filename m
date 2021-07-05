Return-Path: <SRS0=ZRVW=L5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B136C07E9B
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jul 2021 13:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3BD61416
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jul 2021 13:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3BD61416
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CB0E890B6;
	Mon,  5 Jul 2021 13:03:23 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFE56890B6;
 Mon,  5 Jul 2021 13:03:21 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 681BD61447;
 Mon,  5 Jul 2021 13:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625490201;
 bh=JAhM9uLnVQdWyUIJvWzQUlT2ptJXIZ6NsbSZCd1vRmw=;
 h=From:To:Cc:Subject:Date:From;
 b=joYZP1uH+TarU+TSon38rp2wt+bjwtNuJciGpFjdb3F1K3fX3tezOnUFc8Ios6DNY
 obi/Cbw3FuWNceIPuQebcJ1j2whR8GVHHpwvg6UWRL3aa9ZL+d9Btb1Ye+sCPDHrga
 y2b1NOizE+V2lzA7/2Tm9JYAAxXQaajaD/JbktNOmRmAe6gUywNXk7BwbZIzeLSwGY
 UQcS+bTw3qcin+aDxqzBTlSZwA1WUPe1oNAN43pAZ9AQLQvyl1afov3v8a2s4j/HFw
 ljIvlxl3lmPfo9n4YWXx0ToIwJ7KHaAYHEjfLTo5CkCxZOloaTU0ZxtZ06YYrSElFR
 c+iJniV0iYxHA==
From: Oded Gabbay <ogabbay@kernel.org>
To: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
Date: Mon,  5 Jul 2021 16:03:12 +0300
Message-Id: <20210705130314.11519-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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
Cc: linux-rdma@vger.kernel.org, daniel.vetter@ffwll.ch, sleybo@amazon.com,
 galpress@amazon.com, dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
 linaro-mm-sig@lists.linaro.org, jgg@ziepe.ca, dledford@redhat.com, hch@lst.de,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, airlied@gmail.com,
 sumit.semwal@linaro.org, leonro@nvidia.com, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,
I'm sending v4 of this patch-set following the long email thread.
I want to thank Jason for reviewing v3 and pointing out the errors, saving
us time later to debug it :)

I consulted with Christian on how to fix patch 2 (the implementation) and
at the end of the day I shamelessly copied the relevant content from
amdgpu_vram_mgr_alloc_sgt() and amdgpu_dma_buf_attach(), regarding the
usage of dma_map_resource() and pci_p2pdma_distance_many(), respectively.

I also made a few improvements after looking at the relevant code in amdgpu.
The details are in the changelog of patch 2.

I took the time to write an import code into the driver, allowing me to
check real P2P with two Gaudi devices, one as exporter and the other as
importer. I'm not going to include the import code in the product, it was
just for testing purposes (although I can share it if anyone wants).

I run it on a bare-metal environment with IOMMU enabled, on a sky-lake CPU
with a white-listed PCIe bridge (to make the pci_p2pdma_distance_many happy).

Greg, I hope this will be good enough for you to merge this code.

Thanks,
Oded

Oded Gabbay (1):
  habanalabs: define uAPI to export FD for DMA-BUF

Tomer Tayar (1):
  habanalabs: add support for dma-buf exporter

 drivers/misc/habanalabs/Kconfig             |   1 +
 drivers/misc/habanalabs/common/habanalabs.h |  26 ++
 drivers/misc/habanalabs/common/memory.c     | 480 +++++++++++++++++++-
 drivers/misc/habanalabs/gaudi/gaudi.c       |   1 +
 drivers/misc/habanalabs/goya/goya.c         |   1 +
 include/uapi/misc/habanalabs.h              |  28 +-
 6 files changed, 532 insertions(+), 5 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
