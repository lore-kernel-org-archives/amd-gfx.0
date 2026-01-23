Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5D6D6CFD5
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 05:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97A4A10E181;
	Fri, 23 Jan 2026 05:57:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MpYU2/YB";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010047.outbound.protection.outlook.com
 [40.93.198.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BCF810E181
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 05:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6ly2T76LgA1+2Ux3TgRZAXbwDfUphJuJf7iMcXB7yu7EJroYAkV6L3lfwxPdwaXKOm2cceXVtC9nBSv9Js3q41af6UFN+XHSCV1hU1XcCU157WrsvyPSuYPeIAub5qkwGcZKA+CwjwaJcoRrI3iM5Ds6wFS0QUZBU5qY8rWkCqtdWFA4BQvQ3jPg72ymqHVuXmKo2StokJAdWT2mFLHL+mySKJPb3+hUYnhynXdpS1NJX6BoLvAOcHbJMhXXeyDhu7w7xR078nbyBnLpdOxUB76J4G/pFH+X4OVj+/89qDT7SVUgdVVikRnp7qlIy/kIxWw/KdlrgL6pIgwmQzMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8s5gupg0R+Ui9oy5YKn1klOnD/Ddi6DdTEkKTs8K+4=;
 b=KbYTcfsKwo+aI2tch2mBv2oKmLcYm7cH6l4KBUjaixYwO2M66IPtKGApYIShDUjuIzbtUgAtmryuVMgIX9kWGGQ4bbeRyydpjlvM6Jx9SUV8RJN0jHqzUzeeQsnHzMM8a/I7hmGBpAlR69YmQL0Wf9UQCERdt2re437StdeHKr5VqeJsqmP97VqjEiuzI5HVqvzaCVBTJVMWhnnWoeADE+rVspKC3GNScrBZBd2nZmg/aruW4RGyjF9BpEU54j37sp3C09ARJ8oUmE63aJsTqKMKslXu9YWZ8GPiVmbVAJrDqwMHuEQYs7ih4UqCOgPaaa1JzKiHpEEvjkOzODDE3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8s5gupg0R+Ui9oy5YKn1klOnD/Ddi6DdTEkKTs8K+4=;
 b=MpYU2/YBCxOMw4fG+EOQK1aKLZQY0V7nJ5/z2BMSOhsDcJlBJ9d/dQR6oGxX3EaNDvzzYlgF4FTm0Z56YHwWFQpTELpMOsCQ8CY9TIhBKXK30Wh3Pfyr99RR6vjVVptw8RiBdrTHShRF1eiTis+cVVCjsuyXNrx2KBugb2f4/0c=
Received: from SJ0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:a03:33e::27)
 by DM4PR12MB6350.namprd12.prod.outlook.com (2603:10b6:8:a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Fri, 23 Jan
 2026 05:57:08 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::e9) by SJ0PR03CA0052.outlook.office365.com
 (2603:10b6:a03:33e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 05:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 05:57:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 23:57:06 -0600
Received: from kenneth-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 22 Jan 2026 23:57:05 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <KevinYang.Wang@amd.com>, <Alexander.Deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: use debug port for mode1 reset request on smu
 13&14
Date: Fri, 23 Jan 2026 13:56:53 +0800
Message-ID: <20260123055654.3776-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|DM4PR12MB6350:EE_
X-MS-Office365-Filtering-Correlation-Id: 6666a9d0-977f-42f4-bae9-08de5a443ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oyPfGFYy8q6laFubu25TVcUCOtsVmzD5sDbUvaA0e+pXUPmgRPeJCDe4/gIa?=
 =?us-ascii?Q?C83HRPUAnmbk/YGwFwtQHLZ1nutkvqBJl1yEacHh1zi3cD6Fn5LvVdUwUDpJ?=
 =?us-ascii?Q?eOrHzDhVKySIjPp5jcEOPffi7mHyfCcivgqPZ0arzs2G3CY0opGCWeHToJJg?=
 =?us-ascii?Q?zWlezbkS1+iKMOBkH+kNPucVWpWKulvqlO1HjE8C0RawG2E3JFsuVzr/P200?=
 =?us-ascii?Q?h9F3S4dxD9arHbd5qdLl5sSATq78U4QtCujMEQmFVDWdthwx6onF4SJVGXW7?=
 =?us-ascii?Q?85ipgw1juLVYMnXUHYDPp0HOdif5CFRmmgHrS/F/pwKgidtmVmLkWnF/lC7L?=
 =?us-ascii?Q?A+FYOq6UlHeq09TKt8crHwWTUJxkIu6QjuFmlFkP+t34i3IODsp7F7PN/q3K?=
 =?us-ascii?Q?aWQBnF12l9WLUfCC6ukwoHhLNMzN/QRYavtilOIBRZWwRtKp9WH3D8HNB/Ch?=
 =?us-ascii?Q?Mcmf5oTL4dlzNjj+0EAsAnJuHO8ZwSJRdgF879z/5Ql2SfskiqJHayWEJOMF?=
 =?us-ascii?Q?7qyioPlyouP9V30FOxAD6EQTp9LcPg4oSDOQsD765rRrOSJAWn/CGnROYtgV?=
 =?us-ascii?Q?LpxPPr+OpIfF7c98bCeYH8KGVHPwzEoUm3E7Wq8Sa8cwNNkXujdW0Dis7xeT?=
 =?us-ascii?Q?OOBT5/oYiJ9HqNCBTXaW+XurVCGAxaIOEWKWwcCnR3fsXRlhMwo5RaYwo7rM?=
 =?us-ascii?Q?nz5UFaN1vQ98uJ4nkYQOGVE4qUuz0dK4u7y9Rk8rs2INQJb7NnXbq4Hf7Hfk?=
 =?us-ascii?Q?1PYcOjZRSa94cKWxmxosxQ9MyFMizurkb7j0vkR9Md9ZYj0d/4vIzbX4fwgk?=
 =?us-ascii?Q?berQ90sgQnaghm1ImuXPg5WgtXsIDTysNxdaCGYutVk+X2r2e1dic2FYSoJC?=
 =?us-ascii?Q?yKvDRtVy7/IzROlXxCEHbgoAKbtt+/pZVYBEC4orPsqJZ+V0aSh6S0F4Sr09?=
 =?us-ascii?Q?6srOQQPdFdt1kIredK0xuUUYKbTdYKKgODgXqEnfbYNMDOqFYt5QWSvLB91L?=
 =?us-ascii?Q?TMw1CTj+c0iY83i85osDipIJClqhXURF0r1OJ4XcnZQHv0hCWSVMH3VbXEer?=
 =?us-ascii?Q?0+93Nq+PECQu4WHdy7HJ3CTCPpmXMGRheF2DKexRTSiNjbg7iN/Fl0oRrYKD?=
 =?us-ascii?Q?C7wSvhPWn+QrpUgLvJexZB380FKdENA6q7SkQ8o6/DoTCS2ubgnHG+ig8/sV?=
 =?us-ascii?Q?zrzlPLNPeZV/Ol6rLVFIDPvxI5y1LyMwLKXvS9O5J9A+pagEWUGpofUuwSB3?=
 =?us-ascii?Q?A7UGtkyoM0Z+XRvCH/AT8BQ6yfrmj37chCRxRuz1oSqONaRBB4Gi0xYkDFzS?=
 =?us-ascii?Q?Qepo3A0WHJH2ei7S32ySbUFnF8klF/UKKpwLXsLXXdSSoZZyt6MPwTVBZNrc?=
 =?us-ascii?Q?MR4Q8skjOcGaeYvcNhXSxFLnpVRKj9dobaYZJQ+MQfwxNFdijJTd/TbsvbMG?=
 =?us-ascii?Q?rC14cslJoC/MNelv9+aShWqhOwobXkSELFRKJLr6ta8mQEO8n155bxPTEW5v?=
 =?us-ascii?Q?MgUuh9xhs1BEeZlQQ/kJcJ4tDGjTpyebo5n0sbVPwY83BuY8O8x5y1iPWMWQ?=
 =?us-ascii?Q?36qtRVR41Yrj+Dx0ExwXgQLPU4m01Bg1mL31WEnm/YE9rYcDdXVkbMJ5tqTy?=
 =?us-ascii?Q?FzqvWZmNO0HGPWgDShygU+0W0I0idpumzUhyhcmkkV9O?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 05:57:07.4201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6666a9d0-977f-42f4-bae9-08de5a443ddf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6350
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

use debug port for mode1 reset request so fw can handle mode1 reset
even when it is stuck.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 14 ++-----------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  6 ++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 21 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  6 +++++-
 4 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index ce52b616b935..d216db3b804b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2617,21 +2617,11 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	u32 smu_version;
-	int ret;
 
 	/* SRIOV does not support SMU mode1 reset */
 	if (amdgpu_sriov_vf(adev))
 		return false;
 
-	/* PMFW support is available since 78.41 */
-	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
-	if (ret)
-		return false;
-
-	if (smu_version < 0x004e2900)
-		return false;
-
 	return true;
 }
 
