Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722CCC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 01:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C5F20672
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 01:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C5F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED00E89AB9;
	Wed, 22 Jul 2020 01:53:33 +0000 (UTC)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6637D6E108;
 Wed, 22 Jul 2020 01:52:35 +0000 (UTC)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 46135F10C8CAD54FD757;
 Wed, 22 Jul 2020 09:52:30 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Jul 2020
 09:52:22 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <airlied@linux.ie>, <daniel@ffwll.ch>, <Jack.Zhang1@amd.com>
Subject: [PATCH -next] drm/amdgpu/vcn3.0: Remove set but not used variable
 'direct_poll'
Date: Wed, 22 Jul 2020 09:52:10 +0800
Message-ID: <20200722015210.29488-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 22 Jul 2020 01:53:32 +0000
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

drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c: In function vcn_v3_0_start_sriov:
drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:1235:3:
 warning: variable direct_poll set but not used [-Wunused-but-set-variable]

It is never used, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 910a4a32ff78..53f680134c40 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1231,8 +1231,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 		direct_wt = { {0} };
 	struct mmsch_v3_0_cmd_direct_read_modify_write
 		direct_rd_mod_wt = { {0} };
-	struct mmsch_v3_0_cmd_direct_polling
-		direct_poll = { {0} };
 	struct mmsch_v3_0_cmd_end end = { {0} };
 	struct mmsch_v3_0_init_header header;
 
@@ -1240,8 +1238,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 		MMSCH_COMMAND__DIRECT_REG_WRITE;
 	direct_rd_mod_wt.cmd_header.command_type =
 		MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE;
-	direct_poll.cmd_header.command_type =
-		MMSCH_COMMAND__DIRECT_REG_POLLING;
 	end.cmd_header.command_type =
 		MMSCH_COMMAND__END;
 
-- 
2.17.1


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
