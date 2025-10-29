Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D62CCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1355B10E219;
	Wed, 29 Oct 2025 17:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tPskZ9mo";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12E4910E805
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5LsDZePNuHbsQP8kdPl3Gu+1aVP0Vnkv5D4UXuazXi5DA3J2XbBljwEfcb62ok+MMDNvh1jnRujDVQR0QP/JxXd8a0Kez+Nq6M/Fh+ZuXexyG/w1w+a1uOpeTPu8nLr6amtlGgESoiyBfoH0l5omd1nv9vEHwFFZ2TLGbk7B7KDNvKbmHS5VkpiHZdpcWo6AMm0dUAiYTjr/8UsHTQ8hcBu/9kNevQ4n3sUYdUtbbjHT1lap8Ie3GDNn37oYgRYpxzhHVwsXAN3Ub3a45QIFNWe3oChzeZXzTOg4VZSYTBCBQkNtbkd8x2wH4eMcSdLI1vjbQWopGK6gJTNTlAvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtpMuvijv8k80OkiWy2QR4LXwTbSr99uhPxjIoQt9Uc=;
 b=E92gpYBHo66HLQmKuZ0yrxr8V8561JUon8F/xm/ntKDZCrKwOGN75D90BYCoDemt6ADXRtx8+yNXaX6nJ9jMGZfsO9BMw94US1fmH/xmQcrGY8yKxqlN+aDDmmHuKTHfT1hyToX6TCfl+sQAoX/x/dEDfP5IjQHU+Embc3LPkdD+vM/o7U6nT4ub7UmefW2E07tWhLekFgnCEpEdybG+tp0zrmOnMGTvw9vDSFRxrPEjYYYUtEsHjmwOSU3aG6yBj9WDiDlE73RYmo8axP1qF766HCbxV01IOMs3mzYhsAwa3A58j5EAJyt9ZtwlUiBBfMqLTFArxPEBY4MNCy1nkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtpMuvijv8k80OkiWy2QR4LXwTbSr99uhPxjIoQt9Uc=;
 b=tPskZ9mo41zCmhM2cqQKKlQP35pYkOuX140a6AUzZc2M4mk3V4CnKsjFSOGjRNc5evhpli3HQs/TS0XDBa3AlvtVGgwIskHCDlZI+CBMSy5/Gs+Ci/qcgW3382lw8uuOKjZrq52IwLu5FtcuvCpYHXQaHtZa7xWy6RHanDSF2B4=
