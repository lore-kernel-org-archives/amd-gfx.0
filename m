Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A6FC52CD9
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E916810E85D;
	Thu, 25 Jul 2024 15:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ppATze70";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18B1010E29F
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxpIzYK0n6YAwmqFiySOLC59UpyV1C187dOqZxjhGjnA5eWrf9BmcfXpSGq9n7by/aBN+DOmfkUKFiCsdG0jX2iYbG4Y09FrOfggJHJnqhvlCnKVkTweHBzIrJp83oRBDzMM2gVlkhvA19nSX/oCU6LbcurGRSlTHmdcdB04+VJY4IwfSNGt2OsM+KdDnKszrFvfqB8fz7jybFXectwwKsei1riuoGYjsGKbVvz5Bg6BRUrFhF4y4UnW7xlxd6j0+K5KkC4cKEpsU1fj2iw71DRyIuPmC4jKOVzRE/UAJ9bgWC9xzkuJ5QjrfqNqfU0CJiQ56xTCxAgX6Qtr1joksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMHquw02kdwlIFhkhe5h55F3vgI+AJyh/MiN3bz/cNM=;
 b=UhN0hZIyBo5G69/GaDLjmB8uGWmIurhpl4HSneXeF4UK+ZmShmX/ex5lbsAflTqKRSqtwcGj3SeAGIeJejjFvcY6i5tE/HF0EbwsI16ZenXDlhvgSTGGwPb+n6EMxEoksG/Tp1ekNuZ0bT0/FFQeeJJMb1Zql+4I/GQn2V0M2KxRvDIfyauHixgOiwxvkkf25BYTFB1V2CD8DnWNj7EANwDTq0ezgkt03eD6KfTfwSAYUgf7WTYnWMfzmVgS680y612A0yMnPlCgF9V2UnT+sl0Odfj8KtpeTfsz3fUz6U1KK9UvFSI2b6hh4TQsW7dbBSH80cXnCdc8Xd3JkQmk7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMHquw02kdwlIFhkhe5h55F3vgI+AJyh/MiN3bz/cNM=;
 b=ppATze7099xp2LJFhZw6JwKVnrZSzDPcnk6IDDPVZucWMpm7n/8uP2Jhedc2lhQGw8QEA3xa5RsNBZtWCEVUEDOa1DPMUM78U4HbbbPdSFBtMuh5a8BE7HP/zq/ULQpB/HYlBjwtVHDCjy2YzfEjdfHFgMDnOGjsa34WW7D1+Y4=
Received: from PH7P220CA0096.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::25)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 15:01:21 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::1a) by PH7P220CA0096.outlook.office365.com
 (2603:10b6:510:32d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/53] drm/amdgpu/gfx11: wait for reset done before remap
