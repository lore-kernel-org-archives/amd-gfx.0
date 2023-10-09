Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E117AE95A9E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 15:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68BB710E280;
	Mon,  9 Oct 2023 15:55:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5569710E14E
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 15:55:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZJF+8rANi96gmCXY8d6bLRvy/NXlgO1hhX8WwxFIyR7mbvuzW2j/TrpFsSjk0BUC8lR8l7qHi0nOGYo0GwUhIJKnY9rrdBxPSO3SQAzetSAv9aDHyzwy9VcipU+EyzYLFxOYiXiQcpNTTvQpEHMPdJKrlirHNVWFhDdI1qU3UH/5JkwJ4vbWIAH5TZC8vZjF7AGsxcOFmMkY0y2+YxJRQTfcRfxdnpIGBXD6K8ognYo2qc3QMhCu/24Oqaj4hj7fcRtAa252oFvW4A6Iis0zmPyF5Y1wGFqBdwfoeUYBMS4xqRfpcfjCCY1tHD9uLqcjTN0mWl0O4BaKSHgWOhZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0sb5G0WQR72OT7XUtgWGIgVCbpcDlbP8u0ybmYj6fE=;
 b=HW+PqbOIBG+ZPJWzfPoRMsxurxd9UPlEuBxFtqtyayV8Z720D4gwbvMJMVO4qv5v+X63FFuJtQ9Emy1MVNMgy+duwMr0/S19MX+eZp4KMr/gTks+UjhU2pTBxIU9zxb5oSg7CvoqEMvAKqRypVy0GGEFb7Tem1ozpJulz1NWGKUekvPcaGnJOXKGx2hfxpL93hj3XAxyW9C0NM9poJwANGtqtWwDKDXdNEfEVU1Gl+vwQvix5+4CjtmOGgCmQlGjyNFTDJBt8vqxCC2a9E5rVnWY6Ridw5uRlD0XB9lNsQa9R3oQ4X8znJZCzH3NhB6II6g7l3zsC1QVB1pH4XtiZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0sb5G0WQR72OT7XUtgWGIgVCbpcDlbP8u0ybmYj6fE=;
 b=0/LM4fufREzglRQ2N1p0W45F4VzyTRsZ1rXAf77o6F5aUzFbBRnlv/BqddnU/lUNA8kYXCqe0FZMOr3zyQEb1wAMWwCJhNMtkIg272ys05kQOvDMSaQfYJhyOSLpL0eZnFf2s7KiLJGjtIvkNli7im0gsnh5GBLg8yNkl1Aj+Oc=
Received: from CH2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:610:50::40)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Mon, 9 Oct
 2023 15:55:03 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::b0) by CH2PR16CA0030.outlook.office365.com
 (2603:10b6:610:50::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 15:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 15:55:02 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 10:54:58 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 6/7] drm/amd/display: Destroy DC context while keeping DML
 and DML2
Date: Mon, 9 Oct 2023 10:54:25 -0500
Message-ID: <20231009155426.96232-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009155426.96232-1-mario.limonciello@amd.com>
References: <20231009155426.96232-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb70d02-b277-462f-f677-08dbc8e01958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Boa+L2+l9wD4T83KAY7R5sf5D3bC6Wn9POQwAsEqLIhCSozTQm06+FsYrk3EMEH/wtp8jhm44shTyy1mqo/GqJl6D5W5huITDYv9sMRUJ7JwiI31pzZb4fqmVkiD/GKDfHDFMxhXSoGG1HHwYSuBJmgmwKmiLjftfz2RqLEBkL6VOLqZ3XrMgg+lbpObOwESLtQipdxOaHlsw2LGztsCTKPGqlelLGOFb+P7BJhNgKvd/xGN0suE3brcNYrJ9cv6J+vtEdb+iNV5l2VlKnC5gYI3i7eoRzeMrE3AEVyz/AMBHLHgUMV1jPMkT418GbtMVnmPH1tyIdmApnhAG6Xh1iLfNgi0JqZQRMpImTh9Dn0BMfuY9a7dXomdbmRRAXc+JPHd7kJdg3lMyqTlxgA3xMeovTpQfgx5M5UedIFVPN94AuJXIH+/uBiS/8T+rtdsWGtJoyYtt5l11yot88gUT3SubhjUt9URTx0iaBngwIy/XavlbYIhnsieIHJy1V9yd7ByxNwyt0udttbl1HtJjqtJuQlPqapmQ3KJXAcHRk8dByupSaME1Zo14S3DU5u1ZG5OMgMJFIyNkuyHf2kDm7urGbuEj76WuMyE+DAzSP4ZuOu/7ScyY9t/NMZzbrqlqsjCDsISMeB0W42NZD62Tcys6jl6bnBXj6ZpFjtTwEMpsLapPeUBJ3wFsMp5yEkqto7AWEJAhq25N1r8rzwoQ8P5C1r9qMrPrmhq/ibN0J9Nof7iEqQx4OMPHLAjGSDx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(6666004)(7696005)(40460700003)(82740400003)(36756003)(356005)(70586007)(8676002)(70206006)(5660300002)(81166007)(8936002)(47076005)(966005)(478600001)(16526019)(26005)(1076003)(2616005)(426003)(336012)(36860700001)(83380400001)(86362001)(2906002)(44832011)(54906003)(6916009)(41300700001)(4326008)(316002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:55:02.5141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb70d02-b277-462f-f677-08dbc8e01958
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If there is memory pressure at suspend time then dynamically
allocating a large structure as part of DC suspend code will
fail.

Instead re-use the same structures and clear all members except
those that should be maintained.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 37 -------------------
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 12 ++++++
 2 files changed, 12 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 074a692e1c66..fd35ab2ce3a4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4781,12 +4781,6 @@ bool dc_set_power_state(
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
 
@@ -4805,40 +4799,9 @@ bool dc_set_power_state(
 
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
index 25562b262555..a7e49c78c187 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4487,6 +4487,18 @@ void dc_resource_state_destruct(struct dc_state *context)
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

