Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F65BEB271F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 21:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC69510E604;
	Tue, 10 Feb 2026 21:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cE7dIiki";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012004.outbound.protection.outlook.com
 [40.93.195.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D50910E602
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 21:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyuRHbROtdo6s0ou70r0cDcLCFjhOXlz2lML4XGDl7/IkySIOp5mt3TRuKguIOdrsXPB7Kjl4cMFBqxDJKlMF3TZrnL6aS/oMQlqb2dt4Xjtp75WXM0mh+D2IEJu6/w7Wn9DfzIAuhV4CpDj9RS3Syyb8UwEziazudxkuiYurTid/dG9Rh3pJpfoOnBUP+vX+vfxxC/rUvdtFwtvJ09+fowveMX2DGKL/KEZJWyqV7a19hDo3vXCVbP1SN8fVa2X38PoJydp5kC/BCtyQhqAPF/FhQfcSv+1spmLeRu+kDR8ACa/wIfPKkTJ9pft+zTsM+jZOZ5ymKh3TbJODVXN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adZofZPVSCLRN3qkyrrQDgeEwqu7MXjCeOBa5LpBxLI=;
 b=r9EX+ZutBqAW+XCdNVuizGbAzi/QVQKbhw81efkIHE5P4Tp9bpFrZuoko+XS23nMyNcTj7mFmXRL04vRlbQFdc4dRyg9iidAhm2uamxRZhERBELLHqso47cqo5heZ+1Yc5LomNHoK7kGnzQhqhsd42g/4vD5f6w0DbyTAx83eWzVGy4V/FhzLVZQlKQnowAQAzDCx5yWt2COg4Vc857+hRTWVWRiKgkERgz2LHrYOPMnkhKrouDl9Df+bbKOVR1T6OabTnJHFUWQOjBbl/eJkNqv4JHgzQ5OOrxidC3fKmoZfUFC7NyKFJf776+eKLjrHa4v7QeboGayt06X/6FP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adZofZPVSCLRN3qkyrrQDgeEwqu7MXjCeOBa5LpBxLI=;
 b=cE7dIiki4gHzdA+RW8NLRd/QUAve/cOTdUzAW3+dyqZyVGIPOPLqZDcbk3TWlLkInRYvfy9LHpqrXMYy6xF8iV5+mK0udnONIJ2jnM55cgKIefCoZxV9v59+B7TmuN5C03D2XowY58Y94YyqYZiyyMJizGXkbll/gj5Td3oM84Q=
Received: from SJ2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:a03:505::8)
 by BL1PR12MB5731.namprd12.prod.outlook.com (2603:10b6:208:386::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 21:48:08 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::13) by SJ2PR07CA0008.outlook.office365.com
 (2603:10b6:a03:505::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 21:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 21:48:05 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Feb 2026 15:47:59 -0600
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <alexander.deucher@amd.com>
CC: <leo.liu@amd.com>, <Boyuan.Zhang@amd.com>, <David.Wu3@amd.com>,
 "Saleemkhan Jamadar" <saleemkhan.jamadar@amd.com>
Subject: [PATCH 06/14] drm/amdgpu/vcn: changes when kernel queue is disabled
Date: Tue, 10 Feb 2026 16:47:21 -0500
Message-ID: <20260210214729.80964-7-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210214729.80964-1-David.Wu3@amd.com>
References: <20260210214729.80964-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|BL1PR12MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: a42708a7-518a-4611-d640-08de68ee126b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D6oOne1y6s51HPfXHXUPRmnYOwRV8TxuZW0QNc6xVVCjS3NYa5mTjt+C2oik?=
 =?us-ascii?Q?IpD0Ea7AZVbD1o/U0jj9wTT/jx1KfnBJGXbuKJ0CtM2eNomoEUQw76mN8/Kh?=
 =?us-ascii?Q?XWQoBdKRlUKKiGcaLqeIJRdgGpBHxW1YRQ/4rAa7XNv74bfy2y1d2BTtaA41?=
 =?us-ascii?Q?aSAlahiGDMzB2NO+CL4P47YnPObMhS7tmLPac1ittHzyOnBFoJYr6xnb2whx?=
 =?us-ascii?Q?5QXPgcx0W1osv8BHZMyOKJZSUk6KT2rXCU98xGt7ZGAQpiqA4CYKurviGizj?=
 =?us-ascii?Q?sQYAJ6iSOxaqpe3I6CwRszNVaT9hTIgcCA1Q5/joK5q7t2IXsRMqO1orNCWc?=
 =?us-ascii?Q?ULsBkrHDoN88REMuH8hkoZc95frxMq/GYw4/mx0BtRdLhDOeXdAJvO1k3Jqz?=
 =?us-ascii?Q?6yRz8+7dzaARJ6ejSK+FsHYN7jRJtch3uPZN0mwIL1kRWeC82kBUnuWuKplJ?=
 =?us-ascii?Q?rpzSVj3XKMHkdb7BLftJL3GTR1Gq1meXDhVDfUFYXvSmAjIjK81buA7l/ybj?=
 =?us-ascii?Q?4mSkQgn07ba3VRvodGvVVED2LisxJgBidWzafh9fFiil7mItPhv8OAzMc2Va?=
 =?us-ascii?Q?oOb12vgU45xooBu0UlywxW+bc0mfSxoeB5pC5BiCXJEpGO/gm4NUeL5stZ6a?=
 =?us-ascii?Q?qPgvv0d46Y/+t+RJEbPCO/qK9+3CBA11cJddWrd3YzvfgULfm4Ib2n8srI/b?=
 =?us-ascii?Q?88yunFZvfFO1nUIw4RsN62DwxZ95daKpKSLWENP9JKTlThWXywqIH1tV4ZLS?=
 =?us-ascii?Q?eencL87PZCWPMkMlbbcUjxRuxwh1GKZUSyijfde3cOZY3JbRVPd3dEhpkwwV?=
 =?us-ascii?Q?vuWAmSoaaq9IZvG+zzMqJi5GDFU5mJI8l5B6FO8Z+AkVE5EGC4ExFdQE6FWD?=
 =?us-ascii?Q?8GXM3TncPkdDBMn6UB9HjzWyspzCd3Zdwg1PbieOgC6VlqNrO7TeW3RpMHfh?=
 =?us-ascii?Q?ZpysE2Sms5j/5gBqJKlnVreCXlyGCpX6rHINPypeXhJRIzAks3aHtmLWkZ2O?=
 =?us-ascii?Q?Ei4gSxgjB/CUfeTJVjA1B4+0IahAGvksviRo/OT9YNoSHHNcOlbX9LFSemCY?=
 =?us-ascii?Q?pxWDqn73UMj/mQjfJAl47RLwPWjHAbnwq6Z6KOPkBS57GuragL86nbM8BfqS?=
 =?us-ascii?Q?20uZn3VWQJmEG2mWAP1DI+yZMti/wnuFpFrnte10hRbzjMQGjF2/uOanCmSB?=
 =?us-ascii?Q?Op+2tRTUm6sv3h/haaGRATd8/Mzeqo2iKQAonSfWaBDuoBcuF7+qnoRf5bZD?=
 =?us-ascii?Q?Yjd7BJm3aWY6hZJfJDIa+aewUnobPBCbc+IT2U0BA2dCuD9hGxdRhj9h79/X?=
 =?us-ascii?Q?Num5KPjX8AaYGDzViXgibXlOr2YmFsNOFzzyEhs1f/AVK3z/Xselx6ubcKTT?=
 =?us-ascii?Q?DCpzskzh8Rb7fyQHzPHFPljW/n6q7MfsDxfgLEr6pEYwxzcHrIjOCzcWIZiu?=
 =?us-ascii?Q?+g3VKhEP55DCdmGcNw8g9Qx3BeoKXqRy4fDa7aHAvMG3k478u8D5bi7LVleN?=
 =?us-ascii?Q?oXvE5cohdyNc8bovyCQLjljUv6mAKiL1DAX4PJ0FVLC5AxR4Rij4nMLNi821?=
 =?us-ascii?Q?YmwKiF84koHGoUn3nRrb5H+D1zxHTohfEq6ySI1j3Em4EPoZGbKQqzn+PQe2?=
 =?us-ascii?Q?Bs45YBgj/iI1azx0bgCraJ/VEI1ESxlX6v0uqZ20LMuF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jSdoCRQftEvuAyhgEDXXH46Wngp3/IOQNoOCZlcgXu/dzBmpBsIHmzj/+Dvw1anHaOX1MMmEota7IaPmTdIYfbqqISlLNI2ooOZ/OXtHjK8PV1eLjTvUjM+NnUryEA4K79A7uQ2kkbk+4OQbkVrsXFYSWjG6+1A1QOZPyEFxRjr9WC8Et3ve0q9XZgBXUdnvdM0ypHIkSvpdWT8/zLkkH92iQL2pWbTVqLNNzGkCSvYff3sLJCuDJ/Sl3ZUMgvgc0FAop9DCQS3TBrgNpDv7hQWmHk8Ffl09ZDbThNkzFA8WwqXs96FPlbs+K4NFUrURE2aKcyaHub/OQngljXb97PymNs3RwB2327YX5JM2ibGZ+AN09yElFsqE0uae5AzeiotVft108YgBilq0MfdztZJ/km6nS8JzIVQZhxzesuwDzuENv47tEodpVyyQXXB1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:48:05.2399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a42708a7-518a-4611-d640-08de68ee126b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5731
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

From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

v4 - don't call ring test and touch the ring structure
     when it is not initialized (Christian)
     add kernel message to note kernel queues are not
     supported with user queues (Alex)
v3 - don't call amdgpu_ring_init() when kernel queue
     is disabled (David)
v2 - Add flag to enable/disable userq and kernelq (Alex)

Disable ring buffer address update to the RB register for user queues.
RB register update is handled by UMSCH.

vcn 4_0_5 cannot support both user queue and kernel
queue at same time, so disable kernel queue when
user queue is enabled. (David)

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 51 ++++++++++++++++++-------
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 82624b44e661..bea95307fd42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -368,6 +368,9 @@ struct amdgpu_vcn {
 	struct mutex            workload_profile_mutex;
 	u32 reg_count;
 	const struct amdgpu_hwip_reg_entry *reg_list;
+
+	bool			disable_uq;
+	bool			disable_kq;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 1f6a22983c0d..d2744cd4c865 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -115,6 +115,24 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, r;
 
+	switch (amdgpu_user_queue) {
+	case -1:
+	case 0:
+	default:
+		adev->vcn.disable_kq = false;
+		adev->vcn.disable_uq = true;
+		break;
+	case 1:
+		adev->vcn.disable_kq = true; /* does not support if userq is enabled */
+		adev->vcn.disable_uq = false;
+		dev_info_once(adev->dev, "Kernel queues are not supported with user queues.\n");
+		break;
+	case 2:
+		adev->vcn.disable_kq = true;
+		adev->vcn.disable_uq = false;
+		break;
+	}
+
 	if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(4, 0, 6))
 		adev->vcn.per_inst_fw = true;
 
@@ -187,13 +205,14 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
 						2 + 8 * i;
 		ring->vm_hub = AMDGPU_MMHUB0(0);
-		sprintf(ring->name, "vcn_unified_%d", i);
-
-		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
-				AMDGPU_RING_PRIO_0, &adev->vcn.inst[i].sched_score);
-		if (r)
-			return r;
 
