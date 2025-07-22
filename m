Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B79C83F34
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DD4610E32C;
	Tue, 22 Jul 2025 22:39:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ckpww19B";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E860510E722
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFNfoHbFDolGMrNMmKKFyNM5nEM01ZPTB0AVwmWwUVm5LfjEtEC41JGEBehGyq7rhkElUbZKWBWw0VqabJgsbBrB4hpR+W8prbiR5T2hYFPI5u8pEa5Rl4gYOc7866J/Dq7+suDk+g7ZF7wNx4LzkX75eW4NCpieNBRs2LXsrynkCixOCJC9zPB4sviXJALGjWe3MpwuDBEOzR6AR2RjazHRvMOuhGotVndXBKfF/8yy8GgDpGUgtlmQP40BfOExoX5nthFA8DUoir0VOkiAHAiLEZUr/mz7UWGPtQ/icPjIrpdEwF9bHabpkO5wFrwwCL9Xu3OASgws6SFleIRpuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycQCflSl8t5NhTfx5CyiaoA2sQXsTjZETIpQXbAmos4=;
 b=IPX1pAPQYKqaftN8n1O9CRJd9qxnpLB/dvNXkmpymPrwszkFfW6Ru3IPI96vyttR8gdCf2toQOobkgth50IJs5KTdvlLRq5zXGRKXKOjJ0iAkhn3kmOX+1V8BBgZ1+GVU+GZ+ltmri3bSEl0RQJAkfZDt6PEIwQ2MW2iqs8JBjI76lTaVdOhw8DxIfXl+YcG35hT1v2OnSYghxX4/RtbS5hYpmNjpOF5cVMMJCUPd1jC7cbvr8OzY8oUXA6qhfR1S0giI8dOrd6uc8xS++0ZGN8D7XtlwgEz7hlOqCA9WtPZRP+DVwR1WcUzvaqgnZvxFYQ3l/NXwxYlXaWgziR9jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycQCflSl8t5NhTfx5CyiaoA2sQXsTjZETIpQXbAmos4=;
 b=Ckpww19B0dZqFzvqn1VDXtZ28Px4LnCTwlbT/vAupUV5D/pQkVETvhhmDaR3h7Oqgr1Y/smszlya25uKlFoROMRuiIQj1Sty0qTX8mVji9OCoR1uUUfXtv92lawXvyT7/Dy0KXMt332vLTlW9Ef6b7c6zKI1pIZeCrjzVaDF6hQ=
Received: from MN2PR05CA0027.namprd05.prod.outlook.com (2603:10b6:208:c0::40)
 by SA5PPFA403A61D8.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8da) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.42; Tue, 22 Jul
 2025 22:39:24 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::e3) by MN2PR05CA0027.outlook.office365.com
 (2603:10b6:208:c0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 22:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:39:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:39:18 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:39:17 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Jingwen Zhu
 <Jingwen.Zhu@amd.com>, Hansen Dsouza <hansen.dsouza@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 05/25] drm/amd/display: Add a config flag for limited_pll_vco
