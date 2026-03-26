Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1713F109E543
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAC8510E941;
	Thu, 26 Mar 2026 03:02:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OrJ76GdU";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013010.outbound.protection.outlook.com
 [40.93.196.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0E5310E93F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:02:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qeS1kWFJqsGIciql3XXpOUhhHLAGE+sobaP8s4wYCWz6fwakGanog8WyI51QQBgGfwYX/wD0A5N9lh+OoC39ZFCgRJycQb1b3/MQG3pT3R0+cON2nKPiL/MPNZDldtXZ9qEMShIFCxNCKfCHFRk+zKvdWzDJTY/NA6SxEnWRb6rCI3JNUtyco2HmjdiOZE4o3OPLxyMRZ4MMLbBjAyR2Z4FXytSh8rRPsIhjYHn9kGTJM8bcd6aUXue8NHu+PPU3Gp2PvFVlJDKPo/QFbJf99fYTVRIBxxx03xIuFesK/8PZyhS1Gf0RlOvPSCi/Qfn+8DR4CtS4YPoCMHk85xm8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XUif1BHkbZtufMNJJVbH2kGWxOg8iKhJbsjoji2KVc=;
 b=upickG/qXz9mmwjWWp8ycERYGpkKhavvot+Zu1S9wqoSBN2mU9JcTk+RpPrUh2D5PdzoTr8HFXQOgYNnVoxf0BN3pQkfwflCyWBoWlEpkmAldA6a9fabc2yn5P38DJYPN6lh4O9GfYoadouYQOxlis4I6HGprrfaUgQkGMPN/v6L2PbL3Lig9AReGk8o7MjiWyaSGd//yRIZveiguuJsIweUcVbfGKdqSGhzusQfmADgrvk89WLRuUKsLQvJ/EuNb8oT4cqHsrqaELWfoKOWk3xSef0A5cNrREmkx9FfA8obC2VZ9Bj5nIXP9h3BBoUc6mUZSjvAleyw0y1MxAWNJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XUif1BHkbZtufMNJJVbH2kGWxOg8iKhJbsjoji2KVc=;
 b=OrJ76GdU8AI5AfdAoDCR9P68XcmvzS/xeP6a+Z3qaem+dri+szJnpoGuFLLwXaLexJpW5lwmexhBfDMTAJKayeFQbnEllPP4CErAnkoIAvVDyVk5AcxbC6qsAhC49HknwO3KMzjnspZmsVn8bvntCQ1L8P1hRE8dc7R+IJAjG+A=
Received: from BL1PR13CA0180.namprd13.prod.outlook.com (2603:10b6:208:2bd::35)
 by IA0PPF8CAB220A1.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 03:02:00 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::a3) by BL1PR13CA0180.outlook.office365.com
 (2603:10b6:208:2bd::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Thu,
 26 Mar 2026 03:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:01:59 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:01:55 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Ovidiu Bunea
 <ovidiu.bunea@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 22/30] drm/amd/display: correct unknown plane state patch
Date: Thu, 26 Mar 2026 10:57:13 +0800
Message-ID: <20260326030153.406612-23-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|IA0PPF8CAB220A1:EE_
X-MS-Office365-Filtering-Correlation-Id: 2290a109-6a5b-4c61-9ce0-08de8ae40c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: RycH6RWqPIXm21AnV2rhhTksngmLgF5wOI8qnWyMms5G6RtEW45UbuxqW4dBmuOZuYixud/k+/yPFW8TYJXrp1HU/Tq79H6WHkx2fvLO9VuZQWYiZ8Z5TKIhApRIBXoa16fuAAgwfWFkomZZuTyo6Vgvsw7jTNquyKusACCIjDYDQDyk1/e6Fz3XSLDy2kClnH8ljcLyuRGYyor1HfJVSCuVBLNTnMOjVEC//TAegvLjxbBvkCwybSPg0WQLDzfVjcZgJw9iJaDDcc7cd6IATv/Q34YeMWHwEnDPwZPNXShWZedfGiLuxvwOs+17UT5OIAlHsMa4MMQBy3E1Op5p78+7nM4Yq1B9E1x1ZjYcmFwHFnCXYENBoRmsZby75f7qJCg0WRXRTZcLW4TeHTxTsfxX/cKcgPvHq/Z/v9TDIulhAJ+UVcoz+kWCksdBmQBKrOHfKBqEEoG4Gzx8zrUyGZX51egT343aeebNp3ig3LjI0L0YOljLKdN81JtwdNAjHN6vUD9I6/0PSbOi32wRoVLoCmsleGoUiiB70hvsS37uqA7BhJqAtwWRHt9R4Qyv9pD/Vwny49t1nQ8y8lp3ciLAMV6veD0PPpr+JvfDgb9T4uSqhP/LwzalRRDWX46uJ05mSuiG0A1sYe0gA+S6hAAJrdIvZ/tChnQJ+vCUJXJGMtwZ3f+Cu4BB/boP2bsi94i8OxyTevwTANoM9sZVZV5/II+Fq6VWA3PlL/yqHDZtKyKvbCn3OzWW8AdOjWeWIsZ7wV1RKI4HzvD9LYLx3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EY1xjITrBTN1N88MSgUxDrfhXKBzMCPuXdHXaUHju+a0XF035r/k9iXoB6qfEZWvcbkQRt2RVw/fcYeKZPPCqAdibmYO2gJGpxH+1WWhRIiYtBerHTEdVMhhdBOXJq1uYQZidlLvMfSvvE83k0eC2SAiiMhQyKEd6lVUKVhwepAcNXeLexDPeMDXmLPALjHHW++jzvNzRvEDNdsN/1eFKilPKanVfYHhhpu01SHnX8rpm3JA3V+RbQcl8opFjoNU7PF93fOsI9vhPDIIUamJCubVL75qNa1IlhkHlL5TYsugRr15LxFkgRwbleD6vbSu0yAFwzTJf0o0DZgowvYdGyP9rAJsZbkNJrwWhzceMaCOiUDiSNJitnY3xm3P6LAshVEKcYo6mhNFOezO+4KcbxbhZ0rvYkBkA2+PUjCe1JPDdl1N5TnjzS0QpHKroLts
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:01:59.3727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2290a109-6a5b-4c61-9ce0-08de8ae40c24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8CAB220A1
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
dcn42x is using same gfx as dcn35, i.e. not use gfx_address3.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index f2a6e260f061..9d6a989d6dd2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -1785,7 +1785,7 @@ static struct resource_funcs dcn42_res_pool_funcs = {
 	.acquire_post_bldn_3dlut = dcn32_acquire_post_bldn_3dlut,
 	.release_post_bldn_3dlut = dcn32_release_post_bldn_3dlut,
 	.update_bw_bounding_box = dcn42_update_bw_bounding_box,
-	.patch_unknown_plane_state = dcn401_patch_unknown_plane_state,
+	.patch_unknown_plane_state = dcn35_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn42_get_panel_config_defaults,
 	.get_preferred_eng_id_dpia = dcn42_get_preferred_eng_id_dpia,
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
-- 
2.43.0

