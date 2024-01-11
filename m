Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C5EC4725D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 09:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1AEC10E8AB;
	Thu, 11 Jan 2024 09:04:30 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by gabe.freedesktop.org (Postfix) with ESMTP id BC76510E589;
 Thu, 11 Jan 2024 08:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=Ec0SMURkHcRLbm9pR8
 p3/Y4NEdzpA/NYtXmEiNFKUR8=; b=AaxgRjc7rY6+RThdQlV5O8IjXjitP6pBmR
 S3LtCfx7XAboWi+WKhAOrjmY2UUoisqSERwpqsQiIiIivSYJDR67b8A6qg/JbrwP
 NFCIvH9AicjJRglkpNzDRQdc6qzotreEnYqEnZRRi+uYZZ5bjS+8BqzU+DvR2X8F
 eGYZHC5cA=
Received: from localhost.localdomain (unknown [182.148.14.173])
 by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wDnb5FbpJ9lFPKUAA--.20884S2;
 Thu, 11 Jan 2024 16:18:35 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: daniel@ffwll.ch, Xinhui.Pan@amd.com, alexander.deucher@amd.com,
 airlied@gmail.com, christian.koenig@amd.com
Subject: [PATCH] drm/radeon: Clean up errors in radeon_asic.c
Date: Thu, 11 Jan 2024 08:18:34 +0000
Message-Id: <20240111081834.11664-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wDnb5FbpJ9lFPKUAA--.20884S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4kWr13GFW5Zr47KFyDWrg_yoWDuFcEgr
 WDZryxJas2yF93WF17Cr1jkFySkr409rWrWF12q3WFqry8WryxXFW5JFyUZw4UX3Wakr1D
 Jr18KFnxJrs3KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUZXo7UUUUU==
X-Originating-IP: [182.148.14.173]
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEB5i1mVOBk+DQQACsY
X-Mailman-Approved-At: Thu, 11 Jan 2024 09:04:25 +0000
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
Cc: GuoHua Chen <chenguohua_716@163.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: spaces required around that '||' (ctx:VxE)

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/radeon_asic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_asic.c b/drivers/gpu/drm/radeon/radeon_asic.c
index 802b5af19261..b5a0109b2e2c 100644
--- a/drivers/gpu/drm/radeon/radeon_asic.c
+++ b/drivers/gpu/drm/radeon/radeon_asic.c
@@ -2400,10 +2400,10 @@ int radeon_asic_init(struct radeon_device *rdev)
 	case CHIP_RS880:
 		rdev->asic = &rs780_asic;
 		/* 760G/780V/880V don't have UVD */
-		if ((rdev->pdev->device == 0x9616)||
-		    (rdev->pdev->device == 0x9611)||
-		    (rdev->pdev->device == 0x9613)||
-		    (rdev->pdev->device == 0x9711)||
+		if ((rdev->pdev->device == 0x9616) ||
+		    (rdev->pdev->device == 0x9611) ||
+		    (rdev->pdev->device == 0x9613) ||
+		    (rdev->pdev->device == 0x9711) ||
 		    (rdev->pdev->device == 0x9713))
 			rdev->has_uvd = false;
 		else
-- 
2.17.1

