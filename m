Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E01CCD1BF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 14:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A7D110E04F;
	Tue, 28 Oct 2025 14:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t1eC1wqF";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EFC610E04F
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 14:13:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhvK8omGnKmwiEgL5sV3iNueS7O307JPuJd+ziK5yDcMc2l1ElLbWLwdqh1PCQ5U9GFMjMIQMAOsPSjoMR7yYQklyj0QB6H+kSoF3UIgshirwF+Dk8QAZXJzeMQu3M/swMZjuq4BVYB2NNCPtt0SVH7da8OuUDdiOAqdfeq/dqiuNr6A9p1EEzoAqVkcv5vMdW3bkk4FkZaIBaxJDiWxnIo4Ni3Hgbxf+QFoLzsZUD1zSEMmvp88L4iQydkoOYizEeKzx6Q/ZgRTqe0ALjBSAlMUV+gsq8y1iCXWtYsyj2BCvBlqByew8auf+b3FlcxYdCaaXuVs/Pv9X8IRIGUaKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UnmRzpLo4O9iJaqJcPMcLhMkjtvTFIPnM7kgbS1e2c=;
 b=Q+dAHShSIiJ5HLzjBjWAsgS1CA5zPpz3cS02zLU5tn/MCcAldRxTk7Z8uCBgrla3XqkPxegao9TowIK1a3RotudfT5xq0SLHwweSMn62Y1JbUV8La5HgaLU4+GY/6V85oFyorhbljqLfZCqHzquCKTcfbeXioiIxN6vU1lBu0PaUE1nn024yDNuRTbXTLVoC6hhIaq/Vp7a+SijTcmOkeSHs1XBXCxTD/cDKL8zdu97mJpLaSXV6eFamKrjzpPP3AVfairX5LVk3+5fuQi42y3sJ887AoI9u7UIYbpwOVVdJpMowdh2xUiUaAV3/SIb7oq8HGK44eH+I8lt962mT/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UnmRzpLo4O9iJaqJcPMcLhMkjtvTFIPnM7kgbS1e2c=;
 b=t1eC1wqFQcaRkHkjwKEqHxsixYWd6Us4G0hWPze+cWteQNWlR8QoP0fliLJZHwwVyb0yRSjqxu1g7u7pmyiQT24VqXBKnUKBTgjtT9WIQV3w1e1SNaU62iicC4ITD8IMTve0lBbVkT6SEX6YZTqnhazodyOmga+yXIGCPdOhGoU=
