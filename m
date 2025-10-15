Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29342CCD193
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 21:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD1D10E8FB;
	Wed, 15 Oct 2025 21:49:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bT0QSkoW";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013053.outbound.protection.outlook.com
 [40.107.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA73F10E8FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 21:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfn7U2tOKbkD6SOl20NW7VVVoKfGEnu7ZaO/f3FW+xkElIV5xdwfDvCNKj3P9VzSWyren5YB7fVXEMOSsiELARq43nIy8R2rPYa6smwzFNfmE7row8bynTrOSSQAnMLvPpd3GTMpKw2veGWIvklYEAYH/XYV3Ix+nAvaodMruiis87VylHnzf3ek1gK+IE/jhz3ughD2r37xAdn7a2JQnOolqs4T22acwb4P49zbBEYGbOn6Cw5KlgO1SHSf53SMD3DsW/E1mdOxpR/ebsuTHPiphRqdTtccDpNBqi2Fx0BvOpEZTVPnM6SwFuVwz/yvACbPXzk9eJpDK/4nO7PPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7zYZVHMft5VRplv5vxTVJgby+cNZdf3mZk/RVhrbWY=;
 b=Hm18VZvxS0eRhELKieX5GpZwzl9hyh5SyHbWsM+CyfFpDjh78+UcW2SsnSjvy3zBNwprYWLHW75N0MNq7OuT9QTcEEPE43KO2NIGtaFT6Tz7ChyFKsscn72ugJQuDQjrJq+L1iDFYCPv7dmAd1ods2xXiMZAN65XzhlDUEaB8vJ2GLjdmey50fBtDHGUWUy6zLGAy6drp9kwOwyue4W3QUwlbCy/8lc/yDgmIaHJpc/Zpy/KPOOqHPwF7P303xQbSxDocOUvH7aGm6S5WqZ6ogWPtUhxbDdK2GOt5BTHIZGl48F9Sto6ZIvY1pPMXa17i3VbM2OElKIQfu1+tOZq4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7zYZVHMft5VRplv5vxTVJgby+cNZdf3mZk/RVhrbWY=;
 b=bT0QSkoWs2/9O7TLMaLH0bM2mPbIohl0Mt7ZQ4TBDb0abhw1/LKBU8VOC+dh6l50xl6a0zjWh43oBe/xC9XctOhyHQ7ttiNahVEYqiznhlLX9xU5kCTf9Oc6Asod9RvyXZab3XIlJaSpZDViiPN6+HeSWQos3VMTPEoWBdsBOUo=
Received: from BL0PR02CA0093.namprd02.prod.outlook.com (2603:10b6:208:51::34)
 by IA0PPF73BED5E32.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 21:49:09 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:51:cafe::46) by BL0PR02CA0093.outlook.office365.com
 (2603:10b6:208:51::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 21:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Wed, 15 Oct 2025 21:49:08 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Oct 2025 14:49:03 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH v5 6/6] drm/amdgpu: Add logic for VF data exchange region to
 init from dynamic crit_region offsets
