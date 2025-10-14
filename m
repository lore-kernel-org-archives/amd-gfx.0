Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BFACCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 09:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1F8E10E11D;
	Tue, 14 Oct 2025 09:37:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iMLeH/e3";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A9CA10E11D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 09:37:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRMQfEE/ZcynDxHVbdI5WKRqWO1rWpuRC5XYZoZlxncewZTzYKeqtDKX82sGJeeVwJpXvKLyeE4F3pURQoOp4xA/PviU6i1ajsy9SxHPmN3ua3Z6CArZo8vw0NqU3f5jeyJM5MnbBIPh6UGyHrXXfjPH1zkRmb5Y/0hx3Qez5T/kFN9PVaD5kQWTuE/WQDQIUnlz63wGqadkioWiCibRtbDFK/Z7KfDYgR3qMXSEHkJ+iiZYJ0s1Bj1k0q/4p1HiDcAf726utJVrYTJwnmIQU8cXOxfAZ0UqQ+i+xEHUMzcBjElyQfkWHl2wJVmSnY+BN7YDTd3xIz58bjxk+kCVMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0Nsjsfdcn/eiv0oxQeWp4F78wub+ttMRApI5naB74k=;
 b=FK37Z3w7stXd4eloTgKwfqJQEW7B0AMfTMIF9sX5CUUj+ABgQG5NZz3KgWd7tKIc9gpPQj4nX1hKgkBY01rc/H7syululA0mo09lmWQKARwCqB2Ii8SGrFAxsoUCkvKzq87f/z03raHbFKCG+5PiLAvCheOtjQLDW1ePYgtUpUBBLwCgdwEdxKaBPz4FSm5ANp1yfY6Mzc4bu0v4Wu56BqkkwKaW1QxU9RXXMNWoJC3YwiLTMpf77pX7QXsgIEZhpGGollFQOh/L9McVA8+48BXkSmKc/ON9qU99ujViJ05kbnmcSQyTxWi04C8G+OTNwYmQS/u4LtYxakcEoNb6bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0Nsjsfdcn/eiv0oxQeWp4F78wub+ttMRApI5naB74k=;
 b=iMLeH/e32ye31rU/u5Q++CBwcVoNSipGEsEowgZEsdpQftPPqsspvuHnph0EHgldxAaI2KA2ZUTa+u7icp6GvvjkQwmjWjnab6SgwEafpf1SIGbYWMd+LCPLbv9+Mud/KNEsdZzOZA5UH3DqMS6d7n/ihmphpNML0bX7/YWLQ6s=
