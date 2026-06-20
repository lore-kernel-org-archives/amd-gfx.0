Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46162CD98E4
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Jun 2026 06:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF55510E158;
	Sat, 20 Jun 2026 06:15:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2WSQ2Ma/";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20CDE10E158
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Jun 2026 06:15:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJrvcEnjuNbQQwEeSKCNv85cPSRNTliJJH3f0X7QwtOnuKcfn+R1/kNDYf66gcDiKUuAKdquVxuQlVemFEL8eC4wYL8o3vEiUivnJOVVaL6lVZj7rlWrVz/3dWHEX42FAnHn2dZe0CzE6C7xII4rlvdLCJ3fWvr2aVB/9678ug1i6ZSzarzYnEv/XrzvyQXMZyJEPg6RZlnif/zI+9DwQZOueRbjxuLGPUIFT1FjTZTI4YB8YZxw0TZpH1PtGaBhy3atrXwzMvt9+8z0WGmINMTbY4SlplcFNIAutzoDUhxbmaizDZXCrnX632ChJCdNPiPt5vrRdunIhwQpk+yR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnfkFlAM6ndPIgzj+Q8PMaeaYfV65G9kmqtImJwei90=;
 b=Sqe2Egb/URMAxJ/+HEvzhuK8QXiODyt387oJMYT70ez/3P2lhGYtXK3IqDDAa1awMbVjS6gHbMZl1qAEvKRBRdyktgWoEPJ1wUGUhziXp+M+pBG4ywgBvCygOBd2VgUaf6UbQ+Dq7GH/Rg3nHLR1nw+TFWW+kiNgLfMKl5nvfJtc6OS/bEOIxkfetsUm76ajTtFde7WNK6b7uGglKPQNpBvRKWvtU3iVsC8yo89J8+aafxN8/LM8hLO1jHfGTvPme7g9yxB/RWa0stPBhiO9/DuwDHL5En3G1/VC48sT4p1AXIuvjYBMRmiFYoRIGtmkMbbsCDzZXcW+8Ly2Q+5h8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnfkFlAM6ndPIgzj+Q8PMaeaYfV65G9kmqtImJwei90=;
 b=2WSQ2Ma/E7zipAU+X9r4hyWl1ujwnXfYxvEmcfiNY2rIbrRU9devT1f6eWApFDTB9YMkWw43dVORl7dNmvDtjH65XnL7FIUUkbyQ/Vkyg3ISlIeU7iDskNfQ+dGn13/4O/iJ9IAx9aXp2ffq3z2KkEN6d8xPi79bT+KcNbhsqhM=
