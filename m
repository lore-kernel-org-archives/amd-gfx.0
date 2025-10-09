Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC05CCA470
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 03:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E372410E909;
	Thu,  9 Oct 2025 03:31:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3cik0wAD";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FC6010E909
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 03:31:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCk3PhwiwZ+hIBDz2iTJV9Dqr+IcGsiH6dk5M9e7RYEAotATb2S9w/C2g4NN9MF+5Nt6Bb4ZwFUCaFy4ElmuHpuqnVNV618fkNYnr+srE7plNkHRjyYgVv4slIb+5mepKuPX4ogDum/ogMkKaBrTVBxFAs2+HV/9na6X1F6+LjjRw9u56i84p2Tj3TRWR4EM3vMh2hAroldenICgazkajTCOxR7b9PAZtVgcLbz0k7N1+IaUs8gfGif/WOGjQ12yf9erriNXD6X/IunHUeaIR9hKKBIL8ERnVcTGTXCmItsuv8f/EkBD3GCYeYLBPu11l/fJK0tuoLalcg0zqDTcgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghx2fjJPbyVTDQwtyzz/9b0HQRrXzQRZCZjWNVavRMo=;
 b=gDP5bm3ZLdqUvuGoS6VjmnLOtYRn8EIE7tA2A7s3Rq178YcJX/dPbcRs7ZYOOfDVAZgxbf6Znx7L0qAETW9ydvBuFtGxRoXtYplcF8Zmk1IZ0TPawhFI2BnU1vftLdvaCZe667Oqels1yh9TQrUB/qE8TP2CmtUodHUMv4sIGV/Q0if1yLTN1J1r8RuozPgxFR5XLZJUs8A1onYJlQBHmnefTOrWSp2kfraqAQ615x95hBa3JSuOHODbkYoujPLnpx/vcpbmZ4ZC5iM+gvyB+hWPO12LGu6UqD8vjPMxh0gJBpW+QCHkSeTAr9+Wbkh7+inTrmmv9yg3XpKttIuTqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghx2fjJPbyVTDQwtyzz/9b0HQRrXzQRZCZjWNVavRMo=;
 b=3cik0wADcWCHB2p+NkXVWVC8fYRH8sJ/VmR43YoekClsZmiCjIN8txdsjhLjYLQsnJwvVPC9LHdYjX11FVUwDQdjP4DTjYcfLB9I9hfQVOHVv6BSHQspDflMndNGD9XI/0cEYLJOvsMTDPxxumSsDv/Ie2b9qOge8AUFmilN0mk=
