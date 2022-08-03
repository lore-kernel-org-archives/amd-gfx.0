Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD35C00144
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Aug 2022 07:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA018F53A;
	Thu,  4 Aug 2022 07:20:45 +0000 (UTC)
X-Greylist: delayed 433 seconds by postgrey-1.36 at gabe;
 Wed, 03 Aug 2022 09:28:28 UTC
Received: from qq.com (smtpbg401.qq.com [113.96.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1E2C10EA0F;
 Wed,  3 Aug 2022 09:28:28 +0000 (UTC)
X-QQ-mid: bizesmtp66t1659518422tzylbcvz
Received: from localhost.localdomain ( [58.240.82.166])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 03 Aug 2022 17:20:15 +0800 (CST)
X-QQ-SSF: 01400000002000C0K000B00C0000000
X-QQ-FEAT: SX/WFj88WPUxbTF4fAIy8feA+WbS0O/OdVIzxiN547FytXi3P1FLnwSOmn5Ue
 GLflUhkiIY0OHLxLWqNHfRMF1NyEPY299Fn9TpbE+qsJQvjLbyO9hE/r9hQJEzKE7aQi9yl
 kUY1OiWrmJtReOBNsVxA1j1fgtKTz9ik2D5Es8dIBfgkfRdHkPb/Wjiwokant2XroxS1PZL
 yhIQSbH9aS14LMec+cOSbLFV9f636CiavPxXwc1ONXb2+bEwSkOWMr8U2bhTwTNWH0nJj84
 6/0NgasvDcCWYGCBHWjcfNgomBtqYvf7Y6W8z8Zbd1H5Q+KTotX+Nv2u+oOOwgrFd3sMMk4
 hwqP3a63xmaL41XwJ0j/BFILIHlggrYZbiOnExPqtcaGg4/T1Xyi5Kdu+HFX/NXeW6iZ85V
X-QQ-GoodBg: 2
From: Zhen Ni <nizhen@uniontech.com>
To: airlied@linux.ie, daniel@ffwll.ch, evan.quan@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com
Subject: [PATCH 1/2] drm/amd/pm: Fix a potential gpu_metrics_table memory leak
Date: Wed,  3 Aug 2022 17:19:58 +0800
Message-Id: <20220803091959.10030-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign3
X-QQ-Bgrelay: 1
X-Mailman-Approved-At: Thu, 04 Aug 2022 07:20:42 +0000
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
Cc: Zhen Ni <nizhen@uniontech.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Memory is allocated for gpu_metrics_table in
smu_v13_0_4_init_smc_tables(), but not freed in
smu_v13_0_4_fini_smc_tables(). This may cause memory leaks, fix it.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 5a17b51aa0f9..7df360c25d51 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -190,6 +190,9 @@ static int smu_v13_0_4_fini_smc_tables(struct smu_context *smu)
 	kfree(smu_table->watermarks_table);
 	smu_table->watermarks_table = NULL;
 
+	kfree(smu_table->gpu_metrics_table);
+	smu_table->gpu_metrics_table = NULL;
+
 	return 0;
 }
 
-- 
2.20.1



