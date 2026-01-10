Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D74D232D3
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Jan 2026 17:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 025EC10E21B;
	Sat, 10 Jan 2026 17:58:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gRcUiShW";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B645910E0A4
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Jan 2026 15:26:33 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-81f3d6990d6so206919b3a.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Jan 2026 07:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768058793; x=1768663593; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ExHuWpFYuvzYHoUvmHMsDGIZ1gwQCmuqPwja0g87GZ8=;
 b=gRcUiShWCzffzTATCEa0/YKDL4PVsbaQM2OKsjZfrV2cXG8iaPozPhVvXmmy2r/3x/
 Gxi4MrMHWFseb+07Md8KBbi77b+4T85RcIYhJH4HtaJf4LAZ2r5U3ADlkP8bsFxA00ka
 NbyinvzFick9jEh+0MPuPGzbT8Xv2tt41O5pfBXHMrVc/lmut2H4Kz4SuiUKD4LRYMb5
 g5i4ClAOMK3fOSZay9gqvmS5eY7sbj3I6J04z5atuy+LzebO6MElTFCu48puu8LYX5KZ
 9/ZeopMOKFWTBCdvHKEIiNMYPsiA0RG9rVt+tP5WMeMTUr92vVb1Q4Geb9UjiXYFfpn9
 V3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768058793; x=1768663593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ExHuWpFYuvzYHoUvmHMsDGIZ1gwQCmuqPwja0g87GZ8=;
 b=IZzvmL2bqAH3UOS9jYzRJjv2dSdvvgH8DQhxNi2AMd/ex/eO22gMDTNoDB5qCxQXa1
 iscD4F6vBNplcYv5SqGYc/3YT2aUPzWqEHOLkzE8b091G4VxPdFa8qyo/aNZKnBe4OE6
 GkhLWdyTEuxDJ+XSLq1/ko6yfEAErey8q/bVrIpHjzn1PmFNcHkeBaRSiTq0DpAJYGOO
 3YnuHA+0JEm7HV5ra6tx6950cNX1L1yYyy5T8Fily2EiwJosJRM7ne3OL7cuxbq6KkFS
 f7yoFmuX3CxX6oCt+pqFN9isGdYuF1KD4MEHE7udN4yG6kZhEdMgCYBUwGw5kt7ZAxS3
 BSUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOHeaW9HvHZgL2MZm2xkvAXf1Z3uB/hqLDyi5XwmSbLz1VziD3fO9LXlfZB+6dKyDwMvmU0032@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPkbaISsXAIj7ah1DYaMle0T5l5BfMwSMHor1trRiNfSxvrtRG
 PuqBVuZKEqING9OBi6MC3k9+BBLAwHFEZJdgBEwTvtmXwCzaI+vExWs=
X-Gm-Gg: AY/fxX4sxt9cLYhVBSDvik482Bu/Gcap1+KNqM2Av7QRliCDHVhy6IwQCjBG2HJfMyi
 08WBwYnLGXteQLYbLniaBoAL7BqCP16Nz2nN8AbD4u3L6o7JECvWCLAizVFXbVorBlw+LBL44FZ
 h89KoQQnDYmYDoNlkQDPH3Ld9wn/5V5iv8MHf+s38KRHuM3GOZgXCGTwZlrJAKnyisr1awuOtrb
 pvUDPEtiLFSK+VQfMYQnDQndj1UeSt02NoyCBm1QdOB4TA1LdRg1AtdYLdUvHC5mu8/BAw4mO6W
 iZJpVxFNOFwFUixoPfc4B0/3tY2XAFDxaN4kxO8zaqqGlpkWB4dpoMyQ1uRfHXhbyhNUI70zEyt
 jqPy8Hl+U7/qDKPvkU3U/h20BWWU4IAanbHCFFEOUAMg8FA8i397TvrHyPIbHSz9md6Jg1Nfgxd
 eOPyRXWgugqHnX/xckeyih0cC3REc+3obGCbcorVXVeG+SkoAZpIcsuT8M0UQv8YqisB4Wodxt+
 qyAXV+o
X-Google-Smtp-Source: AGHT+IH7mBj7PPLRfVb3A2O0XATpTJScJZZT8x3SVMdLz/XnkWw7wXYuSj38Xx7/krVrHHAnyz4MDg==
X-Received: by 2002:a05:6a00:4186:b0:781:17fb:d3ca with SMTP id
 d2e1a72fcca58-81b7de5c609mr11127452b3a.15.1768058793103; 
 Sat, 10 Jan 2026 07:26:33 -0800 (PST)
Received: from DESKTOP-BKIPFGN
 (ec2-54-169-177-146.ap-southeast-1.compute.amazonaws.com. [54.169.177.146])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81c4905ca83sm8487203b3a.38.2026.01.10.07.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jan 2026 07:26:32 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: sunpeng.li@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH] drm/amd/display: dcn314: clamp NumDfPstatesEnabled to table
 size
Date: Sat, 10 Jan 2026 23:26:03 +0800
Message-ID: <20260110152603.2107-1-qikeyu2017@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 10 Jan 2026 17:58:19 +0000
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

NumDfPstatesEnabled from SMU/PMFW is used to iterate over DfPstateTable[]
in dcn314_clk_mgr_helper_populate_bw_params(). The value is not validated
against the maximum number of DF P-states supported.

Although we have not observed any firmware returning an invalid value,
an oversized NumDfPstatesEnabled could cause an out-of-bounds read.

A similar bounds issue in dcn35_clkmgr was previously fixed and assigned
CVE-2024-26699. This patch applies the same defensive check to dcn314.

Clamp NumDfPstatesEnabled to NUM_DF_PSTATE_LEVELS before using it.

Fixes: 19f7b8334484 ("drm/amd/display: Update clock table policy for DCN314")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index db687a13174d..50ea75d974fd 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -754,9 +754,15 @@ static void dcn314_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *cl
 	struct clk_limit_table_entry def_max = bw_params->clk_table.entries[bw_params->clk_table.num_entries - 1];
 	uint32_t max_pstate = 0,  max_fclk = 0,  min_pstate = 0, max_dispclk = 0, max_dppclk = 0;
 	int i;
+	/* Clamp NumDfPstatesEnabled to avoid out-of-bounds access */
+	uint8_t num_memps = clock_table->NumDfPstatesEnabled;
+
+	if (num_memps > NUM_DF_PSTATE_LEVELS) {
+		num_memps = NUM_DF_PSTATE_LEVELS;
+	}
 
 	/* Find highest valid fclk pstate */
-	for (i = 0; i < clock_table->NumDfPstatesEnabled; i++) {
+	for (i = 0; i < num_memps; i++) {
 		if (is_valid_clock_value(clock_table->DfPstateTable[i].FClk) &&
 		    clock_table->DfPstateTable[i].FClk > max_fclk) {
 			max_fclk = clock_table->DfPstateTable[i].FClk;
@@ -782,7 +788,7 @@ static void dcn314_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *cl
 		uint32_t min_fclk = clock_table->DfPstateTable[0].FClk;
 		int j;
 
-		for (j = 1; j < clock_table->NumDfPstatesEnabled; j++) {
+		for (j = 1; j < num_memps; j++) {
 			if (is_valid_clock_value(clock_table->DfPstateTable[j].FClk) &&
 			    clock_table->DfPstateTable[j].FClk < min_fclk &&
 			    clock_table->DfPstateTable[j].Voltage <= clock_table->SocVoltage[i]) {
-- 
2.34.1

