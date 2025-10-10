Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602C3CCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 07:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04C8B10E3A3;
	Fri, 10 Oct 2025 07:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bCYTUM91";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D0210E324
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 07:33:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2CMMQTrt/rl2C4vb7rEw6Ew0dQTeXeinHm0qxo3OqGO9kK9dsufIf+oAXh/VUJy4wCCfiLSfz4+fgvUgt7kwSB9Xz6bx1s80a6CsDi3NhxCSQ2VzFwDatNvVNZ2TguE4qbthVDjF9o23RPzIyktafAM7lSSUNaCCOY5245UQDg3lswqiczDDN2MjEBiSy22EjaV/ffpHtRqlsbXlQ8viQo8iUsy+XJyE6j51D0ZhsWwNU6bP1E0pRG/zv39WZ1qRuN4mf9l25AHJO5uTkfeTTWUlkOEbQ10rjqwModnPVACZ+3XhGnXggAokce4Neb4YkJdZFNk1LzyFXzHUVJriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3lPQmpXhZAfFkpt7Pofh+UZL4dgiDgm2hH4e6bzJR0=;
 b=ipvhPK85jU9Nm4uYItq6Qns8bf0s/N80EHb8HQZKehYpZqTh0aexqctnlHUczFIxPsa6ZjoEx4sfG0Rh7Mka7kvgYY7DJTzwdpgLp8YoF2TtvY9OEyr6iJA08kEsYiuhAeDUWzM8MdTWX++2JMxRjCbMEasXfcbdlb2E7y4N3S0+bcbfXx9stMEZd6HxmPJJQtZfo2PjUASJtLnQqowXO/C9MRnvmmt0GUH1e3P5KRpxK4tOiN/V5IewxSO6/Kz002XyPsIOSVp1wd9CN/4G+2uuhNbe1efUu+N8ytWWzg17NEdMcH7Ed1Cu/FNZIjHQYLpOB+S+yfu2vkUfz2YKzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3lPQmpXhZAfFkpt7Pofh+UZL4dgiDgm2hH4e6bzJR0=;
 b=bCYTUM91OEze2vBZEudEP/wey+8fZYxkx9HoBwKF2X/pN7/OgtnhP19YA5cPQXnRyRbm8Q4ETO9lp+CWdeZrLyEkOGCU49GHxjaWZBIFagNZffI3wLs9tmMGPunND3QyO8FRePjVarekUKicxeT0OXJK2tRgjcEpNAdwyU7dKyg=
