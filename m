Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA60CCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 18:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 815A110EC7D;
	Fri, 10 Oct 2025 18:49:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qLTD13eR";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB02110EC7F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 18:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueGNL5oyGO+dLRqzPgWq716eV+DIoUZ97egF0G9jdwcNqQ+7JinkB8GlBE4lhLfDfteQ5kepS0r+Nr92GNbv11Z05Cpk7kvsC7ZPe8+862BSLI+loN2DzPZnI4IGG8K7jpJBXcoysO+7AqG74uxW2o8mmC0uzFHxiYIx38ANXV4/9bnpClzJrYpORzE0AuQm7oX6+uoYBID0pll8L0ThR+CTereXkO0a8Y/M1CAEBsb7jKij9MU1OXdn1htHhs6GX+M1UCWyE6wMRDJCQvoEL2GEar2HsT7OZz3CX7Nv+qsohmVbI3n22W+7kkFNrUm1/q0Gnjp/jD9ksJh0sPl5+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XG7Qmiv1AajPOpomuovygYSInGF+EpxQT6HbXgMqL+g=;
 b=pOpq3cH2zK5gh8R9O2oDKc+ngOzqcI4TBF9m1cDdL4s3UI5NGu+RBJqUXCv1xKxECK7kovMRpUBCpD8RPEPmXHjyDHuD0WSuDipPKmd+j2Sb8nEvd+KGV18TVyBgs1kFaMBrrugpYj6JKqsVuEVrS57VQpogqdmBL5KxoHKOm5mk1kke2lA1+7mVMAwgNIdf9hiCDLWVE93jsq9D90PAiGAMBw8p9YvgWZ/H5mY0NRXP5SLHQU5qYNROyu8rDbUqVG0cE6vqTbqDa2J3HO7R+escmKkzZhFv2LIIHi6qfzppvPJX+UgioPXyawnv2fr6TyAwtQYZu58ODfiKPA8xXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XG7Qmiv1AajPOpomuovygYSInGF+EpxQT6HbXgMqL+g=;
 b=qLTD13eRiZy7/ZGzCeOW2WWV0uh+30IkqEvHwdfBlG2H+6sZYSxuERcgSM7aOJvJXaJ9o15j6ncQwxKAsXz886MkL5Wf6k405BUQewOJ2jlNWSeSz9U5cXqE4H3XXp0ytP3QpFRT+d6QPTQsnX6l+cxQBZG13aRB0Bo73XX7Ayg=
Received: from CH0PR04CA0068.namprd04.prod.outlook.com (2603:10b6:610:74::13)
 by SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Fri, 10 Oct
 2025 18:49:07 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::e1) by CH0PR04CA0068.outlook.office365.com
 (2603:10b6:610:74::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Fri,
 10 Oct 2025 18:49:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 18:49:07 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 10 Oct 2025 11:49:05 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH v3 6/6] drm/amdgpu: Add logic for VF data exchange region to
 init from dynamic crit_region offsets
