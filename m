Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896EAE77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 06:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BA0810E35A;
	Thu,  9 Jan 2025 06:43:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qWnCKeYV";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC8B10E35A
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 06:43:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H16kyPRFQxJWBP/ck0gzIN/HfaMGgRg56gjbojAHRSz34cBTxHLL1xWvZXGURE0e4OEQYwxCrKktvlwaQcdpir8GrMxrfznpHDtnae3t4qSBnENNq3q9B5RMW0dyAUMcKl2SjhMmndWXzeQMB7I52HDgooCU58NP66MJYu2dCeGAv4rPuhWVcrJnAghkWPkBp8aCdE+C9X4uxniYVuMotNR3dayoH/YKddbGr/8+Qqiy5AjNagb5hw0H3WrTnY/EHvOrTntXp1GZMJNyrkQBQGqmCulc3waP/P28EcPYPSbe6fan/nY+b6QT/t0DqQXvz0WskD07ti3vbDHTD0vGhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBIx3cMBZGYUo9D0QUKR9C/zHcqZ9fLzf9Lzb+0U34w=;
 b=Pf5miMR5D7fbrKDYdBvrOY2y27BIALoT1k7hG7GJcE8ZfvoO18WsZmTEbzEa5MtbpHvm2+UGfEpIVl6i2QmRiCfUiQ5S5fOuryVKog8gpd6uAWfhbmdCmzYnAgyjYpzAq40WoCfEACbPNDqmZyYhFqw7rsqxlIeDPHjBbeCkOGhTMD3Bwff3vevcUM5sppT4GW9mcfEa3zOX4lTYYJ9ClFC/DMg8VSqzRsGXkPcsLIr3E9BVOdXn7c5ehnYi62oCErczWaFAKjc9K0vyzGhPv4zAjKpww7k9YlNhWhCaDoYDA0dZgeOKS8TphGfJ8hj82ALBxxSnWv7ogzEXKl6zwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBIx3cMBZGYUo9D0QUKR9C/zHcqZ9fLzf9Lzb+0U34w=;
 b=qWnCKeYVAK5vlxyWiiUmvMlJ0bNF2fHp6JDJ0QxvHQ3R8i57iIaSHJQMCEIm+9v32iWzYmJRYgqjhrqSer0+pjhpEtQnEsJT8mzUaQfSp9+okctPzysAKtjuX7hYq5LFXEMZ72pgzQ8hhZeYnpG+HkpCZPe3Z1OVPLAC37KczzE=
