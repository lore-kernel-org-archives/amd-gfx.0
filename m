Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD9BC4363A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 23:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20EEF21655
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 23:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wTRRimrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EEF21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C99C86EA98;
	Mon, 26 Oct 2020 23:51:10 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14B196EA98;
 Mon, 26 Oct 2020 23:51:09 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1919820B1F;
 Mon, 26 Oct 2020 23:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603756269;
 bh=SbFHCpjFUIgnRes5SSzBfbN3T+ObB3Aq3esfOYYDvAw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=wTRRimrOytpWvFAuwXfJw/g4fTnygSiMZhyPK/U7NhTvMb7HHZfuN8ihv+iiB8t1c
 1MKwWuUouc61UsRS/L3NeFScxmZtOhf51h2tTZMU8ddEstI4v9n5MDmTEGW0g+JtcO
 pOolzRxHHSx+Xd835u0Sv5z9O1F7rTcaWETC4TeI=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.9 101/147] drm/amd/display: Avoid set zero in the
 requested clk
Date: Mon, 26 Oct 2020 19:48:19 -0400
Message-Id: <20201026234905.1022767-101-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026234905.1022767-1-sashal@kernel.org>
References: <20201026234905.1022767-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Eryk Brol <eryk.brol@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[ Upstream commit 2f8be0e516803cc3fd87c1671247896571a5a8fb ]

[Why]
Sometimes CRTCs can be disabled due to display unplugging or temporarily
transition in the userspace; in these circumstances, DCE tries to set
the minimum clock threshold. When we have this situation, the function
bw_calcs is invoked with number_of_displays set to zero, making DCE set
dispclk_khz and sclk_khz to zero. For these reasons, we have seen some
ATOM bios errors that look like:

[drm:atom_op_jump [amdgpu]] *ERROR* atombios stuck in loop for more than
5secs aborting
[drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR* atombios stuck
executing EA8A (len 761, WS 0, PS 0) @ 0xEABA

[How]
This error happens due to an attempt to optimize the bandwidth using the
sclk, and the dispclk clock set to zero. Technically we handle this in
the function dce112_set_clock, but we are not considering the case that
this value is set to zero. This commit fixes this issue by ensuring that
we never set a minimum value below the minimum clock threshold.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
index d031bd3d30724..807dca8f7d7aa 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
@@ -79,8 +79,7 @@ int dce112_set_clock(struct clk_mgr *clk_mgr_base, int requested_clk_khz)
 	memset(&dce_clk_params, 0, sizeof(dce_clk_params));
 
 	/* Make sure requested clock isn't lower than minimum threshold*/
-	if (requested_clk_khz > 0)
-		requested_clk_khz = max(requested_clk_khz,
+	requested_clk_khz = max(requested_clk_khz,
 				clk_mgr_dce->base.dentist_vco_freq_khz / 62);
 
 	dce_clk_params.target_clock_frequency = requested_clk_khz;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
