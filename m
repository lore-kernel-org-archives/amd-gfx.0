Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134D4CEF177
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 14:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B95E410E51B;
	Tue,  8 Oct 2024 14:01:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v/IXcQPj";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0149510E51B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 14:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrZWVO0uCoMsYB6jW/fZPyJwmA7sUuExfPEJ7MT3GI5ASE0QQGdX7NNxbhtdsV82eyzcd0f4Fu0+jAkmhqNbY8xpHnZFEymNWv4XudHZcAvWBuffHT/PHfga1QKkxhLkYr3OpuBe41lr157WnPbERttFexFsQ5upznWPE/MFRV3Uc5l8S14p6ouKCnqSAkqPQttqLgVtb3N401EYsGv1qIWsox2fGaRHYPAisr11vjIJ+QKDZ/04dWfI/HzeakCj7+qfWE1qWGaAFjDRr6CRX66sVHDZB/PD4dlVX2wCSdhjrwWNGv42v9T7bdq3DWpFyA8y0bZYoGh5P8NlRaM8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QRMgNtgiN2b+BX96WC304Ug6GP1S+d0oNfWhJCEnfo=;
 b=ODDMiUeK6G9yb4Q+gjpqR81zwikW5aWmkS4Qse8jTwIazvEsW84HLhcSjLsH6GP6fN+s5+HI2lGlu8dsS5PgFcNSJpisRGmlIpI2Fc7Tqd52irh7UZDuMwxE6vmLI2LFt/jAOGue9ZeaETwymBSXzEGoFDlLoISMH61npNx/8dajTmPUklqsiuk+rSg/FkZAEVjTcfJZWWvPyxXYMBsM54qTOvvIIbsI3xQFzQSG52Mn4FH5mUjl+pqdibFg/YkcWNeMGacxueyCxeM3sEWO2JLTQhzgTFDzoQfBZJ7LdnwR8AzBP2x47oWEI+Wifm0bNITSDCUapeKkVjVOVl7GiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QRMgNtgiN2b+BX96WC304Ug6GP1S+d0oNfWhJCEnfo=;
 b=v/IXcQPj2aw4zLFvYPy9+5ubyyuIxvr6X8uEeAEWl7Y+3Pd4KJZi8Sw53URr7820t5otTOHgvZ2lhJfdiPf7/WybFF6xILpbebsD9LSwDqffQRv3+uvAg61VBFvGvP72l6nsw00MpQdSE4V5WX231TUBnvO95OE9i6jXqMr756s=
Received: from BY3PR04CA0022.namprd04.prod.outlook.com (2603:10b6:a03:217::27)
 by DM4PR12MB7502.namprd12.prod.outlook.com (2603:10b6:8:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 14:01:15 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::e6) by BY3PR04CA0022.outlook.office365.com
 (2603:10b6:a03:217::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 14:01:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 14:01:14 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 09:01:09 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <rajneesh.bhardwaj@amd.com>, <Ramesh.Errabolu@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH v2] drm/amdgpu: Add NPS switch support for GC 9.4.3