Received: from MN0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:208:52d::17)
 by DS0PR12MB6488.namprd12.prod.outlook.com (2603:10b6:8:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 14:13:45 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::69) by MN0PR04CA0026.outlook.office365.com
 (2603:10b6:208:52d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 14:13:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 14:13:45 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 07:13:40 -0700
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Remove invalidate and flush hdp macros
Date: Tue, 28 Oct 2025 22:13:28 +0800
Message-ID: <20251028141328.3302820-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DS0PR12MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5bed0f-c03e-4662-de77-08de162c34cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vMT5zGf0gV4Y9h6JPbJOx8ORnUacf20CN4Py3NsHBuCQ3HVOBbt1Q1s/iK1G?=
 =?us-ascii?Q?qHyh1/LQVv7rfxf6zkfGGm9r+vYHqqy6OXCCTYYNOdYyG1xawNSy+eAaKBwF?=
 =?us-ascii?Q?SMgAAk2tM1y2oMbFq/QnOPUG8oQmwlLDlcgEzirnr5yf15HZKEGjOABcARs1?=
 =?us-ascii?Q?E88+uY/9tXSn2glmOQwuKDa44PKkauOdkmoEL9C9oWBTLfHSGe0qTIrH+PI7?=
 =?us-ascii?Q?yf4VGRRVhgP+/BPpcZGcEC2HQWxA140UpSai9g0eAiv8NTEb3w9qJmA/34Mp?=
 =?us-ascii?Q?LFhw8MFfOflHKIJpemtnhOc8FdezcdCD5zJ6ds+YGOs97hqO0hJv/ejR9Ee4?=
 =?us-ascii?Q?vmdVduVCvp/EmC0kLhBOzEYEHZpTj4IbsKC81bC9Rt1iP5ZmTQ+VuHv7E8tY?=
 =?us-ascii?Q?61bBZU7LR1P6qSd4iz10OFK+P1BkQX/C7ntKfnYrZc7X+jRN8vI9/kYcPYjD?=
 =?us-ascii?Q?cqrGxBeLVxiRPSpNyD+8O/SpU1egqttgJlX7u5CHOHikYDyACRd3uXn1rlhC?=
 =?us-ascii?Q?5blj4JRERurZ1rhx1cKGyvx9PUjqNIqbi5AzymLElYZyK/6MURAwFbvf2pGD?=
 =?us-ascii?Q?n/HKL7anAtW0wFUeRGwTWR8SsbOxVfb9hawYLXPSYDDfN/cknvXqXPyhZVbG?=
 =?us-ascii?Q?nGVweptbOAaigxACWMfI+BCfBIFF6gwsptgeZXK4DVSTEQTun7M59S/b670b?=
 =?us-ascii?Q?2e3L0TxlALV16CbQ/+3jmK1chJm24EN3hblhQmFkifhCwyYTKbziW3CLIEug?=
 =?us-ascii?Q?k/dMLBxWyQ1teuMI+oIUSY+olXSsf9KNXSIypd+BAOu2xuV4RdMqEITt11X7?=
 =?us-ascii?Q?wrybfA5kNzbwHftgmhgkLIFpsGaCWyZm9CQHV11jX3V+PcnxokkTSBPWExhs?=
 =?us-ascii?Q?BcGE3UyyDVyfo3ROOI9riEhzad9tPqQJaMH+TyHbD4z6BYt7WXF747ZHwmJz?=
 =?us-ascii?Q?cVvnANrYA3/1Ufm1RRn0dAvPlgR8yriiJ/TAYtjpRLy6GYld1cQ/qu8z6VhX?=
 =?us-ascii?Q?B4BYV6w3Sw/atL9eHaljCCjkrNBcVNpCbGMJX2pwrkeJ/pC+AiLLGNscjyaw?=
 =?us-ascii?Q?e8Mh375hpw2uq1UG622TGs6M9C81c3D2sLKUPzlLTbWdGnfjGfAsDylGULI8?=
 =?us-ascii?Q?m+grQePemLBB4ckHQdoZSHGZh9cOQkLlfC4NLPw8GYW0M4hL3dl/v8uU+xZU?=
 =?us-ascii?Q?pEvZgyZP30+P8eJ6IykL+RO01s6woHByhYYJBv63WHAsLuyJ/7CGhe9TbMg8?=
 =?us-ascii?Q?h5FUl/EFazSJcaco69lJB6itM77eeCBCXa9mDdP0UmgUCUOM4fn86mxAEI7Q?=
 =?us-ascii?Q?x25FC5+0eCAn5yMjRXjfmjA8q5SYT0TXZNBZPSHaJnyB0otoZXsztKHinRaM?=
 =?us-ascii?Q?xRiBDbM0zk5JLazuNXUgj7fATrumB0PMcSgNDrXFV5rTaiNHC+FywwZtoCQj?=
 =?us-ascii?Q?lOAAc6Phqv3LbMJoYZB9PMboap8nzpU9Grl4/yJtfkK2HgLu7WGm/lDCEZtd?=
 =?us-ascii?Q?XqYWa2TRLi8AG4fLdxFX9rAp+dupfwZKBkocgRHNgimVsjv8D9QU7Ri3/8mU?=
 =?us-ascii?Q?frgm1+SNojEbsOOvMfg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:13:45.3165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5bed0f-c03e-4662-de77-08de162c34cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488
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

Remove amdgpu_asic_flush_hdp & amdgpu_asic_invalidate_hdp functions and
directly use the mapped ones

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                     | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c              | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                  | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c  | 4 ++--
 drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c | 4 ++--
 drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c | 4 ++--
 drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c | 8 ++++----
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c   | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 6 +++---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                  | 4 ++--
 11 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d1137d8beca7..bcfed46eedaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1539,8 +1539,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_asic_read_bios_from_rom(adev, b, l) (adev)->asic_funcs->read_bios_from_rom((adev), (b), (l))
 #define amdgpu_asic_read_register(adev, se, sh, offset, v)((adev)->asic_funcs->read_register((adev), (se), (sh), (offset), (v)))
 #define amdgpu_asic_get_config_memsize(adev) (adev)->asic_funcs->get_config_memsize((adev))
-#define amdgpu_asic_flush_hdp(adev, r) amdgpu_hdp_flush(adev, r)
-#define amdgpu_asic_invalidate_hdp(adev, r) amdgpu_hdp_invalidate(adev, r)
 #define amdgpu_asic_need_full_reset(adev) (adev)->asic_funcs->need_full_reset((adev))
 #define amdgpu_asic_init_doorbell_index(adev) (adev)->asic_funcs->init_doorbell_index((adev))
 #define amdgpu_asic_get_pcie_usage(adev, cnt0, cnt1) ((adev)->asic_funcs->get_pcie_usage((adev), (cnt0), (cnt1)))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b92234d63562..962380af4ee9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -7327,7 +7327,7 @@ void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
 			return;
 	}
 
