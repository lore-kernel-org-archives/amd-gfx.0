Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E850E776DB
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 00:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EC6410E13F;
	Tue,  3 Oct 2023 00:25:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 188A610E12F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 00:25:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KF/JJ6S6WxHQpCvmcUTviEI1B5tAKJgWFg8v48ncQWnAVW0V9AfZE9DKF6g3qkjbgnTORerRmDc0GI5AoFYx4eUF8oczI6IjwQS6UvVOZ4N8TaS6kAcOdYPS4dzBkPVbcuuWCkTQqED80TMtFrz07wjrZge8dBckJbtU51UeKSR5qGhiSp+2mp9TslXqA1tA2c3Ywco+K4DetXAxwqaGHcXPEPClHP3M4YEpNE8+mHGAuMvECJeSdesTuJOOx6brNCq4Ix4BwVPfsj7uv5rk/pxNGFpXAifOTdoRobulU0tF75Qk7tzas2gFHMQjFrkzLgvG64Ep5pT2obATAXFS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9+SclS9XWdygbyCnTjn2s5N/AA7VrmKEl+7EJra+NM=;
 b=N4LMM6Vi8K0vgynq3vrrJn/YervSfXUaTg4wNPjUl94Mvjg7Pgo38mLOERKz6rvlHD9GXsZuVtZVf9+e0S1t3IgotYmRJwsmeq5rZxiADfL/1TB62ThQHx3OD7qVyi4d4U6PYqWodHatPkDE5bV5dAzIQCCHQqUeh6oNGh61UdovcwjeUD1kkFwI1ejBfkNOf/6f3PVHqIA6hrtrlSxQk3hWMv3W35VcOoWGvjzCSrkWvdNIz1Qphn95j7fcLUlVT5OkWf9FW7T8Wg6EZJIGVmh1ULUUTD1TiI8nZGyMiLvXQuvIG+dQUopdfvQft9X8DYk2h/WycfJ2KKiVQpVkAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9+SclS9XWdygbyCnTjn2s5N/AA7VrmKEl+7EJra+NM=;
 b=eBdJD6IER4FA725eyP1U7PHLlUwK7UG+VHqUlSdybn+5CgPzhDv6U4bn9xM5T3Wm6duSlt/gDXuWYfpRsEbRH2lmVFsBOR77s4HKp4trDpbVAK/hzaf1n1obr8oYDkxITy/exNh0DacO/giy2VC4ZoLdMZSx31+8lVnmXLGgRgw=
