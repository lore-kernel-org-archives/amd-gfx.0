Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C49C5B543
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 04:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B41410E54B;
	Wed, 28 May 2025 04:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pdZ+0w8D";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1120310E572
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 04:19:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYivcEYGkc254uxkI1IuRYYU1tbWx9qlrT7R9dX9HnRSzhl9k+U2EEp2Jm+F2yIPhfcZp2iiHyInE06tsqjq4bvL/OVFGdoDdQ4E/5QNmdZHwphESGL9awkdn/1zXtMChl8n0xbDpXBh/EwH9iaUtBsbLPpGscK/JHMZC+IWlIT3KRoB1qQGM8dTkMnHdjlAJiiyZlsZXaQInW/IHMTUQ4pA0G09/2m1u5GFK0Awyocs3IFNH4korxPQN8v2Sns1mz1hWzb3RT09pwxJxe5ppZWZ3YPdDvnAuqykXQZVcUAUVZEKOQKqUhOHFDb0Ov7S7oNhpS2mz3wdLr7J01qmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zctuUp5pNeYoSA876srcxppJLNagC86QCl64zeVhGDQ=;
 b=pUwuzHe5KHWSk8xszlK5d1DVjHmx48XcO690sjD8OkG47r/md+gVjLLoZsuxBHmHtQ70rYF9BH6gI7oiuxmom27p455C8R3Ywce2DeLUfSaXsuX4TzwNBSfdz9Ju5Oz+OviwOsczSLnad1Ko8P/Drg/VOQHatADZyut1uduP+ZvdRhX0LMp80OScqcHnaBwuUhGWVc/38a9kwhbTKl8yOWZILrsiSvxAbp+vmQuYYojMqsl42cmynXoFtDH9lFiHkZSb9wuWSGx6gfFtHlSxBYaFLpE5MGJ3cijRVa3K61O34Yn5JRDYSW5IMdRal66wa0+WbZCeGm6JLv81rgUS5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zctuUp5pNeYoSA876srcxppJLNagC86QCl64zeVhGDQ=;
 b=pdZ+0w8DKRQkgjcDkuiA17T9d73C2334UuZsX8mcmQ8I4wfToL7j2Se2dWKl+7uAd33msd66AFGMUGUiEckHrXP8x9n/xS0wE/8xfy6lRxhMPOTbgLmXV00CedqZ+ROUpdBgGL6/G72CFQhmdzJcNbIZHt9VTlyjuF3+u95koO8=
Received: from DS7PR05CA0032.namprd05.prod.outlook.com (2603:10b6:8:2f::31) by
 BL4PR12MB9536.namprd12.prod.outlook.com (2603:10b6:208:590::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 28 May
 2025 04:19:38 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::7) by DS7PR05CA0032.outlook.office365.com
 (2603:10b6:8:2f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.16 via Frontend Transport; Wed,
 28 May 2025 04:19:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 04:19:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 23:19:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/19] drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq
 reset
