Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9CEC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 16:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2892410FD1B;
	Thu, 18 Apr 2024 16:17:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ExHdD+5d";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1096E10FD1B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 16:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLfRaD1e0wb6U4r8sftMHX6grYQCO3cydTP3EijpNK4qGv15lEoy33a8y2CndloZvGOohk1I+Ycjp7LuKPxpnLgkCgFuykS9D8AiHQ21INYOoQ18ANKjRfGeDOHDeCgw2mBU3T65uZ1twNxBVax7Hn4RVy2u/4O5cJaQbmNDb/r9lMVFMFVzxXsZpcvh0am7tKJEhUpLjpxhfsPbDC2I8UACUy12zE1/grpEQp/a2uMMBgGUGkdkwzqkx7Hoih7crx4w2ywXlfl/jLBQHs6VpfXxTpQ+F3bc5+EOoyDAq/0ehhunlLwxojLA75b3MnJnf8LeAdLknJOEJUZtSATwVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCA4jsiacYRWDbdWH3+VLfzicol4uSMCbRiOxT68CY0=;
 b=lqlnM50CJoz7ZToYsecjd4o0WHNAMwKNmefcMQn2+hCvSP4UINkQ3yzX1of/xevgqzUjFVnz975WBRzaLdr4UKG9P8rV9kLsyChXYjlyqPyLVPGPU1yEx6MHglZPNV3J670eoTKZMTPY6sGour2fY5dKnAmRweKIhnKmOUU/wJ+D58LaYQ2m4xjGQcNMUc206V5v1GiMy1IpvxNb/Qd9fSeSrSYPfC2x4SIgaWjQ6BwDFIMSBMRfs/CE52ckdjlMbqm2XsLRw7l3ZXXw1B4w+ne4K577xqsaTv7ReZlhjCWRWZHMDa6bTj0p6H+ouzqofs1zc/8XFXK8N5VXmP11xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCA4jsiacYRWDbdWH3+VLfzicol4uSMCbRiOxT68CY0=;
 b=ExHdD+5dua6G32jxAp3Y0onnx91MFwsYHVUcXN3ZfBGBQ2W/SFO1EvOHNp6l2Y8+mLoB5teKc/MVvSEAgMw3/Yne7FeR8V5Y55zrxnVnfr4zavImHI+UqdzFvhWTBP0ma6uObOozEwDBYZ98gpca4Nieick+uOFlM1570R32aJw=
Received: from BL1PR13CA0337.namprd13.prod.outlook.com (2603:10b6:208:2c6::12)
 by PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Thu, 18 Apr
 2024 16:17:41 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::72) by BL1PR13CA0337.outlook.office365.com
 (2603:10b6:208:2c6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.11 via Frontend
 Transport; Thu, 18 Apr 2024 16:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 16:17:40 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 11:17:35 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH] drm/amdgpu: Fix leak when GPU memory allocation fails
Date: Thu, 18 Apr 2024 12:17:24 -0400
Message-ID: <20240418161724.1214480-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|PH7PR12MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c87627e-bcaa-409f-6e83-08dc5fc31225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UEwtLskU0feRHKtApn0ysb1gncAj1bZbLbwLZX5yzwhOjPqVvsmW/l42o93DBcbpkujMRtHBRnLyXdwD+C204xuRSkXgmBrUcMAJ6QFLtMaNeGYPQZKST21uWuohYWxdizBTJL3Ll3jnEUrbKUNQs1R3/dsZHap2sqw+WyrTB1z+7BZ9JjxPbL0RIK3L9rtq99NLjCyieIxiK72gGSmkwNwg9YZjiddYpe35PnItymZ2TYZSZleCXA/cWSlY5FPxT79H/QYPeISZ1G3r5VCBti41hoF2an0wffMfhFBsPoFxzSI45oRA0uhsyblA5DMJ30fmMidcjaFZTfqQE3diQys2XpQSACoXObJQFfSEWhlMgWbMYNbU0a8bYrDfv1+xNrXcpbqupNyvvbI2RpjvdXK75RjXYU7ffSWYz4v/QCKAADZmlaFf/DLb+FFKnpxsHSXRscpTo4Wy1AJ1jpQ2Gwkn/XIEMC/Su/gaC1brWZ5gorwTmMCHc+kW59A+BY1jFMdK5ysCe4PzS73PKePanHgfJK6mfKw8XbkqGPCciRQkOTlWwvat8tzT5CVPhaNQbEkw+IFL+C2Svj7LFGNf577zZ0onp2EjIPBimtWwz/TvIDkYRzxaCwzbMxyTreI8emIqTwqoCQsFtnkpFOtHR/oKk8/ie7Ew0iO5aR2xYhoPxJ2AUtU89yVWC5aMdHc1IcIuJ3tRyCRnop8w2MTT8zD9MMd4o8j1rAyl4xq9mvdXZy+O7XPqvk47UoKFMeJg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:17:40.7003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c87627e-bcaa-409f-6e83-08dc5fc31225
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7988
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

Free the sync object if the memory allocation fails for any
reason.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0ae9fd844623..bcf4a9e82075 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1854,6 +1854,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 err_bo_create:
 	amdgpu_amdkfd_unreserve_mem_limit(adev, aligned_size, flags, xcp_id);
 err_reserve_limit:
+	amdgpu_sync_free(&(*mem)->sync);
 	mutex_destroy(&(*mem)->lock);
 	if (gobj)
 		drm_gem_object_put(gobj);
-- 
2.35.1

