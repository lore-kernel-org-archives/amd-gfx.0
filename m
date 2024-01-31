Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF07C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 20:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CAB410FCBC;
	Wed, 31 Jan 2024 20:15:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B748C10FCBC
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 20:15:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeFDzSf81jrB8hpRBmKvEbE/1KEyVFlQFaSjNESmE1yD/pkHmIIF32NFCLeu94oG74VlMrEH9ZIVH20hD+GFozRLnJFE8czlcmuMhaqIGydwOjTOmYHdWBg4CDUfniLM6StlS2KdbwOfaKhg/K5Nb2c86vWNmoYcM3HneeLUfVkMOcgO+/7v4dOxsDsm0OEbsRZxi9GA73WgDlTXWcIRbQQm1H/oU03u3dnVhD4xh+P5jqgIezdaTBsoA1BD3Yy0P7LcwMM4uWCTs32aAwChqDWN84OC2p/NyuG1aS7kXJUQE2otw5WvW0tkbj7LCubOdaOtkd8QqNVTu75S9Bf3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCUzt2IzV8aSu1PYcb4DvyMMWc0GX4LPkZ4qHCyBwqE=;
 b=DtebG82RZ6w5XOPoXSvysmbioljKdFHg6U9Pf1nJ1OCuiY8KqEG3EUsHm8Goj4thabBH/vjBp6WI+3Z/Bj7SDCBZjazWHuitSExL4yc2M1nE1sV4WQJE4v2SJx1mAv5Z4/MEPGGbTeASbCvDo3mhZkQgGw8nRdq+mMGz+IZZK3rEPBpNQIniIRVyMbw3tkcxgxRYMc88eS+b9aftP6uwiO/rJPyB53kv+YUwTPQm1sYcUutCZX7rJflaCdbCgq9xJKYcNsKp20PagIc7YI7I22EwNQnTTPkvQgVPBhywyGFtYXWSuJ2Dn3f1TOAmxvJ+Sh1ZUoBynwblPfyRUzPz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCUzt2IzV8aSu1PYcb4DvyMMWc0GX4LPkZ4qHCyBwqE=;
 b=IEVYQjK+1iPFbfkmlFafmUcbCVJyYo2UZc9V0n39Cm3GptNEEPX6x0JgqNrZDiAAuPvCQKK9acVLjNwQtq9VNmA/GwEz37wDTP8e9Bv6BwUQGS14WReyzAENPOrA4uVCfafj8xIFm8EisbCrJpM9nC//7qjO4y+X7C4ZJshucWM=
Received: from SN7PR18CA0008.namprd18.prod.outlook.com (2603:10b6:806:f3::32)
 by BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 20:14:52 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::22) by SN7PR18CA0008.outlook.office365.com
 (2603:10b6:806:f3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Wed, 31 Jan 2024 20:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 20:14:51 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 14:14:50 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/21] drm/amd/display: Adjust set_p_state calls to fix logging
Date: Wed, 31 Jan 2024 15:11:20 -0500
Message-ID: <20240131201220.19106-15-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131201220.19106-1-hamza.mahfooz@amd.com>
References: <20240131201220.19106-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|BL3PR12MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d16eaa-5eb9-4704-51cb-08dc2299485c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sSsDMJLWyvK94kDeir8S72/JYfxDI+DrT1olcA/aZBt4IZz6lM2Ma1pBUUH8FxGNT+6cfRRlbumsB3J+CAB86JeTRb/2P2fsr7VTHqD6Iw8PMHi3ZJpNQ1dCVjaHNcOH4BuCRrwBuyxWOrFhq2zbubD9fzLxi/NiajlIY7fSuhvG4Hssdk9BZDTN0hpn+WElDG9J9YR8EauAgcaEKMWNZyxPa6U7nc1b2ZHMgv3J0St5ZZEz0vLwmon+ySHfp969wCjHIFIpPzNEjW+73MvjkJzocvgODjI8SX93qMN4tsVSp7dhGXF5Eqf1BaA3FB1wgdzV6dS6LofWFBItJCIhkjMcE897PpBnxcnWX7MHJvJ2M7/WP/tJUhaLNpHprgw4lKrknW3AgFV2OOpg7cUGmlyTlZsCzAPztmyWOju2kO1CBL0Ip55HuVwAFwQSWbfJQnv0DJA/kVrpCvBj1c+nKsPQNmKQheGhEbjCfD2o6SyTl02F8y0SGaVIoZ1S2lP/9OeDFI0lKM+gPCuecu/CURmxs6SPbyADw7n5q752fizoZduGOFtedr0WtMM/Z6rMYL4cmbOPW3IDi+JtopafZl6OX14/I6Kj8arfDuRwD2xSuoikQvJxq4FJh+nnNxC5gmF9Ibzx5vol1OSq8kWP8czp52eZJwvbfPBJFUT053+CJJRatFpV3DZa7C7l6UKpej5vpPP30dopDEwq4XpIsaBiey3uUhiRl4uF0zd73qFre3pxnqc7XpIL8lwOz32KmnQAiXnu2bmN/um7RjLb53uuDf5Fi66T5fRb+Nn5EBX88tgGEtQRAV/4xKAij//B
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(8936002)(8676002)(82740400003)(26005)(4326008)(47076005)(36756003)(40480700001)(40460700003)(6916009)(54906003)(70206006)(16526019)(70586007)(316002)(83380400001)(5660300002)(356005)(2906002)(1076003)(44832011)(478600001)(2616005)(81166007)(336012)(426003)(36860700001)(6666004)(41300700001)(86362001)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:14:51.8336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d16eaa-5eb9-4704-51cb-08dc2299485c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425
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
Cc: Ethan Bitnun <etbitnun@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ethan Bitnun <etbitnun@amd.com>

Update the p_state type before update_clocks is called to ensure
accurate values are used for logging.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Ethan Bitnun <etbitnun@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e58bd0861dc0..9127805f19f4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3565,6 +3565,17 @@ static void commit_planes_for_stream(struct dc *dc,
 	if (update_type == UPDATE_TYPE_FULL)
 		wait_for_outstanding_hw_updates(dc, context);
 
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream && pipe->plane_state) {
+			set_p_state_switch_method(dc, context, pipe);
+
+			if (dc->debug.visual_confirm)
+				dc_update_visual_confirm_color(dc, context, pipe);
+		}
+	}
+
 	if (update_type == UPDATE_TYPE_FULL) {
 		dc_allow_idle_optimizations(dc, false);
 
@@ -3599,17 +3610,6 @@ static void commit_planes_for_stream(struct dc *dc,
 		}
 	}
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-
-		if (pipe->stream && pipe->plane_state) {
-			set_p_state_switch_method(dc, context, pipe);
-
-			if (dc->debug.visual_confirm)
-				dc_update_visual_confirm_color(dc, context, pipe);
-		}
-	}
-
 	if (stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE) {
 		struct pipe_ctx *mpcc_pipe;
 		struct pipe_ctx *odm_pipe;
-- 
2.43.0

