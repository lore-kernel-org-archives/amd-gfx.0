Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B77BC02180
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 12:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E22610E1A7;
	Thu, 16 Jan 2025 12:29:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yfp/cLiv";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67D8C10E583
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 12:29:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNSiU8WysHMKTNoT9Be9Tk4/X2kXt5Oa2f/eu6oDCjA/CUuf6zJ268eKQssUh0D638bSRntP+XpFuoaZ5xNC5LT95RfUJLPfWzS1RxgP8rHZyXmM5cjOf6LzzukNi8RokkRBAJeX/Es4XviQtpz1eGajGYYbML7i4BIrQ20bj2CuH33F4bucWhT8rZR2836BVgEYC2hPXhvzbUkBWmMePU3nOaKS6uIAbwJOls61Tw/Ki6RN1xS8InUkyyAEysRzVlZjMjeM1U/Sqny7jkxCFu12f6p8islvRuqccBRBRtb0gfVjhzyc3Ixv2LFhIUwYh5/MBAkTcAQDRYRHi45JLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7Jz/E/REGT0aJaBs7wc5jcsnm/6x4Znd94HLNerrz4=;
 b=HZ89cwe6uq0hY8PRttibw94o/rqHBmuVjr4t6yZCEqLStT8413rw9HlNLhW6vfxbyTG/6Bg0fbGwirLjjviBXinnKZ4pwmmon5N+YqfhpDZRPifFBqprK+epNFB4/WJIae2wKhPGnHvmT8UI6knXWxHtYV029k2cXKK37V9skEXXJbbIf6/juL4ywOxNMjhn12QUO8L6hrHBmhYxv80wHufbrYFHjNsYKghSR+BHpSMH7Rbw9OBcqm2nI9Ju4s/NHt2ksHcSGWUiuWupx4Q0EAvIjHrIWvTvDcXCf0uJL3lh0UrnWuKPBrZKlJ4bmq/oKqpup9iKkDlnVmTQyDnmUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7Jz/E/REGT0aJaBs7wc5jcsnm/6x4Znd94HLNerrz4=;
 b=Yfp/cLiv7GkoUoAKQnUydy+z9q21So7dpFE5U3UQuPsHK4cvOH7LmLFYZkr+ztPvb0713kkBQ7ZtEPgrFypCO3R0+FWWrX/ut/yPXcWpl8ummsY5+/ObkUeJ3iw0vH3IJvexXK1dgi+XqJPCyBHxYqeeoZuLndO7J8vRa2sZ+pM=
