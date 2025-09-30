Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD32CCA470
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Sep 2025 11:35:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FCAB10E2AD;
	Tue, 30 Sep 2025 11:35:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g+26gkMD";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013060.outbound.protection.outlook.com
 [40.93.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFBFE10E2AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Sep 2025 11:35:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvMGf+KJg/Iup/15Yj0CIuEVM2smvkBRD6RP9VO1npHVJtzEJyn/Wj8wZsdGma21luXl0zIMOjdUm0C+FB2xBIOZJ5enpx8a1MLBjQZAwfIBSdx9icFCKXEbJx69EC6gS3bpeRLYoD/2b7rPae7KdN4aKHZ1S/tI/WkBxG6clcXTFdlboIKwEIhZAljh2qqTjI/NFyu1pNpvqddPIaqVBQhCQ4yovTFv80+D3wFLHhO4QUdhX/+LNAwJHZ7ywfA9gDWi5MclqvIJGrJM9FHeOoL1K535uRnGzCUIIXNrxKbeUr2fsJKxtWmJ4tin6h5yPCiS0yOGtv8s7+IDtuZRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U822fZQ96Sh4dLN3Sw1k4+7nihOI2UmQWzrJs6mjQAo=;
 b=ig3Tbhtqd+fcDVBBK8Hjr7nbPKStHZplPAtO3lk8OyHhQtfnPFcwkKBrJYE5v7zbZ/Df3Ncu3Kh0YeTQ/Xr30MM63WVzHvbCu1u0nixTfXFYbvZDxA6QIeCDD5PXVj8ErOGH2kAPaptGK34EsppB9cfjZR2H8fZufxYIcaLwSsJcCODRYHHnE9tijPE9LGDKiqC9xXzTXF2u6rnheqPZb0PhfiLg20fBBM0O0Swxuadhg3EXl3AVEwB3NbcKwWAqVNtEPRutvPC+Vpaq3qC2vKg4JO/tdjWEnf8tjyYsU81f7Xx116ALgodmcpZ/dwguFICpho2HeWvCbu1W6dm9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U822fZQ96Sh4dLN3Sw1k4+7nihOI2UmQWzrJs6mjQAo=;
 b=g+26gkMDDJX/D+7OxYjt1YdAoh/tsKGu8VTgXsbPQJdR2j7Ovr4Rgdx9NceniCfl5WIaiWsP3Q504Ert7gm0+/QmZ5T7rd1ugidS3MzHQrn+h6KFq8dS+Qhoi1f6t5j9IAI2oZVm3FQLqR5z2dmHpiQi382E49twYkg+Ck2hAe8=
Received: from PH1PEPF000132F8.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::29)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 11:35:25 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH1PEPF000132F8.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Tue,
 30 Sep 2025 11:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 11:35:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 04:35:22 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 04:35:22 -0700
Received: from victor-aws2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 30 Sep 2025 04:35:21 -0700
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <HaiJun.Chang@amd.com>, <Lijo.Lazar@amd.com>, Victor Zhao
 <Victor.Zhao@amd.com>
