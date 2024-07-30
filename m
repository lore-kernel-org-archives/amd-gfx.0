Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B978C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FDD10E4C4;
	Tue, 30 Jul 2024 07:21:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mYVSc7VL";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D611E10E4C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKNoRsUINWGNUd8CDQuBoNxTKx4l4NN0hk6O9afHNbHn0GkMgp2a4VI6jqaGFoMB5zq3JyqPpGlTZLT+bk5ibS7810V+iOr5D78V4cFgkLExdR0awaS2ENc91IuLdec4Nu9tpVTWlSKu+6tZHFYGvPDJSwNMahrDz4SXyX0V7i+OlsbpBNIqC0ejDNF4UvQt8NAuFNVFXkPmZaV/hpkd0Y73b9nEAqCsolv+TB6AWgimo/S3YTEB71R12xrcwaqORCS8RXV8w9FC1IFiH2yYSLmax0IDD86jTQdXsOjvPaDFz/M+hthVKV8OG+w9aZbPTqGxanKwfJYYNDKh3PFPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzFAg4+V7nOIGgu+IvwEZBHBx8fdZd3vTlsx9p4ZBHc=;
 b=q2pSZ/O/o1QnwxOj/Eklfj/SsQM/vzhfnZwW3zXqZaBpP7AggWUIeChvYcxAehkvpkQ+FerbiN8I1X4LR73IB59BBOstF9aGL3bnQ5PqgeCIR6kQvCSsd4vCHyxGhfIPhvQRGm8tdGHnht5r8bSjovog2UCtUKKl8o0A3gkgucrBe+fPJaf/KYrJpnmQgrY2nTJNPJceAq87+s1Sk+qeDu8HRoBmufDTXaq3MugoF6fQo6LjLkQXCItgXJnhIxZ4hqusDenso9kQefUP4DvR+crywOndH4lrtrzj4dwgXPR0DfaOb9URO6CLDTti7fhed94faEh10oOqL/sM3EuhgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzFAg4+V7nOIGgu+IvwEZBHBx8fdZd3vTlsx9p4ZBHc=;
 b=mYVSc7VLIFbwtQ9WzAgSYoyNZzQeIP77lXZwtJTocZB7MdeShXxacMPLK0DIHUDbIXdZi21J2/AMZENbjQv9HUpD8ci3XMNm1VUzMGgZ0R+SmNiOZJhuqAppE2eKfZakTuslPgqiDRUY2HfvA7Q0UyjnzDb16BhaJri3HIz95qQ=
Received: from CH0PR03CA0305.namprd03.prod.outlook.com (2603:10b6:610:118::7)
 by DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Tue, 30 Jul
 2024 07:21:12 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::86) by CH0PR03CA0305.outlook.office365.com
 (2603:10b6:610:118::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 07:21:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:21:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:21:11 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:21:05 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 13/22] drm/amd/display: Force enable 3DLUT DMA check for
 dcn401 in DML
