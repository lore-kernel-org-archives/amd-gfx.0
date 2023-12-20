Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37D2C46CD3
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F0AB10E1BD;
	Wed, 20 Dec 2023 16:36:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48C2010E1BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:36:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddb2YUXHDQ2G680oJOQg6bp1zh4eeBoXMRdwLicYgCG4UEu4ewivkUs6Uaw4MAQso0oAjQKl3xujyWFDzJALzzzUauCAR1PMhd5RRLsoJF8IyPGgHuEQVoHXNxy0hwk8QzJVVFZl6dOvmpJoHjV9jvRKz0oF2mMxGDfJK6kKZjW2HoLO+Lb0k0+7EC6RNkMrL0PJFQ3C2fvRvkRFMhqh/QNaHGVQkKkCLoBoD6tYF0iirj6Jsh89YuyEfmV54ozJ+BjQ5BIfBYGnTnvaGpxXHDIDUdg98MiNMe/bU8MnQt6j/28aTrrLBaUQscMPoDaWB2mId94gIGxgKTZu1b/XKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Qd+ne8ES/Lr5l8gg+qQizyCS8PdwTPUdtOfpZBHwRg=;
 b=D2RtV8tTYMs07ywKnmNVsIlBeDVVNE0ToeYSRqn9NUdqRjMM70foTQDmYyf9Srzj/r0DUjVtUc6sRfNFW536fADyKCBO0dFCXA2CwqekGTvyq65IJPdBA/tehCzROM8Rwe1repQhqrbGvX1FJYI1Uu4KGvdiOz3rm9zKKA/6ilFr51FFhXzjqScJJkj5FH3WKHSNxdO4Am1ifL6z00Nn5msvukFMyo7Gz0WmKXifX6ai7PTKmhxYCTlHK75oAMrzjD+Xloe0poFdzyksYFh/diW7ADHgUhJwAk8q7G/PYpcoDu+k+ZiyDkrKPVn7iCfmOkwl5vapJoK2hnvx4/Bvzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Qd+ne8ES/Lr5l8gg+qQizyCS8PdwTPUdtOfpZBHwRg=;
 b=WMMQmwZxanCzcvcJ1aigMn7Us4cevAC8DQiqEN39pi4woMI/ldwU3AGUQic4LCT8I9M258B/jhpwzorwBGMFvRv9cPk2qDUv+5h0w11DgT7zTfRWR+lPB+m75dHca6Q4QXnYLdy7wue4vePCWLvFtuhiP0CVfvQZcsK99tbhcQk=
Received: from MN2PR16CA0054.namprd16.prod.outlook.com (2603:10b6:208:234::23)
 by BL3PR12MB6521.namprd12.prod.outlook.com (2603:10b6:208:3bd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 16:36:43 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::4e) by MN2PR16CA0054.outlook.office365.com
 (2603:10b6:208:234::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 16:36:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 16:36:43 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:36:41 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/20] drm/amd/display: Fix subvp+drr logic errors
Date: Wed, 20 Dec 2023 09:33:33 -0700
Message-ID: <20231220163538.1742834-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
References: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|BL3PR12MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: b6988b83-ab59-4478-d657-08dc0179d98e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i3U1miGovegI0jXOfEkv+CHd7gZuwBkq8PyEAbXEGFZE9fWv/jLcG26Jr/sfqe074ZO9reG7elsTK8z7ISDbOWaRtfYIBRCeINdu0VRR3RIm0EXUZ3/6IPwN+H98qiWvn0Ru0m0hMoYHT/wxatNO3KG2+F7WlhX3nOEcLe21KjvfxiHVXtUYq+awqOsVh6/Y5BV3ORKXB0fsplestd8X/HGbMiahMeuZqcfrNYgOo3+v68rtlQB6jU30SWwcIqzT2wh3YnPz/xldTT1N+Bd7mD/j/dvaYLnPFsuQ5zdkwcc9/HC6RBFEy9LfuE5Ou9FyZSNvcXT2uuX6Fl5pCnz3H+zQWPDbQ/kvilL2RvQE3Gg8q9KAeRAyz8TfopGqpjlT1bIt6cBfSVQN5on4lKIIIGT+DN/kzRZqZ79lA4+l6RW6MH6EFu3teCB0vOikv74Vs/F7nd29w1mJTrUVvxYIM9nWOGwFSot8zK1zmAZmaZatXkHc33FRaDtmXU6zc42mouirQMfZPPdoyQlSiU2Vrw/iNcCpL/5hokkNZlwX/2y+BqL49TPLyqKxQHpDG/jzc8CDQg1mk9KB5WznE5wdsft+1HXvfwOsVe2S+qiBNTNoK4RvfGYL//CUPi95IbeBHD2/JeoWizYCY3Z0A10/8kk1gZQNvNZ4/n5pNtEWW4lPQPnxy+CNGO/o7gwrUPpDJ/5K+8sgtqca46sYhyuLTctwG/bTTV4JRR2qAUd+AMBzNFS4iLdTIpgaQIafhnJrhJPXuA8zJZ7HMJvGoUYHhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(1076003)(426003)(36756003)(336012)(2616005)(16526019)(26005)(4326008)(6666004)(36860700001)(70206006)(8936002)(5660300002)(83380400001)(8676002)(41300700001)(2906002)(478600001)(316002)(54906003)(6916009)(70586007)(86362001)(356005)(82740400003)(81166007)(47076005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:36:43.1986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6988b83-ab59-4478-d657-08dc0179d98e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6521
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 Samson Tam <samson.tam@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Chaitanya Dhere <chaitanya.dhere@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
There is some logic error where the wrong variable was used to check for
OTG_MASTER and DPP_PIPE.

