Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42916E77198
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC34410EB08;
	Tue,  7 Jan 2025 15:30:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xLutPTMK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4F3810EB08
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:30:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6zBBDU+eYE+lkQC9I4al2u/1y0YtKnPe80dZ+vOeP7Fije8zZ6vmRkZ8EhPbWv/2wGGLbZ1/9UMgWI9TkanNbbDKNB5E8eWu05CQ6q713A1Xpy4TBWfyeXyFm0qgqomYJnr/hD5Qodif12RleJQGEmOvMG04KTgBw+6QiFkGoUl+p8ugTaAbNBew4k0hx70hINjCeXJOJqGJQbnzDEV6R5MGM6iJlW2iUqTp6/6FBLJ49ImlPK7d+H/s5y+eLKePwvO9V4O0VeWl2tiSU+/OSxS2fpEBOxW4+MeWvwjJ1jWFpSFXudSxljgFcDR4i9d/Vln5CHWAbYJWLj4s5QOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmM4/h4trxM6iwj9zwZaEbOUIqXL+B7McuDq5lq7CVA=;
 b=xifa79ab8+52fUrcbLtr/kF/m56yJtUXuVxVfQNGLb2qV3VAbOV6wxE1vZbjAWGTjHG87Q8XTI5MEivjoUbg6F5eVEnqDUHKI7LSt2O+nQESqRJcRw/JGvYKv8D9L9F17jG5uWAlNGusdOjd3+Mxz2z6zRVmpJdla2XOcc8H1Be017PFmySHWwJ0q6qyokCfGORzOVife9y3hLgPfOA4z1MFz0gMsr8YhrLDpufcDXW+Arax0La2cL7NMF/2Izysy5X+0yFI4nsACWjXKK+jMIzKMTsSs2qfFCJkuoiLU4c8LDeEukmE+VZt8BTotvSLNOUDyLpVVBsuAm6lqe0kPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmM4/h4trxM6iwj9zwZaEbOUIqXL+B7McuDq5lq7CVA=;
 b=xLutPTMKfTtzyT5JVyTq7k+wv447Y8MgRskOWHw4j34ZFL0G50aEE3h3Ncr8Gc9Y64zSthvj8pDoxDV/+NjZV8+zjUdFTK+lAB7FEPK+mul2i7aBHvvJ6vtj4zKnBq+0YqquQTVSSC41UnVbASm0+EmbKItyb5wx7aY5k6QlJ8U=
