Return-Path: <SRS0=MNsS=OC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5E0C433FE
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Sep 2021 16:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4AB61051
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Sep 2021 16:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D4AB61051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D32C6E03A;
	Sun, 12 Sep 2021 16:53:17 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ABC16E03A;
 Sun, 12 Sep 2021 16:53:16 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F4A46103D;
 Sun, 12 Sep 2021 16:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631465596;
 bh=hWXd04iRoonKIYllliPipNavG0ogl8feAMJEpsYp1lg=;
 h=From:To:Cc:Subject:Date:From;
 b=Dl6IVrhh7WwKFWaOhzoqOwbt8G011NZ0T/ouDpKIYZkE+w8fiC3wG4/v+sd0m4Fck
 hkVFLI/8BvwAiqtqHv/RB60UBrJcIrLIIM9t4O+MCSDR6nzgL6eWRxe3v+JzbVqWKk
 MWUc3dsNJRLQV0aMgUF4PGt9epInExMQ2Le28h4XMzse95hWDWYNqkaVHpJ7cUKXjo
 hGve2sPeZLhJJ3+nCnVAeBZTVKZAAqAUjlXHaQCDuTyd3rtcgJQ8TSqe6+KSK1dLmx
 4iuJzUNu+n5yGZ4WSSYJhQ+RUO4y9rEV1z83KvDUCIrO1SMPB3M0CHB1ft6w1Rc4/l
 EvrhuA6yJb+ig==
From: Oded Gabbay <ogabbay@kernel.org>
To: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jgg@ziepe.ca
Cc: christian.koenig@amd.com, daniel.vetter@ffwll.ch, galpress@amazon.com,
 sleybo@amazon.com, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
 dledford@redhat.com, airlied@gmail.com, alexander.deucher@amd.com,
 leonro@nvidia.com, hch@lst.de, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH v6 0/2] Add p2p via dmabuf to habanalabs
Date: Sun, 12 Sep 2021 19:53:07 +0300
Message-Id: <20210912165309.98695-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
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

Hi,
Re-sending this patch-set following the release of our user-space TPC
compiler and runtime library.

I would appreciate a review on this.

Thanks,
Oded

Oded Gabbay (1):
  habanalabs: define uAPI to export FD for DMA-BUF

Tomer Tayar (1):
  habanalabs: add support for dma-buf exporter

 drivers/misc/habanalabs/Kconfig             |   1 +
 drivers/misc/habanalabs/common/habanalabs.h |  22 +
 drivers/misc/habanalabs/common/memory.c     | 522 +++++++++++++++++++-
 drivers/misc/habanalabs/gaudi/gaudi.c       |   1 +
 drivers/misc/habanalabs/goya/goya.c         |   1 +
 include/uapi/misc/habanalabs.h              |  28 +-
 6 files changed, 570 insertions(+), 5 deletions(-)

-- 
2.17.1

