Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88F3D5B85B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 18:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DA8E10E4E2;
	Mon, 15 Dec 2025 18:16:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wvjpab7g";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC4810E4E2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 18:16:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TevPj5OHQBtXREhKUnFFqClPE24HVXwSewxZMupVchJPaWlb6jQ+GZ07ZWCE5TeHRUF+Hq24TXCrBfrPQTLTfLqLH9VxYJPL9t2OmMWdWc0jsKKUbjWexR20MzgWhCOj9sGPLzZApz1zQfrmfcnyhN8/pqYNNxcihNKVjJ+BWVeDSJpmezeX/jw77NCuWvaCXy3d+6igIvSjICmKdgy3PmZPEp2AMRLzafIri/6g74WeqNfTqESDDZqxtnfzNEykMXtIcHnYc2N0erQ7OwhPfbOQ1Jf0Kh1MqQ4yDWw3lrS75fB1pPKG6HQAKOQ5UHIJk+yjXx73jLrc+h+vuBTTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liGpJL4RxcSOycMV7ECLZw1EKxX/nhM9HtpNZE9lVt4=;
 b=x+DQ4q4t7XVpqc4dV+WIehw/MOzG5WBE6JL/bo3dlKJomPwxHJOyvlxa9UZtGKM90YT3FwnBlyHgTTf6O4ppcrl2UurxLEGk69L++/hu3RS3YHav+EXrEnEQG8VRKxW75ZWj7xf+fep3BB9veHN4LqlK/f52oZ0t6za6He6a09+zYR2vNiXye6V2C9UII5WnP/5r+vtG2bXPS1JLQ8Td47c/lY7aUV6WQ9Iu3J4OBvm08Psh935dOI9PepILbt17omVPoA9ITnbhKFc9+j2+PuQ6ZpuFrqHuUXQyIoMRgHBkqBXEHJa2UfZqYpAepeA9HalbGjTpC7m0QDfyIBrORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liGpJL4RxcSOycMV7ECLZw1EKxX/nhM9HtpNZE9lVt4=;
 b=Wvjpab7g7VqA9TYggi4QF394KTFqdynbEltthDzzkOST4ro32nnXKEZTMYJ84s2q0a1bfAsba/TiT+cgm3KFh55J1HAxD8/DOnGPnEaV6A6tLPnayvSiceBnedOW/jFml9flVk8msMIg4dMRFVj1a5hynDNZeACV6/ptc9Lpl80=
