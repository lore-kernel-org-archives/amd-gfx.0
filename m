Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F294FC282DE
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 20:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90E9010E33E;
	Wed,  5 Mar 2025 20:49:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iEj/6gVk";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8820110E33E
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 20:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3JyWc1FbwiG7PBk3CKF1jGG8X2Zv/d41mfKxbYW7BGflm7paa7Gn30BxCGsxghCkOMAGfJwuF4qNUOEztJpFzUpXplV3lHusLD8SOcVyYq7W8bdxk1UB7EcaHifTDtiJFMpi1/qe/4NCI4EhtooHFyQlH8jwRvJU5Tq6ocMgRVir+NlhMQwcv7uMciB3LAtrfK3s6OZXOrgJ1ipUT5G/u8xpftFYs6hp9ecZiTlGkW3sJy9q7Pu2gKqTBabXU91FixzCrNP4LpDgSGIumIBf2zL7J2Vh7cufXM80SBgHhzEb0Vv0gHzx4pai+ahLyqMnXFlwB/Ger9f2GOHhdEHHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6rQ+SPSLQj1Vb50dKdSoY0HzBNosQtlZWriA86GxDM=;
 b=f38gSabkQK8+M4S+ZAMFSgRb6uIMirDdl7gKr2fBhnES6vK3GNOdQ9qv527+jCgd8kDVnBvT51suO0GGs5W/huwjC14HxNO17XGhJKOxiNOD5DcEpaPiIeflwZsQK7k7erwNgYr4sarsG7XelZWGwqMlTnO+qQ4Fq8wi5yUHV2uZMyw1lv/ar+IgIk9Su/Ssyru6P1tGIZLUa1GT5N0je4FkqyHKoey0k5pGWx89uiO7rkxIV2divWWAS8BalRF6XywUABZ2zvClRLk/kPo5Q52eCAHdQ9ScQF2/yIuKL1sYEQtPtkS9CzfNZYf3152zNrNKZCz3VAKCgYntE/stgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6rQ+SPSLQj1Vb50dKdSoY0HzBNosQtlZWriA86GxDM=;
 b=iEj/6gVk9dfYSmFaqw8oy8wR4h+gM88Q19D+QnKtpg/2wPWLRaaDZJouMqJeBj/FK42aGbHpnVKUMT83fObrb3OWJbiJLm06cSmtlsgQmysjC2NhcfjiNylfgCmGlpHTGnpwpRWA9eb0rup6sVEzPL5GPqURxiU7LixCMCBxBmw=
