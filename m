Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33956EE0217
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF92510E218;
	Thu, 14 Sep 2023 02:01:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 956C710E218
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UepT/wbE+n3mLCHGHEdSAar4dol1pf4Nkrw4Q+ofrTk3gzNl619o5RiRfWwbQuzusFRsrLnRHEolYCcLMNLBlwPNtge5pG8yETejUuWEd2/PIXQQxTXfszbXke4TdGqOZqvGSVYFEC6ejy73BhpHbG3au9Nwnzre7oTLVsWJAYqJ6k9flj6Rs0UJVi4vpXNIPwczUHJ4xmRsoAH8r9qSjuuFUWAvEfzkGXfAdSFiEIqTdWlFCt3p6QQ1GvRkrip92iO/3vBIuz3Avev/DUd3TT948kFWCAXDMdxnwmp0RLd30GILPq8LTuqkAGpRuZOpZTjFCEUu7P2TKp6KOHJlCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxO/fjRkfGV0IG3RyYdVmVj/seA127HzR3nFzTxRn4g=;
 b=RxFXGHq5fFrJKOpesVJ6GvtmXLuax9yhGW89vUnFrTBubvAWkkDsAg+hPJJbghOGUNz2byMm7nyLXWwRTLG1gG5ZJSDxNim7GZ5h7VrnRLdyUiHIkDCDXjdpJa8Wjy3v0HPicACeHMHXtXKRhPzja9nR01jlmpWldmiVTWa6EntIz/CkHu3MPPgbGMCLT+VNHOl3cToaevr3KrSG4JfLW69SzLknt5uySSqhFeTldGRG5APnTmJJGzHhvwMZ0cbgRO60bNof06o5MvNTPHdd1TI8e7bIldU9GZxpIGmN4jjzTVEWT7bRDqy6jhws96GTG5kBzLJdyhFGhjbojYiqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxO/fjRkfGV0IG3RyYdVmVj/seA127HzR3nFzTxRn4g=;
 b=JjudXWdI6ftpvmBwakzjDSk1PrCaGNC1LFQYbFyt1wYksnRXIKe4yFoqLyg2HSxfAaTY0a9HJDJGSsghAA+FKxzFOwQcFP6Blk83paGp+mleq9FBDaNgBqkPUdbKwFjShG1rei4bLdvn5GFUUeBYgM0IE1Yusc4mibTecy62Cso=
Received: from BY5PR17CA0018.namprd17.prod.outlook.com (2603:10b6:a03:1b8::31)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 02:01:28 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::fb) by BY5PR17CA0018.outlook.office365.com
 (2603:10b6:a03:1b8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:27 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:24 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/28] drm/amd/display: Add z8_marks related in dml for DCN35
