Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4A4C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA6D410E84C;
	Thu, 25 Jul 2024 15:01:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kLEb10rH";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A334C10E861
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t766abJlKwwzI8/1OQPxowS4LffcVvVqKsWk+mGRihH5YETAdPsWYLNkiBgYVYPepfjfEZjgFwp+VHGaRXMZhYLPSrTXG29ZdkdgWYg51UYk1dr4pPKhn6G5HDrXsmi0PtPVR9mQ43NbqinIEXMOzHZrfHg/c2YZUXBtZdDr7QkJUllxRcjNfBtaOiFeGBX3DMfQEWlOCsU6zSXNc/b/J41bEKcZey9flbuKwkIb5ldmv7cbTlbQYBXKc8ElPDlm20NJz7FvUltphtTVntqG50GHm7Ozswl3GIeyZAWD6kiA3rKeEEfDu1KuIlcad+GTFm86iMR+9WMz7krpouiJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1yM81TAOhQjxQr3tx2Tn6DUf5RDH2z2cmbZ7cYXPjY=;
 b=vIKcwluVjHpOj3p491cAnIK41/ssd9ADOo9HMvH8kCgJ7vAYILeVgY4Gq6mQ/p81SL7+OmZ7Dgm8UUEoryYkMq8sb+GMZ4RCncJQV0r6+H/rvf4qn4Wb5rGxJDbaVLn+lLOj0qhV6+kyr39BFsnW66HCnpvrgcMF1YRy2n8x4bAwbOTR6uA3sTBPIAhbyV75zrWbw+z0HK9zZMyW04t8z1T1hbdgDhaNMeTal515htDMG+vF5LOEYp3Xt0nmsg+KTvk1ggIXpIs2ViVmq7DqFFhhrtCSI3K8BNkPmqZea5rZP9cM06EjUqS+ws3dda8pBIUN+pQk0AE+q6kBJwq/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1yM81TAOhQjxQr3tx2Tn6DUf5RDH2z2cmbZ7cYXPjY=;
 b=kLEb10rH4omyihqIK1wKEgWc1GhsoNHQH1l7VzQU0T0lkhty8jwc7NqdikVbk+IOFBnZI0Zn+TuC81dNKSf6zcU+QyS9dk1Oom8kfzJiS+wrjhyFIeHdzyjXdWN7oN/W3LxfbroE1Pu7eWRr0S9pMKfS0i0EYRIeT1WUuJene54=
Received: from PH7P220CA0106.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::7)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 15:01:22 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::20) by PH7P220CA0106.outlook.office365.com
 (2603:10b6:510:32d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/53] drm/amdgpu/gfx10: remap queue after reset successfully