Received: from CH2PR12CA0022.namprd12.prod.outlook.com (2603:10b6:610:57::32)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 07:33:00 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::5e) by CH2PR12CA0022.outlook.office365.com
 (2603:10b6:610:57::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Fri,
 10 Oct 2025 07:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 07:33:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 10 Oct
 2025 00:32:59 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 10 Oct
 2025 02:32:59 -0500
Received: from victor-aws2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 10 Oct 2025 00:32:58 -0700
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <HaiJun.Chang@amd.com>, Victor Zhao <Victor.Zhao@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: use GPU_HDP_FLUSH for sriov
Date: Fri, 10 Oct 2025 15:32:46 +0800
Message-ID: <20251010073246.204178-2-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251010073246.204178-1-Victor.Zhao@amd.com>
References: <20251010073246.204178-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Victor.Zhao@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf0600c-2675-4e7b-d2c7-08de07cf3d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+ckz7C8O6xh/fXlEDJv1bCP/A0dLAc3kwSIv3DAgVsWS+SjXpoQ08FuJ0DNc?=
 =?us-ascii?Q?VnMcKYbZ8zBrLMGfi/XJu9fl7OztMbPlGuuN2u2HROM36Jt4qFfyQ874hCd3?=
 =?us-ascii?Q?DtKR1Cakj1YlpJ6fxrNRC63YbIPJIQimh6Puz+4pr8OismMUS6sXc4BuBRlb?=
 =?us-ascii?Q?iAZ5N8l9YiJkTZvgn6YOYRYRcLS1rZRdtyNZdlSrDZvkEZx9n0cKyq6YPLFx?=
 =?us-ascii?Q?FOK0/aoWIPEC5zhuBLoaNEaYbtHyHP6CeE9iop5vBTJKiucxZBp5U5+URe/v?=
 =?us-ascii?Q?S0AdaL5RbuT/wkyjmpHhCdmxdZjXmESYd5TxfANSX8W7d13JvRIhM8JRQPVe?=
 =?us-ascii?Q?RQXWhYX7Bht7lmffPPnQP/jR45FN9F5i6bGsSYxnsykE80kB2pm93ZNLgvFM?=
 =?us-ascii?Q?Il5aa+80Ic9Ysn1bAYGctaCafz1l1DUTayHKITYg9Glp3ztdQJnB/WXyTuzX?=
 =?us-ascii?Q?v+Ac74PuXqUEgWTH13b4I4V0D4cdnOI0st4Fm1Efbo1Hs1wB5rwFywLtSF2H?=
 =?us-ascii?Q?xBlLGVN7k85nzCD3+om/djK4WRZZnKeHDnUwqpJG6Bo/IE/YPP7SwEPWXxQi?=
 =?us-ascii?Q?YtqL+m2eL8meLt7AAUQDTv0okKNQKp+qGGbZUv550uEvudwwnH8PWEK1fjrS?=
 =?us-ascii?Q?1bJcMDXIZekW2oDpCO6+J1UgvtAnj5zLEMlmxa5C5ckEBpNCbf0UYOau0xBG?=
 =?us-ascii?Q?DUnXEn4VsjURVz+kFBQ84eJsSkJr/xrEefcQOm1Kd/st+vukJ6lKOUI5t8z2?=
 =?us-ascii?Q?KpyKzY5DctEYlWmacVo99FC26AeaIb4p13WuYyrpY0ZCWTkvvk60c+tqnrD8?=
 =?us-ascii?Q?/q4XbsqV75LbdYNtTIbCxJbKztvaIfExVXTQCo7CMi2f4ySZdkKSpTk7QBp+?=
 =?us-ascii?Q?yZotjzEdvDyF87NRQPXwlMFxuJBHZNog0kjK+VPeUCnizQLGJhvzPkwll+GY?=
 =?us-ascii?Q?u/iCDFue35VBBcWXe6axUMNkdKYZk6TyGqJVtZlqSJeO+VlPMY97H58fvnwN?=
 =?us-ascii?Q?WliB94MybmV6JhQshRllKx728+3SgzK4x7wLLgjAAMVs2oRZhRGUO+ZVRcLm?=
 =?us-ascii?Q?uM0cwYGeB7xLWQOEMVRKFMwQrVtop6adz71ymQzbExqaG2TWDds91ITG10nm?=
 =?us-ascii?Q?kL1FFEU+SLXlHPiq1Q+3jVXWD7bdwiPdQcQOeUuesJ03FFyx9Xb3f5uIzcc1?=
 =?us-ascii?Q?MdN2tQs7BNOSgXT/Abb6ie+NdlEJTAGymGA6WsEk1vjHwoxYKpeGg10ufRDN?=
 =?us-ascii?Q?MyEThuwI4fkKWIZEW3SNXDAZeiIXZf12Bl2hrDu4572SbSb+EFtZbKuEDFgM?=
 =?us-ascii?Q?zykp1qAysnmE6cbUFTD4zAAMZrlRgKn/88UPTN2gaNj7d03cnsS9OjC1T+Rk?=
 =?us-ascii?Q?1qUOBJFdxh/D2dfVVba9JkiJfHV8KF9fErrsShu56NT3kEpAMBbBRzIigRIM?=
 =?us-ascii?Q?oT1UENjGFVLAvZay2z03uMS/8YefXeC/cm20AtsgztI3iTRkG11F7D7G2sDa?=
 =?us-ascii?Q?hPiUY85276bsYySuePZmEoqvd4MHoWdJ2w5IfWrvNsiFjsiBZUJOxL/m+L7v?=
 =?us-ascii?Q?0bR994Y4sbrTzFm83Es=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 07:33:00.2167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf0600c-2675-4e7b-d2c7-08de07cf3d62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594
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
index 7f02e36ccc1e..bf28e8ef6c14 100644
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
+		return -ENODEV;
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

