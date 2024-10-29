Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4CBD3A67C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EDCC10E6C4;
	Tue, 29 Oct 2024 17:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R66Vb7gY";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF9B810E6B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApqlinD3FlUCuzy0tWRsfVY/OHtkVAkUvIGOD7Z8TwIBDP6O7UtGyI9kXhaPI39YrBADqYGsi9W5IphvI1YQFdCyiLxfgr22smKJCV9e/+YxnHaWPnTFMqIFAwrQMdSymnVeMyEsLaThisW40eK2xJ5PNCXobnskcEEjiERhq7OdbTNupo7J6BSRSRvbqiUBIdenBfhExk0tWYSlGK/V2/MkWm6Trtism+83kIvXiGS4FeJfAzqWb5rd8oAStZfEf6LrHbOQe5DS09VBL1UJlfsHUdeQ/w6hq3U5e36KyKYbUPbJ82hJWHqSFyWO8eEJYuQFqDM9fPgXs7AUwscwMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFMjcphp7tacg+rPnyLubmHXVz1qUayThJ2U0YiljeU=;
 b=d5/tQuov+hIQQ6bgYDlLfAJStVgM5/AMQ/AwztwqHOB6dR7yq8vpVTGRVOaBwnirtZ1+/sY+Tsv0pga8Gg3ezkLImZqk4hS9mpKppGmrtRYH7sTOszur0bKtN/gUVZWSAMVV99w/HBGV4QEk/wZ5hyfjgAkx0rUhS26IQ8o9DQj4cf9nI0bs2PiFHpyKVEvKjTQObpeQ42w6/d1OE31JnEk5V5koR7HeYb01F78EW0W349MeDMNDKwAWa16k5UKBmN5yuSC9QWzpZ3BN3XhVbhIkhZvmes2k1goVr9DOuC/yHvrEtMcOEUyUxqG+e3+Guyun3L1f+/xdMEnLoMo7Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFMjcphp7tacg+rPnyLubmHXVz1qUayThJ2U0YiljeU=;
 b=R66Vb7gYHk8hdVrWanlgqxOu/2C5ryjAI+P3hiKcPkXfsP6BeZV92odZiT+9ovegEQIRQCQM+ATDWE5CEwCPWn7H8MCyRg18l8jv0rpG9NMGZ7khrLLV6AIdW8Y9JanR9pykTMHk7MqDe6AeO2JkXpUe3x7T00Fvp86rNMVE4aA=
Received: from SN6PR16CA0040.namprd16.prod.outlook.com (2603:10b6:805:ca::17)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 17:43:09 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::28) by SN6PR16CA0040.outlook.office365.com
 (2603:10b6:805:ca::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29 via Frontend
 Transport; Tue, 29 Oct 2024 17:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:43:09 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:43:02 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 24/29] drm/amdgpu: suspend for each vcn instance
