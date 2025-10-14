Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE9DCCD18E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 20:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C228910E6B5;
	Tue, 14 Oct 2025 20:14:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lq2IKVHs";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012015.outbound.protection.outlook.com
 [40.93.195.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7E9310E6A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 20:14:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s98dW5fGf5KxmwZQNmCKsLMDVkNZIs35L2vh2qSyOnuW+KoDYbA+Dg3PWZ0WdFLE1GhLBz/m1M6gDMvhmzW/qbRvJCdzQgvXQE84X76FnN7JorrnUk5yLvyjLnwumizYDD0ttgB7/EY/qAJMubVS5uSO+MwCRKfVA3/0opoMlYdHVXve2EYuNjf3+UcT92os0sK4wA+T2BkAmQ7L6V60KSbkCdx1MjLyc23znduYtu7VwStIL4inkJlOlwENuCoweq7Y+RQyjsIZBRjxniIOv+WyD6MJNanrNsBDmV+sMpWNlUz35Xdg9UCjIsk3ObJrgsX1AaeukeCd/ehqM+owgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/c7Ibljhb7XVzNAnUWXsXspL6AU0hyD92J5rBqJX5I=;
 b=kucF4FKKSHEbZyObfcoBMIYKTpkTE79uZSigkJ6zYOgnorc0tO5SUdpgrVaBMOtRi46olYGK6FuGIZjf1CxhKCXNq91oOcv/DkwfB11lIQ5E60Qusx7QsIqDClAKBn3I7GTA91a1fk/s5euNYV3Db/P/SbLgyDSnpWB/b8RRvC/xOX6L9/btt//h62v1bx3f80yQKNPceS8+9OESBXYRIaNJvlDg6d4um80BTVepA9YRjhMaf7tC++sOd4Wgcifl46Pofl4EEx+Jyt2vS2G557EWqLfgzcUuw26WSGj9j4n1QpFd1KfxPlFVlHvW5jeeBcwvWYKOMkjm+EPHwn0msw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/c7Ibljhb7XVzNAnUWXsXspL6AU0hyD92J5rBqJX5I=;
 b=Lq2IKVHseORVprYggNxg4okOw37MZ8LGKf0IAxnAZAfQ6ZX2VX09ncbvIWvyzp6emc3NZbutBNeKUNbN31fht0miD3/w5bTocfsRTCRNnRIqrXj5PpTN3onjazy27w5sMDlJBNsrfyJMp0vpe6ReJi7t12qX5nagZsoctHtg2PA=
Received: from SA9PR11CA0018.namprd11.prod.outlook.com (2603:10b6:806:6e::23)
 by DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 20:14:06 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::93) by SA9PR11CA0018.outlook.office365.com
 (2603:10b6:806:6e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Tue,
 14 Oct 2025 20:14:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 20:14:06 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Oct 2025 13:14:03 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH v4 6/6] drm/amdgpu: Add logic for VF data exchange region to
 init from dynamic crit_region offsets
