Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BC2C2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 18:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9793C10E415;
	Mon, 19 May 2025 18:22:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GG/c/5G+";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF04110E406
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 18:22:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLfFfbjTj53bGosCBPHQX329ctqekqjwwnlqfaacfid0ORzCUr8MFfVEgBY4uW3C/LTcR32SAERS7NlJ/s58r3tGIHV0RhFIZQKHP+d878Dq7AUz0DzasecXvlS0mAZ/gnO6+81CviE2ZEMGESmEe+qlGpQlslKTGfe+rnimigYKpene3iOCgIMXCKk1HIkHjk+HerFOzZq1SNydswfrLrQNS3KHDjnLxGQGOhXVJZOGfnrBpKi3lLreWvpZ1ATn7//rCSgOVAWlaxLNYIpjBlJEoJjxRj5+Gmmdv4Cc9SCeKh67R12fLUdAlp4J/SoaaQCaMb7j0qeHEjI2tadV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekLBnhOrPGvdReHhGuYZtg46CMaM29ivmzUZdVJjSl8=;
 b=hpn9I8fq8tN7Hh3/tTsdUklzriRLZ93TIynXHzKzHXdoQCiYdGdxLucWxQF5ByH7SaicSzs7BTRRX0i24raS47j29Na50HWdf7ZHDB3P8gsCMWzSac7by7K0jmaAECQaz3MFk/hQh7TzOUUP5opKxb57kL6mGg8bn/OR3weN4eZH04Z1+LoLKwOHyDSdAF0I/bcw4PfynHU2rqRewgELdzRDbQJCJvXlfTkpTKD4hwUJG23xY6i0vqj1T8bsoySllUb3IYrE2peVVpPJVrwfohivLYbRfSwpoE1If/waqeaMkNtLSgCo3R0V10NaY3R/dJverDPVxWXj1jhdazvK1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekLBnhOrPGvdReHhGuYZtg46CMaM29ivmzUZdVJjSl8=;
 b=GG/c/5G+MpJD1xDgqY0GPe2ihaBgzjEshrnjjz8fe02Onjd/pnFVoCgn+tzCFzMt4XpJIjAYPfZUGvUYOzvAyLQo2Snr0bYrDlPuq6qKGtvDqWHZQEhelP7c82NbXivSa6IzHEt6nRqxsnbFjYIeGRaTN7B5BZK1/qEAg6yRqVI=
Received: from MW4PR03CA0304.namprd03.prod.outlook.com (2603:10b6:303:dd::9)
 by DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 18:22:29 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::66) by MW4PR03CA0304.outlook.office365.com
 (2603:10b6:303:dd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.26 via Frontend Transport; Mon,
 19 May 2025 18:22:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 18:22:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 13:22:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 6/8] drm/amdgpu: rework gfx10 queue reset
