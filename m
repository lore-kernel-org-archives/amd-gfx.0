Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A33D35660
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 01:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FBDA10E5E6;
	Wed, 28 Jan 2026 01:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GTIUHESs";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013001.outbound.protection.outlook.com
 [40.93.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A982310E5F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 01:59:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=le4RdNBJLgux2qUtEmMlu1+xbw6uhDuiugZw+ERjHAQk4s/PGp+46ajpU/1iE9R8vhctQsokgQGRawFeDqRoiJiUwLRU/i0LpCsM7fr4a9Lb3O2tTypWq3ISV9eeXPqm6mO5GOvCVBIqMhcAn/rRJqBUUfFNjfY1L15P6NdsNfapg2naQAEUV8dSOJHwTbTSTamR6xfVRtCvY7OduAnlV/cksLlf2m+37GUR7GFUS9dGHqmAzygzGINRtsbAVW00zetqJafisyzeWf1YcBCnehEF8ay1oMi7RzP9RLLU8Yt054uycY0p3CApP0BaA7tVqvoVUfHGkwmXeO24smyJWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7g68X0ANFjGoVy4YYEXFBTowf3zmb/9c50LxF6kfxs=;
 b=mH+thkzTndOfTOki11kqC0Ys656y8OC5Rn+Yt4sBigG9oc3T62vyo7zCn6qKhiNINiDPuXvczqjRDS2b9zPSMmVAOeDjrDT9bke9wV9NONCJfKUeJYBXS051AgcXVXgzr4ya01v/WDDB/AumKK4cEzRAZ+MJgVmG3KLTeEUJl7Znsca2jpL1KTE07g/CglsADupZeWtGKHBJHsK4wdwPsuijtqIsEY1yalx1U057+iD8ymXK0v7kkz2P9qDXEg1Uhpfbo+2ojQoEgJ7zFv7wlXbXkBCqGYrLV/ErADxsBT0zM7bhVylfSACEbF0N2Uu9v5sLXH9EIMeO4o7yQ13CAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7g68X0ANFjGoVy4YYEXFBTowf3zmb/9c50LxF6kfxs=;
 b=GTIUHESsk1EL3GbOWt71e9O9GckYcbuJnmIy5fXqQniJpIf8pK9LabhsYJWQZV/l5O6JmBzO79gyB3zQtiR55EF/NE5IOA9tljifp7cybif/+IUeSYhk3XvfKDLTC5XNfnc9HaqWcUJQBs+SYxdxSmgPivlVVyQ/fVpU0hdHD7Y=
Received: from BYAPR07CA0060.namprd07.prod.outlook.com (2603:10b6:a03:60::37)
 by DS5PPF482CFEB7D.namprd12.prod.outlook.com (2603:10b6:f:fc00::64a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 01:59:26 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::25) by BYAPR07CA0060.outlook.office365.com
 (2603:10b6:a03:60::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Wed,
 28 Jan 2026 01:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 01:59:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 19:59:25 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 17:59:24 -0800
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 19:59:21 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Ovidiu Bunea <ovidiu.bunea@amd.com>
Subject: [PATCH 04/21] drm/amd/display: Make DCN35 OTG disable w/a reusable
Date: Wed, 28 Jan 2026 09:51:29 +0800
Message-ID: <20260128015538.568712-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128015538.568712-1-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|DS5PPF482CFEB7D:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b83987-91df-4f95-33b0-08de5e10dd58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0DIuauwOmHAUPd1ynLJCMLUzLn6Awxud+tIMZsEB/ZfERuqSu+j0LV2WJwXT?=
 =?us-ascii?Q?v4q54TEYXNyDbGBykOXsqOdTGidMrqkt9EtvVDvzmVMsBmINg2WGqfxFmUfe?=
 =?us-ascii?Q?eXvVoNBAaOedgTECS+x14ylyiHr/RxhWbIJvj/6mnPAAHhIIuKAKlZsyFiEm?=
 =?us-ascii?Q?5UaggxN/ruaO28GIZ8qVzHXdrXpuhHcu1ABpv349boO5HIjfp8kBkR5MlQaH?=
 =?us-ascii?Q?n9LmyeITtGXi/rlM0+LEdBJuIwUIGI0akmGMtU9Ca23u6x3HneBoFQfL8bW3?=
 =?us-ascii?Q?F2z4YIcVsxf3GudYpru3jWM/JZNWAMJ0/pH01CfD+MXlxIiSVClO0Htdz5uv?=
 =?us-ascii?Q?sMzOLMVP4rdVzRy+BgQXL/PS70ArGgERLgiPnVugTNfK2jIndTVUIpExEDua?=
 =?us-ascii?Q?2++21qlsbWP0s4YcBKIHWerX+06FWGBtxvw5Asr6K0egGh25P0dOgXGfUrmw?=
 =?us-ascii?Q?lSuETLaznPeXyLY2QdrtPqZmh6dkzm02oIFMBeRQe9O/5RVl3Rd7NXnmYNeO?=
 =?us-ascii?Q?Ss0c5fvavWFTRz4GSF1UFB2u9xb6iw2D43e86BO7aHvEe6xysbMvnwPoxLRK?=
 =?us-ascii?Q?PH3q6JNhAiKkLK4ya6CQUYsaKffZcW0yuZSK0ARj2c+MJhQOb28wroGPP9B2?=
 =?us-ascii?Q?pDp9qU3WPIjJC5tYRvReQWeUSwkitfhdlVmfOKtyTXNgGx+bDsggQ+9gOThq?=
 =?us-ascii?Q?uQAPOlPKj2hADmhTH48Dh6Sa/aBjqgfbKjdlKvXFrLgUhi1t4P+84ZccLOBY?=
 =?us-ascii?Q?OQoWvsKA52FpEstIaLx0pDddCBnPzBA7bvNSLhF9TsCWAuL17tCLhBhJML+A?=
 =?us-ascii?Q?hB5gI3YkmZMYw65xoC2chIqOfRCPS0fz0j5gOp03Lc2eu/UKiMHkWFBGTGSV?=
 =?us-ascii?Q?ugCSD6OHMD1Kg4BLOFsTXpwPJkZEPjGYZ569iGq3r43wKtNX5iCr0x4mZ5ab?=
 =?us-ascii?Q?0UZx5jshtSB7SZ/xPh/vVzJk+Th4h2okbozYO0NXYwYnQ932XHl0w3AA8kq6?=
 =?us-ascii?Q?HO/z9kcQYR/lrLTTvXFuRA+b2YiSRaxjidjTYYAhsSqyae8U4re4EUoRS6pj?=
 =?us-ascii?Q?8OOktNGxjPTVTew048kvLfVKedtnSOu4FnXP1MRciz/Qe7f7Je3HeSM1dEfB?=
 =?us-ascii?Q?zINPv/jwVnegSi/xO82AHgYzD0vEva2I9KCd8fuIxt4OB37lONkcmw9Z2AJY?=
 =?us-ascii?Q?qAf6Z2/zNzzPD+7C0Nfqv3OnZhnoqXzQ7S/rh60f/LEhUKfR0EKTyQrS7MHC?=
 =?us-ascii?Q?O/cTZ1sFND+2UbGlS040IoGIMQIHI/SrNBV9kMbHJA7TPXIDBQef/WuLJK+A?=
 =?us-ascii?Q?3/m8b+FJq7hsox6Z/TlV3DswFcbskzHkxWrqsvtZ2WO67qhzqtC8uyHLvFEx?=
 =?us-ascii?Q?EVywgqdWXbGP/2GDct1oQ8in2d0cIhmIdlcM09RY96YRq9Blmbv+rpADULsV?=
 =?us-ascii?Q?HJ6A0QsusR3kWuGtQrp9l7kZDeJNos1lLcTmZj5uYk87LwWsYil7OwE99buZ?=
 =?us-ascii?Q?qmZU/ccFhb4oeOPOBNoUFMe+L5zarVYac1cflZZE+onCM64Tr9F3Ry03uyrD?=
 =?us-ascii?Q?ET7Oogn3nToeNa7yVgWpaq9DTsRk8zXNU1JpMKttnrQmYK5VFzR0CIwCeIQA?=
 =?us-ascii?Q?g8dEsgVSJO9M9ItlUakpdswGhl5bqgcV9bm1bBKTG094CsUIJ48Nz2nhKQvN?=
 =?us-ascii?Q?krQuug=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 01:59:25.7865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b83987-91df-4f95-33b0-08de5e10dd58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF482CFEB7D
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

The logic for the OTG disable workaround is particularly complex and
should be leveraged going forward instead of reimplementing and
maintaining it for multiple ASIC.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c    | 2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.h    | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 72558cc55a9a..7abe6811e4df 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -186,7 +186,7 @@ static int dcn35_get_active_display_cnt_wa(
 
 	return display_count;
 }
-static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context,
+void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context,
 		bool safe_to_lower, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.h
index a12a9bf90806..83e2263563fe 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.h
@@ -64,4 +64,10 @@ void dcn351_clk_mgr_construct(struct dc_context *ctx,
 		struct clk_mgr_dcn35 *clk_mgr,
 		struct pp_smu_funcs *pp_smu,
 		struct dccg *dccg);
+
+void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base,
+		struct dc_state *context,
+		bool safe_to_lower,
+		bool disable);
+
 #endif //__DCN35_CLK_MGR_H__
-- 
2.43.0

