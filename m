Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4D9E8304D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 04:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 122B310E302;
	Tue,  3 Feb 2026 04:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OFUGFKSk";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09BED10E302
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 04:12:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7aqNwJyVsqIN0QKNK+RBWAItxamqteftKMjU6XN8L7honsqrFDpHakT5SxiHYUksasUGQ8d5/5O4ZJtSV7lCm1a1e3ETTvISs1BIsjbjXPCGnUxpaT7+krrbMZlKJ5/9JXzEvo1BgP1XuGxj8pIlMa/TMycT4Q8nsa4EcLR1LghQILT3C+5K48J2mQTmMcFgz3LqG/WbAlogBr7mwdhtwgoCT8/TKPBIi3b4v4naCunm1iDu+5sWTVhM1xz5JPbpXIPBf4iknVa4ubPW1brlpFVq/0DvX0g8MUek3WMexMyWtDSvde9vCrXNzxvUm9v69bfTv86JO3D2CAdxt/Dkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cCXuGYWXmFyN7lMYxjELGxgDjbom24G11gcBFFdEB8=;
 b=MwGcdJSFi0s/USDJmzcEO+CWj9RcXrPSZzZ0BBQwOs7Bkd6FBVXWID6oPyl0PJEbGFhcI5wCEyiiJPYES8etLKoCGCcO/vI+BHnvVDm9WNRnvBa7Ue+Bg9YNwT3qqZb7jkGzbGxaWLOEUDFkLAR2NKWyz4lwnl0Yd1Kp72dj97bAaefZDNIyvNQ0OFohbtCCORENumGkevYnpuGHuduIZTRCBaEiHP0Ye94e63jYudtf+/XGD1T8lshQ26NSe/uCH+qemxuqIMmASP0x2s3MmWBsQGBJCiepY0mA1fy1788HeW4nsgLpAPcUmC28Q+d0pNmJtD/1RXbWzpxX8YhAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cCXuGYWXmFyN7lMYxjELGxgDjbom24G11gcBFFdEB8=;
 b=OFUGFKSkIH/nU2Uu17HB7MV8cT448a9ulSHheOWdxlFHYmtZ2vPVE2s5U/pbFGlnVhRZD4MCsoAk44YgmbncPEY96a9HCcC6+j0g2XieCWTzJcDNEPmgcsZCvTbHXV7ymfx04PBCu78jrqIXii4z92vPwgFyw/Lm5vnCBfSbENw=
Received: from BN1PR12CA0003.namprd12.prod.outlook.com (2603:10b6:408:e1::8)
 by DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 04:12:45 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::6) by BN1PR12CA0003.outlook.office365.com
 (2603:10b6:408:e1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 04:12:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 04:12:45 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 2 Feb 2026 22:12:44 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH V2 03/14] drm/amd/ras: add pmfw eeprom smu interfaces