Date: Thu, 25 Jul 2024 11:00:19 -0400
Message-ID: <20240725150055.1991893-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|DM6PR12MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: 67aacb14-580f-4bf8-09bf-08dcacbaa5a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n+ZS8wACoqw2f8+jQqnBj+AVCU7qrCY5RFf0LLTxeI/NdNjeDWGE+65gZPjY?=
 =?us-ascii?Q?cwsWx5fXFh8aoNJ3UB4MOLqZ6bF2rXaXRI8fGIXbgotEz+LPrIv9PTteBKOL?=
 =?us-ascii?Q?JW0XjaYCr1XO6kj6hHBvmlK5JLivhCSAmLr9I9KIlPmiIvgocaRa5l0ubaWO?=
 =?us-ascii?Q?B5/3yb36A5eJMntnusMv8pGZZ68ooEzbYY1AWS0EHfaiwncA4gqWLe8Hkv27?=
 =?us-ascii?Q?OMvzw+SO8SVpM+hXWYmereevcZzJuixLEQXNRiaQ/k5s6D4GOeCaxyIWRE/L?=
 =?us-ascii?Q?uOw8t72cJfAPJPXXZ+IE/zX/UnNQDqpel24m8rKHnDfxNjlOpVv30ONwMpM3?=
 =?us-ascii?Q?YCY00K2JTgbQ5IbGfhjpK0QnJYyavSS+Breai0biQFAaj7MXq96IJTQt9OXO?=
 =?us-ascii?Q?NkuzkNO84xx5lhn4YF2tJOymewvpdstzoHJfObFTRp5+fHUZ1cQ1ML8yjqHW?=
 =?us-ascii?Q?/T+67zbN50CPEFa6ePYjDsOvpZKw55DbC03egXzxsB8l+g/5aC6n0rrMvabG?=
 =?us-ascii?Q?5YBRN4wEWXh0MCa8lzCUTJ9RivvuQ/FlHUNqc4nhAKWqs1UsGFnftzmPldzp?=
 =?us-ascii?Q?0Ay2rWjZK8GcdPKJPU55RBUngLGddjcT5jld4wVoY2O62V4DW2TuQrT9ijRJ?=
 =?us-ascii?Q?T6MzbpJGdS0vQrbL3URX8CEld1aiw8lojPUIwfQqG+T0acwLWEGB72Ld+Isg?=
 =?us-ascii?Q?lbMHnG0w6suRdeN/Xl47T/cMyssaGqOpLlPhsa8uFtcg9SOvvSgJiLCjkyrj?=
 =?us-ascii?Q?AXT7QyG00uRpohucO1an5wGV8kcZRxrSkOCwOA7r7IcwL8MhYWaxSgjWpT4o?=
 =?us-ascii?Q?g5vepVRi4Q+3VGB7LMibFNnKUbRqYvj4gmxO045oyodygN8XRtSUIdco8b9r?=
 =?us-ascii?Q?6WknfJ7T6ty/iL/t6tvEUYwVtMtfyJLegEeJmG3UnNlTj2O4+oMJHFo73UI0?=
 =?us-ascii?Q?5r9cq0he7TvDNyo72Oqd09sKPf8lXfUX3XEaFxo7Z7sARSGiXW1HM5wKqMDT?=
 =?us-ascii?Q?qeYFsWGCU7RkynSw7dDFsa/UiaGYFABLgsD/icNN+2HW2V4cyQVtNHf/3DBT?=
 =?us-ascii?Q?b1XdrlGfrCQaY0yRMxUHQqqljbHZPgnlKV1k2FDCK8rTvxofUp5rTo7QknSW?=
 =?us-ascii?Q?sliqXOJDoJ/cB+1NioXFonrGv0bd6z2jogQuL86RN6TYU7DC4PlrMpKyXZ8L?=
 =?us-ascii?Q?MZuTHxst5kBzqgb6zYdDDOVht3za0RGPv1NfhKH4HhVHV3rt2/A8oC955Nw/?=
 =?us-ascii?Q?71OB2R6EKiCTGBEPQiOyP5vsyKQAng8qg1r5qmzRm3i80DMEWPKnrZWA+UCj?=
 =?us-ascii?Q?rmdpMyce161u0x+4FxvE3WMIpTsnrSp5USp9O2IdCoasIBTNapGzt5PCapqB?=
 =?us-ascii?Q?kpgyCaVKHCOGzLzva4fyWCKqIcIyUIkSPz3ajyYAAQ+urlxGlGzfeCfp0MTJ?=
 =?us-ascii?Q?fxkEIjF7UzYqBVJmuo0lH2bASn8VyT+O?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:22.0622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67aacb14-580f-4bf8-09bf-08dcacbaa5a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Kiq command unmap_queues only does the dequeueing action.
We have to map the queue back with clean mqd.

v2: fix up error handling (Alex)

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 46 ++++++++++++++++++++------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8cc701cf9e17..ee0fd555c284 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7086,13 +7086,13 @@ static int gfx_v10_0_kiq_init_queue(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v10_0_kcq_init_queue(struct amdgpu_ring *ring)
+static int gfx_v10_0_kcq_init_queue(struct amdgpu_ring *ring, bool restore)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v10_compute_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.compute_ring[0];
 
-	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
+	if (!restore && !amdgpu_in_reset(adev) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -7154,7 +7154,7 @@ static int gfx_v10_0_kcq_resume(struct amdgpu_device *adev)
 			goto done;
 		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 		if (!r) {
-			r = gfx_v10_0_kcq_init_queue(ring);
+			r = gfx_v10_0_kcq_init_queue(ring, false);
 			amdgpu_bo_kunmap(ring->mqd_obj);
 			ring->mqd_ptr = NULL;
 		}
@@ -9521,25 +9521,49 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
-		spin_unlock_irqrestore(&kiq->ring_lock, flags);
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto out;
 	}
 
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
 				   0, 0);
 	amdgpu_ring_commit(kiq_ring);
 
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+	r = amdgpu_ring_test_ring(kiq_ring);
+	if (r)
+		goto out;
+
+	r = amdgpu_bo_reserve(ring->mqd_obj, false);
+	if (unlikely(r != 0)){
+		dev_err(adev->dev, "fail to resv mqd_obj\n");
+		goto out;
+	}
+	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
+	if (!r) {
+		r = gfx_v10_0_kcq_init_queue(ring, true);
+		amdgpu_bo_kunmap(ring->mqd_obj);
+		ring->mqd_ptr = NULL;
+	}
+	amdgpu_bo_unreserve(ring->mqd_obj);
+	if (r){
+		dev_err(adev->dev, "fail to unresv mqd_obj\n");
+		goto out;
+	}
+
+	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size)) {
+		r = -ENOMEM;
+		goto out;
+	}
+	kiq->pmf->kiq_map_queues(kiq_ring, ring);
+	amdgpu_ring_commit(kiq_ring);
 
 	r = amdgpu_ring_test_ring(kiq_ring);
+
+out:
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
-	/* reset the ring */
-	ring->wptr = 0;
-	*ring->wptr_cpu_addr = 0;
-	amdgpu_ring_clear_ring(ring);
-
 	return amdgpu_ring_test_ring(ring);
 }
 
-- 
2.45.2

