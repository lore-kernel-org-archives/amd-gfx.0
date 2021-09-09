Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83546C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 11:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5403E6103D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 11:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5403E6103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D82F56E804;
	Thu,  9 Sep 2021 11:55:09 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 362476E804;
 Thu,  9 Sep 2021 11:55:09 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17D4A61BBE;
 Thu,  9 Sep 2021 11:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631188509;
 bh=12siGeLuNRMNegAARWNe0txf5wjF4ptGz5s0ho4zFTw=;
 h=From:To:Cc:Subject:Date:From;
 b=SI03uRknSp4iI+9F4WlxXjmqEHGtOmdZ0Mw0+nbqTaQazxLiHw90KmdWsSiWQeTac
 X7bNXftpbNI+tXBOp04yYS3tSt1/wz67mv+YhzKBs+Xjb31Toj8NqtXuOTFpE5ZkRU
 ESabJFd8KLkpzjLydurhmdO8zqpJmMmZXF2x187t+VRIbbgem5K6I4QCam1FNs58iI
 OfHVpl4ces0ir7uiPBpsQlLsVdobBwzNdTEruC2Mhv69x0poFvQzhSSO4m0f77hThE
 QUWp7ZooIyInLYcJmFLaE2HQ8MRHm6CM5gSs9FrzO782b7QvkVJimrX+ROdP5Szkdd
 Qm95T4+8+/L/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luben Tuikov <luben.tuikov@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 001/109] drm/amdgpu: Fix amdgpu_ras_eeprom_init()
Date: Thu,  9 Sep 2021 07:53:18 -0400
Message-Id: <20210909115507.147917-1-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Luben Tuikov <luben.tuikov@amd.com>

[ Upstream commit dce4400e6516d18313d23de45b5be8a18980b00e ]

No need to account for the 2 bytes of EEPROM
address--this is now well abstracted away by
the fixes the the lower layers.

Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Acked-by: Alexander Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 8a32b5c93778..bd7ae3e130b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -138,7 +138,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 		return ret;
 	}
 
-	__decode_table_header_from_buff(hdr, &buff[2]);
+	__decode_table_header_from_buff(hdr, buff);
 
 	if (hdr->header == EEPROM_TABLE_HDR_VAL) {
 		control->num_recs = (hdr->tbl_size - EEPROM_TABLE_HEADER_SIZE) /
-- 
2.30.2