Received: from BN0PR08CA0010.namprd08.prod.outlook.com (2603:10b6:408:142::11)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 29 Oct
 2025 17:51:59 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::40) by BN0PR08CA0010.outlook.office365.com
 (2603:10b6:408:142::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 17:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:51:59 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:51:57 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/mes: add multi-xcc support
Date: Wed, 29 Oct 2025 13:51:31 -0400
Message-ID: <20251029175137.2861556-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175137.2861556-1-alexander.deucher@amd.com>
References: <20251029175137.2861556-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: ec2adb39-196d-42c5-0d54-08de1713dbda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VyksP0i3h+L/qowLQ2yltR6mRIE5vAQKLQWHfdkDc8cFyrE2dRcY521Ly1L3?=
 =?us-ascii?Q?QsORsMxSIZMBB6I/kLa70asBNwGlvdFObuEzzhBeo7bFN5VxkmSgsX8REOm1?=
 =?us-ascii?Q?ND5z89e2BUCzU5+Oe+XbodCYMeqfApgSSEB2m9OApVuW6e86GvT26gi5GWWF?=
 =?us-ascii?Q?3Yt7kh+B6Ss3x293Dt7H6ST4j0VhVLrqygoqjzE3Gej6mMmxL0z1rMG6HKNc?=
 =?us-ascii?Q?L81D8/cRGUvP13geOHNOC3SR12MHH03q87dcHQTU0hkMqmEqkUIqZLTZrY/A?=
 =?us-ascii?Q?gYMl7lah0k7ZnUU6m6apGY6gLzv8I6AKgRjrbnKZjLhV4dOapXmEBI0upZWb?=
 =?us-ascii?Q?VoE1SQ1yGofk7gXjRyT6STL1WHMF8WVz5NOqH12jb84AALysf0wbmQmtHUfi?=
 =?us-ascii?Q?26dcSkLPCY7SmJdAt0hzc07r3RGYXVM/tL5IuFiZvmO/TLF8Ug4JlL5ntjDT?=
 =?us-ascii?Q?9rJFWVhElYw5aLJNumKFYoU1llUivvjZzpwhKD5mTuTduRsT9XpZE4MdLekD?=
 =?us-ascii?Q?A6yGitsi4SXvt17ecOznAGjm27N02/zfKWeY12TtU8TyofD6vvB8cQYrzcf/?=
 =?us-ascii?Q?0Cd8A9vR2/1so6xoWoKL2W2lKw4Z6U7/MuLLHB+rEOulFIlxcN0HJrpwIME9?=
 =?us-ascii?Q?1pI2mCmTNESyjdEv2vtYCTXuaHX1m/HNuqazaP6Te2M7/FSLcstHrax3Suuo?=
 =?us-ascii?Q?SsGyrsz0A7WDCNfXmLwt2DU2LIMr7rkayEIDNOOl8UB2bVKEXXS1A9PFOCxG?=
 =?us-ascii?Q?dnrGk9UciRPXt8OOw7D3c9iIFtoOGGG5lik3QvNmnvbAb/NBw9rfqPgc+2AU?=
 =?us-ascii?Q?TpSxWqOmyMMCE9ATkH6e1CDihbUhUqk1BLcwnXCkzYm4l86b0CyHSYBBdxGZ?=
 =?us-ascii?Q?ZyiM46oBDaabU4uA+yrEOAG1vWaDY3nqAhb+eeWmHHfmLzZPKTC9mV9sc9+U?=
 =?us-ascii?Q?G+BhXL6xz1H8acs4RwTJIBuyvzplYCr3NJP5aX87nDknKH69d4Am3kvsju3x?=
 =?us-ascii?Q?f431SE/YmQfol9YPwm0ttnCAfiD3ZdUorm6v0Yj9x79DPx+9WQy+hb/Ed/+5?=
 =?us-ascii?Q?LCLpQ+LGPFnRC/FkhRRdbVEvKiMOV/hovo/bP5P/1Vy18vqUeOOnzldmltPf?=
 =?us-ascii?Q?0HV8oVSEqHi0RV+tpXW9LhrUWzLcTPvqY0IyQdoVSAPFlhGwfCRPnLJuv0Uz?=
 =?us-ascii?Q?NV4umWpYPQ98WhY+Dim6ts5H8RWlXk6dUW46kjixsu841pBKQ9dBmV/KT/4v?=
 =?us-ascii?Q?gApBms3kJbsT4Ha7qx6iPqDCw11QvyGK5wsFwfGOKwJWD9MGJ3E5IwENxTrK?=
 =?us-ascii?Q?kWP8KQx3/K4+KLMHoqd8cWcfgT1GkVXoMDYTTavbJcYUj6ut4cSizVg4XXEQ?=
 =?us-ascii?Q?S62DusfsIbs80SQVwQvGwRPNlP18MimXmwLCc2ZKavA+JrsAkYeFn7TBkwYJ?=
 =?us-ascii?Q?cIYG2ZdUDeLpIYVDLl5nPGljLUUyjQoq5k6xXQb5IOudh4hXalocBeXkuISl?=
 =?us-ascii?Q?D59hvwRSWgOjdtP2UPkdYLPCvE6lVRdJGNxuaiO1U+N3L5nvZDNsG/OHG68Q?=
 =?us-ascii?Q?gpVcW/j29pekOWNdEzk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:51:59.3093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2adb39-196d-42c5-0d54-08de1713dbda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190
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

From: Jack Xiao <Jack.Xiao@amd.com>

a. extend mes pipe instances to num_xcc * max_mes_pipe
b. initialize mes schq/kiq pipes per xcc
c. submit mes packet to mes ring according to xcc_id

v2: rebase (Alex)

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  14 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  86 +++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       | 100 +++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  15 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  15 +--
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |   2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  14 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |   2 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |   2 +-
 13 files changed, 158 insertions(+), 108 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 3d24f9cd750a0..5a1904b0b064f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -511,7 +511,7 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 			j = i + xcc_id * adev->gfx.num_compute_rings;
 			amdgpu_mes_unmap_legacy_queue(adev,
 						   &adev->gfx.compute_ring[j],
-						   RESET_QUEUES, 0, 0);
+						   RESET_QUEUES, 0, 0, xcc_id);
 		}
 		return 0;
 	}
@@ -562,7 +562,7 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev, int xcc_id)
 				j = i + xcc_id * adev->gfx.num_gfx_rings;
 				amdgpu_mes_unmap_legacy_queue(adev,
 						      &adev->gfx.gfx_ring[j],
-						      PREEMPT_QUEUES, 0, 0);
+						      PREEMPT_QUEUES, 0, 0, xcc_id);
 			}
 		}
 		return 0;
