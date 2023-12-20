Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7297DC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2A9910E5C9;
	Wed, 20 Dec 2023 16:36:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D190C10E5BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:36:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2WrQegHkWqWnUw+CHh8qluFEeDoJZaeAVEP21IO3mwXxbTObwSs+2CP39pBLgVcdnBPbsUc+lvJGZMX0E0EvVDVwtQSjtLdNoIgKhizMQB97Ya8UtHJOYnonFazsHVOz+4FSnd8TgHQmcJ8w9P0I6QVyH8NrHJl2k/CEqRwmI+CnVFoIblJJkHiwbzznz9ugIZhobyQ9UTmWfe/KKwN7BARuAKrnEJTNW95Ij0sap/w9xmxqj1qZxRyTrGfLCgxc5ud3iAFAHjwxHe0l9aYzQ/opW4c1ZoOVcWQuODaWRNY344Ka2Kb0j5S/qnvnr4e7oPkREsWenfv7IPViLJy2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=425toXpppXdgGAHJCog/NaooJ6znpJFHhFYQc5s/p/o=;
 b=NpKiBYY5FrBBANtFv2W5vAjmNTIhz2B/gxyAZHS4FnSPJeQn7AEytyknykAIBNFJ8cntVOYBMNY+xTcqkZI5I9aPdgcxphNW6HAzc2iewXlIMJbpJkv0aoG2L02QgL7a6u/D5xy2WxgUPIyXdILAvHpNLpF+I42/zbbLBd4zS3x5h5VRcqw2LB+6/7PNi9U2AeOOXkEN1zqBBJyDrXt0UQwtxsWI2idEC45NDIOMXhE4w52JnxXCx4GLi9wd8Uf5DjKdMpfR3EPbzvxt3uF0zAxw2ApP7XpSk/R9wdvhlquFQ9mQfjBH2q8XeBb2ZGbWvIARGQEWcWNI5v3GJL2Cgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=425toXpppXdgGAHJCog/NaooJ6znpJFHhFYQc5s/p/o=;
 b=FFK5UHeWAJ8VgZVNuq3/0d1NJPdnj7WefnapBdG7DJtgD+T+whE0aGb7+V5Delm5TNsLXKFqISLe7dRGzQngInRLPjCDAAGa5V8Tea3TE6mv1Cd+/4CY8RcvgW+EW5BS4MxKf3V8BEP3TSvF9FFsOW8GTJvAlS8XsmQafWGTVmg=
Received: from BLAPR05CA0036.namprd05.prod.outlook.com (2603:10b6:208:335::17)
 by BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 16:36:50 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:335:cafe::f1) by BLAPR05CA0036.outlook.office365.com
 (2603:10b6:208:335::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 16:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 16:36:50 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:36:48 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/20] drm/amd/display: Add null pointer guards where needed
Date: Wed, 20 Dec 2023 09:33:37 -0700
Message-ID: <20231220163538.1742834-6-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|BL0PR12MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c4a01d-315c-46f2-8ceb-08dc0179ddef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tuPOgQYnb2SGCyGka9iDobBRwvzJ8/pWpzld/XR7KpfotXHBiDwJUoG50zIBVtbVkOy2gnkj3pW59InMj98qdY0s2yx8ylm7uxz7MCb8tl9THbtiAi/HQSxWVXDGJ+0WUAXQF6UgOeP03Ihds/clR1dXhhaRk7mnmM3K8yjBUoBFhtkooGH7Uplq6zP6nflG6b+uwh+1FtRBTNPFPU7/9LDhtc7ygMicdXBPuzoI1pqvwu57eU+D20Sxau4BsYm6+rv7LypwAygX4bpGfojZGeNYUlbyrzNE8hVdmCsOCp9F6iBMi5an6miq2KzLHdkl6KxEkaGXrctGJIbJAuRHKPT0m0/WqATqXxLR705I4j8//wHhFqt6nVM/M+c+Q0/QDDCyZ68h5tdC35BwXbVYIgFb3sfvJRn6HEBzP7PIlxic6uVZNVF7wBLYPjHYlM9Tkbew5XPeg/vb1KkZuXO1aWtDussmGkWaLjEYh8+AyMPGVKkuX81YwSuuoIkgeWkk9GBCgX1EcpY/YKfmMwBti0zkGAThCC9nG5xenAhvvBvO+ftRwQs631tF2+p+J/5t+dpHJjLYvhCPAzn0+0lJRMh/lVK6jYFzGQu/bIZpWkD2kD6Nm7RR+qOIBfnkvGGOSojSS5d66RcJMgRyMt2qYNHirDa/xVVaqcOG/8LlPojY2XqLMSAjLl5ETh/1yH4hTx1ooaLuP5L8dURrv1+kwCi2l3TVszBit7WLO28+fUkrHIJ84nN6xE7FsWCqNHudhf3aP0ycP0E20F8GB8NCOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(5660300002)(2906002)(40460700003)(41300700001)(81166007)(356005)(36756003)(6666004)(26005)(86362001)(82740400003)(426003)(2616005)(1076003)(16526019)(478600001)(336012)(36860700001)(47076005)(83380400001)(8936002)(54906003)(4326008)(8676002)(6916009)(70206006)(70586007)(316002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:36:50.5433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c4a01d-315c-46f2-8ceb-08dc0179ddef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
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
Cc: stylon.wang@amd.com, Sung Lee <sung.lee@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Josip
 Pavic <josip.pavic@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Aric Cyr <aric.cyr@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <josip.pavic@amd.com>

[Why]
Some functions whose output is typically checked for null are not being
checked for null at several call sites, causing some static analysis
tools to throw an error.

[How]
Add null pointer guards around functions that typically have them at
other call sites.

Reviewed-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Josip Pavic <josip.pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 5 +++++
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 +++
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c   | 3 ++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d55de3f5115d..b7c2eaebf8bf 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3379,6 +3379,9 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 			&context->res_ctx,
 			stream);
 
+	if (!top_pipe_to_program)
+		return;
+
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
@@ -3978,6 +3981,8 @@ static struct dc_state *create_minimal_transition_state(struct dc *dc,
 	dc->debug.force_disable_subvp = true;
 
 	minimal_transition_context = dc_state_create_copy(base_context);
+	if (!minimal_transition_context)
+		return NULL;
 
 	/* commit minimal state */
 	if (dc->res_pool->funcs->validate_bandwidth(dc, minimal_transition_context, false)) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 716b59bd03b6..f2abc1096ffb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2460,6 +2460,9 @@ void resource_remove_otg_master_for_stream_output(struct dc_state *context,
 	struct pipe_ctx *otg_master = resource_get_otg_master_for_stream(
 			&context->res_ctx, stream);
 
+	if (!otg_master)
+		return;
+
 	ASSERT(resource_get_odm_slice_count(otg_master) == 1);
 	ASSERT(otg_master->plane_state == NULL);
 	ASSERT(otg_master->stream_res.stream_enc);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index f2b265ed7fc2..54670e0b1518 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -447,7 +447,8 @@ bool dc_stream_add_writeback(struct dc *dc,
 	if (dc->hwss.enable_writeback) {
 		struct dc_stream_status *stream_status = dc_stream_get_status(stream);
 		struct dwbc *dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
-		dwb->otg_inst = stream_status->primary_otg_inst;
+		if (stream_status)
+			dwb->otg_inst = stream_status->primary_otg_inst;
 	}
 
 	if (!dc->hwss.update_bandwidth(dc, dc->current_state)) {
-- 
2.42.0

