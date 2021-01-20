Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA665C43381
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 01:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EDC023121
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 01:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDC023121
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A2116E13A;
	Wed, 20 Jan 2021 01:27:34 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A1236E13A;
 Wed, 20 Jan 2021 01:27:33 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2009623119;
 Wed, 20 Jan 2021 01:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611106053;
 bh=x8SzVggovaHzS2vLj57odYH8uRPPp+IM+ZSmWzDora4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ajjuuym+kh/7DYhiATHs17+f+B0TcR1ycxgPSSH/AzpuUCYXKlbMNzZrSpkcpLkqy
 SBTFUobzTEkQ3k2wrl4gr5NU+870J71HoImpLmB/Zu4/v1CrAI0pirkGzP7t+4ZdFs
 AzwH0a8q/d3MQnNdkW/n4tZtR2jN5b3YStr2M4e+EWfAD8IVS4m3UwIDXj6/GEy+vS
 G0X/7sD/0h2YizYM3l3Tx7xheyswyl53bvkrCKYSLIz73JeDvuaGSPEhMeSzn2pGnO
 vE+BXZ5xk8UnB4yBhFRb1tRiAkrqI7N8BWsxJTvIlCKphARuA7FBwcRtXgD9JMV62e
 72U3EZyKg0+Sg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 21/26] drm/amd/display: Fix to be able to stop crc
 calculation
Date: Tue, 19 Jan 2021 20:26:58 -0500
Message-Id: <20210120012704.770095-21-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210120012704.770095-1-sashal@kernel.org>
References: <20210120012704.770095-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Qingqing Zhuo <qingqing.zhuo@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Wayne Lin <Wayne.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[ Upstream commit 02ce73b01e09e388614b22b7ebc71debf4a588f0 ]

[Why]
Find out when we try to disable CRC calculation,
crc generation is still enabled. Main reason is
that dc_stream_configure_crc() will never get
called when the source is AMDGPU_DM_PIPE_CRC_SOURCE_NONE.

[How]
Add checking condition that when source is
AMDGPU_DM_PIPE_CRC_SOURCE_NONE, we should also call
dc_stream_configure_crc() to disable crc calculation.
Also, clean up crc window when disable crc calculation.

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index a549c7c717ddc..f0b001b3af578 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -113,7 +113,7 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 	mutex_lock(&adev->dm.dc_lock);
 
 	/* Enable CRTC CRC generation if necessary. */
-	if (dm_is_crc_source_crtc(source)) {
+	if (dm_is_crc_source_crtc(source) || source == AMDGPU_DM_PIPE_CRC_SOURCE_NONE) {
 		if (!dc_stream_configure_crc(stream_state->ctx->dc,
 					     stream_state, enable, enable)) {
 			ret = -EINVAL;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