Received: from CH2PR04CA0024.namprd04.prod.outlook.com (2603:10b6:610:52::34)
 by SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 12:29:26 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::e8) by CH2PR04CA0024.outlook.office365.com
 (2603:10b6:610:52::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Thu,
 16 Jan 2025 12:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 12:29:25 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 16 Jan
 2025 06:29:23 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Add capability flags for SMU v13.0.6
Date: Thu, 16 Jan 2025 17:59:08 +0530
Message-ID: <20250116122908.1451094-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|SA1PR12MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: 57fde150-a96e-4465-3862-08dd36296a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X/p8Vj8LnvZ4PlqMFlydy02Qqno+L6BRCYRr94xfgXyk1DOzKj+NoqSmcUUz?=
 =?us-ascii?Q?ZHDz77R3QV5rtlj3w5+5aRI9gTobhJOk69Z5ait/rq/Rmrpr5Z4olsImShtk?=
 =?us-ascii?Q?zsZU3AN2Oh3wFL9BTXfdzEcBrVoMrjfgIDhY8okGSwz9/tCsdRmv3zSSmsnx?=
 =?us-ascii?Q?Kg92tpH+FEjX2bmmCJlYp9UOEHOouops6W10Q7EgA94YBc9hdEydbOqBqNgd?=
 =?us-ascii?Q?7JQAvmW8kXTthgbS26p5SVCnLIEtq5zTqtBdOqkXwVyqo0WPzqiQd0EmxVPN?=
 =?us-ascii?Q?8Fy7JisIX4On/E2sTl1oHzqdDcuCf3qG4bMsWVDP7h1DVgQP/x0i7Q5OZxUL?=
 =?us-ascii?Q?KhB9ZSzGGdVXqnHZLEvJ5ce9EyC/GKVrkT5MDYB6R8tkE4bfAI95MXdcwpG7?=
 =?us-ascii?Q?m+z1o64wLzBKqN7RJ+4XjHIBiWzXJAYvxhwZk5BZrBd0jbssjZJ4pSHF2T5G?=
 =?us-ascii?Q?CRYOQLy+dlMGRdQhsOzOFQUb+lLYYZQHnVqf+UusIicYPU95V5Ep3NBF01Qc?=
 =?us-ascii?Q?uHOnmoNI/JBcy+jQcwXsCzG77MGAsjLOGfhqG3DYSi6tU2LCy9Mm3rSk+SBR?=
 =?us-ascii?Q?wcdW7ct4U1VHCc3VypW/s5H/HlRFbwrtiqNXmYaMaa/C2W/DEfRCO2xO3sIS?=
 =?us-ascii?Q?Qgu5UGQPnY7EIp2tGNj8Ey2ubZhUAzWWdP5rpdNA05ObolerX6Hx7NNr5ncv?=
 =?us-ascii?Q?SBQkxou+w6vBMeF6+tyI8sjA1tvcvhoMo8gjo4ur/rISnmzYtIoMzrclIUV9?=
 =?us-ascii?Q?p0//BOcAJG0okdmuCP0si/8RE69V1fdKTKrgSFyVw1jMltcRlazpJ59h0Q8J?=
 =?us-ascii?Q?IwYnt9QIVIExk4M4Xq0iqrhR5PepAR+/wrcugilZKHCsHZ/xuRyg1qReJAs9?=
 =?us-ascii?Q?Nv1jncKHeO2uIWSR5XBCWECY1pwwKHX41Uqs7IbSt0JrH6W4b3/yAbg+VHmF?=
 =?us-ascii?Q?cIEDuJAbsF5f5X40RFUcnCb3/OETxRcc76BLSiraD7J96y//1lUN41y1h8u3?=
 =?us-ascii?Q?NKSyEyrNZ86G9jTfyBK+FswQXTrohPDVLvH7tUIHua1iPxkXDepmGt6byVZI?=
 =?us-ascii?Q?jDW0ri6WZaCrdwSirIsCy8W4DHLIxSORWkno2w+OiVlzJJeaUTyPTgR09T60?=
 =?us-ascii?Q?zAONgt5FY3MNfB6ZYmjXXo14B5H6nXbCz3BWJUjDp4ZfDpl/r/kOltZYzDgl?=
 =?us-ascii?Q?IR039rgO3M78t3kQF28E6i9+CqZ8BM4ROzgxkPGBcp6zKjVQCK400D2uimwH?=
 =?us-ascii?Q?MLtkUSIGlH2l1ycPC8/qkoZyVnSihF4/7oQZig0fIiVOTltM/MyQkNbaWXjV?=
 =?us-ascii?Q?LwLNafkptMD7wP6NLbulsxBtM4JKH4n/KefEFl8H1qmDpGzf7LbschOqE4Hj?=
 =?us-ascii?Q?CqCzyVkf3WG+TfVtc9QEew6Bhd3ipXpJHDENT+lX2HVCSFE+hvjrHOEj1SZ3?=
 =?us-ascii?Q?GeN/h6NGFdOquuf8d98d6jiva0qUGAgl1Bk+xG/7/exR7Ki+ZaiX/pOe59E0?=
 =?us-ascii?Q?bZZhH7khPeHLVbE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 12:29:25.8408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fde150-a96e-4465-3862-08dd36296a2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821
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

Add capability flags for SMU v13.0.6 variants. Initialize the flags
based on firmware support. As there are multiple IP versions maintained,
it is more manageable with one time initialization caps flags based on
IP version and firmware feature support.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 225 ++++++++++++------
 2 files changed, 158 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 356d9422b411..8d4a96e23326 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -107,6 +107,7 @@ struct smu_13_0_dpm_context {
 	struct smu_13_0_dpm_tables  dpm_tables;
 	uint32_t                    workload_policy_mask;
 	uint32_t                    dcef_min_ds_clk;
+	uint64_t                    caps;
 };
 
 enum smu_13_0_power_state {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index c12959a36d78..56e26fcd3066 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -101,38 +101,25 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_14.bin");
 #define MCA_BANK_IPID(_ip, _hwid, _type) \
 	[AMDGPU_MCA_IP_##_ip] = { .hwid = _hwid, .mcatype = _type, }
 
-static inline bool smu_v13_0_6_is_unified_metrics(struct smu_context *smu)
-{
-	return (smu->adev->flags & AMD_IS_APU) &&
-		smu->smc_fw_version <= 0x4556900;
-}
-
-static inline bool smu_v13_0_6_is_other_end_count_available(struct smu_context *smu)
-{
-	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
-	case IP_VERSION(13, 0, 6):
-		return smu->smc_fw_version >= 0x557600;
-	case IP_VERSION(13, 0, 14):
-		return smu->smc_fw_version >= 0x05550E00;
-	default:
-		return false;
-	}
-}
-
-static inline bool smu_v13_0_6_is_blw_host_limit_available(struct smu_context *smu)
-{
-	if (smu->adev->flags & AMD_IS_APU)
-		return smu->smc_fw_version >= 0x04556F00;
+enum smu_v13_0_6_caps {
+	SMU_13_0_6_CAPS_DPM,
+	SMU_13_0_6_CAPS_UNI_METRICS,
+	SMU_13_0_6_CAPS_DPM_POLICY,
+	SMU_13_0_6_CAPS_OTHER_END_METRICS,
+	SMU_13_0_6_CAPS_SET_UCLK_MAX,
+	SMU_13_0_6_CAPS_PCIE_METRICS,
+	SMU_13_0_6_CAPS_HST_LIMIT_METRICS,
+	SMU_13_0_6_CAPS_MCA_DEBUG_MODE,
+	SMU_13_0_6_CAPS_PER_INST_METRICS,
+	SMU_13_0_6_CAPS_CTF_LIMIT,
+	SMU_13_0_6_CAPS_RMA_MSG,
+	SMU_13_0_6_CAPS_ACA_SYND,
+	SMU_13_0_6_CAPS_SDMA_RESET,
+	SMU_13_0_6_CAPS_ALL,
+};
 
-	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
-	case IP_VERSION(13, 0, 6):
-		return smu->smc_fw_version >= 0x557900;
-	case IP_VERSION(13, 0, 14):
-		return smu->smc_fw_version >= 0x05551000;
-	default:
-		return false;
-	}
-}
+#define SMU_CAPS_MASK(x) (ULL(1) << x)
+#define SMU_CAPS(x) SMU_CAPS_MASK(SMU_13_0_6_CAPS_##x)
 
 struct mca_bank_ipid {
 	enum amdgpu_mca_ip ip;
@@ -297,6 +284,119 @@ struct smu_v13_0_6_dpm_map {
 	uint32_t *freq_table;
 };
 
+static void smu_v13_0_14_init_caps(struct smu_context *smu)
+{
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	uint64_t caps = SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
+			SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
+			SMU_CAPS(PCIE_METRICS) | SMU_CAPS(CTF_LIMIT) |
+			SMU_CAPS(MCA_DEBUG_MODE) | SMU_CAPS(RMA_MSG) |
+			SMU_CAPS(ACA_SYND);
+	uint32_t fw_ver = smu->smc_fw_version;
+
+	if (fw_ver >= 0x05550E00)
+		caps |= SMU_CAPS(OTHER_END_METRICS);
+	if (fw_ver >= 0x05551000)
+		caps |= SMU_CAPS(HST_LIMIT_METRICS);
+	if (fw_ver >= 0x05550B00)
+		caps |= SMU_CAPS(PER_INST_METRICS);
+	if (fw_ver > 0x05550f00)
+		caps |= SMU_CAPS(SDMA_RESET);
+
+	dpm_context->caps = caps;
+}
+
+static void smu_v13_0_6_init_caps(struct smu_context *smu)
+{
+	uint64_t caps = SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
+			SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
+			SMU_CAPS(PCIE_METRICS) | SMU_CAPS(MCA_DEBUG_MODE) |
+			SMU_CAPS(CTF_LIMIT) | SMU_CAPS(RMA_MSG) |
+			SMU_CAPS(ACA_SYND);
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t fw_ver = smu->smc_fw_version;
+	uint32_t pgm = (fw_ver >> 24) & 0xFF;
+
+	if (fw_ver < 0x552F00)
+		caps &= ~SMU_CAPS(DPM);
+
+	if (adev->flags & AMD_IS_APU) {
+		caps &= ~SMU_CAPS(PCIE_METRICS);
+		caps &= ~SMU_CAPS(SET_UCLK_MAX);
+		caps &= ~SMU_CAPS(DPM_POLICY);
+		caps &= ~SMU_CAPS(RMA_MSG);
+		caps &= ~SMU_CAPS(ACA_SYND);
+
+		if (fw_ver <= 0x4556900)
+			caps &= ~SMU_CAPS(UNI_METRICS);
+
+		if (fw_ver >= 0x04556F00)
+			caps |= SMU_CAPS(HST_LIMIT_METRICS);
+		if (fw_ver >= 0x04556A00)
+			caps |= SMU_CAPS(PER_INST_METRICS);
+		if (fw_ver < 0x554500)
+			caps &= ~SMU_CAPS(CTF_LIMIT);
+	} else {
+		if (fw_ver >= 0x557600)
+			caps |= SMU_CAPS(OTHER_END_METRICS);
+		if (fw_ver < 0x00556000)
+			caps &= ~SMU_CAPS(DPM_POLICY);
+		if (amdgpu_sriov_vf(adev) && (fw_ver < 0x556600))
+			caps &= ~SMU_CAPS(SET_UCLK_MAX);
+		if (fw_ver < 0x556300)
+			caps &= ~SMU_CAPS(PCIE_METRICS);
+		if (fw_ver < 0x554800)
+			caps &= ~SMU_CAPS(MCA_DEBUG_MODE);
+		if (fw_ver >= 0x556F00)
+			caps |= SMU_CAPS(PER_INST_METRICS);
+		if (fw_ver < 0x554500)
+			caps &= ~SMU_CAPS(CTF_LIMIT);
+		if (fw_ver < 0x00555a00)
+			caps &= ~SMU_CAPS(RMA_MSG);
+		if (fw_ver < 0x00555600)
+			caps &= ~SMU_CAPS(ACA_SYND);
+		if (pgm == 0 && fw_ver >= 0x557900)
+			caps |= SMU_CAPS(HST_LIMIT_METRICS);
+	}
+	if (((pgm == 7) && (fw_ver > 0x07550700)) ||
+	    ((pgm == 0) && (fw_ver > 0x00557700)) ||
+	    ((pgm == 4) && (fw_ver > 0x4556e6c)))
+		caps |= SMU_CAPS(SDMA_RESET);
+
+	dpm_context->caps = caps;
+}
+
+static inline bool smu_v13_0_6_caps_supported(struct smu_context *smu,
+					      enum smu_v13_0_6_caps caps)
+{
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+
+	return (dpm_context->caps & SMU_CAPS_MASK(caps)) == SMU_CAPS_MASK(caps);
+}
+
+static void smu_v13_0_x_init_caps(struct smu_context *smu)
+{
+	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
+	case IP_VERSION(13, 0, 14):
+		return smu_v13_0_14_init_caps(smu);
+	default:
+		return smu_v13_0_6_init_caps(smu);
+	}
+}
+
+static int smu_v13_0_6_check_fw_version(struct smu_context *smu)
+{
+	int r;
+
+	r = smu_v13_0_check_fw_version(smu);
+	/* Initialize caps flags once fw version is fetched */
+	if (!r)
+		smu_v13_0_x_init_caps(smu);
+
+	return r;
+}
+
 static int smu_v13_0_6_init_microcode(struct smu_context *smu)
 {
 	const struct smc_firmware_header_v2_1 *v2_1;
@@ -616,7 +716,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 	MetricsTableA_t *metrics_a = (MetricsTableA_t *)smu_table->metrics_table;
 	struct PPTable_t *pptable =
 		(struct PPTable_t *)smu_table->driver_pptable;
-	bool flag = smu_v13_0_6_is_unified_metrics(smu);
+	bool flag = !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRICS));
 	int ret, i, retry = 100;
 	uint32_t table_version;
 