Date: Tue, 14 Oct 2025 15:13:46 -0500
Message-ID: <20251014201346.9422-6-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014201346.9422-1-yunru.pan@amd.com>
References: <20251014201346.9422-1-yunru.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DM4PR12MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: 2222b4ea-cd18-4f3d-958d-08de0b5e3a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/zNEGjEQL+ID3y/sealYpvEQxFUYu7+DrOEMXzCkR46SlzXAAeXgG/nM2/+N?=
 =?us-ascii?Q?XW6g4KjQekrE4iS8xHiy0EWAkNbwFbWdtglVC6bTNNGeFGJ8neDMHRiOEyLT?=
 =?us-ascii?Q?gS1AAYundX2q3dJHWChrcKmqVXg9nWB/IFpCRSm85Pv29UHx5J/YYTLZ1bOT?=
 =?us-ascii?Q?vkEmiltP2PoU8QUiUiYwnddaT8gr2UmUXe2flK5RAeth5f5Ow0ZT2DsRLl7n?=
 =?us-ascii?Q?EKrp0FPExEKGeh5qrifQkBLyTn3FyChnp/sBcXDv6GaCwuz17KgUIFaAMkxu?=
 =?us-ascii?Q?B4vWHqB99npDB5h0bxkYd6Br/r1uWPX6k0XDBTgarB1XAlK/sRCa1tUCK7KI?=
 =?us-ascii?Q?9twhhqeHVTcB0jeRFSWFyPiHq/CGvbL0DNbMyfIE9oUEg/il+orBoOJF4GaI?=
 =?us-ascii?Q?y59TvTht31pyOWboc+NTgUX3rWBwFLcmZvEtW9OhnSZdwEovuKUDc989L8S3?=
 =?us-ascii?Q?o+PehHz8Wg0Ta8Ta2470Foqgta4Tu5o2RAt4cgik7ut3dmSlsr0J8kTQgnjC?=
 =?us-ascii?Q?3iU19IVPJfmIARFIzlxzyR8+jjikQsLeqp5qCevAKqL61yyE1N+HZBwSfA8X?=
 =?us-ascii?Q?j7Y5Ffk2Q0wvUFN3qSR04F8eCEeWvALJXhhjtkEMHqwZbQ1C5vcsQ2gWzyrA?=
 =?us-ascii?Q?eVIugkKFUi72oavW0g3ZCs13QJsc6dhmBnbiJRzhOBf5SmtiIdaMS2Uvxv+k?=
 =?us-ascii?Q?9WPwCwXrsgg1qMJXB7PmhvUvNx3/dJzjjQvdmcLoIyEY911fC2f0iaQWfbls?=
 =?us-ascii?Q?YoaZ5TeAqAB1rxdlF8uwkfsObU7yhdypYCQyFX0pOsnwyfYdYl+v2yaLahvX?=
 =?us-ascii?Q?1cbniO2ROBt/dGSXzcEa7XZ/QyfJxZjIM+N3/e71J2+cM6XnI7FDQyIicrrp?=
 =?us-ascii?Q?t/PnBVovW9RxYicCWh7h4AOxRjb8ZaI3/q8bvFyQmvugeMjEOArQuSSLYlqP?=
 =?us-ascii?Q?3h/ZHp5O86h4GrR1lFzo/Utljtaoa91hhXeUiV4GZishT/e2pLaKNexV+aHA?=
 =?us-ascii?Q?m0couGM0O4Sgx63TKyxxFCIuszpND9VRZQYddOwvriHoRN8Y+XXUg0l/Sgz2?=
 =?us-ascii?Q?WSea6I46onhPd7cQH9hL/eeaANN2flVKX5aWSsI/HqrKANg3cDdpiDGuYWda?=
 =?us-ascii?Q?OwVuMiYqCLS7pN9qMxtY+RisJCo9bPTx13QbxRNN7u7g1++H/eqbUM+2O6dl?=
 =?us-ascii?Q?2e1jPWIJ/gp7HxzyWlzY9HSRJ+qHGpZHAuSZ5XT0mIyUpXEAhM8Z1v5fpEJk?=
 =?us-ascii?Q?Mc4RHUrDkez7wLMKN8Ur8YCpZfyiCyw9V3LyNAN6zTY3h1qvcmFloayt8TEy?=
 =?us-ascii?Q?cZw9to+TZCfW+sqCx3qRa/KD4LChjtoW5wWFGigM1BwtjJhGyN2/rLxp8/kH?=
 =?us-ascii?Q?CSFh2OoNICPlib7Ng7oy+mfKgFl4Nm5T9e9lnk5oBECbIZMSFvElFJ73VC3X?=
 =?us-ascii?Q?cN/g/e79rSRa4t7ZGyXSm1MnGRW3nyoZV3u0SIVg1aq7eaQpQlk7V3OfWMtt?=
 =?us-ascii?Q?SRPu2xqU5vwUc0CW1EnCogwj7ZgBW9u+tc1CAV26wTFm3tJneKIVeXRahmaI?=
 =?us-ascii?Q?o6ybztb99wey4kjDJH8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 20:14:06.5135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2222b4ea-cd18-4f3d-958d-08de0b5e3a47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614
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

