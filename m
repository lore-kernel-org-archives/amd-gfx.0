Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E792C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A4310E3F9;
	Fri, 31 May 2024 16:53:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JiFX5YMK";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B67F10E602
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUpxGr2jxGKIPp309F0IK+IMa/86o10Abq9vbRUAorHy8gn1WUzLWZebP2dDbkEwDH8fjWQxxugjX4Z11pwkKIxlsAFvO9lJM4ibNEf98LzfqX2VTADoODtj//tflmM0hkGnD/X84WTA6SAmEIq/xE5i8GYeZafJw1anYp+cGkTt2Nir8ZvrfUtwXfB67qW30qEqFstHjBMusCTNp58ekpnAtquO9fO7b9n1gzFl1G+cGCJCmN3fXYpXrVVUomCT9uJHAOfyH6Sz/rSyqAhKFRILTgCgeUkz26272oiB+GHQw0gXxPnNEx9k4Z+q18+4MS9kf2J/rBygSuAAg7BMcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fazMt4db9e+4UOeOyIr7NfVpj71sRpCiBd/ylixFZtw=;
 b=ZndMzarG1NAkMWrd6954VABe6ZnWDB2VnEz56n1OHKpIFf5j/ke5eB88UVo1eKrnj/ZJon0E9KMyttR+QK9d5cxxID7LeR0GD+VGHG29IaZyC2t1js9+/RCxS/fl56vfLxg6xysHFfxNC0Ti75Ov3Hpo7boorwDX7vivEd/LML8zqJMTbu8OYshHj7G23srMstbYG+nZ0BK11VF2mKcNLMOfhGZAGC5koqqY5qwgVVZeckaGRqGqn5qwSUppO3w6kZbJhIlKpnA+NcGOs/gqt4m3UrtexYaBjZQQo1hkl8aO0yzFwCcAusbdcuNnM/CMl1scF47FnJZsYaHPEZH5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fazMt4db9e+4UOeOyIr7NfVpj71sRpCiBd/ylixFZtw=;
 b=JiFX5YMK1n3Zely0aH0MzcFEOQC+bLt+TDIX5cxtXHhApjAcfrezZfgOV1GUD1p7evWjefDYIecvvzago8YvssZ7Hxb/OVpRz2NdMGUOP+6UwM0Ysp1DCI2lNRPoI/iF5n2hHnHKtRHsffP68GCJZxDqVTj5rCODigE4AcgysfQ=
Received: from PH7PR10CA0023.namprd10.prod.outlook.com (2603:10b6:510:23d::21)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 16:52:40 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::22) by PH7PR10CA0023.outlook.office365.com
 (2603:10b6:510:23d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22 via Frontend
 Transport; Fri, 31 May 2024 16:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:40 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:35 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Samson Tam <samson.tam@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 15/32] drm/amd/display: fix YUV video color corruption in
 DCN401
