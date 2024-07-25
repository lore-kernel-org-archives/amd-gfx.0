Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEEEC3DA7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFCCD10E849;
	Thu, 25 Jul 2024 15:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5ZYpjmId";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36F1B10E29F
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DeP2rRJck8PpPSrJdvrWYzOFxW0wx+3CpPo5nJ9NTXmfWpQ/2gjZpiUUSR2XglIhBUKr3Iofw1c5TjnvNjawNoyNmNw6puPPUPxBVKNT1AKQ2FhaJPGUiUYzS7oRde+K5sXgOnr8ohkMmM6ur8f0WbDrxXvCxKONiJxg7BJBeMQ1NuDoEjeQCcp5vbIIyQYcHyCWUAYLrZ6JAEJ1D/tiWUhMvF24dCb/1xczzbKGbogiCvYBJr9I4xoBarZKvFpAJuxN8aF/4z2ZCZMokrpCfHOjaCI/0/e7PSLmAQmTVkWoxEO6HRsdNj/mhKJcp/rSaxTT+oaPmfQSsR2Ou9eYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcHjdFiK2LMcnoHMCq3/d2GwHYfwUiDKc16InkmtiE0=;
 b=JOyNwpfRb74Q4ckD9AHj7LJ0NrNLGrpfWGyU2hF1nsJzt7iT4AJWjbPkjyPNUFYx4tldtg6CuiItfu+T+u5JlDA4p7yJMDT1ztPs2GUBMNyka8QHsa2LDgjkXBOYHLuQCVQfpVYIzLFO6qHEi8L1fxKtx7Q4idl3ouqVcyIbCrtxjI6zx/vgj2AKVKXNymDXfNMGuRICvDSdwDkfBhkiXDqsWoXAaa3crnKdYbTj1myO5UrTGDi6sy+/vFNombuSIo0cojfQG2K+rEac+NH70HhoVeOsFOPr/aMtv+yOp38OmLQD8Dgt9OdEsXSlnUKl2Y2uk46jz8DJkqpI8DlJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcHjdFiK2LMcnoHMCq3/d2GwHYfwUiDKc16InkmtiE0=;
 b=5ZYpjmIdvYa2n6ggBq4sTnfjhPoDo4+vtuAawz2iyuWXUcqlQ1VDnINhc9SLAq7AXXXFCYcZrecUxFlqYSoRDE9AaUnRTXoevpUGu/hAy7aFUFLVr/AGE59QBAktJb8RPqnD+4KsG8PVfR+WlUjW51O0er+D8e+j+1AMSY3lF0E=
Received: from CYZPR10CA0003.namprd10.prod.outlook.com (2603:10b6:930:8a::15)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 15:01:23 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::6b) by CYZPR10CA0003.outlook.office365.com
 (2603:10b6:930:8a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/53] drm/amdgpu/gfx10: wait for reset done before remap