Date: Tue, 29 Oct 2024 13:42:35 -0400
Message-ID: <20241029174240.682928-25-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029174240.682928-1-boyuan.zhang@amd.com>
References: <20241029174240.682928-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: b9661ee5-f296-44f8-5a8b-08dcf841275e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E0O4gYrrLaIfKtJooPrRZ9whrIVy1utC5EENNW3Ccyor4ZjFUR1xEk/F9Got?=
 =?us-ascii?Q?qJgeSclnvZEIC8XHqaMla1Lqjkjarh0dcXLLqrnK4m7OM4u9WibIUTYTojzU?=
 =?us-ascii?Q?YcG/GC7mUoIjBH8iRbL583T795Ovzh6xK278B1mi9cnyqp1oX+ecOVys7Ffr?=
 =?us-ascii?Q?Lq3LjS74x4GH8WwQ6GeRGko1QEPpyhIm2mfCUxaYNck00lNWe26iV/SxaeTj?=
 =?us-ascii?Q?S/v54yVGygEuOOs0zOmjliRf3bPmTRsnr1cLTwX4676yxx/hqplWi3gWbeLH?=
 =?us-ascii?Q?QYTP5EBV5iDj2UC/LpzpmEy1jlrjgMr105pI+WPbXLLcWEHVk57lfQLIqYCT?=
 =?us-ascii?Q?99sgs/mN/rBJlfjutozvscZQgUH//JcPwe/mSNIIpndT7q4M5eGRoypyK+nT?=
 =?us-ascii?Q?PVXQ2/B47KLywnJilk0AL+kApku9dOGUoLbAvfNhbxbtJXmvP/GSuLW2jnSI?=
 =?us-ascii?Q?zyZ1UdRfJ/hQ/oPgvkXj7/ejuy6LTBLgE13NlW95bT1NaHTQT0DITRwVbnxT?=
 =?us-ascii?Q?o2Nh1RnZS+qehi/zxkA2bVrqf8LQugls5PJIhpIHkb+Ctg2YEelEm8gC++Bi?=
 =?us-ascii?Q?84D2WNNyZuGuHe4Jks8N1CEReEsohtFveirALdlQg5LLfFDJoEJfjsXE3GkV?=
 =?us-ascii?Q?Zp6PtHUAb6effqClFUqSF4i5Wk8dVOKDfEy8JqzZOZfphuuGYfnVbGi8U3iR?=
 =?us-ascii?Q?zbLkBIN/IVeiBHmsutHwNHcEB1dHGy+m6UDMC+cPWRDLSmcFbVkX37qqUnjy?=
 =?us-ascii?Q?XUApX6sy3sdYY/FgMWXO0i93Xm5USRK044CPERx1GFq67JFg80BgL+FeUSsC?=
 =?us-ascii?Q?e97Vy1jsn2Y5/tiXoCCQxxo3k3BZkV3NB6iLE12B9B8GRJ6R4EIIVKy4BT9e?=
 =?us-ascii?Q?fsJCL0xEh1Wf91NRs+a7R3H5G/l1F+ojc6bpWmgRY51PKfwGGGxyss58AaPl?=
 =?us-ascii?Q?4zUd49q7KcZc1AispF6zmLcPBQ8+HaOOATadFmsklGYqJoWqEDDASMkbhJ6x?=
 =?us-ascii?Q?vKKwecLzJemMx+fO6STEETDp77GpdQOnhIirAd9jnYRJuhslZvJYI0ab15uo?=
 =?us-ascii?Q?HQM8Fjz4XAlmvuYJuBfF5J0o6Nz9LoYI2OdpwyCBV2kd4ovYr5YDW8FHfEps?=
 =?us-ascii?Q?yJ2n2mU0kVXsxah/rgE+p8WTE7/INqMhlU2yW5kOGOUc3+yg6f/Uh/HgZchs?=
 =?us-ascii?Q?KiLP+aVBhr7saaBN3C8/XZ+G88Iyeh8+x3sqLvjlpcFPwvM5cTVrfuP8ZV8N?=
 =?us-ascii?Q?wFl2ZrQlEbslfe58srnQJiAEBuHq3al/VTJvWlzYaWxXUMfY0Up/+va+yLRq?=
 =?us-ascii?Q?3ri4Y0r0G/E8Q4H0RyPJHhEOUG2Be/rvmPwZikPcWBvHIILMXPdlarjBhdqq?=
 =?us-ascii?Q?GOpt1OiBl35T7uIk5ntt92yi7CHYSOakDPFIIZFoTfraFaKPeQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:43:09.5887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9661ee5-f296-44f8-5a8b-08dcf841275e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Pass instance parameter to amdgpu_vcn_suspend(), and perform
suspend ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

v2: add vcn instance to amdgpu_vcn_save_vcpu_bo()

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 13 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   | 38 +++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  4 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  7 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   |  6 ++--
 11 files changed, 59 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 24dae7cdbe95..4fc0ee01d56b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -42,13 +42,14 @@ static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
 		/* XXX handle errors */
 		amdgpu_ip_block_suspend(&adev->ip_blocks[i]);
 		adev->ip_blocks[i].status.hw = false;
-	}
 
