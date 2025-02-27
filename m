Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F60C021BE
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 04:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83BEB10E2FE;
	Thu, 27 Feb 2025 04:00:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XBEQZAL7";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622E310E2FE
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 04:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9WwtEXPLYh0OPgND5aQhRBrZLVJlVllhCGjgQGMAnNx5o4guMXQX2q06MZuP+oY7jmFTCUygePawBMp2g1kFiBtB3QBb5nax/4Az5iGeGtm0itzNXoidG0OELVbbFMpQlqkLr58drfLlLJxU1sWlFP0TZ4z1DZGrgVcKz4xEUaj4+3Td9yOXMaM00jtGTUMyM7JFuXe74SsVvTwMdIaHokBgj1TqgfStuhEmgknCIw1xXQzFnOAPKitjQl9GjFrSKvGPqWCHgkN9M+OH1Cx0uvkazdikvq+xKGKyfcrdhsBBb3JayXlIRipbIM40lEZQMjNGxi32MwyVLkDuuUfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7AwyxEqMMlza9qH4ehJWVO/YkXftEUAul48zX9dTbw=;
 b=KpmFINON3yhuIfL36o/y3meuWCipQPS527fRZGLYsp8VhtI2/zMuSLJYAAHSfmgR3AdpzuFd2ylDJJOawHCkJ7dD6lXxJfBo+3qiYT0eTaRK6UxMzWogiMjI98tuLOazI5wN8b8akBC/0K2GPZoO5q559xKcbj6oaEXnOd8XwLOLtQjFwPagCRVTMBmB6xe7gsp6zuHkk96Xlh62yrn610tvMj4oavbmMsA8Rx52lsjdIWJe2hmLmR89Hnxhv9oBItk1yQnRtBBrG4i3rSeBAqt/pj5qS0eFqAaBcwQ0OaERP1wToYpQzAOS8e6MVIWXBUWcqdhJkjshcNpFzp1ahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7AwyxEqMMlza9qH4ehJWVO/YkXftEUAul48zX9dTbw=;
 b=XBEQZAL7CztDYna3aZ/nYIqLP1lUqnHNtD9KQlWnFlZ+OLy/aGvxDxKT5zBYOnDOVdVce81ItuatwFWQCaXiG+L73qMkqrWdN4pDZYF50HpTo52vXh5hWIcxOvldU9c7DuXuVnQAf5QNsGNrNRdcAtEu76yn0jQDq82gY9g5Kow=
