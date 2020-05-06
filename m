Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E1BC47256
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 14:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E68C920769
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 14:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68C920769
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C8586E888;
	Wed,  6 May 2020 14:27:50 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E6908989A;
 Wed,  6 May 2020 14:26:31 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 04F18B72BC3D72B57A71;
 Wed,  6 May 2020 22:26:27 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 6 May 2020
 22:26:19 +0800
From: Zheng Bin <zhengbin13@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 03/14] drm/radeon: remove comparison to bool in ni_dpm.c
Date: Wed, 6 May 2020 22:33:15 +0800
Message-ID: <20200506143326.66467-4-zhengbin13@huawei.com>
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

drivers/gpu/drm/radeon/ni_dpm.c:807:5-26: WARNING: Comparison to bool
drivers/gpu/drm/radeon/ni_dpm.c:2466:5-36: WARNING: Comparison to boo
drivers/gpu/drm/radeon/ni_dpm.c:3146:5-22: WARNING: Comparison to bool

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/gpu/drm/radeon/ni_dpm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ni_dpm.c b/drivers/gpu/drm/radeon/ni_dpm.c
index b57c37ddd164..66c48ce107a5 100644
--- a/drivers/gpu/drm/radeon/ni_dpm.c
+++ b/drivers/gpu/drm/radeon/ni_dpm.c
@@ -804,7 +804,7 @@ static void ni_apply_state_adjust_rules(struct radeon_device *rdev,
 	else
 		max_limits = &rdev->pm.dpm.dyn_state.max_clock_voltage_on_dc;

-	if (rdev->pm.dpm.ac_power == false) {
+	if (!rdev->pm.dpm.ac_power) {
 		for (i = 0; i < ps->performance_level_count; i++) {
 			if (ps->performance_levels[i].mclk > max_limits->mclk)
 				ps->performance_levels[i].mclk = max_limits->mclk;
@@ -2463,7 +2463,7 @@ static int ni_populate_power_containment_values(struct radeon_device *rdev,
 	u32 power_boost_limit;
 	u8 max_ps_percent;

-	if (ni_pi->enable_power_containment == false)
+	if (!ni_pi->enable_power_containment)
 		return 0;

 	if (state->performance_level_count == 0)
@@ -3143,7 +3143,7 @@ static int ni_initialize_smc_cac_tables(struct radeon_device *rdev)
 	int i, ret;
 	u32 reg;

-	if (ni_pi->enable_cac == false)
+	if (!ni_pi->enable_cac)
 		return 0;

 	cac_tables = kzalloc(sizeof(PP_NIslands_CACTABLES), GFP_KERNEL);
--
2.26.0.106.g9fadedd

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