Date: Thu, 25 Jul 2024 11:00:17 -0400
Message-ID: <20240725150055.1991893-16-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|CH2PR12MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: 83de5e1a-c394-4356-b003-08dcacbaa4e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2oTxSuiQhkj/wu573x4uwuFZBkF5KUrpYPSVd8Xi05Ec1JWS/atP310O+ncx?=
 =?us-ascii?Q?kSd7oIFutBshlF85nMxbmUP086DCO8GY4TLUDH42PHK7qkcfCh7awToQeo8m?=
 =?us-ascii?Q?uJC0MQPTt++U0E9hh8JXcR1mA63Mvtavsbsm7oKMKV+VGP6ibOvsaodILMXz?=
 =?us-ascii?Q?3pB76zAN4NZLR5UEwCBMUVEfPu3Obftr0WKHedVzj9/825xDm8TtG9cTTYBI?=
 =?us-ascii?Q?fqsgq+VimryqnQG4F8QU8PgVblz+4W7aSzRY9ka/Y8E6YahFXfiMmMMaEBnn?=
 =?us-ascii?Q?MbbdMEci92vID6zSfAmbEldLClyAZf0yIj/Kh6GFbH9/gxj/1INo9hQLREB8?=
 =?us-ascii?Q?vXvSML5yi7i9MhCoNv/IUbbj9ZPEwsNv1D9o6G+1ITK1uLZwnCd83bV3D1mr?=
 =?us-ascii?Q?5X4h1t24FcLf4ClZdvg9wHouKL857A2r/xdIYOFMuRpdocw73Cey15jLoKQ2?=
 =?us-ascii?Q?jJ95TPOJKD+hzI95OIdtFuyEOY3PWfdaLMU/8i6uCCAzxEgh5nfEds8GRzRH?=
 =?us-ascii?Q?IFeO5diAcKPoeoIJ2IVEwQh5lZ40daxgDeMk9xLjOL6pUVa1fqAyWi6eYFbh?=
 =?us-ascii?Q?JNTHMDD7B/JVfPpX91mTppY81DQ8XDXJQcwAgUIaHpETxoP8k7QA/Hr+shZY?=
 =?us-ascii?Q?Fy4scXGfhwe/Fl4UBvc6Ldc7MiidLQTeQnDjZAnljbPSkL2yywqv+U/dZUMK?=
 =?us-ascii?Q?RqQDoNlWoTDeDVjFzjNLMD0mofaXAHjo88vgm34w9FbfNs2MhDxbf9kUXk3/?=
 =?us-ascii?Q?GFiXpyz2lNYwC/O6Gs8YPFmeF4lvqI8rJVpAv48GVNTD66ZAg5qcrVSm6wec?=
 =?us-ascii?Q?yqlfWwSD0IzgjOFtI2+gLaA6iLWYxhsjX8LU6xYNxjysX82ZEaDLaqycz1zr?=
 =?us-ascii?Q?w00QPy12XsfuMS6Tqz49qOQVc39jdtoAJwCk3RuHIGNfptOdAGacUZUp1XIE?=
 =?us-ascii?Q?z/vWCDwQk1nfkF1OIWLN6BjtLgeNMw/qKzOeenVn+nKBVxmZg/dXgRId4r9I?=
 =?us-ascii?Q?ZgBIOd7QR95Awalw9Ry/wd1jMQq++TJTMFool4fp2l/LwF1Nbfyyph6o043I?=
 =?us-ascii?Q?s7/ic+ga1G9jgUA89Ajh48q0Z5swsbt+C9jgocU6dwbnUPA4cAPZSvtJaFzg?=
 =?us-ascii?Q?fqoQOgMPB4PcIV0p15CuEg4Gi9ouGrRrTjSRTgHsQHuTeHZUmmxAS0hYPQqS?=
 =?us-ascii?Q?yjmMcY/A27hy4K9SReX+bMmeoDLabEZVXQtAVIf44Q5/sgycy4h1xDMmcmKS?=
 =?us-ascii?Q?5c22+89Huam8p2sI0RC8b33n9ib9kk7NOs9o65px1kpvZJlVA9DETHKHbXmG?=
 =?us-ascii?Q?NgH2IPD3FYALXARPqirFKmiyuQidEmYOu2qJx9PNOiucpeyVg0FiMfwTk+it?=
 =?us-ascii?Q?gJDvGHKlVK6d8WeK4p2wJrWeGLCUvKMu+WjtrK9wwaPC2Svq9gGxl8bPzAkY?=
 =?us-ascii?Q?yegFw3Q+ekHs0flQiYt5lOGat4rpWRZQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:20.8903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83de5e1a-c394-4356-b003-08dcacbaa4e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293
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

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 71e158f1efda..8a54455859f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6558,16 +6558,29 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int r;
+	int i, r = 0;
 
 	gfx_v11_0_set_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
 	WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0x2);
 	WREG32_SOC15(GC, 0, regSPI_COMPUTE_QUEUE_RESET, 0x1);
+
+	/* make sure dequeue is complete*/
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+			break;
+		udelay(1);
+	}
+	if (i >= adev->usec_timeout)
+		r = -ETIMEDOUT;
 	soc21_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 	gfx_v11_0_unset_safe_mode(adev, 0);
+	if (r) {
+		dev_err(adev->dev, "fail to wait on hqd deactive\n");
+		return r;
+	}
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
 	if (unlikely(r != 0)){
-- 
2.45.2

