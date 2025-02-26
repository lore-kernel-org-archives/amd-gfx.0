Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D47C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 20:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 423EE10E24B;
	Wed, 26 Feb 2025 20:58:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="can2V8zf";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17B9410E24B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 20:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epQXughxCPIWJOPWZExrEsWq0ROcrUc/gTcaHn7vOJbGslXoOCFjwMztCFyn9nf9DMf+RUX+3Am6X74YnAIBhn/2tD/BPZMFjQUtndWs/YhsELlecOfKV12q/3Vci65I/wk/U85UVURkYfdXKcNIg+lqFD1zGAKwvM5YFMMtBJbBW4n7xWDYb8NVVs6Q2VbsolZ/gdiIl7QG7vhMneHgfWUY4wRhHJuKlxl/aSjVAYu+4P1SbacMh13UCIvXzKToBxk4MO5KjouWlNgZVWqZK88QlE2A/h8a5VZyCJnwr4ptybSYvZZWK2vipEihxzzVS502rz560MZuOtYFanT/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWNT4pYSgIjuzHF7yuG5aDhCFJFlnnywLmAH/YvX0iE=;
 b=odtUOiGIU2Qk6/u9AQ3ceOCGK1oZgAVPlPUfdv2iRnGyooVIF+C1K+dPSQy0PMBisXkweZJZTaYIG6jwRbtugxhSj4udU37JSVpkovRc/u7+SgxTKa/n0cGWEhdrxqGvP8vixPUccAew6Iy4Ar0BV1BE2VzUCnud3LthbkucTJ5kr/M3+KT9k0jlZWxDn/NvdYoJlkoNsp8DeOd4jcz3muMFREoUdedWTyM9H0q0XrNiIzVulBLu8CkhSQxBh838IGZu87HNibQoIsAXTuJBR2egQVfju/TwLC3lbdLfp7yUaGDCygmnqz8SNY56hUFaXLmt+IBFDEtDMf2ZpNcyKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWNT4pYSgIjuzHF7yuG5aDhCFJFlnnywLmAH/YvX0iE=;
 b=can2V8zfyeUq8tgRBi27FbmLI1nGutGTaXSZInHnVH+fUMyPeswnXfTv8Ojfvt5hH35oELaiQXrHBXanG1Npu+PihR6+2N/vCeM7p/ME89Qlrz2ZdyMUeyC7T3YgdL1MEltl/bwM3qiM98g1Q3y440R141S4FT5mDmIRxpP5SNY=
