Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53D2C47257
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 14:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84DD520769
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 14:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DD520769
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B02328999C;
	Wed,  6 May 2020 14:27:49 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DC9389830;
 Wed,  6 May 2020 14:26:32 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0FB53941B130165484AB;
 Wed,  6 May 2020 22:26:27 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 6 May 2020
 22:26:19 +0800
From: Zheng Bin <zhengbin13@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 04/14] drm/radeon: remove comparison to bool in
 radeon_atpx_handler.c
Date: Wed, 6 May 2020 22:33:16 +0800
Message-ID: <20200506143326.66467-5-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
In-Reply-To: <20200506143326.66467-1-zhengbin13@huawei.com>
References: <20200506143326.66467-1-zhengbin13@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 06 May 2020 14:27:48 +0000
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
Cc: zhengbin13@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes coccicheck warning:

drivers/gpu/drm/radeon/radeon_atpx_handler.c:561:15-49: WARNING: Comparison to bool
drivers/gpu/drm/radeon/radeon_atpx_handler.c:571:15-49: WARNING: Comparison to bool

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/gpu/drm/radeon/radeon_atpx_handler.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
index 6f93f54bf651..6131917322b4 100644
--- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
+++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
@@ -558,7 +558,7 @@ static bool radeon_atpx_detect(void)
 	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
 		vga_count++;

-		has_atpx |= (radeon_atpx_pci_probe_handle(pdev) == true);
+		has_atpx |= radeon_atpx_pci_probe_handle(pdev);

 		parent_pdev = pci_upstream_bridge(pdev);
 		d3_supported |= parent_pdev && parent_pdev->bridge_d3;
@@ -568,7 +568,7 @@ static bool radeon_atpx_detect(void)
 	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, pdev)) != NULL) {
 		vga_count++;

-		has_atpx |= (radeon_atpx_pci_probe_handle(pdev) == true);
+		has_atpx |= radeon_atpx_pci_probe_handle(pdev);

 		parent_pdev = pci_upstream_bridge(pdev);
 		d3_supported |= parent_pdev && parent_pdev->bridge_d3;
--
2.26.0.106.g9fadedd

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