Date: Tue, 8 Oct 2024 19:30:51 +0530
Message-ID: <20241008140051.2998777-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|DM4PR12MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 0548e844-f248-44a3-57e1-08dce7a1ac62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U6UUx2s8e/B+4E4rCrlku8f6/eP7kEig9R6NvExBHCCi/JhvJMoqlq9x4nOz?=
 =?us-ascii?Q?0S9E/UegFHb6pUOuJp4dQduDqeeCJiyezZmCWAeaxAnz+dURgbywociNNYqU?=
 =?us-ascii?Q?ol940a28gS3JJSPXeba84W4gpRyGLORbjcrwoA2lgKdNOHve/KQ2KqI2A8W3?=
 =?us-ascii?Q?nssfIdtZSaEwVt4LRUlobcTmT2wSRYBCaXoDDswiXVcWJxb9Xqs5vgRour/f?=
 =?us-ascii?Q?7ZS/W5x7JTra5LCbTeOLZAhOFX+MwsAp9SOGaChJ56AI+IhEuGu3+4oibnEF?=
 =?us-ascii?Q?fi9Xhqc46hpVDf8G4EiTFbd2AD2XbkDwQOGeTlkDN9oUYfZjhuw/cSEO+Wkz?=
 =?us-ascii?Q?5/py/L+b8DZolOd9c6AqS8OdoU1asbfsTXQGfZly+WrMgQllYLxoQcZXNLJw?=
 =?us-ascii?Q?YdFP8Rn4wCmBejCaTRiOBP09Idf4SYaY6Uy6RKkS/kcpVP5U6dIAag6SotK3?=
 =?us-ascii?Q?sNtqkFfHSeXJGK8WvHaLYGTOFau9+K0TdGmyLXLoDxjtXyF+BPXiW//P10W9?=
 =?us-ascii?Q?etVWiF98QRhuYDG+1YxFHw8rFyCwrfoRGccbfMqPY8t9FL4H4Gy19s40hFMa?=
 =?us-ascii?Q?NmecyNbWNF9Tq2co6v7lmjEyxGdpmMWn7MV2lJ+pXdq8w9DBrCTkR38pLt8K?=
 =?us-ascii?Q?2eu0lj5366k4HqBU0KabYDCcmxUi/nD5PO5nMUjXrvMsUaiO9yaaDtsuS9i3?=
 =?us-ascii?Q?Y9+O4NY2kPZ8ZIoc5KtjkELS4AVjG6LsB9nH0n+wQhKKhn8ZiN2xp6yZzhrZ?=
 =?us-ascii?Q?wFk3WyrehFIQBL0WiRwMUyjpgI3NTGbZjq0BHwjRfq94wsFFsD3F0a14teKn?=
 =?us-ascii?Q?iOuqDzE/Qh6OiB8DkCy8cjpCQqYEQQgFkGw2rH+ZPM29FM7KglsIjfNSbGYH?=
 =?us-ascii?Q?f6DeT3ecIVv7+3WyxhOZzvxuJltXo35987Iu/7G5ph7tWWYNECD6jqZ/ctyH?=
 =?us-ascii?Q?9mmBKzXcgn50Wk2A2FdTBHX+UmUD2IRwDeXmk6IHda3DPlQH9EoH2q6C01pY?=
 =?us-ascii?Q?U0AviBrOUI9wVCbjNv4abn5kwkvF2AYX3jWYMCIVKorK4zvHJilY9Ec3XrO9?=
 =?us-ascii?Q?6/bl0aeZryFYsCLLyt5Ei5b5o2/HwmHBVdpXLoI4R3kdsLPMG5cbXfMXBQLC?=
 =?us-ascii?Q?cTU4ZF/26w9bcx6y2edkkkz8+jGcZoOr4QxXdgopBHAxreCWMI1YByFGUWGB?=
 =?us-ascii?Q?n2Dvgeftqse+Ysd/8HyiUEuGz/JrSA26ENgFxsKEb31YtWXgQi66tMAM8GWN?=
 =?us-ascii?Q?wSAvcWilbI1QeyY8G8quXmC7WzTqdpB+A9ENzljimzsPKpspuCPn2J0Glysc?=
 =?us-ascii?Q?/AANgXkBbBSIsGGgLRFbUJhxyQ6csqo5Xrhk1oCSs/V6u06JONAFXi6igBvS?=
 =?us-ascii?Q?mp6+R7E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 14:01:14.5769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0548e844-f248-44a3-57e1-08dce7a1ac62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7502
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

Add dynamic NPS switch support for GC 9.4.3 variants. Only GC v9.4.3 and
GC v9.4.4 currently support this. NPS switch is only supported if an SOC
supports multiple NPS modes.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
---
v2: Add NULL check for is_nps_switch_supported callback implementation

 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 45 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c   | 12 +++++++
 3 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index f61d117b0caf..79c2f807b9fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -101,6 +101,7 @@ struct amdgpu_nbio_funcs {
 	int (*get_compute_partition_mode)(struct amdgpu_device *adev);
 	u32 (*get_memory_partition_mode)(struct amdgpu_device *adev,
 					 u32 *supp_modes);
+	bool (*is_nps_switch_requested)(struct amdgpu_device *adev);
 	u64 (*get_pcie_replay_count)(struct amdgpu_device *adev);
 	void (*set_reg_remap)(struct amdgpu_device *adev);
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 94600e5c8ea3..bfbfbcc9b89b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1395,6 +1395,17 @@ gmc_v9_0_query_memory_partition(struct amdgpu_device *adev)
 	return gmc_v9_0_get_memory_partition(adev, NULL);
 }
 
