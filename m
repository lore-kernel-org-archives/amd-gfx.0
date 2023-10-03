Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9757E8FDB6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 20:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5186E10E100;
	Tue,  3 Oct 2023 20:57:38 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A59A10E314
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 20:57:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJMl6YRa0MKeTMRZaIF1QcCG/qMuLbD0pA6UeN2LCImE4MZfMMFTCZ5xP9f1SGBtK14WP5YXYp9/F0lFUL3r/0P2UABNYIXIYUjbUxh/gZ3bHR229T0aJIUgR8nja5s7HW9UeoEC5n+0CC3fBiGEp9qrV1bHsmTsRWVgd9jWxEh8GjEJv87cwg6DrFJr69bJyKtenn3WU0E+lpNvcx/rIX3V9xS8xbagMv1PpdK++IPZHLHpun++9sWxEIjFUOT7fCsORrT965ttXnTL1GA1maSHrc8IAuhOiSw5L4sdbx3DgwVVOibznHzYyPBjiDPwWjhPtc4CjicSrHgw0VH7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAVzKuXOqCIAAhRFbJvaFRGsYvxcZx+OdwE9PSWweXk=;
 b=PgpL9DVIqDbyJAj2Xosez75zzIVuKTHtl4Cqv2CRctkRmqv2qQqnRUPUR8CKeXHHlnAw3zuuzNZVNuhVYsDy8mcH7duC9AHxOaDlFLpzcxmy3FvqsDUkd9gGZuD4LsaE3sZMY9aZZHGj3+LnoiHfqHLBvoYmVek6AopgAcM3wRloTl8OeicPoaI9Hzf3z6YkgFePOyaOmX+oNrrNul46GxBznKSTs3pJmrA6CXpkS81002H/Vfu8t4qkAgOvRmSugXDLSjO2JHsgf9Hk1Ik/Lw/lryWXxBtzT2IpoAOnWgu8WASXopfXhGcTec78NN1HYfo7QSi88CLMFV2h676C+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAVzKuXOqCIAAhRFbJvaFRGsYvxcZx+OdwE9PSWweXk=;
 b=UtuNgq5xoz3KZjkVKsOyHWvL+lkj0FfH7tdNKMxxTR2NkZrtwxicOXIBJXgddUjErWrPpzGj2En3Sh6qGYuXg2Hoa76aUv5aMpN/QLkDQzhiDQb6CrSIPVQjP4nF9uePVJGno5F6vyOf+QIIituo6jqR1b6ntDz6eBhmi2bMRdI=
Received: from CYZPR12CA0007.namprd12.prod.outlook.com (2603:10b6:930:8b::25)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Tue, 3 Oct
 2023 20:57:31 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:8b:cafe::74) by CYZPR12CA0007.outlook.office365.com
 (2603:10b6:930:8b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Tue, 3 Oct 2023 20:57:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 3 Oct 2023 20:57:31 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 15:57:27 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/4] drm/amd/display: Destroy DC context while keeping DML
Date: Tue, 3 Oct 2023 15:54:36 -0500
Message-ID: <20231003205437.123426-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003205437.123426-1-mario.limonciello@amd.com>
References: <20231003205437.123426-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|BL1PR12MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf10148-d281-4edd-364e-08dbc4535c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aeVqQIb67ihWJzefNLKvjVd7aUdnDL4K4HuVmcHhB0T23Uli5iF6zRnS9vTzW/Loq85pirOzyfvsqYy3m1xAbrOw7nQbRp7h4+8+NEOmjyXEtHafQgr2bE6NqaTljbaKxESFks+NzMdTyrrVPDR9b75KMQ8O6xjBuCpnTpgYJ9RdO2nGZumSoy5o7uRhEfGBYfbJBXRiBg5YGPoi3BfmgwzDTt/BJslTTkVGVx1cZWusvbCgp8llNCR4HGJDeyuW4GdRLvIvce02HU+fM7ACSorCA8EeF9iYwWa8EeeB72EC5KUA+eHGg2i665Sx5o0REI7S1JEdtAGQWOnix5ayJ0lSEzDXF5Eukq+TH6rdUTpaezmlYEHfslub8gEJUtxuQPtp+F8Lg0hykIPepdwr5w6/rMPDxOtpN0m7CFH1WHk7Az1CZHsT2MBuTmYUiai4g7XL89GQgBmFXk4cjzqRD6Pi0XPwbHUDPXG9BFOMQmD+rmYSB4qrYwgfNyZHkkXhcuu6yR3V48n21yWn0mrYQh0nUO6Kid6J32EK31i+sYwD6iZvRIysEz8hAgY9v1St8/JUj79jBMxK/apvRmPs2ttdUR8qqQbjmD62zSWVGOunC/E2e7eepYo4MYmso5ZwBMAl+ie2tyHrVxYy2taLvUwmZgdhmmN3cSd8ZFynCEo1Fk2dl1yRiehO1letnDY2qozN1siInqApwJU6eJMOeD+Ho/ChYzSwZUfbmTvrHS+YkS9mEFCfybN9kWobmCeC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(7696005)(6666004)(966005)(478600001)(81166007)(86362001)(47076005)(82740400003)(44832011)(356005)(2906002)(41300700001)(426003)(1076003)(26005)(336012)(83380400001)(2616005)(16526019)(36860700001)(8936002)(36756003)(5660300002)(70206006)(70586007)(6916009)(316002)(54906003)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 20:57:31.3429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf10148-d281-4edd-364e-08dbc4535c65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
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
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 12 +++++++++
 2 files changed, 12 insertions(+), 25 deletions(-)

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
index 628b902a4cec..202f5364bab5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4350,6 +4350,18 @@ void dc_resource_state_destruct(struct dc_state *context)
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