Received: from CH2PR18CA0037.namprd18.prod.outlook.com (2603:10b6:610:55::17)
 by SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 06:15:25 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::c) by CH2PR18CA0037.outlook.office365.com
 (2603:10b6:610:55::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Sat,
 20 Jun 2026 06:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sat, 20 Jun 2026 06:15:24 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Sat, 20 Jun 2026 01:15:22 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>
Subject: [PATCH v2] drm/amdgpu: Reduce stack usage in IP block soft reset v2
Date: Sat, 20 Jun 2026 11:45:08 +0530
Message-ID: <20260620061508.2999892-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: ee27792f-76b7-4113-a328-08dece9350f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: rwJZdWqYaFjvmKcRTg0CG2LC1zuDn3gzCfBY5XMD6SzP+N11DKM+KK1PV3WwKxa2CztbNz+byjYSGCaKAlDbfuX321COSghPj1LdcLiURtReqaJioLN+ovnK39X8qKNhvxnxvvRbPFjlV3OmE5tE/FknQo3+v/nyAluFg79hLjeQi4FWvepS6epiJ6CwkM2TmtgJxt4P7ZAxV9M8LvNJ6pVyTaRNJJ/VZl1seSDsiNbKy4eWdnQCb1t4HXy4Tr9SCq9r10/FH13dgKLmFGclVRtJ/X4EGqJrwbvwwMKZ14RyesoAei+zj1oTI8U1omDcuefrQxTnmRbGU+AqQzj4vLjrEmAAS0R/giEe+0zCQ9eAGAXbvuJWTkQgDrkY1oJj6sQkhGgHwZoPgImUkq1uPVedhNrqSIT4NorgznzT0qlvIwVaJG7FhTMzWuxQhorajzermgEGLavOs4q6YwrD68KHYp5KBz+M5tVaUq3g82v0DhhiuHWzxWKFf9qh0xe8TsVyKIH9eYWuDrQRGsdtDZIruCVFIb+LzqS0oAQZiBNK4ppdgk0/aLibBgio5DHopxS/23igPrxAdlau7c0iHWNPyRfZG1mgFm76dI6nAygwbwz45wa5JbDM8lSmcaauFoY8EurHQVdTJ1cCGNkfnw+ncHuXgu7TF4/xE+kWyNaasdkgqW1kIQrdqXMODJjld9QhYv1UGSLQ06nAFud6pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DOIpspmlNa1hRmPkdXke7XS6mDzpDPoiOPuIvBsLuJh9oCL5FLd+5s7IQW/NvVCx4gotwrO17CaRVXrzM8eiHHaWY/EyLQh76kb6HtArHoKcOg09p335SN844pa3PVX18EOVmCjQ28Pf0E8+uFoTtPnJDmE5vb4jUYbq76dmPV5YP3k3/8ByhcAooInYtB3hgEdoQo/l9q/yDqHgIsDkr5mug2l7Wu3zy0og94cSjx5ZBzTE4k9TXNSa0yW7Ce7kIIGOIMOESX2FRs3nWdLa/OGZLEPGEklIYLYLwaciGUD+YiNBAkVfo8Cq3aQXAW0NW6dxbo7fjImOFS/YhSDTX/VdXZpKqWLF8tKHC/aG0VmOSvSaM2UCA3JBlikWVnQy+z9O3GKRGnRjkDgWM+FzsuQXZPnFf0ypNX3WuuYTzdat24vPSExxSSxhl+n7fmfh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 06:15:24.6853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee27792f-76b7-4113-a328-08dece9350f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978
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

amdgpu_device_ip_soft_reset() allocates an array of AMDGPU_MAX_RINGS
ring pointers on the stack. On 64-bit builds this consumes around 1280
bytes and triggers:

warning: stack frame size (1304) exceeds limit (1024)

Move the temporary ring pointer array to heap allocation to reduce stack
usage.

v2: (Alex)
- Avoid allocating memory in the reset path.
- Use a pre-allocated ring pointer array stored in amdgpu_device.

Fixes: a6319ac34a13 ("drm/amdgpu: Add IP block soft reset as a GPU recovery method")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h    | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c | 8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4c3e933ff6d5..30053ca3b92b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -889,6 +889,8 @@ struct amdgpu_device {
 	u64				fence_context;
 	unsigned			num_rings;
 	struct amdgpu_ring		*rings[AMDGPU_MAX_RINGS];
+	/* Temporary ring list used during IP block soft reset. */
+	struct amdgpu_ring		*ip_soft_reset_rings[AMDGPU_MAX_RINGS];
 	struct dma_fence __rcu		*gang_submit;
 	bool				ib_pool_ready;
 	struct amdgpu_sa_manager	ib_pools[AMDGPU_IB_POOL_MAX];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index 65505bc50399..c8af5a158cea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -524,7 +524,7 @@ int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
 				struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = guilty_ring->adev;
-	struct amdgpu_ring *rings[AMDGPU_MAX_RINGS];
+	struct amdgpu_ring **rings = adev->ip_soft_reset_rings;
 	struct amdgpu_ip_block *ip_block;
 	enum amd_ip_block_type ip_type;
 	u32 num_rings, ring_type_mask;
@@ -546,11 +546,13 @@ int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
 	amdgpu_filter_rings(adev, ring_type_mask, rings, &num_rings);
 
 	amdgpu_device_lock_reset_domain(adev->reset_domain);
-	amdgpu_multi_ring_reset_helper_begin(rings, num_rings, guilty_ring, guilty_fence);
+	amdgpu_multi_ring_reset_helper_begin(rings, num_rings, guilty_ring,
+					     guilty_fence);
 
 	r = ip_block->version->funcs->soft_reset(ip_block);
 
-	r = amdgpu_multi_ring_reset_helper_end(rings, num_rings, guilty_ring, r);
+	r = amdgpu_multi_ring_reset_helper_end(rings, num_rings, guilty_ring,
+					       r);
 	amdgpu_device_unlock_reset_domain(adev->reset_domain);
 
 	if (r) {
-- 
2.34.1

