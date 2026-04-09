Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29FAF31E24
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 15:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E1E10E113;
	Thu,  9 Apr 2026 15:03:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yt+FJxtm";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDADB10E113
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 15:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SO9fzgB/9NCcd/9sXiU6O+djbjKEpC2nfgshiEsHfeN7MFx/p7RII40dFJgFVt/ebcu6zXnJstc7oJOIkpY+1P8jXnMSBMttLoMYfZCTUcJFk3ApagnXfDBNnxEuhe7iTZaTUa2cOqLtnENDy/z879gKpsICmZ6yTOOg359ulrg19YRDfffMssH/9E2c6F7JqTjikOcLwbtL7bFuRD5Wo2u+78tgTJ6L+mDBFXa7r5IOtVbB/Hut2t8tMqXrPnrBqg0bcD00rifBDdWTDfcYh8Cv4CgqozoZArA19q7y3Cti5vh9hEy3TFgcMqJD5OlEaA+QET4+Dn4q6IP2YC3h9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1r3vePLEnF+0yrJZXEQ/M0KDaYtMkFkktOq8maY5Hk=;
 b=exmY1lqJsqH7OpmXTz1ZIgcMc8jDafhgHx7youQKU7STUF2M1mVIe2ORIpnSk+utlUC+PPMSvhN4Rfc+qv90j2Xzq6WEA6bpwsEYmqVfrKA9BeKWIgYuN3px23fAPLWfNOpDCZBMSxVQq4JLpWt4bo6+PsCjIZtc2nbIrtjktikM0NaGdlO76QtDhUN5+lnwIkXo7ANDy3hr6V/2DG6r+QTMGru5c9unDvDMPdy63dbcmiTyKXYUNVJ6wjD9i9oG7H9VQXZ3mSYGkF93UIv3YtMUEp3NdC98MQ3U50cUQk4jCMDDdR/XqFLGMMZ+hkU5NmjsHoV1X7Wmh/3jTmYV7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1r3vePLEnF+0yrJZXEQ/M0KDaYtMkFkktOq8maY5Hk=;
 b=Yt+FJxtm+GnME2kwjj3RrXHJhAsiFoPVTjO2GN3hcfD2xHDSTHkeK6ZQ7zkSy9J8TZReVhI4sIqaW+cmSJck2+OpVb/7XYo6D3CGVX6u4lO2fKaj+sxwq4CKTtqlydvaK3PK7GDg4vHkk5qdoWYIcujxIjiqG58IlyV2cMaPLVY=
Received: from BYAPR21CA0001.namprd21.prod.outlook.com (2603:10b6:a03:114::11)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 9 Apr
 2026 15:03:22 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::fc) by BYAPR21CA0001.outlook.office365.com
 (2603:10b6:a03:114::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9818.12 via Frontend Transport; Thu,
 9 Apr 2026 15:03:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 15:03:21 +0000
Received: from amir-devpc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 10:03:21 -0500
From: Amir Shetaia <Amir.Shetaia@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <harish.kasiviswanathan@amd.com>,
 <christian.koenig@amd.com>, Amir Shetaia <Amir.Shetaia@amd.com>
Subject: [PATCH] drm/amdgpu: Clear VRAM for all user mode allocations
Date: Thu, 9 Apr 2026 11:03:15 -0400
Message-ID: <20260409150315.1441442-1-Amir.Shetaia@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 56042524-721a-4bb0-ed1d-08de96492442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: yVHb7R9imYi12MJa7JpnqbpF0kGIpt0HibI77jz9sTtC0rzi3c/0Lhm+63r8OIeGFq+4Boeq4Qd4RyJWansp6MTFXOXvb5g0W9LElit7cw4cFN0G3pdJdlZa5AWEcuxPa/BjRNDVCCUOYGw9wK/7mXR18MJ2iSTQLSsXk3CgEjucPOR6xouc0J3zRS2t3FEZiVnVrWP844+MMisWM9DdWED0bZAEDgbSQURXH0TTGuD6BFIFrC8lU0/UDKfnFAnPRBdaTQ354KLMucvSlMm6aE30C8U5sAJUrhEhfZB6VDDABkE4z9NHH2eSGB6UwxM3/xb5yGqnHqpRVzeJFj6aDr2j7IqtwU01gtlumSHYV9j8aT75daJow6iydNZJ3ItzbxAPFAWaLsaxhLkBmLxwm4t/L2jer47EMJG5V+UZXapcZV2S7S6uHwuAeM38f/PnkaXuWz+iu/MaHegbecG8ucDxoYskgpTLbryjK47tMXCFPExzKlk1YX5dvv92aR4tTr3WbZW55cd9B8VXNQy0aLtNx2juGJbiRt3hZu3mLSud+ai/v5jUd2d3I9doqfyu3X8Bp54iov85hn5d5QL7nr+SWLhE1p4T3bxgGDSwBRIec/WywTDc9ltWVRW2+8yKpEAs0raap2U9vKtM9XEomFuCDOi6Ln/wJ3sG8uYDM90qjT1gvec5KOey0RhfnTupRTFIInPytS9BdiNIFrhDINuVB39BmBKo+TJTFzldtoll5d7ReH/1A6PN9fvLS2IyL8DuD5GCPKmgzzsk4S084Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gwy70HrVt5Ew70G2PuUMEIf4an96t5cHKCuYIHAZoWe3zbEJLNWo0+NsINU6kMuZNVlTXC9xDYN6jjKwKFJoBTx9l3W64UDQZWbR4FYUCxOrS7M8dEdWKQ28w01VyY2mDhmHRSzjw9qHiTc4/9Uv2yyCl+Oml7LZzuYMRpPbJLnfw01R/m0kXXF8izmbXQrYb2utPoT+fyhv1FpJyjt+lRAQJO++vGcaQCAuxEof9trpk43Hw79y7T4zY8YMba0A0NO74egwjGN649MUCP9uEyG2sPPPWGZGTw1RIVMwA57IYokr56nEv4U3scQ+lP6WSa6DIXI6Ol1XTbY1sKGKDPKAFCTf507t9t7VRqQqYCXC6Hl6pK3GBvESa4yfsdslfjSw8zrGyLzclbL0Ndf/lI5wnVyIB6fTyLdWBU/sLVJnAhHYn8oCBsWDEChQzaiN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 15:03:21.7225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56042524-721a-4bb0-ed1d-08de96492442
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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

amdgpu_gem_object_create() sets AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE
but not AMDGPU_GEM_CREATE_VRAM_CLEARED. While the GEM ioctl adds
VRAM_CLEARED separately, other callers such as KFD do not, leaving
freshly allocated VRAM with stale data observable by user mode.

This causes crashes in applications that expect zero-initialized
VRAM, such as RCCL P2P transport where stale page table remnants
corrupt protocol handshake fields.

Add AMDGPU_GEM_CREATE_VRAM_CLEARED alongside VRAM_WIPE_ON_RELEASE
in amdgpu_gem_object_create() to cover all user mode VRAM paths.

Signed-off-by: Amir Shetaia <Amir.Shetaia@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index b0ba2bdaf43a..c704bc53946c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -175,7 +175,8 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 
 	memset(&bp, 0, sizeof(bp));
 	*obj = NULL;
-	flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
+	flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE |
+		 AMDGPU_GEM_CREATE_VRAM_CLEARED;
 
 	bp.size = size;
 	bp.byte_align = alignment;
-- 
2.43.0

