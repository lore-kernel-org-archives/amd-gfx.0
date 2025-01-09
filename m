Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD4BE77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 06:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 759FE10E2BD;
	Thu,  9 Jan 2025 06:28:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a33m16/v";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88E4410E2BD
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 06:28:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWXlwb0OvEcJfyFa7+vB55u58cCrvHDtlLDwefI8n9Gs3kExgQFNTAUW+GVZC69RZKvLCEgZ1t1gTOySjdyPPaV90caI2q0fQUavSRVgiJkjaJgz0h3WSi+J7Ssnb+uB4xcwbhk7HWPT8tG++RQDN5s26JexOQViPDUVOFWlN2YmULKHPTsd4orxUSIV5Br7GHLidWHeLoI5YDKUCGWL66LqsDklHqVn/rpeA5yy4FA22LTHcQc9ZeUqYXdLKLkFz/SnDdM7knRJ3Ys8/62Wsoim8P8Uco7JiJ9EZIOLRusQfe2sbLNjEJ9U2HgVfKZc2l1VUeF2GalO9TgeKnA5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+B2+be9G+YM9q1+qG/2sXJ4giDgsmzlEsF0OUq+9IQ=;
 b=dmOwTrdwnS2djqk+ARzsvHPzeqTke0UrG20QLM4gYD18MOgirqBlfrcm7ZL0jfBd9SDufpCLZc+2Z53Luf4T70yWhjmo1QGth2ftcnDRIdsxl2XzSl3yhnnLRc5+4tTIIbdPQLUCU8JvkUYinZr656CPzmcUeq1p8G9CqpBWnmOV0kSmV6YvDGApjoi5+x4gXxoiEH3M8qzUw6LiMwKzighyGkWXELP1oL4gKrZJK/n4g9icKk85dfS4+EbxrHM48emH1KnyG1YSBQheLareLTfk4YVS5yUljV7Ltv3nc1mpN++dif7/WiizHN/yfb5gkGJyUwLOTmmSktp6APkBgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+B2+be9G+YM9q1+qG/2sXJ4giDgsmzlEsF0OUq+9IQ=;
 b=a33m16/vAc9ZFF+23lEry3kRxPdLGjVSP8qYUnVu/cX9AIY0Az1RqPUsMC1r1jIDhmvy3qo9SF8flrMWGbpfmO6ega+8XLhK1+4GyPHXE8KH+6YEzkRwLaJZImmEwkd6JDFRGlZNDbu0jKPRK0BJyp78hoLBzrNPqMWuajm2yYg=