Date: Tue, 3 Feb 2026 12:11:55 +0800
Message-ID: <20260203041206.1299104-3-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203041206.1299104-1-ganglxie@amd.com>
References: <20260203041206.1299104-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|DS0PR12MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 63aeaa29-7f65-4fa0-5b65-08de62da7c30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9nC1qciMbi/aznhIM9mW+kDVEhrx4PFPO9YdmE0iScjbWn3o7sniPkHpGw7O?=
 =?us-ascii?Q?7cpHwYPmSsK46RKFyvDCJ2dDqwkeIe+eEU409w5NwgV2apZ1HSo55aO5Ptnu?=
 =?us-ascii?Q?aXbP3wiej6jiSkvLVWYDlA/0lKZ0wqAfx/uMCOL+nPJK0RnjLFN1/YZ0iEuA?=
 =?us-ascii?Q?9q8xT6KGVhNCkIF59R6+RD5Qv4yIFGOn1qS0hnzspsyQw1CI1oO9URdAUKpD?=
 =?us-ascii?Q?mnG4aGhXRKTlGqhg1ILLlueU+UhdFr9GyLIitDDl/Y5ofySWXES1QylwrgIY?=
 =?us-ascii?Q?kR393cYFPtNDig+qQ+J4kX0OViGzq7GzfKI+TFMjMBqEYFxvssiegDdgiZ1Z?=
 =?us-ascii?Q?EREVa6pxRfK6HN9ZkdDgRbA4wETcdPMoXRI9Z/eB7zBLlYcmslalgP9H0ZP5?=
 =?us-ascii?Q?L9ySpp1DbjZHJe7eZ/Gpo1IP/UEVbFZ48sM/MftnM6kqdP1JjI3mMxUwpDgb?=
 =?us-ascii?Q?ojzmUqWR2JusqRvisTG4e258jT47hBfSNtacZBcSXC9OXkL3pQIlPXFTGRE7?=
 =?us-ascii?Q?a/IbJ3pZtnv24Ol/KFDzy4+xiVOgSovt5ufz8SHVal+I2esqiy9UymlEMPti?=
 =?us-ascii?Q?lpr9WAOHRbIdOVEpMi94lJxTaDS5QsyYzGqUE8Rb6KHwGvBTt8/kzYFF7Qhq?=
 =?us-ascii?Q?AuuJTuJTr1/3hYgi8poNWR3cmADTbAPyFGNeHDQ2gsScA8LQCX3DYN025IlZ?=
 =?us-ascii?Q?YHvCVIy8oso6BmVu4XTZLBLFabYzM5E39+j1D6hrgKMYn5uZ6HAXB2O8MB8Y?=
 =?us-ascii?Q?ouLW6Vq/KDxF85WXvdHgfzwT+Y/akuDwE4rCqPdvYognqmwQHGxQj00ERwkr?=
 =?us-ascii?Q?Fz/OlWAWy1V4AVYxHAdGCaa5m+S3q7xj99Ihf/s/dYquBe+HcBR8sb3f/HPm?=
 =?us-ascii?Q?bqN8oDvgFHHWjLiEnhd462cHJCIybWh9+XqxDg5EEwEtPxKTi2ZJRFJQrSVO?=
 =?us-ascii?Q?oSPD1Ojs6Oxr01BLf8+TEBBbdg3GaCHf2Q9x0p9Z2OVxTysOTxhavHjlL/Yk?=
 =?us-ascii?Q?AzIFyTW9a5ZbiB1BbPtRQiGOAaLKqYF6jJD14KV9TuWLJsJRAspRg7xsC6OI?=
 =?us-ascii?Q?iCUPFrAz7anyZDVEh3W8HwD2Kp1wTZJUsnEaR0SI87Vq3xDj5PGOTC238iVa?=
 =?us-ascii?Q?7QGuRDDtTyZyetanlSJtQgiIf2EeKl+kZCwS+eFIBGfcmm6EsLlbyhwEattM?=
 =?us-ascii?Q?Ar2ObHDLGPFja6V0Mqj+iU3fOSgke0azzcDpbUbhYCawxT2SE7qcLsZvu33r?=
 =?us-ascii?Q?w0KGBF/7rLQVwaIGsrtygOhPAmXQrsPorZ39s1yyODj3z/LCXfL73IWgA8nH?=
 =?us-ascii?Q?TutVFnDp4QBezr0dBaknFLwwpzMtqtogKquLHu80xz2StdhuLD8dm6wl6kO9?=
 =?us-ascii?Q?xUp8bI1MDk4bpH2zE9OVHYFbsooMSoRCirNL9+ZP4dVbX/eJRUy8Ib1W3rAP?=
 =?us-ascii?Q?oghXQtIDpx+cQYDTKNi558d0sGUYbdOR28WJ0WCzQ0Rayj0zlloIyqVRKNkL?=
 =?us-ascii?Q?JgZ+c2LAOcVvkQHSgSUgrpNZMM8nmfzH5dyEDNHgwQF1R1xtagYqoAxnmnpy?=
 =?us-ascii?Q?Ixbbn+bV2GYlJOSHAGIr8AhEz1UH3IX7k1aeBLC4jRGGIT5qLgJCJ+av3+jI?=
 =?us-ascii?Q?b9PMnr8BvK+B7s+NYhUCzAc//p9T9oePMrHLvvBCKUgbaoNbVtUEFtoL7FkO?=
 =?us-ascii?Q?wDTztQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TUk2ZTZQK7dHBuW5j1XdL3ZY0YXT2L1k33g2LBymMhY4qJwIh6qvr7iVUk/IeaYmfmslwk/AisWfIGbQaSihtZoM4JzbiTDsEJz6wE6yl/vOMUC5h47noKLTQgN8t+dD1GSbQYi4NJ+EbdaiBOZ076/6QZILCWeKiUQML9NSAv1afJDm8595HBtFSVihOiaqmqMAD2kEFlSZYZnB9K6IlQyS1nDF4GzF8Q+WQr9d/zHze/NF1V0KJXi7DCJqgFw8wY4Tfxj8CAFWM06CR+MlLdQnxxW45t7Hcs1s/ge+8zyYxfFQ/zcScL7reZSemQbXBEWh0NlxsTDoA2ggZkYaKvxoOGEoHWjocEkpplPLYTjF+1Ztx2cVSWHjMDTQttsAZw4Qsouhq5B0snh5IBEf1XItGuByFqoqEokjQJyzdQu2pZhV5r2cZz7k3y4tdecz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 04:12:45.8688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63aeaa29-7f65-4fa0-5b65-08de62da7c30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558
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

add smu interfaces and its data structures for
pmfw eeprom in uniras