@@ -812,8 +912,7 @@ static int smu_v13_0_6_set_default_dpm_table(struct smu_context *smu)
 	smu_v13_0_6_setup_driver_pptable(smu);
 
 	/* DPM policy not supported in older firmwares */
-	if (!(smu->adev->flags & AMD_IS_APU) &&
-	    (smu->smc_fw_version < 0x00556000)) {
+	if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(DPM_POLICY))) {
 		struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 
 		smu_dpm->dpm_policies->policy_mask &=
@@ -990,7 +1089,7 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	struct smu_table_context *smu_table = &smu->smu_table;
 	MetricsTableX_t *metrics_x = (MetricsTableX_t *)smu_table->metrics_table;
 	MetricsTableA_t *metrics_a = (MetricsTableA_t *)smu_table->metrics_table;
-	bool flag = smu_v13_0_6_is_unified_metrics(smu);
+	bool flag = !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRICS));
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 	int xcc_id;
@@ -1003,7 +1102,7 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
 	case METRICS_AVERAGE_GFXCLK:
-		if (smu->smc_fw_version >= 0x552F00) {
+		if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(DPM))) {
 			xcc_id = GET_INST(GC, 0);
 			*value = SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency, flag)[xcc_id]);
 		} else {
@@ -1692,7 +1791,7 @@ static int smu_v13_0_6_notify_unload(struct smu_context *smu)
 static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu, bool enable)
 {
 	/* NOTE: this ClearMcaOnRead message is only supported for smu version 85.72.0 or higher */
-	if (smu->smc_fw_version < 0x554800)
+	if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(MCA_DEBUG_MODE)))
 		return 0;
 
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,
@@ -1837,9 +1936,8 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
 			if (max == pstate_table->uclk_pstate.curr.max)
 				return 0;
 			/* For VF, only allowed in FW versions 85.102 or greater */