@@ -644,7 +644,8 @@ static int amdgpu_gfx_mes_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		j = i + xcc_id * adev->gfx.num_compute_rings;
 		r = amdgpu_mes_map_legacy_queue(adev,
-						&adev->gfx.compute_ring[j]);
+						&adev->gfx.compute_ring[j],
+						xcc_id);
 		if (r) {
 			dev_err(adev->dev, "failed to map compute queue\n");
 			return r;
@@ -733,7 +734,8 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 			j = i + xcc_id * adev->gfx.num_gfx_rings;
 			r = amdgpu_mes_map_legacy_queue(adev,
-							&adev->gfx.gfx_ring[j]);
+							&adev->gfx.gfx_ring[j],
+							xcc_id);
 			if (r) {
 				dev_err(adev->dev, "failed to map gfx queue\n");
 				return r;
@@ -1067,7 +1069,7 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
 		return 0;
 
 	if (adev->mes.ring[0].sched.ready)
-		return amdgpu_mes_rreg(adev, reg);
+		return amdgpu_mes_rreg(adev, reg, xcc_id);
 
 	BUG_ON(!ring->funcs->emit_rreg);
 
@@ -1143,7 +1145,7 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 		return;
 
 	if (adev->mes.ring[0].sched.ready) {
-		amdgpu_mes_wreg(adev, reg, v);
+		amdgpu_mes_wreg(adev, reg, v, xcc_id);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 97b562a79ea8e..0017bd10d4520 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -810,7 +810,7 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 
 	if (adev->mes.ring[0].sched.ready) {
 		amdgpu_mes_reg_write_reg_wait(adev, reg0, reg1,
-					      ref, mask);
+					      ref, mask, xcc_inst);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 9c182ce501af4..96dc65559f488 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -91,6 +91,7 @@ static void amdgpu_mes_doorbell_free(struct amdgpu_device *adev)
 int amdgpu_mes_init(struct amdgpu_device *adev)
 {
 	int i, r, num_pipes;
+	int num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
 	adev->mes.adev = adev;
 
@@ -101,7 +102,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	spin_lock_init(&adev->mes.queue_id_lock);
 	mutex_init(&adev->mes.mutex_hidden);
 
-	for (i = 0; i < AMDGPU_MAX_MES_PIPES; i++)
+	for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++)
 		spin_lock_init(&adev->mes.ring_lock[i]);
 
 	adev->mes.total_max_queue = AMDGPU_FENCE_MES_QUEUE_ID_MASK;
@@ -156,7 +157,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		adev->mes.sdma_hqd_mask[i] = 0xfc;
 	}
 
-	for (i = 0; i < AMDGPU_MAX_MES_PIPES; i++) {
+	for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
 		r = amdgpu_device_wb_get(adev, &adev->mes.sch_ctx_offs[i]);
 		if (r) {
 			dev_err(adev->dev,
@@ -192,16 +193,18 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		goto error_doorbell;
 
 	if (adev->mes.hung_queue_db_array_size) {
-		r = amdgpu_bo_create_kernel(adev,
-					    adev->mes.hung_queue_db_array_size * sizeof(u32),
-					    PAGE_SIZE,
-					    AMDGPU_GEM_DOMAIN_GTT,
-					    &adev->mes.hung_queue_db_array_gpu_obj,
-					    &adev->mes.hung_queue_db_array_gpu_addr,
-					    &adev->mes.hung_queue_db_array_cpu_addr);
-		if (r) {
-			dev_warn(adev->dev, "failed to create MES hung db array buffer (%d)", r);
-			goto error_doorbell;
+		for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
+			r = amdgpu_bo_create_kernel(adev,
+						    adev->mes.hung_queue_db_array_size * sizeof(u32),
+						    PAGE_SIZE,
+						    AMDGPU_GEM_DOMAIN_GTT,
+						    &adev->mes.hung_queue_db_array_gpu_obj[i],
+						    &adev->mes.hung_queue_db_array_gpu_addr[i],
+						    &adev->mes.hung_queue_db_array_cpu_addr[i]);
+			if (r) {
+				dev_warn(adev->dev, "failed to create MES hung db array buffer (%d)", r);
+				goto error_doorbell;
+			}
 		}
 	}
 
@@ -210,12 +213,16 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 error_doorbell:
 	amdgpu_mes_doorbell_free(adev);
 error:
-	for (i = 0; i < AMDGPU_MAX_MES_PIPES; i++) {
+	for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
 		if (adev->mes.sch_ctx_ptr[i])
 			amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs[i]);
 		if (adev->mes.query_status_fence_ptr[i])
 			amdgpu_device_wb_free(adev,
 				      adev->mes.query_status_fence_offs[i]);
+		if (adev->mes.hung_queue_db_array_gpu_obj[i])
+			amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_obj[i],
+					      &adev->mes.hung_queue_db_array_gpu_addr[i],
+					      &adev->mes.hung_queue_db_array_cpu_addr[i]);
 	}
 
 	idr_destroy(&adev->mes.pasid_idr);
@@ -228,17 +235,17 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 
 void amdgpu_mes_fini(struct amdgpu_device *adev)
 {
-	int i;
-
-	amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_obj,
-			      &adev->mes.hung_queue_db_array_gpu_addr,
-			      &adev->mes.hung_queue_db_array_cpu_addr);
+	int i, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
 	amdgpu_bo_free_kernel(&adev->mes.event_log_gpu_obj,
 			      &adev->mes.event_log_gpu_addr,
 			      &adev->mes.event_log_cpu_addr);
 
-	for (i = 0; i < AMDGPU_MAX_MES_PIPES; i++) {
+	for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
+		amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_obj[i],
+				      &adev->mes.hung_queue_db_array_gpu_addr[i],
+				      &adev->mes.hung_queue_db_array_cpu_addr[i]);
+
 		if (adev->mes.sch_ctx_ptr[i])
 			amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs[i]);
 		if (adev->mes.query_status_fence_ptr[i])
@@ -304,13 +311,14 @@ int amdgpu_mes_resume(struct amdgpu_device *adev)
 }
 
 int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
