Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D63C11F79
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B41461E1A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B41461E1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAC2F6E424;
	Tue,  6 Jul 2021 11:24:07 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C366B6E423;
 Tue,  6 Jul 2021 11:24:06 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA71E61E3E;
 Tue,  6 Jul 2021 11:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625570646;
 bh=+cgxu2ErfEUHA2P6PmWEGiulRbq/+byzMvEXiYLvCDw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ozd1FBQ5Dg83sRTwF1HNSKlWs+yL8EeZjWCER8dtTT20tuLbzBu1y2Ob2XAz2RMfx
 2iuQ8LBGwVL96SH6XzujOYFKdnDibB059gIx4asMnq4JJotk4bDU5SSS1EFi0nTG1Z
 y7mme1QtWtrkUVYNLLUZqatmNjj3KFbVzG41kjAI/clcUqDcQE0panF2V/EacxVKIA
 FYlesNkaepVzMGFgqu4RRTtUHLzvr/SfolORqWqFpv9mJoZnfrSBqy2rvq+6VMwUxH
 xdXMKubOJxl5l9z4IPezJ42jqZaa4l+JpwwnhtyVYat9xbNof2lYCIDDCT+p/rkFTy
 0SxnE8tnrvTAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 095/137] drm/amdgpu: fix bad address translation
 for sienna_cichlid
Date: Tue,  6 Jul 2021 07:21:21 -0400
Message-Id: <20210706112203.2062605-95-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706112203.2062605-1-sashal@kernel.org>
References: <20210706112203.2062605-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, dri-devel@lists.freedesktop.org,
 "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Stanley.Yang" <Stanley.Yang@amd.com>

[ Upstream commit 6ec598cc9dfbf40433e94a2ed1a622e3ef80268b ]

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 5 +++++
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c   | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 183814493658..bda4438c3925 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -21,6 +21,11 @@
 #ifndef __AMDGPU_UMC_H__
 #define __AMDGPU_UMC_H__
 
+/*
+ * (addr / 256) * 4096, the higher 26 bits in ErrorAddr
+ * is the index of 4KB block
+ */
+#define ADDR_OF_4KB_BLOCK(addr)			(((addr) & ~0xffULL) << 4)
 /*
  * (addr / 256) * 8192, the higher 26 bits in ErrorAddr
  * is the index of 8KB block
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
index 5665c77a9d58..afbbe9f05d5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -233,7 +233,7 @@ static void umc_v8_7_query_error_address(struct amdgpu_device *adev,
 		err_addr &= ~((0x1ULL << lsb) - 1);
 
 		/* translate umc channel address to soc pa, 3 parts are included */
-		retired_page = ADDR_OF_8KB_BLOCK(err_addr) |
+		retired_page = ADDR_OF_4KB_BLOCK(err_addr) |
 				ADDR_OF_256B_BLOCK(channel_index) |
 				OFFSET_IN_256B_BLOCK(err_addr);
 
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