-			if (amdgpu_sriov_vf(adev) &&
-			    ((smu->smc_fw_version < 0x556600) ||
-			     (adev->flags & AMD_IS_APU)))
+			if (!smu_v13_0_6_caps_supported(smu,
+							SMU_CAPS(SET_UCLK_MAX)))
 				return -EOPNOTSUPP;
 			/* Only max clock limiting is allowed for UCLK */
 			ret = smu_v13_0_set_soft_freq_limited_range(
@@ -2043,7 +2141,7 @@ static int smu_v13_0_6_get_enabled_mask(struct smu_context *smu,
 
 	ret = smu_cmn_get_enabled_mask(smu, feature_mask);
 
-	if (ret == -EIO && smu->smc_fw_version < 0x552F00) {
+	if (ret == -EIO && !smu_v13_0_6_caps_supported(smu, SMU_CAPS(DPM))) {
 		*feature_mask = 0;
 		ret = 0;
 	}
@@ -2336,11 +2434,10 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
 
 static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
 {
-	bool per_inst, smu_13_0_6_per_inst, smu_13_0_14_per_inst, apu_per_inst;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v1_7 *gpu_metrics =
 		(struct gpu_metrics_v1_7 *)smu_table->gpu_metrics_table;
-	bool flag = smu_v13_0_6_is_unified_metrics(smu);
+	bool flag = !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRICS));
 	int ret = 0, xcc_id, inst, i, j, k, idx;
 	struct amdgpu_device *adev = smu->adev;
 	MetricsTableX_t *metrics_x;
@@ -2348,6 +2445,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	struct amdgpu_xcp *xcp;
 	u16 link_width_level;
 	u32 inst_mask;
+	bool per_inst;
 
 	metrics_x = kzalloc(max(sizeof(MetricsTableX_t), sizeof(MetricsTableA_t)), GFP_KERNEL);
 	ret = smu_v13_0_6_get_metrics_table(smu, metrics_x, true);
@@ -2421,7 +2519,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 		 * table for both pf & one vf for smu version 85.99.0 or higher else report only
 		 * for pf from registers
 		 */
-		if (smu->smc_fw_version >= 0x556300) {
+		if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(PCIE_METRICS))) {
 			gpu_metrics->pcie_link_width = metrics_x->PCIeLinkWidth;
 			gpu_metrics->pcie_link_speed =
 				pcie_gen_to_speed(metrics_x->PCIeLinkSpeed);
@@ -2450,7 +2548,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 				metrics_x->PCIeNAKSentCountAcc;
 		gpu_metrics->pcie_nak_rcvd_count_acc =
 				metrics_x->PCIeNAKReceivedCountAcc;
-		if (smu_v13_0_6_is_other_end_count_available(smu))
+		if (smu_v13_0_6_caps_supported(smu,
+					       SMU_CAPS(OTHER_END_METRICS)))
 			gpu_metrics->pcie_lc_perf_other_end_recovery =
 				metrics_x->PCIeOtherEndRecoveryAcc;
 
@@ -2475,17 +2574,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	gpu_metrics->num_partition = adev->xcp_mgr->num_xcps;
 
-	apu_per_inst = (adev->flags & AMD_IS_APU) && (smu->smc_fw_version >= 0x04556A00);
-	smu_13_0_6_per_inst = !(adev->flags & AMD_IS_APU) &&
-				(amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
-				 == IP_VERSION(13, 0, 6)) &&
-				(smu->smc_fw_version >= 0x556F00);
-	smu_13_0_14_per_inst = !(adev->flags & AMD_IS_APU) &&
-				(amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
-				 == IP_VERSION(13, 0, 14)) &&
-				(smu->smc_fw_version >= 0x05550B00);
-
-	per_inst = apu_per_inst || smu_13_0_6_per_inst || smu_13_0_14_per_inst;
+	per_inst = smu_v13_0_6_caps_supported(smu, SMU_CAPS(PER_INST_METRICS));
 
 	for_each_xcp(adev->xcp_mgr, xcp, i) {
 		amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
@@ -2516,7 +2605,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 				gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
 					SMUQ10_ROUND(metrics_x->GfxBusyAcc[inst]);
 
-				if (smu_v13_0_6_is_blw_host_limit_available(smu))
+				if (smu_v13_0_6_caps_supported(
+					    smu, SMU_CAPS(HST_LIMIT_METRICS)))
 					gpu_metrics->xcp_stats[i].gfx_below_host_limit_acc[idx] =
 						SMUQ10_ROUND(metrics_x->GfxclkBelowHostLimitAcc
 								[inst]);
@@ -2624,7 +2714,7 @@ static int smu_v13_0_6_get_thermal_temperature_range(struct smu_context *smu,
 		return -EINVAL;
 
 	/*Check smu version, GetCtfLimit message only supported for smu version 85.69 or higher */
-	if (smu->smc_fw_version < 0x554500)
+	if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(CTF_LIMIT)))
 		return 0;
 
 	/* Get SOC Max operating temperature */
@@ -2726,11 +2816,10 @@ static int smu_v13_0_6_smu_send_hbm_bad_page_num(struct smu_context *smu,
 
 static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret;
 
 	/* NOTE: the message is only valid on dGPU with pmfw 85.90.0 and above */
-	if ((adev->flags & AMD_IS_APU) || smu->smc_fw_version < 0x00555a00)
+	if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(RMA_MSG)))
 		return 0;
 
 	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_RmaDueToBadPageThreshold, NULL);