+				struct amdgpu_ring *ring, uint32_t xcc_id)
 {
 	struct mes_map_legacy_queue_input queue_input;
 	int r;
 
 	memset(&queue_input, 0, sizeof(queue_input));
 
+	queue_input.xcc_id = xcc_id;
 	queue_input.queue_type = ring->funcs->type;
 	queue_input.doorbell_offset = ring->doorbell_index;
 	queue_input.pipe_id = ring->pipe;
@@ -330,11 +338,12 @@ int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
 int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 				  struct amdgpu_ring *ring,
 				  enum amdgpu_unmap_queues_action action,
-				  u64 gpu_addr, u64 seq)
+				  u64 gpu_addr, u64 seq, uint32_t xcc_id)
 {
 	struct mes_unmap_legacy_queue_input queue_input;
 	int r;
 
+	queue_input.xcc_id = xcc_id;
 	queue_input.action = action;
 	queue_input.queue_type = ring->funcs->type;
 	queue_input.doorbell_offset = ring->doorbell_index;
@@ -355,13 +364,15 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 				  struct amdgpu_ring *ring,
 				  unsigned int vmid,
-				  bool use_mmio)
+				  bool use_mmio,
+				  uint32_t xcc_id)
 {
 	struct mes_reset_queue_input queue_input;
 	int r;
 
 	memset(&queue_input, 0, sizeof(queue_input));
 
+	queue_input.xcc_id = xcc_id;
 	queue_input.queue_type = ring->funcs->type;
 	queue_input.doorbell_offset = ring->doorbell_index;
 	queue_input.me_id = ring->me;
@@ -393,11 +404,11 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 					    int queue_type,
 					    bool detect_only,
 					    unsigned int *hung_db_num,
-					    u32 *hung_db_array)
-
+					    u32 *hung_db_array,
+					    uint32_t xcc_id)
 {
 	struct mes_detect_and_reset_queue_input input;
-	u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr;
+	u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr[xcc_id];
 	int r, i;
 
 	if (!hung_db_num || !hung_db_array)
@@ -409,7 +420,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 		return -EINVAL;
 
 	/* Clear the doorbell array before detection */
-	memset(adev->mes.hung_queue_db_array_cpu_addr, AMDGPU_MES_INVALID_DB_OFFSET,
+	memset(adev->mes.hung_queue_db_array_cpu_addr[xcc_id], AMDGPU_MES_INVALID_DB_OFFSET,
 		adev->mes.hung_queue_db_array_size * sizeof(u32));
 	input.queue_type = queue_type;
 	input.detect_only = detect_only;
@@ -436,7 +447,8 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 	return r;
 }
 
-uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
+uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg,
+			 uint32_t xcc_id)
 {
 	struct mes_misc_op_input op_input;
 	int r, val = 0;
@@ -450,6 +462,7 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 	}
 	read_val_gpu_addr = adev->wb.gpu_addr + (addr_offset * 4);
 	read_val_ptr = (uint32_t *)&adev->wb.wb[addr_offset];
+	op_input.xcc_id = xcc_id;
 	op_input.op = MES_MISC_OP_READ_REG;
 	op_input.read_reg.reg_offset = reg;
 	op_input.read_reg.buffer_addr = read_val_gpu_addr;
@@ -473,12 +486,13 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 	return val;
 }
 
-int amdgpu_mes_wreg(struct amdgpu_device *adev,
-		    uint32_t reg, uint32_t val)
+int amdgpu_mes_wreg(struct amdgpu_device *adev, uint32_t reg,
+		    uint32_t val, uint32_t xcc_id)
 {
 	struct mes_misc_op_input op_input;
 	int r;
 
+	op_input.xcc_id = xcc_id;
 	op_input.op = MES_MISC_OP_WRITE_REG;
 	op_input.write_reg.reg_offset = reg;
 	op_input.write_reg.reg_value = val;
@@ -501,11 +515,13 @@ int amdgpu_mes_wreg(struct amdgpu_device *adev,
 
 int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 				  uint32_t reg0, uint32_t reg1,
-				  uint32_t ref, uint32_t mask)
+				  uint32_t ref, uint32_t mask,
+				  uint32_t xcc_id)
 {
 	struct mes_misc_op_input op_input;
 	int r;
 
+	op_input.xcc_id = xcc_id;
 	op_input.op = MES_MISC_OP_WRM_REG_WR_WAIT;
 	op_input.wrm_reg.reg0 = reg0;
 	op_input.wrm_reg.reg1 = reg1;
@@ -537,7 +553,7 @@ int amdgpu_mes_hdp_flush(struct amdgpu_device *adev)
 	ref_and_mask = adev->nbio.hdp_flush_reg->ref_and_mask_cp0;
 
 	return amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset, hdp_flush_done_offset,
-					     ref_and_mask, ref_and_mask);
+					     ref_and_mask, ref_and_mask, 0);
 }
 
 int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
@@ -545,7 +561,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 				uint32_t spi_gdbg_per_vmid_cntl,
 				const uint32_t *tcp_watch_cntl,
 				uint32_t flags,
-				bool trap_en)
+				bool trap_en,
+				uint32_t xcc_id)
 {
 	struct mes_misc_op_input op_input = {0};
 	int r;
@@ -556,6 +573,7 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 		return -EINVAL;
 	}
 
+	op_input.xcc_id = xcc_id;
 	op_input.op = MES_MISC_OP_SET_SHADER_DEBUGGER;
 	op_input.set_shader_debugger.process_context_addr = process_context_addr;
 	op_input.set_shader_debugger.flags.u32all = flags;
@@ -584,7 +602,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 }
 
 int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
-				     uint64_t process_context_addr)
+				     uint64_t process_context_addr,
+				     uint32_t xcc_id)
 {
 	struct mes_misc_op_input op_input = {0};
 	int r;
@@ -595,6 +614,7 @@ int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
 		return -EINVAL;
 	}
 
