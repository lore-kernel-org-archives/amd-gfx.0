Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CEBC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 13:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC718611C9
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 13:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC718611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC77C6E491;
	Mon, 10 May 2021 13:57:55 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E82656E159;
 Mon, 10 May 2021 12:24:15 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Ff0XZ24QHzCr37;
 Mon, 10 May 2021 20:21:34 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 20:24:03 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx
 <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Delete two unneeded bool conversions
Date: Mon, 10 May 2021 20:23:38 +0800
Message-ID: <20210510122338.3748-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 10 May 2021 13:57:54 +0000
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
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The result of an expression consisting of a single relational operator is
already of the bool type and does not need to be evaluated explicitly.

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index a9899335d0b1fb0..709ac576ac7e892 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -569,9 +569,9 @@ static int mmhub_v2_3_set_clockgating(struct amdgpu_device *adev,
 		return 0;
 
 	mmhub_v2_3_update_medium_grain_clock_gating(adev,
-			state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 	mmhub_v2_3_update_medium_grain_light_sleep(adev,
-			state == AMD_CG_STATE_GATE ? true : false);
+				state == AMD_CG_STATE_GATE);
 
 	return 0;
 }
-- 
2.26.0.106.g9fadedd


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
