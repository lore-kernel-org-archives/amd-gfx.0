Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB0EC83F34
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3482B10E735;
	Tue, 22 Jul 2025 22:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VS5gkxie";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7461C10E726
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:46:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrBbRq8M1AMj2GyMtIhWWgh0NJvj/raOSf8PxY6nekNIQO8MHI6Kc5xd2O2De8ivTEUEhyZX/iLb7KMlFw8GfdQgmUSGxB4BCjhsIs4ThC8F1753ifvVrwFS6VpRXR6mDyOIXqojvofbUSnY7Y9VOsPgvLkl8LipSw94LAt3/j+JGQletd8vAkUmsbJSks7sTWHq7XI1QJrroy0y+e13zH6SnVHUOecGwmp6wlDwmIWUiVaTanbjEcZzJqBQwVHFk5CKRenCaWDOyYmfqHf4vZHElQS8TmrcAHOoim//TALOdbbR29VvvG12iTx1OHFe4/C8noxY1tzURvFq7uqRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAXWXlNw6kJMtUzgRdmAGEeAY0lp8dLSOZDHIqubexE=;
 b=DQxyQZwImLKedxKugvMraHc6Cl+ipOicVW3baq1sRQcg670EwIAVfA6qciOMNwQZIgMdrAnC83jaxRaK3U3KO2fYPowYcnYmI4F4zakiX+0Ejf9lGqw0JpD+9GRu5Tun1ZIVy42S4SLfk8wlWNE2Om9bhqPfeQaYosqFZ9FLm+W44OEAaa0v9q051x8LxXD30M1Enr7R7i6sAUTulNc0GZSSt9sFP+VDRRry4Zujlan/9eX/vyBV3CK4bTsNMIMo8bzuIfsfOvNO/4CxPCvBSvFePKOHR4E4NOMl21oH8Lw90IGqAj55H6SIkED99UU5rXDHqdFPqBMIoA8Sg1x1PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAXWXlNw6kJMtUzgRdmAGEeAY0lp8dLSOZDHIqubexE=;
 b=VS5gkxieD8qKYHzK0ScYftCc4civwhJkbFbvFEcAkf/zASij+WLxil1G73cOQhLoIleLw6uc/SceHfZ426ftLuoZ0iM2ox+h5imFUXkekOTdbKQX7kAl++0HJn6GQ+Y5l1zAw8I+umZ3a4RHOsktE0CkjDG0KiYH/kCKtiuNy30=
Received: from SJ0PR03CA0200.namprd03.prod.outlook.com (2603:10b6:a03:2ef::25)
 by PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.32; Tue, 22 Jul
 2025 22:46:09 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::e9) by SJ0PR03CA0200.outlook.office365.com
 (2603:10b6:a03:2ef::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 22:46:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:46:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:46:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:46:07 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:46:06 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Ovidiu Bunea
 <ovidiu.bunea@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 21/25] drm/amd/display: Revert "Add a config flag for
 limited_pll_vco"
