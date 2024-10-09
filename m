Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BA7CEE347
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 19:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 816DC10E7ED;
	Wed,  9 Oct 2024 19:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UznIx8RW";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BE6810E7E5
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 19:26:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dmani+gDrSxu09lAa8DRBD0fVd/dPMbteZRtRB+rJGQ+4qhGCRzyOZFCU5mR663p2DIofDWcZMRtfThvqwRM1ve7BqQNjGEAPqMQm50oet7+vEVBcW4oQlO0yjrRXwzdZxdNxghEpJRKVpfqm1G0NJw+pSIhGhJVKOd7IdZ2eDlZsihVdYEsEXjsobD5FemOVC1F+D8cFqNx+BOJVJiiptoiPo2qfUDopQiftFWnKpKIfhB0/yCX2ZU4zwZKMOSHPwhrcB5KHw/MOfdISQrWzZCiKc6zaia+DcUOAoajjS+p2HU15sz5fKbEap93y8+DB7gPc5vZ2FgGC42bNBJDfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVQ+rZ5c2WBdt6jg4gdj5Vf1lmJpfhMrxjBqBtIukWw=;
 b=ijtjhXcebw+0fZHJB5I3pvYhjLBWGSPoYB6FkZXuzApjiFPvivt8C1PK+XaeGqOtbSCbAMuqUjZJc6zKi5QIpzUZxDI3NQmfiodKxwqLnVSNWX7gixXgoWjUM3JGpKSNpk8EkDRD4lXOVwxs7QrOVmJHlDMYnxbZSmC19hWHmpMk8XurlYqLvwOLE8xQW4m41Mge3seHpQiSLWaxYXLTF83g82Y6lIv1g25aFiEAhIexSS3/6WYNVng8rIB+kwjo6peVdrXISlgWputsE/Pf1vbDyeq5sb+SmnBNkmU2m293x0EmKVlUDIFMcizmRA2aN4zi1L7b9o36JKn+ZsQeKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVQ+rZ5c2WBdt6jg4gdj5Vf1lmJpfhMrxjBqBtIukWw=;
 b=UznIx8RWmXgOKkONzwmSD14aqaR67QKal67B6upVFQfEY5qQzcINO5654+Pqpfnp4lE4SCzMZk0CMj5GuZCORhncUvV7HJM8J0+8O/cK80/OBOadMeLk0GhMr2H0hKWy+AyG6Crn3+tPc8eTGAERnQj64B/q1jiUXGSMakzAraM=
Received: from BN9PR03CA0739.namprd03.prod.outlook.com (2603:10b6:408:110::24)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 19:26:06 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::58) by BN9PR03CA0739.outlook.office365.com
 (2603:10b6:408:110::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 19:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 19:26:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:26:05 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 14:26:05 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Samson Tam <Samson.Tam@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 12/16] drm/amd/display: add sharpening policy to plane state