Received: from CH0PR03CA0437.namprd03.prod.outlook.com (2603:10b6:610:10e::17)
 by SA1PR12MB8857.namprd12.prod.outlook.com (2603:10b6:806:38d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 06:28:11 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::ec) by CH0PR03CA0437.outlook.office365.com
 (2603:10b6:610:10e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 06:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 06:28:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 00:28:10 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 00:28:09 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 9 Jan 2025 00:28:08 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/gfx10: implement queue reset via MMIO
Date: Thu, 9 Jan 2025 14:28:06 +0800
Message-ID: <20250109062807.3011684-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|SA1PR12MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b63847-6edf-4f2f-31d3-08dd3076c9e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VjMWKmKmsia8/yCZrt7lB/w1Nc5HTCq5vE8yZU/Js/432mLmg1/ngKQyCQgX?=
 =?us-ascii?Q?trzoO1R6/o9CpUP+xO9SDfmOSxFLvZ3hH+ySTn7aaysBliqaCEgULI/3pKyB?=
 =?us-ascii?Q?eRkbc8FYsEBptNvqXgyV4Z5k8LVpoBA09GJOBIt/UGkWRMJuQWbIuImdJvYv?=
 =?us-ascii?Q?Y3jHjlSR7RrigwvTr6rEGZqtJM4uFQ0/AklBx09HzEgrdoM4+ltodZ98HvlL?=
 =?us-ascii?Q?6ZyOFpF40DwhvaDYx80MTLWGtNPN1MF3/ToBktrS7wfkxwAz/mxEYMpRXev/?=
 =?us-ascii?Q?onRsXxMuwhkIBASvDJgZL6orvAq89cUK0+xZPgUHQLrrRABEyqnclxqFlk6q?=
 =?us-ascii?Q?WSOjmCpDGuXO2VRmOor4WVHNxA95UcRCKhl7mn6Bpr+dSrNSWncqTl9S/DIU?=
 =?us-ascii?Q?POGqRNpmu3Dc5dNhIl4lQq9dFeK22a5Tuzhe190a/MG0G6cCxjf24NyVKv7w?=
 =?us-ascii?Q?DUgOJ8wSOnLi/Lp5lv3lLMuMXoBuT0PmpRqcq9wO8cm7Nqs76bC8XJwVMsQY?=
 =?us-ascii?Q?tz5HQWTUk4DpRsGXJHG1ABKUufGFStlLiuhvOfEleQ9kdb+0A6chtgNcVc7L?=
 =?us-ascii?Q?0xZ/RxTUw2+qg6Aew8kK57iIBDepvFBvHJfpHmlh7DZcSm1T7doitcY4yM2/?=
 =?us-ascii?Q?aVgSlBXTI3gr/1mckGubOlrMPkYKczkjnrzjSE9Ulcg6YfW27c5aGCVXTuPy?=
 =?us-ascii?Q?VYWNL8Nkb/S39tOuKX25G8AyFHOk2b+e98ZudfARzey/ij+XQY4qNLHmjidJ?=
 =?us-ascii?Q?lm65ch+zd/VVVpgVTTtoFVoz1eZSAQ/UemDw6nWl7N8wIC8qowSE7gMOEwiv?=
 =?us-ascii?Q?b4N6pUmf8EIrp8366yuEpXaKM/7gU6XcoJeQNwPJIIb6ZpZyKc4JTHNSY7r6?=
 =?us-ascii?Q?GMSW3MXeaHnGTnsixNOdFqP5Foor032liwtYqg+oq16hS4353WeaKteE6Jjj?=
 =?us-ascii?Q?3LkTi4HDJ71gh7tlfeDCbiHOIo+GEMs2dYu7cmZRwIV4uuhPPMDtviasy+Do?=
 =?us-ascii?Q?1LyblnH1BBTpG2e8UhJluy6nLXvSvygVQl5FwrI7UtgfcLCKgnSA29+5I9uE?=
 =?us-ascii?Q?gF7/yNIh5UqsTZ2xmQu6VTFgM316x/+/NuNdkoah7hLqEjEfFEyj2tVrld51?=
 =?us-ascii?Q?tz79dgQt/UMT1MFOv21n0kepe0qOFaMn6RRWZjhoXbfaRsxweg92oCEBS8Yo?=
 =?us-ascii?Q?RckeiOexegJ5gRZhLj4mFE8AR90gfhLofkHLTVeOfM/KSRJP6Zcc9AJIwtqi?=
 =?us-ascii?Q?fJ9Ej/3n3qER9v263QsRf74+2ZGeLOsIzloSS9xzf4/E+b5kQf/2fPPOSXtT?=
 =?us-ascii?Q?yf/8F9FGoV4H/XkOJ7pX5uE4pa2FP8DMVwXrlOiD5Xxk6U6K5XUGRbfGV1JX?=
 =?us-ascii?Q?8TEumI42/Y7rFwEvYwAWeRD6/1JeFspcTAJ6QhTswuXEZyiJGbodgczdDGcV?=
 =?us-ascii?Q?JpcevSrwcHmBegc4v6NVw7GrFv9nvMqsP/07aKnDh5T2JjQhDJLtYPcxEiUW?=
 =?us-ascii?Q?Ag/TEI6p8OgrcBw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 06:28:10.7408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b63847-6edf-4f2f-31d3-08dd3076c9e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8857
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

implement gfx10 kcq reset via mmio.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 121 ++++++++++++++++++-------
 1 file changed, 88 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 88393c2c08e4..89409cb7d195 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9457,6 +9457,92 @@ static void gfx_v10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 	amdgpu_ring_insert_nop(ring, num_nop - 1);
 }
 
