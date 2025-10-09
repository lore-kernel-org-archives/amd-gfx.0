Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD68CCA470
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 02:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 326FB10E1B0;
	Thu,  9 Oct 2025 02:48:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BFn59UEt";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7619010E1B0
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 02:48:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6wJ6hxZJ7KVEAkQ4qS6yDaYfg+Fk/EFu/GM1QJh7BBe/0igxhimeBU+pyANbhXHy7DKNLngoAMVIQptTWM4qcptzd7FWsawnx+dUWLA/U5PrdWsVg2S3ruFOU1Wa4l5OR5cc+F67Ggz3OxOwD8XmXf8UGM4TSIsxA8TXlHys+lc0sZY1Mi0uzDLbuwD/JdIbHXWoZeFxha64No2+BHLjrKqhN2HqsFBojG4MVlSkCy2cguy/R0+R6uNEraYfL/rtDw12+zo6gxx0T8p/JFrKl4SdO8OGrjF0Kbltke4ieyjomy6XeErKjejjibB4C6aBeLE9jfuhdnTuaPyw5Z5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sh5OfKWf1wvhL7ps44r1ZYGZuo78aBXCMWmyTjw+b8=;
 b=ALVsVz7VrwHnmJ/Y79zi3Dx2qE5bhLUhmfJ2LEs7W8iserM5M0tT3mTlBeTPc2sP1eOXu5HwiFUKOmNUNgiBV0jS+5DQAuJfrXAeHZyzJGuzGTEbzv5qiDgs18dBrXBqMryzfC/z7E62upHKD0C7fRDbLs1TuiEUhbSssmogi1sc0s12KcVjMmRHhVticB5AYk3PJrTUvL9BnYV+apqoB6i6GCeAZ74d21uxR3dTTP9+uEpshmdcSTnxz8tV7LGCG6V535gk3Wt1fiiukjch0VxQpAuebGvpv/sO+RZsFf7fldPkrXRMU08c7X9jfMxIFcwtz/IcZLMKKSUZfnRtoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sh5OfKWf1wvhL7ps44r1ZYGZuo78aBXCMWmyTjw+b8=;
 b=BFn59UEtWgNxCpT9xpIGALkaXTzh1un9id0d4CsqgTvpQBW/ve9uGdnkeL9YNE5y7DIWre0sifMZInLkQx/rJ5lF9nGWHBWAKz9VR3i6Gc5p9MU1gjGlvgC4s4/SHijgel6A9wf98yKW8Xw8lObyS6PiHW10KBo+cGtLBD8fyo0=