Date: Mon, 19 May 2025 14:22:07 -0400
Message-ID: <20250519182209.18273-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519182209.18273-1-alexander.deucher@amd.com>
References: <20250519182209.18273-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|DM4PR12MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae7fc6e-3a2c-45ed-dda7-08dd97021d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejZiUnQrZDExWDdIcDc2enhCN0pFRkhIQnhzUmlBWi9QMUdKNTR1M3ZYeElv?=
 =?utf-8?B?bUE3UWJxV3hNczdPMTIvblFIWnlSWmt5K2QzU2lxcXRQWW1Sd2xXejRQSlBE?=
 =?utf-8?B?bllYR2hHcDhsNDJ4SHlEbWNqWFdnSHAydEw0L2RpZjVtNHVSTk9QRGRRKzVh?=
 =?utf-8?B?VjN3c0Z6VlZqZVlTZi9jLzlnT3ZkbUtKY1NoNHZXNUIrNkwwbU5QbTRxTm9v?=
 =?utf-8?B?R3hXTG1wQk1mTnR4dUUyaExMZlkxWlVkMUc1TTZqRGxlZHlhb1p3bzl4K0NM?=
 =?utf-8?B?OUNvRlNGakVpc1lKaVB4YTl3WmxuK2dCSlM3L2RBVklvQXY3TjM4NE13WjRL?=
 =?utf-8?B?RCszMEtCTEVVWGN6b2ZsMEdKTk4yM0QxWVVPTkRTWnFSVVZRaitLOS9aUno0?=
 =?utf-8?B?RVR1L3pFRDZCSGpiTUNxMDIwR3dzOWRVbXdXL203N254b204WU9UVzdKMi9G?=
 =?utf-8?B?aEdtRHZGVEkzd2dySFVOb2xoZUQ3WnVNT2NQRWVsVk1XYURubFFvcVJFK0Fn?=
 =?utf-8?B?UVBZMEN5RkdEb0JZUGUvbG1NSTVqcDJkM1hta1EzT2ErelhOQ1hSNUk1L3I2?=
 =?utf-8?B?R3lzVzYzZ2tlbXphdkxid1FhRHZhQkJ5WG1UWVZaZjJuTEJIWnB5c3RuVDNH?=
 =?utf-8?B?QU9mUnVXU2FmK0ZhSk9tSHNZdXRYUnhaQk9ORDhldUdXM0htQWZDWVZLek1s?=
 =?utf-8?B?V1NXZ0VvYXp2QlYwbzJwa0E0SVowWE9FejJaN2VManZ6NXh0WEpIWk9ic3Z5?=
 =?utf-8?B?bFRYSytsYUczV2NyZHB2QTJKcGtEUFpTdWhISkROVWt4TW03dHNrY3ZwUkNo?=
 =?utf-8?B?S3kxS2tkN0prUnhScGVFN0pPUzZ0a2FYZ1o0Ykk1dDVTbmUwZm5PVkFPYjdL?=
 =?utf-8?B?YWtmb0ZtMldkUWlKY0JIN1Y0ZjFrd2dzbFByNVVUZ1psd3ZybDMzd3JEN2NT?=
 =?utf-8?B?SnYwSlI1MzZpdU51dFp6djNlMjdsdjVQVTRKQ2xlV2dqbWtZdjlpVHRCTG5v?=
 =?utf-8?B?VVZJQkpSenBQT0VuTzVCU0JodGJEMEdRcjJoSDRkYncySHpUUVRvZnIzbURm?=
 =?utf-8?B?ZEtjeDRQemo2YzY1bTIxeVFSaWNlRWIrS3N2eG1TaVJBZmFXTURTRkZFSXlD?=
 =?utf-8?B?K2xxQzFWbW43Z0VRa09oQWVwa1J0b1F0bW5aZDN2bHQ4c0hGVUV6RUx6VWVj?=
 =?utf-8?B?YkpOaGVkNGxHaW85NmFjazlQYjZLSnhZY2x3RTJkVVlBM0pXWnVhRFo1cU56?=
 =?utf-8?B?YllqT1NmdGhlSUMwNHZGVS9mNW8xL1FpOHRiUFB4Z3BINmVmRjJkRUJGc0Vs?=
 =?utf-8?B?Ny9pN2FremNHUVZGWlNlaldkelB3R1VvRWxySkExT3BBOXQwR3NBMGx4UHBL?=
 =?utf-8?B?TE9YQjY1cEVoOWxabXAwSjJmS1dDOGZsc2V1ZTY2MXNtN1EvcDRDVkQyTjZi?=
 =?utf-8?B?TXNycy9XdnRXVk1WWE5CSk81Vi9LY2RyaDJqdVE1RlN3TVgvandvdHFrRHkz?=
 =?utf-8?B?UVFQMFY0TVhnRGVUMnFFQkxXSUp4Nit5SitDVFBvSm5DaHdkckZNTCtNRU1k?=
 =?utf-8?B?aXlFNkQxNVNQZWh5dGJYTzNqdSt1aXVHak45eHJLUU1US05UTGIrWEFTeVhw?=
 =?utf-8?B?dzJWdTNyaEY2YmVPMmZDbGRNZlFIUmRZcm8xSWU4QzJBcDJTUXN4V0RIY1Vs?=
 =?utf-8?B?cHNWQ0xFOWJMSTlVQ1NlSlJYREZTUWc2TFBGMUZ4bkpNKzFwYUk2WE5iczlD?=
 =?utf-8?B?TmhkekNHckdMUHl0N3ZrYzFRQ0wxYjl0QUZGSDNvZ0JEUlA0eG9WdUs2NUln?=
 =?utf-8?B?RlZ1MVIxbXVMRzBpc0FlWTFsVnBsbWtrem1Xa2pXMUdMTEo1TE5IekhqOGxa?=
 =?utf-8?B?V2RMNXZSakVwYTZFTDMwZGhRZ2JDWWR2TGpuTnFMaERrb29TN1gweHQ1eEVl?=
 =?utf-8?B?d2ZFa1NnVnVIRWRUaHFQTFA5NlAxR1pNdjAxU2pKOUJZT1FVY2ZuTzhmVkFY?=
 =?utf-8?B?WWFQTWh3Q1owS0MzUXV2a3Y2c0ZWbXFRd2RGbk4valVtbnJjclJCWGp5b2gy?=
 =?utf-8?Q?EFBv4j?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 18:22:29.2812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae7fc6e-3a2c-45ed-dda7-08dd97021d54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5747
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