Received: from DM6PR05CA0054.namprd05.prod.outlook.com (2603:10b6:5:335::23)
 by SA1PR12MB9492.namprd12.prod.outlook.com (2603:10b6:806:459::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 03:31:44 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::79) by DM6PR05CA0054.outlook.office365.com
 (2603:10b6:5:335::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 03:31:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 03:31:43 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Oct 2025 20:31:43 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Shravankumar.Gande@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: Add logic for VF data exchange region to init
 from dynamic crit_region offsets
Date: Wed, 8 Oct 2025 22:31:31 -0500
Message-ID: <20251009033131.25040-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SA1PR12MB9492:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa7847e-ee9b-4cc1-db2b-08de06e45e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?obj2nCTiNtOlweKLLmDTkqXb3itF6NDeAVQr9FxcriGWTSX4zUQ3Z8xtxAh0?=
 =?us-ascii?Q?oVaVrYCeSbWkEw4TU7PJfqeyTf4W886M7cmw90UOmXSiUh+eDpTZsNCHkQqM?=
 =?us-ascii?Q?6xZzeCqHoffBIzVqWHCE4l7oRTZGG9VuCjuxx+HQcFx9skQwXD6XZV6KQ/Lw?=
 =?us-ascii?Q?q7toc4oB7d6wtWbr8JeXrIdp6yL5VUCGBV4c/LBhBiZEc8Iwc9MPPGKa/POy?=
 =?us-ascii?Q?NV+goyvRwqbB1OGYLeiIhQmShOv07x1kDUYVKwTRTuM57yR5bz2bHJk2mB6t?=
 =?us-ascii?Q?gB/eO7nFmjFESMeF3FfiqdEda7qNg2t3/Oz490vQo6Gls4OtlbZLpFxlsOrA?=
 =?us-ascii?Q?e6Xl19LNbOPnNDZM/VmdRBTlrDhCPCbr/LP++3IyjOrAQ/RgnpHR3asNXaF/?=
 =?us-ascii?Q?RpGUE/ckppA8b12mpTekB/YbOs0jflpiL1xWZjWzUAjmdKbc0fdEE0BtXSJn?=
 =?us-ascii?Q?yAv/5OciO/82Zzqi+/8WSlOdkrzA9h2epZYVDK+6yuCeCAroZ/j0jkCvR79b?=
 =?us-ascii?Q?zKHHDWhX0qslOVOsO5e+lu3Njk9YJZA4O5KUsU2HZcu2Zwygck5UMoewXj4V?=
 =?us-ascii?Q?kqzRyYVtS21issE/K27+diWLX90zxgjNdkzGh5acEUuu6mo4cABF2DPV9n1C?=
 =?us-ascii?Q?7Z+uuvAjJNigyloxMKcn4SaAsYGZb53F5zDrxYd5ezx4xjhV7phLpprwZyxV?=
 =?us-ascii?Q?N6XZKmCkgOF6YqSKQNevWQ+jj4X6Rsl8R+GTTo+fo34jE3Bhpibp2/hobTft?=
 =?us-ascii?Q?PRkvUC0tHuVDlP7AEKIT3jVr3JD1AWkLVpFKQOBsh7wo3Oa66lyBjIbJ/FvF?=
 =?us-ascii?Q?LXDVU60H68xJrRTbVy+QlMsb4LgusCLo4qGWk3MSScc7IWV5c0jjmRDIjOOI?=
 =?us-ascii?Q?eH8VvIMsSgLwMSYsPs+icZJhWtB4FYTvG8dXhSjk4tA+cEf5fcKDqLjoXtYu?=
 =?us-ascii?Q?ZVxVnkhIiEKD+yD7oAARZ/pPNZb7dRiB9+v78k5XT6kHKO2grsSSux1lWKtf?=
 =?us-ascii?Q?MkSPqJqThnS894lVEUwVvhXMdedaUGLOsJlHft8JX80KDUiyC8nYERF/HESk?=
 =?us-ascii?Q?sSWU49yk+L5sU3MwPLEWZMPgzeVd5AJMIguKhg5+HsiVv3TsXX9hqFPItz1M?=
 =?us-ascii?Q?784gO0qJKWvNf6D8kG49CFm0HNbdbxQmdWacZvBNt6GT9mL5YjVoaw9726Vj?=
 =?us-ascii?Q?6S3LG4BOjvoBZT3FnRJ+BBIC8Cw1psB5VD273KlwqCkN3dWieC4dcqvrPE1E?=
 =?us-ascii?Q?maFkeqfIYuHxtxKuF/31LQa5CpzS59W3JQD0msw8MLgZSferkseeOOJW3oWn?=
 =?us-ascii?Q?nA5W2tw/gBYUb3MZn3mgjyjDU7pRf1GzzEFprzC9IFRIs96pGXoyNOsbMffm?=
 =?us-ascii?Q?1yXh2mMtM5L30DJQEYCb5qlM4EZN/HP+6Vns5O3wX0ppnvRFbdU9D3pGK5Nh?=
 =?us-ascii?Q?kr/ADCek95bEQCJ/Hu7PVw8OvE9YcBJoQwc0PBuSaeJzJ18POfiesZE8X+/W?=
 =?us-ascii?Q?i8evvTX2IW6bjx3Gmy75u0+v+NpuQd3DTjkACbVEXbXyZrZRxojavDF9RdbI?=
 =?us-ascii?Q?Y4Os5TjPg0Af09GhJiM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 03:31:43.6453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa7847e-ee9b-4cc1-db2b-08de06e45e48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9492
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 87 ++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  1 +
 2 files changed, 76 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 9181acef4e9b..e684aa3f286f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -670,6 +670,8 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
 
 void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 {
+	uint32_t *pfvf_data = NULL;
+
 	adev->virt.fw_reserve.p_pf2vf = NULL;
 	adev->virt.fw_reserve.p_vf2pf = NULL;
 	adev->virt.vf2pf_update_interval_ms = 0;
@@ -685,11 +687,34 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
 	} else if (adev->bios != NULL) {
 		/* got through this logic in early init stage to get necessary flags, e.g. rlcg_acc related*/
-		adev->virt.fw_reserve.p_pf2vf =
-			(struct amd_sriov_msg_pf2vf_info_header *)
-			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
+		if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
+			pfvf_data =
+				kzalloc(adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] << 10,
+					GFP_KERNEL);
+			if (!pfvf_data) {
+				DRM_ERROR("Failed to allocate memory for pfvf_data\n");
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
 
@@ -702,14 +727,29 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 
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
+					adev->virt.crit_region_offsets[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID]);
+				adev->virt.fw_reserve.p_vf2pf =
+					(struct amd_sriov_msg_vf2pf_info_header *)
+					(adev->mman.fw_vram_usage_va +
+					adev->virt.crit_region_offsets[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] +
+					(AMD_SRIOV_MSG_SIZE_KB_V1 << 10));
+				adev->virt.fw_reserve.ras_telemetry =
+					(adev->mman.fw_vram_usage_va +
+					adev->virt.crit_region_offsets[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID]);
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
@@ -1001,6 +1041,29 @@ int amdgpu_virt_get_bios_info(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, uint32_t *pfvf_data)
+{
+	uint32_t dataexchange_offset =
+		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID];
+	uint32_t dataexchange_size =
+		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] << 10;
+	uint64_t pos = 0;
+
+	dev_info(adev->dev, "use data exchange information copied from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
+			 dataexchange_offset, dataexchange_size);
+
+	if (!IS_ALIGNED(dataexchange_offset, 4) || !IS_ALIGNED(dataexchange_size, 4)) {
+		DRM_ERROR("Data exchange data not aligned to 4 bytes\n");
+		return -EINVAL;
+	}
+
+	pos = (uint64_t)dataexchange_offset;
+	amdgpu_device_vram_access(adev, pos, pfvf_data,
+					dataexchange_size, false);
+
+	return 0;
+}
+
 void amdgpu_virt_init(struct amdgpu_device *adev)
 {
 	bool is_sriov = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index d122347ff666..64a61949a25e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -437,6 +437,7 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
 int amdgpu_virt_init_ip_discovery(struct amdgpu_device *adev, uint8_t *binary);
 int amdgpu_virt_get_bios_info(struct amdgpu_device *adev,
 					  resource_size_t *bios_offset, resource_size_t *bios_size);
+int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, uint32_t *pfvf_data);
 
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
-- 
2.34.1

