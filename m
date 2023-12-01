Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31FCC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 040D510E884;
	Fri,  1 Dec 2023 13:28:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EECB310E868
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNfoAMkqfYwaEXXgoEjD92D0WUomLJrl7Pp/MUBiMdir7fGBXecuq4XUsgLLoGpFsQd9tYWBNFgxaRc/p1HLd7w4eO8gWHx8+RE/67qjfoKtkYEcVexhsU3JXf6GOWVpjFcN4E9WoSgeNmWvyTvkpRxKKKlLROY5XkvjSxvQS5JX7Ur0i3iZjRZEccMz5n7+xYopfoyfh9vKH++3l9G6Fp/bwEffd9514//ei701QhZu89mn5xKQYqdPr6KmQyR9E/rRj6bwcbIk7xcZVG7mGj3v5/IM6xS0Mea6ZX0XTSiyMoTNS49NpX6EVXh2TAmvkm9IM42M++qJfmAIOykENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vymZb91roDH7L1/Y7AZFrD818knErBVlkXo//z8nL8w=;
 b=Mk0PkNnLPNvZko8sTZByrjrcoZUKHau4Ehs925Qd5ZrmrbhOk0ptVwTn4F79TGRKgC5dpxbv5/NgRHuB79TonebXMxBb4VqZ3NfiPlUg8+3eivg1KcbHI/Ml3giIy5sGbr2UiQkaNUCwahDMqQ0LDoucFYhOwi6fLf6S4bUJshlLEUYFfwy+dLUZAPYyBmm64jKHKF3lIzJhjhiAfmh/IQScahZ3VJBMSGi4tLzSRbL4YC0EKhGDV7rW4hssAIWHHC0fqFZv8xcNATiiXuNq4csYL30eose+Vo7Gh4WarcNOd5BfWCE1tqCycFgkbrlK6XcTOS3rbrhQv2NPq1OL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vymZb91roDH7L1/Y7AZFrD818knErBVlkXo//z8nL8w=;
 b=HMgIhAA5Y/YvIPIxLN+9xYh+TCYk6MOVFmDAhFxyDTW7EMsUqc62ymOg8yo461j6r6G/poc3luq2kcNzX0ozttgB00cvYOf6wQUvBpshxp/zwNixCxDsl4eCMzMYdbi8naGkWZr5GgzOATp7aChPBYSLV/mfaDBYhuSxnwGjiuk=
Received: from DM6PR02CA0128.namprd02.prod.outlook.com (2603:10b6:5:1b4::30)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:28:01 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::56) by DM6PR02CA0128.outlook.office365.com
 (2603:10b6:5:1b4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.29 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:00 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:27:58 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/47] drm/amd/display: Add ODM check during pipe split/merge
 validation