Apply the same changes to gfx10 as done to gfx9.

The general idea to reset the whole kernel queue and then asking the kiq
to map it again didn't worked at all. Background is that we don't use per
application kernel queues for gfx10 on Linux for performance reasons.

So instead use the gfx9 approach here as well and only reset all
submissions from a specific VMID instead of the whole queue.

Navi 10 seems to be stable, but Navi 2x still shows hangs during over
night testing. This needs more investigation, but the result is clearly
better than before.

v2: fix up pipeline_sync count, only emit vmid reset on gfx (Alex)

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 60 ++++++++------------------
 1 file changed, 19 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 14cbd1f08eb5c..52e12fb083d5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8746,6 +8746,19 @@ static void gfx_v10_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
 	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {
+		amdgpu_ring_emit_reg_wait(ring,
+					  SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET),
+					  0, 0xffff);
+		amdgpu_ring_emit_wreg(ring,
+				      SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET),
+				      0);
+		amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+				       ring->fence_drv.sync_seq,
+				       AMDGPU_FENCE_FLAG_EXEC);
+	}
 
 	gfx_v10_0_wait_reg_mem(ring, usepfp, 1, 0, lower_32_bits(addr),
 			       upper_32_bits(addr), seq, 0xffffffff, 4);
@@ -9046,21 +9059,6 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 							   ref, mask);
 }
 
-static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned int vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -9529,38 +9527,21 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
 	u32 tmp;
-	u64 addr;
 	int r;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
-		return -EINVAL;
-
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
-	if (amdgpu_ring_alloc(kiq_ring, 5 + 7 + 7 + kiq->pmf->map_queues_size)) {
+	if (amdgpu_ring_alloc(kiq_ring, 5)) {
 		spin_unlock_irqrestore(&kiq->ring_lock, flags);
 		return -ENOMEM;
 	}
 
-	addr = amdgpu_bo_gpu_offset(ring->mqd_obj) +
-		offsetof(struct v10_gfx_mqd, cp_gfx_hqd_active);
 	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
-	if (ring->pipe == 0)
-		tmp = REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE0_QUEUES, 1 << ring->queue);
-	else
-		tmp = REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE1_QUEUES, 1 << ring->queue);
-
 	gfx_v10_0_ring_emit_wreg(kiq_ring,
 				 SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), tmp);
-	gfx_v10_0_wait_reg_mem(kiq_ring, 0, 1, 0,
-			       lower_32_bits(addr), upper_32_bits(addr),
-			       0, 1, 0x20);
-	gfx_v10_0_ring_emit_reg_wait(kiq_ring,
-				     SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffffffff);
-	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
 
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
@@ -9569,13 +9550,12 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	if (r)
 		return r;
 
-	r = gfx_v10_0_kgq_init_queue(ring, true);
-	if (r) {
-		DRM_ERROR("fail to init kgq\n");
-		return r;
-	}
+	if (amdgpu_ring_alloc(ring, 7 + 7 + 5 + 7))
+		return -ENOMEM;
+	gfx_v10_0_ring_emit_pipeline_sync(ring);
+	amdgpu_ring_commit(ring);
 
-	return amdgpu_ring_test_ring(ring);
+	return gfx_v10_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
@@ -9882,7 +9862,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
@@ -9923,7 +9902,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
-- 
2.49.0

