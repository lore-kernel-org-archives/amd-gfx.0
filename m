Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D1FC47095
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985D560FE5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985D560FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CBF66E93B;
	Mon,  7 Jun 2021 16:48:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D4D96E93B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:48:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qg8b6kA3bJqdBus3DfeT7QnZip5RDx9DUCfxlVDjLSJiYkwSPyDMGUEBBqlGDWlx6+O/f7tUnjFYVwNYDhxaYMEdbru+2FXYXscgBGK8j+J9ihnAZdvgzkMyfeD4ACbi6RhImNWm24kQPUdmS8a5ga8r+hmy72K0wgoEXyT9TOebpmnovdR/rSZrsoQclzViXsh6mRsReZegcQzx+qF65P/d733z/F77Ldjxuj4VX5ixXI1R82NEtK4VFVypTMD3dPWvCJpOCb38iYSep4Dsy0iduIZGZAnDEjbqpd8pBUUXRW6qEPtxEQKRbp4K1YiexNkwBVPD5POVEjA/ujvbVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gCnIlwcKgtOTRxCnZgLkNeIK3TPORygufGsfVEHYYM=;
 b=gHEFK31pGPbA0hiHiV+BB68We/JTCh9UqTRo+EjzQjTNxTjVwebm0KpDmajRdFsUkm999+U/9mTZhAbarfZ5+msrxiNk2ewLIceFUQr0eSf6Xgjagz42pekFgd8YGkhp6dZXjIQAy3UhOsG9aq+aQ9MqhlFIKgHBy6aTh8vdieqFpCEQ4sqVL5vYVTMZDM5sopcVCSdXW7XSVFyZmbXqO0B8krH/m49nfOiJ/MDDduUVzGjNxIJXK2Eqe5GSZU+OQ3cnANHd7vQKlgPXp2Zy6GHCModu0NhvbQUYMnYIY8mque638g50cZpxd1d1WCBD2imiyg/tYHCOL2+3M77/ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gCnIlwcKgtOTRxCnZgLkNeIK3TPORygufGsfVEHYYM=;
 b=GJL6e30pING+tBWrQQlaWECwUn0YcHkt/PN/6H0Sje6c3SHF0BMUzZPf0C5p9HeyheaAeFHBT1TA/ivzgJlEEu+45XLEW97/Yuac4LK/1Wlg62jD3R785Jd1RAkYHmkemTGsn0DTGc7VDxAbn2mE4mdsxo3yWwzW2cfeST6EdAQ=
Received: from BN9PR03CA0612.namprd03.prod.outlook.com (2603:10b6:408:106::17)
 by BN8PR12MB3057.namprd12.prod.outlook.com (2603:10b6:408:64::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Mon, 7 Jun
 2021 16:48:41 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::f2) by BN9PR03CA0612.outlook.office365.com
 (2603:10b6:408:106::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Mon, 7 Jun 2021 16:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:48:40 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:48:37 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/30] drm/amd/display: Change default policy for MPO with
 multidisplay
Date: Tue, 8 Jun 2021 00:47:00 +0800
Message-ID: <20210607164714.311325-17-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0425efb4-5613-4e78-ad60-08d929d41ab3
X-MS-TrafficTypeDiagnostic: BN8PR12MB3057:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3057CA45927C45EB2447D047FF389@BN8PR12MB3057.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZF6pbqNKhIN8LMDLy8G8cR2IN6/xEx0zSsSYOXZcHsAE4Uxn+VUeON3lq8yvU0674onHtO3dKp8ykrJRW72aTmwCR9PhDehfZBoFYwDwTYYDsrMgP63ccILlPx8pypmHUOn8WS/aqpDCvl7cJ5UnFo54tFxNSI0fMoPF8eslWLNWoUJLFmRm4+Z4vZJBRh3/iwYrCzOEtpC2+A8mVp/s8UT7ifnD0Kx8vc11mJYXLolB9lI+kOTQSzfHAwTrVRVoG1DSmqMMcfHG2YuopDuME7wIS0K67qWZw35D3XKNBSjkShIdo99nOJin1KnTVgdlrAzK7Wnj9RTsYRpTVwZhaGlsVC9px9ZDvKuvC9idI4GXqb6S1VZ8ZZrUKU4IqQ4evXM1XTRxPcU5Bw6T1zaazUPsmf5u0msAuC3ZJhjha3YYHzqjzGOx5kul9OUMybDsHUazkP4paeW9zGAGhFN8bJGRiNupw5xUvhPsy6+x8ksE+Hr99rm9Wj143VL74hPOlV5FduqheVjViy3T7xKtKaxzoQlQDUtx5QZw9+ca8y35Hn0bxQTe0gzO8rNwifIT/0fHEsFWNraziwdZgahxFG8esqjbTpjdbskQZ3h2X/JI7oDv8C3/k7FrvEau+MxH69lchYLt/U3tiY6m1Ye1VMbP3bt7E0B9s7H/sxNBDdBQbnkvkzFURbbM++iIHDH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39850400004)(46966006)(36840700001)(82310400003)(86362001)(336012)(26005)(2616005)(16526019)(2906002)(186003)(36756003)(5660300002)(36860700001)(44832011)(4326008)(47076005)(83380400001)(316002)(8936002)(1076003)(478600001)(6916009)(81166007)(54906003)(82740400003)(8676002)(356005)(426003)(70206006)(70586007)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:48:40.6984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0425efb4-5613-4e78-ad60-08d929d41ab3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3057
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
Cc: Stylon Wang <stylon.wang@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Krunoslav Kovac <Krunoslav.Kovac@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
Rearranging pipes with multiple displays and multiple planes cannot be
done atomically and requires a much improved sequence to deal with it.

[How]
To workaround such issues, prefer avoid pipe-split policy for
multidisplay scenarios.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 0d06307456a2..43a6b6cf201e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1065,7 +1065,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 39920422409d..596c97dce67e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -840,7 +840,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.timing_trace = false,
 	.clock_trace = true,
 	.disable_pplib_clock_request = true,
-	.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+	.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
 	.force_single_disp_pipe_split = false,
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 00cb6d11ed0d..b16d19a25d88 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -211,7 +211,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index aff0230c9193..758f89ba0192 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -193,7 +193,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