Received: from SJ0PR13CA0105.namprd13.prod.outlook.com (2603:10b6:a03:2c5::20)
 by IA0PR12MB7530.namprd12.prod.outlook.com (2603:10b6:208:440::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 20:57:58 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::e5) by SJ0PR13CA0105.outlook.office365.com
 (2603:10b6:a03:2c5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 20:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 20:57:57 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 14:57:56 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: implement per queue sdma reset for gfx 9.4+
Date: Wed, 26 Feb 2025 15:57:33 -0500
Message-ID: <20250226205734.3108512-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|IA0PR12MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dcc45b0-d34e-4361-031e-08dd56a83fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M67KFwYIlZDMWZGfb57h3/DjefZNwXW0++qxNKVvrhY6b1v8I69fxPjEjCXh?=
 =?us-ascii?Q?B7fxRN+Dg6qGfompwQzUXJBilFM9smZm8yNq9Er8i2RFvqs8SIbmy+yfqYe1?=
 =?us-ascii?Q?2nYspOfEXycay37NmoVkTQ6poP4Jtzm3x0rxnJqQwiez1VFNBgAmKPf7noK+?=
 =?us-ascii?Q?A8Tb+ob3VEgF/fcgVqzVUr0GXrk1K1+RORqUShUoZ0VhKw+5UHP4uFqkGjTU?=
 =?us-ascii?Q?pcrry5CoEZLSGQeLa7YKmQDJI85cqzw1nN4QWQAmoB7ldLKnqukqelbRkOOT?=
 =?us-ascii?Q?vRO/KkKpSgIMJaFODMBHcbucB7A87bhQY5mnHEQIzYISgiC+CJ/pe8jUVo8h?=
 =?us-ascii?Q?isMvsFXDGC14/DeVKkDjqDAlIvlXRJdUUKrdLr1OgqngbKrQDcWt8oXnrV5E?=
 =?us-ascii?Q?dauAsPUHXyi7Dnqf4VWCfSm44qz5Vr0AKJn8VM6AwVpRiZGa1NfaoXBMGcI1?=
 =?us-ascii?Q?othxhNg74ixW7p1NyA3tZDicGi1MLlrsqtmMPbTZQDbXJq8Fjejv0s2d2eaL?=
 =?us-ascii?Q?P62a4dmqD3pKCmbCIZst+WHRmxtzBNTYS2pYd30MzLaAyh7nW8Rif7p4qtWq?=
 =?us-ascii?Q?U/xoOzrIenxbgqg6ky7WlaOC1Vktg9X8jI6qIf9f9mxAMatxpP9mDQeSz3y8?=
 =?us-ascii?Q?fi+qXbnHjk7j9R2AEzpoN62KV8ygxBu8762dmguJBs1ZQjlQPXTYpTf17LDL?=
 =?us-ascii?Q?d5vSAdFrT0dW9ZyB9hvmsT5aqt4bGF/XZM+QHCnNWnHWVNGsms5R85t1UUjN?=
 =?us-ascii?Q?z6seoSCwzziWwstSGItcoPsHEcsTwT4wCsWcK0IUZo1udfcAoLNCwUwmQ4cg?=
 =?us-ascii?Q?TmMqeyr6KW/xRrCRuBTztupqj1GZBdKBHGbTMX6DO177qbuBiWxL6O8Xkhqi?=
 =?us-ascii?Q?23/xC+oO0Z56DccxG/2+lmMZ1suEdbzAqZWUzp6aGDjjLZ6wB8zXTa6m9uyO?=
 =?us-ascii?Q?omSkUzMZ6zD+WvvElCw4jtXEDPQtu5S78OBmNJRWrzLdbQ0g9iDXYMqamo4W?=
 =?us-ascii?Q?BZT3zd7pxCus0vQAElaMIsOa/JrP7z+fN4L/TxvbY/+rXoKFo7L/siF1Ltt0?=
 =?us-ascii?Q?HjQHYgUBRIYxVah5+YYLx5bz9WDvXjJuJglGfD4dUpNHbEZtYgZe6hsCB+2C?=
 =?us-ascii?Q?8moifpIkT51QvDL4e/r8+98wua5qurKu5nCMy20RfKiSggtCiQrVmlJZ8WN8?=
 =?us-ascii?Q?WoAKLzQL/xa3w36QBAMvMr8xhcy/NLPS7Ba3r6M3BxWZbO87/RfQTKKIEjKS?=
 =?us-ascii?Q?o1RxcWraPTr/2sPQJfkd95BjuiR09LLHIvfoID5x17Gy6sgndhiYHxx5XRzF?=
 =?us-ascii?Q?cfKx05Nx14qzlMsIHAC6wDSmeRfup57LPxq8oKLbO0zeKD8+AHWM5m3nWg0z?=
 =?us-ascii?Q?zgv3123G00IiOc2N7Y/FYhC3eXZxFYCLks/pSlIfU0hxwDRPeRVUdNW9ZJXM?=
 =?us-ascii?Q?O1B6MS/zs4tGgWMVoMJrv8FW6urxQuj1JLPpi+bKO5pWx2nB7ZMEr7hb0AhV?=
 =?us-ascii?Q?CRZ7nmrgX0Z2rrY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 20:57:57.7582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcc45b0-d34e-4361-031e-08dd56a83fab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7530
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

To reset hung SDMA queues on GFX 9.4+ for the GFX9 family, a soft reset
must be issued through SMU.  Since soft resets will reset an entire SDMA
engine, use a common KGD call to do the reset as the KGD will handle
avoiding a reset of in flight GFX and paging queues on that engine.

In addition, create a common call for all reset types to simplify
the handling of module parameter settings that block gpu resets.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   1 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |   4 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  14 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |   9 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |   2 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |   3 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |   9 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c    |   7 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  16 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |   2 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 128 ++++++++++++++++--
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |   2 +
 12 files changed, 172 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index 8dfdb18197c4..6e861d08d044 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -193,4 +193,5 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
 	.hqd_reset = kgd_gfx_v9_hqd_reset,
+	.hqd_sdma_get_doorbell = kgd_gfx_v9_hqd_sdma_get_doorbell
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 9abf29b58ac7..c70d1b7c4c4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -389,6 +389,7 @@ static uint32_t kgd_arcturus_disable_debug_trap(struct amdgpu_device *adev,
 
 	return 0;
 }
+
 const struct kfd2kgd_calls arcturus_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -419,5 +420,6 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
-	.hqd_reset = kgd_gfx_v9_hqd_reset
+	.hqd_reset = kgd_gfx_v9_hqd_reset,
+	.hqd_sdma_get_doorbell = kgd_gfx_v9_hqd_sdma_get_doorbell
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index e2ae714a700f..0c0998477598 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -509,6 +509,17 @@ static uint32_t kgd_gfx_v9_4_3_clear_address_watch(struct amdgpu_device *adev,
 	return 0;
 }
 
+static uint32_t kgd_gfx_v9_4_3_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
+						     int engine, int queue)
+{
+	uint32_t reg_offset = get_sdma_rlc_reg_offset(adev, engine, queue);
+	uint32_t status = RREG32(regSDMA_RLC0_CONTEXT_STATUS + reg_offset);
+	uint32_t doorbell_off = RREG32(regSDMA_RLC0_DOORBELL_OFFSET + reg_offset);
+	bool is_active = !!REG_GET_FIELD(status, SDMA_RLC0_CONTEXT_STATUS, SELECTED);
+
+	return is_active ? doorbell_off >> 2 : 0;
+}
+
 const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_4_3_set_pasid_vmid_mapping,
