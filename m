Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF1DC3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 17:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74B4210E693;
	Wed, 28 May 2025 17:28:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fq4t5Hsq";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 240FD10E6AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 17:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIHt3tPhSitY9h9EQRq+ljK98QGLgFVJQKRtpmqI9JroL/yFuVqa8uM5liWDTApX6XfdGATQrvwuLSNpSDv4wSIiNf60NKhK3G/8PWf/QVKZHm6FvOqCjtXrdAGmzdy/qRvbGZxuf1N7W+/9J8GZeFMvbXqcG1cvbU5XgIsqeuRXqLqS42FFkru7pwwrgYjZs80vrwyXcu6r7dzG/Hv1kOuRadsOmnr9pjCnzK/UxHWdymZ5tzGRdfObLNDslnGS48/zjZy0ejpM+qmW4OjXmdt+lNBbuwWxFvEXYE32bijzzSRCRQ/qTBu9ulhePPuL0TI+afBHmi4SUO4ocA/tBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaQT2FeUGd2GUYTDHAEPf4fKErqeWaKGwVnpxX7Wnc8=;
 b=RtiqhvRYO8Ntps8LTehREIkJc66twZQOL8QV7BA4gedWuLfTO4cTsRsFpDVkhIhwEGeSpqyFeMJYo0xtm+I+fNe3Do8E5Ht9DLcNHKS5w2EZKUP3WxYPLmMeYGjYF1kAOPMEnyGicua23/uaPV4x7qrNQX7BVYYPa4oAJT0UFg0UGwtMbX8awr85O3J+GCltKqgcIP2TkXhdqz8zY2gPZ6muCJ4kgK5zPTOkwEbyQf7VM7nxA2VsEgyMvFWGxxsll5ltuy5JvuoRPbdjqXkIdS3kcrZyvu1YquukmlSzRqOjNOJ9muuOCwEuz86e7fniOq+klx0wznPasB+GOjb1tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaQT2FeUGd2GUYTDHAEPf4fKErqeWaKGwVnpxX7Wnc8=;
 b=Fq4t5HsqkeEn+Icn6kfbS74MbRGv/LwEdJk1z+bCs4msOepStcuBd5a5k/21A3YYkK+IBYAJzRvkKnbioEtn/CDp6kgO8vy8Mbfha1D0lKGGnCXcAoIpyoJjHxPuHEeA7EEQljvQh5GaqVL2paZ/cku0mreE7LGFDGpGPP1Snow=
Received: from MN2PR18CA0004.namprd18.prod.outlook.com (2603:10b6:208:23c::9)
 by IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 17:28:26 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::35) by MN2PR18CA0004.outlook.office365.com
 (2603:10b6:208:23c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Wed,
 28 May 2025 17:28:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 17:28:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 12:28:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/16] drm/amdgpu/gfx10: re-emit unprocessed state on kcq reset