Date: Wed, 13 Sep 2023 19:59:58 -0600
Message-ID: <20230914020021.2890026-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|IA0PR12MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b396e5-97e0-41a7-db07-08dbb4c681f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hHfJ2PFkmGpARzvagOn5NK8yFOIZjAcipO3WW/Hlof4xIV+W2Y5vYwMuVclylyqwTMvWSKWjPmMK3av3iQGLSz7jz46t2o0oYZJna5owqAqV5mMiP6ma4JcD9DJtPO8JGBHuJwue0bgze8VU0e+83ylIkHcSqK8WtucyBbocvDoljnw17yqmYJ4UsnRU2ScWpfTTjPkf4MEFUlZLDOwAe3kJIoYZ2XH3/KL0JwvLSTpMJQLvYMr/MMm1ZJ7j/b1oyYxL4MfE8CNX91Kttui/pFtEuCvwIrvKdcFy8MLFA1iqP+pYiIOUkyigJwDl06mNyOkiW8VVxqlVO/EB3yOij+3VbHO69kLYIfSpUr9N23nHLrNOFtsYSoht5jeKC8WC0Rp2WG5Ulw0hmSbyOH5EvrBWhtZF+MZwvYLtPu5hSIKYoElVZUBreUI4my3sLzq+JVkWGONkHu0O1ArAy0A6SKjGLXJcW1mupo9RK0LxkojMAKdxLmyDiZ4p37Tvg3ddI4sy4LXcVl27HqvNFhkjKHE4z/1N/xnTF0nIg172O8Z3QciM7967bDqk1R59CU5vd5/4I+Pv03v2FRvZz8UgjY/383uQm3yIXlQGvd2BIMxrwWtPQa3SLVp9XBYK2YCc8/USSzKBkoEKk1id0DLNq+tLukjxgpK+tb3qJEVOMRFhKPjj3PInWiwMHDN0/g94GYQLFrcmI+sXJlX7XaF5p1o0LXOAU+RMWGjdC2Ikp0DmsQm5wtZUHXSARl43srg2KAEe/9vXVQTUMdoZhwL2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(41300700001)(6666004)(47076005)(54906003)(83380400001)(336012)(2616005)(26005)(16526019)(8676002)(478600001)(8936002)(70586007)(4326008)(316002)(1076003)(36756003)(86362001)(40480700001)(426003)(36860700001)(40460700003)(6916009)(2906002)(5660300002)(82740400003)(356005)(81166007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:27.9133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b396e5-97e0-41a7-db07-08dbb4c681f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

Add z8 watermarks to struct for DCN35.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 .../drm/amd/display/dc/dcn35/dcn35_hubbub.c   | 34 +++++++++++++++++++
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |  3 +-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
index 458aac24778c..e9b1734e0c67 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
@@ -379,6 +379,17 @@ static void hubbub35_init_watermarks(struct hubbub *hubbub)
 	REG_WRITE(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_B, reg);
 	REG_WRITE(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_C, reg);
 	REG_WRITE(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D, reg);
+
+	reg = REG_READ(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_A);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_B, reg);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_C, reg);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_D, reg);
+
+	reg = REG_READ(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_A);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_B, reg);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C, reg);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, reg);
+
 }
 
 static void hubbub35_wm_read_state(struct hubbub *hubbub,
@@ -409,6 +420,11 @@ static void hubbub35_wm_read_state(struct hubbub *hubbub,
 	REG_GET(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_A,
 			 DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_A, &s->fclk_pstate_change);
 
+	REG_GET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_A,
+			DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_A, &s->sr_enter_exit_Z8);
+
+	REG_GET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_A,
+			DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_A, &s->sr_enter_Z8);
 	s = &wm->sets[1];
 	s->wm_set = 1;
 	REG_GET(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_B,
@@ -429,6 +445,12 @@ static void hubbub35_wm_read_state(struct hubbub *hubbub,
 	REG_GET(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_B,
 			DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_B, &s->fclk_pstate_change);
 
+	REG_GET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_B,
+			DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_B, &s->sr_enter_exit_Z8);
+
+	REG_GET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_B,
+			DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_B, &s->sr_enter_Z8);
+
 	s = &wm->sets[2];
 	s->wm_set = 2;
 	REG_GET(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_C,
@@ -449,6 +471,12 @@ static void hubbub35_wm_read_state(struct hubbub *hubbub,
 	REG_GET(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_C,
 			DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_C, &s->fclk_pstate_change);
 
+	REG_GET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C,
+			DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C, &s->sr_enter_exit_Z8);
+
+	REG_GET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_C,
+			DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_C, &s->sr_enter_Z8);
+
 	s = &wm->sets[3];
 	s->wm_set = 3;
 	REG_GET(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_D,
@@ -468,6 +496,12 @@ static void hubbub35_wm_read_state(struct hubbub *hubbub,
 
 	REG_GET(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D,
 			DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D, &s->fclk_pstate_change);
+
+	REG_GET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D,
+			DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, &s->sr_enter_exit_Z8);
+
+	REG_GET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_D,
+			DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_D, &s->sr_enter_Z8);
 }
 
 static void hubbub35_set_fgcg(struct dcn20_hubbub *hubbub2, bool enable)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index aa0c27e76e4e..60e7e09a577a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -1677,6 +1677,7 @@ static bool dcn35_validate_bandwidth(struct dc *dc,
 	return out;
 }
 
+
 static struct resource_funcs dcn35_res_pool_funcs = {
 	.destroy = dcn35_destroy_resource_pool,
 	.link_enc_create = dcn35_link_encoder_create,
@@ -1685,7 +1686,7 @@ static struct resource_funcs dcn35_res_pool_funcs = {
 	.link_enc_unassign = link_enc_cfg_link_enc_unassign,
 	.panel_cntl_create = dcn31_panel_cntl_create,
 	.validate_bandwidth = dcn35_validate_bandwidth,
-	.calculate_wm_and_dlg = dcn31_calculate_wm_and_dlg,
+	.calculate_wm_and_dlg = NULL,
 	.update_soc_for_wm_a = dcn31_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn35_populate_dml_pipes_from_context_fpu,
 	.acquire_free_pipe_as_secondary_dpp_pipe = dcn20_acquire_free_pipe_for_layer,
-- 
2.40.1

