Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E7FC47077
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 09:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6BBF10E8A4;
	Thu, 11 Jan 2024 09:05:07 +0000 (UTC)
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.219])
 by gabe.freedesktop.org (Postfix) with ESMTP id A067A10E18A;
 Thu, 11 Jan 2024 08:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=EdwkIfTSeV+DEasRQ1
 DrTVemJN0cc/VUOnUfemJESuA=; b=LoRzmpVsm/tfsGH7czRoYTCM1z2lLGz/WW
 S1urIPDX1dY2reDQ1/8uhTu5YurDU0AQk12EWZBb50RnxK4oUMPolIhHJSOLvEtQ
 nHZG+9p8ecR3aWwzwBOyzBSmF1lYX0poxPk0oYwNDcnCTirQLpx+iaLFUMoHDydO
 PF6kx9pxs=
Received: from localhost.localdomain (unknown [182.148.14.173])
 by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wD3X+DKoZ9l4YOTAA--.19175S2;
 Thu, 11 Jan 2024 16:07:39 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: daniel@ffwll.ch, Xinhui.Pan@amd.com, airlied@gmail.com,
 christian.koenig@amd.com, alexander.deucher@amd.com
Subject: [PATCH] drm/radeon/rv770: Clean up errors in rv770_dpm.c
Date: Thu, 11 Jan 2024 08:07:35 +0000
Message-Id: <20240111080735.11217-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3X+DKoZ9l4YOTAA--.19175S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWrKF4fKr1DurWDGrWfZrb_yoW8Jw1Upw
 4S93s8ursxAr1Y9a129a18KryfW3WkJFy2qr4xG3WjkayUJryUAFZI9r43JF93KF929Fy7
 tFyIgry7ua10yr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UzUDAUUUUU=
X-Originating-IP: [182.148.14.173]
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEAdi1mVOBk8scQABsd
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
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, GuoHua Chen <chenguohua_716@163.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: space prohibited before that close parenthesis ')'

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/rv770_dpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/rv770_dpm.c b/drivers/gpu/drm/radeon/rv770_dpm.c
index ef2f1a048cfe..e3e1f6833f12 100644
--- a/drivers/gpu/drm/radeon/rv770_dpm.c
+++ b/drivers/gpu/drm/radeon/rv770_dpm.c
@@ -1010,7 +1010,7 @@ int rv770_populate_initial_mvdd_value(struct radeon_device *rdev,
 	struct rv7xx_power_info *pi = rv770_get_pi(rdev);
 
 	if ((pi->s0_vid_lower_smio_cntl & pi->mvdd_mask_low) ==
-	     (pi->mvdd_low_smio[MVDD_LOW_INDEX] & pi->mvdd_mask_low) ) {
+	     (pi->mvdd_low_smio[MVDD_LOW_INDEX] & pi->mvdd_mask_low)) {
 		voltage->index = MVDD_LOW_INDEX;
 		voltage->value = cpu_to_be16(MVDD_LOW_VALUE);
 	} else {
@@ -1260,7 +1260,7 @@ static int rv770_construct_vddc_table(struct radeon_device *rdev)
 		pi->vddc_mask_low = gpio_mask;
 		if (i > 0) {
 			if ((pi->vddc_table[i].low_smio !=
-			     pi->vddc_table[i - 1].low_smio ) ||
+			     pi->vddc_table[i - 1].low_smio) ||
 			     (pi->vddc_table[i].high_smio !=
 			      pi->vddc_table[i - 1].high_smio))
 				vddc_index++;
-- 
2.17.1

