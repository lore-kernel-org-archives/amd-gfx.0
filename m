Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222DFC5B552
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 07:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4DEA10E7F4;
	Fri, 30 May 2025 07:55:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eowFyaCk";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 229BB10E7F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 07:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjwaAiQw3IqYxlQmNmCph/L0+zzJIwSbC77G4qmeFwzSAOl8+ZARcKK687j4t0Or2p9W5t50G3TrmHE4ue61If5sDwolVZ+tZrNGFLWXmpSBIHaTc+g3D185rWlZx9hdltOWGlZIYTPXoFwtCqtGACONEY0TwWxztYBszrif2ucz/03BFZ7VuqwWYEqPe++yzMTIwIDmBgTyEb0rU7J1/nlh9nRxDB6FtC9czlSGJ1ZuQvgnY2lOMUZgogluEnWKJgUGLFtznjDW1PNojVswZPA3/uH41mn986DnxOavYQsJOk+o2QtpTvGaTWGjmakm9y/K3PxfoLzhU8JkDViLhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0MVCb9X/+HML/HtCliQMch8mnzL/VQMQvwT7Zuvn0U=;
 b=VtZLeh2BGpof42thPL9Tpd5N15PFV7IsW/+Opl5shiSq1LfypfiUKu//pW/f6Xu9faXPjVOh2CzUPachTjSPlEALsJM/ZUjtp7mUALM7QSvU6QsE++FNwRdELB4g7gG0FvnUe6ldXkIfw6NNNYhvEoyLHRvR21Fatrj0tq6O+PWdgkzz9vIjSmI2yO2+jdMyd3njd35muhUUW3a+REYx/TFGLV4cMit/LGRZoQKDZlzKe4D9zoTxpCfTQdr/YF6YGST1RUNWatzedj9NUUnmW3mGwEJ45pemO2TO34hDYO3R+eT0WP/yrRk2stP3uZR71XCGyUXeD+yajJqQvC+iyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0MVCb9X/+HML/HtCliQMch8mnzL/VQMQvwT7Zuvn0U=;
 b=eowFyaCkps0FZDYYVcBLmxDQwX92nlf9Fv6yiQPHeELTHn3jFbIzIp6zdS94eUiPcW8VB3kRBu0zscl+nw0itrn9bsJQHRVVwQt/cYn8jX2QqVgj53gicWaA3CGvvKhx8k1wGDbhuIgooQiMhk3Wg+i9fL7c74ejsXpFWcqD1XM=
Received: from BY3PR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:217::20)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 07:55:32 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::8a) by BY3PR04CA0015.outlook.office365.com
 (2603:10b6:a03:217::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Fri,
 30 May 2025 07:55:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 07:55:32 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 02:55:30 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 9/9] drm/amdgpu: validate userq activity status for GEM_VA
 unmap