@@ -2750,18 +2839,17 @@ static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 	smu_program = (smu->smc_fw_version >> 24) & 0xff;
 	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
 	case IP_VERSION(13, 0, 6):
-		if (((smu_program == 7) && (smu->smc_fw_version > 0x07550700)) ||
-			((smu_program == 0) && (smu->smc_fw_version > 0x00557700)))
+		if ((smu_program == 7 || smu_program == 0) &&
+		    smu_v13_0_6_caps_supported(smu, SMU_CAPS(SDMA_RESET)))
 			ret = smu_cmn_send_smc_msg_with_param(smu,
 				SMU_MSG_ResetSDMA, inst_mask, NULL);
 		else if ((smu_program == 4) &&
-			(smu->smc_fw_version > 0x4556e6c))
+			 smu_v13_0_6_caps_supported(smu, SMU_CAPS(SDMA_RESET)))
 			ret = smu_cmn_send_smc_msg_with_param(smu,
 				      SMU_MSG_ResetSDMA2, inst_mask, NULL);
 		break;
 	case IP_VERSION(13, 0, 14):
-		if ((smu_program == 5) &&
-			(smu->smc_fw_version > 0x05550f00))
+		if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(SDMA_RESET)))
 			ret = smu_cmn_send_smc_msg_with_param(smu,
 				      SMU_MSG_ResetSDMA2, inst_mask, NULL);
 		break;
