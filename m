Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6477EC33CB2
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 19:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CEC1206A2
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 19:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1pUBqFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEC1206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D95976F3C9;
	Tue, 28 Jan 2020 19:47:16 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34EE26F3C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 19:47:15 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id w15so12908750qkf.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 11:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GJohU3KzvZYhEw1cbst+KlBdmKzpV0ja0z2afTuVFv0=;
 b=C1pUBqFGkO6gZ8EcC47c3f7jp8hcy19TAMA2xJqO+26pGw2aUAA7tU8dPaQOqKykAA
 gq+9uE90dWb8bnpp8AHVzdzyoDwjJhmkDNkD2xYTsvDHwduy2LReiim2U2jCH/4Qo9mp
 Dv3gXBx6HMvwalv0+YMHEV8l0OJXf1+HKkRk9HkmY5mTAXSpdBous5cCE5ARRxZ/VbVO
 O3ocfKnzqdG5iLwGOhY2sgutOcldeoUskoZMp9umt8k0sp6BipEOZd3d0TPYjwxHgicF
 qZVR1Tsros9cWbmPRQLCNuv3vX0p4GVaww/HxRPqjA4Alesx3u9uzVI3Sf+jJ4zUu5jZ
 xBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GJohU3KzvZYhEw1cbst+KlBdmKzpV0ja0z2afTuVFv0=;
 b=dJOdG+2RHWrPLKN8zzreQfq/rlxsi1Gs3sI86jSs6BxhhmVP36srfV547WYmzCXnpA
 PGTyX+KAUftqkNDKoKqD9eYDUDayGFc19UafEVFUUr8Xbuy+s91rLNJiehJF0EvL+usN
 ZyFk7mf49YcvaaLHkquJInNKkicPUUa3om3Rim5G3NC6Ac5F5xJ9fmR7+QbqV+4RFp3N
 eTnGNXqS9DhaPjjphnNXizuZSWnPOVWoW4kbpn9DbyxX/cp5Up1QPna1GFB4OuCJyW3H
 aerlno5YFwUjHimAG5Ro8W5SI8T7Q32esiKHQoqxhzfx/TAOPe/lesIs+dqDY/MX7soP
 o9xA==
X-Gm-Message-State: APjAAAWr4+oJ9Vf+SNQDurta5Y5hEfRC6iEafCX+uBZxLthyFnhZIyQk
 g/jAAFIFHR+J9nLAAS6BowQtirgi
X-Google-Smtp-Source: APXvYqxhS6zPd6QGI/bKyvpyMcqkz7xrrCOz8/BvD5V2ilq9bdq8hgJu0rDV1WJfcjaLySWJT2iTcQ==
X-Received: by 2002:a37:a68f:: with SMTP id
 p137mr24325587qke.328.1580240834125; 
 Tue, 28 Jan 2020 11:47:14 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id b22sm12590452qka.121.2020.01.28.11.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 11:47:13 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/display: handle multiple numbers of fclks in
 dcn_calcs.c
Date: Tue, 28 Jan 2020 14:47:06 -0500
Message-Id: <20200128194707.87898-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We might get different numbers of clocks from powerplay depending
on what the OEM has populated.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/963
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  | 31 ++++++++++++-------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
index a27d84ca15a5..8ad32a11d363 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
@@ -1446,17 +1446,26 @@ void dcn_bw_update_from_pplib(struct dc *dc)
 		res = verify_clock_values(&fclks);
 
 	if (res) {
-		ASSERT(fclks.num_levels >= 3);
-		dc->dcn_soc->fabric_and_dram_bandwidth_vmin0p65 = 32 * (fclks.data[0].clocks_in_khz / 1000.0) / 1000.0;
-		dc->dcn_soc->fabric_and_dram_bandwidth_vmid0p72 = dc->dcn_soc->number_of_channels *
-				(fclks.data[fclks.num_levels - (fclks.num_levels > 2 ? 3 : 2)].clocks_in_khz / 1000.0)
-				* ddr4_dram_factor_single_Channel / 1000.0;
-		dc->dcn_soc->fabric_and_dram_bandwidth_vnom0p8 = dc->dcn_soc->number_of_channels *
-				(fclks.data[fclks.num_levels - 2].clocks_in_khz / 1000.0)
-				* ddr4_dram_factor_single_Channel / 1000.0;
-		dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = dc->dcn_soc->number_of_channels *
-				(fclks.data[fclks.num_levels - 1].clocks_in_khz / 1000.0)
-				* ddr4_dram_factor_single_Channel / 1000.0;
+		unsigned vmin0p65_idx = 0;
+		unsigned vmid0p72_idx = fclks.num_levels -
+			(fclks.num_levels > 2 ? 3 : (fclks.num_levels > 1 ? 2 : 1));
+		unsigned vnom0p8_idx = fclks.num_levels - (fclks.num_levels > 1 ? 2 : 1);
+		unsigned vmax0p9_idx = fclks.num_levels - 1;
+
+		dc->dcn_soc->fabric_and_dram_bandwidth_vmin0p65 =
+			32 * (fclks.data[vmin0p65_idx].clocks_in_khz / 1000.0) / 1000.0;
+		dc->dcn_soc->fabric_and_dram_bandwidth_vmid0p72 =
+			dc->dcn_soc->number_of_channels *
+			(fclks.data[vmid0p72_idx].clocks_in_khz / 1000.0)
+			* ddr4_dram_factor_single_Channel / 1000.0;
+		dc->dcn_soc->fabric_and_dram_bandwidth_vnom0p8 =
+			dc->dcn_soc->number_of_channels *
+			(fclks.data[vnom0p8_idx].clocks_in_khz / 1000.0)
+			* ddr4_dram_factor_single_Channel / 1000.0;
+		dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 =
+			dc->dcn_soc->number_of_channels *
+			(fclks.data[vmax0p9_idx].clocks_in_khz / 1000.0)
+			* ddr4_dram_factor_single_Channel / 1000.0;
 	} else
 		BREAK_TO_DEBUGGER();
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