+static int gfx_v10_0_queue_reset(struct amdgpu_ring *ring, uint32_t vmid, bool use_mmio)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	uint32_t queue_type = ring->funcs->type;
+	unsigned long flags;
+	int i, r = 0;
+
+	if (use_mmio) {
+		if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+			amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+			mutex_lock(&adev->srbm_mutex);
+			nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+
+			WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 0x2);
+			WREG32_SOC15(GC, 0, mmSPI_COMPUTE_QUEUE_RESET, 0x1);
+
+			nv_grbm_select(adev, 0, 0, 0, 0);
+			mutex_unlock(&adev->srbm_mutex);
+			amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+
+			/* Make sure dequeue is complete */
+			amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+			mutex_lock(&adev->srbm_mutex);
+			nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+
+			for (i = 0; i < adev->usec_timeout; i++) {
+				if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1))
+					break;
+				udelay(1);
+			}
+
+			if (i >= adev->usec_timeout) {
+				r = -ETIMEDOUT;
+				dev_err(adev->dev, "fail to wait on hqd deactivate\n");
+			}
+
+			nv_grbm_select(adev, 0, 0, 0, 0);
+			mutex_unlock(&adev->srbm_mutex);
+			amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+		}
+	} else {
+		if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+			spin_lock_irqsave(&kiq->ring_lock, flags);
+
+			if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
+				spin_unlock_irqrestore(&kiq->ring_lock, flags);
+				return -ENOMEM;
+			}
+
+			kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES, 0, 0);
+
+			amdgpu_ring_commit(kiq_ring);
+			spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+			r = amdgpu_ring_test_ring(kiq_ring);
+			if (r)
+				return r;
+
+			/* Make sure dequeue is complete */
+			amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+			mutex_lock(&adev->srbm_mutex);
+			nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+
+			for (i = 0; i < adev->usec_timeout; i++) {
+				if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1))
+					break;
+				udelay(1);
+			}
+			if (i >= adev->usec_timeout)
+				r = -ETIMEDOUT;
+			nv_grbm_select(adev, 0, 0, 0, 0);
+			mutex_unlock(&adev->srbm_mutex);
+			amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+			if (i >= adev->usec_timeout) {
+				r = -ETIMEDOUT;
+				dev_err(adev->dev, "fail to wait on hqd deactivate\n");
+			}
+
+		}
+	}
+
+	return r;
+}
+
 static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -9531,7 +9617,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
-	int i, r;
+	int r;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
@@ -9539,41 +9625,10 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	spin_lock_irqsave(&kiq->ring_lock, flags);
-
-	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
-		spin_unlock_irqrestore(&kiq->ring_lock, flags);
-		return -ENOMEM;
-	}
-
-	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
-				   0, 0);
-	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
-	r = amdgpu_ring_test_ring(kiq_ring);
+	r = gfx_v10_0_queue_reset(ring, vmid, false);
 	if (r)
 		return r;
 
-	/* make sure dequeue is complete*/
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	mutex_lock(&adev->srbm_mutex);
-	nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-	for (i = 0; i < adev->usec_timeout; i++) {
-		if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1))
-			break;
-		udelay(1);
-	}
-	if (i >= adev->usec_timeout)
-		r = -ETIMEDOUT;
-	nv_grbm_select(adev, 0, 0, 0, 0);
-	mutex_unlock(&adev->srbm_mutex);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-	if (r) {
-		dev_err(adev->dev, "fail to wait on hqd deactivate\n");
-		return r;
-	}
-
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
 	if (unlikely(r != 0)) {
 		dev_err(adev->dev, "fail to resv mqd_obj\n");
-- 
2.25.1

