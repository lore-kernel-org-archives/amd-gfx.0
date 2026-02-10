Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823D8EA8118
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 13:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1679210E586;
	Tue, 10 Feb 2026 13:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qakBaN6N";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B925210E586
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 13:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Seys8eMEZCGUj8X3I+NwNBA50bqs0GS+QoG1j7Nxve39qOh0tZg/eNB6Zng3eUDMxL8JL1Karz/6QGROaXP/NqJjxHh3kZYaFIXnKRrPECMV7Hk3wX6m/SpO9cpfe7Iz8FwNZwUlc1GgzVPy3IBjLv3c9yC3wqsP06GU/iPCl6fGqOVYSWG1fUXp0qb9Ng6PvPT4Vs3JKWoNHuLcsmgiI/9+iQ3qlE7hKRkQm4/OI6sc6+PMeGcsBFsSmsNBwXTemx4UMrU2UbySJFNnO0Xry8IgOepMNwU0z6Gbqisbajo1sOy4vYKaGTOWKgFTdpf+FxwycQmMevXMqSH3xSebpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTiL4q49miqPokxgRHjzqPnevbDWFrlWSxmOGnRZq6s=;
 b=JQ1vljZshUHdMca+g1Q8pLBeGwNscrN63NrP6NCBdzrHI1hEZQmAtYfP8azhnNGyN8lFYq6kVknOriLmtfVHFrQ9hHfj6gWJDcS/BE2H9upgP4y+5eEg0D0hSEqWa7XngYWR6s/1w2RXz0q1lnGQC5BIb6ZZ5v0OnZAvqqAxwLCmxQxSN7g36+/kS/8uTTdRFg4sjuEqzhg55jde1BIMaBypsnUaAeb+2Kk3tLM+iejAnJg5elIJ1dyYl158g5RF2DxjbO+Bs5dJHC7O28wuMHOtZavsZshd5OxPERIJ7UX+Qt4sufM+1JQcKvr4xaGiUaN6R1tBp+ab4YFuJQmaDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTiL4q49miqPokxgRHjzqPnevbDWFrlWSxmOGnRZq6s=;
 b=qakBaN6NoQXbEmEBGep9I/KgmcOS7ThZx7XTF9pYNeGizuEXxzPtuIIRV6MTsFC26ykk7Zbr6pcECF5RWJRN9A9ZZEOt847bMlFQZddiC0+cAmGpAiVKTVsHo6xzMoBT06NDrfodLNqcq3tBCNxm5DHbnOg7LtvgutmfZiw6j90=