Received: from CY5PR22CA0007.namprd22.prod.outlook.com (2603:10b6:930:16::21)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 00:24:58 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:16:cafe::7f) by CY5PR22CA0007.outlook.office365.com
 (2603:10b6:930:16::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 00:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 3 Oct 2023 00:24:57 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 19:24:56 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amd/display: Destroy DC context while keeping DML
Date: Mon, 2 Oct 2023 17:44:49 -0500
Message-ID: <20231002224449.95565-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002224449.95565-1-mario.limonciello@amd.com>
References: <20231002224449.95565-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 7761baba-c429-4b88-55e6-08dbc3a72ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +S5g1IsoZeOMplMGquFloMeL/Dqs2hWrWezCImSOogTFAJW8ARLxsqNmLgv4QdSbLE2QcMAVDvcEf7H/YlYMwBvmgpclxF0WKO34xlDPWn1eul0zxuRY1+P5/VkGAUw+cMkrz0v/7/+f/ZOo49/gv9WisI4GX4QhO3xeTs8QntCMXeuQAHHprQFWwsB4p4hDjW2v6FWXSABN9dsA3Z3o2Z7sGTlazAbCw1fn7yaR1XptuqnRLrKyTKStfxLi5yMOy/SZz0uuvZNX/fO4kSm4xLIkdoKIEF75+6idglILLAcNhrFsHvroVz6dU/lbjh4Ec0236h/022bsNBsCDhaMJ3ugn0ivDhlBhqpzXISfLIQR9SMsAxcm6DO+aNldhEtDWI9hZQYSN6UtKAjshnj0LA4ScZ6KEr84h2L6hjcGLyXFgzmoFZbw31dS+vT0tz0NKcHFQ3YFjzphawy7jz7kRbo8bu348AlgJmLgZ6ZCl7RGGan5zD0tB05bLhtlzNj4Bum4RRZmyTtiLzoKFxnanx9mRmD+fs7g+Q5Or0B3/a1ri8/2DMS4Msxj++Mh/NBmrKSmnaXpkqwSkbCUBguxPy+miaGpQs9H1tEuKTJLV388LYfO/cOrSlTU4aICGFlAG1j2LE/1oIAwvISo845yC8QiWyQqxEJi0EjXppGtjPga2xMlAPeJ07YIVor1VbA+gQ+051McrDy8LEAQwNWDalN/4JHF5RiSRU7/G049FgOaeKSxNvUVWNH5dtwej+D6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(356005)(40480700001)(47076005)(6916009)(316002)(54906003)(70586007)(40460700003)(81166007)(70206006)(83380400001)(36756003)(36860700001)(4326008)(44832011)(8676002)(8936002)(2906002)(86362001)(478600001)(966005)(6666004)(7696005)(41300700001)(16526019)(2616005)(1076003)(5660300002)(26005)(82740400003)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 00:24:57.7845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7761baba-c429-4b88-55e6-08dbc3a72ca1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257
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
Cc: Harry.Wentland@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If there is memory pressure at suspend time then dynamically
allocating a large structure as part of DC suspend code will
fail.

Instead re-use the same structure and clear all members except
those that should be maintained.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Harry.Wentland@amd.com
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 25 -------------------
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 11 ++++++++
 2 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 72dffb7a49f9..e917530e4024 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4728,9 +4728,6 @@ bool dc_set_power_state(
 	struct dc *dc,
 	enum dc_acpi_cm_power_state power_state)
 {
-	struct kref refcount;
-	struct display_mode_lib *dml;
-
 	if (!dc->current_state)
 		return true;
 
@@ -4750,30 +4747,8 @@ bool dc_set_power_state(
 		break;
 	default:
 		ASSERT(dc->current_state->stream_count == 0);
-		/* Zero out the current context so that on resume we start with
-		 * clean state, and dc hw programming optimizations will not
-		 * cause any trouble.
-		 */
-		dml = kzalloc(sizeof(struct display_mode_lib),
-				GFP_KERNEL);
-
-		ASSERT(dml);
-		if (!dml)
-			return false;
-
-		/* Preserve refcount */
-		refcount = dc->current_state->refcount;
-		/* Preserve display mode lib */
-		memcpy(dml, &dc->current_state->bw_ctx.dml, sizeof(struct display_mode_lib));
 
 		dc_resource_state_destruct(dc->current_state);
-		memset(dc->current_state, 0,
-				sizeof(*dc->current_state));
-
-		dc->current_state->refcount = refcount;
-		dc->current_state->bw_ctx.dml = *dml;
-
-		kfree(dml);
 
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 628b902a4cec..1f051aad1ee9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4350,6 +4350,17 @@ void dc_resource_state_destruct(struct dc_state *context)
 		context->streams[i] = NULL;
 	}
 	context->stream_count = 0;
+	context->stream_mask = 0;
+	memset(&context->res_ctx, 0, sizeof(context->res_ctx));
+	memset(&context->pp_display_cfg, 0, sizeof(context->pp_display_cfg));
+	memset(&context->dcn_bw_vars, 0, sizeof(context->dcn_bw_vars));
+	context->clk_mgr = NULL;
+	memset(&context->bw_ctx.bw, 0, sizeof(context->bw_ctx.bw));
+	memset(context->block_sequence, 0, sizeof(context->block_sequence));
+	context->block_sequence_steps = 0;
+	memset(context->dc_dmub_cmd, 0, sizeof(context->dc_dmub_cmd));
+	context->dmub_cmd_count = 0;
+	memset(&context->perf_params, 0, sizeof(context->perf_params));
 }
 
 void dc_resource_state_copy_construct(
-- 
2.34.1

