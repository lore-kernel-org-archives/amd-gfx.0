Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B2DC44500
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 08:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F105D10E950;
	Thu, 22 Jan 2026 08:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dowzu8W6";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013059.outbound.protection.outlook.com
 [40.93.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3698D10E950
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 08:58:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NL6wh+gUFTWdibBFSYd4CpRGIfkCh09dkoBdjxt9gg55gG1yRnW8ep/C/usT9qNz6V/xid1QsCd3reMJzKXj6Z6U3DJrivvNT2myD53/xa5BhmD45Slw8rWfrlZxh0rsCo+85TG8AWEuqDg5gzdFWYxZmz71tMohh3mcAy3TB0UfITgJR1lVV9GW0Gt0daodgAhnsLAB5xod1h8OyHef4VCorL4WQP01bWcVovCj29x0I+4WYotsoLJSNEzC3UkjtokYfn536pO0Vo/pz6aPwmMN1bsmbYcmbkskn5LtKUr4/QCdZdShIATKPI1fTCLeJ9GRqTYurOT/z5kpOfxpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWLl83jdZfhN3VfuKjxuA0HaT3jakbU/UHtvQ1ZrjFQ=;
 b=qJPS9kM1cKe7mblAaST+jLjF+CvhrZVMiMd/t1lW5NZOrs6wl1SbhkgbTP3NVeHKT7QpgQraXGDjCtcHvc/o92JMZvqu/rJPmTMIeR9QIlz0Q0RaeiRvm1JGg1FoNWbDDVagDOOOkeF8AUibLVYPl316JlyEQqqkkG9JSP7fu5g7cky1/rsM3AsLSNqTJ8PieMCTNP9uJIXc+AUXtoVFQEisAp533BfHQZpOkyzG6Mm2Tl94C5+GMc1xGQYxjIHaQI7f4HPBC/oR9wSTXG7GAbTSmXjzmSIKL8EPAGcNvdOInuc6ZUZtbnmn2kG3KNVzqkwr1jGmh1qb9kfCCNCrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWLl83jdZfhN3VfuKjxuA0HaT3jakbU/UHtvQ1ZrjFQ=;
 b=Dowzu8W6ND7CO4xXv0mnUZFgZVXzGTHYrbraPDo+mtvKrGYDdUy4TbV5XEGu3dxetd19CnShYLodoh4bKIiPO1iFUprAoG7s+5LJikpvC1l46pm5ZEukN7zYbmUFN1SSNxySVyKUyf4ytX1cKoTvdqQrnbcb9vO99d8c8KIQ+5s=
Received: from MN2PR07CA0013.namprd07.prod.outlook.com (2603:10b6:208:1a0::23)
 by DS7PR12MB6192.namprd12.prod.outlook.com (2603:10b6:8:97::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.9; Thu, 22 Jan 2026 08:58:07 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::8c) by MN2PR07CA0013.outlook.office365.com
 (2603:10b6:208:1a0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 08:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 08:58:06 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 02:58:03 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 22 Jan 2026 02:57:57 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 3/9] drm/amd/amdgpu/gfx11: Implement GFX11 MQD update
 callbacks for COMPUTE IPs
Date: Thu, 22 Jan 2026 16:57:13 +0800
Message-ID: <20260122085738.1542800-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
References: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|DS7PR12MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3b0f89-7182-440e-95fe-08de59945bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SnPkMOV3Qy1q85/eVqfKFItDE0mYoGGq1nCmo95CliV4710sVlKCZcFm1mHB?=
 =?us-ascii?Q?lnFVXGGDindES45UIXYZCvjStu1LtsYvSKCSsmzxXpQCcpSHDJH5JW1VUAdG?=
 =?us-ascii?Q?Z9cce38AsDTrb3DnOkPzftNcHzV1mrmHh1BgsB0Av+6b4s5ezV05DIlrXoDI?=
 =?us-ascii?Q?ne44XpNRCq9zogSVn02AaKOnFIC67yGak2HwzMvyJvQ+8aIzIsGXQ5kM0yk2?=
 =?us-ascii?Q?PDtI5r47aecPnc0VmEMCIbPOE8tMz+Gf9/KZYzsxC7sN6/vww++CVRLV8Buc?=
 =?us-ascii?Q?59EfMCqAOeLog26vpQEW8vJE+623MlWGFxcK479KFBePz/QANZMdd72TIq4e?=
 =?us-ascii?Q?7vcFjizsJa4OPf/WeAMYDncdr3Bv/aARW580n4vNE43LbMZrnLVvzRgutlpQ?=
 =?us-ascii?Q?bxDEB7cZsqJdkzoVi0EvCuWDHhITnqJagv9aTX+MCTg8NL+80hDEwce/shcX?=
 =?us-ascii?Q?SpAUIy1joedmiM/GvpqGIxYUFM3KcIVYFlOSzmWHFyBi/vSUkDA7R3XFIa4o?=
 =?us-ascii?Q?ezxilCKOZG/GwbfD37N0RYFG5sqtqdvuyHiU2a7WtS2MGhGGDOnnAoFqWn56?=
 =?us-ascii?Q?gmVRCrCD+ercBV3YYpt1402NWS+EFUqK4QhqpGSuC7Fmj81ePCzPJCz6cZsu?=
 =?us-ascii?Q?PBGKt3TK7ieq+yYIuzorUNXPJ81SpTqw5vQjRrg/FCvB7FMIVXvHmaQMGQuW?=
 =?us-ascii?Q?OkgM2jMRIEYqjD5CQ3DSJL8jqIIwQnua9mItND8j0VLW3Iu9PkED0AQlMRwC?=
 =?us-ascii?Q?L0FGQZYgV4EP+kpB7kN42sPI0aHjxm417TT9smvfqXnKblvel6ra4cDXq0N9?=
 =?us-ascii?Q?QRzwoSqQfTa6uryKTsRCCMB4F8VmkhecajYNXxoNidykdfmR5K20nQOXaQyp?=
 =?us-ascii?Q?UHwCxOmEe5oxhMCh10xM//kdflgJKRbMVnxsxSaq54YphhP7HT1fOAXQ1ilr?=
 =?us-ascii?Q?IPQMYlVlcfEgILVfR9PDsPbNzljRCub5CSh7L19iK/ihy63sfGB6HZPKdZNf?=
 =?us-ascii?Q?ikZl/pCbhDsIYDXmW3P6rsEfuBNcFAAGaNRv5Mu3nIVFQtZpX/JGbvNaXY9d?=
 =?us-ascii?Q?x5cXjkzzserm0DOruY3Ocqq3+tgDHBcUxtPAyD66le3w2mG8kEcxWUHKismZ?=
 =?us-ascii?Q?Zs+uLSyPwX7v1xa0Ikd386wOV7giY6Jbp7AwVYLvq0lYl0MGZV1FnynF2eTm?=
 =?us-ascii?Q?oDcKAvDji6BC+N4NvlunlhBrkHswsOHjIq+8W7InYDHWT6eZcM/8EiNQiZ4c?=
 =?us-ascii?Q?fS0UvYRyWK9MoRzHWtDaNGg2WjVMfzEISxUR4J92YyvGf6zB26A7qfbeXn/D?=
 =?us-ascii?Q?lKUPGe3Z5AjIXkeffZRJmLv1IndrgkNSO0Afp42jmaTHvzifpJDAwvuUNK7o?=
 =?us-ascii?Q?UEsd6xT5657URNtRII1MNlKZmSjt9YdbYlpGTNGWs8iulZ9sk/YmS87j0ZzB?=
 =?us-ascii?Q?CtDmoqOWpoqVy5xhw5lUgB5eVGeP8bjeMx4ab/0mW6808fM3p/2BKQQFmqQU?=
 =?us-ascii?Q?URIsCKNvzSfnu9lgQWPJnH714eSoEuIYGEkWCqwErCwsjWwrzko+jVXbfH2w?=
 =?us-ascii?Q?t4R3JjNlEXpABfqTSDTp8rcMXZSkEvv8n1q/8O4dk/CqfgZJ5UPZcISd3WCk?=
 =?us-ascii?Q?/be4vWcwT8lZBqBpv7tSn4QJE+cv/mCQNJticyDyJLzMGAjzMCYiUmAzZpV2?=
 =?us-ascii?Q?M6wklA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 08:58:06.5322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3b0f89-7182-440e-95fe-08de59945bf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6192
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

Add architecture-specific 'update_mqd' callbacks for GFX11 to support
runtime MQD priority updates.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 79 ++++++++++++++++----------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 3a4ca104b161..a47c91d33846 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4238,11 +4238,55 @@ static int gfx_v11_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 	return gfx_v11_0_cp_gfx_start(adev);
 }
 