Received: from BYAPR21CA0025.namprd21.prod.outlook.com (2603:10b6:a03:114::35)
 by BY1PR12MB8448.namprd12.prod.outlook.com (2603:10b6:a03:534::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Wed, 5 Mar
 2025 20:49:46 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::ad) by BYAPR21CA0025.outlook.office365.com
 (2603:10b6:a03:114::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.8 via Frontend Transport; Wed, 5
 Mar 2025 20:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 20:49:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 14:49:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/gfx12: don't read registers in mqd init
Date: Wed, 5 Mar 2025 15:49:29 -0500
Message-ID: <20250305204929.1214682-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305204929.1214682-1-alexander.deucher@amd.com>
References: <20250305204929.1214682-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|BY1PR12MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: 176241d9-2c27-4c03-0c98-08dd5c274382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CieNCAUNTeIiiifcHY4qse/6r4kAoXzTbep0f+QZ8VnDIuQdkLgYOXf/nZcF?=
 =?us-ascii?Q?pxnCbLuAC0vFTCHRRY4Cw7yOWZ8dNaeJvlVP7PunRAzN/SHwCDvzprm7gBlZ?=
 =?us-ascii?Q?O5gxsIVvIZlCgTw8xSDRscnuZAGzKBOQ3YWOyI28HyLW92lFbzGuDCwFlNAe?=
 =?us-ascii?Q?NU9XC2Fp74k1NNa0k9pfWTUXeKXocLtRc4TwEPJyRimSDCh0g3zm6egk5Cyt?=
 =?us-ascii?Q?PZrxA0xhxNaX8x1eWfYzsiWU5bKHEa3bN+hl+vcN9Rq3zERaitYFqMo2mlP8?=
 =?us-ascii?Q?Pd2YpYwdVZogGeCZvUFg+vMbhu+b+yE/hGWkG5snGivsSqbMwFqbTwgh4v7I?=
 =?us-ascii?Q?yu6P3knfZ4R/328j4w+k4sjAK0TDlp64HIQKbb6FGE1KVnKZIsPt71zSddjX?=
 =?us-ascii?Q?oRaUEeFdRFPq0FvnEpeXUae6LzSF1GLKnQVB/FPxKTSX/aqCfBB6CN3Pd4ML?=
 =?us-ascii?Q?3j3MMz8cKqGHSZdk/KqAGb2SASR402uWYF/6d7LTzRIv2N6s1WesA1vXVSiU?=
 =?us-ascii?Q?ZIhDKGtiuB4x0NiGNmM2NHAxGRfGKz3FvNc8Zj+J0paNm2VltbYOTC5/tj3U?=
 =?us-ascii?Q?3YX1gWLOzTD6bSrQ9b80WhEYIF+MMnMyDxb44hGHvHRDz6p+mmIsF36KS6rM?=
 =?us-ascii?Q?TmwATLM+kZI3WHHoZEc/JPLnUTaETB7xxWXxGZYu1eV5GAQlc2W3bem6iW6Z?=
 =?us-ascii?Q?3gmMcPzxiHsWc+EdkeSREaFm3J61brkQJXWm7cK+mg0tMJI5eRtaZ6NtBWnq?=
 =?us-ascii?Q?Udh0PLZJGZ7TyhKHlKBMUgyIyN+CVeLu1pThu+yNGUpbaT4fmfGgP+/f47Ag?=
 =?us-ascii?Q?0R1gkW91yTVH2PYAtYQwOTMeNTiK01xnifra9Sn64YD/Gm5JEKTocZfl5OsL?=
 =?us-ascii?Q?HyF9HqSaJ/TcKPb7vfpDxQ8hQKVHKiQlq5ql/BoXLt72As6nr9mfbFOn2KZc?=
 =?us-ascii?Q?zRhD0gPUzv5lG8bxuZewQuB5RA/iBwj109AjA1mlRDdSFRaQX4Kdxa+6vAuQ?=
 =?us-ascii?Q?EiofFmyMNQpMBjqTpn8JY1f+ZPqDQpbsPeksERz5zAOVucOU/G48fAsRGXpQ?=
 =?us-ascii?Q?1cTiDsiDaHdeysPhubuuyPCI7+nyrpTv4jSZXBfGPNhplDRxExzzxgo0Use0?=
 =?us-ascii?Q?9IAzFvHzCC1wuI54XX5V663GnoUrLgy/vtY5FUhLGF7njozgyRm8OdyOp7AZ?=
 =?us-ascii?Q?0pk/LWrwEVy0BfCYjlY9eLxhf6VhFN3X15sZxpQxsGtrObZjZ/Gmb9jLJBuO?=
 =?us-ascii?Q?p5yRe1EzFvn/oc/8Bxjd7mwFNyhbLkdhxcj0l4l8RyFaAwj6/V/MpU4l1w8l?=
 =?us-ascii?Q?UNsZ9F0KT61XgexGHhjGnN7GrrexdQg8u+CBBzHtVLpuPPCczXHxuX/jfTXc?=
 =?us-ascii?Q?WyjDgD4fCFv0HmHmrRK31ysn7aNkKDHPen+XfL3KWW3F2O2b2JDeh6XZbeKP?=
 =?us-ascii?Q?RASHTg7IIaZ5mNNaNCxmiKlm0cMpIYM33bxwCmsAUPf8W6dQ6QFSffuK7Wz0?=
 =?us-ascii?Q?au2uydqId16WpAE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:49:46.0680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 176241d9-2c27-4c03-0c98-08dd5c274382
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8448
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

Just use the default values.  There's not need to
get the value from hardware and it could cause problems
if we do that at runtime and gfxoff is active.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 48 ++++++++++++++++++--------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 8fde7b239fdbb..d729eb0ddb268 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -52,6 +52,24 @@
 
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
 
+#define regCP_GFX_MQD_CONTROL_DEFAULT                                             0x00000100
+#define regCP_GFX_HQD_VMID_DEFAULT                                                0x00000000
+#define regCP_GFX_HQD_QUEUE_PRIORITY_DEFAULT                                      0x00000000
+#define regCP_GFX_HQD_QUANTUM_DEFAULT                                             0x00000a01
+#define regCP_GFX_HQD_CNTL_DEFAULT                                                0x00f00000
+#define regCP_RB_DOORBELL_CONTROL_DEFAULT                                         0x00000000
+#define regCP_GFX_HQD_RPTR_DEFAULT                                                0x00000000
+
+#define regCP_HQD_EOP_CONTROL_DEFAULT                                             0x00000006
+#define regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT                                     0x00000000
+#define regCP_MQD_CONTROL_DEFAULT                                                 0x00000100
+#define regCP_HQD_PQ_CONTROL_DEFAULT                                              0x00308509
+#define regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT                                     0x00000000
+#define regCP_HQD_PQ_RPTR_DEFAULT                                                 0x00000000
+#define regCP_HQD_PERSISTENT_STATE_DEFAULT                                        0x0be05501
+#define regCP_HQD_IB_CONTROL_DEFAULT                                              0x00300000
+
+
 MODULE_FIRMWARE("amdgpu/gc_12_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_0_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_0_mec.bin");
@@ -2933,25 +2951,25 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_mqd_base_addr_hi = upper_32_bits(prop->mqd_gpu_addr);
 
 	/* set up mqd control */
-	tmp = RREG32_SOC15(GC, 0, regCP_GFX_MQD_CONTROL);
+	tmp = regCP_GFX_MQD_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, VMID, 0);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, PRIV_STATE, 1);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, CACHE_POLICY, 0);
 	mqd->cp_gfx_mqd_control = tmp;
 
 	/* set up gfx_hqd_vimd with 0x0 to indicate the ring buffer's vmid */
