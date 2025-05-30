Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733CBC5B549
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 09:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C58010E82E;
	Fri, 30 May 2025 09:04:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GrlW1adr";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9666810E82E
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 09:04:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hd8Az/D3VtVV7Cw6J66ET/+y084P+CVO8LqlS1XfgHn5vMiKXMXa+y8d+Rs/nGPf1mD79eoOUqoTiEDhzjjq4kWQZGClUJ3fdsoGdeTn5MbIVrgr75pZvsf7MK44/bwS1/hS2EbVMtn5VqjyqxLYMSyK2yZnF2njeGrUNgMcZDpPV86AjxCFI3qJFPUUxw9rEaxTfdMqGe/BqmFftRDnniCLPBxBZaVEx33zfhyVmnBEDZUdcwE/BoF1AOwkJZvWOxCHvhlB/0YPTbKqUpOhfrVSu0iIybpW2bSJIqDLqJaAKS2Y3vkawCljx1PBX19s62gGVZLJs6xzukAijwV3cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEg7rTsk/DnMqvsJp34rpfqZD7/TiQ+DWTkRNPWzXcw=;
 b=oRQzu0F4DXxGQLZ6qBvvLVi/2j9YCqg28PNaa0DyKclpgCSnNZn9/HbMaxkp3XrrOl82Y+KJg1b1eBG+D8iG/f2Zsvv/7FG0qRkv70TLSiDK7oUchNd6bXIg4XZ5HaAOhIAf5B4MVpjyaeYmGBHaA5gBBiTZToUlTQ3WKER2gJSNy6Kv/QV0fDG2G7mnq/cNDRNRKDrA+Y4WZ5KqfSfwvRfTJPyypEaXF5+y1bh96CnG8Gc9UFM5uXIWdIkVqNybgaiwKiMxmDGH9HvqEo7FrNRAvoE6LMyuFkPMVFeWAJ3Io6HStEeoeCjPFAUw3NKohRMmXaurcXMKWL1qPC+Zdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEg7rTsk/DnMqvsJp34rpfqZD7/TiQ+DWTkRNPWzXcw=;
 b=GrlW1adrOmZpsVA25p8PVsEcUNzcth8GzCpaRcD9ANZ+gLsFOaqaiIKGjzl30GrZ+l/s9jo+Cbfeid9fnJ7Bwcw2PAEJ9aCpeTyKh8FmX2oQ88eJhlxxg+loMfcH/myqZ3q/VhOLJWJnyxpw+8HvfVXzlfo/OG336mfJnMEdgV0=
Received: from BLAPR03CA0144.namprd03.prod.outlook.com (2603:10b6:208:32e::29)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 09:04:29 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::80) by BLAPR03CA0144.outlook.office365.com
 (2603:10b6:208:32e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Fri,
 30 May 2025 09:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 09:04:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 04:04:27 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 30 May 2025 04:04:26 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 11/14] drm/amd/amdgpu: Add HQD PQ address retrieval support
 for GFX11