v2: add 'const' to smu messages array, and specify
    index for each member when initializing.

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c    | 46 +++++++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras.h         | 18 ++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
index 79a51b1603ac..2098f24d4940 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
@@ -28,6 +28,16 @@
 #define RAS_MP1_MSG_QueryValidMcaCeCount  0x3A
 #define RAS_MP1_MSG_McaBankCeDumpDW       0x3B
 
+static const enum smu_message_type pmfw_eeprom_msgs[] = {
+	[RAS_SMU_GetRASTableVersion] = SMU_MSG_GetRASTableVersion,
+	[RAS_SMU_GetBadPageCount] = SMU_MSG_GetBadPageCount,
+	[RAS_SMU_SetTimestamp] = SMU_MSG_SetTimestamp,
+	[RAS_SMU_GetTimestamp] = SMU_MSG_GetTimestamp,
+	[RAS_SMU_GetBadPageIpid] = SMU_MSG_GetBadPageIpid,
+	[RAS_SMU_EraseRasTable] = SMU_MSG_EraseRasTable,
+	[RAS_SMU_GetBadPageMcaAddr] = SMU_MSG_GetBadPageMcaAddr,
+};
+
 static int mp1_v13_0_get_valid_bank_count(struct ras_core_context *ras_core,
 					  u32 msg, u32 *count)
 {
@@ -87,8 +97,44 @@ static int mp1_v13_0_dump_valid_bank(struct ras_core_context *ras_core,
 	return ret;
 }
 
+static int mp1_v13_0_eeprom_send_msg(struct ras_core_context *ras_core,
+				enum ras_fw_eeprom_cmd index, uint32_t param, uint32_t *read_arg)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	int ret = 0;
+
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		ret = amdgpu_smu_ras_send_msg(adev,
+			pmfw_eeprom_msgs[index], param, read_arg);
+		up_read(&adev->reset_domain->sem);
+	} else {
+		ret = -RAS_CORE_GPU_IN_MODE1_RESET;
+	}
+
+	return ret;
+}
+
+static int mp1_v13_0_get_ras_enabled_mask(struct ras_core_context *ras_core,
+					     uint64_t *enabled_mask)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	int ret = 0;
+
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		if (amdgpu_smu_ras_feature_is_enabled(adev, SMU_FEATURE_HROM_EN_BIT))
+			*enabled_mask |= RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM;
+		up_read(&adev->reset_domain->sem);
+	} else {
+		ret = -RAS_CORE_GPU_IN_MODE1_RESET;
+	}
+
+	return ret;
+}
+
 const struct ras_mp1_sys_func amdgpu_ras_mp1_sys_func_v13_0 = {
 	.mp1_get_valid_bank_count = mp1_v13_0_get_valid_bank_count,
 	.mp1_dump_valid_bank = mp1_v13_0_dump_valid_bank,
+	.mp1_send_eeprom_msg = mp1_v13_0_eeprom_send_msg,
+	.mp1_get_ras_enabled_mask = mp1_v13_0_get_ras_enabled_mask,
 };
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index 3396b2e0949d..2db838c444f1 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -49,6 +49,10 @@
 #define GPU_RESET_CAUSE_FATAL   (RAS_CORE_RESET_GPU | 0x0002)
 #define GPU_RESET_CAUSE_RMA     (RAS_CORE_RESET_GPU | 0x0004)
 
+enum ras_core_fw_feature_flags {
+	RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM = BIT_ULL(0),
+};
+
 enum ras_block_id {
 	RAS_BLOCK_ID__UMC = 0,
 	RAS_BLOCK_ID__SDMA,
@@ -127,6 +131,16 @@ enum ras_gpu_status {
 	RAS_GPU_STATUS__IS_VF = 0x8,
 };
 
+enum ras_fw_eeprom_cmd {
+	RAS_SMU_GetRASTableVersion = 0,
+	RAS_SMU_GetBadPageCount,
+	RAS_SMU_SetTimestamp,
+	RAS_SMU_GetTimestamp,
+	RAS_SMU_GetBadPageIpid,
+	RAS_SMU_EraseRasTable,
+	RAS_SMU_GetBadPageMcaAddr,
+};
+
 struct ras_core_context;
 struct ras_bank_ecc;
 struct ras_umc;
@@ -141,6 +155,10 @@ struct ras_mp1_sys_func {
 			u32 msg, u32 *count);
 	int (*mp1_dump_valid_bank)(struct ras_core_context *ras_core,
 			u32 msg, u32 idx, u32 reg_idx, u64 *val);
+	int (*mp1_send_eeprom_msg)(struct ras_core_context *ras_core,
+			enum ras_fw_eeprom_cmd index, uint32_t param, uint32_t *read_arg);
+	int (*mp1_get_ras_enabled_mask)(struct ras_core_context *ras_core,
+			uint64_t *enabled_mask);
 };
 
 struct ras_eeprom_sys_func {
-- 
2.34.1

