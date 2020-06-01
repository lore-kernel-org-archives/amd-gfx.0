Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C4DC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC242073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKwPaVkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC242073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 981426E373;
	Mon,  1 Jun 2020 18:22:48 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 774956E372
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:47 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id c185so10010372qke.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KaAq14FndSiZBabp/zevyAzkfLfLtaVr0HOxqEWCe28=;
 b=FKwPaVkzAUHZ77aLrH5og/HiB+i3W0ncfAxR08rKet1tNwS14NgwikxEoA3s86swsa
 TZRXXgLjeiFkJCUJ1xYX9adZ7ZepRwhXTMsEHgYen5de/xg+DAxoUJzAXdKlUh9M/u9m
 q9h3Mxz06xrnlxTE4kWmS8Xkae+ZMOSM+mV5WTeR+MO8qhlFe52bjYiGdj7q811yMKHX
 l46c0IXyoHHx39n8lDPN6i93SpFdJ4yDNXUntul+mJKR0Q2jFF+8Kmv01AKNYUQS40V0
 1FeiVGq2rB0pOrRTa9UIkUItyx2aYU0weX6j7j1gzURCxMuVfqz4+YtfuoLxzwCTwodK
 9U5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KaAq14FndSiZBabp/zevyAzkfLfLtaVr0HOxqEWCe28=;
 b=lQ7xI+g/CsHrwFuWN4zhzni9X8pCI0PlGDIrIskaw+5GcjbD2pWs3UIyRofPBxiBpb
 CQUANqPo4SK63gDAVRRXf4vvDPSm2hqvqdcIqcR5o8pNWi8WmJmJGKlYLax4czmPkzCy
 PnG/GFfTWnkG8SAvfba1GKY+lAsTDDstaBXPxiog1lSpyRcSmrX/2PaIYrajLpbfhZWk
 rQOPeN+DqIgtb+vMPDlKOQVsuonBpjpV5fTIcEagIF7R0NgUCmZr3uWkEw8CYhd5X900
 tJ3x7q8LSocDwY0sJA/QmXCg3M/OFTfbUkp96C1EbAXs1S5M+GUPJ2NzK/RgGBURmYnO
 faWA==
X-Gm-Message-State: AOAM533g8ypkK7DAAmCWVc5RWZrUdk5ishxt2i8sbaHYgu3ytFwQwjOl
 m4+tUG78tmJy7emmJ0guF8WX13kv
X-Google-Smtp-Source: ABdhPJxiexTVXv0i4rYj4bU6x4ycV9tYelsSwFKN8X/R5iob0PYtb7pTE14DkRctdTwc/Hq+RK+UlA==
X-Received: by 2002:a37:8d85:: with SMTP id p127mr19656237qkd.35.1591035766447; 
 Mon, 01 Jun 2020 11:22:46 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:45 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 167/207] drm/amd/powerplay: show gfxclk=0 in gfxoff state
Date: Mon,  1 Jun 2020 14:20:14 -0400
Message-Id: <20200601182054.1267858-78-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

The instant retrieved gfxclk value should be 0 in gfxoff state.
This can be fetched with gfxoff enabled.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 10114132fdd8..c924ecf2899f 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -709,9 +709,6 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	uint32_t mark_index = 0;
 	uint32_t gen_speed, lane_width;
 
-	if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
-		amdgpu_gfx_off_ctrl(adev, false);
-
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
@@ -727,6 +724,10 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		/* 10KHz -> MHz */
 		cur_value = cur_value / 100;
 
+		/* no need to disable gfxoff when retrieving the current gfxclk */
+		if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
+			amdgpu_gfx_off_ctrl(adev, false);
+
 		ret = smu_get_dpm_level_count(smu, clk_type, &count);
 		if (ret)
 			goto print_clk_out;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
