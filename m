Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1AACFD65B
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E6EA10E644;
	Wed,  7 Jan 2026 15:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GnRphMRv";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010049.outbound.protection.outlook.com
 [52.101.193.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CE9F10E63F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:58:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZQ/9283ZTugAkC2mKqmBGnGmA7gYJJ5wLJ7sOyz0Tv7MkoFXGI1985ow6EgGcBY4CwjpJDzUGbwypis/t/koENCMm3JHEE5pK72glJ2qx6PcQCKSTsoB0/ECTBnSbq0K7rX9M80eO+W0LS8fsmRbQgZ/iqSm7yqUg/YSyMRtl3sxP4se4wug2Msrksncay6/uXLfMAbA5AD4kIJVvGXFSEC2pz9zKZ/cijg60P6EMlaOndqtDd7OArPFlSI14p5IydHA+O3zYTB8q8i4uMQF+96N8TwsrXSFuPUVCFnKSyzs8Yg/f9M7WT73+TaVWru2vfXf/l3fNwVolTSW//+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+PrnJfnoufS2rB1ow2e6727fBEVXqR5FcK3saF8XS8=;
 b=cKOWuJeBXZ9Rq2Iml1SgH2PnB1k2HIK2OkiJI5oAYD1Q/Sw5xpxgOrwuunPaEqusqgBX/oHgrXVrkFei0avIlgJjEzRn1eXcpChHkMANuZ1fPFGugCVOgDbjmSdtFrHxgUCLw6SVzQYYS/bssWyWt9YolxsHsRBBiAGLUa++zhDhToNaKFN/JqtIMvgRKMC0Xg1B3YIfIqD8EGKRU1Uy6vanhqWvHsLXDN469hDLVlAlQhREuAPy3XzWFIM87lMmBk76ks5Tlaqv7FavR0ZSbZ9aP7Ong/D93Jk9vcNt3/IgnJ+aDxCFukusmwN2Rn4Qi0jXFX+TsLQ2QIp/CKL+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+PrnJfnoufS2rB1ow2e6727fBEVXqR5FcK3saF8XS8=;
 b=GnRphMRvlMbiW+EznF5vOLogTty6AMjcBPsAML5a81xeproQzpickXi4CcBCHvy7zWbEHbvkUIm83WiERfDyY2to0YMtmCT8b1jBr0mc/NIzTe72JUbmxitTS/Sm85lJ3cnxCZL2cqTpOOacJ9l/3EhNq7QvFGTAnQupaY02ot8=
Received: from CH0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:610:b0::31)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:58:15 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::fa) by CH0PR03CA0026.outlook.office365.com
 (2603:10b6:610:b0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 15:58:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Wed, 7 Jan 2026 15:58:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 09:58:11 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 07:58:11 -0800
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:58:10 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>
Subject: [PATCH 20/21] drm/amd/display: [FW Promotion] Release 0.1.42.0
Date: Wed, 7 Jan 2026 10:48:12 -0500
Message-ID: <20260107155421.1999951-21-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: c0358cb5-2141-4a43-16d2-08de4e059126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hWOhMQgHKj3lWqeb23z3IqbmfUEYxOxXnCr1GPQkM7Bfzyl1u05WawkZTkfv?=
 =?us-ascii?Q?yrK5sCEK8XIKwwSVtF6VcnQ9BOCqnbNG1ddmxfL0JKeENfstsXZfE6YEePOc?=
 =?us-ascii?Q?bs1LgHBxUBPfYM0XqdZLm2GYOsdKHNUsLkW70ewvb8YRiU+cCBnDD1vPecHf?=
 =?us-ascii?Q?v/mmY+yzSO8HClOFnfYlbMQCweRrYoQ+cyeDtJ9+SMmsxsr9GJMqnVbgQuN/?=
 =?us-ascii?Q?evRb9a3d9y+DPrKEfLWJyXdCynNrPPu5j7IyXmmPaFlFyPM2T0AiqKr4XAKU?=
 =?us-ascii?Q?0bn4VGjyZfBVNsTib34zHj3dJxHub7oZtO8V1IsF5FqdQAGhpmdYBLgYjH+q?=
 =?us-ascii?Q?ylPDrFuMVGIqnG2XjmscjSA5ZlqUWn1PvO82EeK5+8i0qFkBehKqiFYCN8Hw?=
 =?us-ascii?Q?4JrSQH2d7ed0ZAllHx8FXjeMfSmFMIngSiXLed6tgniLkQv6mkbi47qs0+dE?=
 =?us-ascii?Q?AN+3pkP+KO7JyQkXN8pzo7GNJdZ2hOLmkBcbav2ZaoWTiSlDFwpZ74eCOLmq?=
 =?us-ascii?Q?7v+U+s3PxYrz/C4YwWNGT3xC1lQlwL8oPhp6RXh7G0g+CYzCRiDjfUHeQaY3?=
 =?us-ascii?Q?unSST0y7GLVXXR13vAWbG+NYgIkltpSPuc/31VOhlFdih35gb2RQBoOmeGkl?=
 =?us-ascii?Q?UqvG24tRlfZzXohSSHa4VptpDyNOOE4Q1YEFP7iThcdugxczUN8u8q02rDY2?=
 =?us-ascii?Q?qLnPiTAZvd1KD1sd6yxE79XGm/enKS/osKXXH6YDD2rJYW4EqYt7D0R8EaFK?=
 =?us-ascii?Q?ojl5wkCDZJj3r+Ub6g8w+0Yu5QFQ1w/ULfoKt+b7RI2o6n6ndSLNqC0D4nys?=
 =?us-ascii?Q?LCJZML9YbwoSi2TP32wTsEdmhi2H/2UzBWM24aZGkmkBVevXTIF0zhA4kSfb?=
 =?us-ascii?Q?/XN+Usb1YmMhmiOaiexLvZmSI0pROZ5wnSYTvAvt9x8Ofq6+HtEFSHEy/QwG?=
 =?us-ascii?Q?3ITjYnvmBLVeGCGDdJ9Zp5fJjmpwdJdE3f5j0jdjZZ6CWbL4FQTlS+GaSA6M?=
 =?us-ascii?Q?PpWVqg6gcXuK24OHlxPFK9EzVx0TQW0U1HhVVQFKiaxTH3jm/azVJDCAB9UU?=
 =?us-ascii?Q?DXo4gzka+C8mjrScGu5dJ9S0cK/ISJbsROV1E44ts2bQt70gI7Tw4IA0yH5T?=
 =?us-ascii?Q?xVnZ+8qROGHOneRAv3zaLdaXXznja7sfCz1N7d6ZhM4OetLv2kYlKXZSmyP5?=
 =?us-ascii?Q?+vsLQf2oeobfy5+7IOo8AULA8Umwy/lutkYGbtfPmfTKVwNOFM6A0bwnSIjc?=
 =?us-ascii?Q?reUfbrfyLepvh+YmooyLwhgm33QTWYeupUaLAOHzt0I/pGNe53lFaKILO1te?=
 =?us-ascii?Q?huF+IMDdI0lXySX/UFbRiJbRs/R9hQ1QeALd3u1tMCSHIvcGgLajkG1nt/8X?=
 =?us-ascii?Q?mdc8BPvvlOfQEwi4z1zjSL6YxaKV6dIZXY312gCZQgJQim8PKo3o23mR5VLL?=
 =?us-ascii?Q?YvthEknP0iwxIBWaXDYn+fkNWf0WX0ALIn9sumUu1PvGBtKMADxyn0wPJnHu?=
 =?us-ascii?Q?mJ5u7NAr2l3c0nuN/FmZ6TqaZ5Qy5tlm16Ck0A+kAphFnK9sd24K+gmyG6si?=
 =?us-ascii?Q?Yc0SOadWmt5D3mC2KWM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:58:14.9657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0358cb5-2141-4a43-16d2-08de4e059126
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Summary for changes in firmware:

* Fix 24/30FPS full screen video low residency
* Fix 60Hz video playback freeze
* Add Panel Replay command for VESA replay

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 87ae63cb0815..cf23c57faf2b 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1091,7 +1091,10 @@ union dmub_fw_boot_options {
 		uint32_t lower_hbr3_phy_ssc: 1; /**< 1 to lower hbr3 phy ssc to 0.125 percent */
 		uint32_t override_hbr3_pll_vco: 1; /**< 1 to override the hbr3 pll vco to 0 */
 		uint32_t disable_dpia_bw_allocation: 1; /**< 1 to disable the USB4 DPIA BW allocation */
-		uint32_t reserved : 4; /**< reserved */
+		uint32_t bootcrc_en_at_preos: 1; /**< 1 to run the boot time crc during warm/cold boot*/
+		uint32_t bootcrc_en_at_S0i3: 1; /**< 1 to run the boot time crc during S0i3 boot*/
+		uint32_t bootcrc_boot_mode: 1; /**< 1 for S0i3 resume and 0 for Warm/cold boot*/
+		uint32_t reserved : 1; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
@@ -2638,7 +2641,7 @@ union dmub_fams2_global_feature_config {
 		uint32_t enable_visual_confirm: 1;
 		uint32_t allow_delay_check_mode: 2;
 		uint32_t legacy_method_no_fams2 : 1;
-		uint32_t reserved: 23;
+		uint32_t reserved : 23;
 	} bits;
 	uint32_t all;
 };
@@ -4375,6 +4378,7 @@ enum dmub_cmd_replay_general_subtype {
 	REPLAY_GENERAL_CMD_UPDATE_ERROR_STATUS,
 	REPLAY_GENERAL_CMD_SET_LOW_RR_ACTIVATE,
 	REPLAY_GENERAL_CMD_VIDEO_CONFERENCING,
+	REPLAY_GENERAL_CMD_SET_CONTINUOUSLY_RESYNC,
 };
 
 struct dmub_alpm_auxless_data {
-- 
2.52.0