Received: from DM6PR02CA0141.namprd02.prod.outlook.com (2603:10b6:5:332::8) by
 LV9PR12MB9805.namprd12.prod.outlook.com (2603:10b6:408:2ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 02:48:46 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::cf) by DM6PR02CA0141.outlook.office365.com
 (2603:10b6:5:332::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Thu,
 9 Oct 2025 02:48:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 02:48:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 8 Oct
 2025 19:48:45 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Oct
 2025 21:48:44 -0500
Received: from victor-aws2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 8 Oct 2025 19:48:43 -0700
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <HaiJun.Chang@amd.com>, Victor Zhao <Victor.Zhao@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: use GPU_HDP_FLUSH for sriov
Date: Thu, 9 Oct 2025 10:48:22 +0800
Message-ID: <20251009024822.3973163-2-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251009024822.3973163-1-Victor.Zhao@amd.com>
References: <20251009024822.3973163-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Victor.Zhao@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|LV9PR12MB9805:EE_
X-MS-Office365-Filtering-Correlation-Id: 396d8c5b-8716-4bd5-8c51-08de06de5db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ITedeh2hfAJOdDo+NttUTBkay9XQtQhzaJeimODMuap7ywI6jkzkm3z5KHsF?=
 =?us-ascii?Q?y6E1w/YLm8PJROpfaGp1hnXtmrWMTwWg8+KUIkkfPB3+mz5I/cKkqF5syGoQ?=
 =?us-ascii?Q?VLr8RmNLvxyDfnyrA3uFYlMAajE9NpEhIpMTwUvjWJw05yTx1wB35CpxnffO?=
 =?us-ascii?Q?VqkFztx72fY2GWVlDkNwe3xPS9htbApLYByNIKlwB1JlY6DzDJxQw6Mw1aUM?=
 =?us-ascii?Q?nwsYLeAqZJ5QNZP/NluYo47oSJ5uI3xwCr1KL0cCEtV8P1JViumbl3Gop1ND?=
 =?us-ascii?Q?8Y0/n7kdzLcK898I24whJ82I9Yi2w5vDZxFVp9mFMRgi6qVFltx3Mlv86Ins?=
 =?us-ascii?Q?uS9DvmWY2+hGPhCaVbuzPlyGgk4IqkSXlpSefKZuvGuKpIpvstJFThXyTIFV?=
 =?us-ascii?Q?5J7OXELZF4YjWDPUDWbM+iqhUu8pbXcVMB7TJ2M/mAzpciWj8PfEM9iLNBjx?=
 =?us-ascii?Q?3yGp0QV4PVH0uann1gzC04f0bHcL9Jr5liwtNzm2rG+YdWwMGiK+Eovlv8dW?=
 =?us-ascii?Q?7bEU1RCgk2z7Un2ty424qvV+wX4AtkIKtaV7GdnHtBPqOpzG5tYD3Y2jDSdT?=
 =?us-ascii?Q?y9d3CZRm23uTu0kQd7yJLtQOElVWuN/m/UHIx9+L8x4RBepxljfrFpPIVtfa?=
 =?us-ascii?Q?9o3oKsDXQSc6Tt2O1CSmO/NhGtbno1rMi5UKgTaHAt6fbzPPCRnjeSckKyuv?=
 =?us-ascii?Q?Waz23iotI6iTF/x24inM/nJr7HFe+ozJpdcu7C+wiz6IZzaPfy7GY+vzmQW3?=
 =?us-ascii?Q?RpOZSMrZMTfKYXAKWZZ6qZ1vlvJEk3ARCrblZhAOGF1LIyqgqkrX4cem3qby?=
 =?us-ascii?Q?TE1njOAtzVYYJoSOYtPXlJ2faY19xtU4+84RPK2+FhvRaX3pKnXrB+trnMit?=
 =?us-ascii?Q?04H740xu/VTUDS5a+HayYbRkic9nht+UYEm0kBbjEDZ1jfwXRiO7bJyHL6qI?=
 =?us-ascii?Q?xNkBgxZ9GmfoeY/xLSX4shDS3J1bBlwOfRKfVPX7oXdl9b19ysa/IVQ/9ayR?=
 =?us-ascii?Q?BWKSIqhOCOZ3g8waCfzfV+v7jUae/T5ADOSXKtTKmPIW0b7oJnP/ubAJODme?=
 =?us-ascii?Q?+eg53FGiugSguW7hNkAEUpIsaLk9lwDOH/yNgJ+nOqnHmzTa7GbUajSQMm/B?=
 =?us-ascii?Q?/wr9PrU+mdfckfdYYQE8X5zywHlwl3esDV9AP1vqwiDyMwALij89w73E6gvD?=
 =?us-ascii?Q?AOkYCKFxDUJwhD77AYie8peX+4mzqsUkI7WKHC3DhD7WxRCtZna6lqkGHQcp?=
 =?us-ascii?Q?XKI1wxROEi0qwG72WxY0qgeUWnzVMZ7qJ2fX7DR6mQiGh9TG+FOuoPUgmj/f?=
 =?us-ascii?Q?c8tuwFzyYjDAfbrHkeIOCyxP+9dThkOjBPieQ/W7tyrYQYj+4tCY1t1tFD+M?=
 =?us-ascii?Q?A7dgFE5p3Jj2TQFR8bxCeK5tEu4J3O1fyaFwjlcFtvMh5UvNUZvz328Eac2e?=
 =?us-ascii?Q?DX5YY5wNjQbUjuRMgLuuz4Cjr48fLt5vmidHKompEzyRnlKiYAuelqXE7VLo?=
 =?us-ascii?Q?TR1clCIy1JBpQc8GmqDzzc8LQfPeTVYdIIBNN49sXI3FT+9fhOxCmiOMDMyK?=
 =?us-ascii?Q?MCC49edCFTD3VgB1/Tc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 02:48:45.6941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 396d8c5b-8716-4bd5-8c51-08de06de5db3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9805
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

Currently SRIOV runtime will use kiq to write HDP_MEM_FLUSH_CNTL for
hdp flush. This register need to be write from CPU for nbif to aware,
otherwise it will not work.

Implement amdgpu_kiq_hdp_flush and use kiq to do gpu hdp flush during
sriov runtime.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 73 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
 3 files changed, 76 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7a899fb4de29..eff43757f983 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -7281,6 +7281,8 @@ void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
 
 	if (ring && ring->funcs->emit_hdp_flush)
 		amdgpu_ring_emit_hdp_flush(ring);
+	else if (!ring && amdgpu_sriov_runtime(adev))
+		amdgpu_kiq_hdp_flush(adev, 0);
 	else
 		amdgpu_asic_flush_hdp(adev, ring);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 7f02e36ccc1e..ecd7908590de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1194,6 +1194,78 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 	dev_err(adev->dev, "failed to write reg:%x\n", reg);
 }
 