Date: Fri, 1 Dec 2023 06:24:59 -0700
Message-ID: <20231201132731.2354141-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: d06f25d9-31d9-4cb0-c4d0-08dbf2715716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zF44NoCjMl/QBkCAOWads9PgQ/Sr2Svgeop9JXDVZgs/AP3zgdUTiwFeHn0WQBj5j10UNecH3S+6EUQdPRROAdrx8yfqgeC/jCMpKhbfogzbEastwwb4uWwu+IJFKpBIcUjR/J6pcmEG883BLKCS06O9ifE3NrKF2bgZakvrngneWW4QkU/Y1XoDYG7LKgLAsXoh+M7s5lSjgxSsFDp81xjDX45vK1VcLUbSUYfUiy+Uw/5J//kbXH3ddlUCSVkzMXZS+gIHbKw10+BD+NSgMd7CG/OBJP+XJ6kOyvluf7BbVaJyYK0kFQx9SuNbmUApDTTMror4rhn1Nbp//n8snIJs3RSH5MP9AE6tV/KDtgyUio7ibvZpU1hJHQl1ez+YQdVw73uCnXeBA+p1PHWAuO9sXQ4RfguRDeNL6Drsj1bWtAh1CnRi7NiMIPNmsFErfQevjuKnq7BQCbM5+ogonJRGI52eK7ei9levZm3v0hGTtN2QtVMUkJoSwJC4mNXq1fmh7MNeWONt4vb+pMFRwshnEnV+VyiuqrKtUuJ24arcjxRc7nDbT5L1tgmxMQ6qHtfDvF2NSTHzz1j5LlfTwsZwfzzyH7tJ+u7lQ3r7BTX57ZyaDBMUGE9jdNPfAD5ixFL65x77gf9DzGWLBi5gvck1dYJTKfe4XynXeJ7Sk9yJ2tYxt9aGTHcVb00oBcwKt9oIBPfMY//E6Iljsk3ui2M02YR8KqOuzQZhCwgSMGXi31SFAOxX+IUM9cXcnkxexvKI2gokktIYEn21SDd3Tw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(36840700001)(46966006)(40470700004)(70206006)(70586007)(316002)(6916009)(54906003)(40460700003)(478600001)(5660300002)(41300700001)(36756003)(2906002)(4326008)(8676002)(8936002)(86362001)(1076003)(16526019)(26005)(2616005)(82740400003)(83380400001)(356005)(47076005)(81166007)(40480700001)(36860700001)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:00.8612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d06f25d9-31d9-4cb0-c4d0-08dbf2715716
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213
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
Cc: stylon.wang@amd.com, Relja Vojvodic <relja.vojvodic@amd.com>,
 jerry.zuo@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Alvin Lee <alvin.lee2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Relja Vojvodic <relja.vojvodic@amd.com>

[why]
When querying DML for a vlevel after pipes have been split or merged the
ODM policy would revert to a default policy, which could cause the query
to use the incorrect ODM status. In this case ODM 2to1 was validated,
but the last DML query would assume no ODM and return the incorrect
vlevel.

[how]
Added ODM check to apply the correct ODM policy before querying DML.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Relja Vojvodic <relja.vojvodic@amd.com>
---
 .../display/dc/dcn32/dcn32_resource_helpers.c | 26 +++++++++++++++++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  3 +++
 .../dc/resource/dcn32/dcn32_resource.h        |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 389ac7ae1154..e8159a459bce 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -806,3 +806,29 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 
 	return result;
 }
+
+void dcn32_update_dml_pipes_odm_policy_based_on_context(struct dc *dc, struct dc_state *context,
+		display_e2e_pipe_params_st *pipes)
+{
+	int i, pipe_cnt;
+	struct resource_context *res_ctx = &context->res_ctx;
+	struct pipe_ctx *pipe = NULL;
+
+	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
+		int odm_slice_count = 0;
+
+		if (!res_ctx->pipe_ctx[i].stream)
+			continue;
+		pipe = &res_ctx->pipe_ctx[i];
+		odm_slice_count = resource_get_odm_slice_count(pipe);
+
+		if (odm_slice_count == 1)
+			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
+		else if (odm_slice_count == 2)
+			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
+		else if (odm_slice_count == 4)
+			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_4to1;
+
+		pipe_cnt++;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 26411d4e9730..de209ca0cf8c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2192,6 +2192,7 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 		int i;
 
 		pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
+		dcn32_update_dml_pipes_odm_policy_based_on_context(dc, context, pipes);
 
 		/* repopulate_pipes = 1 means the pipes were either split or merged. In this case
 		 * we have to re-calculate the DET allocation and run through DML once more to
@@ -2200,7 +2201,9 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 		 * */
 		context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final =
 					dm_prefetch_support_uclk_fclk_and_stutter_if_possible;
+
 		vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
+
 		if (vlevel == context->bw_ctx.dml.soc.num_states) {
 			/* failed after DET size changes */
 			goto validate_fail;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index b2f20e6cfb38..9ca799da1a56 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -193,6 +193,8 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context);
 
 bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int vlevel);
 
+void dcn32_update_dml_pipes_odm_policy_based_on_context(struct dc *dc, struct dc_state *context, display_e2e_pipe_params_st *pipes);
+
 /* definitions for run time init of reg offsets */
 
 /* CLK SRC */
-- 
2.42.0