+	op_input.xcc_id = xcc_id;
 	op_input.op = MES_MISC_OP_SET_SHADER_DEBUGGER;
 	op_input.set_shader_debugger.process_context_addr = process_context_addr;
 	op_input.set_shader_debugger.flags.process_ctx_flush = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index e989225b354bb..941d6f805b028 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -58,11 +58,20 @@ enum amdgpu_mes_priority_level {
 struct amdgpu_mes_funcs;
 
 enum amdgpu_mes_pipe {
-	AMDGPU_MES_SCHED_PIPE = 0,
-	AMDGPU_MES_KIQ_PIPE,
+	AMDGPU_MES_PIPE_0 = 0,
+	AMDGPU_MES_PIPE_1,
 	AMDGPU_MAX_MES_PIPES = 2,
 };
 
+#define AMDGPU_MES_SCHED_PIPE AMDGPU_MES_PIPE_0
+#define AMDGPU_MES_KIQ_PIPE AMDGPU_MES_PIPE_1
+
+#define AMDGPU_MAX_MES_INST_PIPES \
+	(AMDGPU_MAX_MES_PIPES * AMDGPU_MAX_GC_INSTANCES)
+
+#define MES_PIPE_INST(xcc_id, pipe_id) \
+	(xcc_id * AMDGPU_MAX_MES_PIPES + pipe_id)
+
 struct amdgpu_mes {
 	struct amdgpu_device            *adev;
 
@@ -86,29 +95,29 @@ struct amdgpu_mes {
 	uint64_t                        default_process_quantum;
 	uint64_t                        default_gang_quantum;
 
-	struct amdgpu_ring              ring[AMDGPU_MAX_MES_PIPES];
-	spinlock_t                      ring_lock[AMDGPU_MAX_MES_PIPES];
+	struct amdgpu_ring              ring[AMDGPU_MAX_MES_INST_PIPES];
+	spinlock_t                      ring_lock[AMDGPU_MAX_MES_INST_PIPES];
 
 	const struct firmware           *fw[AMDGPU_MAX_MES_PIPES];
 
 	/* mes ucode */
-	struct amdgpu_bo		*ucode_fw_obj[AMDGPU_MAX_MES_PIPES];
-	uint64_t			ucode_fw_gpu_addr[AMDGPU_MAX_MES_PIPES];
-	uint32_t			*ucode_fw_ptr[AMDGPU_MAX_MES_PIPES];
+	struct amdgpu_bo		*ucode_fw_obj[AMDGPU_MAX_MES_INST_PIPES];
+	uint64_t			ucode_fw_gpu_addr[AMDGPU_MAX_MES_INST_PIPES];
+	uint32_t			*ucode_fw_ptr[AMDGPU_MAX_MES_INST_PIPES];
 	uint64_t                        uc_start_addr[AMDGPU_MAX_MES_PIPES];
 
 	/* mes ucode data */
-	struct amdgpu_bo		*data_fw_obj[AMDGPU_MAX_MES_PIPES];
-	uint64_t			data_fw_gpu_addr[AMDGPU_MAX_MES_PIPES];
-	uint32_t			*data_fw_ptr[AMDGPU_MAX_MES_PIPES];
+	struct amdgpu_bo		*data_fw_obj[AMDGPU_MAX_MES_INST_PIPES];
+	uint64_t			data_fw_gpu_addr[AMDGPU_MAX_MES_INST_PIPES];
+	uint32_t			*data_fw_ptr[AMDGPU_MAX_MES_INST_PIPES];
 	uint64_t                        data_start_addr[AMDGPU_MAX_MES_PIPES];
 
 	/* eop gpu obj */
-	struct amdgpu_bo		*eop_gpu_obj[AMDGPU_MAX_MES_PIPES];
-	uint64_t                        eop_gpu_addr[AMDGPU_MAX_MES_PIPES];
+	struct amdgpu_bo		*eop_gpu_obj[AMDGPU_MAX_MES_INST_PIPES];
+	uint64_t                        eop_gpu_addr[AMDGPU_MAX_MES_INST_PIPES];
 
-	void                            *mqd_backup[AMDGPU_MAX_MES_PIPES];
-	struct amdgpu_irq_src	        irq[AMDGPU_MAX_MES_PIPES];
+	void                            *mqd_backup[AMDGPU_MAX_MES_INST_PIPES];
+	struct amdgpu_irq_src	        irq[AMDGPU_MAX_MES_INST_PIPES];
 
 	uint32_t                        vmid_mask_gfxhub;
 	uint32_t                        vmid_mask_mmhub;
@@ -116,18 +125,21 @@ struct amdgpu_mes {
 	uint32_t                        compute_hqd_mask[AMDGPU_MES_MAX_COMPUTE_PIPES];
 	uint32_t                        sdma_hqd_mask[AMDGPU_MES_MAX_SDMA_PIPES];
 	uint32_t                        aggregated_doorbells[AMDGPU_MES_PRIORITY_NUM_LEVELS];
-	uint32_t                        sch_ctx_offs[AMDGPU_MAX_MES_PIPES];
-	uint64_t			sch_ctx_gpu_addr[AMDGPU_MAX_MES_PIPES];
-	uint64_t			*sch_ctx_ptr[AMDGPU_MAX_MES_PIPES];
-	uint32_t			query_status_fence_offs[AMDGPU_MAX_MES_PIPES];
-	uint64_t			query_status_fence_gpu_addr[AMDGPU_MAX_MES_PIPES];
-	uint64_t			*query_status_fence_ptr[AMDGPU_MAX_MES_PIPES];
+
+	uint32_t                        sch_ctx_offs[AMDGPU_MAX_MES_INST_PIPES];
+	uint64_t                        sch_ctx_gpu_addr[AMDGPU_MAX_MES_INST_PIPES];
+	uint64_t                        *sch_ctx_ptr[AMDGPU_MAX_MES_INST_PIPES];
+	uint32_t                        query_status_fence_offs[AMDGPU_MAX_MES_INST_PIPES];
+	uint64_t                        query_status_fence_gpu_addr[AMDGPU_MAX_MES_INST_PIPES];
+	uint64_t                        *query_status_fence_ptr[AMDGPU_MAX_MES_INST_PIPES];
 
 	uint32_t			saved_flags;
 
 	/* initialize kiq pipe */
-	int                             (*kiq_hw_init)(struct amdgpu_device *adev);
-	int                             (*kiq_hw_fini)(struct amdgpu_device *adev);
+	int                             (*kiq_hw_init)(struct amdgpu_device *adev,
+                                                   uint32_t xcc_id);
+	int                             (*kiq_hw_fini)(struct amdgpu_device *adev,
+                                                   uint32_t xcc_id);
 
 	/* MES doorbells */
 	uint32_t			db_start_dw_offset;
@@ -150,9 +162,9 @@ struct amdgpu_mes {
 
 	int				hung_queue_db_array_size;
 	int				hung_queue_hqd_info_offset;
-	struct amdgpu_bo		*hung_queue_db_array_gpu_obj;
-	uint64_t			hung_queue_db_array_gpu_addr;
-	void				*hung_queue_db_array_cpu_addr;
+	struct amdgpu_bo		*hung_queue_db_array_gpu_obj[AMDGPU_MAX_MES_PIPES];
+	uint64_t			hung_queue_db_array_gpu_addr[AMDGPU_MAX_MES_PIPES];
+	void				*hung_queue_db_array_cpu_addr[AMDGPU_MAX_MES_PIPES];
 };
 
 struct amdgpu_mes_gang {
@@ -208,6 +220,7 @@ struct amdgpu_mes_gang_properties {
 };
 
 struct mes_add_queue_input {
+	uint32_t        xcc_id;
 	uint32_t	process_id;
 	uint64_t	page_table_base_addr;
 	uint64_t	process_va_start;
@@ -237,12 +250,14 @@ struct mes_add_queue_input {
 };
 
 struct mes_remove_queue_input {
+	uint32_t        xcc_id;
 	uint32_t	doorbell_offset;
 	uint64_t	gang_context_addr;
 	bool		remove_queue_after_reset;
 };
 
 struct mes_map_legacy_queue_input {
+	uint32_t			   xcc_id;
 	uint32_t                           queue_type;
 	uint32_t                           doorbell_offset;
 	uint32_t                           pipe_id;
@@ -252,6 +267,7 @@ struct mes_map_legacy_queue_input {
 };
 
 struct mes_unmap_legacy_queue_input {
+	uint32_t                           xcc_id;
 	enum amdgpu_unmap_queues_action    action;
 	uint32_t                           queue_type;
 	uint32_t                           doorbell_offset;
@@ -262,6 +278,7 @@ struct mes_unmap_legacy_queue_input {
 };
 
 struct mes_suspend_gang_input {
+	uint32_t        xcc_id;
 	bool		suspend_all_gangs;
 	uint64_t	gang_context_addr;
 	uint64_t	suspend_fence_addr;
@@ -269,11 +286,13 @@ struct mes_suspend_gang_input {
 };
 
 struct mes_resume_gang_input {
+	uint32_t	xcc_id;
 	bool		resume_all_gangs;
 	uint64_t	gang_context_addr;
 };
 
 struct mes_reset_queue_input {
+	uint32_t			   xcc_id;
 	uint32_t                           queue_type;
 	uint32_t                           doorbell_offset;
 	bool                               use_mmio;
@@ -309,7 +328,8 @@ enum mes_misc_opcode {
 };
 
 struct mes_misc_op_input {
-	enum mes_misc_opcode op;
+	uint32_t                 xcc_id;
+	enum mes_misc_opcode     op;
 
 	union {
 		struct {
@@ -395,8 +415,10 @@ struct amdgpu_mes_funcs {
 			      struct mes_inv_tlbs_pasid_input *input);
 };
 
-#define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
-#define amdgpu_mes_kiq_hw_fini(adev) (adev)->mes.kiq_hw_fini((adev))
+#define amdgpu_mes_kiq_hw_init(adev, xcc_id) \
+	(adev)->mes.kiq_hw_init((adev), (xcc_id))
+#define amdgpu_mes_kiq_hw_fini(adev, xcc_id) \
+	(adev)->mes.kiq_hw_fini((adev), (xcc_id))
 
 int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);
 int amdgpu_mes_init(struct amdgpu_device *adev);
@@ -406,38 +428,42 @@ int amdgpu_mes_suspend(struct amdgpu_device *adev);
 int amdgpu_mes_resume(struct amdgpu_device *adev);
 
 int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring);
+				struct amdgpu_ring *ring, uint32_t xcc_id);
 int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 				  struct amdgpu_ring *ring,
 				  enum amdgpu_unmap_queues_action action,
-				  u64 gpu_addr, u64 seq);
+				  u64 gpu_addr, u64 seq, uint32_t xcc_id);
 int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 				  struct amdgpu_ring *ring,
 				  unsigned int vmid,
-				  bool use_mmio);
+				  bool use_mmio,
+				  uint32_t xcc_id);
 
 int amdgpu_mes_get_hung_queue_db_array_size(struct amdgpu_device *adev);
 int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 					    int queue_type,
 					    bool detect_only,
 					    unsigned int *hung_db_num,
-					    u32 *hung_db_array);
+					    u32 *hung_db_array,
+					    uint32_t xcc_id);
 
-uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg);
+uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg,
+			 uint32_t xcc_id);
 int amdgpu_mes_wreg(struct amdgpu_device *adev,
-		    uint32_t reg, uint32_t val);
+		    uint32_t reg, uint32_t val, uint32_t xcc_id);
 int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 				  uint32_t reg0, uint32_t reg1,