Received: from CH2PR14CA0052.namprd14.prod.outlook.com (2603:10b6:610:56::32)
 by SJ2PR12MB8110.namprd12.prod.outlook.com (2603:10b6:a03:4fc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 06:28:13 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::15) by CH2PR14CA0052.outlook.office365.com
 (2603:10b6:610:56::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 06:28:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 06:28:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 00:28:12 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 9 Jan 2025 00:28:10 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/gfx10: implement gfx queue reset via MMIO
Date: Thu, 9 Jan 2025 14:28:07 +0800
Message-ID: <20250109062807.3011684-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250109062807.3011684-1-jesse.zhang@amd.com>
References: <20250109062807.3011684-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|SJ2PR12MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: c233900b-f7bf-4cf5-0477-08dd3076cb40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FlxbpOnwPsHK+6mo+LMzc1UokOthsJCc/QwtGt8L/RMPZ0G5+0Llq3P7cmjo?=
 =?us-ascii?Q?/HRvMz8MXhCKtd0dQudY1tKLqERS9AKb2r6HhTWN3y1TYh3nq/FoeB+MT9Xi?=
 =?us-ascii?Q?IP3z648fPQ6RHKVRppEnRJ7HmZtJ5aO3RitZ7XbYJ1LosixMyRScla8xXaxz?=
 =?us-ascii?Q?WyTXIIeI++Mx0FIIpjQR/4r9/itAB+Ikal6IEtAlE9AWHJevyssJRvb0bW1J?=
 =?us-ascii?Q?UUq6pRjEHCkQ4T0LvlfbOkMcg+DuKjuJjZcc55eKFHVjtaKqR6DcnldExZ1F?=
 =?us-ascii?Q?2at7y9dN8UvcrlouAT2np5TS1cWdkRW794B5AiSKguj97Am5U0Z22fIXWKKZ?=
 =?us-ascii?Q?ut0plAL7KWDqtMWfYmMGfN1SzUvatjl4JgYvw2M8xqNbcbtHSNtVW0oZPjk4?=
 =?us-ascii?Q?m/3ZSuDGA+cIriURPre0yoy6EB2CftW1N34TbjgUpklrKcTDShyupwkIbNJH?=
 =?us-ascii?Q?7NjmVAGI1JCGmSwQsg+BgEij9V8P80yLJ6pVmQogUUMFp2rFqxcXpadepHtZ?=
 =?us-ascii?Q?O44UBKml6hV9ZjAde5e4gclP/pFGOvKX3PFp6/vokqVsEWNrKtIipW6TI/Sl?=
 =?us-ascii?Q?Qj25UpGOPYTsEuUWpJRX68mAxeBsXvLAGCm6O+MxuqwmOE2xlCdSIQMH9Tml?=
 =?us-ascii?Q?WqqPGo2LGUW0C5OFHnfRXbBmG7ML5NqcZQWkUtePvfLzyRoyAdxEOlSEqmVL?=
 =?us-ascii?Q?6460VJU2TFJlnMPbZjZa8Cfaf0Z9G/O2pKvJLd/6zu55lJnz/PfVAe+fti3W?=
 =?us-ascii?Q?ZIHhl2ktIQQym55HNL7e7+liY1qZul/PJYeKjqN31Atx8tDpP2RZ/CVnoPNB?=
 =?us-ascii?Q?9KVApCZeT9jAK2m4HjFxjZxqFLFVv7AvjGdzHQgNjtYi5PBYzKj5LvA2p7pf?=
 =?us-ascii?Q?psp5vrNDjLOPjsrNdODVk1cF1l7Iu0Me1GyhFKxBWNU0iYY91TcEcAruqpLI?=
 =?us-ascii?Q?pcd3s+qikafREh0cEUOv03+P+7Ht9rrcsNU1tThiGRQY+Dre5VOhHYYwYqAf?=
 =?us-ascii?Q?ld8MUAyzhVeLXpeUbd/b454pzk2ihk1wJgIP63Thd0gpd0ONlSbpqI6jfT2s?=
 =?us-ascii?Q?vIZQXJyCtsjLaAAcmjpm9FVKVBX4zu03FDqk+qwwg5Iq+ahUDzScc4rHrJZ5?=
 =?us-ascii?Q?+pJARDxLQ0PtpJWQPDKfNejuIH/ERFlRZD1hXGqsQ2ahtKn7eB5iFl4aqDrG?=
 =?us-ascii?Q?qETiaa+wmkjptEhlHTo0BGPQtP+2PuTgcz1I4t+LB/zxfkFyS7H94Wbg/GQt?=
 =?us-ascii?Q?+fmNGDUXM2vnAluA9b1bteNGsxoEWGy28+EHP/HFKAjy6XghP/Yo3TN8CktV?=
 =?us-ascii?Q?gIymkb4Ufol4jyuISbkHFhvCpxCGkWiegbGwPqeYSMNaxby8WkAoZeujH/Cc?=
 =?us-ascii?Q?qvMDQdWnSBiJjdM5XfISstnpZ1/I0/D4FJc6zcIrKX4sgrBo5Y6r4jQatjj/?=
 =?us-ascii?Q?vmS8krCoAaqTwLr5iTZWUKV6iRZ43i7sE8TLM/7AMNbCh8P4ltdyNAKCG+FS?=
 =?us-ascii?Q?jMH4euRfMmaFXDY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 06:28:12.9941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c233900b-f7bf-4cf5-0477-08dd3076cb40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8110
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

implement gfx10 kgq reset via mmio.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 98 ++++++++++++++++++--------
 1 file changed, 70 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 89409cb7d195..aac250c121d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9464,6 +9464,8 @@ static int gfx_v10_0_queue_reset(struct amdgpu_ring *ring, uint32_t vmid, bool u
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	uint32_t queue_type = ring->funcs->type;
 	unsigned long flags;
+	uint32_t tmp;
+	uint64_t addr;
 	int i, r = 0;
 
 	if (use_mmio) {
@@ -9498,6 +9500,40 @@ static int gfx_v10_0_queue_reset(struct amdgpu_ring *ring, uint32_t vmid, bool u
 			nv_grbm_select(adev, 0, 0, 0, 0);
 			mutex_unlock(&adev->srbm_mutex);
 			amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+		} else if (queue_type == AMDGPU_RING_TYPE_GFX) {
+			amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+			mutex_lock(&adev->srbm_mutex);
+			nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+
+			WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX,
+				     (uint32_t)(0x1 << GRBM_GFX_INDEX__SE_BROADCAST_WRITES__SHIFT));
+			tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
+			if (ring->pipe == 0)
+				tmp = REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE0_QUEUES, 1 << ring->queue);
+			else
+				tmp = REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE1_QUEUES, 1 << ring->queue);
+			WREG32_SOC15(GC, 0, mmCP_VMID_RESET, tmp);
+
+
+			nv_grbm_select(adev, 0, 0, 0, 0);
+			mutex_unlock(&adev->srbm_mutex);
+			amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+
+			mutex_lock(&adev->srbm_mutex);
+			nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+			/* wait till dequeue take effects */
+			for (i = 0; i < adev->usec_timeout; i++) {
+				if (!(RREG32_SOC15(GC, 0, mmCP_GFX_HQD_ACTIVE) & 1))
+					break;
+				udelay(1);
+			}
+			if (i >= adev->usec_timeout) {
+				dev_err(adev->dev, "failed to wait on gfx hqd deactivate\n");
+				r = -ETIMEDOUT;
+			}
+
+			nv_grbm_select(adev, 0, 0, 0, 0);
+			mutex_unlock(&adev->srbm_mutex);
 		}
 	} else {
 		if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
@@ -9537,6 +9573,28 @@ static int gfx_v10_0_queue_reset(struct amdgpu_ring *ring, uint32_t vmid, bool u
 				dev_err(adev->dev, "fail to wait on hqd deactivate\n");
 			}
 
+		} else if (queue_type == AMDGPU_RING_TYPE_GFX) {
+			if (amdgpu_ring_alloc(kiq_ring, 5 + 7 + 7)) {
+				spin_unlock_irqrestore(&kiq->ring_lock, flags);
+				return -ENOMEM;
+			}
+
+			addr = amdgpu_bo_gpu_offset(ring->mqd_obj) +
+				offsetof(struct v10_gfx_mqd, cp_gfx_hqd_active);
+			tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
+			if (ring->pipe == 0)
+				tmp = REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE0_QUEUES, 1 << ring->queue);
+			else
+				tmp = REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE1_QUEUES, 1 << ring->queue);
+
+			gfx_v10_0_ring_emit_wreg(kiq_ring,
+						 SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), tmp);
+			gfx_v10_0_wait_reg_mem(kiq_ring, 0, 1, 0,
+					       lower_32_bits(addr), upper_32_bits(addr),
+					       0, 1, 0x20);
+			gfx_v10_0_ring_emit_reg_wait(kiq_ring,
+						     SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffffffff);
+			amdgpu_ring_commit(kiq_ring);
 		}
 	}
 