+		if (!adev->vcn.disable_kq) {
+			sprintf(ring->name, "vcn_unified_%d", i);
+			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
+					     AMDGPU_RING_PRIO_0, &adev->vcn.inst[i].sched_score);
+			if (r)
+				return r;
+		}
 		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
 		fw_shared->sq.is_enabled = 1;
@@ -300,6 +319,8 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
 		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 				((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i), i);
 
+		if (adev->vcn.disable_kq)
+			continue;
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
@@ -1005,10 +1026,11 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	}
 
 	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
-
-	WREG32_SOC15(VCN, inst_idx, regUVD_RB_BASE_LO, ring->gpu_addr);
-	WREG32_SOC15(VCN, inst_idx, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-	WREG32_SOC15(VCN, inst_idx, regUVD_RB_SIZE, ring->ring_size / 4);
+	if (!adev->vcn.disable_kq) {
+		WREG32_SOC15(VCN, inst_idx, regUVD_RB_BASE_LO, ring->gpu_addr);
+		WREG32_SOC15(VCN, inst_idx, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+		WREG32_SOC15(VCN, inst_idx, regUVD_RB_SIZE, ring->ring_size / 4);
+	}
 
 	tmp = RREG32_SOC15(VCN, inst_idx, regVCN_RB_ENABLE);
 	tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
@@ -1195,10 +1217,11 @@ static int vcn_v4_0_5_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
 		     ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 		     VCN_RB1_DB_CTRL__EN_MASK);
-
-	WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
-	WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-	WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring->ring_size / 4);
+	if (!adev->vcn.disable_kq) {
+		WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
+		WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+		WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring->ring_size / 4);
+	}
 
 	tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
 	tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
-- 
2.43.0