Received: from BL1PR13CA0119.namprd13.prod.outlook.com (2603:10b6:208:2b9::34)
 by SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Tue, 7 Jan
 2025 15:30:15 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::dd) by BL1PR13CA0119.outlook.office365.com
 (2603:10b6:208:2b9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.9 via Frontend Transport; Tue, 7
 Jan 2025 15:30:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:30:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:14 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:14 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:30:10 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Nicholas
 Susanto" <Nicholas.Susanto@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 13/24] Revert "drm/amd/display: Enable urgent latency
 adjustments for DCN35"
Date: Tue, 7 Jan 2025 23:28:44 +0800
Message-ID: <20250107152855.2953302-14-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|SA1PR12MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b99fc6-de98-4548-3b5d-08dd2f302f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZnNU1IJsk29XcSCImwnOH9nj62lBkKWFsG3xOBgShYr5gjx2775yaAJTO69Q?=
 =?us-ascii?Q?dK2vL1FtH7+njJn3f6Uo9X4efGVEl47e1XThylQJV7k+7yRxkeu76J8qfmQW?=
 =?us-ascii?Q?Yb8Rw7ajiecnKkzbZ5scIk8gdxdjMMDK0BK00gvrQOOGo5oym+qahdTjMNTe?=
 =?us-ascii?Q?grS+PXQecHlCwq+fMeFsqz3RbNl2PJI1qtNoFGW5TOV5MyVUKQ0bQ2dXMwEd?=
 =?us-ascii?Q?B6zAu5t7tSwlvrYNGdc2eYr8mBZ8phtJA5Sgrv+yF4jya5WNrsfMGC9hNu2r?=
 =?us-ascii?Q?GAN83HyT7yriK7iSfdNks0FL4/4myKu712Fc8nm3D/jlOtKw3YPkftJT6t0y?=
 =?us-ascii?Q?BTuGJbvtYe5Z/p/EsuhkErdIB0iviwxYH1OI3LK53/hnjJ9jOaZQxX/KwUqM?=
 =?us-ascii?Q?BzNOHVwsVyuceOM1ItIo+HdXxq8l04tVRBxbVfTv+aCh5yMAkbHHI3VWmT2w?=
 =?us-ascii?Q?Z860+7rhzGCxiTzQJeGPX8SUlAxkbc5Gbfz7maB/3kHxKbXkjrcIPTUpzL4e?=
 =?us-ascii?Q?UnanJkWxv6wz9a5GOYOzWfODssc6tbqNccseL5n2CcjcIeuaj2hXHXbZYvyD?=
 =?us-ascii?Q?M3ZtUznrwOU1GsVhI7e26BerVzWppGElXQzkk8KPMZCF0w8Kb4hy3y8OA097?=
 =?us-ascii?Q?qJG+Jky2YtL7fPxy9tPSn9P+h8HfOTD3osgZLIC7M1BSjvZbaH98r2pJVGpl?=
 =?us-ascii?Q?XfzkP++q6ODC9dyPO0ymUYaO7AasIDw+O8vhXcajuWPtKJX+4E1947PkUYaY?=
 =?us-ascii?Q?1pol5dAp8kro9+wwHt2x8FUN2XEbvG1eyVB0V4M6BuNLy7/y+V9c1PR3gsWs?=
 =?us-ascii?Q?kYQ9c19R8oQ6vkXk9J3mtZL/y+EOVqOgRxVzKqui9/pFpn9ecwaiy7TuTZqT?=
 =?us-ascii?Q?dlyorl7SFhX/wZWBzm09TEJTmCpygo5mFa4KOqt72LHn7t9PFDpjVIUjuQZZ?=
 =?us-ascii?Q?IG+JVUt0PfaQ55u+OEINm5VGOG19d6yMV5QaS8fBL3AdWR4iBlzH0CcfCHCH?=
 =?us-ascii?Q?dz3nGi9bOjOX8hwt3ruTKH9RfL2J3avF/d2Zn1h9KsDaiLgnbwK7RBFaVXMf?=
 =?us-ascii?Q?b8Ek9lDY4a+5QA9Pn4ucuclqqDfoEmWco3NWwt1wd4UcnRKD7r3w2yTD4ayC?=
 =?us-ascii?Q?zD60T/JD78cgNchcMO0I/2wA05s6HESiHvS0GU/QBAklQ9SJbrUEeb8uCqQH?=
 =?us-ascii?Q?GRG7nQLpaD4xM0xdFkmLANIoM/sx0ooBcA/AYHY9ESB1czGcewDBy1H/mJa/?=
 =?us-ascii?Q?BwoEjA/kn+9m6PGZE0aGTee4VKGUxkpOvGWnsUfsUiEhIjmQnstqXDlVu01j?=
 =?us-ascii?Q?Tb++X5TGSRdKmq17mL2chfAWsKugTUCEiX6/dT2/YlNwrepxcTd6Yk1aZdZr?=
 =?us-ascii?Q?ygLlO9Xvbemlu6b184d/GhKEOShSzwhoyT0eMgkb2ow7sD8ts2+yj1S9BrqM?=
 =?us-ascii?Q?+jTbNBl+kAuyLyaakBb91/diML2Pfq6JGPMDQIlXC9xSGm+SXA9J1Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:30:15.0119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b99fc6-de98-4548-3b5d-08dd2f302f0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822
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

From: Nicholas Susanto <Nicholas.Susanto@amd.com>

Revert commit 284f141f5ce5 ("drm/amd/display: Enable urgent latency adjustments for DCN35")

[Why & How]

Urgent latency increase caused  2.8K OLED monitor caused it to
block this panel support P0.

Reverting this change does not reintroduce the netflix corruption issue
which it fixed.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Nicholas Susanto <Nicholas.Susanto@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index beed7adbbd43..47d785204f29 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -195,9 +195,9 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 	.dcn_downspread_percent = 0.5,
 	.gpuvm_min_page_size_bytes = 4096,
 	.hostvm_min_page_size_bytes = 4096,
-	.do_urgent_latency_adjustment = 1,
+	.do_urgent_latency_adjustment = 0,
 	.urgent_latency_adjustment_fabric_clock_component_us = 0,
-	.urgent_latency_adjustment_fabric_clock_reference_mhz = 3000,
+	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
 };
 
 void dcn35_build_wm_range_table_fpu(struct clk_mgr *clk_mgr)
-- 
2.34.1