@@ -543,5 +554,6 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 	.set_address_watch = kgd_gfx_v9_4_3_set_address_watch,
 	.clear_address_watch = kgd_gfx_v9_4_3_clear_address_watch,
 	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
-	.hqd_reset = kgd_gfx_v9_hqd_reset
+	.hqd_reset = kgd_gfx_v9_hqd_reset,
+	.hqd_sdma_get_doorbell = kgd_gfx_v9_4_3_hqd_sdma_get_doorbell
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 62176d607bef..2887b6f3eaa2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -1084,6 +1084,12 @@ uint64_t kgd_gfx_v10_hqd_reset(struct amdgpu_device *adev,
 	return 0;
 }
 
+uint32_t kgd_gfx_v10_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
+					   int engine, int queue)
+{
+	return 0;
+}
+
 const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.program_sh_mem_settings = kgd_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_set_pasid_vmid_mapping,
@@ -1112,5 +1118,6 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.build_grace_period_packet_info = kgd_gfx_v10_build_grace_period_packet_info,
 	.program_trap_handler_settings = program_trap_handler_settings,
 	.hqd_get_pq_addr = kgd_gfx_v10_hqd_get_pq_addr,
-	.hqd_reset = kgd_gfx_v10_hqd_reset
+	.hqd_reset = kgd_gfx_v10_hqd_reset,
+	.hqd_sdma_get_doorbell = kgd_gfx_v10_hqd_sdma_get_doorbell
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
index 9efd2dd4fdd7..db577c2a847a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
@@ -65,3 +65,5 @@ uint64_t kgd_gfx_v10_hqd_reset(struct amdgpu_device *adev,
 			      uint32_t queue_id,
 			      uint32_t inst,
 			      unsigned int utimeout);
+uint32_t kgd_gfx_v10_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
+					   int engine, int queue);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index c718bedda0ca..ac9ad505f9d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -682,5 +682,6 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
 	.set_address_watch = kgd_gfx_v10_set_address_watch,
 	.clear_address_watch = kgd_gfx_v10_clear_address_watch,
 	.hqd_get_pq_addr = kgd_gfx_v10_hqd_get_pq_addr,
-	.hqd_reset = kgd_gfx_v10_hqd_reset
+	.hqd_reset = kgd_gfx_v10_hqd_reset,
+	.hqd_sdma_get_doorbell = kgd_gfx_v10_hqd_sdma_get_doorbell
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index a4ba49cb22db..e0e6a6a49d90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -800,6 +800,12 @@ static uint64_t kgd_gfx_v11_hqd_reset(struct amdgpu_device *adev,
 	return 0;
 }
 