Date: Fri, 30 May 2025 15:55:05 +0800
Message-ID: <20250530075505.882004-9-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250530075505.882004-1-Prike.Liang@amd.com>
References: <20250530075505.882004-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 7664f543-ae5a-457e-2bc3-08dd9f4f5a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pVE8k09zntEFQwlY+AUvqvS0nQ5Dpl1nBLBIJgo/qMq2Adnm/2Viq4E1tRRp?=
 =?us-ascii?Q?8DVNETzgXsHTGiplGZGaA4DH15bouhc/CSAXhAOlEQlOQJkDkEwdNgv0JqHU?=
 =?us-ascii?Q?1hGvGaysVQETYJycwgy0t6DpwW6DMlVyLZWMrSg5MDVnjuNToSSBDThmWXG4?=
 =?us-ascii?Q?ZmzX3K8LoeHFfda4HleXjBQj98eEcJftqOpCfUutiHIeSLYOOugV0Lve7u60?=
 =?us-ascii?Q?oWGyav6/p7dqmAOsrXpBZdplx820jKdiF0ra5rzs6+Rcy77OG5z4Fm9gbDyb?=
 =?us-ascii?Q?F2SRPsfcxDxvK5jOt66aTIxGVotzbvUTHBqxwvffuXT87gDnP3qZqxjaW/tj?=
 =?us-ascii?Q?geab8YhkBE2FIfFF8A58dmgVqwzBygZQEVg0nfx9IIm2fztWcRlbNy0v7OWL?=
 =?us-ascii?Q?+BBVjRb4j6riYza0XSyH/btleUzm4ZWgGR8qQe/Gu0/iAyk1Xx3rVkeKeDV7?=
 =?us-ascii?Q?IIttIu5D0w+uuy8Y7x7acTSGeLC66xBBDxK/1nQJ4IeJPoqEgqjtR5A3JHCU?=
 =?us-ascii?Q?SuwZ1m3SUjZL4NzW4GVoqE4IQ49IIG1U2yeNj2+ID9N2KOx39ey5+9s/cgiT?=
 =?us-ascii?Q?goALfvjKEt9khPvFOOxCGX4ur5QlXR17qhHTj5YuAD0tRK0WUzVs1W25GIXB?=
 =?us-ascii?Q?79/PxllzjR+eJTJstYG7URhzDrkenCbZIxI4nfGeP+Cxica9u4q3zh3/8lGA?=
 =?us-ascii?Q?JBlME/JWFdPHf2wwEYbeqyNS9k3qegZHpTepj/yKXPzf8cyChJBRCGcLl6xB?=
 =?us-ascii?Q?2zf/bQp1Lt/3GxnZhYtMIXUuOeoKuWvMOAKU1xHZUdaGZe45o17itVC5WK5A?=
 =?us-ascii?Q?PF/wsMspBa0uyNkYk08sU9zOU0O7mXodFIPUiNX434AptZL99ehh3vz3F2De?=
 =?us-ascii?Q?BvL5owUrYzxf7IuVXLSIZv1O8L/AKmhiTvROIkn5flYrQGrMWtIv7visAjH3?=
 =?us-ascii?Q?qnLbup2YC75RPZLYQlPvV+5iIsgRbezpULP880rX+Mat+Ne9ijpDGfaglc/1?=
 =?us-ascii?Q?yNTzCZ8Xk6v+J0rpMqngaZAHYQCndjo4YY9TXk+Btw9LGYJqxACUdE8KHMcA?=
 =?us-ascii?Q?OjpMVQKCfgmdJggiUjbqGnF7dLngF0ZMn5BCqXMUIBbc2VNl53iYe5VjKPOO?=
 =?us-ascii?Q?wn/vsf1hUMqyTnjonVSGICMMBGkU74CmfPQSEfvvlotkwgtIfZUJ25Ytrd5H?=
 =?us-ascii?Q?78J9yBF3f2RwxBpp7clRfg+5Il2y9Cz11M6FS4eRRIs0HAmr4pqrj70aBMdM?=
 =?us-ascii?Q?zk6kZUD2vn2LgjMT/QsfhKpPVEIxrWGU9oAj41rk063DvzvGFsbJ11wghXe2?=
 =?us-ascii?Q?WuIYuKtRufFH3xaAqC5yuqC6PxKhea954sq3BSK+eagAPLhHDqwQZUG7ePz0?=
 =?us-ascii?Q?CM3s0L5+NH1vHH/DrFz1ra+fYEBW2Whtc/Folc3YtQE4xXqHtiv6N5QDjawO?=
 =?us-ascii?Q?Ye+gb7dhEgLrT0+KMasLqcikwvuhRQxdOQaLQOR2LYjslnfVCsG6W1hq3Bn3?=
 =?us-ascii?Q?ymelNh64p5QYCFSr7fXL/sNT8Qki0NLnXrnv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:55:32.3208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7664f543-ae5a-457e-2bc3-08dd9f4f5a6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407
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

The userq VA unmap requires validating queue status before unamapping
it, if user tries to unmap an active userq by GEM VA IOCTL then the
driver should report an error for this illegal usage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 +++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e43a61f64755..e2275280554d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -234,7 +234,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static void
+static int
 amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_usermode_queue *queue)
 {
@@ -243,10 +243,14 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 
 	if (f && !dma_fence_is_signaled(f)) {
 		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
-		if (ret <= 0)
+		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
+			return -ETIMEDOUT;
+		}
 	}
+
+	return 0;
 }
 
 static void
@@ -464,7 +468,13 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		mutex_unlock(&uq_mgr->userq_mutex);
 		return -EINVAL;
 	}
-	amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
+
+	if (amdgpu_userq_wait_for_last_fence(uq_mgr, queue)) {
+		drm_warn(adev_to_drm(uq_mgr->adev), "Don't destroy a busy userq\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+
 	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
 	if (!r) {
 		amdgpu_bo_unpin(queue->db_obj.obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 5e075e8f0ca3..168fc3835aaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1930,6 +1930,11 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	bool valid = true;
 
+	if (amdgpu_userq_gem_va_unmap_wait(vm)) {
+		dev_warn(adev->dev, "shouldn't unmap the VA for an active userq\n");
+		return -EINVAL;
+	}
+
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
 
 	list_for_each_entry(mapping, &bo_va->valids, list) {
-- 
2.34.1