[How]
Add booleans to confirm that the expected pipes were found before
validating schedulability.

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Reviewed-by: Samson Tam <samson.tam@amd.com>
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 52 +++++++++++--------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 10c890a9cb7c..cc759b34268b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -806,6 +806,8 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context)
 	int16_t drr_stretched_vblank_us = 0;
 	int16_t max_vblank_mallregion = 0;
 	struct dc_stream_state *phantom_stream;
+	bool subvp_found = false;
+	bool drr_found = false;
 
 	// Find SubVP pipe
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -818,8 +820,10 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context)
 			continue;
 
 		// Find the SubVP pipe
-		if (dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_MAIN)
+		if (dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_MAIN) {
+			subvp_found = true;
 			break;
+		}
 	}
 
 	// Find the DRR pipe
@@ -827,33 +831,37 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context)
 		drr_pipe = &context->res_ctx.pipe_ctx[i];
 
 		// We check for master pipe only
-		if (!resource_is_pipe_type(pipe, OTG_MASTER) ||
-				!resource_is_pipe_type(pipe, DPP_PIPE))
+		if (!resource_is_pipe_type(drr_pipe, OTG_MASTER) ||
+				!resource_is_pipe_type(drr_pipe, DPP_PIPE))
 			continue;
 
 		if (dc_state_get_pipe_subvp_type(context, drr_pipe) == SUBVP_NONE && drr_pipe->stream->ignore_msa_timing_param &&
-				(drr_pipe->stream->allow_freesync || drr_pipe->stream->vrr_active_variable || drr_pipe->stream->vrr_active_fixed))
+				(drr_pipe->stream->allow_freesync || drr_pipe->stream->vrr_active_variable || drr_pipe->stream->vrr_active_fixed)) {
+			drr_found = true;
 			break;
+		}
 	}
 
-	phantom_stream = dc_state_get_paired_subvp_stream(context, pipe->stream);
-	main_timing = &pipe->stream->timing;
-	phantom_timing = &phantom_stream->timing;
-	drr_timing = &drr_pipe->stream->timing;
-	prefetch_us = (phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total /
-			(double)(phantom_timing->pix_clk_100hz * 100) * 1000000 +
-			dc->caps.subvp_prefetch_end_to_mall_start_us;
-	subvp_active_us = main_timing->v_addressable * main_timing->h_total /
-			(double)(main_timing->pix_clk_100hz * 100) * 1000000;
-	drr_frame_us = drr_timing->v_total * drr_timing->h_total /
-			(double)(drr_timing->pix_clk_100hz * 100) * 1000000;
-	// P-State allow width and FW delays already included phantom_timing->v_addressable
-	mall_region_us = phantom_timing->v_addressable * phantom_timing->h_total /
-			(double)(phantom_timing->pix_clk_100hz * 100) * 1000000;
-	stretched_drr_us = drr_frame_us + mall_region_us + SUBVP_DRR_MARGIN_US;
-	drr_stretched_vblank_us = (drr_timing->v_total - drr_timing->v_addressable) * drr_timing->h_total /
-			(double)(drr_timing->pix_clk_100hz * 100) * 1000000 + (stretched_drr_us - drr_frame_us);
-	max_vblank_mallregion = drr_stretched_vblank_us > mall_region_us ? drr_stretched_vblank_us : mall_region_us;
+	if (subvp_found && drr_found) {
+		phantom_stream = dc_state_get_paired_subvp_stream(context, pipe->stream);
+		main_timing = &pipe->stream->timing;
+		phantom_timing = &phantom_stream->timing;
+		drr_timing = &drr_pipe->stream->timing;
+		prefetch_us = (phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total /
+				(double)(phantom_timing->pix_clk_100hz * 100) * 1000000 +
+				dc->caps.subvp_prefetch_end_to_mall_start_us;
+		subvp_active_us = main_timing->v_addressable * main_timing->h_total /
+				(double)(main_timing->pix_clk_100hz * 100) * 1000000;
+		drr_frame_us = drr_timing->v_total * drr_timing->h_total /
+				(double)(drr_timing->pix_clk_100hz * 100) * 1000000;
+		// P-State allow width and FW delays already included phantom_timing->v_addressable
+		mall_region_us = phantom_timing->v_addressable * phantom_timing->h_total /
+				(double)(phantom_timing->pix_clk_100hz * 100) * 1000000;
+		stretched_drr_us = drr_frame_us + mall_region_us + SUBVP_DRR_MARGIN_US;
+		drr_stretched_vblank_us = (drr_timing->v_total - drr_timing->v_addressable) * drr_timing->h_total /
+				(double)(drr_timing->pix_clk_100hz * 100) * 1000000 + (stretched_drr_us - drr_frame_us);
+		max_vblank_mallregion = drr_stretched_vblank_us > mall_region_us ? drr_stretched_vblank_us : mall_region_us;
+	}
 
 	/* We consider SubVP + DRR schedulable if the stretched frame duration of the DRR display (i.e. the
 	 * highest refresh rate + margin that can support UCLK P-State switch) passes the static analysis
-- 
2.42.0