+void amdgpu_kiq_hdp_flush(struct amdgpu_device *adev, uint32_t xcc_id)
+{
+	signed long r, cnt = 0;
+	unsigned long flags;
+	uint32_t seq;
+	uint32_t hdp_flush_req_offset, hdp_flush_done_offset, ref_and_mask;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
+	struct amdgpu_ring *ring = &kiq->ring;
+
+	BUG_ON(!ring->funcs->emit_hdp_flush);
+
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
+	if (adev->enable_mes_kiq && adev->mes.ring[0].sched.ready) {
+		hdp_flush_req_offset = adev->nbio.funcs->get_hdp_flush_req_offset(adev);
+		hdp_flush_done_offset = adev->nbio.funcs->get_hdp_flush_done_offset(adev);
+		ref_and_mask = adev->nbio.hdp_flush_reg->ref_and_mask_cp0; /* Use CP0 for KIQ */
+
+		amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset, hdp_flush_done_offset,
+					      ref_and_mask, ref_and_mask);
+		return;
+	}
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+	r = amdgpu_ring_alloc(ring, 32);
+	if (r)
+		goto failed_unlock;
+
+	amdgpu_ring_emit_hdp_flush(ring);
+	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
+	if (r)
+		goto failed_undo;
+
+	amdgpu_ring_commit(ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+
+	/* don't wait anymore for gpu reset case because this way may
+	 * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
+	 * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
+	 * never return if we keep waiting in virt_kiq_rreg, which cause
+	 * gpu_recover() hang there.
+	 *
+	 * also don't wait anymore for IRQ context
+	 * */
+	if (r < 1 && (amdgpu_in_reset(adev) || in_interrupt()))
+		goto failed_kiq_hdp_flush;
+
+	might_sleep();
+	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
+		if (amdgpu_in_reset(adev))
+			goto failed_kiq_hdp_flush;
+
+		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+	}
+
+	if (cnt > MAX_KIQ_REG_TRY)
+		goto failed_kiq_hdp_flush;
+
+	return;
+
+failed_undo:
+	amdgpu_ring_undo(ring);
+failed_unlock:
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+failed_kiq_hdp_flush:
+	dev_err(adev->dev, "failed to flush HDP via KIQ\n");
+}
+
 int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
 {
 	if (amdgpu_num_kcq == -1) {
@@ -2484,3 +2556,4 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_compute_sched_mask_fops);
 #endif
 }
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index fb5f7a0ee029..5bccd2cc9518 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -615,6 +615,7 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 				  struct amdgpu_iv_entry *entry);
 uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_id);
 void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t xcc_id);
+void amdgpu_kiq_hdp_flush(struct amdgpu_device *adev, uint32_t xcc_id);
 int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
 void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t ucode_id);
 
-- 
2.25.1

