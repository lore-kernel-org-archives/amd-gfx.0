Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DFCC28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 05:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62A9910E6C8;
	Wed, 12 Mar 2025 05:47:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C60quNKG";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D05A10E6C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 05:46:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIHw5m55dejXUnhXE0vQoN+DB+WphckdyPX645HuLYWHuyaxAFn6gQJA2bQnlHb7bLAvhkm7hecG3hWe/yOwI/qAsquLrJHFVHk2NK/PeasHQ1/+BjEX9QfFaB5z9VyX8kWH/Je8bnqw9ZQIVIVIKplox1itctoJOypR2r8PXnINbEreZnOUAO7pdkvCCmBaOpWvgyWiO+weRS1CLgXCGTE9reI/4G0oxxZwhOuqi01LlEaOnQXGpjMIGxx53lns8qrmNKD3lA1bAuUBV+nIDFwn/kfT3b+/a7MZSat69T0q2dA2Hx7t/6ooLxrAp1AXRGXDdbpxlRmP/9QQchIjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVFJrw4WpsfQWsUUm6gNn9fs/U2DrW1ImnfDbFG8iU4=;
 b=r+GIj2vfiRin+vSCcvjczTSF3/GWJ7khidVBF0cwLkNfFgezeWUUUM0cT/0NoQWNH3JkxU3Rl6K+swbos68JJEcY1PL9DEHKkFl1w6M7O8Bw91GCckax85nqG7fZ8nYyutDkJmgg1ZTyTuG2zykIhfV+Wy8kFnUSplDMPokYbaFQEvK1lP4jRZaJLeFtY75ZWC3nmTqMJANWpqo+gwcVxFW6d/SoBA/tlS7cjH3B1DPgrHxPPDiyZKoZ2SSVQYV+rrXe3vMRs2/Ay1vEKkEISS17ehSNpWkyK/X6a41uHla4g+gSqObu57oFNqlF6FT+OXz/rOnpnXmY2QhzkeYciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVFJrw4WpsfQWsUUm6gNn9fs/U2DrW1ImnfDbFG8iU4=;
 b=C60quNKG0fuuzbGoZ99mkSrrWv2Ln3eF0Ju5CfQ6if18VvyS829aowWwplFurgQllcmb8M88fflgWUSDMHqAi3EqP1+5z8ov2KKjP3W/hbbvD07YZl5mBUPkLapEvGM/cXkfSD8xn+3VdQHMHjCLwM7EeTwHGpYHOaaqRdyygqE=
