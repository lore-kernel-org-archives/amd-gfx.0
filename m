Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054B1E7C4E8
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 17:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B32310E3AE;
	Wed,  4 Oct 2023 17:19:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4825910E3AA
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 17:19:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzpebaZAr9SIO4xrg0bjCfsHlJfVXI2enkWfwjIyJCuQcIWsy74MZh4xoGhP6FPF/9Wg1wUW1wPqDKy64Y7kszGMcyJGvEuSaazY3o3S1R+Bp4hpw64rbk70ltPSQlTgIExS0qcAdu1Qhc7JuEowg84oOOGUzYMZ0uhIcgkfcyZJZd3u1voTtHC9s5LNPPxGZZezK+JiBGqP50kBdq4YRXWaRWvNlB7SgDPCaTesbh79dwJwwLd2/vCn9KHr8LslfBzJCUV6qAij51hge8RT59Mu/Q4CE8SRcFhVkhG79+Dh8EXTbbjM0iAuZbsWdz3i0CyU/E6KNxHMyDPwnSQGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CTQUfvd8HA7ZADPwjiXpHEczesQ6OBYXJa23B8q/1w=;
 b=Y4x7tnLzIB7pucaO9aBZ3eOzeFgGv/bWlYSS0X/k9auCjSx9tiFUGqMRscK9n499X5csFqobDAFY6SPDCPpwwVRqIIiXwKqH1lHw3so8Es+huNGJfgtM5AZlW1pmTJUYDzyQF3WjOWFZS/o0MmJvB3teC8L/lAjbhQ3WcVhIYOd8z8lS3zlbfGNJtbfxuWS+q94MDlqtKDnpKVMJI04EFK3v1bELwnTHoK9Uz8aYAp/T51S1onnCZEiqmmlhhf0d6WN0+nHhQyHKgcdbmUBW6UzvLKZNoS7YTwLlQ67T52NR+IGU5Kbv6gVe3n8ZmyXyzjRJGC6ArGJZz8f04+iXRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CTQUfvd8HA7ZADPwjiXpHEczesQ6OBYXJa23B8q/1w=;
 b=fXMPA3ofUa79I5ZnHNBL7QS9Z4tic/JdO6NC/4nq55DUMf/SxTMKJFtevvR90mEJsYHbaqL7gnFBSCR9cu1jQVeusajOag2oedb9PjLol5tOhb8iId/kvzVIgUzatkQNsMSSp82ysSAsiLYfA2djNDHp0iHcrxvw54/TC1Ctqdc=
Received: from MW4PR03CA0165.namprd03.prod.outlook.com (2603:10b6:303:8d::20)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 4 Oct
 2023 17:19:01 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::4e) by MW4PR03CA0165.outlook.office365.com
 (2603:10b6:303:8d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Wed, 4 Oct 2023 17:19:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 17:19:01 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 12:18:58 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 2/3] drm/amd/display: Destroy DC context while keeping DML
Date: Wed, 4 Oct 2023 12:18:37 -0500
Message-ID: <20231004171838.168215-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004171838.168215-1-mario.limonciello@amd.com>
References: <20231004171838.168215-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 28086864-13ce-4ba9-3447-08dbc4fe007e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9R2M1PYULgXEGJI6dcc0kHy830PttPTZMIkeJQ30Rbr7k5yZ55+YcPSRMwxo+B5Zyzx5PP2Nj01yKm9e+7TDOsvhjZXokRLhOpNskMHclZKFuidj+V1H5mgbe63nPgeyO/k2tIX/S307LrBVNV8LRhJyRjq+URDWpqgi91pKoZmbc71NZApVA1Ki/jo5V5V7jmJi7RLcqVyBnwhB7oiLhOkIMeb5ixC+AAO3mZ8aYuPY8d+zBFYFFVZP5H3O7msM+Xrd4W6TvpjPgzyHwfiawwqlPoCBmpwNJ4iIyAysGjcG3pxQFKo83fT2LLO3oVFOKZMr1dNI8VinVzDbtKO2AbRzvoM8uIbNyxMh7TrFPul+4jB45u7jf6FU5Q9FVBLuIAMu+ziYIKCfeVZ6UNo4eHl6O0BUZ1BZYyXfsQkD9CLUHBri70Lrntntz33E9Zpf9HaMSghegaSlhFhNd2awkWCuuZU6OgtC7o1EZudgyzl1rPSuFJJ2lXKkQ1mWN0wwMigGwGNlm+FTIA0Ny4keusGqJ4sn/bEWTGjEwGznW7+rjQNGDl8FhrKRGudFJzBa3D6qg3qx44tdAZySNB/5Phj6Cl2xekFPOpxxAFpfqMTLJ84OQrmHHodfmCt7Ngf0H/Y4reHV4V384q3Lr6NAbVJJNCS70Qve2FmtEiJktiJ90a6CexcxVUM+fjTYYBAcVB1HK0hbQWR20n/Y7JKhycVFMP7Mr3IncG9YfSMjfq22ggx6Mi+KSwmKIfwxEmiX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799009)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(4326008)(41300700001)(6916009)(47076005)(316002)(7696005)(44832011)(82740400003)(5660300002)(81166007)(70586007)(86362001)(36756003)(70206006)(478600001)(356005)(8936002)(83380400001)(966005)(8676002)(36860700001)(336012)(2906002)(26005)(16526019)(6666004)(54906003)(426003)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 17:19:01.0502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28086864-13ce-4ba9-3447-08dbc4fe007e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
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
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 25 -------------------
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 12 +++++++++
 2 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 39e291a467e2..cb8c7c5a8807 100644
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
index aa7b5db83644..e487c966c118 100644
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

