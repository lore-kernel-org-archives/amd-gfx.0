Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D287AFEDA09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C69610E643;
	Wed, 18 Mar 2026 01:02:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AtyodvIH";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6FD810E643
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1YSS32Jfox8rhxMjSwnZyizjbTjdU0ktZPqXUjoaQpi0iMcp7RXOOhe1i8r6zyUvPy2H4FnTShwPneUNpopKLeXQp5yVv2g505fJVkDCe1wupEPo9n4SpLCTN+PFy9Ne059ufiKyeSAAdTmRRFGU2dIF189LfsCde5AEzjaClnFHnekjRGO/kX5f89LpTRMTlUSeYny0zeNI6DeY/rZg0+DdCgkMiLMlju0zxKWd0jtSrumuH7zMapjAjx9dACfdQX0IGmKdBve44BKD+da+ddJ00Caiw/fOCaxFVKKJPOsbhk0JCASCnJVkrp1z2a/N4I7XbU3xPO8otxs4ycnIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaZuvGOuJfiXPuwttp8yUg0xrC94XHZ1/rorN+5YOP0=;
 b=VrqvP8HqO5T2dxkxWM7b8cmTsl3RKZiB6k9zWEWcqmKE6a0D3rzgvjUI9n15KqYPxChk059afauxwF4+VdPsp3Fd7KCSXBtxoMiHZfCSfhgK9VMkfs5hMONTTU0BvpzbwZ8kHgzVn19mku7NbqhRlabWfZ0z+JuLadTV0cIPVMFWaRg0j8IznPfK+ZNxDM/ROd80LfQXnoK4HTZug3gyYQfuk7xTR9jwaYP1XhXAcqEY+B/Fc4Sh+2cBdenMrGmv48HXuvKpOb7NHfzxsNS+I/LKWt6IFwJdSg0RGSNqiF9GDnKGJ/Yq9S/C0pEGYYMK2rsnuh0eFKRLi4yYjqnyMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaZuvGOuJfiXPuwttp8yUg0xrC94XHZ1/rorN+5YOP0=;
 b=AtyodvIHomtCdI28Pv/p0+I8wdyK5phXHoRVYoidC388aUue8tHGUPKHOE1eefZoj/TWwT8Cc8YpBhTQF9Sn9ArGJDye4MXOJgWm09Um34JFDhWGBofz4TJoPpW7gn+4C5aheOwvHuEjGDFqp29uchnZa4kGUNGr3BhRUDJZDKM=
