Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E3CC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F1F3112BFF;
	Mon, 22 Apr 2024 15:31:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ahB/xD20";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EEC8112BFF
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:31:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6okw2FXkgaCNckptj5FXb8HEShkPszqgKVsaRuDjXiFXva/kZKUcCKfJ04EQlp0H8Z0MiqzjoUFWZrqWRFoHBGGZdZnK2QBldJD65hCnWj2N5ASTxg/E0bl7vWNYu4DdEo6X7THVDW+DSJ3dbsWJvw1tLZ30ZGg8jv+8h4OKT18pzI9mrkLgjFdUpm7lddsya9oG7D4prLDJ4llfB8FRvIJHyjE/lI6nMHs+y2DeqTU/Atj/jrxliF4TUikhfm2iDxMjpBeqoh8mSewt/lp3DZ+/A5hUMUVbYb4LNw9s2ksN4qqJKvhtcMWTWCej79EfT8ZP5rNnazm5PnsMBzR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnDkw3rdkm4Uuhd+F+jDZQ07fH9xgwCHXBDwGfpnd88=;
 b=Gv8lYSV3gbGZlJzzGpHawEIx4KizLaPEUPjunAWip6AgX5FZccX/qRhEcWB7q0An5FPlNGvLVHF6Y56w2b0BA1b4EVnnXsXB/j7bxumGF+hnlKcq/+vWS95gCrk3dTsrrU7EH40kPJ7nufPy94BsjTtq6Q0/ss5FjmwYuLH/cLM/SI7ygIQgpHvrg9E1YHOaLfX1F4IBbg+kMNnxufnhFEICAqh+ULWHyaKe16HOPdzzMUUV4UnA/MkXXNBK8JpwDZ9EZdpfctne9ATHTMLs4TDd9mZrR2hHCLY1YA9EWg6QVFT7ExobKEWX5gToqsacpwC6ULBmB/ZniA7ByuvIrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnDkw3rdkm4Uuhd+F+jDZQ07fH9xgwCHXBDwGfpnd88=;
 b=ahB/xD20YQkiQJejf1d0bevdzJZXfG4SKq/hA1+XDllc8TM+caCyNpOQwAjx/hHk+SgL4XnRMq7jcAVW4mD9EfZBMLPDdGKN8FyOIaHXWzXVJyVDT7Pk38DN8OyflKj/q3/jC4eBRg1Paa3pdDe+wi6MEcH5HDc7FzbU6DHM16U=
Received: from DS7PR06CA0023.namprd06.prod.outlook.com (2603:10b6:8:2a::14) by
 SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 15:30:59 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::4e) by DS7PR06CA0023.outlook.office365.com
 (2603:10b6:8:2a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:30:58 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:30:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 08:30:58 -0700
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:30:52 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>, Chaitanya Dhere <chaitanya.dhere@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 28/37] Revert "drm/amd/display: Fix incorrect pointer
 assignment"