-				  uint32_t ref, uint32_t mask);
+				  uint32_t ref, uint32_t mask, uint32_t xcc_id);
 int amdgpu_mes_hdp_flush(struct amdgpu_device *adev);
 int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 				uint64_t process_context_addr,
 				uint32_t spi_gdbg_per_vmid_cntl,
 				const uint32_t *tcp_watch_cntl,
 				uint32_t flags,
-				bool trap_en);
+				bool trap_en,
+				uint32_t xcc_id);
 int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
-				uint64_t process_context_addr);
+				uint64_t process_context_addr, uint32_t xcc_id);
 
 uint32_t amdgpu_mes_get_aggregated_doorbell_index(struct amdgpu_device *adev,
 						   enum amdgpu_mes_priority_level prio);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 02d7cfae22bde..0a7d495c62e92 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -416,7 +416,8 @@ static void gfx11_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
 	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
 
 	if (adev->enable_mes && !adev->gfx.kiq[0].ring.sched.ready) {
-		amdgpu_mes_unmap_legacy_queue(adev, ring, action, gpu_addr, seq);
+		amdgpu_mes_unmap_legacy_queue(adev, ring, action,
+					      gpu_addr, seq, 0);
 		return;
 	}
 
@@ -4593,7 +4594,7 @@ static int gfx_v11_0_cp_resume(struct amdgpu_device *adev)
 	}
 
 	if (adev->enable_mes_kiq && adev->mes.kiq_hw_init)