Date: Wed, 9 Oct 2024 15:23:40 -0400
Message-ID: <20241009192344.650118-13-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009192344.650118-1-Roman.Li@amd.com>
References: <20241009192344.650118-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|SA0PR12MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1d1057-3307-4aa3-707c-08dce89838be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UctnfyEyMu4I9UZ6+yc4tnobd/5+3twzw/yzzZrKcWeegzDFh5ipJGocLd5w?=
 =?us-ascii?Q?EkvIxtlMwJ2gtGDAnK2M3jwEnPy74sYHXi7E15nCzFuOvGyGNm2G/gceZu2d?=
 =?us-ascii?Q?FjShNXY+YnSwzDONb3njsjT7Sq4v2p+5iNLR6m2nFpu3ppEkIZmX+Gmdz0kA?=
 =?us-ascii?Q?jDEBuKv1B/GqxYWWOFNi+0zvLet1lS/fMbOBd4PmH3a4WhyalJF2ZJkCugBw?=
 =?us-ascii?Q?vupMiegRj6EDc+AKUTall65kpdOzML+wRTV2hZOt2wpnRIOsJRwX/Eb4F3MZ?=
 =?us-ascii?Q?7Jy421yODnBgf8lWxSqUafN2+vXa/P7SZFG99rQjh4ruzxaOS/RtmlIyOUqj?=
 =?us-ascii?Q?t/mgzBf4L+8ZBwkgVLCQ110iAlIVX73pipKURba6aqp5YoOkg8ky+PDgik7/?=
 =?us-ascii?Q?fakY955iN8qHutOwFcLsuH6PiDwLW9W7SE5C5lY9EJSXY8zUjKgQ9T4yvTKG?=
 =?us-ascii?Q?SgmYxNEoH6e1YcL05nL3uUNe+BsASt96ngX3f+VeXoF749zLBq1eJWkON9LL?=
 =?us-ascii?Q?t/ob54ofsFsOt1bquAgyKbxUHX5mqJ1XRh7R3QI2iXF7+o56jXXVz97eX1wA?=
 =?us-ascii?Q?QwxFmozCzjwtwGWW9rc3hY9HUhuktglwxsmGT5mMkU7KyPi4DZvHzlxwrzuM?=
 =?us-ascii?Q?NjLSAiIBSrq5agoRwe2EZdjVxNccOjgsSmkLAdsyolzVHDfH1zcWhjiJ/JdY?=
 =?us-ascii?Q?OzPxROAFKmTorJN98oUx0kvhzo8l8uGCOR/RDnEHeqDHOx4rFGvRbrYa5pw2?=
 =?us-ascii?Q?BYyAKv+t+gxDEDIpu91uLOxWDZvV81xiQUvcNI3Q36UiYnnZHstc5FunLwja?=
 =?us-ascii?Q?0O2LFbyLJu8tLA/QtIzBa+RswqZaaH3YiBKJjWmuUc9NlPbHpc6HYzH4hFd5?=
 =?us-ascii?Q?JM8/aQFKHfw+Si/krHtmUGLWV9GFx+ODLvf8H8Cj1ub80XF/oBmS1znX/WLY?=
 =?us-ascii?Q?NVLD7f+VxE7jEr4ocvN4ofXmQ1K/PJVDD8kqnjEKTAuRGxc55znQBlYvlseT?=
 =?us-ascii?Q?UggHzYQrY8rS+IVCfyLr41oxRcY9tsfCIfR/80AU+eaJpU2pPLGJbeE2eDKT?=
 =?us-ascii?Q?stqvyLCa4h2nq2gPdnd6c3S2zUdD5SfVk3GwdFoAnlS08mZjuksDnjf088PB?=
 =?us-ascii?Q?Jx2C1xC+vINeC3ChdRbXzbGhnqpfGtgQvmtRk2nS7rZCWOCk2JpZ/OPnYzyo?=
 =?us-ascii?Q?T7LV29o95aLhPZcLJbkNfEZGjMhqKHFN6w0cWtnw1nH8RYX8NFWORcmob2Wm?=
 =?us-ascii?Q?SkCaB4IlHnCQxnsELMghtep+xq/rj6Crwfcj2C0aGK0OfM3AAN+27jyTnh5r?=
 =?us-ascii?Q?lbK8l96SnQch2iTCoU+YEMs+RvoaH7rm4txP7rGtFJvV9s6Epq3fMILcrk/4?=
 =?us-ascii?Q?DfMigREdA2a2VYaOuZ6bJRSHidXq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 19:26:06.3820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1d1057-3307-4aa3-707c-08dce89838be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
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

From: Samson Tam <Samson.Tam@amd.com>

[Why]
Pass in sharpening policy through plane state from control side