Date: Tue, 30 Jul 2024 15:18:34 +0800
Message-ID: <20240730071843.880430-14-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|DM4PR12MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 9460b67a-1283-4baa-37bf-08dcb068310d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tNN/jj72aAq4jqKZbtt4mngvcWUEX1c8AEIgwPHHQxNQ6V1m+YPNupNuPs9B?=
 =?us-ascii?Q?PwMZUVFLFlLD7S4GZBKbxyZ2Da5ygv9lXI0H4kUy9bljXvxc7PHb6XZe76I2?=
 =?us-ascii?Q?MfZbKX28omcBWktzUZ3Qaua6CoywtJb/sNkr6yvuNuwH7NhTvHfHN1nzylz2?=
 =?us-ascii?Q?78azdO9YJC9nYepuAvnxeURbHyzTryUpQeaFqfmxdioVzJgG7mfI4gD8Wj07?=
 =?us-ascii?Q?Jl0qs+wU68zbZQ78KPjjfc5Xr/hFTdSDtbHw+iDYHZO4SizYIrTQQ4AMC+Q3?=
 =?us-ascii?Q?d8olfMiqn4FCZG+o7Ya7C7eqXwEkfuKFb6Ttdl11q0gp2/ppN1krW8sxn6D5?=
 =?us-ascii?Q?Dq/CeUF9bn8n9TKhXIUPhl/IwTnf2ur6MRwbbgNwrRzqzkVvbab9WsE7g1W/?=
 =?us-ascii?Q?LLGwxaSuO8dWmRfbCXJE+XilD+URelEvkoPSBSFUMMkoMm2f+aVZZesOCNv3?=
 =?us-ascii?Q?LyG2oCIb1dncL0/xS1HOXNQHrBEwbepz+gNk19nAG5tNKtNmSAu5UnhnkMau?=
 =?us-ascii?Q?Eo8+24bUYhofge7mUf3UBKMgaOX3CVLvGJuiIT1Tt+3ElhqZ4q1i8Lm4b+y3?=
 =?us-ascii?Q?RN1EeK0JdVapvd0NJ+EUS8Fmdb872dC499zuw/FCE75e/RTyGu+teDoZkTr5?=
 =?us-ascii?Q?hPd2JIyA9fG/Kro4DCTP1kPmXg6shMXLijcHsvx0FZrEwI0Pnc8R4lj2NtKi?=
 =?us-ascii?Q?hDD0bQYWXEQ25oUp0WkcBsTIQqUfTWhmtl92G02XBanZ3oPV6WHDOrIKgnpj?=
 =?us-ascii?Q?FUqi0MQhEhsgdcnDH2lvmRBKcr6eQ9lkMXq47UQL0RUejcrI6wY30fPRqLwS?=
 =?us-ascii?Q?3P+Wl6I9wHvzAHHRtar3cXXCLruCI5SgLNir4y8VYPJP5rHjfiWctr/AdBHB?=
 =?us-ascii?Q?XIn5NkHQ1S5GRu2IoaEYBAWyftpXWzmz3eLHsZDMpqcTlv+EXsN5TK6foBuF?=
 =?us-ascii?Q?C3ARUq3J+A4a6AQSgLqeDXnolLNXOrZjwOcSoF1X7uIbg/VcPd3Ymlk5qpyZ?=
 =?us-ascii?Q?58GND579Us3/IE4fiqQMS1jUQRyAU+MjjynsGtYIZQ5OWhQnSqYshGQxcc2V?=
 =?us-ascii?Q?crkUTijwGvypuRPwEiKxcy2HK8eyzmOUfIlwxRggOEyRKT8KSscR/gnd+Y9H?=
 =?us-ascii?Q?SI0eB2JcmYuAzBAZY7VRSpmaxh0jTLHvMw+1S98aQwzXgVAWMmQ6oNc0fWrh?=
 =?us-ascii?Q?4IjfyK34pGUVEC7csRcsVjp05e7n8zTbexfQD5eRoM6YMA0ZT0J6sJUENTSM?=
 =?us-ascii?Q?Ln1V41rwryG1relKi1E2mQosAqa0nduWBrlxtiXhGFKGKgA5iD7BjkEYI5Id?=
 =?us-ascii?Q?EJ9y/+OHU5bV6Mo68ex0kjbIpVtVluD26054NDWGKap+WZY/ay5qgdc9W4X+?=
 =?us-ascii?Q?sz2AXenpu5bju/Bhy5yq+Ak/UPkDs4Bj0m9Pmz1UFd+dUVeGEBBCXsQWEb/7?=
 =?us-ascii?Q?knpHmDvax879tXMuATRXgN5ut1mHVLU/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:21:12.5023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9460b67a-1283-4baa-37bf-08dcb068310d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY]
Currently TR0 (trip 0) is not properly budgeting for urgent latency in
DML2.1. This results in overly aggressive prefetch schedules that are
vulnerable to request return jitter, resulting in severe underflow at
the start of the frame.

[HOW]
Forcing 3DLUT DMA check to enable causes urgent latency to be budgeted
properly into the prefetch schedule, avoiding the vulnerability.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/dc/dml2/dml21/dml21_translation_helper.c    | 6 ++++--
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h          | 1 +
 .../drm/amd/display/dc/resource/dcn401/dcn401_resource.c    | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index b0de8920f7e7..006667aa961b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -816,6 +816,7 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 
 	if (plane_state->mcm_luts.lut3d_data.lut3d_src == DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM) {
 		plane->tdlut.setup_for_tdlut = true;
+
 		switch (plane_state->mcm_luts.lut3d_data.gpu_mem_params.layout) {
 		case DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_RGB:
 		case DC_CM2_GPU_MEM_LAYOUT_3D_SWIZZLE_LINEAR_BGR:
@@ -825,6 +826,7 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 			plane->tdlut.tdlut_addressing_mode = dml2_tdlut_simple_linear;
 			break;
 		}
+
 		switch (plane_state->mcm_luts.lut3d_data.gpu_mem_params.size) {
 		case DC_CM2_GPU_MEM_SIZE_171717:
 			plane->tdlut.tdlut_width_mode = dml2_tdlut_width_17_cube;
@@ -833,8 +835,8 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 			//plane->tdlut.tdlut_width_mode = dml2_tdlut_width_flatten; // dml2_tdlut_width_flatten undefined
 			break;
 		}
-	} else
-		plane->tdlut.setup_for_tdlut = false;
+	}
+	plane->tdlut.setup_for_tdlut |= dml_ctx->config.force_tdlut_enable;
 
 	plane->dynamic_meta_data.enable = false;
 	plane->dynamic_meta_data.lines_before_active_required = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index 023325e8f6e2..0f944fcfd5a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -236,6 +236,7 @@ struct dml2_configuration_options {
 
 	bool use_clock_dc_limits;
 	bool gpuvm_enable;
+	bool force_tdlut_enable;
 	struct dml2_soc_bb *bb_from_dmub;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 3e76732ac0dc..ec676d269d33 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -2099,6 +2099,7 @@ static bool dcn401_resource_construct(
 	dc->dml2_options.use_native_soc_bb_construction = true;
 	dc->dml2_options.minimize_dispclk_using_odm = true;
 	dc->dml2_options.map_dc_pipes_with_callbacks = true;
+	dc->dml2_options.force_tdlut_enable = true;
 
 	resource_init_common_dml2_callbacks(dc, &dc->dml2_options);
 	dc->dml2_options.callbacks.can_support_mclk_switch_using_fw_based_vblank_stretch = &dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch;
-- 
2.37.3