Received: from BL1PR13CA0235.namprd13.prod.outlook.com (2603:10b6:208:2bf::30)
 by CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 18:16:40 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::f0) by BL1PR13CA0235.outlook.office365.com
 (2603:10b6:208:2bf::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 18:16:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 18:16:40 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 12:16:30 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix xcc_id input for soc_v1_0_grbm_select
Date: Mon, 15 Dec 2025 13:16:07 -0500
Message-ID: <20251215181607.29132-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215181607.29132-1-alexander.deucher@amd.com>
References: <20251215181607.29132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|CH1PR12MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8fa37d-eeeb-4a0f-e98f-08de3c06182f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6arEK/VAw6MaaZ7P4H51YALxomp3SmlhPj9LBMLamnAepzAk+BUSOiTKorOx?=
 =?us-ascii?Q?n/79Z/g+3Gv8MQM15mLscilNMTN+g2RMJFv4t0dYPn7SM4I3/lHXNuWyGOow?=
 =?us-ascii?Q?xX0dKHEmL4W/PpmaAh4Sbnf/Mj+3ihhoTU2QNoCcGl3gPzemG7smphdijBG7?=
 =?us-ascii?Q?g4W8fZ4FWZ2i6YoiYuVaY/0helcgZpwfyoK0JDR3nS3otGqYnu6IwrcoGLU1?=
 =?us-ascii?Q?Me8ld83eX/nsIbUFzGnDSTp4FuBezPTiyFQwtZ2KBeOK832vp8TjeYz2o3ei?=
 =?us-ascii?Q?6A7hy9QNCjhUfGSV9Gwx8gcvT+xGF3EZNmqL4KByX3/0uO1L4ksAvEief2K7?=
 =?us-ascii?Q?IlfE4vbKvYdBNDogxqY6oSRnVV7a8UOPu8bUR1oB+izEZvN2Y55baX033RJv?=
 =?us-ascii?Q?WuS5zf2Dj22aWPYuzf3ES9H7QDQXo5DzPzFDiero1qh2E+6OR+tbT6Iz8/vd?=
 =?us-ascii?Q?jssKDB4/kSE0nggxVDOlPJwkqD57y1jilc2SIDlp/lLQiXacdAUvLBQbbmcH?=
 =?us-ascii?Q?x7y+H7q1VHgR7Cp4/5LGh1lc5QS6XSiLFomvh5onukpAXoSttds5uk+TMD2J?=
 =?us-ascii?Q?bdZBKHsX41i9lNykr3nGJRoMWank+JeHqglpNh6kQibzgDKnXt7wPOQxsjrp?=
 =?us-ascii?Q?sLvRQkAN+OwwC1Q0XQbeSODWBOcjK10G0nnsxFyxjLhb+Q/F2JmruXBybjKX?=
 =?us-ascii?Q?Rvn1jpSvlVicibhZLC/oRa9bP+B4u31kONURlAN2DAhgWC2w0xo2NDy87LJ3?=
 =?us-ascii?Q?aCOEdhuTri9aYStWNuGBFgYzqX+qp9Y8kFNPXKAmMtfl7wZVAU960ZfFdjM3?=
 =?us-ascii?Q?MqFYA876DM6OdkU+s928p2q8tl4hWMCq0EIm14O4Pn3TKxkroYmq5Aac04xp?=
 =?us-ascii?Q?+h7fBLa06NXDngDnxDwXtjgGzK2AlDyAd4KlbbrOU33VqoXwHGXZH5wmof1P?=
 =?us-ascii?Q?Y3MoRGrAl+JilTlU/VA6CdrEozlOzSPwAbPIv9KvowTcVAxIJNQNMGu/DveO?=
 =?us-ascii?Q?YOM0b1u2gs057TeaYICd1UO3rgWPF2BA+yPWaMIrQeDIvE4BlbP9CPZ91PiV?=
 =?us-ascii?Q?1g9atGl5RdIFsZK7+PJaDH9/Zy9hdZ888pARH03y6FdOpmO3J0AVCq80NVKY?=
 =?us-ascii?Q?CntuXtDkv3IH70HLXEf3e7QDF1cEwyKM4mI5qSW5HVLUlN3Dcdgb8eRrEAMy?=
 =?us-ascii?Q?06Ww8mYfP+PfA1w++P58fNAsf+nXQvBNEmPjBELiqANNe/TAY0bNTDQYbZfK?=
 =?us-ascii?Q?kuzOQFQZcqkWOfWg4Aqpu58EkXAfc4rvDOdk6S+GImWJ2r0q87hMmWV4PzSu?=
 =?us-ascii?Q?rRiBMYI6oOhpUI6DKDRQFGXpbHSa8LL1WTKaoSfDgw2tCtWtXxnFi9AUoMQ6?=
 =?us-ascii?Q?fm8FymkO1hb6E/QLz1mpZHjzjnVh1svcGd00ha/+cLntW3zouap33tQsoCbG?=
 =?us-ascii?Q?oMfvX4wgG0iZIJgzQ/Lo1cjDRe+dSTnQ+UFX21AggWz2pdZuna61Sf1Tev9x?=
 =?us-ascii?Q?mK3oWSmrNBCFKw8aD2j1oqA0Rw9cEtVb9thMiU9CUYnNGabfWsaFqhGD4xb9?=
 =?us-ascii?Q?mDgmc/z0qQLDLXfYJTM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:16:40.6005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8fa37d-eeeb-4a0f-e98f-08de3c06182f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Ensure the GRBM_GFX_CNTL is programmed correctly

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index ed6c2aae3c486..a70ab9e4b7385 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1455,7 +1455,7 @@ static void gfx_v12_1_xcc_constants_init(struct amdgpu_device *adev,
 			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regSH_MEM_BASES, tmp);
 		}
 	}
-	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, 0));
+	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
 
 	mutex_unlock(&adev->srbm_mutex);
 
@@ -1783,7 +1783,7 @@ static void gfx_v12_1_xcc_config_gfx_rs64(struct amdgpu_device *adev,
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_RS64_PRGRM_CNTR_START_HI,
 					mec_hdr->ucode_start_addr_hi >> 2);
 	}
-	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, 0));
+	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
 
 	/* reset mec pipe */
 	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_RS64_CNTL);
@@ -1828,7 +1828,7 @@ static void gfx_v12_1_xcc_set_mec_ucode_start_addr(struct amdgpu_device *adev,
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_RS64_PRGRM_CNTR_START_HI,
 			     cp_hdr->ucode_start_addr_hi >> 2);
 	}
-	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, 0));
+	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
 	mutex_unlock(&adev->srbm_mutex);
 }
 
@@ -2024,7 +2024,7 @@ static int gfx_v12_1_xcc_cp_compute_load_microcode_rs64(struct amdgpu_device *ad
 				upper_32_bits(adev->gfx.mec.mec_fw_gpu_addr));
 	}
 	mutex_unlock(&adev->srbm_mutex);
-	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, 0));
+	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
 
 	/* Trigger an invalidation of the L1 instruction caches */
 	tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DC_OP_CNTL);
-- 
2.52.0