1. Added VF logic to init data exchange region using the offsets from dynamic(v2) critical regions;

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 104 ++++++++++++++++++-----
 1 file changed, 85 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index fef4ebb0f879..35cb716ec594 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -208,12 +208,12 @@ int amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev)
 				    &adev->virt.mm_table.gpu_addr,
 				    (void *)&adev->virt.mm_table.cpu_addr);
 	if (r) {
-		DRM_ERROR("failed to alloc mm table and error = %d.\n", r);
+		dev_err(adev->dev, "failed to alloc mm table and error = %d.\n", r);
 		return r;
 	}
 
 	memset((void *)adev->virt.mm_table.cpu_addr, 0, PAGE_SIZE);
-	DRM_INFO("MM table gpu addr = 0x%llx, cpu addr = %p.\n",
+	dev_info(adev->dev, "MM table gpu addr = 0x%llx, cpu addr = %p.\n",
 		 adev->virt.mm_table.gpu_addr,
 		 adev->virt.mm_table.cpu_addr);
 	return 0;
@@ -393,7 +393,9 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
 			if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
 							AMDGPU_GPU_PAGE_SIZE,
 							&bo, NULL))
-				DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
+				dev_dbg(adev->dev,
+						"RAS WARN: reserve vram for retired page %llx fail\n",
+						bp);
 			data->bps_bo[i] = bo;
 		}
 		data->last_reserved = i + 1;
@@ -661,10 +663,34 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 	schedule_delayed_work(&(adev->virt.vf2pf_work), adev->virt.vf2pf_update_interval_ms);
 }
 
+static int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, uint32_t *pfvf_data)
+{
+	uint32_t dataexchange_offset =
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset;
+	uint32_t dataexchange_size =
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10;
+	uint64_t pos = 0;
+
+	dev_info(adev->dev,
+			"Got data exchange info from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
+			dataexchange_offset, dataexchange_size);
+
+	if (!IS_ALIGNED(dataexchange_offset, 4) || !IS_ALIGNED(dataexchange_size, 4)) {
+		dev_err(adev->dev, "Data exchange data not aligned to 4 bytes\n");
+		return -EINVAL;
+	}
+
+	pos = (uint64_t)dataexchange_offset;
+	amdgpu_device_vram_access(adev, pos, pfvf_data,
+			dataexchange_size, false);
+
+	return 0;
+}
+
 void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
 {
 	if (adev->virt.vf2pf_update_interval_ms != 0) {
-		DRM_INFO("clean up the vf2pf work item\n");
+		dev_info(adev->dev, "clean up the vf2pf work item\n");
 		cancel_delayed_work_sync(&adev->virt.vf2pf_work);
 		adev->virt.vf2pf_update_interval_ms = 0;
 	}
@@ -672,13 +698,15 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
 
 void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 {
+	uint32_t *pfvf_data = NULL;
+
 	adev->virt.fw_reserve.p_pf2vf = NULL;
 	adev->virt.fw_reserve.p_vf2pf = NULL;
 	adev->virt.vf2pf_update_interval_ms = 0;
 	adev->virt.vf2pf_update_retry_cnt = 0;
 
 	if (adev->mman.fw_vram_usage_va && adev->mman.drv_vram_usage_va) {
-		DRM_WARN("Currently fw_vram and drv_vram should not have values at the same time!");
+		dev_warn(adev->dev, "Currently fw_vram and drv_vram should not have values at the same time!");
 	} else if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) {
 		/* go through this logic in ip_init and reset to init workqueue*/
 		amdgpu_virt_exchange_data(adev);
@@ -687,11 +715,34 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
 	} else if (adev->bios != NULL) {
 		/* got through this logic in early init stage to get necessary flags, e.g. rlcg_acc related*/
-		adev->virt.fw_reserve.p_pf2vf =
-			(struct amd_sriov_msg_pf2vf_info_header *)
-			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
+		if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
+			pfvf_data =
+				kzalloc(adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10,
+					GFP_KERNEL);
+			if (!pfvf_data) {
+				dev_err(adev->dev, "Failed to allocate memory for pfvf_data\n");
+				return;
+			}
 
-		amdgpu_virt_read_pf2vf_data(adev);
+			if (amdgpu_virt_read_exchange_data_from_mem(adev, pfvf_data))
+				goto free_pfvf_data;
+
+			adev->virt.fw_reserve.p_pf2vf =
+				(struct amd_sriov_msg_pf2vf_info_header *)pfvf_data;
+
+			amdgpu_virt_read_pf2vf_data(adev);
+
+free_pfvf_data:
+			kfree(pfvf_data);
+			pfvf_data = NULL;
+			adev->virt.fw_reserve.p_pf2vf = NULL;
+		} else {
+			adev->virt.fw_reserve.p_pf2vf =
+				(struct amd_sriov_msg_pf2vf_info_header *)
+				(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
+
+			amdgpu_virt_read_pf2vf_data(adev);
+		}
 	}
 }
 
