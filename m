Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8979C19F32
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 04:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50ED910E300;
	Thu, 27 Feb 2025 04:00:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="20GDdozK";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 714DF10E300
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 04:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTU7vtXePuOaSnoR+uQXQPcozMu2NqivgbcGn1RlOePvZ6rT4aGWLPSG2FLPtBlb92Wleh+uEXutYaaa/3XtHJHrffgA2t48c5/OwAhpv4m2gsrEe2jNLi30Njd+z3smD8l1oUL6dXw2G1fFC57JLnxxb93ao3IlW8SaAjJUjAtDLEkyP7rHmNQtRyLI0JlY4U2shp4I1zkm3d3Z++vDJA8AbjtId0rlOKTHMM5NizLVYQ86mSAJubb2K0DI8pq/G6BSLBJQBGfBMUiKkVAoMVOrg/yURTG33j7sJ9Lh5cj76NNwdKaRpvT0UkwLEU7s/0IDeJcnMCH6gu4DYVzR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSgceA0qbVnZQSyah7pgSPKAbkMhW97aiM/t7JrvGlE=;
 b=bbPJ/hqTY5//XalgdziC3H1YqVIEUOyOFarSMAGjAmBCISCEJntgUDKgiMupd5ImxCexvwrqaKa5EZ21RvVwWZRvjtY89sJoQJJPD5AC4kvbSpcyAR95ukrR/kaEzCdUWAEPqopt7LZi5ufMmIVjOHl6tjiKUw07Qmxw3cfwJNVQadmt5oonHfSah+1a9pRS37lKXA3OnEikEfs++QWV8JQl8FG5uZf31KNLIt+urkloD917XlEem3nN5pBwOHOqi6V5kYOeub+5rJCx0G0rvU/boDZL9j/1BlnjMmRoEA8LeNMorjbINs0BDwapIRLcP4b/06729xelbRAoE0g07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSgceA0qbVnZQSyah7pgSPKAbkMhW97aiM/t7JrvGlE=;
 b=20GDdozKhtdiC3+wPTvOpfq39xhfBXEeOyfmAkRA5Nxak+1BCJWinv6Ezn4eHNDV3OOsCuGV/H0nOq8Q03I3Il7cKCnhzi+5pGIr8iXycATJN0deEa+0HqmT4fK0ipk7OwNmnKNPiRCmkVKkrsNpsyylL0tpK/88+biLYyqhTLs=
