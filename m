Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D584C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 23:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FBF208B3
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 23:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AR8Bew5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FBF208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF91589C46;
	Mon,  8 Jun 2020 23:08:15 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5137B89C46;
 Mon,  8 Jun 2020 23:08:15 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4717F20842;
 Mon,  8 Jun 2020 23:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591657695;
 bh=h1T8WN4lKVZU17Fkg6U+9UkbB+FzXtXp0Ckcu6/lPss=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AR8Bew5NPRB8LiSO6uflaDp8v5HK9mp+G9wE1TNxF+FKHg1qQoZFff36/ibycqFGU
 qgXAaL8JfP9U/ZtDTVLSYjLVxuGQ+dEnjNP4EnH3kJk4dSf/jdc5vXhKAZjdITmihW
 05xV3lJ4GCgjw8D6uDhNmBeE1UB59raSj5qoVfbU=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 095/274] drm/amd/display: Revert to old formula in
 set_vtg_params
Date: Mon,  8 Jun 2020 19:03:08 -0400
Message-Id: <20200608230607.3361041-95-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
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
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Yongqiang Sun <yongqiang.sun@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[ Upstream commit a1a0e61f3c43c610f0a3c109348c14ce930c1977 ]

[Why]
New formula + cursor change causing underflow
on certain configs

[How]
Rever to old formula

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 17d96ec6acd8..ec0ab42becba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -299,6 +299,7 @@ void optc1_set_vtg_params(struct timing_generator *optc,
 	uint32_t asic_blank_end;
 	uint32_t v_init;
 	uint32_t v_fp2 = 0;
+	int32_t vertical_line_start;
 
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
@@ -315,8 +316,9 @@ void optc1_set_vtg_params(struct timing_generator *optc,
 			patched_crtc_timing.v_border_top;
 
 	/* if VSTARTUP is before VSYNC, FP2 is the offset, otherwise 0 */
-	if (optc1->vstartup_start > asic_blank_end)
-		v_fp2 = optc1->vstartup_start - asic_blank_end;
+	vertical_line_start = asic_blank_end - optc1->vstartup_start + 1;
+	if (vertical_line_start < 0)
+		v_fp2 = -vertical_line_start;
 
 	/* Interlace */
 	if (REG(OTG_INTERLACE_CONTROL)) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