Received: from PH8PR07CA0007.namprd07.prod.outlook.com (2603:10b6:510:2cd::23)
 by IA0PPF7646FEBB5.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 13:56:20 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:510:2cd:cafe::5c) by PH8PR07CA0007.outlook.office365.com
 (2603:10b6:510:2cd::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 13:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Tue, 10 Feb 2026 13:56:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 07:56:18 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 05:56:18 -0800
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Feb 2026 07:56:10 -0600
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>, "Wenjing
 Liu" <wenjing.liu@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 14/18] drm/amd/display: Refactor and fix link_dpms info
Date: Tue, 10 Feb 2026 21:50:07 +0800
Message-ID: <20260210135353.848421-15-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135353.848421-1-ray.wu@amd.com>
References: <20260210135353.848421-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|IA0PPF7646FEBB5:EE_
X-MS-Office365-Filtering-Correlation-Id: e4609507-52e1-4ce8-142d-08de68ac2ad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QvZ5uT4ebJsQp4tDYWwd3iNYi3xYcYdiA0nkx/f1bd7mYLzkYNa88q6u/eCV?=
 =?us-ascii?Q?yxOMttpt8OWsDHGK5ZU86XDu4GCn63PBsywnQXKIt6g63QAmoVi4iHYQwHB2?=
 =?us-ascii?Q?Nl5asNlWmbHruOusVksf6nraXgzGadSVTbVl9Q19I+TnB1J69EGI7GXYMlUk?=
 =?us-ascii?Q?JQd3dAG38c1+ES/9leBbHn9YSq26eq9/lJffI9b/2Y1wuW5bHZmZtVHyehU/?=
 =?us-ascii?Q?wt3rj9Zdnpwrx32rv6xgsUeQ6MsiU/iY0UF8wW4t4htaXXisuLdMgMzoRfJL?=
 =?us-ascii?Q?Aa4sf8ea+z9oq9PLIXiXqzdykLvVtyVOuu6guzQDrCO4X86KokyhfvCWLg0z?=
 =?us-ascii?Q?/WLlZgu/a5GK3HUF2anor/VG3xjeaVet8b8eXAhxmdoXBlspFlUHyfMIj+tS?=
 =?us-ascii?Q?Hij3YN7TC6wXY5JnSxIrN71hfaayZUs6Fu0n1hDitAfnQBPNiU40CLVd2wYW?=
 =?us-ascii?Q?XV9PgB3S1uhuM/EqUDm08+oRwW06Hd1vHEpFF+ldBL0EAUC03Blnrf77ZdlT?=
 =?us-ascii?Q?rkZZ6DEZHMAsCI3/SDxobs0jdSkbRkemaxi5lXTD8VAzZyvTKzx4h/0zyYzX?=
 =?us-ascii?Q?hnO0BtaIPqbVlPCX6w/RaoJ5zz2jZQItRu4ZcHyFkXvmgwhKgizDgc8gNE6K?=
 =?us-ascii?Q?0tKrByGz/CVGyjyPpcemykEHxjT84anZpFl+SWu05bfLgdz7Z4q6K0ZM7kdo?=
 =?us-ascii?Q?lFZfunCa+CPI2j2Lq+ZIezwkOtw0GwWNo2VxhMqqM8UL0vcqcwiytNgLACsn?=
 =?us-ascii?Q?qcfBkCAGtOS9AYHLBz9SqRtklujWWOTviy3yaOFZD2kMjNuCCaLfCFf6unIL?=
 =?us-ascii?Q?u3rT4jl7b0F/THHpnmNJTP+o9q9puN/BENJOz7NiVpi9zRTL0V+o6W2U3i/W?=
 =?us-ascii?Q?hZdNSmSjJ2iwtE2SoFUKTt9hxMrZjaxTowUrCODV2cUlqAeR68st6RSlgK7G?=
 =?us-ascii?Q?ef+BaExnAP01j1dRs04sC8Aq7uOllkg/mQZioDQ7Wv0eUENVIIaK7iOMLNxH?=
 =?us-ascii?Q?u6t9uYJIfO6jHm0abj8lktJsR+pdTXLZ6DsdMlXx1BZb8aNTcopf1Ci8FC/v?=
 =?us-ascii?Q?VY0vmVxxbmCY0q6el2H+gmrwR6OgNUm9hj4fpUlo2JAom9z7G89HOpsR+Jih?=
 =?us-ascii?Q?f0qzyS0fo2pACLu15xu0+//5zYo/swTVyBQJXwvQOh11elfGuyb/rsrYXpbJ?=
 =?us-ascii?Q?yRu9v4U9kTOqaT4/8HJMD4l1FPlWe01n6dLBNtwqYCR888C3VjL+BREqsle6?=
 =?us-ascii?Q?8HKcBLUjlqf4XqWFVjwmhJKOP4C4emeUtuR4OFgFIUmJPcIuLLp+z31B+VKj?=
 =?us-ascii?Q?7LRfp/q0KfBtHWhLBuW9UjfXkow5Z9mRen2wUukQIpTCA5dT9aOl33pUuPAs?=
 =?us-ascii?Q?LbZV3AlloalCexuVsZnLHFZrO/PGmfUmm/6uxeXbAFmHEuvM31LLmoBY1uha?=
 =?us-ascii?Q?4cK4MroSotEGZ8Lh49W24qRrC/YYnyD672jXHrZdooI7KfW5hlQupjkaRM9p?=
 =?us-ascii?Q?i/VNaXjJA1jiUpfCxairs03V19mCYqcrm6k1LFxIN5SvdDOUjZymi0oYpxwr?=
 =?us-ascii?Q?Nw++aDsWXNbUY73rAuQkyMvPGgLno+fzU/4DCfNJeMud4WVTgARF9CmKWG/k?=
 =?us-ascii?Q?f4MclhzvMjJTTYwPl9ys9tZkrLXZb7sWedADyMJ1BvhQ0Yf/E6Ui3WsciRqh?=
 =?us-ascii?Q?LTsBJQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0FcYLZEiGm2QJkAQwgdTO3ykJ7Rcw17/zjyonS8+L6dcTy0sMrSkO2Y6/jH1OPr7PB4ofqznmnX9JfoOIkwq0D6nj8ByHJoIvXyWowFxHZes36F7lssiPzsJOYR1qy67YdoW/YhrABvAtmAkA1WeJv6CpY0ab98Oo9SviJvb14+zKeqZtaz+IOmxj4YKohszaC7bwUZa1l7IZb23nNCoqrKEAOap4v4ZZ887ZQGsNjLItY41vGnSieYGcbkWEjMbvFPAipi5eD93Hd75j4vPwYVHVS6bBbROYuAq2ZkH1A4GUbTcnHKKWWs5ZqRS+H1HwSBpLtjB37yics48UljSChtG7mH8pv8R/AOmYYZCu5nuItibx52LkOGbEf6W7d7DZlc2u7i/Ruw9Upt38FANesoYt+v8Pb4uks883eUR/5A9IELPZ3nZweVsNkycHsGN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:56:19.3800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4609507-52e1-4ce8-142d-08de68ac2ad0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7646FEBB5
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

From: Dominik Kaszewski <dominik.kaszewski@amd.com>

[Why]
get_ext_hdmi_settings contained a copy-paste error, assigning
both reg_num_6g and reg_num from dp0_ext_hdmi_6g_reg_num.

[How]
* Correctly assign reg_num from dp0_ext_hdmi_reg_num.
* Refactor and clean the function.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 165 +++++++++---------
 1 file changed, 84 insertions(+), 81 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index befbe005af68..89c916dbf657 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -223,16 +223,32 @@ void link_get_master_pipes_with_dpms_on(const struct dc_link *link,
 	}
 }
 