@@ -3087,7 +3175,7 @@ static bool mca_smu_bank_is_valid(const struct mca_ras_info *mca_ras, struct amd
 	if (instlo != 0x03b30400)
 		return false;
 
-	if (!(adev->flags & AMD_IS_APU) && smu->smc_fw_version >= 0x00555600) {
+	if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(ACA_SYND))) {
 		errcode = MCA_REG__SYND__ERRORINFORMATION(entry->regs[MCA_REG_IDX_SYND]);
 		errcode &= 0xff;
 	} else {
@@ -3373,9 +3461,10 @@ static int aca_smu_get_valid_aca_bank(struct amdgpu_device *adev,
 
 static int aca_smu_parse_error_code(struct amdgpu_device *adev, struct aca_bank *bank)
 {
+	struct smu_context *smu = adev->powerplay.pp_handle;
 	int error_code;
 
-	if (!(adev->flags & AMD_IS_APU) && adev->pm.fw_version >= 0x00555600)
+	if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(ACA_SYND)))
 		error_code = ACA_REG__SYND__ERRORINFORMATION(bank->regs[ACA_REG_IDX_SYND]);
 	else
 		error_code = ACA_REG__STATUS__ERRORCODE(bank->regs[ACA_REG_IDX_STATUS]);
@@ -3413,7 +3502,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.fini_power = smu_v13_0_fini_power,
 	.check_fw_status = smu_v13_0_6_check_fw_status,
 	/* pptable related */
-	.check_fw_version = smu_v13_0_check_fw_version,
+	.check_fw_version = smu_v13_0_6_check_fw_version,
 	.set_driver_table_location = smu_v13_0_set_driver_table_location,
 	.set_tool_table_location = smu_v13_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v13_0_notify_memory_pool_location,
-- 
2.25.1

