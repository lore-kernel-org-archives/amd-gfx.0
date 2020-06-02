Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73B7C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 13:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 838AB20674
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 13:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838AB20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F36A6E3B7;
	Tue,  2 Jun 2020 13:15:32 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3662D89C3F;
 Tue,  2 Jun 2020 09:20:41 +0000 (UTC)
IronPort-SDR: lKTIVbVRuy3pdOD5JLHA3GFvrR2UWr+CSBkbQc4WYGpCvPoEnNNOHgC+86/ol8CgNtsW3MXE3X
 WOB0XkucxDkg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2020 02:20:40 -0700
IronPort-SDR: 2jrTq9czAJgHkfCg8Sfvuvet4XPOvwOSY4Atd02F/9QchcTH81ecRpuWw75snVAW5Anx6j1Jx0
 5mzvQcFm0VTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; d="scan'208";a="312219453"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
 by FMSMGA003.fm.intel.com with ESMTP; 02 Jun 2020 02:20:38 -0700
From: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 07/15] drm/amdgpu: use PCI_IRQ_MSI_TYPES where appropriate
Date: Tue,  2 Jun 2020 11:20:30 +0200
Message-Id: <20200602092030.31966-1-piotr.stankiewicz@intel.com>
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
Cc: Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Seeing as there is shorthand available to use when asking for any type
of interrupt, or any type of message signalled interrupt, leverage it.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 5ed4227f304b..6dbe173a9fd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -251,11 +251,11 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 		int nvec = pci_msix_vec_count(adev->pdev);
 		unsigned int flags;
 
-		if (nvec <= 0) {
+		if (nvec > 0)
+			flags = PCI_IRQ_MSI_TYPES;
+		else
 			flags = PCI_IRQ_MSI;
-		} else {
-			flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
-		}
+
 		/* we only need one vector */
 		nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
 		if (nvec > 0) {
-- 
2.17.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
