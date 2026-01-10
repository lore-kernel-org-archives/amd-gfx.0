Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DC3D277C1
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Jan 2026 17:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 189FE10E1D8;
	Sat, 10 Jan 2026 17:58:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dYNC9O0/";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FA3C10E1A3
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Jan 2026 15:44:32 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-34c2f335681so3011638a91.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Jan 2026 07:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768059872; x=1768664672; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6WGRfS/hg/dlR95sL3z4iPS0A9xs8ZeuFM3/8G+jStk=;
 b=dYNC9O0/8a/9qtGVLBk49z4aFGRa7TU5xNvbxYY/WBuQlvFr2RqcB8WlWtG2vx2ysd
 cISqG8k2EJyHmdxsA8uUfbgLHhFAMOWv+220bWvsV13X+1Dgg+DryZLpFbOXVr42CKFA
 Glz3PS0/zRM1vVW7QpuQlvYyyzcEAsIoF+FcWgxVKgY6Emz58HbMhmm5AeggwQX8t/To
 uBq7HX71+7Z109t5jb6bIX0MDbbTbFwFyDW4x+hFl3PUaOuY7hWx2nDNmd8jPimXNNxM
 sXzR1VV+K33TVAM+x9JYl8MxZ+jrtoi4cZqQ0sBjh9UA4Ok1nRBWyioi9Hufd9vdRfB4
 +fMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768059872; x=1768664672;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6WGRfS/hg/dlR95sL3z4iPS0A9xs8ZeuFM3/8G+jStk=;
 b=swY5nKdjbW4xP4hRUXUKdF29dYYt2S+k5BcV26/HQe1b674ITJsADwKALF8ioU4yAw
 cYCGhRATX5EOeEWeljpKg7RqAgF+UInTsQg5UoSlLZ3pNILsuRM6zsGgmGxjocryQwSv
 hFXm01k4qryo0NaBoD07AKJO3oTXqSYY3GMsa36h5IzBKX1dz/8BU8ppV+NG4Z4ZF4Nn
 1uzmjZqJ1U2qa560we34OFDu1OkLRGEj9KePRHuBTnQNWm/wxaT+2rU0xdBQIAbttN31
 r4fXG1FBqKB+n9b1dicViG+HQcB0T/u1sTeVP+lgzSrESxohzgaJq/IEo2OeZFN5rq9P
 Yaew==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5Ze3loGEcQmDrRXShXeDXDMz1/96RZg/mBIayQ349gjJVU0W7pgTfR7N9dhvuSFbXImXoSzXF@lists.freedesktop.org
X-Gm-Message-State: AOJu0YznxYHwjYnzmXLFblET3LLd4UCJ9LubNLisvge7dNdgm7R2i68N
 JRloXMKK7YPHzs/QJ1q7YWT1uFhtdGGJsWGkPSVo5AMTbROlIM5x9S0=
X-Gm-Gg: AY/fxX7LYyDNWugN4iW8hfDtncys4HH6mdQ0gDNwzjjZSyzk+BrrKzn5xrw5q8Llp1w
 lzy5p2ZKBUi9YV/fVaDM6tFVC/Cb6qeDw7BCuFcy92YWkq8TgEU08LQV30AuJZ/e3jTXWn/JfKl
 zSN57f0YQrop/LcpkcfT6vG38fJDf7VW2Ge2imcEaHNMowDOlgnswmho8cbqutE5FFXFhMJqHHq
 AUqauekwNRlOGgsDocQI/3A5Pj2twlO3vyH+OQmWuLql7YIKMKDN5HI8hQqr9YJs8O1gxC9KObv
 LAmaYt6nELL1Rr0s4hZkIn/Ii15JEDkPJoCBNRasgIOKDfxNfpuro7C6Ng2K6/6b6MUqkoC5nKo
 +UCRHev0zJ0eB9u2+RcOyjs1nk6CscyniSQItK7sDKKrIVheUolerA9ObKJXjgVohdQ24XU/4aq
 VyFIFPLUtaK9TqzHX9
X-Google-Smtp-Source: AGHT+IHEn7qxu+STvjiQQkoAM0lssrQA//cWYatgbloFeBZO2SpvpP8cc6OhL/6BnI0Q+diDGSsbnw==
X-Received: by 2002:a17:90b:1643:b0:340:bc27:97b8 with SMTP id
 98e67ed59e1d1-34f68c4ffd5mr11873894a91.10.1768059872014; 
 Sat, 10 Jan 2026 07:44:32 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([45.136.255.173])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fb7442asm13430375a91.15.2026.01.10.07.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jan 2026 07:44:31 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: siqueira@igalia.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH] drm/amd/display: dcn315: validate NumDfPstatesEnabled in bw
 params
Date: Sat, 10 Jan 2026 23:44:16 +0800
Message-ID: <20260110154416.2134-1-qikeyu2017@gmail.com>
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

dcn315_clk_mgr_helper_populate_bw_params() derives max_pstate from
clock_table->NumDfPstatesEnabled and uses it to index DfPstateTable[].
NumDfPstatesEnabled is provided by SMU/PMFW and is not validated.

If NumDfPstatesEnabled is 0, max_pstate underflows and later accesses
DfPstateTable[max_pstate]. If it is larger than NUM_DF_PSTATE_LEVELS,
the helper may read past the end of DfPstateTable[] when populating
the clock table, potentially crashing the kernel.

A similar missing bounds check was fixed in dcn35_clkmgr and assigned
CVE-2024-26699. We have not confirmed a concrete trigger for dcn315,
but this is a defensive hardening to avoid potential OOB reads.

Clamp NumDfPstatesEnabled to a sane range before using it for loop
bounds and max_pstate selection.

Fixes: 60f6fe665e85 ("drm/amd/display: update dcn315 clock table read")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 3a881451e9da..eba71cc9f6f8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -548,15 +548,21 @@ static void dcn315_clk_mgr_helper_populate_bw_params(
 {
 	int i;
 	struct clk_bw_params *bw_params = clk_mgr->base.bw_params;
-	uint32_t max_pstate = clock_table->NumDfPstatesEnabled - 1;
 	struct clk_limit_table_entry def_max = bw_params->clk_table.entries[bw_params->clk_table.num_entries - 1];
+	/* Clamp NumDfPstatesEnabled to avoid out-of-bounds access */
+	uint8_t num_memps = clock_table->NumDfPstatesEnabled;
+	uint32_t max_pstate;
+
+	if (num_memps > NUM_DF_PSTATE_LEVELS)
+		num_memps = NUM_DF_PSTATE_LEVELS;
+	max_pstate = num_memps - 1;
 
 	/* For 315 we want to base clock table on dcfclk, need at least one entry regardless of pmfw table */
 	for (i = 0; i < clock_table->NumDcfClkLevelsEnabled; i++) {
 		int j;
 
 		/* DF table is sorted with clocks decreasing */
-		for (j = clock_table->NumDfPstatesEnabled - 2; j >= 0; j--) {
+		for (j = num_memps - 2; j >= 0; j--) {
 			if (clock_table->DfPstateTable[j].Voltage <= clock_table->SocVoltage[i])
 				max_pstate = j;
 		}
-- 
2.34.1

