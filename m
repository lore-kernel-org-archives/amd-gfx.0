Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0D6C04FF8
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 13:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 970A91137CB;
	Thu, 18 Apr 2024 13:58:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ambGKFkY";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82FF710FC8D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 13:58:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8ko4urLxWiJjUzFfzgZUup1w4eJYNQ0w20bXR6luILa9N0oe0hKAGXFAi9CAa5d9ek2t9Z+QR2SuzFfssEWzCRz1aZFHxzSIP2VXVgAgQavSjsj4FZ7kL73bB89I386GeZSl9XeOJH557AeiQ4JLUaBOIloDMal72nCBw3oa9mlSVxXpp2EK3TMhJL3hhr/7sc+RutmCr6BGQREarvQMVuHE3ksWrYDkfI9CAOyIqFW59C3Q+ApH9H17fs7bj2WtXFWk5imGiHYlMTsPmOBE2mOTqtz0kV4pOFg+ckzQeOf0ibRPAGX9hwlOznIJZFzGBnV5NOnV2WLvViy62Pdow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yzch0u06xpcIAUG9H3pf2JPcuoFEYsk9SJ6dDRpewnQ=;
 b=DolZNYVTqio8lxMRrY8SefRsQk97mWAFc0GfUr55fB+gFqMYQtc0WQlR7wP8aDUKv8VvoDgeDq1JZK9GSdB/TkMVjwDypwCvA2A1GDivKnBeM2+/S8CPRZ2YyaAlxXdYVdsJGSOOjr0luVbuXYECIwMjyCbome7spPI6PYcjiJKiuysYp7F7phOutMPUZbplMkH1mJ02IdzlYE4GIfJB1MS+yoh490FwQQ5z/xDmUn/n7hmUy5L1Cn0G5BMH5Jur23ff0rwNzf3kA0wZV1YQrIdf2a7WHmAQfW3O3Pyrme3xRg/gCjHAMqLC5b5uKpdSYTNIQWrIDNKhK9foMBKYHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yzch0u06xpcIAUG9H3pf2JPcuoFEYsk9SJ6dDRpewnQ=;
 b=ambGKFkYcol/36PUoQxU93lJJVmFiIu7iAQwVhI95I9m6BWTsatcsG/Wqjm7y1o65gSp3gCz1DoaQlYNJIVQsZN4mR5NnXKcvsJCPuB0cuUiTgWO5gpPwNi6UjhqEpe3HWZ+BeGC0Hlxepx00aN+zgI72nSNhudoXOCH8O+6EUM=
Received: from MN2PR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:23a::19)
 by CYYPR12MB8730.namprd12.prod.outlook.com (2603:10b6:930:c1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 13:58:40 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::a9) by MN2PR03CA0014.outlook.office365.com
 (2603:10b6:208:23a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.28 via Frontend
 Transport; Thu, 18 Apr 2024 13:58:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 13:58:39 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 08:58:35 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 2/6] drm/amdgpu: Evict BOs from same process for contiguous
 allocation
Date: Thu, 18 Apr 2024 09:57:59 -0400
Message-ID: <20240418135803.17365-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240418135803.17365-1-Philip.Yang@amd.com>
References: <20240418135803.17365-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|CYYPR12MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b70c925-2a34-4ce6-f9c2-08dc5fafa6bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KwGXxiMT3OBbhjXHbR00/jZqkATRx9Flp2EH2hM+hvjUFBCnLgePVsCl0/+98LB0PYdewbTTAxfHVppecesv9IwQ18d6LE2SEPlXUFziy05uzgU8EycaK+ATJVMg3AmUR4VlFNflLSub7ASIfE7PXSjhJPEW3E9ECQ9gv52FNmTtfwA/6ZdY3PJX0+/lj7NWfVPWcs0gFOLiDsOx46/B9dtN/u3+0F899oXQskfRODOwz7R6pT9bK3Hk6PtGsgXr2NSwMmleAjVLtWTAdQvrlDPgXBM806RQN2QsCLofQcztVCdw286EXYXiYwk4rJMFdFx57aaZwqYRA3J66z8zpD8HcIuzQ1htpWn/pMv/vzhlsAavlB88sWMSGOaz+t4QiZe/kcENn4AuEyvn/YHLq/Lmom86elYtXHC4Md2gQidLSNjmp5T7BbaYVU3VIrcTUzusQOjxpW2RTsa83fdHI9h0q4UDEZXdr+pqhsTZCMnwUjlNLhBZ4q+GbHD2e/XNpnIWv2N58amKY/iOJAENSlkx+cLRJiFk26LG1uehVVawuF63V3nPDbbqQmckqZ/40VwXaRkUNEK9fQBiBzTG3zMvkIW0/aZPZcRBF/2aAzPzmnTGuRO9zA7xbdtzKEAU04luPx5BL+2C77POqngmZteSMn+XneYv3psO9hciwPzWfphl6n8qc+7Ds0/gfTl3XJMTRMc5vv3kdwwNisgl6LQBHvLAP7EfNQtjGEoj6yJp5qKoAIsHwwn9oLnnhkkB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:58:39.9276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b70c925-2a34-4ce6-f9c2-08dc5fafa6bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8730
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

When TTM failed to alloc VRAM, TTM try evict BOs from VRAM to system
memory then retry the allocation, this skips the KFD BOs from the same
process because KFD require all BOs are resident for user queues.

If TTM with TTM_PL_FLAG_CONTIGUOUS flag to alloc contiguous VRAM, allow
TTM evict KFD BOs from the same process, this will evict the user queues
first, and restore the queues later after contiguous VRAM allocation.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 851509c6e90e..c907d6005641 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1398,7 +1398,8 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 	 */
 	dma_resv_for_each_fence(&resv_cursor, bo->base.resv,
 				DMA_RESV_USAGE_BOOKKEEP, f) {
-		if (amdkfd_fence_check_mm(f, current->mm))
+		if (amdkfd_fence_check_mm(f, current->mm) &&
+		    !(place->flags & TTM_PL_FLAG_CONTIGUOUS))
 			return false;
 	}
 
-- 
2.43.2

