Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2F8C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 07:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D51632078B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 07:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51632078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB8CA6E2AF;
	Thu, 10 Sep 2020 07:29:37 +0000 (UTC)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2E9289FA6;
 Thu, 10 Sep 2020 03:14:12 +0000 (UTC)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6E1C1469BF9A48FFFFD1;
 Thu, 10 Sep 2020 11:14:07 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 11:14:00 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>, <airlied@linux.ie>,
 <daniel@ffwll.ch>, <mikita.lipski@amd.com>, <eryk.brol@amd.com>
Subject: [PATCH -next] drm/amd/display: Create trigger_hotplug entry
Date: Thu, 10 Sep 2020 11:13:52 +0800
Message-ID: <20200910031352.39992-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 10 Sep 2020 07:29:37 +0000
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
Cc: YueHaibing <yuehaibing@huawei.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add trigger_hotplug debugfs entry.

Fixes: 6f77b2ac6280 ("drm/amd/display: Add connector HPD trigger debugfs entry")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 94fcb086154c..83da24aced45 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2098,6 +2098,7 @@ static const struct {
 	const struct file_operations *fops;
 } dp_debugfs_entries[] = {
 		{"link_settings", &dp_link_settings_debugfs_fops},
+		{"trigger_hotplug", &dp_trigger_hotplug_debugfs_fops},
 		{"phy_settings", &dp_phy_settings_debugfs_fop},
 		{"test_pattern", &dp_phy_test_pattern_fops},
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-- 
2.17.1


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