Date: Fri, 30 May 2025 17:00:12 +0800
Message-ID: <20250530090322.3589364-11-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
References: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: 85eaf694-e3fe-438a-08ca-08dd9f58fb69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QlLAfNDktGYPVfK8c2ifWxt4c0OjMv5zRyRYpF53+6KuCFJWBTmA/i/nNRhs?=
 =?us-ascii?Q?7rzEBdM599Vk6kXkyEFE4NIvgcS5sORlQsdEYiwterjhnUuhtIIMHLIKJK1N?=
 =?us-ascii?Q?wNumcVvezVMisvli0VYtqKeYz59Qy2qVq7bolyhN9AwJFhvdj24zWLmzd4vU?=
 =?us-ascii?Q?pDTkWp5hFqa4EluUDSz3dgaSFwnuGrKJSZgDLZlg2adHipiGKJqhuuPEmzJw?=
 =?us-ascii?Q?s0qPSwuQdih30v+SrUze1Zy7Mt7eLqOUlOW5v934k25lPOtNty1UEkw+3Jgp?=
 =?us-ascii?Q?LT0NjwZfjS606s+QbYEpmyC+Jslp8T+M+X3pflJPnEfojBe0CAdgcYoHEXLI?=
 =?us-ascii?Q?OkHuyVFSy1S7v3Df3wnXEgyBSSO0K+Hel/TOgQS+n9lI2LAZDe5Zqlzv/e3c?=
 =?us-ascii?Q?mi++A8Qlnpj5hDyevALg9dcL7FphL1xfh6bGxmmpTqG09igXcFsmm1Z1rS4K?=
 =?us-ascii?Q?gf6tvB7GoELfxECFHjzJbyitA8mmrtTtnhHTx+N/UaBFpYVBM+dbf4jYWe2m?=
 =?us-ascii?Q?cfwfeIL3gxBCcJhOi+CUjAZmdeJxKkvV8qelvo+XEqeUJ/kxPFNcJl5yqk00?=
 =?us-ascii?Q?6f/cL7cKhOLfkEYutUuomuN+NS1xqW3cWtfxGLCXLOZX44sCTB9E10euk86B?=
 =?us-ascii?Q?eng3BvWeIjT5L7XfcBO4r5/Q/54EtJw3ULXIgPs/ycKv3rCkHho3cpTjWQVg?=
 =?us-ascii?Q?6UHx4jLqXxhXUAFick+EihOzsDf2HmqxgqR/H63siavthBSHT0zIVMTa8G7y?=
 =?us-ascii?Q?tvcd2HyZE5VpPcs6ujANBAFnMRVZMldz/oeIHg89LqeCtfY8UrU1u6C4NkmT?=
 =?us-ascii?Q?aZDlDQWZkv5avXN+ffj3f3aodNeYQYo0EceVAbgXhvNi65OBfTv7btO0HWAN?=
 =?us-ascii?Q?EOVvE/U9HCbToxX+ekIWv55xjSEg2McA9DOqpR4ZCCZDYrpRBl1PBhtScZqZ?=
 =?us-ascii?Q?c1hyIDvPJTSpUGZM64aXKVSPE9E91F1zHgsfrmH0QHKJqifk7PfKsdAKOCAX?=
 =?us-ascii?Q?uXVNnAtSfbu0RP36krbGpGWCNpQegPTvwv5RqsZS6WBoLUxp0yFwFrxGuBRL?=
 =?us-ascii?Q?7XXQ85QZGCocj0LeGHjuYlqDxj2U1FrUxX8h9RqxVuO24ukrTtP8cA7YCTDO?=
 =?us-ascii?Q?I3TwCpqC521yzeOWqvNUYXy9qZDekOe/O9oFQlqsOHcnCRLG9+mIGhdxQOhD?=
 =?us-ascii?Q?6JnD9bSfXaZCvN8VeE6AkWxDfcck9mA/Qehisa1FP9W4H4C1cED6mU0EZm31?=
 =?us-ascii?Q?wA8F7xIH6GZx1NFZ42XvofZrEFhn0LJQJYbXQfYbuXo7FFP5UqYrNvfCd6/Y?=
 =?us-ascii?Q?5q9u1kYEO3PRGKD+ff3MlPKj2AfAswteRvZCD4USgN+QTtJREcIDWiuNSeAe?=
 =?us-ascii?Q?5odsW/M1LEtQoYSPEvQ3qm4/YTj30MGXiCMHsV7iBgI+mpyF2Pic3cmr+Wc8?=
 =?us-ascii?Q?kF39+Q37MeBGchkQ6yQuZAjod30iS4ql7BPCCazoIHsnoj/cro/lSlyMnjWU?=
 =?us-ascii?Q?KCdD9fAF4NB9TMfsxO1eZYICuM//hN+8W/yV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:04:27.9959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85eaf694-e3fe-438a-08ca-08dd9f58fb69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615
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