-	tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_VMID);
+	tmp = regCP_GFX_HQD_VMID_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_VMID, VMID, 0);
 	mqd->cp_gfx_hqd_vmid = 0;
 
 	/* set up default queue priority level
 	 * 0x0 = low priority, 0x1 = high priority */
-	tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUEUE_PRIORITY);
+	tmp = regCP_GFX_HQD_QUEUE_PRIORITY_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUEUE_PRIORITY, PRIORITY_LEVEL, 0);
 	mqd->cp_gfx_hqd_queue_priority = tmp;
 
 	/* set up time quantum */
-	tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUANTUM);
+	tmp = regCP_GFX_HQD_QUANTUM_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_EN, 1);
 	mqd->cp_gfx_hqd_quantum = tmp;
 
@@ -2973,7 +2991,7 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 
 	/* set up the gfx_hqd_control, similar as CP_RB0_CNTL */
 	rb_bufsz = order_base_2(prop->queue_size / 4) - 1;
-	tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_CNTL);
+	tmp = regCP_GFX_HQD_CNTL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
 #ifdef __BIG_ENDIAN
@@ -2982,7 +3000,7 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_gfx_hqd_cntl = tmp;
 
 	/* set up cp_doorbell_control */
-	tmp = RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL);
+	tmp = regCP_RB_DOORBELL_CONTROL_DEFAULT;
 	if (prop->use_doorbell) {
 		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
 				    DOORBELL_OFFSET, prop->doorbell_index);
@@ -2994,7 +3012,7 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_rb_doorbell_control = tmp;
 
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	mqd->cp_gfx_hqd_rptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_RPTR);
+	mqd->cp_gfx_hqd_rptr = regCP_GFX_HQD_RPTR_DEFAULT;
 
 	/* active the queue */
 	mqd->cp_gfx_hqd_active = 1;
@@ -3097,14 +3115,14 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_eop_base_addr_hi = upper_32_bits(eop_base_addr);
 
 	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_EOP_CONTROL);
+	tmp = regCP_HQD_EOP_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_EOP_CONTROL, EOP_SIZE,
 			(order_base_2(GFX12_MEC_HPD_SIZE / 4) - 1));
 
 	mqd->cp_hqd_eop_control = tmp;
 
 	/* enable doorbell? */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
+	tmp = regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT;
 
 	if (prop->use_doorbell) {
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
@@ -3133,7 +3151,7 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_mqd_base_addr_hi = upper_32_bits(prop->mqd_gpu_addr);
 
 	/* set MQD vmid to 0 */
-	tmp = RREG32_SOC15(GC, 0, regCP_MQD_CONTROL);
+	tmp = regCP_MQD_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
 	mqd->cp_mqd_control = tmp;
 
@@ -3143,7 +3161,7 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_pq_base_hi = upper_32_bits(hqd_gpu_addr);
 
 	/* set up the HQD, this is similar to CP_RB0_CNTL */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_PQ_CONTROL);
+	tmp = regCP_HQD_PQ_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
 			    (order_base_2(prop->queue_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
@@ -3168,7 +3186,7 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = 0;
 	/* enable the doorbell if requested */
 	if (prop->use_doorbell) {
-		tmp = RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
+		tmp = regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT;
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				DOORBELL_OFFSET, prop->doorbell_index);
 
@@ -3183,17 +3201,17 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_pq_doorbell_control = tmp;
 
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	mqd->cp_hqd_pq_rptr = RREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR);
+	mqd->cp_hqd_pq_rptr = regCP_HQD_PQ_RPTR_DEFAULT;
 
 	/* set the vmid for the queue */
 	mqd->cp_hqd_vmid = 0;
 
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_PERSISTENT_STATE);
+	tmp = regCP_HQD_PERSISTENT_STATE_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE, PRELOAD_SIZE, 0x55);
 	mqd->cp_hqd_persistent_state = tmp;
 
 	/* set MIN_IB_AVAIL_SIZE */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_IB_CONTROL);
+	tmp = regCP_HQD_IB_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
 	mqd->cp_hqd_ib_control = tmp;
 
-- 
2.48.1

