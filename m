Return-Path: <SRS0=l0jK=2O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF22C2D0D5
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 18:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4CCD206CB
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 18:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CCD206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D9F06E359;
	Tue, 24 Dec 2019 18:09:17 +0000 (UTC)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98DA56E08A;
 Tue, 24 Dec 2019 03:20:33 +0000 (UTC)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 5EC36E79F2ED3EA6C7C0;
 Tue, 24 Dec 2019 11:20:31 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 11:20:24 +0800
From: zhengbin <zhengbin13@huawei.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amd/display: use true,
 false for bool variable in display_mode_vba_21.c
Date: Tue, 24 Dec 2019 11:27:39 +0800
Message-ID: <1577158063-76188-5-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577158063-76188-1-git-send-email-zhengbin13@huawei.com>
References: <1577158063-76188-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 24 Dec 2019 18:09:10 +0000
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

drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c:4124:3-28: WARNING: Assignment of 0/1 to bool variable
drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c:4128:5-30: WARNING: Assignment of 0/1 to bool variable
drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c:5207:3-37: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index 945291d..b6d3466 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -4121,11 +4121,11 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 	for (i = 0; i <= mode_lib->vba.soc.num_states; i++) {
 		for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
-			locals->RequiresDSC[i][k] = 0;
+			locals->RequiresDSC[i][k] = false;
 			locals->RequiresFEC[i][k] = 0;
 			if (mode_lib->vba.BlendingAndTiming[k] == k) {
 				if (mode_lib->vba.Output[k] == dm_hdmi) {
-					locals->RequiresDSC[i][k] = 0;
+					locals->RequiresDSC[i][k] = false;
 					locals->RequiresFEC[i][k] = 0;
 					locals->OutputBppPerState[i][k] = TruncToValidBPP(
 							dml_min(600.0, mode_lib->vba.PHYCLKPerState[i]) / mode_lib->vba.PixelClockBackEnd[k] * 24,
@@ -5204,7 +5204,7 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			mode_lib->vba.ODMCombineEnabled[k] =
 					locals->ODMCombineEnablePerState[mode_lib->vba.VoltageLevel][k];
 		} else {
-			mode_lib->vba.ODMCombineEnabled[k] = 0;
+			mode_lib->vba.ODMCombineEnabled[k] = false;
 		}
 		mode_lib->vba.DSCEnabled[k] =
 				locals->RequiresDSC[mode_lib->vba.VoltageLevel][k];
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