This commit introduces HQD PQ address retrieval functionality for GFX11
hardware by:

1. Adding hqd_get_pq_addr function pointer to amdgpu_mqd structure
2. Implementing gfx_v11_0_hqd_get_pq_addr() for GFX11
3. Registering the function in gfx_v11_0_set_mqd_funcs()

Key features:
- Supports XCC instances for Compute queues
- Checks HQD active status before accessing registers
- Provides accurate queue address calculation combining high/low registers
- Maintains compatibility with existing reset mechanisms

This functionality will be used for hang detection and queue management
operations that need to identify specific hardware queues.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h    |  4 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 49 ++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7365558f47a1..927375ebafa1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -892,6 +892,10 @@ struct amdgpu_mqd {
 	unsigned mqd_size;
 	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
 			struct amdgpu_mqd_prop *p);
+	uint64_t (*hqd_get_pq_addr)(struct amdgpu_device *adev, uint32_t queue_type,
+				    uint32_t me_id, uint32_t pipe_id, uint32_t queue_id,
+				    uint32_t xcc_id, uint32_t *vmid);
+
 };
 
 struct amdgpu_pcie_reset_ctx {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index afd6d59164bf..95509adabd77 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4152,6 +4152,51 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
+static uint64_t gfx_v11_0_hqd_get_pq_addr(struct amdgpu_device *adev, uint32_t queue_type,
+                    uint32_t me_id, uint32_t pipe_id, uint32_t queue_id,
+                    uint32_t xcc_id, uint32_t *vmid)
+{
+	uint32_t low = 0, high = 0, active = 0;
+	uint64_t queue_addr = 0;
+
+	mutex_lock(&adev->srbm_mutex);
+	/* Enter safe mode to safely access HQD registers */
+	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
+
+
+	/* Select the specific ME/PIPE/QUEUE to access its HQD registers */
+	soc21_grbm_select(adev, me_id, pipe_id, queue_id, 0);
+
+	if (queue_type == AMDGPU_RING_TYPE_GFX) {
+		active = RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE);
+		if (!(active & 1))
+			goto unlock_out;
+
+		*vmid = RREG32_SOC15(GC, 0, regCP_GFX_HQD_VMID);
+		low = RREG32_SOC15(GC, 0, regCP_GFX_HQD_BASE);
+		high = RREG32_SOC15(GC, 0, regCP_GFX_HQD_BASE_HI);
+
+		queue_addr = (((uint64_t)high << 32) | low) << 8;
+	} else if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+		active = RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE);
+		if (!(active & 1))
+			goto unlock_out;
+
+		*vmid = RREG32_SOC15(GC, 0, regCP_HQD_VMID);
+		low = RREG32_SOC15(GC, 0, regCP_HQD_PQ_BASE);
+		high = RREG32_SOC15(GC, 0, regCP_HQD_PQ_BASE_HI);
+
+		queue_addr = (((uint64_t)high << 32) | low) << 8;
+	}
+
+unlock_out:
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	mutex_unlock(&adev->srbm_mutex);
+
+	return queue_addr;
+}
+
 static int gfx_v11_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -7400,11 +7445,15 @@ static void gfx_v11_0_set_mqd_funcs(struct amdgpu_device *adev)
 		sizeof(struct v11_gfx_mqd);
 	adev->mqds[AMDGPU_HW_IP_GFX].init_mqd =
 		gfx_v11_0_gfx_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_GFX].hqd_get_pq_addr =
+		gfx_v11_0_hqd_get_pq_addr;
 	/* set compute eng mqd */
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size =
 		sizeof(struct v11_compute_mqd);
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =
 		gfx_v11_0_compute_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_COMPUTE].hqd_get_pq_addr =
+		gfx_v11_0_hqd_get_pq_addr;
 }
 
 static void gfx_v11_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *adev,
-- 
2.49.0

