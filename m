Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B28AC3F2CD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 03:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6AC2073B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 03:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6AC2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mikelr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB2706E408;
	Thu,  5 Mar 2020 03:43:48 +0000 (UTC)
Received: from yyz.mikelr.com (unknown
 [IPv6:2602:ffb6:2:0:f816:3eff:fe0d:377b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEDC86E03E
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 03:41:45 +0000 (UTC)
Received: from glidewell.ykf.mikelr.com (198-84-194-208.cpe.teksavvy.com
 [198.84.194.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by yyz.mikelr.com (Postfix) with ESMTPSA id 439B43D085;
 Wed,  4 Mar 2020 22:41:44 -0500 (EST)
From: Mikel Rychliski <mikel@mikelr.com>
To: amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
 nouveau@lists.freedesktop.org
Subject: [PATCH v2 0/2] Fix loading of platform ROM from 32-bit EFI
Date: Wed,  4 Mar 2020 22:41:24 -0500
Message-Id: <20200305034126.6989-1-mikel@mikelr.com>
X-Mailer: git-send-email 2.13.7
X-Mailman-Approved-At: Thu, 05 Mar 2020 03:43:47 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Matthew Garrett <matthewgarrett@google.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Ben Skeggs <bskeggs@redhat.com>,
 Mikel Rychliski <mikel@mikelr.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch series fixes an oops when loading the radeon driver on old Macs
with a 32-bit EFI implementation.

Tested on a MacPro 1,1 with a Radeon X1900 XT card and 32-bit kernel.

Mikel Rychliski (2):
  drm/radeon: Stop directly referencing iomem
  PCI: Use ioremap(), not phys_to_virt() for platform ROM

 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c             |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowpci.c | 11 ++++++++++-
 drivers/gpu/drm/radeon/radeon_bios.c                 | 12 ++++++++----
 drivers/pci/rom.c                                    |  9 ++++++---
 4 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.13.7

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