Date: Wed, 15 Oct 2025 16:48:48 -0500
Message-ID: <20251015214848.11580-5-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015214848.11580-1-yunru.pan@amd.com>
References: <20251015214848.11580-1-yunru.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|IA0PPF73BED5E32:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e40c47a-47f3-40ca-564f-08de0c34ab99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T2Wz5hK3fabzBXTviAcmcXUl29Jj45Nee06/wdyCHBI0UqMj+t4oewIsvr4a?=
 =?us-ascii?Q?lmDTxxU8tILJWF6k0VtpHF6O6VCnqIt5k1NuC4i6rEJkcq1/DY1WT1Gx+2cA?=
 =?us-ascii?Q?nF0LxKfxoMEmlHtfsJM3tHPfjLBVeXxMvtrO49Wr3CVwwFixeCEaYTlhWV3D?=
 =?us-ascii?Q?Y3EZpOcmSk+8S2OGhcieIq1smM7KYQRlG0tot8AdROnpGf4vhkHVifm4u+kL?=
 =?us-ascii?Q?o5A+WdTBQU7FtGr9QDCZyWMsRoDNJ5C/JCDzQR9PvMQPvZOunNBOVCkWdn1g?=
 =?us-ascii?Q?DHxdiYHPeF4XjWaH7+PBMSFGuOy+KxrKbDa+zTkCFS86tz0gV2euM1Q+IHY0?=
 =?us-ascii?Q?ZmpdF4cLaGCOjAZfg3dUlONpxNJER6OtBxv4BPuuZGxd0aKTPU+7LGSdSY0q?=
 =?us-ascii?Q?fz5U+y3No7dX4b5InFkm+cpikhOiV8ZphsioVnaOB4MD0FCWZ4MatXI5sCWE?=
 =?us-ascii?Q?xZ5q6T/cAla2qJ7qgYBYfgY4N5j36XUla8DWo1Lb3lZIWLGNwx1w5W0YlD6o?=
 =?us-ascii?Q?tf/6o4oOl7GULko5wwK6f01LHdsIJkh92Kzted+sabddW6G7D8pImlQNq1kF?=
 =?us-ascii?Q?WoWEy4i48qfDkOXAXUKRONbebHd1lK422l3cX/siPgI1kA+Cmfbpu0SBqL0/?=
 =?us-ascii?Q?ncUFM7/Duhi+LRnvZ2ZCNIrrhy/os12XRa2EwTZdHRv0qfGN0r3N9nCOTXDY?=
 =?us-ascii?Q?9g3KMxb07jwTJOsJklCD42WjtwXtQbiirEfzfExU6kul1T0odvDz+6jEguex?=
 =?us-ascii?Q?A4qTXyQDa1IuEJfAA9bn2yPEsFdF7o+INz0pykrdnPZQlth11islQZ8cRHUu?=
 =?us-ascii?Q?ISY+vW2y5ZFKLXGLvAepd3qDC5mw364DV31mZQdDFCF6toVl84+cnYfEOrmR?=
 =?us-ascii?Q?vXDuBHzYXOxDEaRpzB9qdBcFr05pPCp2jEQ0ZjNo27ovTLLnLRo7upFU45R2?=
 =?us-ascii?Q?M0T12IxOMEN8J5peb7jOGU3rXCh3ECbBC3Hq0WhKUycLhvO7rXC+J9RtoRzP?=
 =?us-ascii?Q?5F7+yMmru7EQEWBbWR54WAPw5m88C6gwbp1Jyh5b8S9DW13grHBSj79uSbgd?=
 =?us-ascii?Q?qmQvKSW2bDv65VmY637usFOFjMA3xkdqUQEtFKBjb3mbfhBqRSEA8vBIfcpW?=
 =?us-ascii?Q?IDxWlyehOxHe5WVCdOMMRrUdHuXTmSSE1vWQQ9LiAOIqPvrqVkfP65h1jG7C?=
 =?us-ascii?Q?DiAxKiyiiXCkf2ciyxUYMEI17L2rtJt1oJkrlol1Vs+m7K/cUhZ+xdt3ybL6?=
 =?us-ascii?Q?l9EKCDzxq7u3gqBeyidXCC0yr/bET3Gv4F2855Fvr4oaG+Ufh7u0hw73E5rC?=
 =?us-ascii?Q?mcFgq98IaK44UeEerKFC4F986+z0vmaY39pNNxNFqhSwXZPperR+As2kpueB?=
 =?us-ascii?Q?V3efkt8lcDd6K8q9YAoYY9ILuccs5TBgJd0CMjrJugkxO/f9Np1LqGPPvddJ?=
 =?us-ascii?Q?PS1bEU3zt8E+9Vu+W+//ScuPZ+Okk0QsnV2RjdWz49NlRT5r0iWcTQKG569o?=
 =?us-ascii?Q?0dBZZrGELzRzIrePFt8/E8QLEx1rkyo9SXaqnFSPtO0J0etipaHlu/5xBKNd?=
 =?us-ascii?Q?yIpUguYv+llKj/FjsDo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 21:49:08.9535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e40c47a-47f3-40ca-564f-08de0c34ab99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF73BED5E32
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
index 15157ed5df29..fe9a806dbf34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -218,12 +218,12 @@ int amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev)
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
@@ -403,7 +403,9 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
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
@@ -671,10 +673,34 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
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
@@ -682,13 +708,15 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
 
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
@@ -697,11 +725,34 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
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
 
@@ -714,14 +765,29 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 
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
+					(AMD_SRIOV_MSG_SIZE_KB << 10));
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
@@ -829,7 +895,7 @@ static bool amdgpu_virt_init_req_data(struct amdgpu_device *adev, u32 reg)
 			break;
 		default: /* other chip doesn't support SRIOV */
 			is_sriov = false;
-			DRM_ERROR("Unknown asic type: %d!\n", adev->asic_type);
+			dev_err(adev->dev, "Unknown asic type: %d!\n", adev->asic_type);
 			break;
 		}
 	}
@@ -1501,7 +1567,7 @@ amdgpu_ras_block_to_sriov(struct amdgpu_device *adev, enum amdgpu_ras_block bloc
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