-		r = amdgpu_mes_kiq_hw_init(adev);
+		r = amdgpu_mes_kiq_hw_init(adev, 0);
 	else
 		r = gfx_v11_0_kiq_resume(adev);
 	if (r)
@@ -4901,7 +4902,7 @@ static int gfx_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (amdgpu_gfx_disable_kcq(adev, 0))
 			DRM_ERROR("KCQ disable failed\n");
 
-		amdgpu_mes_kiq_hw_fini(adev);
+		amdgpu_mes_kiq_hw_fini(adev, 0);
 	}
 
 	if (amdgpu_sriov_vf(adev))
@@ -6827,7 +6828,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false, 0);
 	if (r) {
 
 		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
@@ -6842,7 +6843,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	r = amdgpu_mes_map_legacy_queue(adev, ring);
+	r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
 	if (r) {
 		dev_err(adev->dev, "failed to remap kgq\n");
 		return r;
@@ -6990,7 +6991,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
 		r = gfx_v11_0_reset_compute_pipe(ring);
@@ -7003,7 +7004,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 		dev_err(adev->dev, "fail to init kcq\n");
 		return r;
 	}
-	r = amdgpu_mes_map_legacy_queue(adev, ring);
+	r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
 	if (r) {
 		dev_err(adev->dev, "failed to remap kcq\n");
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d01d2712cf570..9a18df0950373 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -356,7 +356,8 @@ static void gfx_v12_0_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
 	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
 
 	if (adev->enable_mes && !adev->gfx.kiq[0].ring.sched.ready) {
-		amdgpu_mes_unmap_legacy_queue(adev, ring, action, gpu_addr, seq);
+		amdgpu_mes_unmap_legacy_queue(adev, ring, action,
+					      gpu_addr, seq, 0);
 		return;
 	}
 
@@ -3470,7 +3471,7 @@ static int gfx_v12_0_cp_resume(struct amdgpu_device *adev)
 	}
 
 	if (adev->enable_mes_kiq && adev->mes.kiq_hw_init)
-		r = amdgpu_mes_kiq_hw_init(adev);
+		r = amdgpu_mes_kiq_hw_init(adev, 0);
 	else
 		r = gfx_v12_0_kiq_resume(adev);
 	if (r)
@@ -3759,7 +3760,7 @@ static int gfx_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (amdgpu_gfx_disable_kcq(adev, 0))
 			DRM_ERROR("KCQ disable failed\n");
 
-		amdgpu_mes_kiq_hw_fini(adev);
+		amdgpu_mes_kiq_hw_fini(adev, 0);
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -5312,7 +5313,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false, 0);
 	if (r) {
 		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
 		r = gfx_v12_reset_gfx_pipe(ring);
@@ -5326,7 +5327,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	r = amdgpu_mes_map_legacy_queue(adev, ring);
+	r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
 	if (r) {
 		dev_err(adev->dev, "failed to remap kgq\n");
 		return r;
@@ -5427,7 +5428,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
 		r = gfx_v12_0_reset_compute_pipe(ring);
@@ -5440,7 +5441,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 		dev_err(adev->dev, "failed to init kcq\n");
 		return r;
 	}
-	r = amdgpu_mes_map_legacy_queue(adev, ring);
+	r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
 	if (r) {
 		dev_err(adev->dev, "failed to remap kcq\n");
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index b1ee9473d6280..5aeadb2f0f473 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -222,7 +222,7 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 
 	amdgpu_mes_lock(&adev->mes);
 	r = amdgpu_mes_detect_and_reset_hung_queues(adev, queue_type, false,
-						    &hung_db_num, db_array);
+						    &hung_db_num, db_array, 0);
 	amdgpu_mes_unlock(&adev->mes);
 	if (r) {
 		dev_err(adev->dev, "Failed to detect and reset queues, err (%d)\n", r);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 3a52754b5cadb..5159f4a9787ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -59,8 +59,8 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_3_mes1.bin");
 
 static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block);
 static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block);