Received: from BL0PR02CA0112.namprd02.prod.outlook.com (2603:10b6:208:35::17)
 by LV3PR12MB9259.namprd12.prod.outlook.com (2603:10b6:408:1b0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 05:46:53 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:35:cafe::65) by BL0PR02CA0112.outlook.office365.com
 (2603:10b6:208:35::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Wed,
 12 Mar 2025 05:46:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 05:46:52 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 00:46:49 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: Update feature list for smu_v13_0_12
Date: Wed, 12 Mar 2025 13:46:30 +0800
Message-ID: <20250312054631.877303-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|LV3PR12MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e77859-7776-4a9f-10a4-08dd61294a75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TIxz/K6Tz1CkvdXQ1gF82zwhvyeZ25UPcrHg9EAjKjlCinQz543DaE0sK6Tt?=
 =?us-ascii?Q?nMBmAo2wHbx3FMwSSHDAQZJJcmcpGqDsiXuexK8ahtbTnfeHzFxQTHoAknyb?=
 =?us-ascii?Q?0OCPxfZjjKWhhwc3fioSIh1NFlzaMXnpeYKyLb7qFJlYamEZYHhV3dpZTP9R?=
 =?us-ascii?Q?EOIydO/zJHTYY4uL8oYaiG4IhOeUtQQUdBYROXXs0WbEly4p+fD1kZIUxwwI?=
 =?us-ascii?Q?SaA4w+GN3iD5kJq/nCCaWzbyQt+2baXgeLdfyxyBcdK0hEnWBwC5sG3Yjt1O?=
 =?us-ascii?Q?lpXQ4xYqttAMj3NYioZyBFXQ5lw+8l9wNzjiuhZDlrxRTuMuYiy7qsNZ2+ie?=
 =?us-ascii?Q?APxBpOhRgkx1wqD2WMdLWHcFG2uw0z7UCT92zl9CrkLGbqD7WUHwxJQMumzU?=
 =?us-ascii?Q?zcezSeJD9/g38YV9v6oE0R64yhovcRWf11H7BjwaUibwHs9k0dtV/d/zR+sn?=
 =?us-ascii?Q?fkZsTzT1G3iE+6Y7xLAhMgdtHJCtZ6lnNjBOVdhU5Ip/WqgT5IRHbpqM0xN0?=
 =?us-ascii?Q?VJuYYQN14KCMn9/DEbzJAC4/7oq7/DbrwRyowm7Log1LH8Yn8zS4oppq4Yas?=
 =?us-ascii?Q?YB8qd4mf2ao9nkArxkNRvgNcmNREjG+qkza7bNhdmY1KhgLD4oh7zWi+WSQH?=
 =?us-ascii?Q?6oQzQGn9FzZkK9RL6vdk4QVY+vWIDORkV9DlTza2FVq/XB+Mrta3/zVPSqVZ?=
 =?us-ascii?Q?HvA1ejrDp2r1KjEVzOmIEh0leedhfMqILS2/hYZ63vPG0VakZG6Mr4zFnlaK?=
 =?us-ascii?Q?qj0Zm70bUvKl2+eEOPWzp+dCivDPvjc6+yBA2kgV5jQg9SdnX7CFeYzpxLiz?=
 =?us-ascii?Q?/RH8nP3qb5Z/VFykLrtb1yp+s3K2KWAQ8yuFi4lyvXpMzqrytOKDLLWJhfpk?=
 =?us-ascii?Q?PyubYyg77gtrbyyRfVzffy1wBlPYDkluxDeCQ6HvM3q2/ek2Vns4fhVcNJnE?=
 =?us-ascii?Q?Dn75JyDD08byloumgO0Q48joVjHm7+QeRz7/DP7SZ4x5B8+cyidXDfaLq0Dr?=
 =?us-ascii?Q?ZjKYZk0/2XsQWyMa6oqXZjMtagvsOZKYmo4hMdt/owK3AK5nvywChmqxMWJd?=
 =?us-ascii?Q?50khI2z/RFevhZhVSfUUge/+Nzj+BuPqzLnihYWVfws62/e4Lng7X11o6HW7?=
 =?us-ascii?Q?Mq44s2LrDUv0wmXGwzFOnVr4T1Dl7cMk7hJBbComlHxaBMOb46B1hJYVLWWM?=
 =?us-ascii?Q?slHbkegNm7KBMi21ZQ5ADNOPCENY03RLkbf2gdwSLxZmCdaNUXnZQ1TAebbd?=
 =?us-ascii?Q?SWKh7L3TOxPFNNwbitYJbjgyvo8O/yOMqTgqQny66VXi9fvhmikz2O4ZgfCl?=
 =?us-ascii?Q?OK2JmBpMr+1XP+OY5Pu4rVmFq3EUiWx/tS0H0A6VTGTcLLnBdCxPFTkS7DJt?=
 =?us-ascii?Q?+Xe+eM/yXKM+ieuX/YgrHrPN0X5EKyAK+tMzDprxEdE7hRQwxVERQeKdvNse?=
 =?us-ascii?Q?4bwhMQbRtGqJ3EOEmikyAA8jHQt4cca0Rvxk2Se2v+kuIqW/Xb3v52mefRzQ?=
 =?us-ascii?Q?efkEgScu5xI4peM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 05:46:52.6749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e77859-7776-4a9f-10a4-08dd61294a75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9259
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

Update feature list for smu_v13_0_12 to show vcn & smu deep
sleep feature enable status.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h          | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 9c8468fb203a..c9dee09395e3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -356,6 +356,7 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(DS_FCLK),                       	\
        __SMU_DUMMY_MAP(DS_MP1CLK),                     	\
        __SMU_DUMMY_MAP(DS_MP0CLK),                     	\
+       __SMU_DUMMY_MAP(DS_MPIOCLK),                     \
        __SMU_DUMMY_MAP(XGMI_PER_LINK_PWR_DWN),          \
        __SMU_DUMMY_MAP(DPM_GFX_PACE),                  	\
        __SMU_DUMMY_MAP(MEM_VDDCI_SCALING),             	\
@@ -452,7 +453,8 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(APT_PF_DCS),				\
        __SMU_DUMMY_MAP(GFX_EDC_XVMIN),				\
        __SMU_DUMMY_MAP(GFX_DIDT_XVMIN),				\
-       __SMU_DUMMY_MAP(FAN_ABNORMAL),
+       __SMU_DUMMY_MAP(FAN_ABNORMAL),				\
+       __SMU_DUMMY_MAP(PIT),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(feature)	SMU_FEATURE_##feature##_BIT
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 285dbfe10303..51078accc0f8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -76,6 +76,11 @@ const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[SMU_FEATURE_COUNT] =
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_THERMAL_BIT, 			FEATURE_THERMAL),
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_SOC_PCC_BIT, 			FEATURE_SOC_PCC),
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT,	FEATURE_XGMI_PER_LINK_PWR_DOWN),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_VCN_BIT,			FEATURE_DS_VCN),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_MP1CLK_BIT,			FEATURE_DS_MP1CLK),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_MPIOCLK_BIT,			FEATURE_DS_MPIOCLK),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_MP0CLK_BIT,			FEATURE_DS_MP0CLK),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_PIT_BIT,			FEATURE_PIT),
 };
 
 // clang-format off
-- 
2.46.0