+static uint32_t kgd_gfx_v11_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
+						  int engine, int queue)
+{
+	return 0;
+}
+
 const struct kfd2kgd_calls gfx_v11_kfd2kgd = {
 	.program_sh_mem_settings = program_sh_mem_settings_v11,
 	.set_pasid_vmid_mapping = set_pasid_vmid_mapping_v11,
@@ -824,5 +830,6 @@ const struct kfd2kgd_calls gfx_v11_kfd2kgd = {
 	.set_address_watch = kgd_gfx_v11_set_address_watch,
 	.clear_address_watch = kgd_gfx_v11_clear_address_watch,
 	.hqd_get_pq_addr = kgd_gfx_v11_hqd_get_pq_addr,
-	.hqd_reset = kgd_gfx_v11_hqd_reset
+	.hqd_reset = kgd_gfx_v11_hqd_reset,
+	.hqd_sdma_get_doorbell = kgd_gfx_v11_hqd_sdma_get_doorbell
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
index 0dfe7093bd8a..6f0dc23c901b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
@@ -361,6 +361,12 @@ static uint32_t kgd_gfx_v12_clear_address_watch(struct amdgpu_device *adev,
 	return 0;
 }
 
+static uint32_t kgd_gfx_v12_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
+						 int engine, int queue)
+{
+	return 0;
+}
+
 const struct kfd2kgd_calls gfx_v12_kfd2kgd = {
 	.init_interrupts = init_interrupts_v12,
 	.hqd_dump = hqd_dump_v12,
@@ -374,4 +380,5 @@ const struct kfd2kgd_calls gfx_v12_kfd2kgd = {
 	.set_wave_launch_mode = kgd_gfx_v12_set_wave_launch_mode,
 	.set_address_watch = kgd_gfx_v12_set_address_watch,
 	.clear_address_watch = kgd_gfx_v12_clear_address_watch,
+	.hqd_sdma_get_doorbell = kgd_gfx_v12_hqd_sdma_get_doorbell
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 441568163e20..84135eb90660 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1131,9 +1131,6 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
 	uint32_t low, high;
 	uint64_t queue_addr = 0;
 
-	if (!amdgpu_gpu_recovery)
-		return 0;
-
 	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
 	amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
 
@@ -1182,9 +1179,6 @@ uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
 	uint32_t low, high, pipe_reset_data = 0;
 	uint64_t queue_addr = 0;
 
-	if (!amdgpu_gpu_recovery)
-		return 0;
-
 	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
 	amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
 
@@ -1229,6 +1223,13 @@ uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
 	return queue_addr;
 }
 
+uint32_t kgd_gfx_v9_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
+					  int engine, int queue)
+
+{
+	return 0;
+}
+
 const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -1258,5 +1259,6 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
-	.hqd_reset = kgd_gfx_v9_hqd_reset
+	.hqd_reset = kgd_gfx_v9_hqd_reset,
+	.hqd_sdma_get_doorbell = kgd_gfx_v9_hqd_sdma_get_doorbell
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index b6a91a552aa4..90c8fa13d519 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -111,3 +111,5 @@ uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
 			      uint32_t queue_id,
 			      uint32_t inst,
 			      unsigned int utimeout);
+uint32_t kgd_gfx_v9_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
+					  int engine, int queue);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 195085079eb2..e631f16033ec 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -36,6 +36,7 @@
 #include "kfd_kernel_queue.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_reset.h"
+#include "amdgpu_sdma.h"
 #include "mes_v11_api_def.h"
 #include "kfd_debug.h"
 
@@ -68,6 +69,8 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 				struct queue *q, const uint32_t *restore_sdma_id);
 static void kfd_process_hw_exception(struct work_struct *work);
 