Subject: [PATCH v2] drm/amdgpu: use GPU_HDP_FLUSH for sriov
Date: Tue, 30 Sep 2025 19:35:17 +0800
Message-ID: <20250930113517.3803937-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|CH3PR12MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd85f4d-b1a7-4bc7-8096-08de001571ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gMPi3lKJz9sHhXL97uo285pnVCaLYrCWpaYCbnSew1ecLsUBtTm6HtyDIbpj?=
 =?us-ascii?Q?PBU/sSDOtm0KjAnAEys8uc95/CiDEozaKSHArCvUmbx4PsINNIqnmqhAwgs/?=
 =?us-ascii?Q?N0zAl/I+QLEU3xKwo+JfLg/Qdlf4pPpqkisTlhA1fyrRUySkJKlp0wm8ruc1?=
 =?us-ascii?Q?t5fvcUmbCRMHS2Bjuq8Ka7EJ3ZXth/5Aqx5OZsi+HsXO1WwZtBEgr07SbLAs?=
 =?us-ascii?Q?X2e5cUA7p91I3Uqiu4bJX3lWhD68rbxUagp5mGt5ylN3O3Vc/tmD6nXZ34/I?=
 =?us-ascii?Q?LUXCyHrYNEMJblalai3u/EAn3NYOjPFo6uKCkQ+UkYmGWdl9CknsHElINo6H?=
 =?us-ascii?Q?NVXOxcM/b11AApLaNkkKzEk/MmcUFdKALQTtRrKMTubgPeQIvM1RoH+x6+a6?=
 =?us-ascii?Q?GufJX57grgXJvZTLCu+mOdki9JkVwCBqnuUJaCylcn5/j72eduHbExNTUlWO?=
 =?us-ascii?Q?2hHHL/xbxkHU6VRJA7RN9drV80MqlQ5f5G9RAOD0kFHCjf/MtoLyyaGAMePB?=
 =?us-ascii?Q?9coe6dBZTbe7GJxdPXqZSjqjof/Ef4KwAJcmtP5eUO6ne9BRuIljMyCR6xKI?=
 =?us-ascii?Q?yKLqASudn8ePEYZ8v6BkvjzWP7Fz9ZbIFsRA/22WDbhFm45IkEYE6ErC7VmU?=
 =?us-ascii?Q?8v7/Q+eLZEPiMcLUZMhCafILW/lagX7ZwrTs0VI4FYzab3Ps4RbPXTriBci0?=
 =?us-ascii?Q?j4fAMJVowclC1g9EIJwXR2RhxqIcFBNzuIoh7R9WrIHPQ372EyD/XpISe9qo?=
 =?us-ascii?Q?f4CKvcFQdzOrsyzrNt0AAgnxBX4BuZOYS8DNvgWrg4REBijZ4hhRRWbaPvPi?=
 =?us-ascii?Q?81MgEZpmCyTG2PO73Ctw31XybyxDasXvmTLZSSOTRspSkPRsQ2jvhABotMVl?=
 =?us-ascii?Q?Ng8iRccMuzpoDGIJ00cqpbrwtxbygIsMZNoHH5z8PmDun4vcyVvwJfvKanAi?=
 =?us-ascii?Q?JFO63+3ekotIjOFvOB8twJouOQ6sjEBiA0yTTc4fsxDUq4zrIIgWbKctGHSa?=
 =?us-ascii?Q?hYNvNmXqLLerEIHAj8n3YannCDuBakK2p4wWXgKtGzW7WExbbpZJxpfP4Y1K?=
 =?us-ascii?Q?l0cSU9kuXZzwgYTiuZtNbZnZYzux8nklKJD7fSIOBBdzyXP7JStqfbaMnSuB?=
 =?us-ascii?Q?34lMdYVnjA1LaJ7Z+w4liKPzdgtId3fgRIaEhwMBo9KUWde8/mNCphngGWl4?=
 =?us-ascii?Q?GNN+WCmaqoE1pACoyaSKQPbeRZZho55zowCcMtnTU0au/wJHBhUR3vRaELU9?=
 =?us-ascii?Q?ZqvOujRqpNB9Nr/14ta1r/nkdM8GO7lWvqbdMo9C3hkmcP7VIRKxbfeC3SyQ?=
 =?us-ascii?Q?VPAJCffgzxWMqZxvUHGyWG0svdJCcEvgCC4iAuFcm4UHOjg+cBP70nc2lb6J?=
 =?us-ascii?Q?Kx7INTQLaKP5/hZZDjiTV9gdDY3HLjC6zLFwEDnrAPv3PsFVj5U8Yere+Qpj?=
 =?us-ascii?Q?DU1DNQZ4WZ1+1mheudpKi6H8B8Y9t0cNjvekVczdQZQhsM3g8qeLDooHFmhg?=
 =?us-ascii?Q?e0D2ygn7L5yXWNajcK5j8qqOPcLlQIlNVchDiJVea1Kkl+jHLBN1mWXTUX9B?=
 =?us-ascii?Q?s2JKYAbxryp9OKnw1eQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 11:35:23.7797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd85f4d-b1a7-4bc7-8096-08de001571ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548
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
Add kiq ring callback to emit GPU_HDP_FLUSH, in amdgpu_device_flush_hdp
if no ring provided.

v2: remove changes to flush_hdp callback

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 61 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  1 +
 9 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a77000c2e0bb..57d3ea33dec2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -7269,6 +7269,8 @@ void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
 
 	if (ring && ring->funcs->emit_hdp_flush)
 		amdgpu_ring_emit_hdp_flush(ring);
+	else if (!ring && amdgpu_sriov_runtime(adev))
+		amdgpu_kiq_hdp_flush(adev, 0);
 	else
 		amdgpu_asic_flush_hdp(adev, ring);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 7f02e36ccc1e..9cb13424ab8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1194,6 +1194,67 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 	dev_err(adev->dev, "failed to write reg:%x\n", reg);
 }
 
+void amdgpu_kiq_hdp_flush(struct amdgpu_device *adev, uint32_t xcc_id)
+{
+	signed long r, cnt = 0;
+	unsigned long flags;
+	uint32_t seq;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
+	struct amdgpu_ring *ring = &kiq->ring;
+
+	BUG_ON(!ring->funcs->emit_hdp_flush);
+
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
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
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8841d7213de4..751732f3e883 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9951,6 +9951,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v10_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v10_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 66c47c466532..10d2219866f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2438,7 +2438,7 @@ static int gfx_v11_0_rlc_load_microcode(struct amdgpu_device *adev)
 			if (version_minor == 3)
 				gfx_v11_0_load_rlcp_rlcv_microcode(adev);
 		}
-		
+
 		return 0;
 	}
 
@@ -3886,7 +3886,7 @@ static int gfx_v11_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 	}
 
 	memcpy(fw, fw_data, fw_size);
-	
+
 	amdgpu_bo_kunmap(adev->gfx.mec.mec_fw_obj);
 	amdgpu_bo_unreserve(adev->gfx.mec.mec_fw_obj);
 
@@ -7320,6 +7320,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v11_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v11_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 710ec9c34e43..e2bb8668150d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5597,6 +5597,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v12_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v12_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 0856ff65288c..d3d0a4b0380c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6939,6 +6939,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_kiq = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_rreg = gfx_v8_0_ring_emit_rreg,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
+	.emit_hdp_flush = gfx_v8_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v8_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index dd19a97436db..f1a2efc2a8d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7586,6 +7586,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v9_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 77f9d5b9a556..b1fa4036befb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4798,6 +4798,7 @@ static const struct amdgpu_ring_funcs gfx_v9_4_3_ring_funcs_kiq = {
 	.emit_wreg = gfx_v9_4_3_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_4_3_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_4_3_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v9_4_3_ring_emit_hdp_flush,
 };
 
 static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

