Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B59C5517A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 03:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CACC720731
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 03:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wna2NBh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACC720731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 715E98981D;
	Tue, 10 Nov 2020 03:56:58 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EA898981D;
 Tue, 10 Nov 2020 03:56:57 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5C473208FE;
 Tue, 10 Nov 2020 03:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604980617;
 bh=Z/YgsnwfhkS28seydQ/oqHbW2Cq5yaLndiz+w91ebe8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Wna2NBh3t5UEzq4Wbvt+yj9OGcfGdi7VSFl8Q5cliB3znCS7wNBtzexGQsQSvBv8g
 Reews/QNcmAufAkqdv2Jhiq8Fz6pNlHoPdThYOlKy4kP+KuqS8azl3b/WZo7SNwwEf
 9vnlas0XqTF7ljFiYwbpIVfPCncxppHq4/M7AmXY=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 04/10] drm/amdgpu: perform srbm soft reset always
 on SDMA resume
Date: Mon,  9 Nov 2020 22:56:45 -0500
Message-Id: <20201110035651.425177-4-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201110035651.425177-1-sashal@kernel.org>
References: <20201110035651.425177-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Sandeep Raghuraman <sandy.8925@gmail.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

[ Upstream commit 253475c455eb5f8da34faa1af92709e7bb414624 ]

This can address the random SDMA hang after pci config reset
seen on Hawaii.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Tested-by: Sandeep Raghuraman <sandy.8925@gmail.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index c568293cb6c1a..f1745c5cdf7b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -1118,22 +1118,19 @@ static int cik_sdma_soft_reset(void *handle)
 {
 	u32 srbm_soft_reset = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	u32 tmp = RREG32(mmSRBM_STATUS2);
+	u32 tmp;
 
-	if (tmp & SRBM_STATUS2__SDMA_BUSY_MASK) {
-		/* sdma0 */
-		tmp = RREG32(mmSDMA0_F32_CNTL + SDMA0_REGISTER_OFFSET);
-		tmp |= SDMA0_F32_CNTL__HALT_MASK;
-		WREG32(mmSDMA0_F32_CNTL + SDMA0_REGISTER_OFFSET, tmp);
-		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_SDMA_MASK;
-	}
-	if (tmp & SRBM_STATUS2__SDMA1_BUSY_MASK) {
-		/* sdma1 */
-		tmp = RREG32(mmSDMA0_F32_CNTL + SDMA1_REGISTER_OFFSET);
-		tmp |= SDMA0_F32_CNTL__HALT_MASK;
-		WREG32(mmSDMA0_F32_CNTL + SDMA1_REGISTER_OFFSET, tmp);
-		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_SDMA1_MASK;
-	}
+	/* sdma0 */
+	tmp = RREG32(mmSDMA0_F32_CNTL + SDMA0_REGISTER_OFFSET);
+	tmp |= SDMA0_F32_CNTL__HALT_MASK;
+	WREG32(mmSDMA0_F32_CNTL + SDMA0_REGISTER_OFFSET, tmp);
+	srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_SDMA_MASK;
+
+	/* sdma1 */
+	tmp = RREG32(mmSDMA0_F32_CNTL + SDMA1_REGISTER_OFFSET);
+	tmp |= SDMA0_F32_CNTL__HALT_MASK;
+	WREG32(mmSDMA0_F32_CNTL + SDMA1_REGISTER_OFFSET, tmp);
+	srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_SDMA1_MASK;
 
 	if (srbm_soft_reset) {
 		cik_sdma_print_status((void *)adev);
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