Date: Wed, 28 May 2025 00:19:11 -0400
Message-ID: <20250528041914.5844-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528041914.5844-1-alexander.deucher@amd.com>
References: <20250528041914.5844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|BL4PR12MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d834f4-ec29-4486-2ded-08dd9d9edca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tlae2cOpnN5GI8X2jJkq9KpVxSzGkq/S9FqeawmjwRwvNrhCCW7WmNqGNla9?=
 =?us-ascii?Q?wRGyki9jfVKchhxBgREAsK+kxkEcWzqoshLBbKNfYeiwM6ZdWIn2vMvuS7hY?=
 =?us-ascii?Q?Q8NhzlLPnhT7jT/LIbm1oTDt6Tpr9P8Dk1P25oMwE8Wqr+ACzRPYnwZAj6ft?=
 =?us-ascii?Q?eLka7mmwPXnW+XST+BSVAp5RcMvgZwqrne/wvCejo81V+BJIhx0Oa1ZvBbvU?=
 =?us-ascii?Q?YKMf8EbmBPpmysQ2Obf22r6nuWugA4ZT0X4GuSAJbsordajEHX3W1+U7goYC?=
 =?us-ascii?Q?OIw4sWfIO6ow88yvkFUOofTqHgLFd89bOCSpvau778fwL6fSb5zyEqDIIfus?=
 =?us-ascii?Q?ek1yPnbmfYjCD6WbrgrTERWpSTryzCrki0LT3nxS60ive+h1QgG7M8o0tveO?=
 =?us-ascii?Q?yHZOICV06+SZfrqyqij7T2TpPm3mJo8doDNi1UTDlupLs5v3TxOv9jQEMj8O?=
 =?us-ascii?Q?6+QEY7ez8B4jpFIH4ZMyQl67o5VaRA5uH3/Nq/ZnD+UflxQFQWLsc2VKAf9P?=
 =?us-ascii?Q?VWTQ8rvNRhv+gHWfSe8ERXsBNaFvYVJba4P8EV49fckiwQE9TcrIUQZoV3BI?=
 =?us-ascii?Q?T8nLaw8r09649BcgY9txI9YWrMdq29bqcE5s6cSBR3xQKsikiUUHGhX9l75p?=
 =?us-ascii?Q?CaZfJxYi0914k3SOCeqjGL20f0ieo1pYSF36hgkztHfzXtV6di+iR3NDfKl+?=
 =?us-ascii?Q?7Stivqti5Dj33NiLoBPsG4EluI/0a9oqJe99qsRsxk7l0sMiD3ygfiEcmywD?=
 =?us-ascii?Q?JOK4jWX8PZAsKQYaDrh0N/X5Dy4Td/MikK8lAxEMgHpbJtKMJUScgUS+p8Z+?=
 =?us-ascii?Q?CRbLye3IzcSPtrU5MGBgJ6thlKRfBNgIPl6D+jd6inaHwkasCqxOD2nXw5fG?=
 =?us-ascii?Q?ORgtlsLgeMvt6mjekPQbNAF34gZ1oyCyHngCHVAEMNfDPoyLruUfOLuLcFAj?=
 =?us-ascii?Q?loYWyZxPglkZlv986lDQ4Br/ytiA9O+vmH6m0mRozjQZ3qbCM0wgnUq9SoBf?=
 =?us-ascii?Q?TCnLHRDh89ttgUsJUo5n656QViDQcw9ZzrqWYXBsZIZr2m/pFvHGubE07mZa?=
 =?us-ascii?Q?GdveRFei1k9KZWjTCizuVj+dJ+EZYepWao26YkMEZWLCGzMICFHDlCiJby4W?=
 =?us-ascii?Q?OCe+zKrkiHW6eSC9YnXvlmqeKjfAYRAD3OIFhD9DRQoNHvzj27xMqdjnEPpX?=
 =?us-ascii?Q?pbv9UDtB2ImYd+Aa17t8+N2dVzvmIeyoUTSgy6AjGMvoLWot1uo96jQ8WUyl?=
 =?us-ascii?Q?ir6zwGkjFEEi90fSzUWwGv1Wbk4c5ZNmn6tkxa6CMs0jhZ/yVL7kn+6rykNP?=
 =?us-ascii?Q?bCFQAudVFRfSjzdgHqI189rqD/OmJTfTjNZQJIZQd7plGHuDUFX0UFMFGQ+X?=
 =?us-ascii?Q?RL3b6H/gM3gqmAGsvlEFYImO5Yr2zNzZl+/ASF43Ew/j9g/oCTeQU7dicJvQ?=
 =?us-ascii?Q?My4bxBHTO1jcn1L//cIgnCwPRkBjaQb+dZVj4kNNCn0f7yBZW/ZGKTmu3BW1?=
 =?us-ascii?Q?BgqMeLvwZ82SEOhaerVvMuhOkOatSBq7xDom?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:19:38.7751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d834f4-ec29-4486-2ded-08dd9d9edca3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9536
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c233edf605694..02519dfdac735 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3558,6 +3558,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
+	unsigned int i;
 	int r;
 
 	if (amdgpu_sriov_vf(adev))
@@ -3612,14 +3613,22 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		dev_err(adev->dev, "fail to remap queue\n");
 		return r;
 	}
-	return amdgpu_ring_test_ring(ring);
+
+	if (amdgpu_ring_alloc(ring, 8 + ring->ring_backup_entries_to_copy))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->ring_backup_seq, 0);
+	for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+		amdgpu_ring_write(ring, ring->ring_backup[i]);
+	amdgpu_ring_commit(ring);
+
+	return gfx_v9_4_3_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 enum amdgpu_gfx_cp_ras_mem_id {
-- 
2.49.0

