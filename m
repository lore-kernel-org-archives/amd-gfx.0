Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6036CE92FE0
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 18:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A91D10E55F;
	Fri,  6 Oct 2023 18:51:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD0D310E556
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 18:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpMwe57Elpi9abWT6R3fIaEHHlfvKkI5efkqGwptp2BpWH7+vlFIqCXOigbcDgRPTIG63QQyIwka4Swfv/bpcoGpm1I7Q2qx/Ji6k2kjJoeFUGnWN6O2JX4sMdMKrBaSBVv1QN2teLjHT2kMx/YzLVDUQkx/CEGiL7Qd5I+hz4P8NU+VcX813doi+HDcc+StcxXyOayVA3HLa2YR411nRGvkJdVpmNowfGTjX/x0JpRAKcSni0al7m+LP02Pc365jKsfRYKm9S8FlT+ku1su+LiYjpzuLgvtBj9yvCpgB7/oN0Oxs5d0BansepjDTGHG39sH4UVGc7Q9Zl2KCRAmMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObIbCUyP+YDqCHS+G+viK4fYufMQjqCozfxbyj8C5M4=;
 b=aB0R7U6w6fSPnzXXBDURO4dClqvsb+hY80sS+4oc8BgX9BNtq4562qz6FWcz+b8xDw8xWwOVWCQOb+RaX+a1bsfGl52UUrPAPFKkHJKIC781yhb5E7ZxRBVurQsPIgn9VEa+ZctTS3akkAaFqIlbqbk4DP1dljly+K1jF7g1mtNS/Nl+/npk4xGAqh23JesAcjDqRRDJJpivFrt/nFpStBzL4HdKGudVrOHpmQV+/1Iv1J41njh/+wTQRuC+NM1ER7DW0RhsGQ9QYBfRyqZdETKiyAz+91E4OiGrYq1yz6zm2saiBjKsnMDaGNXlu82GITf59FHmgBXX5RuBQB4eUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObIbCUyP+YDqCHS+G+viK4fYufMQjqCozfxbyj8C5M4=;
 b=sPtUDN7gAVAVmXMrOIuqbiyriKReLJiEseeqpsfiaCm8yTCP5AR1q7It7HywOIgtEX4fYcBq+qxhpg0bu6IoujDIh1UfjCJnNJNUJFu58WNvzdDE9bA/q7VzyeLwJEHBoGw8dxDxc4ZqpSLDW4Vg/TOoyrIWzfOEMki9eeyA8+k=
Received: from BL1PR13CA0247.namprd13.prod.outlook.com (2603:10b6:208:2ba::12)
 by SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 18:51:23 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::fb) by BL1PR13CA0247.outlook.office365.com
 (2603:10b6:208:2ba::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 18:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 18:51:23 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 13:50:54 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 6/7] drm/amd/display: Destroy DC context while keeping DML
 and DML2
Date: Fri, 6 Oct 2023 13:50:25 -0500
Message-ID: <20231006185026.5536-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006185026.5536-1-mario.limonciello@amd.com>
References: <20231006185026.5536-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6c1386-8768-4eae-d777-08dbc69d3ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VChtFLxP2aVjthFD/ViWidEYdl7Yf9dJAA+zhJfi3HeqxtpYywyP3Ng+8MnK/tNWpbSiBbHr/zbOV58iafjZxL/hWKzrsIn8NNKLRv0/dxOi3u7uWKObRHIL48Qe9gFgT7i2Bob5fo4fc3gVxDYqDQSyc2E864bt8coj9h6HjHZvD63JNrg+SO7PF527ufkQPUvfItwIuThb080rcD1URGSIBwRkM1xa69jhB6NCcii+327IOTlLbltIUnu3YkAIG4KPtolbFD4IToqM8J6TllDNi53glhbJ33HKNgp2DUOlfomchkatj0zY9nKlKN5HSu37nNRr7/j3opSJ8/eaOXipHKi4MPvgF78KVavpKcHZm6lzpY0mRUpHUHK/6QnbJVDeRIKtUnRhBs3ROfFWim6c4To78M20iAvOu/bZbpIIjQXV4Zj1PF/dJWwJfH8wGyru7JdUuY+fjMwKzM3UU2485gX7uKjilEmfq11Hp8BOpEAbLLIqg+cAza+LLvh/gH3P5e0wty8Qc2zv3BSwIohCmGrHev0PxoGFP9+PaS1LuPRlS40W42ULL8xGPgZDAspx6UvIMTTwA2dQWRMFd/VwjDuXADuxvvxdRI9h20FRbXr5j4CCpECUzT2s4Bbn0WVCefklUK0fEjhoKAMdnoPcqZsWmzahDyQgZPa1/DY8pYHqln4NHB9sLP86RemtwHCDwA/Lu9eiFPaLiqiTivIY9G+ymbw5P+HMZlmv9GL4Z7xAngtqtCavDWYK5Fdl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(1800799009)(64100799003)(82310400011)(186009)(451199024)(36840700001)(46966006)(40470700004)(36860700001)(44832011)(8676002)(8936002)(4326008)(41300700001)(316002)(6916009)(54906003)(5660300002)(70206006)(70586007)(40460700003)(2906002)(86362001)(2616005)(356005)(81166007)(40480700001)(7696005)(6666004)(36756003)(47076005)(82740400003)(478600001)(966005)(1076003)(26005)(336012)(426003)(83380400001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 18:51:23.2189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6c1386-8768-4eae-d777-08dbc69d3ca4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832
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

Instead re-use the same structures and clear all members except
those that should be maintained.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4->v5:
 * Rebase for DML2
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 37 -------------------
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 12 ++++++
 2 files changed, 12 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2436a293931b..55e7b5a8ec8e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4704,12 +4704,6 @@ bool dc_set_power_state(
 	struct dc *dc,
 	enum dc_acpi_cm_power_state power_state)
 {
-	struct kref refcount;
-	struct display_mode_lib *dml;
-#ifdef CONFIG_DRM_AMD_DC_FP
-	struct dml2_context *dml2 = NULL;
-#endif
-
 	if (!dc->current_state)
 		return true;
 
@@ -4728,40 +4722,9 @@ bool dc_set_power_state(
 
 		break;
 	default:
-#ifdef CONFIG_DRM_AMD_DC_FP
-		if (dc->debug.using_dml2)
-			dml2 = dc->current_state->bw_ctx.dml2;
-#endif
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
-
-#ifdef CONFIG_DRM_AMD_DC_FP
-		if (dc->debug.using_dml2)
-			dc->current_state->bw_ctx.dml2 = dml2;
-#endif
 
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index c1e2f0e10ab2..e2c7acdff301 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4357,6 +4357,18 @@ void dc_resource_state_destruct(struct dc_state *context)
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
+	memset(&context->scratch, 0, sizeof(context->scratch));
 }
 
 void dc_resource_state_copy_construct(
-- 
2.34.1