Date: Mon, 22 Apr 2024 11:27:37 -0400
Message-ID: <20240422152817.2765349-29-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 0acac63c-ac96-42bb-9e48-08dc62e135e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tUocJgS+Cf0PByQULnhi3oXOMAGXNLjsBYvzuMRWLw8Ei/zAhyYtW9xVKVk8?=
 =?us-ascii?Q?8BOISvSk7zElK6wpGqowPvCosMxLOzuTndeiJImrSH+T4GMs7gL4ROs0FQKf?=
 =?us-ascii?Q?CxqVjCpGsnOdmn7AJ4rF/oP4OxdUJHHUOb25TAB4yPe5V2SkvlTpfIjWGDBy?=
 =?us-ascii?Q?Lm34qAvTgL2LUqR4OPX7PsE3uiFPnuZ/bE+8T2Vi6ANHPp7Qv4mgB0SbfXpu?=
 =?us-ascii?Q?b3W06LT5azgkg2JUsutFK8y/RnnynmcH7SL3W7M6THnsztyBwbmvmCTYid5C?=
 =?us-ascii?Q?YiLnYsgWcKWbamIWe2ImaoYGd659IAqimL+subPedkJbyJCEo19YKDtLCO90?=
 =?us-ascii?Q?Vzbg1x1buBGnIr0FH/M1pekYyl5GbciO2jgi98trwFde3xevJxlZ5cxZ1hf8?=
 =?us-ascii?Q?zwuSe5ba8btsAK3OmrNLTbm8JPH9h4xbnZvkPwSUk3RpDTpZafyKDmI8oNCM?=
 =?us-ascii?Q?pktV64YKme+MBryCCIMS50Ba7dMPZVY2giQCaAUFh//3bXkbLBYzIHbbAzbV?=
 =?us-ascii?Q?LjeBSnpahhjhbSc9oyYhDqtYVU2bR1tTHCx4I5VupCvtuo14UtsoPpGt5KLx?=
 =?us-ascii?Q?XrTeSSeGqQ808QXFWLlQD7KtJ2Yms5QiFYTsIlEhWHV9vRqzqF/Dd83H/uXU?=
 =?us-ascii?Q?uHM0ISd8nK4C1wYmJklUhCsEsLMlrzeEocvowX0yjGuCqm3LWgu4Ml74aqkX?=
 =?us-ascii?Q?uAxVXMrEb5YP7/jhRzBRiQ0zUjJtzezsFb8kbjKf/Ab/zSnSY5n7rL9690L7?=
 =?us-ascii?Q?aexeAaG0QA6D6HaVFCC0/he0Twsa16Hh2WxQyp5CwS7Bo6xtKJ52CBm6rvIC?=
 =?us-ascii?Q?UVFyWrL0lLOh5gtzLb0bkt49AFdVSxykbLc/lZnf8p1vlUClJUmlyc/N7Sld?=
 =?us-ascii?Q?Z+7sqcqAj2CVOhRyk0IEM9uz5IDm6wITdAdSXSdazmXmksOQrBzJEcU/v9NY?=
 =?us-ascii?Q?SHCq5wXumW+lmXW/w61zm9SrEtN9FqaFpBGQvGSb70OoRwYZamWDg26fCrcb?=
 =?us-ascii?Q?yVg+ZWb2PZCPqh4Q8fbdWWONUxfuhR3fdZPmdjIcHc1hsdN2+7PCKeUYQzpq?=
 =?us-ascii?Q?PuyEUtbluEQv6JDZJWjMS0Ouwu1uTD62xv3z1UyH5b0A2TAsRnsxZPA8tFK7?=
 =?us-ascii?Q?fPcB0bMhojt/cD7wvvbR8nbdlv3u/qjxL+Tld9SQxZ0C0YMNmMTzKBNn6pTl?=
 =?us-ascii?Q?Jm+RClpsFnhGiKW3VzhPwZI/oBStdabmP08rmITytFPOufAJEmo2e2WBFUFU?=
 =?us-ascii?Q?lLqCyGd18URqQlyGRu4M3RIWN3nszDkkFszXARYC4qnF2Jn0jIBa1diO3JUv?=
 =?us-ascii?Q?kbh8rEaYeWGxRKRWeNUFjsOdMqLXkTJldrg+tLYhckjp7MiX9wLcrQCAylBr?=
 =?us-ascii?Q?J0U7N+fEGxPiWF7GknUa6S0HKNtn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:30:58.9544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0acac63c-ac96-42bb-9e48-08dc62e135e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841
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

From: Joshua Aberback <joshua.aberback@amd.com>

This reverts commit 44739205e867

[Why]
The change being reverted incorrectly assumes that a pointer type was
intended, however copying to a new structure is correct. As well, there
is no compiler error, it was instead an error in the testing framework
being used.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 7f5d5545ae08..70928223b642 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -193,7 +193,7 @@ static void init_state(struct dc *dc, struct dc_state *state)
 struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *params)
 {
 #ifdef CONFIG_DRM_AMD_DC_FP
-	struct dml2_configuration_options *dml2_opt = &dc->dml2_options;
+	struct dml2_configuration_options dml2_opt = dc->dml2_options;
 #endif
 	struct dc_state *state = kvzalloc(sizeof(struct dc_state),
 			GFP_KERNEL);
@@ -207,11 +207,11 @@ struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *p
 
 #ifdef CONFIG_DRM_AMD_DC_FP
 	if (dc->debug.using_dml2) {
-		dml2_opt->use_clock_dc_limits = false;
-		dml2_create(dc, dml2_opt, &state->bw_ctx.dml2);
+		dml2_opt.use_clock_dc_limits = false;
+		dml2_create(dc, &dml2_opt, &state->bw_ctx.dml2);
 
-		dml2_opt->use_clock_dc_limits = true;
-		dml2_create(dc, dml2_opt, &state->bw_ctx.dml2_dc_power_source);
+		dml2_opt.use_clock_dc_limits = true;
+		dml2_create(dc, &dml2_opt, &state->bw_ctx.dml2_dc_power_source);
 	}
 #endif
 
-- 
2.44.0