[How]
Add sharpener support through dc_caps.
Add sharpen policy to plane state and move to spl_input.
Pass sharpen policy from plane state to SPL.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                         | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dc_spl_translate.c           | 2 +-
 .../drm/amd/display/dc/resource/dcn401/dcn401_resource.c    | 1 +
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c                 | 6 +++---
 drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h           | 2 +-
 5 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 621444a1f190..ad8e2a91c306 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -227,6 +227,10 @@ struct dc_dmub_caps {
 	uint8_t fams_ver;
 };
 
+struct dc_scl_caps {
+	bool sharpener_support;
+};
+
 struct dc_caps {
 	uint32_t max_streams;
 	uint32_t max_links;
@@ -292,6 +296,7 @@ struct dc_caps {
 	bool sequential_ono;
 	/* Conservative limit for DCC cases which require ODM4:1 to support*/
 	uint32_t dcc_plane_width_limit;
+	struct dc_scl_caps scl_caps;
 };
 
 struct dc_bug_wa {
@@ -1355,6 +1360,7 @@ struct dc_plane_state {
 	enum mpcc_movable_cm_location mcm_location;
 	struct dc_csc_transform cursor_csc_color_matrix;
 	bool adaptive_sharpness_en;
+	int adaptive_sharpness_policy;
 	int sharpness_level;
 	enum linear_light_scaling linear_light_scaling;
 	unsigned int sdr_white_level_nits;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index 20fd0afca8cb..eeffe44be9e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -188,7 +188,7 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 	spl_in->h_active = pipe_ctx->plane_res.scl_data.h_active;
 	spl_in->v_active = pipe_ctx->plane_res.scl_data.v_active;
 
-	spl_in->debug.sharpen_policy = (enum sharpen_policy)pipe_ctx->stream->ctx->dc->debug.sharpen_policy;
+	spl_in->sharpen_policy = (enum sharpen_policy)plane_state->adaptive_sharpness_policy;
 	spl_in->debug.scale_to_sharpness_policy =
 		(enum scale_to_sharpness_policy)pipe_ctx->stream->ctx->dc->debug.scale_to_sharpness_policy;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 7da81966b4df..46feff9348d9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -2171,6 +2171,7 @@ static bool dcn401_resource_construct(
 	/* SPL */
 	spl_init_easf_filter_coeffs();
 	spl_init_blur_scale_coeffs();
+	dc->caps.scl_caps.sharpener_support = true;
 
 	return true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index c38a5c8646e8..f043c7e32e16 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -848,13 +848,13 @@ static bool spl_get_isharp_en(struct spl_in *spl_in,
 	 *  surfaces based on policy setting
 	 */
 	if (!spl_is_yuv420(spl_in->basic_in.format) &&
-		(spl_in->debug.sharpen_policy == SHARPEN_YUV))
+		(spl_in->sharpen_policy == SHARPEN_YUV))
 		return enable_isharp;
 	else if ((spl_is_yuv420(spl_in->basic_in.format) && !fullscreen) &&
-		(spl_in->debug.sharpen_policy == SHARPEN_RGB_FULLSCREEN_YUV))
+		(spl_in->sharpen_policy == SHARPEN_RGB_FULLSCREEN_YUV))
 		return enable_isharp;
 	else if (!spl_in->is_fullscreen &&
-			spl_in->debug.sharpen_policy == SHARPEN_FULLSCREEN_ALL)
+			spl_in->sharpen_policy == SHARPEN_FULLSCREEN_ALL)
 		return enable_isharp;
 
 	/*
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
index 48e4217555f8..fcb5d389592b 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
@@ -508,7 +508,6 @@ struct spl_funcs	{
 struct spl_debug {
 	int visual_confirm_base_offset;
 	int visual_confirm_dpp_offset;
-	enum sharpen_policy sharpen_policy;
 	enum scale_to_sharpness_policy scale_to_sharpness_policy;
 };
 
@@ -530,6 +529,7 @@ struct spl_in	{
 	int h_active;
 	int v_active;
 	int sdr_white_level_nits;
+	enum sharpen_policy sharpen_policy;
 };
 // end of SPL inputs
 
-- 
2.34.1