Received: from MW4PR03CA0005.namprd03.prod.outlook.com (2603:10b6:303:8f::10)
 by BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 04:00:49 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::32) by MW4PR03CA0005.outlook.office365.com
 (2603:10b6:303:8f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Thu,
 27 Feb 2025 04:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 04:00:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 22:00:47 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/gfx11: don't read registers in mqd init
Date: Wed, 26 Feb 2025 23:00:31 -0500
Message-ID: <20250227040033.234065-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|BL3PR12MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: e46d26cb-cb00-4417-4fd0-08dd56e3515a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bBWujIg86iFKCc/W3UEQ8nDbenDV2HsMKzcZNwSxzJdLb8PKd8gvb0jOUtS/?=
 =?us-ascii?Q?Nz34qpzIoqk0eDKaSDR3hvRQHnvuav7UPPM3XohK/ZB/XUn8nXb9eI0mqXa5?=
 =?us-ascii?Q?liT+704jdcS+JbMk3EL+n/+6LwX+DgQziW0ZiN6O8wKPaPyx16+bfJg5TkpD?=
 =?us-ascii?Q?Y3r0ZYCx80kDwdj4byZcqVXIMgkywouDoOwVj3oWx978tvrsP8krfhjTj7aA?=
 =?us-ascii?Q?to1Kzi0memlzlzXAv7oIVNlaVKFo+LCDqX9I71DnMKRfxTB+nx0bV8Y5VBu9?=
 =?us-ascii?Q?9GvnQwEEMKN71JouXAz3G3sxeuRFalMfWXGIQ6I7KwPQ8IVHNi+lqjpHqalx?=
 =?us-ascii?Q?hKvqJVpEcVTcq6xXBZa/tTvBfvl0N/VKkWeORAbxY3Ov77oJQOn+/z0PbwWl?=
 =?us-ascii?Q?F8ngUEQfjDr4Cjjg/LTJdcxZyGJ3il4Jd1//I57pF4v5ijFMwvJQSwk91rCE?=
 =?us-ascii?Q?s/xjItroOiydjJSqq7rHavmrsIfYz72Q4O41ORo6JKIOuXAgwXMdqPHW4eRA?=
 =?us-ascii?Q?3Ns/S8YqIRzWw/gLVux2iMl/dv0d/NyBR9E3D/UK4ara6Sg/bWMxSpwo2Sda?=
 =?us-ascii?Q?7hxSMOkNHPqt+KNNC0MtRzJjnQWWSMxjSksYKT3Z1BKa9Glmclr23PoV22WI?=
 =?us-ascii?Q?w+ns+GAr+4usR4dDq+BLs7ciDZdl0A40Tkx9NJcbCp2RXQe8yuvMuNuu0uVM?=
 =?us-ascii?Q?ibodx6jCWBuymfiWVffRoCZZ1q3xKCzNTgam4GJ0zvjZve2aIqFZpxKiAHpO?=
 =?us-ascii?Q?vauUCUo3JmWYjVi6B8jXGqWp+gTCeJn4S3jrm2njM01zjhzfODYEAuP+4/Y0?=
 =?us-ascii?Q?vPZmoUBjUXLG210B2x2GZjPzM59cIZVSEmv528jG+1qdkQsgPPcku6YcjNhS?=
 =?us-ascii?Q?bz9tdc1hXkI3LONSYvOpUJPq8rWw0iSBXg9fnxYMnz2Zx7F9kDF4CwcZLT4/?=
 =?us-ascii?Q?M/iES5XNZ8QP15i1uXQgviCAvnrFxf/8AlDHMG0HuydZAac9Wcf86Bc3WCfe?=
 =?us-ascii?Q?Fl9t/MMuNjHuYH3jzSf2TduPSCnPM+7jlwUL5jwdOKxWpyHTxBqRJoiqbQCn?=
 =?us-ascii?Q?dsw4FybSaMpCXcSCZuZzKDYFPlWXLk0ck+kKx9SpOWURTNCBovaiSnZZcB0G?=
 =?us-ascii?Q?BXrNJHk/ZjB7G6dTQ6oZzJZ7qG2539gn9Xqq0qswDwQ+GImMW6q5EiZ42qvH?=
 =?us-ascii?Q?axjVDQGPEIJbur3QsAbeWcD2DCELtJfxaYRrYDrRJxfNYWJ57lwArHtcaxHA?=
 =?us-ascii?Q?ZqH6fodalUMsytVuMYbWma1RpQ7yGdOQDh1YDw4JvF4d8z49kIyKv1H8gRYa?=
 =?us-ascii?Q?Z1AlwC/4I0iuXtDvLjomuP1ETf9vpHm7odgGl5ciCI/5+KJipcsw9Y80UgWC?=
 =?us-ascii?Q?YYT3PjraOjg6jwnx+6xZiMtQZ4CPR/eo6Wlr6nsq3o+5MGyX96iBR/6Dza3J?=
 =?us-ascii?Q?+eo4s6kLHBDFBKKYV1Vq2TjhcBHi5C7PVnVl7ms8g3Uhf5c5KKEJlcITJzwn?=
 =?us-ascii?Q?uNL8cAt7hbPE5AU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:00:47.7196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e46d26cb-cb00-4417-4fd0-08dd56e3515a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548
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
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 47 ++++++++++++++++++--------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 2c7f0bb242ffd..75becd7f218a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -64,6 +64,23 @@
 #define regPC_CONFIG_CNTL_1		0x194d
 #define regPC_CONFIG_CNTL_1_BASE_IDX	1
 
+#define regCP_GFX_MQD_CONTROL_DEFAULT                                             0x00000100
+#define regCP_GFX_HQD_VMID_DEFAULT                                                0x00000000
+#define regCP_GFX_HQD_QUEUE_PRIORITY_DEFAULT                                      0x00000000
+#define regCP_GFX_HQD_QUANTUM_DEFAULT                                             0x00000a01
+#define regCP_GFX_HQD_CNTL_DEFAULT                                                0x00a00000
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
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mec.bin");
@@ -3982,7 +3999,7 @@ static void gfx_v11_0_gfx_mqd_set_priority(struct amdgpu_device *adev,
 	if (prop->hqd_pipe_priority == AMDGPU_GFX_PIPE_PRIO_HIGH)
 		priority = 1;
 
-	tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUEUE_PRIORITY);
+	tmp = regCP_GFX_HQD_QUEUE_PRIORITY_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUEUE_PRIORITY, PRIORITY_LEVEL, priority);
 	mqd->cp_gfx_hqd_queue_priority = tmp;
 }