@@ -2830,8 +2820,8 @@ static int smu_v13_0_0_mode1_reset(struct smu_context *smu)
 		/* SMU 13_0_0 PMFW supports RAS fatal error reset from 78.77 */
 		smu_v13_0_0_set_mode1_reset_param(smu, 0x004e4d00, &param);
 
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						SMU_MSG_Mode1Reset, param, NULL);
+		ret = smu_cmn_send_debug_smc_msg_with_param(smu,
+						DEBUGSMC_MSG_Mode1Reset, param);
 		break;
 
 	case IP_VERSION(13, 0, 10):
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 1e82c43c851a..b8e202d702d3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3055,6 +3055,12 @@ static int smu_v13_0_6_link_reset(struct smu_context *smu)
 
 static bool smu_v13_0_6_is_mode1_reset_supported(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
+
+	/* SRIOV does not support SMU mode1 reset */
+	if (amdgpu_sriov_vf(adev))
+		return false;
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 0375e8484b2a..882316c15602 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -72,6 +72,8 @@
 
 #define MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE	0x4000
 
+#define DEBUGSMC_MSG_Mode1Reset	2
+
 #define PP_OD_FEATURE_GFXCLK_FMIN			0
 #define PP_OD_FEATURE_GFXCLK_FMAX			1
 #define PP_OD_FEATURE_UCLK_FMIN				2
@@ -2735,6 +2737,23 @@ static int smu_v13_0_7_update_pcie_parameters(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v13_0_7_mode1_reset(struct smu_context *smu)
+{
+	int ret;
+
+	ret = smu_cmn_send_debug_smc_msg(smu, DEBUGSMC_MSG_Mode1Reset);
+
+	if (!ret) {
+		/* disable mmio access while doing mode 1 reset*/
+		smu->adev->no_hw_access = true;
+		/* ensure no_hw_access is globally visible before any MMIO */
+		smp_mb();
+		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
+	}
+
+	return ret;
+}
+
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
@@ -2796,7 +2815,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.baco_enter = smu_v13_0_baco_enter,
 	.baco_exit = smu_v13_0_baco_exit,
 	.mode1_reset_is_support = smu_v13_0_7_is_mode1_reset_supported,
-	.mode1_reset = smu_v13_0_mode1_reset,
+	.mode1_reset = smu_v13_0_7_mode1_reset,
 	.set_mp1_state = smu_v13_0_7_set_mp1_state,
 	.set_df_cstate = smu_v13_0_7_set_df_cstate,
 	.gpo_control = smu_v13_0_gpo_control,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index faae1da81bd4..81635050b455 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1899,7 +1899,11 @@ static int smu_v14_0_2_baco_exit(struct smu_context *smu)
 
 static bool smu_v14_0_2_is_mode1_reset_supported(struct smu_context *smu)
 {
-	// TODO
+	struct amdgpu_device *adev = smu->adev;
+
+	/* SRIOV does not support SMU mode1 reset */
+	if (amdgpu_sriov_vf(adev))
+		return false;
 
 	return true;
 }
-- 
2.34.1