Received: from MW4PR03CA0017.namprd03.prod.outlook.com (2603:10b6:303:8f::22)
 by IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 04:00:50 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::17) by MW4PR03CA0017.outlook.office365.com
 (2603:10b6:303:8f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Thu,
 27 Feb 2025 04:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 04:00:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 22:00:47 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/gfx12: don't read registers in mqd init
Date: Wed, 26 Feb 2025 23:00:32 -0500
Message-ID: <20250227040033.234065-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227040033.234065-1-alexander.deucher@amd.com>
References: <20250227040033.234065-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|IA0PR12MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: 073f5c61-c477-401a-51be-08dd56e352a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mUgnA8IA6R5eySs2Znohhoo8rs3CUgc9JWJF3N1I0EOx1G+HWGc0nRjCPicY?=
 =?us-ascii?Q?+piozCSvdIyAkt/rwAYVhqS9dJnfpD/6ipZiKdZS3xfA17T50jyHkYaISf9D?=
 =?us-ascii?Q?x4pohKmUs78sDbsvKD6jYtP4USM+No4zqC8dkcIf9R+gY9h4H/SfzZWKF+Nf?=
 =?us-ascii?Q?7qewqWiLdMv+xde/20idEQr7Tzy1DGoykJX/d140cb9+cJySdhDp7ZM2u2HC?=
 =?us-ascii?Q?4lZgEyeh0xLNy7Cfn+KGtn15mMaaajqUwNjdKmOABwbGUy0rbwaFg2Ho8Ts0?=
 =?us-ascii?Q?Ux0rsIA9+iTMjQp07ogWs72QVc9V2eiM3w192IfV1hb4rip4kkhjbx2uQAFT?=
 =?us-ascii?Q?OzKDwFpOHJYeeUzdKH90Nqe4oAcBbrCHvHR3RLixHG6C80k4A7f/5wUxUYX9?=
 =?us-ascii?Q?iLkXKcxOTyqgvC8g2xg1cmyOsO4AehzNfl4ou3EyVGwMLjCyssJBTgNVv6ZM?=
 =?us-ascii?Q?s8SpkQEs1wQa6qbUgmtEtc0s1H6zrIL5ZGZLRvaxg41yFi17K0u1eiJsb2ka?=
 =?us-ascii?Q?Utr4JkW6NIx4FWGygtxLGDqUYCQ3n7l2CStZhGYEZpFUKWsvZjulPa1xbE5N?=
 =?us-ascii?Q?PeUjkkkWNr5KKrGjbGOdjNqfhygXfKDkFOL+NXIZR2owTWYHIMXqVopziNkI?=
 =?us-ascii?Q?MEIFUabMVey5gYUyen4xUpEy4XraIYPtIMwkcwNTyuM6mhIuYRcK0YsUtTV9?=
 =?us-ascii?Q?0kgb1KXlZDqmzJ+V4VJkJ2S9LSOOUev7iine/ljr9RYc7nFb/MhY+adOKC5j?=
 =?us-ascii?Q?JGDXyk1r1m7t3WEuXgTIVAVuQXhOEZ67vo39/kd2CImLIP6MIsCaPhc4twjL?=
 =?us-ascii?Q?NJ5pzmnKUEQtmcET7DaurQdVMsQUxr09YO/ns9tU05C63gUQL7q8tZXVY5UR?=
 =?us-ascii?Q?XNS1NBM3w3x/yIzzPo5A5JokBmLxzplTtBc0wKmCJ5qxiv/QrkcnsZUUjGT8?=
 =?us-ascii?Q?LfbcQBn7h6U1JYwW5A2qUDZiveKNtcVlVe6krIUu/flTrrsM4NGgEuTtWVMz?=
 =?us-ascii?Q?KymqLhXG9MeNff5w1fQGNIG128G+ivt1NOi/UBHWkx2ok/gFqlVlAkpm37op?=
 =?us-ascii?Q?Xq7BZw+aqQMCbBmfV1t75F35UAWNpzeNEtghGmpil0GwdQwesGjR5OiuyTQG?=
 =?us-ascii?Q?TBmfJe2YujsHBQh2VHNcluNtxNytDa4rZYyC15rSagOnUrcD/ibYvtl/LfLT?=
 =?us-ascii?Q?7dblp2rz/slWIlHUpHk/6CWW65vLo9vSSEuNXhXvEJb6FoPwxMGf7eo+H1GG?=
 =?us-ascii?Q?P83/4qN3ZzfOeLH0mMIlajFVB+530Ku2N0p07uYLEGSEUQTpF/haXLnsU/HW?=
 =?us-ascii?Q?1KbuPQ+W66EzuKuyGuXUS+Usxd4GMJ1OoVZ5H5imjJOg/LsVZENU53SjHGnm?=
 =?us-ascii?Q?h4y8NACy3q+l/aqCTWn529cKWOqEKu9uOFLLKuIEYqJN9+MjYVEUA6P1sNwY?=
 =?us-ascii?Q?KsJS4Lwnqq6w9rLePPAvqdhT+FjtWI52cNvGUDTKxNBBRSqKIdhlqGoCVW99?=
 =?us-ascii?Q?45NuJc0f/EbAkgw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:00:49.8759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 073f5c61-c477-401a-51be-08dd56e352a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7699
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

Just use the default values.  There's not need to
get the value from hardware and it could cause problems
if we do that at runtime and gfxoff is active.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 48 ++++++++++++++++++--------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 667c8013b7738..804e9552a608a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -52,6 +52,24 @@
 
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
 
+#define regCP_GFX_MQD_CONTROL_DEFAULT                                             0x00000100
+#define regCP_GFX_HQD_VMID_DEFAULT                                                0x00000000
+#define regCP_GFX_HQD_QUEUE_PRIORITY_DEFAULT                                      0x00000000
+#define regCP_GFX_HQD_QUANTUM_DEFAULT                                             0x00000a01
+#define regCP_GFX_HQD_CNTL_DEFAULT                                                0x00f00000
+#define regCP_RB_DOORBELL_CONTROL_DEFAULT                                         0x00000000
+#define regCP_GFX_HQD_RPTR_DEFAULT                                                0x00000000
+
+#define regCP_HQD_EOP_CONTROL_DEFAULT                                             0x00000006
+#define regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT                                     0x00000000
+#define regCP_MQD_CONTROL_DEFAULT                                                 0x00000100
+#define regCP_HQD_PQ_CONTROL_DEFAULT                                              0x00308509
+#define regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT                                     0x00000000
+#define regCP_HQD_PQ_RPTR_DEFAULT                                                 0x00000000
+#define regCP_HQD_PERSISTENT_STATE_DEFAULT                                        0x0be05501
+#define regCP_HQD_IB_CONTROL_DEFAULT                                              0x00300000
+
+
 MODULE_FIRMWARE("amdgpu/gc_12_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_0_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_0_mec.bin");
@@ -2926,25 +2944,25 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_mqd_base_addr_hi = upper_32_bits(prop->mqd_gpu_addr);
 
 	/* set up mqd control */
-	tmp = RREG32_SOC15(GC, 0, regCP_GFX_MQD_CONTROL);
+	tmp = regCP_GFX_MQD_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, VMID, 0);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, PRIV_STATE, 1);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, CACHE_POLICY, 0);
 	mqd->cp_gfx_mqd_control = tmp;
 
 	/* set up gfx_hqd_vimd with 0x0 to indicate the ring buffer's vmid */
