Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662C7C54F30
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E864810E101;
	Wed, 28 May 2025 02:52:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1jnNERHD";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B311F10E0E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9jU6vaJFk9lH5JkCVJCozcX++Blga4kxThooH+dF3ms8+Xc+ZhpjtdPp28pnUqzMbYI8iTFapvs6zLLLKhiXWxey97m0RfzT9jIZbp5t690357Yu76GyDTjP6hhebpjlFVIB1FsbGkWFI/HfXAnfz5V78Ooo/EoUwMzVPH0jJXIQIHitL5JduGtyeK8j1g8NSBNXD2+IbKNugulVnJz+msCwai5cJUmX4tMHQmsLQVyao7ZUqiXegsTPUmJdS0RjnofNmLYAIce3lGP0bq5Jr99IL3eNE/KUwnMwj3J67MfqwcaVZssBSe9Wzx4W4cVNgkqd2pWyqZ0xQWPkXqHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcck87lXRjh4naxIiecZWcMGfZazU6TgHx3mN7JtIUE=;
 b=RCQiA55J+2FMwDZPUPty8NLj7+mmDDVOCXXnuVouTbW/GKJlXc6/mKLiSJ4TGrtUweCv/3U/O5hMzQsDq4Bfpsw93v2j9YF+wK8HPtanb/dw4kDVxwt1Dyhe5PiyvDvI7nO80dww+A+Ad8crA7NaQr8Iy5/syaQHpm2fGkb0hOBAnF0aurKGGwFQ+drw7TAHYOmFsCMn2EkqbqIy1+aUIiByQ4mcvE2TmyJk/ArAIhHL1xlZTqlR3DNwnaHoa6NkJUI/c7yyhdsypVS5kIgtBr0127lHJ8Sbv8e2S3XRcyosMNzLZJKaPz82WyitlACNr69sHmWYl6KDKLpY+8R0AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcck87lXRjh4naxIiecZWcMGfZazU6TgHx3mN7JtIUE=;
 b=1jnNERHDw79Sf8zo0aOP3zcwGDxridbQCWzfbkP5A2Wcbfebw0cIb7/otqUlEV+Rsade1Dm8jH9i0oX2h097jx/+wu8tFH70UYbzz1VKsYcWszIgHb71XS3hFcYB9wZSNkZzPbZ6lDbEzGgmaPvm5FF6Y1h37f4w1ZNiSEa2+pc=
Received: from BN9PR03CA0254.namprd03.prod.outlook.com (2603:10b6:408:ff::19)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Wed, 28 May
 2025 02:52:23 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:ff:cafe::1d) by BN9PR03CA0254.outlook.office365.com
 (2603:10b6:408:ff::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 02:52:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:52:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:52:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:52:21 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:52:17 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Taimur Hassan
 <Syed.Hassan@amd.com>
Subject: [PATCH 01/24] drm/amd/display: [FW Promotion] Release 0.1.11.0
Date: Wed, 28 May 2025 10:48:56 +0800
Message-ID: <20250528025204.79578-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: fd143c69-4dd1-4b07-8dbb-08dd9d92ab6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5mWfNXBjwIT6BghKVLvh/M9ngi5r7mxGP5OPfv1/ls19e8vGc41TV/oVp3h1?=
 =?us-ascii?Q?LxZdxUZoXcGAaRxLQeuySSs58YQQL03e/8/LobFX+IMfZhU4dd2Poav0kwgL?=
 =?us-ascii?Q?t6XoT1FRc1w2jKAmrbhpMSatLaU5EKdld+cl4061g+48E+/10eetitQ3t4HN?=
 =?us-ascii?Q?EzdDvwzc5Y5aNi/3MljIaQ6CFqWwsnXqmJcG5TL6JFfHYKWczMMK46F+T/gU?=
 =?us-ascii?Q?ycV3BCTagW09q19wrlTKX31AP0liz3efYTxa0iC6Kl6HB6tfU9kq6atWgKD4?=
 =?us-ascii?Q?XEcYpSGH7/Hvu31N6/UuQLeycf1Env+txd3DKeFSGOFB9epvtAC0RTsfYajS?=
 =?us-ascii?Q?Brmgc2CIQGmrTxmw5Rpi/lsroVDrx+DtOAKbwceniCiiw49obzuuRv8TlMLH?=
 =?us-ascii?Q?pf1RH2vYc+pVdooy7XkAbjZfQIK0bo4l3Ih7RcOl3O1M8oRL7puvj05l433P?=
 =?us-ascii?Q?BKZygG3cNuzth8uqhBOCR9e66femjzRosC6w841tt9EefO8fzV7iutJNzsms?=
 =?us-ascii?Q?kiNuiqNL4FDa8bi7D2O3GNBsahSAOtAwBDdEBCxwpUnF80BL+H1rNDTqi6Pv?=
 =?us-ascii?Q?Zl6/IZsyWuMmZ4Y0biHW+iTM5KRaf6JX/mBepy02es5syFIfWfg5wG4Jcheh?=
 =?us-ascii?Q?Vb5RYl4cN5xwY5BWF//IyjenjuUdmcMfYcIKT5U0+sdiBazQPLf4TTiETZqW?=
 =?us-ascii?Q?zburGgThiCtCrE8X+rEOj7HbSLMnTz2d9EK6YhVDVYVaMcpaI4ySqvUfeggu?=
 =?us-ascii?Q?G7C8NTvR3CFbztGPSnAlKnCw1pXCM3qooU5V74xhqHKPP9nTYCuM55fWjrE+?=
 =?us-ascii?Q?242xoNR1T47Gvy4WJ2+SyWak5Y5QMzFSoxlaLJ/wLnAs0pJg4NVSxNYhxw4U?=
 =?us-ascii?Q?RakEsff3ZaJ+x5Vm/I2rb3q8AIcm5vuuKjC98Q/G3MsiNeFooEpYjHW5nfsG?=
 =?us-ascii?Q?OxVTuaOBdex3sCxueFvxlGsme3icG3r/0NQhhViRgW52QYNV+qPk2s7Ldj2p?=
 =?us-ascii?Q?YvBLctgkqmOVBXZcDpXyPtlyxxSrcbFPzDdM5ApNxCF94IWKYxilEmRMBiLy?=
 =?us-ascii?Q?Y9V/cLzhMK8ZmU+1g1pssn5/5CLAxf5saDNm/AOPt+ZOX8HJhBQ36E68//dI?=
 =?us-ascii?Q?BGfq3m/pTFCpqW7yAHrj06UHvXzE0Mm/AhrubJxNtx0wQvUZFCF3wm8y9aN1?=
 =?us-ascii?Q?SPYphcGJUj1QproLYmHam7zngS9sRxnfhsqAu0USEGb4k/oMRsHiKNc4Om71?=
 =?us-ascii?Q?kM+cLufzQ3cYIC+C5+Y0dA3GVOtcQ314BXTbUcKcPlyCQyieTncc+sLUuKGF?=
 =?us-ascii?Q?h+NrYPqi486YdHQWUdENSzdvwC2eQ7hq/mZRBRCbFktE2p+uKchYISiNYsuK?=
 =?us-ascii?Q?SXLM1x+9GIdOvuDJ5Asjg02GoSlXsJ7447kD4Iyw+H48gwwxH4B4m1kjQvAe?=
 =?us-ascii?Q?WSuObDEbgllBXP0/bnDzUNdUbm5bePu7l1ziZ0a3zoarc3yKc0WO2iqMmkSM?=
 =?us-ascii?Q?2Lw7GnhMnOMZAAfPNsdYmKpz9hW0fqBK9hmh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:52:22.3052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd143c69-4dd1-4b07-8dbb-08dd9d92ab6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979
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

Refactoring some DMUB related structs and enum.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 34 +++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index b66bd10cdc9b..57fa05bddb45 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2139,6 +2139,11 @@ union dmub_cmd_fams2_config {
 	} stream_v1; //v1
 };
 