Received: from SA9PR11CA0022.namprd11.prod.outlook.com (2603:10b6:806:6e::27)
 by LV9PR12MB9805.namprd12.prod.outlook.com (2603:10b6:408:2ee::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 09:37:22 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:6e:cafe::7e) by SA9PR11CA0022.outlook.office365.com
 (2603:10b6:806:6e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Tue,
 14 Oct 2025 09:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 09:37:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 14 Oct
 2025 02:37:21 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Oct
 2025 04:37:21 -0500
Received: from victor-aws2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Oct 2025 02:37:20 -0700
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <HaiJun.Chang@amd.com>, <lijo.lazar@amd.com>, Victor Zhao
 <Victor.Zhao@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: use GPU_HDP_FLUSH for sriov
Date: Tue, 14 Oct 2025 17:37:11 +0800
Message-ID: <20251014093711.434989-2-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014093711.434989-1-Victor.Zhao@amd.com>
References: <20251014093711.434989-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|LV9PR12MB9805:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac2c54c-e589-4249-6e8f-08de0b0546b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y4h6Fkg8xb9usy5hpVau+PIihwsxpeNN1/i70/Tt/6nBSQHTFJxGg5RLXmxl?=
 =?us-ascii?Q?kWBzDS3YicBU1+9WBeDuMVITl76+75QbBn2+kJkcEyrvJZmClcdvIUPvmxNC?=
 =?us-ascii?Q?TbQZvx/NYcfd+zmN3bI15fVi2F+xT4V71eXoXbUWNFtOHGaBb/yS8o3FqpV4?=
 =?us-ascii?Q?aDZrhYX9Y7HCfBnLWwFCDMCtE+/td0Y0OFHFpxAbWFl3qn1AuBLIhmo2SG9M?=
 =?us-ascii?Q?iIuoOYVWhujX1ePwKQC/z5uYlBWAWXqi7Q8btgSDB8FXJgY2A6mmLbJIMvZC?=
 =?us-ascii?Q?zJvEwu/8cAKVk1vDv6hdV1esLOHa6a2INWxMVd//4T8UgxVVhdbQQ1TkiRSG?=
 =?us-ascii?Q?Mh+dshv/O7FukBi23QCia2xaGDCF1mAsM16T5S4AIxPVdjJyRE7OcKaPk2n6?=
 =?us-ascii?Q?mMnDfg2mV5AN+ccWLx4yekH9RlDlDJSCIfW07KisBWfOP1wzeZoml8IkYkzE?=
 =?us-ascii?Q?y4aRG+DF/Y5jvW1sFAUGii2XRsnyaFJ/p+14KNuyGoHlrs5VuWgZlgMRHG4n?=
 =?us-ascii?Q?qnLxp429Z3uOSPrQZR8uBVwObZ6+eDNVlQYQa93tZkO4nhOra/q6PXu8E3Ag?=
 =?us-ascii?Q?qw13NVZcuVnfD01fTaBgrVC0JChogpk6mKHQgZEOoRd7LAYVoBvBoFIigMM5?=
 =?us-ascii?Q?n6TdEBP6WCfUUnp1Z7AxzQ7kSBfEo6uZE4GYlRv96QToWRiIGdzf4oFQaqUR?=
 =?us-ascii?Q?6EXbX5HKJRU5Srwr7zD8rU5xMCnmFITDkiq5btLanTTpFggYzaZBv92e7Ak5?=
 =?us-ascii?Q?jvnZMYX4UNKdehXxl1XZ6oy8FYZM1AY45EvdUSSFUedZlex6OSdrWofu8nbF?=
 =?us-ascii?Q?GSP3ICvE2kIRzTUQHagGN+qIHc2mHr5dMOLdoVKz28IzyDMTl5Wg/X/5FpR3?=
 =?us-ascii?Q?RoNzpgTLzAaoKU/D8NY6q0VacxjE7pLxLbnRhWUDOVM7VM14XehOZuPeu6Eo?=
 =?us-ascii?Q?MultwVtUwSKAwMEY17Fj9R77HG0FQXWETyC/Zz+Yfn0O4LuSsB2CroHYrsU3?=
 =?us-ascii?Q?0DpTiAweAb1N09CFSRNZ1z8DLtvm+8p+iAba++HvTDsw5mcqHbt0ZWkEASPA?=
 =?us-ascii?Q?cShgcxKIakuH2MzBVVQNkbMX3of/aHInTITyRPQnN58Ci7R4GDh6hfJ7L5f4?=
 =?us-ascii?Q?KS2JsBoRy+rHcQiOmT2iAV8Di4FRq5YH/Z4qbC0moxTaQdRukqxlcyqalrFS?=
 =?us-ascii?Q?cdhtMiX/LlC3dqorjHEBQXogF+Ze1fgCCN55d6GiSheHdQKKmpKUzrxgB0VI?=
 =?us-ascii?Q?ULELez2BreiJ7vlZo0JTwZfZU52ZrePWwiHyYe4nBlve4ank9k+PjOkBN4nj?=
 =?us-ascii?Q?mIM2i1mvzB/GqWEYX4FVJYjXDtHSjH1D4avtVzOoy4iXj1Pxe6Usj1VYuwyU?=
 =?us-ascii?Q?1O1vwLDoFoqZfx774Yaz0Ud1Bp2OUt/sd1VQZlPmM3VDoLyXt2Jmn+vFbUgZ?=
 =?us-ascii?Q?DVHSfamwf9ivOti0QnfPTctdnLqJp7x9MXnV4sPpSOQIeEMjMVNpSfC2GBfS?=
 =?us-ascii?Q?T3/taQcUBvkF0viB8xtdB1EtHadoVJA4Vti/mzemedOZzclbal+RR/jgu2kC?=
 =?us-ascii?Q?D0IOBQjOthk2dwdThPI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 09:37:22.1271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac2c54c-e589-4249-6e8f-08de0b0546b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
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

v2:
- fallback to amdgpu_asic_flush_hdp when amdgpu_kiq_hdp_flush failed
- add function amdgpu_mes_hdp_flush

v3:
- changed returned error

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 71 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 12 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  1 +
 5 files changed, 95 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7a899fb4de29..65cc6f776536 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -7279,10 +7279,17 @@ void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
 	if (adev->gmc.xgmi.connected_to_cpu)
 		return;
 
-	if (ring && ring->funcs->emit_hdp_flush)
+	if (ring && ring->funcs->emit_hdp_flush) {
 		amdgpu_ring_emit_hdp_flush(ring);
-	else
-		amdgpu_asic_flush_hdp(adev, ring);
+		return;
+	}
+
+	if (!ring && amdgpu_sriov_runtime(adev)) {
+		if (!amdgpu_kiq_hdp_flush(adev))
+			return;
+	}
+
+	amdgpu_asic_flush_hdp(adev, ring);
 }
 
 void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 7f02e36ccc1e..3d24f9cd750a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -33,6 +33,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_xgmi.h"