-	tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_VMID);
+	tmp = regCP_GFX_HQD_VMID_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_VMID, VMID, 0);
 	mqd->cp_gfx_hqd_vmid = 0;
 
 	/* set up default queue priority level
 	 * 0x0 = low priority, 0x1 = high priority */
-	tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUEUE_PRIORITY);
+	tmp = regCP_GFX_HQD_QUEUE_PRIORITY_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUEUE_PRIORITY, PRIORITY_LEVEL, 0);
 	mqd->cp_gfx_hqd_queue_priority = tmp;
 
 	/* set up time quantum */
-	tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUANTUM);
+	tmp = regCP_GFX_HQD_QUANTUM_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_EN, 1);
 	mqd->cp_gfx_hqd_quantum = tmp;
 
@@ -2966,7 +2984,7 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 
 	/* set up the gfx_hqd_control, similar as CP_RB0_CNTL */
 	rb_bufsz = order_base_2(prop->queue_size / 4) - 1;
-	tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_CNTL);
+	tmp = regCP_GFX_HQD_CNTL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
 #ifdef __BIG_ENDIAN
@@ -2975,7 +2993,7 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_gfx_hqd_cntl = tmp;
 
 	/* set up cp_doorbell_control */
-	tmp = RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL);
+	tmp = regCP_RB_DOORBELL_CONTROL_DEFAULT;
 	if (prop->use_doorbell) {
 		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
 				    DOORBELL_OFFSET, prop->doorbell_index);
@@ -2987,7 +3005,7 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_rb_doorbell_control = tmp;
 
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	mqd->cp_gfx_hqd_rptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_RPTR);
+	mqd->cp_gfx_hqd_rptr = regCP_GFX_HQD_RPTR_DEFAULT;
 
 	/* active the queue */
 	mqd->cp_gfx_hqd_active = 1;
@@ -3090,14 +3108,14 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_eop_base_addr_hi = upper_32_bits(eop_base_addr);
 
 	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_EOP_CONTROL);
+	tmp = regCP_HQD_EOP_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_EOP_CONTROL, EOP_SIZE,
 			(order_base_2(GFX12_MEC_HPD_SIZE / 4) - 1));
 
 	mqd->cp_hqd_eop_control = tmp;
 
 	/* enable doorbell? */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
+	tmp = regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT;
 
 	if (prop->use_doorbell) {
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
@@ -3126,7 +3144,7 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_mqd_base_addr_hi = upper_32_bits(prop->mqd_gpu_addr);
 
 	/* set MQD vmid to 0 */
-	tmp = RREG32_SOC15(GC, 0, regCP_MQD_CONTROL);
+	tmp = regCP_MQD_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
 	mqd->cp_mqd_control = tmp;
 
@@ -3136,7 +3154,7 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_pq_base_hi = upper_32_bits(hqd_gpu_addr);
 
 	/* set up the HQD, this is similar to CP_RB0_CNTL */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_PQ_CONTROL);
+	tmp = regCP_HQD_PQ_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
 			    (order_base_2(prop->queue_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
@@ -3161,7 +3179,7 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = 0;
 	/* enable the doorbell if requested */
 	if (prop->use_doorbell) {
-		tmp = RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
+		tmp = regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT;
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				DOORBELL_OFFSET, prop->doorbell_index);
 
@@ -3176,17 +3194,17 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_pq_doorbell_control = tmp;
 
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	mqd->cp_hqd_pq_rptr = RREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR);
+	mqd->cp_hqd_pq_rptr = regCP_HQD_PQ_RPTR_DEFAULT;
 
 	/* set the vmid for the queue */
 	mqd->cp_hqd_vmid = 0;
 
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_PERSISTENT_STATE);
+	tmp = regCP_HQD_PERSISTENT_STATE_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE, PRELOAD_SIZE, 0x55);
 	mqd->cp_hqd_persistent_state = tmp;
 
 	/* set MIN_IB_AVAIL_SIZE */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_IB_CONTROL);
+	tmp = regCP_HQD_IB_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
 	mqd->cp_hqd_ib_control = tmp;
 
-- 
2.48.1