-static bool get_ext_hdmi_settings(struct pipe_ctx *pipe_ctx,
-		enum engine_id eng_id,
-		struct ext_hdmi_settings *settings)
+static struct ext_hdmi_settings create_ext_hdmi_settings(
+		uint8_t address,
+		uint8_t reg_num,
+		uint8_t reg_num_6g,
+		const struct i2c_reg_info *reg_settings,
+		const struct i2c_reg_info *reg_settings_6g
+)
 {
-	bool result = false;
-	int i = 0;
-	struct integrated_info *integrated_info =
-			pipe_ctx->stream->ctx->dc_bios->integrated_info;
+	struct ext_hdmi_settings result = {
+		.slv_addr = address,
+		.reg_num = reg_num,
+		.reg_num_6g = reg_num_6g,
+	};
+
+	memcpy(result.reg_settings, reg_settings, sizeof(result.reg_settings));
+	memcpy(result.reg_settings_6g, reg_settings_6g, sizeof(result.reg_settings_6g));
+	return result;
+}
 
-	if (integrated_info == NULL)
+static bool get_ext_hdmi_settings(
+		const struct integrated_info *info,
+		enum engine_id eng_id,
+		struct ext_hdmi_settings *settings
+)
+{
+	if (!settings || !info)
 		return false;
 
 	/*
@@ -242,82 +258,69 @@ static bool get_ext_hdmi_settings(struct pipe_ctx *pipe_ctx,
 	 */
 
 	// Check if current bios contains ext Hdmi settings
-	if (integrated_info->gpu_cap_info & 0x20) {
-		switch (eng_id) {
-		case ENGINE_ID_DIGA:
-			settings->slv_addr = integrated_info->dp0_ext_hdmi_slv_addr;
-			settings->reg_num = integrated_info->dp0_ext_hdmi_6g_reg_num;
-			settings->reg_num_6g = integrated_info->dp0_ext_hdmi_6g_reg_num;
-			memmove(settings->reg_settings,
-					integrated_info->dp0_ext_hdmi_reg_settings,
-					sizeof(integrated_info->dp0_ext_hdmi_reg_settings));
-			memmove(settings->reg_settings_6g,
-					integrated_info->dp0_ext_hdmi_6g_reg_settings,
-					sizeof(integrated_info->dp0_ext_hdmi_6g_reg_settings));
-			result = true;
-			break;
-		case ENGINE_ID_DIGB:
-			settings->slv_addr = integrated_info->dp1_ext_hdmi_slv_addr;
-			settings->reg_num = integrated_info->dp1_ext_hdmi_6g_reg_num;
-			settings->reg_num_6g = integrated_info->dp1_ext_hdmi_6g_reg_num;
-			memmove(settings->reg_settings,
-					integrated_info->dp1_ext_hdmi_reg_settings,
-					sizeof(integrated_info->dp1_ext_hdmi_reg_settings));
-			memmove(settings->reg_settings_6g,
-					integrated_info->dp1_ext_hdmi_6g_reg_settings,
-					sizeof(integrated_info->dp1_ext_hdmi_6g_reg_settings));
-			result = true;
-			break;
-		case ENGINE_ID_DIGC:
-			settings->slv_addr = integrated_info->dp2_ext_hdmi_slv_addr;
-			settings->reg_num = integrated_info->dp2_ext_hdmi_6g_reg_num;
-			settings->reg_num_6g = integrated_info->dp2_ext_hdmi_6g_reg_num;
-			memmove(settings->reg_settings,
-					integrated_info->dp2_ext_hdmi_reg_settings,
-					sizeof(integrated_info->dp2_ext_hdmi_reg_settings));
-			memmove(settings->reg_settings_6g,
-					integrated_info->dp2_ext_hdmi_6g_reg_settings,
-					sizeof(integrated_info->dp2_ext_hdmi_6g_reg_settings));
-			result = true;
-			break;
-		case ENGINE_ID_DIGD:
-			settings->slv_addr = integrated_info->dp3_ext_hdmi_slv_addr;
-			settings->reg_num = integrated_info->dp3_ext_hdmi_6g_reg_num;
-			settings->reg_num_6g = integrated_info->dp3_ext_hdmi_6g_reg_num;
-			memmove(settings->reg_settings,
-					integrated_info->dp3_ext_hdmi_reg_settings,
-					sizeof(integrated_info->dp3_ext_hdmi_reg_settings));
-			memmove(settings->reg_settings_6g,
-					integrated_info->dp3_ext_hdmi_6g_reg_settings,
-					sizeof(integrated_info->dp3_ext_hdmi_6g_reg_settings));
-			result = true;
-			break;
-		default:
-			break;
-		}
+	if (!(info->gpu_cap_info & 0x20))
+		return false;
 
-		if (result == true) {
-			// Validate settings from bios integrated info table
-			if (settings->slv_addr == 0)
-				return false;
-			if (settings->reg_num > 9)
-				return false;
-			if (settings->reg_num_6g > 3)
-				return false;
+	switch (eng_id) {
+	case ENGINE_ID_DIGA:
+		*settings = create_ext_hdmi_settings(
+				info->dp0_ext_hdmi_slv_addr,
+				info->dp0_ext_hdmi_reg_num,
+				info->dp0_ext_hdmi_6g_reg_num,
+				info->dp0_ext_hdmi_reg_settings,
+				info->dp0_ext_hdmi_6g_reg_settings
+		);
+		break;
+	case ENGINE_ID_DIGB:
+		*settings = create_ext_hdmi_settings(
+				info->dp1_ext_hdmi_slv_addr,
+				info->dp1_ext_hdmi_reg_num,
+				info->dp1_ext_hdmi_6g_reg_num,
+				info->dp1_ext_hdmi_reg_settings,
+				info->dp1_ext_hdmi_6g_reg_settings
+		);
+		break;
+	case ENGINE_ID_DIGC:
+		*settings = create_ext_hdmi_settings(
+				info->dp2_ext_hdmi_slv_addr,
+				info->dp2_ext_hdmi_reg_num,
+				info->dp2_ext_hdmi_6g_reg_num,
+				info->dp2_ext_hdmi_reg_settings,
+				info->dp2_ext_hdmi_6g_reg_settings
+		);
+		break;
+	case ENGINE_ID_DIGD:
+		*settings = create_ext_hdmi_settings(
+				info->dp3_ext_hdmi_slv_addr,
+				info->dp3_ext_hdmi_reg_num,
+				info->dp3_ext_hdmi_6g_reg_num,
+				info->dp3_ext_hdmi_reg_settings,
+				info->dp3_ext_hdmi_6g_reg_settings
+		);
+		break;
+	default:
+		return false;
+	}
 
-			for (i = 0; i < settings->reg_num; i++) {
-				if (settings->reg_settings[i].i2c_reg_index > 0x20)
-					return false;
-			}
+	// Validate settings from bios integrated info table
+	if (
+			!settings->slv_addr
+			|| settings->reg_num > ARRAY_SIZE(settings->reg_settings)
+			|| settings->reg_num_6g > ARRAY_SIZE(settings->reg_settings_6g)
+	) {
+		return false;
+	}
 
-			for (i = 0; i < settings->reg_num_6g; i++) {
-				if (settings->reg_settings_6g[i].i2c_reg_index > 0x20)
-					return false;
-			}
-		}
+	for (size_t i = 0; i < settings->reg_num; i++) {
+		if (settings->reg_settings[i].i2c_reg_index > 0x20)
+			return false;
 	}
 
-	return result;
+	for (size_t i = 0; i < settings->reg_num_6g; i++) {
+		if (settings->reg_settings_6g[i].i2c_reg_index > 0x20)
+			return false;
+	}
+	return true;
 }
 
 static bool write_i2c(
@@ -1792,7 +1795,7 @@ static void enable_link_hdmi(struct pipe_ctx *pipe_ctx)
 			/* DP159, Retimer settings */
 			eng_id = pipe_ctx->stream_res.stream_enc->id;
 
-			if (get_ext_hdmi_settings(pipe_ctx, eng_id, &settings)) {
+			if (get_ext_hdmi_settings(stream->ctx->dc_bios->integrated_info, eng_id, &settings)) {
 				write_i2c_retimer_setting(link, is_vga_mode, is_over_340mhz, &settings);
 			} else {
 				write_i2c_default_retimer_setting(link, is_vga_mode, is_over_340mhz);
@@ -2209,7 +2212,7 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 			false);
 		if (masked_chip_caps == AMD_EXT_DISPLAY_PATH_CAPS__HDMI20_TISN65DP159RSBT) {
 			/* DP159, Retimer settings */
-			if (get_ext_hdmi_settings(pipe_ctx, eng_id, &settings))
+			if (get_ext_hdmi_settings(stream->ctx->dc_bios->integrated_info, eng_id, &settings))
 				write_i2c_retimer_setting(link, false, false, &settings);
 			else
 				write_i2c_default_retimer_setting(link, false, false);
-- 
2.43.0

