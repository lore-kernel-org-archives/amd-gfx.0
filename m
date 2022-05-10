Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AD1C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 07:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FB9910F5C9;
	Tue, 10 May 2022 07:43:03 +0000 (UTC)
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Tue, 10 May 2022 06:10:09 UTC
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C84710EFFA
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 06:10:08 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0VCpD4Yc_1652162694; 
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0VCpD4Yc_1652162694) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 10 May 2022 14:05:03 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: clean up some inconsistent indenting
Date: Tue, 10 May 2022 14:04:40 +0800
Message-Id: <20220510060440.67178-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 May 2022 07:43:01 +0000
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
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, daniel@ffwll.ch, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Eliminate the follow smatch warning:

drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c:35 nbio_v7_7_get_rev_id() warn:
inconsistent indenting.

drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c:214 nbio_v7_7_init_registers()
warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
index e32c874b42b5..cdc0c9779848 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -32,8 +32,7 @@ static u32 nbio_v7_7_get_rev_id(struct amdgpu_device *adev)
 {
 	u32 tmp;
 
-		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
-
+	tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
 	tmp &= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
 	tmp >>= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
 
@@ -211,14 +210,14 @@ static void nbio_v7_7_init_registers(struct amdgpu_device *adev)
 {
 	uint32_t def, data;
 
-		def = data = RREG32_SOC15(NBIO, 0, regBIF0_PCIE_MST_CTRL_3);
-		data = REG_SET_FIELD(data, BIF0_PCIE_MST_CTRL_3,
-			CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
-		data = REG_SET_FIELD(data, BIF0_PCIE_MST_CTRL_3,
-			CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV, 1);
+	def = data = RREG32_SOC15(NBIO, 0, regBIF0_PCIE_MST_CTRL_3);
+	data = REG_SET_FIELD(data, BIF0_PCIE_MST_CTRL_3,
+			     CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
+	data = REG_SET_FIELD(data, BIF0_PCIE_MST_CTRL_3,
+			     CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV, 1);
 
-		if (def != data)
-			WREG32_SOC15(NBIO, 0, regBIF0_PCIE_MST_CTRL_3, data);
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regBIF0_PCIE_MST_CTRL_3, data);
 
 }
 
-- 
2.20.1.7.g153144c

