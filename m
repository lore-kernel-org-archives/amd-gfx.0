Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C78FC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 01:26:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB78021D79
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 01:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB78021D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAF2F89C56;
	Wed, 20 Jan 2021 01:26:46 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6802E89B3B;
 Wed, 20 Jan 2021 01:26:45 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15A992245C;
 Wed, 20 Jan 2021 01:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611106005;
 bh=kMn8CfxQziRnH48xb4v4RCCNXXh+0G5URM2cOoDmtm8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ELfPLZ8zOUh7ySsHr9hICofuPW8t7z1Q4MEMxm+xuyBhH0lW0uR6AQx7vGHxRFaYo
 wkIdAYpoxYT2ERAZaDMK5kTJexJmcwYpJwLywzRqOD+IpYKVTGyZ/lEOmfjLzbUhRY
 IX5h+Y5OxfoF2cLoPKD+a9wdCVGE/PSj3Vnb++ZRX6dYF4IX/Giep9OsnelnK+VISe
 52FE/CQSMl5Zga5rNTuGbC1cV4QjdaOXcdEu9SuTrY+IJ7IfPDRcOlotITvxybOZQJ
 hb/oEnYNAdFjXEh4VAQWLCk4J3HrdYSBkfYJeH2WjqfEqSrzXwgS7HqotT2RmCSmi5
 pITLoiBDWeclA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 32/45] drm/amdgpu/psp: fix psp gfx ctrl cmds
Date: Tue, 19 Jan 2021 20:25:49 -0500
Message-Id: <20210120012602.769683-32-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210120012602.769683-1-sashal@kernel.org>
References: <20210120012602.769683-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Victor Zhao <Victor.Zhao@amd.com>,
 dri-devel@lists.freedesktop.org, "Emily . Deng" <Emily.Deng@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Victor Zhao <Victor.Zhao@amd.com>

[ Upstream commit f14a5c34d143f6627f0be70c0de1d962f3a6ff1c ]

psp GFX_CTRL_CMD_ID_CONSUME_CMD different for windows and linux,
according to psp, linux cmds are not correct.

v2: only correct GFX_CTRL_CMD_ID_CONSUME_CMD.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
Reviewed-by: Emily.Deng <Emily.Deng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 4137dc710aafd..7ad0434be293b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -47,7 +47,7 @@ enum psp_gfx_crtl_cmd_id
     GFX_CTRL_CMD_ID_DISABLE_INT     = 0x00060000,   /* disable PSP-to-Gfx interrupt */
     GFX_CTRL_CMD_ID_MODE1_RST       = 0x00070000,   /* trigger the Mode 1 reset */
     GFX_CTRL_CMD_ID_GBR_IH_SET      = 0x00080000,   /* set Gbr IH_RB_CNTL registers */
-    GFX_CTRL_CMD_ID_CONSUME_CMD     = 0x000A0000,   /* send interrupt to psp for updating write pointer of vf */
+    GFX_CTRL_CMD_ID_CONSUME_CMD     = 0x00090000,   /* send interrupt to psp for updating write pointer of vf */
     GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING = 0x000C0000, /* destroy GPCOM ring */
 
     GFX_CTRL_CMD_ID_MAX             = 0x000F0000,   /* max command ID */
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
