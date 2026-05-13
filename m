Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83B9CD4851
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5736E10EEF0;
	Wed, 13 May 2026 14:33:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wXTfT1eg";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010046.outbound.protection.outlook.com
 [40.93.198.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DFD510EEE0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPcByPw9IbYqG9rqQpUFDU5oxUovMulzpqiBFpEaOQ6Y6cl88EBCgIWywGUXb7ZqsXfZSDSomUFZhPZR0jyjTGIwuIG3bVeagv7rRn+CMHO5WdrgLVTH4xtd39iAEunGmoHHwoEABdVPV3Dtk9t5uZNMwuFe4Wx/yZRyhtvnpKfnBcEG9mVPo71sPC8EUXaX/J+Yqb2Rep/NPKG0qYSCaVHAXre3SLGLowSRB+zA06K4lf3OuVFQGDs2kfNKH7d320GuDz/2XTgum48I/vMP8ml7QPEhAN5HWlUWAlA7nxb/EEv7N/1PQyKlFERqYZ3UWkpYDkFGHVtc2hGsGKgaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ztOMWJKOdXXYbeD/L8W/jJLRPImu0SXjba6Sium594=;
 b=oTuLco/yLntpJRtLAs4dymmdKpo0gvrd5FUvHWltZLAguRKs689dBUSXaHpLHXdeJEvulBhdwqibhSTTrejHKif5wGiQNVxqOmtdUoiHbakjH09eg5GnTYZzTUWJ0zYuO551QkfCbUt1LotyTfa2FyVA1X/DqbJ9v0acAhktPFu5owJz0BEqLTI3Pc8Aa/iPoh7UXyEyjGlgvCjewjC3selV4+u6YjDm9GiQdYvmGKtPUxxyfpMeIcwnhZTKIORJFYn3s3oA7V4SkIdZsAzRemJuH/mJ56gkDJ8MqjiqYVthjUKAQgvKNyt3UBqUkdRMhAuOXBchtbXv8G/Lto9N9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ztOMWJKOdXXYbeD/L8W/jJLRPImu0SXjba6Sium594=;
 b=wXTfT1egG17UhpPvd/GGU1lMN5IxEFm72BVBFM+rZnhgnXCtg3yV28e2hg+3EqOAkWgK4NlPaHg/iBFfOlebS5HmijZ20ZJz5KVErKfWuECr9X+RfBS9QKfRLj8zan+j+7HO4jq+IVh8IproYWk8IjSrR3fKMBQTMbOP7PcICTM=
Received: from CYZPR19CA0021.namprd19.prod.outlook.com (2603:10b6:930:8e::22)
 by PH7PR12MB6936.namprd12.prod.outlook.com (2603:10b6:510:1ba::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 14:33:30 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:930:8e:cafe::d3) by CYZPR19CA0021.outlook.office365.com
 (2603:10b6:930:8e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 14:33:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:24 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:24 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Aric Cyr <Aric.Cyr@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 15/28] drm/amd/display: Enable additional wait for pipe
 pending checks
Date: Wed, 13 May 2026 10:29:37 -0400
Message-ID: <20260513143213.1852892-17-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|PH7PR12MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d4be05-7c66-4433-1282-08deb0fc9a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +HhK4rVW1qEiU3syYiL54BAw+Zgk8T4r9vJolsQXm25nDx/7EOxrgd+KSR08+AhLw0hPpqgDJ7iKzmDZHd1CZWhbXsgzw9gfDVIz3kvpwQW6DhS63rVYsUnMfCf0DVG3USid9o1IYtZdRbxmh58Uc8PQQnokNSe65nv2kAIgiOlj8PGKh0DL0Y17DeU6ogBzr+9qwNDtPOej+cqjddFb3svbrAQVq6Uf85SxdrKZ+jJpf2xi2w9dJhvaZHfZ4IKWkgi1VQL3n3BvwVZofuCkAFhJD6UidEuokK1PnDHJDaX/+uVuYXI04r9AnvZMb5D7j2Pt3rMSZVL2Hvds9/fyDkwJ7HWGbO1GMfeGgp7U4cvlmorKGOukKBgzLX7b8LevuuPd/5/d4iRYPwAK5xIeGGe27GoZyDKTWuvmQ180vTIimM+5FfpVBl6/CTswpAQlvyXiZmnVADk4dC66sFKtemr8qBeliIMIRQ3gokkqVrZouvhh5XNZPq2zRLDmDrpQgtEhsMUqejAt4t19TTETqxaA9mXBQirJjbizQkQ9H3M1TH7XHAegQqrmQzRbaRdOKwyxHxsayHz5/3RHPdfOYJlKKmmukj1Nhxy02386YW/HIZ5F3TkN19CI6d2sez5rquURH6+j8H8PWGzlV85u3UOmof3b5h/zVfwUU8Msfe4aCaMbKkqTuZfVef6JoHtJpGlVjcNRJEL4NZmFa4YyDCkJAXbgwLuham2L7x+P34E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(11063799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2Jskj0PtVLRNOjYj3CS1Mw2vXvwQGJleulppvhqAJSBXX2wK4OQrqgIAj+nV1ElLvwvIHfYQRX04EyaANUkL0vCaAHRWKVfPe0F50UgL2HvblRcs7bQjxf+wxozs1k7SEqYLqg1l7x8C+DH+rKpUbT2msoxbffOkOH1zAWYtg4SNxd6gBHwTUNummMYsaSC5WbwZ57f2ApswD/NXLWvWv88lUwGi0mRhmsWJrD71hGwRJGrPmqdSVu/hGfMZwAxes9bornxWIin72oMRVydJq+ZsWdElzN+YFLK34aejUmbPwJpBZYPXJ5llKdwhkLCss/Usc951ziyr3B6GI1MUG5V5dYV0Mq03T4AWnEP+TxPVvy5yboVnpTvl8IvI5+y7FVHPdmRhGU+SECQoota0x+rkgylOWNQYjCnK0pTi9aHi1mPAi/YVPtnl0o2e7cvK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:29.6770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d4be05-7c66-4433-1282-08deb0fc9a1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6936
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

From: Aric Cyr <Aric.Cyr@amd.com>

[why]
In cases where there are two FULL updates within the same display frame,
it's possible for some blocks to be programmed a second time without having
been latched completely from the first programming.

DCN 3.5 and up already work around this with additional validation checks
for frame count and defer as needed via fsleep.

[how]
Enabled existing pipe checks generically for all DCN versions to avoid HW
programming hazards.

Also removed redundant max_frame_count which can be determined by the
register mask and shift.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c  | 8 +++++---
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c | 2 ++
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c | 2 ++
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c   | 2 ++
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c | 2 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h             | 1 -
 drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c   | 1 -
 drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c   | 2 --
 12 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index fc2587ca56ec..a1c3c4454397 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -181,6 +181,7 @@ void dcn10_set_wait_for_update_needed_for_pipe(struct dc *dc, struct pipe_ctx *p
 	uint32_t vupdate_start, vupdate_end;
 	struct crtc_position position;
 	unsigned int vpos, cur_frame;
+	uint32_t max_frame_count;
 
 	if (!pipe_ctx->stream ||
 		!pipe_ctx->stream_res.tg ||
@@ -197,7 +198,8 @@ void dcn10_set_wait_for_update_needed_for_pipe(struct dc *dc, struct pipe_ctx *p
 
 	struct optc *optc1 = DCN10TG_FROM_TG(tg);
 
-	ASSERT(optc1->max_frame_count != 0);
+	max_frame_count = optc1->tg_mask->OTG_FRAME_COUNT >> optc1->tg_shift->OTG_FRAME_COUNT;
+	ASSERT(max_frame_count != 0);
 
 	if (tg->funcs->is_tg_enabled && !tg->funcs->is_tg_enabled(tg))
 		return;
@@ -209,8 +211,8 @@ void dcn10_set_wait_for_update_needed_for_pipe(struct dc *dc, struct pipe_ctx *p
 	if (vpos < vupdate_start) {
 		pipe_ctx->wait_frame_count = cur_frame;
 	} else {
-		if (cur_frame + 1 > optc1->max_frame_count)
-			pipe_ctx->wait_frame_count = cur_frame + 1 - optc1->max_frame_count;
+		if (cur_frame + 1 > max_frame_count)
+			pipe_ctx->wait_frame_count = cur_frame + 1 - max_frame_count;
 		else
 			pipe_ctx->wait_frame_count = cur_frame + 1;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
index 079c226c1097..b5e82e190124 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
@@ -118,6 +118,8 @@ static const struct hwseq_private_funcs dcn10_private_funcs = {
 	.dsc_pg_control = NULL,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
 	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
+	.wait_for_pipe_update_if_needed = dcn10_wait_for_pipe_update_if_needed,
+	.set_wait_for_update_needed_for_pipe = dcn10_set_wait_for_update_needed_for_pipe,
 };
 
 void dcn10_hw_sequencer_construct(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
index ad253c586ea1..1797a91b0186 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
@@ -136,6 +136,8 @@ static const struct hwseq_private_funcs dcn20_private_funcs = {
 	.dccg_init = dcn20_dccg_init,
 	.set_blend_lut = dcn20_set_blend_lut,
 	.set_shaper_3dlut = dcn20_set_shaper_3dlut,
+	.wait_for_pipe_update_if_needed = dcn10_wait_for_pipe_update_if_needed,
+	.set_wait_for_update_needed_for_pipe = dcn10_set_wait_for_update_needed_for_pipe,
 };
 
 void dcn20_hw_sequencer_construct(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
index 5cbae0cdda96..9834d3075487 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
@@ -145,6 +145,8 @@ static const struct hwseq_private_funcs dcn30_private_funcs = {
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
 	.set_blend_lut = dcn30_set_blend_lut,
 	.set_shaper_3dlut = dcn20_set_shaper_3dlut,
+	.wait_for_pipe_update_if_needed = dcn10_wait_for_pipe_update_if_needed,
+	.set_wait_for_update_needed_for_pipe = dcn10_set_wait_for_update_needed_for_pipe,
 };
 
 void dcn30_hw_sequencer_construct(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
index 33cc48cd0196..a570333aeac1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
@@ -142,6 +142,8 @@ static const struct hwseq_private_funcs dcn301_private_funcs = {
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
 	.set_blend_lut = dcn30_set_blend_lut,
 	.set_shaper_3dlut = dcn20_set_shaper_3dlut,
+	.wait_for_pipe_update_if_needed = dcn10_wait_for_pipe_update_if_needed,
+	.set_wait_for_update_needed_for_pipe = dcn10_set_wait_for_update_needed_for_pipe,
 };
 
 void dcn301_hw_sequencer_construct(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
index e56b9a46aecf..b14e6e60b878 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
@@ -147,6 +147,8 @@ static const struct hwseq_private_funcs dcn31_private_funcs = {
 	.set_blend_lut = dcn30_set_blend_lut,
 	.set_shaper_3dlut = dcn20_set_shaper_3dlut,
 	.setup_hpo_hw_control = dcn31_setup_hpo_hw_control,
+	.wait_for_pipe_update_if_needed = dcn10_wait_for_pipe_update_if_needed,
+	.set_wait_for_update_needed_for_pipe = dcn10_set_wait_for_update_needed_for_pipe,
 };
 
 void dcn31_hw_sequencer_construct(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index 9900c87b4567..d782080883ab 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -154,6 +154,8 @@ static const struct hwseq_private_funcs dcn314_private_funcs = {
 	.setup_hpo_hw_control = dcn31_setup_hpo_hw_control,
 	.calculate_dccg_k1_k2_values = dcn314_calculate_dccg_k1_k2_values,
 	.resync_fifo_dccg_dio = dcn314_resync_fifo_dccg_dio,
+	.wait_for_pipe_update_if_needed = dcn10_wait_for_pipe_update_if_needed,
+	.set_wait_for_update_needed_for_pipe = dcn10_set_wait_for_update_needed_for_pipe,
 };
 
 void dcn314_hw_sequencer_construct(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 849dae18b738..c68b20104773 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -163,6 +163,8 @@ static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
 	.apply_single_controller_ctx_to_hw = dce110_apply_single_controller_ctx_to_hw,
 	.reset_back_end_for_pipe = dcn20_reset_back_end_for_pipe,
+	.wait_for_pipe_update_if_needed = dcn10_wait_for_pipe_update_if_needed,
+	.set_wait_for_update_needed_for_pipe = dcn10_set_wait_for_update_needed_for_pipe,
 };
 
 void dcn32_hw_sequencer_init_functions(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 5d0dfb36f3e1..0908a791832b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -167,6 +167,8 @@ static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.perform_3dlut_wa_unlock = dcn401_perform_3dlut_wa_unlock,
 	.program_pipe_sequence = dcn401_program_pipe_sequence,
 	.dc_ip_request_cntl = dcn401_dc_ip_request_cntl,
+	.wait_for_pipe_update_if_needed = dcn10_wait_for_pipe_update_if_needed,
+	.set_wait_for_update_needed_for_pipe = dcn10_set_wait_for_update_needed_for_pipe,
 };
 
 void dcn401_hw_sequencer_init_functions(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h
index 0d5a8358a778..7f371cbb35cd 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h
@@ -68,7 +68,6 @@ struct optc {
 	int pstate_keepout;
 	struct dc_crtc_timing orginal_patched_timing;
 	enum signal_type signal;
-	uint32_t max_frame_count;
 };
 
 void optc1_read_otg_state(struct timing_generator *optc, struct dcn_otg_state *s);
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index a880e4a6d165..62f45c156c32 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -621,7 +621,6 @@ void dcn35_timing_generator_init(struct optc *optc1)
 	optc1->min_v_blank_interlace = 5;
 	optc1->min_h_sync_width = 4;
 	optc1->min_v_sync_width = 1;
-	optc1->max_frame_count = 0xFFFFFF;
 
 	dcn35_timing_generator_set_fgcg(
 		optc1, CTX->dc->debug.enable_fine_grain_clock_gating.bits.optc);
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c
index ed66a2bbb8ae..a3431ec2f058 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c
@@ -283,9 +283,7 @@ void dcn42_timing_generator_init(struct optc *optc1)
 	optc1->min_v_blank_interlace = 5;
 	optc1->min_h_sync_width = 4;
 	optc1->min_v_sync_width = 1;
-	optc1->max_frame_count = 0xFFFFFF;
 
 	dcn35_timing_generator_set_fgcg(
 		optc1, CTX->dc->debug.enable_fine_grain_clock_gating.bits.optc);
 }
-
-- 
2.43.0