Date: Fri, 31 May 2024 12:51:28 -0400
Message-ID: <20240531165145.1874966-16-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1fab07-6380-4293-40d8-08dc81921545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MZXVMP/U7MOFH+Ba5OBr0sHXbCDZ/dXOiDhk9ndFZ72YOpWz52vY4LifB5g/?=
 =?us-ascii?Q?ojcJdT1AycbZjgodzbffAJpWG8z/2TRTC2m0//o5kkSlEmrt09ghfifSZMAK?=
 =?us-ascii?Q?YkB6Gz+6frXgotPH9YislzMut/QqLfqwqEJvnGzK+Q6sugtgp8k1xdDwLKc0?=
 =?us-ascii?Q?jXAxI0m46jGmjGT0cjZSK0DwoKgCWPv75goUwMmPUJKrb4g9hMq5KAV5dJFS?=
 =?us-ascii?Q?ASepF492uJlWSQTGldmtMqm4rBpiZzGGz2RRhtHjY8xxFZ20gcgf54D9bUB6?=
 =?us-ascii?Q?0is2C/1FlqX5YVuM+NcryU0qM2XWBhsOIsuxeGywkWeY473Jf4adNP10m3Wb?=
 =?us-ascii?Q?A66gqbj7fbYCIbVONbz0hRL4aF+lVOFXUh6JQ1U7/8vrYUEMxVSGZofjKyP/?=
 =?us-ascii?Q?82AoWsgoqtckI3CXj5hkjlUetc1jv/zetoka+ge9os9t63AuxLVmaMxWH4dr?=
 =?us-ascii?Q?XcQMDKVo1VJgyRkrYaXDLHzJ1uciB2/MMM1P/Lp9Er8qNZuGUojYgfoHLJNt?=
 =?us-ascii?Q?/7pLE5l7I0qlrhtTZ/6HjmXTNrIPcjiHAv8D1BiaoxLJM6LAnUHzV9wJZrmu?=
 =?us-ascii?Q?p+Sxlqo+IR2UHJQRnMk0NLGfAdQQTVkk6TTVReZm11JOEhpYPdGiPR2OV3gp?=
 =?us-ascii?Q?fA455odIul7H5x/LFTmJ6q/CJGl7gojr/9zi+JjbKntfHEkeuJcN2DPra2Mf?=
 =?us-ascii?Q?HwivBDMIFeP6NNqtGtz4rN+vigIFOLpValKCCbOtfhPSgFh/2hsTJQUUhXZz?=
 =?us-ascii?Q?lel6S/a53WIbIjJ7K4vrQ7UaKAz+R99YOJwWpYCBroaxmdMeOCCrKTzpHxJI?=
 =?us-ascii?Q?wXQuw80BXUYAWDXRV5tEewbmwUJdbqMo/BILdVinjzLi1nP3R44nR9xY4T/D?=
 =?us-ascii?Q?soKegga8jScXWWo6Tp6knBRjHUA7EXHOoi5fUdrEbATQmbesRDcNAGLqh6K/?=
 =?us-ascii?Q?dGKHgWKBtD+iTWqJO1Q00C9la6VsY92K8bxpkIR5vwcag7aREZzE7j1I84Jl?=
 =?us-ascii?Q?ukdqU4oSlS80PZne8NSLrPLPPwmSbrXxFRoFnPR+3pufNzyCVuHsIfoMuwJQ?=
 =?us-ascii?Q?SmYuQMFyD7PBIbbUdu1blPKR5H3kl9b1f5z6zR8MMLR/bJ4/wS50voJQ/bSC?=
 =?us-ascii?Q?b4V5nKharK0bdsVqqkgkOZdVI1/WEElGyTZwqOpkUqfuyTg/GKFQHgjtoSml?=
 =?us-ascii?Q?CPGTMOqbqSuLqZ80I3ed0xytvlNUMdY7Jw32KNxsGOxU4USgXqZ00eyXmWZZ?=
 =?us-ascii?Q?szaKhPd7sO0fFG+iwfTjFykfaYPSJp1bWrwG2NLYIasT4+bF5S2qZXQwNjh4?=
 =?us-ascii?Q?zeojk7lmS9/kGL93OJXcBNk2oqVfKmMPMNjbYTJByPh38Ql47D6EMLAey9ur?=
 =?us-ascii?Q?eaDwetnm5P+VaBeeq0xxPk/lPpU8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:40.0898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1fab07-6380-4293-40d8-08dc81921545
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <samson.tam@amd.com>

[Why]
Missing check causes sequence error which results in chroma
 filter coefficients not being updated in certain modes
 when we display YUV video in fullscreen.  This results in
 color corruption in video

[How]
Add back chroma_coef_mode check in dscl_set_scl_filter
 so that filter coefficients are calculated and updated when
 we have YUV surface

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
---
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c  | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index 6cb3fa4b585c..505929800426 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -297,17 +297,21 @@ static void dpp401_dscl_set_scl_filter(
 	if ((dpp->base.ctx->dc->config.use_spl) && (!dpp->base.ctx->dc->debug.disable_spl)) {
 		filter_h = scl_data->dscl_prog_data.filter_h;
 		filter_v = scl_data->dscl_prog_data.filter_v;
-		filter_h_c = scl_data->dscl_prog_data.filter_h_c;
-		filter_v_c = scl_data->dscl_prog_data.filter_v_c;
+		if (chroma_coef_mode) {
+			filter_h_c = scl_data->dscl_prog_data.filter_h_c;
+			filter_v_c = scl_data->dscl_prog_data.filter_v_c;
+		}
 	} else {
 		filter_h = dpp401_dscl_get_filter_coeffs_64p(
 			scl_data->taps.h_taps, scl_data->ratios.horz);
 		filter_v = dpp401_dscl_get_filter_coeffs_64p(
 			scl_data->taps.v_taps, scl_data->ratios.vert);
-		filter_h_c = dpp401_dscl_get_filter_coeffs_64p(
-			scl_data->taps.h_taps_c, scl_data->ratios.horz_c);
-		filter_v_c = dpp401_dscl_get_filter_coeffs_64p(
-			scl_data->taps.v_taps_c, scl_data->ratios.vert_c);
+		if (chroma_coef_mode) {
+			filter_h_c = dpp401_dscl_get_filter_coeffs_64p(
+				scl_data->taps.h_taps_c, scl_data->ratios.horz_c);
+			filter_v_c = dpp401_dscl_get_filter_coeffs_64p(
+				scl_data->taps.v_taps_c, scl_data->ratios.vert_c);
+		}
 	}
 
 	h_2tap_hardcode_coef_en = scl_data->taps.h_taps < 3
-- 
2.34.1

