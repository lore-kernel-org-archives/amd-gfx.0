Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F89AC54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 09:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84C7210E90E;
	Wed, 13 Mar 2024 09:29:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V/mRfswL";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1F8310E90E
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 09:29:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQYydZjcnBPwtagIj+4/ABorfzQea13VvzofRYgPZ90FaSEDXMRHfIdOHLI/X9VN4T153dYxesgNlR6kv8Lp6aZJufSD3a3vyZXQ/c3CdOsDq0qYvkZEITBMybxv3kGN4Fqlufz4p4ahflHlszU0GMt6a+I7QBIzAiWKy5FZ44unYO4tyzlGDnTH0v2aB9oxYpswXZmzcR+Kv3ie+eDyBbNfy3tuEO51I6HDHcU1MC/HnJ6pVzwXm2QNDZoykgqpvRDcBa7m6z0vtpxHk6thivfL9Zh3d5AWoL5ZZG37MQYGK/m+jMdUt9Z+1t7/DyQ0j/x+Br67h9tq7nnKj12YnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FU9vZp72NZE6IeFaHC03deP9vIxosiEEOb+8rACA7LE=;
 b=lQONpj+vrQKfHHBGK/ZtHV+Lw0WfHzgjG+EZBW2++uHzt7ZVa3VEzqqnqzuEFnxIIYMG0XVf6pnbSwIavDuRoTmfYHxVGdvcuS1mmfh/x6fE/KcsFwbdRbvfI5TDij1udiMJT7f6WhIoi8ctkaj8IPqcMjmU1eNDS/KYdsxqY9FBP68Q3lwdSFHsS38bVu8ljZOlSVDwoCk/8nfzvcoImvBRVtxaLIe3LUEKcVPUAkfVfP2OexGC0Ona1/7e8sntLcr6k8HFKHCe72lh/i0BYFd3Ec75oIjSsbcGGvS5GRpLsB1d12WfiNW9zJoJEu4aJn5qWXd1D7zW6u7QFZMcfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FU9vZp72NZE6IeFaHC03deP9vIxosiEEOb+8rACA7LE=;
 b=V/mRfswLMbxJPH0VXuFBgfveEK0QeZbFOv0xnXDFwMNKsJ7UPUhNfOOAJKl4nBk8twviswGmL/rhRI5nSDbG9tpmTRuOcq4umGnIbt6ts/bJTCLuoNuMmi/0p26T+nXpAKLzDo51T23zjPvX4LRP39Xr75Mm6/Q7UZ8v2DsQek8=
Received: from DM6PR11CA0039.namprd11.prod.outlook.com (2603:10b6:5:14c::16)
 by SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 09:29:47 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::41) by DM6PR11CA0039.outlook.office365.com
 (2603:10b6:5:14c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Wed, 13 Mar 2024 09:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 09:29:47 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 04:29:45 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: correct the KGQ fallback message
Date: Wed, 13 Mar 2024 17:29:36 +0800
Message-ID: <20240313092936.1274265-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SJ2PR12MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: a2daffc6-0224-4069-0f9a-08dc43401ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLOz3np//rZqJCcZjWH4CSOPieVt8Szqs3xQJJhLCYGZsZ8r5REWGGqqNWPNMH0UzSJgFwjRTXCli/2QB7vtqxnXQfRuWme+L+QTqXyCHH5vXaQW4Bf1+uiJuukpxTQYXugSdz/E5qTkxM8PxKAG22h+my0s38pcFBQNiCj/wq6ThnBWYrnobb6Ebx+QPoILiZMwzvsNYYNd9eNCoBOM1YEe8CiOaqme/1q7/+PtYR0irfA6u9UPhVNk3wqp2h3tVWsR3Z+fz8VWZxcbMVEV3YF0poLfEH8tuXtM4BwSppTy+ZS4jk9Hh45nSHNQENMkJCBhbRqnvHX6BZYz5Eg4lPfAgVQ8p/MHVX2bk1BUFE80G1feORg2P3kv1xj8ObHLaeRUOK5mMT+KqAf+0MLLRhjbTFSd81QDy7wNKsPDcNz6yoR9CVZ+qKE9jbRvKWMCEdMMMO+QMiEWnUapCgyqOBW8PVfi4rkuxM9v1EgiwwamR8cZkrjxK56DN3r+x5nlOIoURX6XexZx4+0ywAjPxQgUjDDR9vUKMTum3HwbjfN2d9E9+UdsVMjG7E5SC8u3nCVVFKuyePMxMr7TBEQzw9C26H730UgfIynvd+8rCw/pXdal0Sm15BGanB6st0+jmLjbu6VhZ1vu50HGcElLVDaaTvfPBZMKoZu+zDBQxgyjdW8LW0NKylfggq30PpwHuxb2Bnb/IqJ/c1dNKc3gSXzKMHw3EDQ7Cy7BHDCZqjnYwHNOG/V7CPukGgPWKlIG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 09:29:47.2042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2daffc6-0224-4069-0f9a-08dc43401ff4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033
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

Fix the KGQ fallback function name, as this will
help differentiate the failure in the KCQ enablement.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 4835d6d899e7..d95555dc5485 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -686,7 +686,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 	r = amdgpu_ring_test_helper(kiq_ring);
 	spin_unlock(&kiq->ring_lock);
 	if (r)
-		DRM_ERROR("KCQ enable failed\n");
+		DRM_ERROR("KGQ enable failed\n");
 
 	return r;
 }
-- 
2.34.1