@@ -4004,14 +4021,14 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
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
 
@@ -4019,7 +4036,7 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	gfx_v11_0_gfx_mqd_set_priority(adev, mqd, prop);
 
 	/* set up time quantum */
-	tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUANTUM);
+	tmp = regCP_GFX_HQD_QUANTUM_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_EN, 1);
 	mqd->cp_gfx_hqd_quantum = tmp;
 
@@ -4041,7 +4058,7 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 
 	/* set up the gfx_hqd_control, similar as CP_RB0_CNTL */
 	rb_bufsz = order_base_2(prop->queue_size / 4) - 1;
-	tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_CNTL);
+	tmp = regCP_GFX_HQD_CNTL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
 #ifdef __BIG_ENDIAN
@@ -4050,7 +4067,7 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_gfx_hqd_cntl = tmp;
 
 	/* set up cp_doorbell_control */
-	tmp = RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL);
+	tmp = regCP_RB_DOORBELL_CONTROL_DEFAULT;
 	if (prop->use_doorbell) {
 		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
 				    DOORBELL_OFFSET, prop->doorbell_index);
@@ -4062,7 +4079,7 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_rb_doorbell_control = tmp;
 
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	mqd->cp_gfx_hqd_rptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_RPTR);
+	mqd->cp_gfx_hqd_rptr = regCP_GFX_HQD_RPTR_DEFAULT;
 
 	/* active the queue */
 	mqd->cp_gfx_hqd_active = 1;
@@ -4158,14 +4175,14 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_eop_base_addr_hi = upper_32_bits(eop_base_addr);
 
 	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_EOP_CONTROL);
+	tmp = regCP_HQD_EOP_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_EOP_CONTROL, EOP_SIZE,
 			(order_base_2(GFX11_MEC_HPD_SIZE / 4) - 1));
 
 	mqd->cp_hqd_eop_control = tmp;
 
 	/* enable doorbell? */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
+	tmp = regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT;
 
 	if (prop->use_doorbell) {
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
@@ -4194,7 +4211,7 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_mqd_base_addr_hi = upper_32_bits(prop->mqd_gpu_addr);
 
 	/* set MQD vmid to 0 */
-	tmp = RREG32_SOC15(GC, 0, regCP_MQD_CONTROL);
+	tmp = regCP_MQD_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
 	mqd->cp_mqd_control = tmp;
 
@@ -4204,7 +4221,7 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_pq_base_hi = upper_32_bits(hqd_gpu_addr);
 
 	/* set up the HQD, this is similar to CP_RB0_CNTL */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_PQ_CONTROL);
+	tmp = regCP_HQD_PQ_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
 			    (order_base_2(prop->queue_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
@@ -4230,7 +4247,7 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = 0;
 	/* enable the doorbell if requested */
 	if (prop->use_doorbell) {
-		tmp = RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
+		tmp = regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT;
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				DOORBELL_OFFSET, prop->doorbell_index);
 
@@ -4245,17 +4262,17 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
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