+struct dmub_fams2_config_v2 {
+	struct dmub_cmd_fams2_global_config global;
+	struct dmub_fams2_stream_static_state_v1 stream_v1[DMUB_MAX_STREAMS]; //v1
+};
+
 /**
  * DMUB rb command definition for FAMS2 (merged SubVP, FPO, Legacy)
  */
@@ -2147,6 +2152,22 @@ struct dmub_rb_cmd_fams2 {
 	union dmub_cmd_fams2_config config;
 };
 
+/**
+ * Indirect buffer descriptor
+ */
+struct dmub_ib_data {
+	union dmub_addr src; // location of indirect buffer in memory
+	uint16_t size; // indirect buffer size in bytes
+};
+
+/**
+ * DMUB rb command definition for commands passed over indirect buffer
+ */
+struct dmub_rb_cmd_ib {
+	struct dmub_cmd_header header;
+	struct dmub_ib_data ib_data;
+};
+
 /**
  * enum dmub_cmd_idle_opt_type - Idle optimization command type.
  */
@@ -2170,6 +2191,11 @@ enum dmub_cmd_idle_opt_type {
 	 * DCN hardware notify power state.
 	 */
 	DMUB_CMD__IDLE_OPT_SET_DC_POWER_STATE = 3,
+
+	/**
+	 * DCN notify to release HW.
+	 */
+	 DMUB_CMD__IDLE_OPT_RELEASE_HW = 4,
 };
 
 /**
@@ -2931,8 +2957,9 @@ enum dmub_cmd_fams_type {
 	 */
 	DMUB_CMD__FAMS_SET_MANUAL_TRIGGER = 3,
 	DMUB_CMD__FAMS2_CONFIG = 4,
-	DMUB_CMD__FAMS2_DRR_UPDATE = 5,
-	DMUB_CMD__FAMS2_FLIP = 6,
+	DMUB_CMD__FAMS2_IB_CONFIG = 5,
+	DMUB_CMD__FAMS2_DRR_UPDATE = 6,
+	DMUB_CMD__FAMS2_FLIP = 7,
 };
 
 /**
@@ -5926,8 +5953,11 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__PSP_ASSR_ENABLE command.
 	 */
 	struct dmub_rb_cmd_assr_enable assr_enable;
+
 	struct dmub_rb_cmd_fams2 fams2_config;
 
+	struct dmub_rb_cmd_ib ib_fams2_config;
+
 	struct dmub_rb_cmd_fams2_drr_update fams2_drr_update;
 
 	struct dmub_rb_cmd_fams2_flip fams2_flip;
-- 
2.43.0