+static bool gmc_v9_0_need_reset_on_init(struct amdgpu_device *adev)
+{
+	if (adev->nbio.funcs && adev->nbio.funcs->is_nps_switch_requested &&
+	    adev->nbio.funcs->is_nps_switch_requested(adev)) {
+		adev->gmc.reset_flags |= AMDGPU_GMC_INIT_RESET_NPS;
+		return true;
+	}
+
+	return false;
+}
+
 static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.flush_gpu_tlb = gmc_v9_0_flush_gpu_tlb,
 	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
@@ -1406,6 +1417,8 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
 	.get_vbios_fb_size = gmc_v9_0_get_vbios_fb_size,
 	.query_mem_partition_mode = &gmc_v9_0_query_memory_partition,
+	.request_mem_partition_mode = &amdgpu_gmc_request_memory_partition,
+	.need_reset_on_init = &gmc_v9_0_need_reset_on_init,
 };
 
 static void gmc_v9_0_set_gmc_funcs(struct amdgpu_device *adev)
@@ -1545,6 +1558,28 @@ static void gmc_v9_0_set_xgmi_ras_funcs(struct amdgpu_device *adev)
 		adev->gmc.xgmi.ras = &xgmi_ras;
 }
 
+static void gmc_v9_0_init_nps_details(struct amdgpu_device *adev)
+{
+	adev->gmc.supported_nps_modes = 0;
+
+	if (amdgpu_sriov_vf(adev) || (adev->flags & AMD_IS_APU))
+		return;
+
+	/*TODO: Check PSP version also which supports NPS switch. Otherwise keep
+	 * supported modes as 0.
+	 */
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+		adev->gmc.supported_nps_modes =
+			BIT(AMDGPU_NPS1_PARTITION_MODE) |
+			BIT(AMDGPU_NPS4_PARTITION_MODE);
+		break;
+	default:
+		break;
+	}
+}
+
 static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -2165,6 +2200,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	gmc_v9_0_init_nps_details(adev);
 	/*
 	 * number of VMs
 	 * VMID 0 is reserved for System
@@ -2435,8 +2471,17 @@ static int gmc_v9_0_suspend(struct amdgpu_ip_block *ip_block)
 
 static int gmc_v9_0_resume(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	/* If a reset is done for NPS mode switch, read the memory range
+	 * information again.
+	 */
+	if (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS) {
+		gmc_v9_0_init_sw_mem_ranges(adev, adev->gmc.mem_partitions);
+		adev->gmc.reset_flags &= ~AMDGPU_GMC_INIT_RESET_NPS;
+	}
+
 	r = gmc_v9_0_hw_init(ip_block);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index d1bd79bbae53..8a0a63ac88d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -401,6 +401,17 @@ static int nbio_v7_9_get_compute_partition_mode(struct amdgpu_device *adev)
 	return px;
 }
 
+static bool nbio_v7_9_is_nps_switch_requested(struct amdgpu_device *adev)
+{
+	u32 tmp;
+
+	tmp = RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_MEM_STATUS);
+	tmp = REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_MEM_STATUS,
+			    CHANGE_STATUE);
+
+	/* 0x8 - NPS switch requested */
+	return (tmp == 0x8);
+}
 static u32 nbio_v7_9_get_memory_partition_mode(struct amdgpu_device *adev,
 					       u32 *supp_modes)
 {
@@ -508,6 +519,7 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.remap_hdp_registers = nbio_v7_9_remap_hdp_registers,
 	.get_compute_partition_mode = nbio_v7_9_get_compute_partition_mode,
 	.get_memory_partition_mode = nbio_v7_9_get_memory_partition_mode,
+	.is_nps_switch_requested = nbio_v7_9_is_nps_switch_requested,
 	.init_registers = nbio_v7_9_init_registers,
 	.get_pcie_replay_count = nbio_v7_9_get_pcie_replay_count,
 	.set_reg_remap = nbio_v7_9_set_reg_remap,
-- 
2.25.1