-	/* VCN FW shared region is in frambuffer, there are some flags
-	 * initialized in that region during sw_init. Make sure the region is
-	 * backed up.
-	 */
-	amdgpu_vcn_save_vcpu_bo(adev);
+		/* VCN FW shared region is in frambuffer, there are some flags
+		* initialized in that region during sw_init. Make sure the region is
+		* backed up.
+		*/
+		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_VCN)
+			amdgpu_vcn_save_vcpu_bo(adev, adev->ip_blocks[i].instance);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index d515cfd2da79..50047c636904 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -294,47 +294,45 @@ bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type t
 	return ret;
 }
 
-int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev)
+int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev, int inst)
 {
 	unsigned int size;
 	void *ptr;
-	int i, idx;
+	int idx;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (adev->vcn.inst[i].vcpu_bo == NULL)
-			return 0;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		size = amdgpu_bo_size(adev->vcn.inst[i].vcpu_bo);
-		ptr = adev->vcn.inst[i].cpu_addr;
+	if (adev->vcn.inst[inst].vcpu_bo == NULL)
+		return 0;
 
-		adev->vcn.inst[i].saved_bo = kvmalloc(size, GFP_KERNEL);
-		if (!adev->vcn.inst[i].saved_bo)
-			return -ENOMEM;
+	size = amdgpu_bo_size(adev->vcn.inst[inst].vcpu_bo);
+	ptr = adev->vcn.inst[inst].cpu_addr;
 
-		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-			memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
-			drm_dev_exit(idx);
-		}
+	adev->vcn.inst[inst].saved_bo = kvmalloc(size, GFP_KERNEL);
+	if (!adev->vcn.inst[inst].saved_bo)
+		return -ENOMEM;
+
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		memcpy_fromio(adev->vcn.inst[inst].saved_bo, ptr, size);
+		drm_dev_exit(idx);
 	}
 
 	return 0;
 }
 
-int amdgpu_vcn_suspend(struct amdgpu_device *adev)
+int amdgpu_vcn_suspend(struct amdgpu_device *adev, int inst)
 {
 	bool in_ras_intr = amdgpu_ras_intr_triggered();
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
 
 	/* err_event_athub will corrupt VCPU buffer, so we need to
 	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
 	if (in_ras_intr)
 		return 0;
 
-	return amdgpu_vcn_save_vcpu_bo(adev);
+	return amdgpu_vcn_save_vcpu_bo(adev, inst);
 }
 
 int amdgpu_vcn_resume(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index ce8000ca11ef..be681bcab184 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -486,7 +486,7 @@ enum vcn_ring_type {
 int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst);
-int amdgpu_vcn_suspend(struct amdgpu_device *adev);
+int amdgpu_vcn_suspend(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_resume(struct amdgpu_device *adev);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
@@ -520,6 +520,6 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
 
 int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 			       enum AMDGPU_UCODE_ID ucode_id);
-int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev);
+int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev, int inst);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 44370949fa57..a3845e7747b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -226,7 +226,7 @@ static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	int inst = ip_block->instance;
 	int r;
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -300,9 +300,10 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	bool idle_work_unexecuted;
+	int r;
 
 	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 	if (idle_work_unexecuted) {
@@ -314,7 +315,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 7b5f2696e60d..8e943d1fae17 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -257,7 +257,7 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -335,13 +335,15 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_0_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v2_0_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 8ce3cea6cf44..9ca07e56b052 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -316,7 +316,7 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -412,13 +412,15 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_5_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v2_5_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 36100c2612d9..a25d2b9784be 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -325,7 +325,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -444,13 +444,15 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v3_0_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v3_0_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 00ff7affc647..fcf7b23cca90 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -277,7 +277,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -372,13 +372,15 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v4_0_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index feb373a96cfb..ece9b1df2743 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -235,7 +235,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -331,13 +331,15 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_3_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v4_0_3_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index fb1e1d5bcdbe..f1ec632a9eb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -246,7 +246,7 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -323,13 +323,15 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_5_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v4_0_5_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 137c3b452433..fdfb3084d54e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -210,7 +210,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 		drm_dev_exit(idx);
 	}
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -287,13 +287,15 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v5_0_0_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v5_0_0_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
-- 
2.34.1