-static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev);
-static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev);
+static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id);
+static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id);
 
 #define MES_EOP_SIZE   2048
 #define GFX_MES_DRAM_SIZE	0x80000
@@ -811,7 +811,7 @@ static int mes_v11_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
 	mes_reset_queue_pkt.queue_type =
 		convert_to_mes_queue_type(input->queue_type);
 	mes_reset_queue_pkt.doorbell_offset_addr =
-		mes->hung_queue_db_array_gpu_addr;
+		mes->hung_queue_db_array_gpu_addr[0];
 
 	if (input->detect_only)
 		mes_reset_queue_pkt.hang_detect_only = 1;
@@ -1570,7 +1570,7 @@ static void mes_v11_0_kiq_clear(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
 }
 
-static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev)
+static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id)
 {
 	int r = 0;
 	struct amdgpu_ip_block *ip_block;
@@ -1625,7 +1625,7 @@ static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev)
 	return r;
 }
 
-static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev)
+static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id)
 {
 	if (adev->mes.ring[0].sched.ready) {
 		mes_v11_0_kiq_dequeue(&adev->mes.ring[0]);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 744e95d3984ad..5cbd3a4ff5970 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -42,8 +42,8 @@ MODULE_FIRMWARE("amdgpu/gc_12_0_1_uni_mes.bin");
 
 static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block);
 static int mes_v12_0_hw_fini(struct amdgpu_ip_block *ip_block);
-static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev);
-static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev);
+static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id);
+static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id);
 
 #define MES_EOP_SIZE   2048
 
@@ -939,7 +939,7 @@ static int mes_v12_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
 	mes_reset_queue_pkt.queue_type =
 		convert_to_mes_queue_type(input->queue_type);
 	mes_reset_queue_pkt.doorbell_offset_addr =
-		mes->hung_queue_db_array_gpu_addr;
+		mes->hung_queue_db_array_gpu_addr[0];
 
 	if (input->detect_only)
 		mes_reset_queue_pkt.hang_detect_only = 1;
@@ -1489,7 +1489,7 @@ static int mes_v12_0_queue_init(struct amdgpu_device *adev,
 
 	if (pipe == AMDGPU_MES_SCHED_PIPE) {
 		if (adev->enable_uni_mes)
-			r = amdgpu_mes_map_legacy_queue(adev, ring);
+			r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
 		else
 			r = mes_v12_0_kiq_enable_queue(adev);
 		if (r)
@@ -1739,7 +1739,7 @@ static void mes_v12_0_kiq_setting(struct amdgpu_ring *ring)
 	WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp | 0x80);
 }
 
-static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
+static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id)
 {
 	int r = 0;
 	struct amdgpu_ip_block *ip_block;
@@ -1801,13 +1801,13 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
 	return r;
 }
 
-static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev)
+static int mes_v12_0_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id)
 {
 	if (adev->mes.ring[0].sched.ready) {
 		if (adev->enable_uni_mes)
 			amdgpu_mes_unmap_legacy_queue(adev,
 				      &adev->mes.ring[AMDGPU_MES_SCHED_PIPE],
-				      RESET_QUEUES, 0, 0);
+				      RESET_QUEUES, 0, 0, 0);
 		else
 			mes_v12_0_kiq_dequeue_sched(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 0ceeb19df2e5d..e3f725bc2f291 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1586,7 +1586,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
-	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
+	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true, 0);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 2b81344dcd668..7fee98d377205 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -816,7 +816,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
-	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
+	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true, 0);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index ba99e0f258aee..ba9a09b6589a6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -372,7 +372,7 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd, bool sq_trap_en)
 	}
 
 	return amdgpu_mes_set_shader_debugger(pdd->dev->adev, pdd->proc_ctx_gpu_addr, spi_dbg_cntl,
-						pdd->watch_points, flags, sq_trap_en);
+						pdd->watch_points, flags, sq_trap_en, 0);
 }
 
 #define KFD_DEBUGGER_INVALID_WATCH_POINT_ID -1
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 7fbb5c274ccc4..fb1aeeacf02de 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -94,7 +94,7 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
 	if (dev->kfd->shared_resources.enable_mes && !!pdd->proc_ctx_gpu_addr &&
 	    down_read_trylock(&dev->adev->reset_domain->sem)) {
 		amdgpu_mes_flush_shader_debugger(dev->adev,
-						 pdd->proc_ctx_gpu_addr);
+						 pdd->proc_ctx_gpu_addr, 0);
 		up_read(&dev->adev->reset_domain->sem);
 	}
 	pdd->already_dequeued = true;
-- 
2.51.0

