Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF25C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 14:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF3EE10EA65;
	Fri, 21 Jan 2022 14:07:54 +0000 (UTC)
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 721C710EB1F;
 Fri, 21 Jan 2022 11:48:20 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R671e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0V2RfKTK_1642765682; 
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0V2RfKTK_1642765682) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 21 Jan 2022 19:48:07 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: evan.quan@amd.com
Subject: [PATCH] drm/amd/pm: remove useless if
Date: Fri, 21 Jan 2022 19:48:00 +0800
Message-Id: <20220121114800.95459-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Jan 2022 14:07:53 +0000
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
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, airlied@linux.ie,
 Xinhui.Pan@amd.com, Abaci Robot <abaci@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Clean the following coccicheck warning:

./drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c:7035:2-4: WARNING: possible
condition with no effect (if == else).

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 23ff0d812e4b..7427c50409d4 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7032,10 +7032,7 @@ static int si_power_control_set_level(struct amdgpu_device *adev)
 	ret = si_resume_smc(adev);
 	if (ret)
 		return ret;
-	ret = si_set_sw_state(adev);
-	if (ret)
-		return ret;
-	return 0;
+	return si_set_sw_state(adev);
 }
 
 static void si_set_vce_clock(struct amdgpu_device *adev,
-- 
2.20.1.7.g153144c