Date: Wed, 28 May 2025 13:27:59 -0400
Message-ID: <20250528172801.34424-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528172801.34424-1-alexander.deucher@amd.com>
References: <20250528172801.34424-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5d5995-ec68-46a4-a09a-08dd9e0d0dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LmrIq8N6azWqJHrVcnpiet2ZWbr3MijPpNBYmDpNqisQ2TJToowFKmtun3OI?=
 =?us-ascii?Q?pykMF15bLv7XWcxDHHRRKhO8BvaFqA3o3RvbLJg5099xv8dkxHrlD7eTvNQP?=
 =?us-ascii?Q?9056s9UZOgA4l6yJhJk6pqus+yNVWTYd2YyNTs0FG4m8fHn6yyJGyILeRgBE?=
 =?us-ascii?Q?EN+AlsaFaDlFThtkXZeLV1sX+vbsZvqZLujWnyiWdfCTzen6r68imdy4g9ha?=
 =?us-ascii?Q?7X1Rs/UrpOLbE7cSDsznoy/ZofEqYwuMXZETTEQ6nZw+sWfBSPOFj6uW5tkZ?=
 =?us-ascii?Q?GmbO9z6amN0o3FrFolX5KZO7OMaMr/ciTZ+Za1kt59iGchTuz/KWzO0m6AjJ?=
 =?us-ascii?Q?Q8I9uDq6kYwLnj5Nr9PKKQMkNQD+sfdtd6olds/bKKAYD5sxuEFhls2SaHLe?=
 =?us-ascii?Q?kK/HS1oWDJqXpqiVfBLjhnG/udjplCYfFcufK1ZXg9tSdsOqaKAdyNd0PUBZ?=
 =?us-ascii?Q?ZIS8qYAjjKM3gnUpWZMMVpa1O1IrneuYqzoW6gv6A1D9J6HxT+GiplX+bdOW?=
 =?us-ascii?Q?7GCtfu1N03rpRkxVQdUX/BbeHbM+rbgBYKNcn3ykigh95PnPMOsQYWRgFnQx?=
 =?us-ascii?Q?9ytx6unh94Djs/gZ9WAvPAZ3frjJ6vSVFflkopraEGGrZp0QyOl+59Pntso+?=
 =?us-ascii?Q?BNw0DleXFu6UJIHoSJ3PS1fUMn48f95AALS/mlJH7t2Cf4MfyiB4YIT7MCiu?=
 =?us-ascii?Q?OcGEDL8ebtEyf9Emf/PdAv6Pf+ZnJ89iqH1W0f6WZMQkJxVH8NT+Zi7c6Lpq?=
 =?us-ascii?Q?tbqpGdTtQy3waGlnJ72smbVeWp/BYyjY515IOeGBUlgqOk2R6InGR4VCGFWv?=
 =?us-ascii?Q?mIHt+TxrD0MAAh8DKb5t8aRMANbQVyrtRj2URcVRYNkzqwxAKvtbk5qzXsG5?=
 =?us-ascii?Q?FCR1QRRfoiuYyu9neeQ6p+fz/yzfGta3BTFRA8TDefJTLkt/NRVObfs20Jpi?=
 =?us-ascii?Q?mj64LUZzXITsKmlPcCg3RcaTdGbJmu/Wpv0kMM2bawK4kZEOwD4Fkfv0Da0A?=
 =?us-ascii?Q?lF9Vyz2f918wMs2mjlGjw3fX/Dfb+SzxpfqkJAwddW7SFrkNopCW075pn2KV?=
 =?us-ascii?Q?t7+hJY/ycZYWdtttiEiS8LwLi4/LpZ4w+C00IchGckeq8MGZAGrqlfWpCt0u?=
 =?us-ascii?Q?Arb/yexD4UxZIinK/jKFFYeq0L8fburbOq/M4hJ/Lv+d8fTtIQkX6t/5jj/x?=
 =?us-ascii?Q?lhNclt5b9iNglsPgCTOB/Q3R7oCSYujHbvmCVjYEZ5Em/HqLpHJtXyVZXdlG?=
 =?us-ascii?Q?o1Pe8JrSYh4800+9RUpGw/gTJOr3OFR7XvgFWXsj/3kAxKXU2UOqgQ2rLG0h?=
 =?us-ascii?Q?ysHsLP+lnioRQBecZK6o9oLObFIggESCXVdafrc5eKyE9IpJl+3rGY+KfutD?=
 =?us-ascii?Q?mYe2zggRK9c1ndcu/q7GRTmNWQkVgKumubj3/gqbwKfAcfHP09Fws04npEcm?=
 =?us-ascii?Q?lGQOY1n+BFe4Wmd10264ZIj2yIvr2/pAAmyQEl9FZM12C++lZ/lF92UL6FK2?=
 =?us-ascii?Q?PUEUt6xQ/1ulrMRz8aHPtbmKEFqUfIwNAqLT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:28:25.9363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5d5995-ec68-46a4-a09a-08dd9e0d0dd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716
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
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 33 ++++++++++++--------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index eb69ab4256c41..b006b07dbf36d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9055,21 +9055,6 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 							   ref, mask);
 }
 
-static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned int vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -9662,13 +9647,26 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
+	r = amdgpu_ring_test_ring(kiq_ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+	if (r)
+		return r;
 
-	r = amdgpu_ring_test_ring(kiq_ring);
+	if (amdgpu_ring_alloc(ring, 8))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->ring_backup_seq, 0);
+	amdgpu_ring_commit(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+	if (amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy))
+		return -ENOMEM;
+	for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+		amdgpu_ring_write(ring, ring->ring_backup[i]);
+	amdgpu_ring_commit(ring);
 
-	return amdgpu_ring_test_ring(ring);
+	return r;
 }
 
 static void gfx_v10_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
@@ -9943,7 +9941,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
-- 
2.49.0