Date: Tue, 22 Jul 2025 18:44:30 -0400
Message-ID: <20250722224514.2655899-21-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
References: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|PH7PR12MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b7bda6-cb7e-4e1f-2464-08ddc9718cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nZuDoCSPRzuZ/HILI/lO6iAT4mohaA/vzv4OQcl5WQFwEjL16qrx1U8qw0K9?=
 =?us-ascii?Q?teHuommOPJqA7tY02l6MtTu68cWOEtxaN+Op2qWHyYQ2I9m7WG9w8IkLlqCn?=
 =?us-ascii?Q?LbZwRifYOsknyE4/GvVbazZJcKMk5pLD5p7prf/4/KflW/jy/yaMXL2t4Egm?=
 =?us-ascii?Q?wmWz8ex+7l9Sq0zi0FUr5YTXvOyXjE9j4DCBwim9rUgEopI9tX63vKMOl7VF?=
 =?us-ascii?Q?a7jNPoG/kljN0D+Zs0w/BEGglHPn9VMP0sqsDpTCwul7OPQGdAzMyS5rTYqN?=
 =?us-ascii?Q?tyFMswzTbr9LT4oxHFtV8vPLPjq34FjKHfmJwbD/CFvhiWg9Qb3OCEkvU1qq?=
 =?us-ascii?Q?VMvUV2OYa8KWvKopB6F/OpsCl9n3rVBRDZpcXmyRFuuJjTLhcSNFr8zCV4eW?=
 =?us-ascii?Q?o7QamCvlJqL8cYiXtLXTonnoEQ3DIFQHwfXVPqfkwc0mD8xWvlKTc1zr0nIU?=
 =?us-ascii?Q?BkGSkZl7fkYyt0Rx3Tm4L42L92jrMhi6cPVhD/Fcn9rJpXigmHj6KCGi9ryu?=
 =?us-ascii?Q?wFRDusunS2Cu1Ai5RZ37yBZoiQyBfgCgTSELxK27pBNI9UKaTC192eeKzwGI?=
 =?us-ascii?Q?6Njn6Ft+3Q/qCXZWMaZKeO+/QLqwoEiKZj+WUKYDljz5/Aj5UMliOKhz5Loq?=
 =?us-ascii?Q?H1en6W3r4elTcNa/QryUh/ZR76qlD7aPxXVVjfnaLZw5/VusMcrxfU8nuSZ0?=
 =?us-ascii?Q?Q6QaCVNqcChqVP3zHqoUzi8DqOZdKl4hyFKbfP4cqUkYnk0mEqm/dxQbFiK9?=
 =?us-ascii?Q?RxpGScHeAVlBVIU0757QFazsWTWwEkdcxIcfOlA7doCRt4X0lpS1pyM2nsD3?=
 =?us-ascii?Q?y/Vw3YnMB0dta4tS+B9F2Wn9Mqahf6IM3eLcdASpvc4x7ISA1LCqClfS7Y09?=
 =?us-ascii?Q?QKVWRqN8faGpQLN3rMgjHAFUwL+AI82sGTNA76X3VXVZvgF1tadUuO3pHoGi?=
 =?us-ascii?Q?JjsqkSjdMWsAPq+a8PG9hjnKXZY+ogOS/mPiHgApEU0MCMDOv7GYH+M6LjOB?=
 =?us-ascii?Q?7o9oxMn1UMMqpRr3xYl3IHIXNJubMK6o042lP/7GGn6Wbu7Bj8v/ti0OD/bQ?=
 =?us-ascii?Q?pLdqT8PfzLTwlibVME5eU0i9ZnpdzdANcJb0jnaHMWZwlCBo2IWxucHWUW35?=
 =?us-ascii?Q?qjjadpZEhVWhD8tQO0H1EukmlZLfUufqoFZwAX5Tz81EfQb6evCaDzHswTaj?=
 =?us-ascii?Q?JzkrmCfaNfmAyg8CkkqlaboFYRMGUYqoTLsxLFY+5UUaXPaQfVl+i62Fw+Db?=
 =?us-ascii?Q?+jPpBrSL1g1YoccKGwHOgeX2eomSLT3e/6OmxEkEQ1QbIHFL0m6Als8AZUAp?=
 =?us-ascii?Q?vFXk50UpE24ArhH1vfihfXrX8pXMBT6OuOGa0SCXbgfnjZpDybpo1P3ybcTq?=
 =?us-ascii?Q?H6VGT44+ZQxVMVi7wUgmcJ2GKRld7JNwDEa7QdCOBVUmXWY6oM24S+hUCCtX?=
 =?us-ascii?Q?JLh8qyF6oVhEMXhn5P2NhKwENat+MEGg5VDGUENVOpr9e4+BHY0da4OZeFR3?=
 =?us-ascii?Q?YaWqoqrI+c+/LGc6a5aQgsH1gmKeNBxmcUSY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:46:08.8432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b7bda6-cb7e-4e1f-2464-08ddc9718cf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5757
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

This reverts commit c97eef97dd74

[why & how]
DMUB header changes should be submitted to firmware branch first and
allowed to propagate to driver. Currently, this change breaks linux
builds so need to revert it until it's ready.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h       | 1 -
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 3 +--
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 87b761ac3135..0bafb6710761 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -316,7 +316,6 @@ struct dmub_srv_hw_params {
 	bool disable_sldo_opt;
 	bool enable_non_transparent_setconfig;
 	bool lower_hbr3_phy_ssc;
-	bool override_hbr3_pll_vco;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index e2e5f71c03f2..a89bf08ffd37 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -843,8 +843,7 @@ union dmub_fw_boot_options {
 		uint32_t ips_sequential_ono: 1; /**< 1 to enable sequential ONO IPS sequence */
 		uint32_t disable_sldo_opt: 1; /**< 1 to disable SLDO optimizations */
 		uint32_t lower_hbr3_phy_ssc: 1; /**< 1 to lower hbr3 phy ssc to 0.125 percent */
-		uint32_t override_hbr3_pll_vco: 1; /**< 1 to override the hbr3 pll vco to 0 */
-		uint32_t reserved : 5; /**< reserved */
+		uint32_t reserved : 6; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 4777c7203b2c..3f38db752b84 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -377,7 +377,6 @@ void dmub_dcn31_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	boot_options.bits.dpia_hpd_int_enable_supported = params->dpia_hpd_int_enable_supported;
 	boot_options.bits.power_optimization = params->power_optimization;
 	boot_options.bits.lower_hbr3_phy_ssc = params->lower_hbr3_phy_ssc;
-	boot_options.bits.override_hbr3_pll_vco = params->override_hbr3_pll_vco;
 
 	boot_options.bits.sel_mux_phy_c_d_phy_f_g = (dmub->asic == DMUB_ASIC_DCN31B) ? 1 : 0;
 
-- 
2.43.0

