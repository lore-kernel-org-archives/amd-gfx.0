Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E29C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 13:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D9820674
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 13:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D9820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D12656E3BB;
	Tue,  2 Jun 2020 13:15:32 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD92189C0A;
 Tue,  2 Jun 2020 09:17:05 +0000 (UTC)
IronPort-SDR: Hn8W7KaiScNMFjZTuT0tfjgNNx4d3owJRj8wAh54pWkMhkFcxgs6w5jV8JkKpJlnIdX9h9el9B
 FcrF7vw1/3Kw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2020 02:17:05 -0700
IronPort-SDR: x/s6TqMkfFCMf6Elj0L0Y8lX5QW2JWx9MUk5QQCfVZssNH9dEg0ZyETqw7Bb3OWNT1BFwpyD/P
 Tvjal8T4d0iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; d="scan'208";a="416118065"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
 by orsmga004.jf.intel.com with ESMTP; 02 Jun 2020 02:16:55 -0700
From: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Jens Axboe <axboe@kernel.dk>,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Jakub Kicinski <kuba@kernel.org>,
 Igor Russkikh <irusskikh@marvell.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, Brian King <brking@us.ibm.com>,
 "James E . J . Bottomley" <jejb@linux.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Jim Gill <jgill@vmware.com>, VMware PV-Drivers <pv-drivers@vmware.com>
Subject: [PATCH 00/15] forward MSIx vector enable error code in
 pci_alloc_irq_vectors_affinity
Date: Tue,  2 Jun 2020 11:16:17 +0200
Message-Id: <20200602091617.31395-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
X-Mailman-Approved-At: Tue, 02 Jun 2020 13:15:31 +0000
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
Cc: amd-gfx@lists.freedesktop.org, linux-scsi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Piotr Stankiewicz <piotr.stankiewicz@intel.com>, linux-crypto@vger.kernel.org,
 netdev@vger.kernel.org, dmaengine@vger.kernel.org, linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The primary objective of this patch series is to change the behaviour
of pci_alloc_irq_vectors_affinity such that it forwards the MSI-X enable
error code when appropriate. In the process, though, it was pointed out
that there are multiple places in the kernel which check/ask for message
signalled interrupts (MSI or MSI-X), which spawned the first patch adding
PCI_IRQ_MSI_TYPES. Finally the rest of the chain converts all users to
take advantage of PCI_IRQ_MSI_TYPES or PCI_IRQ_ALL_TYPES, as
appropriate.

Piotr Stankiewicz (15):
  PCI: add shorthand define for message signalled interrupt types
  PCI/MSI: forward MSIx vector enable error code in
    pci_alloc_irq_vectors_affinity
  PCI: use PCI_IRQ_MSI_TYPES where appropriate
  ahci: use PCI_IRQ_MSI_TYPES where appropriate
  crypto: inside-secure - use PCI_IRQ_MSI_TYPES where appropriate
  dmaengine: dw-edma: use PCI_IRQ_MSI_TYPES  where appropriate
  drm/amdgpu: use PCI_IRQ_MSI_TYPES where appropriate
  IB/qib: Use PCI_IRQ_MSI_TYPES where appropriate
  media: ddbridge: use PCI_IRQ_MSI_TYPES where appropriate
  vmw_vmci: use PCI_IRQ_ALL_TYPES where appropriate
  mmc: sdhci: use PCI_IRQ_MSI_TYPES where appropriate
  amd-xgbe: use PCI_IRQ_MSI_TYPES where appropriate
  aquantia: atlantic: use PCI_IRQ_ALL_TYPES where appropriate
  net: hns3: use PCI_IRQ_MSI_TYPES where appropriate
  scsi: use PCI_IRQ_MSI_TYPES and PCI_IRQ_ALL_TYPES where appropriate

 Documentation/PCI/msi-howto.rst                           | 5 +++--
 drivers/ata/ahci.c                                        | 2 +-
 drivers/crypto/inside-secure/safexcel.c                   | 2 +-
 drivers/dma/dw-edma/dw-edma-pcie.c                        | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c                   | 8 ++++----
 drivers/infiniband/hw/qib/qib_pcie.c                      | 2 +-
 drivers/media/pci/ddbridge/ddbridge-main.c                | 2 +-
 drivers/misc/vmw_vmci/vmci_guest.c                        | 3 +--
 drivers/mmc/host/sdhci-pci-gli.c                          | 3 +--
 drivers/mmc/host/sdhci-pci-o2micro.c                      | 3 +--
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c                  | 2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c      | 4 +---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 3 +--
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 2 +-
 drivers/pci/msi.c                                         | 4 ++--
 drivers/pci/pcie/portdrv_core.c                           | 4 ++--
 drivers/pci/switch/switchtec.c                            | 3 +--
 drivers/scsi/ipr.c                                        | 2 +-
 drivers/scsi/vmw_pvscsi.c                                 | 2 +-
 include/linux/pci.h                                       | 4 ++--
 20 files changed, 28 insertions(+), 34 deletions(-)

-- 
2.17.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