+static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool is_sdma);
+
 static inline
 enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type)
 {
@@ -2222,8 +2225,7 @@ static struct queue *find_queue_by_address(struct device_queue_manager *dqm, uin
 	return NULL;
 }
 
-/* only for compute queue */
-static int reset_queues_on_hws_hang(struct device_queue_manager *dqm)
+static int reset_hung_queues(struct device_queue_manager *dqm)
 {
 	int r = 0, reset_count = 0, i;
 
@@ -2276,6 +2278,104 @@ static int reset_queues_on_hws_hang(struct device_queue_manager *dqm)
 	return r;
 }
 
+static bool sdma_has_hang(struct device_queue_manager *dqm)
+{
+	int engine_start = dqm->dev->node_id * get_num_all_sdma_engines(dqm);
+	int engine_end = engine_start + get_num_all_sdma_engines(dqm);
+	int num_queues_per_eng =  dqm->dev->kfd->device_info.num_sdma_queues_per_engine;
+	int i, j;
+
+	for (i = engine_start; i < engine_end; i++) {
+		for (j = 0; j < num_queues_per_eng; j++) {
+			if (!dqm->dev->kfd2kgd->hqd_sdma_get_doorbell(dqm->dev->adev, i, j))
+				continue;
+
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static bool set_sdma_queue_as_reset(struct device_queue_manager *dqm,
+				    uint32_t doorbell_off)
+{
+	struct device_process_node *cur;
+	struct qcm_process_device *qpd;
+	struct queue *q;
+
+	list_for_each_entry(cur, &dqm->queues, list) {
+		qpd = cur->qpd;
+		list_for_each_entry(q, &qpd->queues_list, list) {
+			if ((q->properties.type == KFD_QUEUE_TYPE_SDMA ||
+			     q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) &&
+			     q->properties.doorbell_off == doorbell_off) {
+				set_queue_as_reset(dqm, q, qpd);
+				return true;
+			}
+		}
+	}
+
+	return false;
+}
+
+static int reset_hung_queues_sdma(struct device_queue_manager *dqm)
+{
+	int engine_start = dqm->dev->node_id * get_num_all_sdma_engines(dqm);
+	int engine_end = engine_start + get_num_all_sdma_engines(dqm);
+	int num_queues_per_eng =  dqm->dev->kfd->device_info.num_sdma_queues_per_engine;
+	int r = 0, i, j;
+
+	if (dqm->is_hws_hang)
+		return -EIO;
+
+	/* Scan for hung HW queues and reset engine. */
+	dqm->detect_hang_count = 0;
+	for (i = engine_start; i < engine_end; i++) {
+		for (j = 0; j < num_queues_per_eng; j++) {
+			uint32_t doorbell_off =
+				dqm->dev->kfd2kgd->hqd_sdma_get_doorbell(dqm->dev->adev, i, j);
+
+			if (!doorbell_off)
+				continue;
+
+			/* Reset engine and check. */
+			if (amdgpu_sdma_reset_engine(dqm->dev->adev, i, false) ||
+			    dqm->dev->kfd2kgd->hqd_sdma_get_doorbell(dqm->dev->adev, i, j) ||
+			    !set_sdma_queue_as_reset(dqm, doorbell_off)) {
+				r = -ENOTRECOVERABLE;
+				goto reset_fail;
+			}
+
+			/* Should only expect on queue active per engine */
+			dqm->detect_hang_count++;
+			break;
+		}
+	}
+
+	/* Signal process reset */
+	if (dqm->detect_hang_count)
+		kfd_signal_reset_event(dqm->dev);
+	else
+		r = -ENOTRECOVERABLE;
+
+reset_fail:
+	dqm->detect_hang_count = 0;
+
+	return r;
+}
+
+static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool is_sdma)
+{
+	while (halt_if_hws_hang)
+		schedule();
+
+	if (!amdgpu_gpu_recovery)
+		return -ENOTRECOVERABLE;
+
+	return is_sdma ? reset_hung_queues_sdma(dqm) : reset_hung_queues(dqm);
+}
+
 /* dqm->lock mutex has to be locked before calling this function */
 static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 				enum kfd_unmap_queues_filter filter,
@@ -2326,16 +2426,13 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	 * check those fields
 	 */
 	mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
-	if (mqd_mgr->check_preemption_failed(mqd_mgr, dqm->packet_mgr.priv_queue->queue->mqd)) {
-		while (halt_if_hws_hang)
-			schedule();
-		if (reset_queues_on_hws_hang(dqm)) {
-			dqm->is_hws_hang = true;
-			kfd_hws_hang(dqm);
-			retval = -ETIME;
-			goto out;
-		}
-	}
+	if (mqd_mgr->check_preemption_failed(mqd_mgr, dqm->packet_mgr.priv_queue->queue->mqd) &&
+	    reset_queues_on_hws_hang(dqm, false))
+		goto reset_fail;
+
+	/* Check for SDMA hang and attempt SDMA reset */
+	if (sdma_has_hang(dqm) && reset_queues_on_hws_hang(dqm, true))
+		goto reset_fail;
 
 	/* We need to reset the grace period value for this device */
 	if (grace_period != USE_DEFAULT_GRACE_PERIOD) {
@@ -2346,10 +2443,15 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 
 	pm_release_ib(&dqm->packet_mgr);
 	dqm->active_runlist = false;
-
 out:
 	up_read(&dqm->dev->adev->reset_domain->sem);
 	return retval;
+
+reset_fail:
+	dqm->is_hws_hang = true;
+	kfd_hws_hang(dqm);
+	up_read(&dqm->dev->adev->reset_domain->sem);
+	return -ETIME;
 }
 
 /* only for compute queue */
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index e3e635a31b8a..1e8dfa6c0dc8 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -330,6 +330,8 @@ struct kfd2kgd_calls {
 	uint64_t (*hqd_reset)(struct amdgpu_device *adev,
 			      uint32_t pipe_id, uint32_t queue_id,
 			      uint32_t inst, unsigned int utimeout);
+	uint32_t (*hqd_sdma_get_doorbell)(struct amdgpu_device *adev,
+					  int engine, int queue);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.34.1