@@ -704,14 +755,29 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 
 	if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) {
 		if (adev->mman.fw_vram_usage_va) {
-			adev->virt.fw_reserve.p_pf2vf =
-				(struct amd_sriov_msg_pf2vf_info_header *)
-				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
-			adev->virt.fw_reserve.p_vf2pf =
-				(struct amd_sriov_msg_vf2pf_info_header *)
-				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
-			adev->virt.fw_reserve.ras_telemetry =
-				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
+			if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
+				adev->virt.fw_reserve.p_pf2vf =
+					(struct amd_sriov_msg_pf2vf_info_header *)
+					(adev->mman.fw_vram_usage_va +
+					adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset);
+				adev->virt.fw_reserve.p_vf2pf =
+					(struct amd_sriov_msg_vf2pf_info_header *)
+					(adev->mman.fw_vram_usage_va +
+					adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset +
+					(AMD_SRIOV_MSG_SIZE_KB_V1 << 10));
+				adev->virt.fw_reserve.ras_telemetry =
+					(adev->mman.fw_vram_usage_va +
+					adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset);
+			} else {
+				adev->virt.fw_reserve.p_pf2vf =
+					(struct amd_sriov_msg_pf2vf_info_header *)
+					(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
+				adev->virt.fw_reserve.p_vf2pf =
+					(struct amd_sriov_msg_vf2pf_info_header *)
+					(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
+				adev->virt.fw_reserve.ras_telemetry =
+					(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
+			}
 		} else if (adev->mman.drv_vram_usage_va) {
 			adev->virt.fw_reserve.p_pf2vf =
 				(struct amd_sriov_msg_pf2vf_info_header *)
@@ -819,7 +885,7 @@ static bool amdgpu_virt_init_req_data(struct amdgpu_device *adev, u32 reg)
 			break;
 		default: /* other chip doesn't support SRIOV */
 			is_sriov = false;
-			DRM_ERROR("Unknown asic type: %d!\n", adev->asic_type);
+			dev_err(adev->dev, "Unknown asic type: %d!\n", adev->asic_type);
 			break;
 		}
 	}
@@ -1468,7 +1534,7 @@ amdgpu_ras_block_to_sriov(struct amdgpu_device *adev, enum amdgpu_ras_block bloc
 	case AMDGPU_RAS_BLOCK__MPIO:
 		return RAS_TELEMETRY_GPU_BLOCK_MPIO;
 	default:
-		DRM_WARN_ONCE("Unsupported SRIOV RAS telemetry block 0x%x\n",
+		dev_warn(adev->dev, "Unsupported SRIOV RAS telemetry block 0x%x\n",
 			      block);
 		return RAS_TELEMETRY_GPU_BLOCK_COUNT;
 	}
-- 
2.34.1