Date: Thu, 25 Jul 2024 11:00:20 -0400
Message-ID: <20240725150055.1991893-19-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: 579d98d3-a3df-4ff5-4f16-08dcacbaa605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ogPePl9apj9r9WsvpFQfgIzjswXzs/0TTkV/1v1x+0Jo7iOQOv9wkOqS8peK?=
 =?us-ascii?Q?zQNBqbaZW2gTKddy1FDyiIzAkqCBKeEPVzJXFBQsT7wc6y5cX7ymq7PlGFaw?=
 =?us-ascii?Q?RnI2bFVIVrU0wVInFi4SZxtBJVfruAeofcQrHuMW2qXTJqNobwhDrHOgE2XD?=
 =?us-ascii?Q?a/aoc9aJzkB/djY9ykmx2qe9CbrG3oEbbUaLCrLzWwC8aOOIh89JP52e4i3Z?=
 =?us-ascii?Q?AN/EokszQuIal5kukuR/yaTmtnIXNXiYGjc5A2j1zDaIXFHfuyd9y1LMb14N?=
 =?us-ascii?Q?B5K2L+Jak5ihFk+7/cUsTMZZvRv5C+OJpg/Cfu81HPKFFlfLkFpE2CB6Gif+?=
 =?us-ascii?Q?KHhVVwYVuhxXAx4xmWPpkA6YWoHE6UDjHUVAMEFJvN4yn/W4uZ+SQupfddlZ?=
 =?us-ascii?Q?a3HmpDpEVSU8KkfeGlxHvo9/WSYDDkVkYPT388L8/SfGYaqkvxKyUxVNQxPx?=
 =?us-ascii?Q?+I8kGBTbhqU5d0cEdw+QQhpNSIFkZVSQT+UVlsFVhuIL5FKzQli+vzCsl/oL?=
 =?us-ascii?Q?/FiVYdiiNCLFa9F08Seo7oPlA/3A1bilVxPKbfY7usoZLt1cdvhY7JeUxkj4?=
 =?us-ascii?Q?dE+ujH+LWYadPggb1pJb9o5Jf2phCEk+tZ1F49iZ1P1h0ygSyzKo62Teds+z?=
 =?us-ascii?Q?JrUaWYrUaJ9uE56/rR5oSWNIR6vQBg0gUfkwUDFxqWphOFdyba81abSoPNj1?=
 =?us-ascii?Q?pkF3lhcS7wx8YFiglD/plY51xNNIhyzA6cZ1+Exp4CgZ0io3AdkSM608BNIX?=
 =?us-ascii?Q?JQfyeTfplFA6f58v1ksWtg+/tDCshQHYcxd9MJ1u+VnnIIW7LsHHy6j+OaTo?=
 =?us-ascii?Q?F1h0t9mdN7NxoynMdMScME8PKJKXYUACX0HL2ghI5e9hq/WJBRFCgbmnokfm?=
 =?us-ascii?Q?lFXE2hG1lr+ADe6mK90U8Fz6ee9NgNsd2ceyWZuAjhZTnjXEWzpBLYoQCTom?=
 =?us-ascii?Q?ECpaF8Iim0GQmoRWRmJQmlik7PdsqZ5I4VSb1KoHpnSmitDwKJszXPMiDQti?=
 =?us-ascii?Q?9FYexS5F7MVeDNw/zTS0H+bqqKJUKtINu37Q587e/qwoRMg/27Gymp5oeDLp?=
 =?us-ascii?Q?XWaX5zTWLH0Babc3ObHWJzYGz8gSQAys4JffIAwzg0SCELcJZl+6Uz6ZWG4O?=
 =?us-ascii?Q?c6y8bhwDc9dFqfzCTa3uMvy7MxVvDSPoHU6j7XUfbPmCUqh2tAY21TxHniGq?=
 =?us-ascii?Q?TeS4euIDz6+RZD0w4w9i+kNTW/OeLBb2xGHoECm32QlohugIK+YKIRITtTFT?=
 =?us-ascii?Q?xX/ZzydUQ/vlG9eey3znYOL/2zfrqRDkCGcJ8vSYSgAPUDgXkSM790tva42x?=
 =?us-ascii?Q?WJNMA1uspi2qVt0pOO0Beb2kxpexNo/fTGz57hAGJ/yHA4KK9jB2jx+Dd8t1?=
 =?us-ascii?Q?LZvxfxNadseXR/pCO4yqCKOx+pRC+7TffM72SneBa51jV1PNWELwcFbQDR9Z?=
 =?us-ascii?Q?6nle4fRkNjsX1slyQyd2F3e18bopTih9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:22.6215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 579d98d3-a3df-4ff5-4f16-08dcacbaa605
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
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

There is a racing condition that cp firmware modifies
MQD in reset sequence after driver updates it for
remapping. We have to wait till CP_HQD_ACTIVE becoming
false then remap the queue.

v2: fix KIQ locking (Alex)
v3: fix KIQ locking harder (Jessie)

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 43 +++++++++++++++++++-------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ee0fd555c284..7b534966a297 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9513,7 +9513,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
-	int r;
+	int i, r;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
@@ -9521,22 +9521,42 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
-		r = -ENOMEM;
-		goto out;
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
 	}
 
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
 				   0, 0);
 	amdgpu_ring_commit(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 
 	r = amdgpu_ring_test_ring(kiq_ring);
 	if (r)
-		goto out;
+		return r;
+
+	/* make sure dequeue is complete*/
+	gfx_v10_0_set_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1))
+			break;
+		udelay(1);
+	}
+	if (i >= adev->usec_timeout)
+		r = -ETIMEDOUT;
+	nv_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v10_0_unset_safe_mode(adev, 0);
+	if (r) {
+		dev_err(adev->dev, "fail to wait on hqd deactive\n");
+		return r;
+	}
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
 	if (unlikely(r != 0)){
 		dev_err(adev->dev, "fail to resv mqd_obj\n");
-		goto out;
+		return r;
 	}
 	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 	if (!r) {
@@ -9545,22 +9565,21 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 		ring->mqd_ptr = NULL;
 	}
 	amdgpu_bo_unreserve(ring->mqd_obj);
-	if (r){
+	if (r) {
 		dev_err(adev->dev, "fail to unresv mqd_obj\n");
-		goto out;
+		return r;
 	}
 
+	spin_lock_irqsave(&kiq->ring_lock, flags);
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size)) {
-		r = -ENOMEM;
-		goto out;
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 
 	r = amdgpu_ring_test_ring(kiq_ring);
-
-out:
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
-- 
2.45.2