-	amdgpu_asic_flush_hdp(adev, ring);
+	amdgpu_hdp_flush(adev, ring);
 }
 
 void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
@@ -7340,7 +7340,7 @@ void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
 	if (adev->gmc.xgmi.connected_to_cpu)
 		return;
 
-	amdgpu_asic_invalidate_hdp(adev, ring);
+	amdgpu_hdp_invalidate(adev, ring);
 }
 
 int amdgpu_in_reset(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 3bd44c24f692..de7a1e168a76 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -342,7 +342,7 @@ static void sdma_v5_2_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
 	if (ring->me > 1) {
-		amdgpu_asic_flush_hdp(adev, ring);
+		amdgpu_hdp_flush(adev, ring);
 	} else {
 		ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0 << ring->me;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
index ac9ec8257f82..38e19e5cad4d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
@@ -139,7 +139,7 @@ static int smu10_copy_table_from_smc(struct pp_hwmgr *hwmgr,
 			priv->smu_tables.entry[table_id].table_id,
 			NULL);
 
-	amdgpu_asic_invalidate_hdp(adev, NULL);
+	amdgpu_hdp_invalidate(adev, NULL);
 
 	memcpy(table, (uint8_t *)priv->smu_tables.entry[table_id].table,
 			priv->smu_tables.entry[table_id].size);
@@ -164,7 +164,7 @@ static int smu10_copy_table_to_smc(struct pp_hwmgr *hwmgr,
 	memcpy(priv->smu_tables.entry[table_id].table, table,
 			priv->smu_tables.entry[table_id].size);
 
-	amdgpu_asic_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 
 	smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
index f9c0f117725d..0bf1bf5528c2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
@@ -60,7 +60,7 @@ static int vega10_copy_table_from_smc(struct pp_hwmgr *hwmgr,
 			priv->smu_tables.entry[table_id].table_id,
 			NULL);
 
-	amdgpu_asic_invalidate_hdp(adev, NULL);
+	amdgpu_hdp_invalidate(adev, NULL);
 
 	memcpy(table, priv->smu_tables.entry[table_id].table,
 			priv->smu_tables.entry[table_id].size);
@@ -90,7 +90,7 @@ static int vega10_copy_table_to_smc(struct pp_hwmgr *hwmgr,
 	memcpy(priv->smu_tables.entry[table_id].table, table,
 			priv->smu_tables.entry[table_id].size);
 
-	amdgpu_asic_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 
 	smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
index d3ff6a831ed5..e2ba593faa5d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
@@ -68,7 +68,7 @@ static int vega12_copy_table_from_smc(struct pp_hwmgr *hwmgr,
 			"[CopyTableFromSMC] Attempt to Transfer Table From SMU Failed!",
 			return -EINVAL);
 
-	amdgpu_asic_invalidate_hdp(adev, NULL);
+	amdgpu_hdp_invalidate(adev, NULL);
 
 	memcpy(table, priv->smu_tables.entry[table_id].table,
 			priv->smu_tables.entry[table_id].size);
@@ -98,7 +98,7 @@ static int vega12_copy_table_to_smc(struct pp_hwmgr *hwmgr,
 	memcpy(priv->smu_tables.entry[table_id].table, table,
 			priv->smu_tables.entry[table_id].size);
 
-	amdgpu_asic_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 
 	PP_ASSERT_WITH_CODE(smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
index a5c95b180672..e3515156d26f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
@@ -192,7 +192,7 @@ static int vega20_copy_table_from_smc(struct pp_hwmgr *hwmgr,
 			"[CopyTableFromSMC] Attempt to Transfer Table From SMU Failed!",
 			return ret);
 
-	amdgpu_asic_invalidate_hdp(adev, NULL);
+	amdgpu_hdp_invalidate(adev, NULL);
 
 	memcpy(table, priv->smu_tables.entry[table_id].table,
 			priv->smu_tables.entry[table_id].size);
@@ -223,7 +223,7 @@ static int vega20_copy_table_to_smc(struct pp_hwmgr *hwmgr,
 	memcpy(priv->smu_tables.entry[table_id].table, table,
 			priv->smu_tables.entry[table_id].size);
 
-	amdgpu_asic_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 
 	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
@@ -256,7 +256,7 @@ int vega20_set_activity_monitor_coeff(struct pp_hwmgr *hwmgr,
 	memcpy(priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].table, table,
 			priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size);
 
-	amdgpu_asic_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 
 	PP_ASSERT_WITH_CODE((ret = smum_send_msg_to_smc_with_parameter(hwmgr,
 			PPSMC_MSG_SetDriverDramAddrHigh,
@@ -306,7 +306,7 @@ int vega20_get_activity_monitor_coeff(struct pp_hwmgr *hwmgr,
 			"[GetActivityMonitor] Attempt to Transfer Table From SMU Failed!",
 			return ret);
 
-	amdgpu_asic_invalidate_hdp(adev, NULL);
+	amdgpu_hdp_invalidate(adev, NULL);
 
 	memcpy(table, priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].table,
 			priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index bbf09aec9152..7c9f77124ab2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2889,7 +2889,7 @@ static int navi10_set_dummy_pstates_table_location(struct smu_context *smu)
 		dummy_table += 0x1000;
 	}
 
-	amdgpu_asic_flush_hdp(smu->adev, NULL);
+	amdgpu_hdp_flush(smu->adev, NULL);
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					      SMU_MSG_SET_DRIVER_DUMMY_TABLE_DRAM_ADDR_HIGH,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index cb3fea9e8cf3..a0c844bf852c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -449,7 +449,7 @@ static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu)
 		return ret;
 	}
 
-	amdgpu_asic_invalidate_hdp(smu->adev, NULL);
+	amdgpu_hdp_invalidate(smu->adev, NULL);
 	smu_table_cache_update_time(sys_table, jiffies);
 	memcpy(sys_table->cache.buffer, table->cpu_addr,
 	       smu_v13_0_12_get_system_metrics_size());
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 0a7d2cea7dc6..e1f9aa5d6c20 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -766,7 +766,7 @@ int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metrics_table,
 			return ret;
 		}
 
-		amdgpu_asic_invalidate_hdp(smu->adev, NULL);
+		amdgpu_hdp_invalidate(smu->adev, NULL);
 		memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
 
 		smu_table->metrics_time = jiffies;
@@ -845,7 +845,7 @@ int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
 		return ret;
 	}
 
-	amdgpu_asic_invalidate_hdp(smu->adev, NULL);
+	amdgpu_hdp_invalidate(smu->adev, NULL);
 	memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
 
 	return 0;
@@ -2385,7 +2385,7 @@ static int smu_v13_0_6_request_i2c_xfer(struct smu_context *smu,
 
 	memcpy(table->cpu_addr, table_data, table_size);
 	/* Flush hdp cache */
-	amdgpu_asic_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_RequestI2cTransaction,
 					  NULL);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index a8961a8f5c42..3b98065dac1d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -980,7 +980,7 @@ int smu_cmn_update_table(struct smu_context *smu,
 		 * Flush hdp cache: to guard the content seen by
 		 * GPU is consitent with CPU.
 		 */
-		amdgpu_asic_flush_hdp(adev, NULL);
+		amdgpu_hdp_flush(adev, NULL);
 	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, drv2smu ?
@@ -992,7 +992,7 @@ int smu_cmn_update_table(struct smu_context *smu,
 		return ret;
 
 	if (!drv2smu) {
-		amdgpu_asic_invalidate_hdp(adev, NULL);
+		amdgpu_hdp_invalidate(adev, NULL);
 		memcpy(table_data, table->cpu_addr, table_size);
 	}
 
-- 
2.46.0

