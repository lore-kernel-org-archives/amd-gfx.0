Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58447C11F70
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F7D861C43
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7D861C43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64F0A6E0CE;
	Tue,  6 Jul 2021 11:15:44 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDC806E0AA;
 Tue,  6 Jul 2021 11:15:42 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0A9A61C28;
 Tue,  6 Jul 2021 11:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625570142;
 bh=MO40KtTCzKgw6sjeqzbXc98VsztHqIQAJjBSUAiLKnc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RD+7Kv6kH/l0O7qAPNY5I2bbcx2Brxw5dvkwnVefshVdnYKhmNylk4mBE5n5V2tTL
 TsIR/+YFhlmRTc2bKdftll13IsDFc4P2A5DqBpY+yefnS3+UUMUR6Taxw0A00azGqx
 9JQBlNP6l5lOVoQ9ZXAIRP7JJn+ecqiopq40ukM9szNstOk73bu2yiFWWBz1aW8SAc
 VFJ7uKJj9qSfL+XvbsXi9lZXq1KuSkwVpSDc2fI9mCAc8eldohAufG+1VjYaJZm0XX
 GQNJSS6cxTGIhZzXe067nPj4ytH3u+gTS1O/i+TxmcEZXvhyUw9apmfFDEquGuDTbW
 4VqKMkUKojGVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 067/189] drm/amdgpu: fix sdma firmware version
 error in sriov
Date: Tue,  6 Jul 2021 07:12:07 -0400
Message-Id: <20210706111409.2058071-67-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706111409.2058071-1-sashal@kernel.org>
References: <20210706111409.2058071-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Kevin Wang <kevin1.wang@amd.com>,
 dri-devel@lists.freedesktop.org, "Stanley . Yang" <Stanley.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kevin Wang <kevin1.wang@amd.com>

[ Upstream commit 2b8f731849800e3948763ccaff31cceac526789b ]

Re-adjust the function return order to avoid empty sdma version in the
sriov environment. (read amdgpu_firmware_info)

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 240596b25fe4..9ab23947a151 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -145,9 +145,6 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
 
-	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_SIENNA_CICHLID))
-		return 0;
-
 	DRM_DEBUG("\n");
 
 	switch (adev->asic_type) {
@@ -182,6 +179,9 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 		       (void *)&adev->sdma.instance[0],
 		       sizeof(struct amdgpu_sdma_instance));
 
+	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_SIENNA_CICHLID))
+		return 0;
+
 	DRM_DEBUG("psp_load == '%s'\n",
 		  adev->firmware.load_type == AMDGPU_FW_LOAD_PSP ? "true" : "false");
 
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