+/**
+ * gfx_v11_0_compute_update_queue - Update runtime-configurable queue parameters
+ * @adev: amdgpu device pointer
+ * @mqd: MQD structure to update
+ * @prop: MQD properties containing updated configuration parameters
+ */
+static int gfx_v11_0_compute_mqd_update(struct amdgpu_device *adev, void *m,
+					  struct amdgpu_mqd_prop *prop)
+{
+	struct v11_compute_mqd *mqd = m;
+	uint64_t hqd_gpu_addr;
+	uint32_t tmp;
+
+	/* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
+	hqd_gpu_addr = prop->hqd_base_gpu_addr >> 8;
+	mqd->cp_hqd_pq_base_lo = hqd_gpu_addr;
+	mqd->cp_hqd_pq_base_hi = upper_32_bits(hqd_gpu_addr);
+
+	/* set up the HQD, this is similar to CP_RB0_CNTL */
+	tmp = regCP_HQD_PQ_CONTROL_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
+			    (order_base_2(prop->queue_size / 4) - 1));
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
+			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
+			    prop->allow_tunneling);
+	if (prop->kernel_queue) {
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
+	}
+	if (prop->tmz_queue)
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TMZ, 1);
+	mqd->cp_hqd_pq_control = tmp;
+
+	/* set static priority for a compute queue/ring */
+	mqd->cp_hqd_pipe_priority = prop->hqd_pipe_priority;
+	mqd->cp_hqd_queue_priority = prop->hqd_queue_priority;
+
+	mqd->cp_hqd_active = prop->hqd_active;
+
+	return 0;
+}
+
 static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 				      struct amdgpu_mqd_prop *prop)
 {
 	struct v11_compute_mqd *mqd = m;
-	uint64_t hqd_gpu_addr, wb_gpu_addr, eop_base_addr;
+	uint64_t wb_gpu_addr, eop_base_addr;
 	uint32_t tmp;
 
 	mqd->header = 0xC0310800;
@@ -4298,28 +4342,6 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
 	mqd->cp_mqd_control = tmp;
 
-	/* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
-	hqd_gpu_addr = prop->hqd_base_gpu_addr >> 8;
-	mqd->cp_hqd_pq_base_lo = hqd_gpu_addr;
-	mqd->cp_hqd_pq_base_hi = upper_32_bits(hqd_gpu_addr);
-
-	/* set up the HQD, this is similar to CP_RB0_CNTL */
-	tmp = regCP_HQD_PQ_CONTROL_DEFAULT;
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
-			    (order_base_2(prop->queue_size / 4) - 1));
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
-			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
-			    prop->allow_tunneling);
-	if (prop->kernel_queue) {
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
-	}
-	if (prop->tmz_queue)
-		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TMZ, 1);
-	mqd->cp_hqd_pq_control = tmp;
-
 	/* set the wb address whether it's enabled or not */
 	wb_gpu_addr = prop->rptr_gpu_addr;
 	mqd->cp_hqd_pq_rptr_report_addr_lo = wb_gpu_addr & 0xfffffffc;
@@ -4363,17 +4385,12 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
 	mqd->cp_hqd_ib_control = tmp;
 
-	/* set static priority for a compute queue/ring */
-	mqd->cp_hqd_pipe_priority = prop->hqd_pipe_priority;
-	mqd->cp_hqd_queue_priority = prop->hqd_queue_priority;
-
-	mqd->cp_hqd_active = prop->hqd_active;
-
 	/* set UQ fenceaddress */
 	mqd->fence_address_lo = lower_32_bits(prop->fence_address);
 	mqd->fence_address_hi = upper_32_bits(prop->fence_address);
 
-	return 0;
+	/* Initialize runtime-configurable parameters */
+	return gfx_v11_0_compute_mqd_update(adev, mqd, prop);
 }
 
 static int gfx_v11_0_kiq_init_register(struct amdgpu_ring *ring)
@@ -7423,6 +7440,8 @@ static void gfx_v11_0_set_mqd_funcs(struct amdgpu_device *adev)
 		sizeof(struct v11_compute_mqd);
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =
 		gfx_v11_0_compute_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_COMPUTE].update_mqd =
+		gfx_v11_0_compute_mqd_update;
 }
 
 static void gfx_v11_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *adev,
-- 
2.49.0

