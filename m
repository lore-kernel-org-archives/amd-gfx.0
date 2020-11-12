Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EABC388F7
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 22:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9624B20709
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 22:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EdkW8GEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9624B20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D42F26E093;
	Thu, 12 Nov 2020 22:06:43 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760088.outbound.protection.outlook.com [40.107.76.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34EF06E093
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 22:06:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aW5s/WLkZOQuRP7mrWOU74rL6d95e1QjtbMILF1OSjn46WIaHrWB9WOPVn1MQvSdcSonNtfgjQdyFwUZhJHkniIhXwWwsVQnznZiJXf6Ahx9wf9bh4NwB+2ba+WPq9kqFySpRBM2aK73EG49WIPnl1I6ZqAy40u+ED8T8RufrpZPHzHLpjx91VH8v5igMESA7RLX3TaNeNMxKd14lb6C1u590ANlgPtRBbxuNJ5j9lXEGgMLvWpD7ayXqTBYt7S09iiJiMtdAzVJJCpKkgSarv7MOUWbfoSd19exMN6dhMOZa4gdxE1JBOWxxscD5DRiNygwM/ELFKcrhg+aZOGZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jFTzC8ce8P/p+lzX6c3pWYqqD5xXNhRHL4fkTF0auY=;
 b=YvTISPVi1htbFa6JsXFZgSaqS5DKr2IrGlqzEOiEKzv+o3a301qOnto4QUmjlK3T+8GIuBffplonaZYJxeCN7IR6USKDbu7zgitHYfc+H//951YSBM7PHZPYlqMw9HQjsuwbnxtJVQouU2ltRUvYAxeI2GE1yGpz1WH/c5AtivFIEALdruBQ5wi9HbrhT/BPppuSyER3+U6XhjtKFZAh7H/6fprQ0GSidBNQTwhpY96kPQza7tnfquJtsoxBlNRGzqIerb34xE8V2AOtPZuWpDm2YLEjyOqsdWmo/nAlmzesVmvOBr/gCM/WTYgAwcHykqmHQPwypzYfPp2SlM4Jcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jFTzC8ce8P/p+lzX6c3pWYqqD5xXNhRHL4fkTF0auY=;
 b=EdkW8GEvaNZpCE52oocXxw5ZC5H+7bodCnvDnXw3j5FLpWvXym67mB92gntSCiz7WL7D7TyV1Id6Y6kAJb0TMZn9LEgppFGzpOpKKhspMkrnfsnYVa8X4FJfDeyIY5XQE+AjySwnwK5/drVhXblA59hAdDMMgFBmxaF29NvBnHM=
Received: from DM6PR02CA0059.namprd02.prod.outlook.com (2603:10b6:5:177::36)
 by BN6PR1201MB0098.namprd12.prod.outlook.com (2603:10b6:405:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 22:06:38 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::12) by DM6PR02CA0059.outlook.office365.com
 (2603:10b6:5:177::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Thu, 12 Nov 2020 22:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Thu, 12 Nov 2020 22:06:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 12 Nov
 2020 16:06:36 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 12 Nov
 2020 16:06:36 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 12 Nov 2020 16:06:36 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <nicholas.kazlauskas@amd.com>, <alexander.deucher@amd.com>,
 <harry.wentland@amd.com>
Subject: [PATCH] drm/amdgpu/display: fix FP handling in DCN30
Date: Thu, 12 Nov 2020 17:06:18 -0500
Message-ID: <20201112220618.3610982-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f403893e-e84a-4920-9b25-08d8875739e1
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0098:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0098A4609455EB5BFA5A202EF9E70@BN6PR1201MB0098.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JpEJhcWftqZW2Z69LRHRmF4ztfjmhNMlJEmtB3jgCaB+jdqxG0VSfSkSA/ZSOpH6sPK1GAgvhVVvlqd3LsCcC0xQf/u0OtZf59axPKeQ7qwg084nVXpVetfUFRHU3jS9sJ3pQGbbAITTs4O/lvUV5FBJO1cpHYyKnc0LJoFoW4GYaEZSuIv322NAx04sAlNIS1hwkpT3I6COZbZNQCX4akQ8ceiqUArsyZPxde675rpxrtE8VwEnNFxsvK4QDkAPA0HXeoEMwz8OERZLT67HaAbvbygWEtbS0G/tU0GHSb7rzy6elyoaUCjdq9lgq0gJ5VP7hyGDG3erTK0n6ep6EeO98fjlBY3wxfp3cTRrJDxCNG70VjWet5JwPK/l9JZFdgkuLJlufUIf+dDxXq5sYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(46966005)(86362001)(356005)(81166007)(47076004)(478600001)(54906003)(6636002)(1076003)(70206006)(8676002)(7696005)(26005)(8936002)(426003)(316002)(82740400003)(2616005)(6666004)(336012)(2906002)(186003)(4326008)(82310400003)(83380400001)(36756003)(110136005)(5660300002)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 22:06:37.4896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f403893e-e84a-4920-9b25-08d8875739e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0098
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

Adjust the FP handling to avoid nested calls.

The nested calls cause the warning below
WARNING: CPU: 3 PID: 384 at arch/x86/kernel/fpu/core.c:129 kernel_fpu_begin

Fixes: 26803606c5d6 ("drm/amdgpu/display: FP fixes for DCN3.x (v4)")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 43 +++----------------
 1 file changed, 6 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index b379057e669c..d5c81ad55045 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1470,20 +1470,8 @@ int dcn30_populate_dml_pipes_from_context(
 	return pipe_cnt;
 }
 
-/*
- * This must be noinline to ensure anything that deals with FP registers
- * is contained within this call; previously our compiling with hard-float
- * would result in fp instructions being emitted outside of the boundaries
- * of the DC_FP_START/END macros, which makes sense as the compiler has no
- * idea about what is wrapped and what is not
- *
- * This is largely just a workaround to avoid breakage introduced with 5.6,
- * ideally all fp-using code should be moved into its own file, only that
- * should be compiled with hard-float, and all code exported from there
- * should be strictly wrapped with DC_FP_START/END
- */
-static noinline void dcn30_populate_dml_writeback_from_context_fp(
-		struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
+void dcn30_populate_dml_writeback_from_context(
+	struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
 {
 	int pipe_cnt, i, j;
 	double max_calc_writeback_dispclk;
@@ -1571,14 +1559,6 @@ static noinline void dcn30_populate_dml_writeback_from_context_fp(
 
 }
 
-void dcn30_populate_dml_writeback_from_context(
-		struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
-{
-	DC_FP_START();
-	dcn30_populate_dml_writeback_from_context_fp(dc, res_ctx, pipes);
-	DC_FP_END();
-}
-
 unsigned int dcn30_calc_max_scaled_time(
 		unsigned int time_per_pixel,
 		enum mmhubbub_wbif_mode mode,
@@ -1977,7 +1957,7 @@ static struct pipe_ctx *dcn30_find_split_pipe(
 	return pipe;
 }
 
-static bool dcn30_internal_validate_bw(
+static noinline bool dcn30_internal_validate_bw(
 		struct dc *dc,
 		struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
@@ -1999,6 +1979,7 @@ static bool dcn30_internal_validate_bw(
 
 	pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
 
+	DC_FP_START();
 	if (!pipe_cnt) {
 		out = true;
 		goto validate_out;
@@ -2222,6 +2203,7 @@ static bool dcn30_internal_validate_bw(
 	out = false;
 
 validate_out:
+	DC_FP_END();
 	return out;
 }
 
@@ -2404,7 +2386,7 @@ void dcn30_calculate_wm_and_dlg(
 	DC_FP_END();
 }
 
-static noinline bool dcn30_validate_bandwidth_fp(struct dc *dc,
+bool dcn30_validate_bandwidth(struct dc *dc,
 		struct dc_state *context,
 		bool fast_validate)
 {
@@ -2455,19 +2437,6 @@ static noinline bool dcn30_validate_bandwidth_fp(struct dc *dc,
 	return out;
 }
 
-bool dcn30_validate_bandwidth(struct dc *dc,
-		struct dc_state *context,
-		bool fast_validate)
-{
-	bool out;
-
-	DC_FP_START();
-	out = dcn30_validate_bandwidth_fp(dc, context, fast_validate);
-	DC_FP_END();
-
-	return out;
-}
-
 static noinline void get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
                                                        unsigned int *optimal_dcfclk,
                                                        unsigned int *optimal_fclk)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