Received: from SA0PR11CA0015.namprd11.prod.outlook.com (2603:10b6:806:d3::20)
 by DS7PR12MB6072.namprd12.prod.outlook.com (2603:10b6:8:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:02:08 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::d3) by SA0PR11CA0015.outlook.office365.com
 (2603:10b6:806:d3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 01:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:02:08 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:02:04 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Chuanyu Tseng
 <chuanyu.tseng@amd.com>
Subject: [PATCH 18/31] drm/amd/display: export get_power_profile interface for
 later use
Date: Wed, 18 Mar 2026 08:59:27 +0800
Message-ID: <20260318010224.513094-19-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|DS7PR12MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 526c104c-ca76-435e-e75a-08de8489fa78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Nw3GF4jbCf54Y40ClVRepIR1bQ+xBpdJ3Zn6g3UccetfcBXvh5nl3wJ3psibxm1LhwN+wZjNTRxCLWgKQufSlc3gW0APVLMF9MLyHt/ltWFcuGBEHnOJKuvsoLVSl6nc/UKjRyimMdRA00Cu+H/KjYGULWcxr1ggLGbG0ZXhaJm2U0rwO/nfnwI5CztGDuSxcDetyqGS54GbizRks7vHc0gHjAhNGxwYOvdZYwwp1FVqa61JXTrzflPL2Izt8cZ33V09pT5MsCazxUNl/7AuCdBngr2QJCnBGQlB1/tdwA8AYltJe6ZcQ7ke/pTVdyaIjQvdPFAycaiTVKLxaJ0293/ruMOhQEA6K7jTNV7n1TibWHcyXXrwuS0jH/BLZDvaeXMtCr/ZsCDwUXJqPYt3YfQ0yOOwb7vp++wh7D6bffjJkgaoWa/M+XMLC3wT42omTqoiHlchD+tgpgl3TWIgkn6K4rlgi+wg2qrakdqdr6rV8QigQlyGqt95dDmu7/5rsA+kgibaTot/Dy4p+lXSn3WT6ev4iIoVYSe6AWo7xMfHjqDvSShTd0UQLsRlRxxFX0iMbi9WroFfrezqwfejG4E1YjzGgNrin7YDSMsoTfcd71SyE1kb4giqoIZ3cl/DzKz0FqSXrBjIHHi2G83QKgxejijbHV0igcMp5Vkq8vZJ/XA0uQ01cvYTqMpyxgo1W95h3YWNzRYuYBYxILPwYIpYgToL46ZwJXHnKvnN8gA1RKh5iLNVKvMC/Z3zWmfq3/+HEVjZlnwoQrCevz+xKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B1EfdImRParJdFt2P3U1+ZUW9UW7j7P82o7HvdZjuf22vC6bTeRjir8uEgKyagD2EOyKYd9tdZrzQ6jds5StKy060wG11HFjWjYpRJVJ4u7sZoxN80bmQvg5hh8YzyS9Xlq4kjIyIpkCOE8X/Grv7nMGlL67onRIh+SQFnaWNnH6iA41FBsgiDrSmofF/Tfpac7q55awpaeasm4pkRv/CTQzpygv5Sgj3HNtfCyple0gvGLUt6/qUfNye9tL3QEEbqjuqLxPUBhGctUsemRkyQ0ZHNSgbCkUAPCIgq5+otArgmkOueWhcvDUPa6u4ImRlzd4bJ/pH12yXkGnXuA9tnsw92IjWwFK/93z0WXBqN4qayryYs/7upvYoS4jFqkCf/Z2nalqHDjjb2ZF0+AW77w4al7bLbIlM17IwgajOfUHDB++h0I7dkxcncseIkl+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:02:08.0431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 526c104c-ca76-435e-e75a-08de8489fa78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6072
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
export dcn401 get_power_profile for later asic.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c    | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h    | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c  | 1 +
 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h  | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 57ae4b216b5d..7ac2f38bfde8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1794,7 +1794,7 @@ static void dcn401_build_pipe_pix_clk_params(struct pipe_ctx *pipe_ctx)
 	}
 }
 
-static int dcn401_get_power_profile(const struct dc_state *context)
+int dcn401_get_power_profile(const struct dc_state *context)
 {
 	int uclk_mhz = context->bw_ctx.bw.dcn.clk.dramclk_khz / 1000;
 	int dpm_level = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index 5f3b0319cb5b..47f82b818262 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -32,6 +32,7 @@ void dcn401_get_default_tiling_info(struct dc_tiling_info *tiling_info);
 
 unsigned int dcn401_get_vstartup_for_pipe(struct pipe_ctx *pipe_ctx);
 
+int dcn401_get_power_profile(const struct dc_state *context);
 /* Following are definitions for run time init of reg offsets */
 
 /* HUBP */
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 8175109a66b0..fa5d0558192c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -1791,6 +1791,7 @@ static struct resource_funcs dcn42_res_pool_funcs = {
 	.calculate_mall_ways_from_bytes = dcn32_calculate_mall_ways_from_bytes,
 	.prepare_mcache_programming = dcn42_prepare_mcache_programming,
 	.build_pipe_pix_clk_params = dcn42_build_pipe_pix_clk_params,
+	.get_power_profile = dcn401_get_power_profile,
 	.get_vstartup_for_pipe = dcn401_get_vstartup_for_pipe,
 	.get_max_hw_cursor_size = dcn42_get_max_hw_cursor_size,
 	.get_default_tiling_info = dcn10_get_default_tiling_info
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h
index 8e7a09402de5..60acf0e423d9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h
@@ -586,5 +586,6 @@ enum dc_status dcn42_validate_bandwidth(struct dc *dc,
 							  enum dc_validate_mode validate_mode);
 
 void dcn42_prepare_mcache_programming(struct dc *dc, struct dc_state *context);
+int dcn42_get_power_profile(const struct dc_state *context);
 
 #endif /* _DCN42_RESOURCE_H_ */
-- 
2.43.0