+#include "amdgpu_mes.h"
 #include "nvd.h"
 
 /* delay 0.1 second to enable gfx off feature */
@@ -1194,6 +1195,75 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 	dev_err(adev->dev, "failed to write reg:%x\n", reg);
 }
 
+int amdgpu_kiq_hdp_flush(struct amdgpu_device *adev)
+{
+	signed long r, cnt = 0;
+	unsigned long flags;
+	uint32_t seq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *ring = &kiq->ring;
+
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
+	if (adev->enable_mes_kiq && adev->mes.ring[0].sched.ready)
+		return amdgpu_mes_hdp_flush(adev);
+
+	if (!ring->funcs->emit_hdp_flush) {
+		return -EOPNOTSUPP;
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
+	if (cnt > MAX_KIQ_REG_TRY) {
+		dev_err(adev->dev, "failed to flush HDP via KIQ timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+
+failed_undo:
+	amdgpu_ring_undo(ring);
+failed_unlock:
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+failed_kiq_hdp_flush:
+	dev_err(adev->dev, "failed to flush HDP via KIQ\n");
+	return r < 0 ? r : -EIO;
+}
+
 int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
 {
 	if (amdgpu_num_kcq == -1) {
@@ -2484,3 +2554,4 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_compute_sched_mask_fops);
 #endif
 }
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index fb5f7a0ee029..efd61a1ccc66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -615,6 +615,7 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 				  struct amdgpu_iv_entry *entry);
 uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_id);
 void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t xcc_id);
+int amdgpu_kiq_hdp_flush(struct amdgpu_device *adev);
 int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
 void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t ucode_id);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 8d03e8c9cc6d..be62681b0c3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -523,6 +523,18 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 	return r;
 }
 
+int amdgpu_mes_hdp_flush(struct amdgpu_device *adev)
+{
+	uint32_t hdp_flush_req_offset, hdp_flush_done_offset, ref_and_mask;
+
+	hdp_flush_req_offset = adev->nbio.funcs->get_hdp_flush_req_offset(adev);
+	hdp_flush_done_offset = adev->nbio.funcs->get_hdp_flush_done_offset(adev);
+	ref_and_mask = adev->nbio.hdp_flush_reg->ref_and_mask_cp0;
+
+	return amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset, hdp_flush_done_offset,
+					     ref_and_mask, ref_and_mask);
+}
+
 int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 				uint64_t process_context_addr,
 				uint32_t spi_gdbg_per_vmid_cntl,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 6b506fc72f58..3a51ace2fa14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -427,6 +427,7 @@ int amdgpu_mes_wreg(struct amdgpu_device *adev,
 int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 				  uint32_t reg0, uint32_t reg1,
 				  uint32_t ref, uint32_t mask);
+int amdgpu_mes_hdp_flush(struct amdgpu_device *adev);
 int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 				uint64_t process_context_addr,
 				uint32_t spi_gdbg_per_vmid_cntl,
-- 
2.25.1