@@ -9549,8 +9607,6 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
-	u32 tmp;
-	u64 addr;
 	int r;
 
 	if (amdgpu_sriov_vf(adev))
@@ -9560,35 +9616,21 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 		return -EINVAL;
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
+	gfx_v10_0_queue_reset(ring, vmid, false);
 
-	if (amdgpu_ring_alloc(kiq_ring, 5 + 7 + 7 + kiq->pmf->map_queues_size)) {
-		spin_unlock_irqrestore(&kiq->ring_lock, flags);
-		return -ENOMEM;
-	}
-
-	addr = amdgpu_bo_gpu_offset(ring->mqd_obj) +
-		offsetof(struct v10_gfx_mqd, cp_gfx_hqd_active);
-	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
-	if (ring->pipe == 0)
-		tmp = REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE0_QUEUES, 1 << ring->queue);
-	else
-		tmp = REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE1_QUEUES, 1 << ring->queue);
-
-	gfx_v10_0_ring_emit_wreg(kiq_ring,
-				 SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), tmp);
-	gfx_v10_0_wait_reg_mem(kiq_ring, 0, 1, 0,
-			       lower_32_bits(addr), upper_32_bits(addr),
-			       0, 1, 0x20);
-	gfx_v10_0_ring_emit_reg_wait(kiq_ring,
-				     SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffffffff);
-	kiq->pmf->kiq_map_queues(kiq_ring, ring);
-	amdgpu_ring_commit(kiq_ring);
+        r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size);
+        if (r) {
+                spin_unlock_irqrestore(&kiq->ring_lock, flags);
+                return r;
+        }
 
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+        kiq->pmf->kiq_map_queues(kiq_ring, ring);
+        amdgpu_ring_commit(kiq_ring);
+        spin_unlock_irqrestore(&kiq->ring_lock, flags);
 
-	r = amdgpu_ring_test_ring(kiq_ring);
-	if (r)
-		return r;
+        r = amdgpu_ring_test_ring(kiq_ring);
+        if (r)
+                return r;
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
 	if (unlikely(r != 0)) {
-- 
2.25.1

