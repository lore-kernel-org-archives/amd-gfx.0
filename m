Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BFEC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 13:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B69B310FC8D;
	Thu, 18 Apr 2024 13:58:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Je1ClfST";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94132113CAD
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 13:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtqCikA6U5SJqeGxgHozzHxmIszh8gxtDUzSofnH2JNdjOKZwm+Z1nqPIUeMrMrva+ugN7X2RtRX1ijmVW1G5t7OWQ2Da5KmQRzROU1pe8xGJMymmFlqDpj7k7I4J54a7grFevUFTOh1JkXcnSmneYSyjzg0/uNBW3wtwbmFTVrDmuKF8w+pWRTxtZmlR0FMLw+SjS2m9WfoDN4O2nGKN0vWVUFzgsTEBjGOviR1AMibetmwZe9m9A86KDcGtukALyepPxD0B9AbHsV4+AEX+UfM1ZJ8pIvdf6AfFqKdPPUQ6Q7iflwEy6QJg8cwy6yPds/7xDFfsrbSAsbAueTO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ai7YRlMvRpQ1rb9kzXINi3k5Yg265+/HzMBihLesDrk=;
 b=SY9CKXin2eTCFNDKgGs2X70S6U4maMoK1mrE8GTQ8g0aHSqkhMbChfcYZYPJNyIGz+H6NkQjwFaL6wdEF2XXRBB/rRmo/ZyZrkuD80ysk4Jgn2d2UjIDi95QGIoFl3qSeJ2VufDEatPC+ivYiJwUdJ4thuiGMVvVRGANL9Mca34Wh+6rHsP+/9l6yY0idy7V6yL4WZ62uXpIQ1reYtbVpp+9/Mo86SUPwh4OXRtyjuS5b6Ue2p/7gsV3KCXGRDmuqrudwKj3mLSnYsLC0ua91w4RMXrSVVEe3i7ErDHzMAJZPhbLRy5Dp4agZWLMqiX1wMfDJ0ObwuRSBN57+PIP6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ai7YRlMvRpQ1rb9kzXINi3k5Yg265+/HzMBihLesDrk=;
 b=Je1ClfSTU8ELx2yqWZsJW2HDxuiEAMynExQEitWQdb5wjBOYg9OeBrUx+0O26p0mYPVrRwlOD7H3Sy4lMM8G3fceV+dPQPF2/aKxo5IaXlDu2/en7D9I1CTUS046GXlidVRJ+MtHnuukfMwsg0Q4OBz19vhx+geJ8kIxPH3IyAo=
Received: from BLAPR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:32b::15)
 by PH7PR12MB5901.namprd12.prod.outlook.com (2603:10b6:510:1d5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.42; Thu, 18 Apr
 2024 13:58:40 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::8a) by BLAPR03CA0010.outlook.office365.com
 (2603:10b6:208:32b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Thu, 18 Apr 2024 13:58:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 13:58:40 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 08:58:36 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 3/6] drm/amdkfd: Evict BO itself for contiguous allocation
Date: Thu, 18 Apr 2024 09:58:00 -0400
Message-ID: <20240418135803.17365-4-Philip.Yang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|PH7PR12MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: aef197b2-1bbc-4c89-29b7-08dc5fafa6e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 28+ju3uQF0Kh7QXTVTea127vh9z3pGS+THwH0r+NTSnf+/UvgV2AHszhneYEVWIODBsgTmaTclicUYrJmgiZkMxcMjXxgLG1x2skL8qMAdeFNHbBZ6krt8uyCL29J7lyI2MKK+tLnWMgji0L6RneSg87z1IupOsP4tD6U0hvkhgPGHkEZRvMiqa2jRz4857tf09wqD3y5vBStzx0zbesMKLvXL2tXQ9/Klv0yR6cRddD7Jh/vGTOT7y3OjmhfGXwIU54+Tq2vVgTG1t7QWji+Vn4oq0TNdqFm1Df7wKjuq8w2tXkOwnN8Cfd7+TbN0DGE1KYnGe0fq9Do9D1cVlRvB+OUBw6Bo7uHB8eKwU3g3zkRqNaUZVgZcQDs4WR7ty7wDVjqcfkNiL1LB/uDKs6y/77+ckTqDSHxPuObuMjgaId3MYRIN7Q4PB4/DJX3cWadhgRopZsyvU9BOf3CP6TAgcRWmxx4YoyA2tHLkzOlIbVH+Jq0hJ/ramPVuiOA8BlyQ+y2V1U2PQ5W2jhWcF1CQ7Xh1Uq5PAmgK6W9MdRtTnjqghKoI6yecNQu7BszZK1Wxx1JTQ4xbEyJMxRnqkBLEv6KN2N/hvY6IszJI2p9DHyAahp4yB7oxyQrTbCorLupk8xkGRb7f9YDhGjlC0mDh2xiVkClrJexnFjm3yt0S2xoaMX6VHphMXeIaDW9x0okPsnaUnJcOO0f445ZQfngTYelz0w2YmanWFM0b8spg/jdHfqG0EQCHKSijrn815U
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:58:40.2263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aef197b2-1bbc-4c89-29b7-08dc5fafa6e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5901
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

If the BO pages pinned for RDMA is not contiguous on VRAM, evict it to
system memory first to free the VRAM space, then allocate contiguous
VRAM space, and then move it from system memory back to VRAM.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index ef9154043757..ff7f54741661 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1470,13 +1470,28 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
 	if (unlikely(ret))
 		return ret;
 
+	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
+		/*
+		 * If bo is not contiguous on VRAM, move to system memory first to ensure
+		 * we can get contiguous VRAM space after evicting other BOs.
+		 */
+		if (!(bo->tbo.resource->placement & TTM_PL_FLAG_CONTIGUOUS)) {
+			ret = amdgpu_amdkfd_bo_validate(bo, AMDGPU_GEM_DOMAIN_GTT, false);
+			if (unlikely(ret)) {
+				pr_debug("validate bo 0x%p to GTT failed %d\n", &bo->tbo, ret);
+				goto out;
+			}
+		}
+	}
+
 	ret = amdgpu_bo_pin_restricted(bo, domain, 0, 0);
 	if (ret)
 		pr_err("Error in Pinning BO to domain: %d\n", domain);
 
 	amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
-	amdgpu_bo_unreserve(bo);
 
+out:
+	amdgpu_bo_unreserve(bo);
 	return ret;
 }
 
-- 
2.43.2