Date: Fri, 10 Oct 2025 13:48:49 -0500
Message-ID: <20251010184849.9701-6-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010184849.9701-1-yunru.pan@amd.com>
References: <20251010184849.9701-1-yunru.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SA5PPF8ECEC29A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c882fb-0a28-4e3e-5438-08de082db123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RELOXMMxjiXFK5tOAeB+yGcBPFyrI74kvxeLc+DIjF4tF+Lj6gwU0xls4dVw?=
 =?us-ascii?Q?e3UtBAyDSqtaIVky3eHvY1G5+VyPMrdgXm4nn2vMKcEMR+pTa2aMxfngPKbf?=
 =?us-ascii?Q?PWwsJja8Jir+kwVu/eu9qVHr4RrUB0kTSCo1pbZlEzx2D3PCuDI8Jt2oy9gv?=
 =?us-ascii?Q?HRUFjGvEHLm5TL/aXOMfTp+okjbdiofGl/PBgurg4oHKvFRkaMzI2RDUxLxu?=
 =?us-ascii?Q?N/1Qw6sAg4yTrpFgh8eOko3qYxG40lQThX/IHlDaZ1ys4ws0vXG7HWrsSR6a?=
 =?us-ascii?Q?IY8NRSLM9Szw1H4k1SdLiQiyKqq+zIMICj/kNOo3+TWeWyRiva3sYcO8Nbhz?=
 =?us-ascii?Q?0KIHp4h+UnWjjMMsxpg9e7HJkRf05RMwU6PMw8wHTR7aI/1s5Z2QeYy1VK8Z?=
 =?us-ascii?Q?aGZt8yVoTPPsZMaAIUWta8rXD9W+fazDgAi55Q+7ynpON9zYeaUlMF3R1H1p?=
 =?us-ascii?Q?7cgiH8w4qqDd4LuM6a/48hHZmtdmtADdZBIh4rVVo17ssKBpwPZcLUpa0Fao?=
 =?us-ascii?Q?gt+BgSPFTPETA71yIzXv3LJpAxcTuHL4tueX4mkl3hBdqmd8F+O/qn4uvvnh?=
 =?us-ascii?Q?Il4M5HKZP8V1Vx5OC7+OFRKfr+cJ/FdbHuFbFxyIyLxxWRX2GyhcmOya0vxg?=
 =?us-ascii?Q?gN+DPI30t43Ap1PeQlNY42YAaYOw/NaP+yHqpzg6o5XDI5t/NZOf+5KEexlE?=
 =?us-ascii?Q?6hbG/OThCa2ETBfJuj5LIj6BjVgKFxFO8SyoW+WDyn9/JOpDPhLFPA9kINhn?=
 =?us-ascii?Q?r6kJ8sx/6cOJGsQ20bewtHyp/+/ZPCWVnh2Ku/5xSrXd5kkFirKr2GgEVeVh?=
 =?us-ascii?Q?2AGSszucTGc6E4uglMIk0ebAAi8+27V1d5AP/pdgwYcsAxkUZ6FpGNHrVsIO?=
 =?us-ascii?Q?RyXFDP3616RVrss/cNULI45My/aIQkIGvPCgnvAmrExjseX170WZJ/SCS9uI?=
 =?us-ascii?Q?tQ7KBRzGwRVqrzhF1XFhKYgmt9RmSajpqlXGpBG9fyYQZkU5X+vrsGea6sBj?=
 =?us-ascii?Q?izeAu6b1HfJADSTSKiJSQJLNYO+IIscrrf9u7Xjiqkvmbb7e0eEveV1AQA0j?=
 =?us-ascii?Q?tOyBlsiquieNqfurtPDfZtfBx7NAuN5iHa94rMf3WJzI9rGo01tgjQx4XEam?=
 =?us-ascii?Q?0RgBqVnvsSLTb5oEwJ0Fyo5CnpIQJlCwGhlHifJyX7xAvn6WsXhLyywRqRBo?=
 =?us-ascii?Q?Q4+DVYBi8LACqkPjZz32jVVqiD3tjH/wjEtQHjm7bRWNLc9kWZrk4d4a4hdx?=
 =?us-ascii?Q?QN2UAF9glnLF1Vo7EcVxoQJgxpC3/AAEFoMxtlEjtmqD1C4DwXJW00T9UAQ0?=
 =?us-ascii?Q?mbwHqK0GTJWkci6eJxHRNOeiy/vR5zUN2xLPjArOLmDod71cWS58C8pGU1CQ?=
 =?us-ascii?Q?6JkltMJ1c3gzWgZFbzRbelhXbjAE4t0Ibs2muLKC7/bnlwYDAP0RhxE/Xf9i?=
 =?us-ascii?Q?iFnVIMgYPLYSK6WLBjUWP333+iqWRvOcPhXuiS3lxPHTFepUESuAFvHv3Vxl?=
 =?us-ascii?Q?GXink3IUQ8XNokJiVSbK1G7l2Tsx8VrPwzxypDFsGzR0pNhQqzLGIEKAlYDu?=
 =?us-ascii?Q?VJgn6cEsCIXln9gd4dE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 18:49:07.1054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c882fb-0a28-4e3e-5438-08de082db123
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8ECEC29A9
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 88 ++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  1 +
 2 files changed, 77 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 4a7125122ae7..d99120b98188 100644
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
+				kzalloc(adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10,
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
@@ -1018,6 +1058,30 @@ int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, uint32_t *pfvf_data)
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
index 5d8e3260f677..4e9489ff295c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -440,6 +440,7 @@ void amdgpu_virt_init(struct amdgpu_device *adev);
 int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
 int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
 	int data_id, uint8_t *binary, uint64_t *size);
+int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, uint32_t *pfvf_data);
 
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
-- 
2.34.1

