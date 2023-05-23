Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAF2C7EE23
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 09:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C68110E414;
	Tue, 23 May 2023 09:25:04 +0000 (UTC)
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E835C10E09E;
 Tue, 23 May 2023 03:32:16 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R921e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0VjIH3CS_1684812723; 
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0VjIH3CS_1684812723) by smtp.aliyun-inc.com;
 Tue, 23 May 2023 11:32:11 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: christian.koenig@amd.com
Subject: [PATCH] drm/amdgpu/vcn: Modify mismatched function name
Date: Tue, 23 May 2023 11:32:02 +0800
Message-Id: <20230523033202.109828-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 May 2023 09:25:02 +0000
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
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Xinhui.Pan@amd.com,
 Abaci Robot <abaci@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch, airlied@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No functional modification involved.

drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:374: warning: expecting prototype for vcn_v4_0_mc_resume_dpg_mode(). Prototype was for vcn_v4_0_3_mc_resume_dpg_mode() instead.
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:631: warning: expecting prototype for vcn_v4_0_enable_clock_gating(). Prototype was for vcn_v4_0_3_enable_clock_gating() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=5284
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 339842382a1e..5d67b8b8a3d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -362,7 +362,7 @@ static void vcn_v4_0_3_mc_resume(struct amdgpu_device *adev, int inst_idx)
 }
 
 /**
- * vcn_v4_0_mc_resume_dpg_mode - memory controller programming for dpg mode
+ * vcn_v4_0_3_mc_resume_dpg_mode - memory controller programming for dpg mode
  *
  * @adev: amdgpu_device pointer
  * @inst_idx: instance number index
@@ -620,7 +620,7 @@ static void vcn_v4_0_3_disable_clock_gating_dpg_mode(struct amdgpu_device *adev,
 }
 
 /**
- * vcn_v4_0_enable_clock_gating - enable VCN clock gating
+ * vcn_v4_0_3_enable_clock_gating - enable VCN clock gating
  *
  * @adev: amdgpu_device pointer
  * @inst_idx: instance number
-- 
2.20.1.7.g153144c