Date: Tue, 22 Jul 2025 18:36:11 -0400
Message-ID: <20250722223911.2655505-6-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
References: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|SA5PPFA403A61D8:EE_
X-MS-Office365-Filtering-Correlation-Id: a139db9e-4846-4b2c-2ed7-08ddc9709b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5BygrfDnjaYHCCiNkkt6U0DZMOnY+V38iUcvixBG3aQJg9nXm+vSk2wVtUlh?=
 =?us-ascii?Q?5HIBoJvz01h0YvM6ypF/89u0n9h+3C363ob/S8wjSDaeyGGDkWeOT+a8rgLz?=
 =?us-ascii?Q?T09ao4s6L/Fikb6tnbQtfxNJaTTaIC9RrDOPuJIcFUjudXI1b2RwaCPeyDhq?=
 =?us-ascii?Q?KRtu1GrwO1TiJXNM6VOYGXIRhU6qe92haC104iHgz/+VEMmWkNT0XZVO2ZeZ?=
 =?us-ascii?Q?EEsjNeOZZGTo1u1Je2qecmrc3EZf/Pve24HR8v1AgePiWyKPUnZcalZ58R4t?=
 =?us-ascii?Q?qW7uwiM909V1gFhuy9zvhI9xtq22EgJ3UuR1paUfqV7IkfyvUvg90/69Vudy?=
 =?us-ascii?Q?Kxs5qyxRBhb/neAmQXCkq72t7wTboSRSG4DJwEDYpcCd5OuL3V3irtTt/Foe?=
 =?us-ascii?Q?vhWZj1URFafjf3f773uFcaCOrmH8WmOYtkUOLNPJia8i2XbRAhUWGe2RXI9i?=
 =?us-ascii?Q?8QCbd65CdUnJhlJT2FPfsynz/npmj3krSbTztpupc4fopNIECKFBZcrEGyAs?=
 =?us-ascii?Q?SeGtaxeXtpcBwzos5/srmxfhw1FXFDo4JlL6OMUZEb1xNMjHtDFZnzEolq01?=
 =?us-ascii?Q?WFRxhFoz7peEqJx1zfgDUaxy41CWjWIUMJctovVWjElTiOutLBfWDNxr8fWP?=
 =?us-ascii?Q?ku14HnEFzYPEvSfTTYlMLS4rrt+dS0/M6SUIauoclwuNBR+VIph4RyxHJtTg?=
 =?us-ascii?Q?Vm6+i7cRsz6QBdr5ryRzeXfmd7eOXIrPvRqTISEjCdSpplhnqHrF3XW4RDK6?=
 =?us-ascii?Q?e8KGcATtVv3ymboeGVhWb+djH7j2sD9i/yPUCKhky5YBoTdFfWt2ksTkBCrY?=
 =?us-ascii?Q?oaDU7oYjNFtMs1pkNmCxYnzdZ9lRdUeSLkN1jlhnz2l7G9kpOomrhMaqTGHb?=
 =?us-ascii?Q?GJajjneA6X7VevNg6SRoSkVIhCsBjhYijIRbvlydk4/GzEK1gX0S3kBJw6V2?=
 =?us-ascii?Q?spBTiVcZmR39v2Wy8Fuz62gnWb6MPmXj8TArQnwKhzGC8zO+i9f9Oyv9wFmq?=
 =?us-ascii?Q?/dhhGUAJNgUSPrgvXSklKwBC+kt5lk/8Pq8I1WZsOjHQpjC6oycxoNh1au5v?=
 =?us-ascii?Q?UXLip9rzfR392Ql/2BRmp/RYUTI7t7wTl9gjFayGK5yIewGXe/2A5rI+rJCi?=
 =?us-ascii?Q?D2mnOzVBn2b71VlVahJ7A3s6mHFGu/w7ZCWGxSPkqhvjE/oGhDMmVwPj6aH2?=
 =?us-ascii?Q?3JN7U3FpP79jPLfdD3XH1afQC9OsYWusX80IegtHWU4P/H4fHR9MfUH82oEQ?=
 =?us-ascii?Q?xIDzZrDOkaFHHAUbcuXCiMU6u+RM7Z3tkqCAB1RCr4NcWvym+E2UrZtmE+D3?=
 =?us-ascii?Q?eKXgIvpV2U0bPNuFW+z0jxKZur+y2uz9TWwFerZOczUXCOsZpBPtrnwLlXI3?=
 =?us-ascii?Q?q6FL+yIckKk5YuFUpkfKQmG+f4tnKAH1/sa5v9MxxBfs3qahQN+UnyhWi40B?=
 =?us-ascii?Q?zQthtx7MqYdi6xz72liTHd3vszeHfSIPz7qMHACuDk6Bhxx9F11ae/aTBxK/?=
 =?us-ascii?Q?LjP5HncpLP0jJCVj7xIZg1joPVyC6axkdu2t?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:39:23.9782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a139db9e-4846-4b2c-2ed7-08ddc9709b96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFA403A61D8
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

From: Jingwen Zhu <Jingwen.Zhu@amd.com>

[Why/How]
Added a new config flag to pass to the DMUB during boot.
This workaround will solves black screen issue on reboot.

Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Signed-off-by: Jingwen Zhu <Jingwen.Zhu@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h       | 1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 3 ++-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 0bafb6710761..87b761ac3135 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -316,6 +316,7 @@ struct dmub_srv_hw_params {
 	bool disable_sldo_opt;
 	bool enable_non_transparent_setconfig;
 	bool lower_hbr3_phy_ssc;
+	bool override_hbr3_pll_vco;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a89bf08ffd37..e2e5f71c03f2 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -843,7 +843,8 @@ union dmub_fw_boot_options {
 		uint32_t ips_sequential_ono: 1; /**< 1 to enable sequential ONO IPS sequence */
 		uint32_t disable_sldo_opt: 1; /**< 1 to disable SLDO optimizations */
 		uint32_t lower_hbr3_phy_ssc: 1; /**< 1 to lower hbr3 phy ssc to 0.125 percent */
-		uint32_t reserved : 6; /**< reserved */
+		uint32_t override_hbr3_pll_vco: 1; /**< 1 to override the hbr3 pll vco to 0 */
+		uint32_t reserved : 5; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 3f38db752b84..4777c7203b2c 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -377,6 +377,7 @@ void dmub_dcn31_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	boot_options.bits.dpia_hpd_int_enable_supported = params->dpia_hpd_int_enable_supported;
 	boot_options.bits.power_optimization = params->power_optimization;
 	boot_options.bits.lower_hbr3_phy_ssc = params->lower_hbr3_phy_ssc;
+	boot_options.bits.override_hbr3_pll_vco = params->override_hbr3_pll_vco;
 
 	boot_options.bits.sel_mux_phy_c_d_phy_f_g = (dmub->asic == DMUB_ASIC_DCN31B) ? 1 : 0;
 
-- 
2.43.0

