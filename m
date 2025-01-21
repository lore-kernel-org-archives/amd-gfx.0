Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F6FC02185
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 06:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01A1B10E166;
	Tue, 21 Jan 2025 06:50:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pl8IXJs1";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 516E310E166
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 06:50:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLwWuzLQ2dXJw9ma6ZxK5eptuOil/YD2xc/IFTM8TXIbVhx7SFuSeueFhX4B+JdIrLBvvL2UnV4U5PifJjx+4Ju/xQJ8ymD57VdNLyYLqPKjhYQPlLq+6/f+GCWxbOnDLCcdHlazB7B55vp/p6knBclk9AYxrza1onzb7GU/UvJIImgmIXpeHBG5YfbL/5O+Ij9k366fUz6hyR3RsB+oPlrmlM83+/Rmu9goN1g+cDdwas3o8GBSEA4AwA1AoYGcUfAyO7fNvRMO5FetxrqXe8dlH3iPWiNRbB9hI4X0E00D+XPYXBNIegSpReeN165PT3jRz7kNQrK3UOJ7bKKbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wkXVpQN0Yaubsnw19cgpOG3KknlKsAh1ipAJqcnOFM=;
 b=k28JiIlSghH4wwErZG3CDihdq6tcYrf2etvI0dmdJZ1fanBqGwQaOUOWx9VavvqP7XGNuOP2wJkX/Z4wMBfAwQqkjYVcLbpBC4Fm7GvyheRZy5M+tfxINnOaHIP3o1OTkMBRNSk4b5Q0fRuPfT9/884ldA5mRCltPyjrAr9mXN5MYtkf2tmfyPMN4dHmHk9pXoHApMM7dTvqb2i989p3K9UWd5uHo5WQhJxlBKVcB8NZC4UJIZ74MZi/V7AKJR9gIJisBxn0aM/SN7J1BJBxQIQCw+Vht8CfqA3qCxEYKIMn755YDYeRP67tW+ARVE23oJNKvDQmSVreecBLhdYHwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wkXVpQN0Yaubsnw19cgpOG3KknlKsAh1ipAJqcnOFM=;
 b=pl8IXJs12H9E0zD3GpB6eluW69yUkJlelJGsbXh09MIGD6HQM2Ze/uiFDQ5NtNWnI/kJ0Lz/RiDeXRXfaH9yNZyEoChB3+oQ7qP3Ff8C6ZyChFHu10FGM1kZN2HMTDemCONEgJUVTwM0KqeW7FzEfhy/Rm/sSVsLX3isR2njds4=
Received: from MN2PR05CA0038.namprd05.prod.outlook.com (2603:10b6:208:236::7)
 by IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 06:50:06 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::e8) by MN2PR05CA0038.outlook.office365.com
 (2603:10b6:208:236::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.13 via Frontend Transport; Tue,
 21 Jan 2025 06:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 06:50:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 00:50:05 -0600
Received: from primary-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 21 Jan 2025 00:50:04 -0600
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, <lincao12@amd.com>
Subject: [PATCH] drm/amdgpu: remove variable vm in function amdgpu_ib_schedule
Date: Tue, 21 Jan 2025 14:50:02 +0800
Message-ID: <20250121065002.1143246-1-lincao12@amd.com>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lincao12@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|IA0PR12MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ab14bf-93b4-400e-18a9-08dd39e7d729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BKZi8RjBFXM1kuZ4Oh/qJUi+k0QiFwnlD6BuSa+ryQ2nkFpbr6hxhjFgnUSA?=
 =?us-ascii?Q?qq/qx+ZR/kKTCsBd/6Hxdd5t8SarqgbpzAjHSc4dDMiqJW1SOroirxmhsKis?=
 =?us-ascii?Q?+kLOYftSt/R0UOielW+WW1JvoQqaBnSDf/hCu+oGjrZQFQG/e0qt99vC8l2l?=
 =?us-ascii?Q?GvCLa9jNUbSTTabkp6D8pAeHqsmhWHM5M0rMtZF2wd7Id6yKLvoJRJFAbNQB?=
 =?us-ascii?Q?1m2pvl7oGnEWi7YxrFi6UV98FsCgwVb+fw1ml84YP+1qZjm7VOtDOkS6/UDn?=
 =?us-ascii?Q?/ejTTJsTz9iRYubGdRncNyiigTMR7cI1vSD7zZUePt3ZL0+pgSqSLjfJjloV?=
 =?us-ascii?Q?4lj1NWvcnBTWIRjmMYAq8sii9G8nxLl8fEgzxJJaNL3s964cTn3R9VpSYBZz?=
 =?us-ascii?Q?ZxnPPNE5OOl33axhwIJarY+j6eASdm/GF/+JILz3EO6bRg73NmQ7Ye8aVFvd?=
 =?us-ascii?Q?qCVBU5hwuPxbF9Teo+Z0DiZKAnqhzDFeCjvmURRfB5/H5amtYBRQMmwStNSe?=
 =?us-ascii?Q?fPcENStP4P/CtpQDF/r521rf6VM+KSks39/SJQZ17uQx4W6Kf+eP5enF1mFZ?=
 =?us-ascii?Q?qPjxxU4Oqg1YkVmNtPdUUa8BS0W6k3kO1xeAXkmrBeV7Rm1UBbujII8xR1it?=
 =?us-ascii?Q?saxYdnjb7pvfS3AoDBBtemI3GgF+GlncxU9kHSW8uFMvartFhrP5uYnV24D7?=
 =?us-ascii?Q?7+EPiWwsB1xZ9NC27MB+YOAo2p+ATw23jm7/UFVRRVlD+OCUgySssEnhHKrP?=
 =?us-ascii?Q?GYTP9bjLiStDADV3ja9cYUNYs0KyoiXnJSNci6+o5kbt2ooY4mr40HBb8nYZ?=
 =?us-ascii?Q?bXKjhI/PyrrY6jEjjZEzuSuzlTPW2LgJ43LVUoC5gK6KBG4MSYvLw/+gG2Di?=
 =?us-ascii?Q?r0CPRoYXotjsr6XwJXZGa7lR57nw4AH7WEteeJJx8rx+1qHdhzAKsWQLqglo?=
 =?us-ascii?Q?xlfpBw608rWCQYxsH3S3gGTaKnHWjXuX5gXrwwdn19SF1+cit1rALfmj6kGb?=
 =?us-ascii?Q?hKtKYszI9JcysnAh7f/jtj028zYp2H1UIAvIdNTYNGnVwso+tIXe5LrzcKxl?=
 =?us-ascii?Q?gjcI4IOTMkVjAfAyFT5X9XxvwFHUX2T0k32SNaDZeFgpOAvzmmhIu+7tXlak?=
 =?us-ascii?Q?cag0uevcY89J7kssZqnLxfgO6R3HP5L7lqRI4PXR7Z+zgYodzDtKZm+/VRBA?=
 =?us-ascii?Q?gxN1LALB89kVndqbFiZ88J6nDag4EbDqwn6i8qVE+KYVh17UAsjcOpDbgovQ?=
 =?us-ascii?Q?rU36Yp8o5nTwIGiWiunfbF5JG5VTiu8qyqtMeBqj8w1/3lXgrwD46BfWOFmX?=
 =?us-ascii?Q?9TN5c8B9QZtXD8mg8zPtla+V2WGo+mZWdKFthDukOQQIaMEdgtVjaIPACD+B?=
 =?us-ascii?Q?NLdqqEEnHVTEzCx1ctqE6PS4129JikcpIkG0tUfsxzHx0NN3szECGbCohU5l?=
 =?us-ascii?Q?f/REghLCobKjMEywm9VTAQmCVLuFeu97HgpAVB0IDhTn5eMNCsTCEtFoe5C+?=
 =?us-ascii?Q?NT08g6gSrlALzd8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 06:50:06.5720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ab14bf-93b4-400e-18a9-08dd39e7d729
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722
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

use job && job->vm to check ib has vmid and use job && job->vmid to
check if switch buffer should be emitted

Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 2ea98ec60220..af908932b8dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -129,7 +129,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	struct amdgpu_ib *ib = &ibs[0];
 	struct dma_fence *tmp = NULL;
 	bool need_ctx_switch;
-	struct amdgpu_vm *vm;
 	uint64_t fence_ctx;
 	uint32_t status = 0, alloc_size;
 	unsigned int fence_flags = 0;
@@ -147,7 +146,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 
 	/* ring tests don't use a job */
 	if (job) {
-		vm = job->vm;
 		fence_ctx = job->base.s_fence ?
 			job->base.s_fence->scheduled.context : 0;
 		shadow_va = job->shadow_va;
@@ -155,7 +153,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		gds_va = job->gds_va;
 		init_shadow = job->init_shadow;
 	} else {
-		vm = NULL;
 		fence_ctx = 0;
 		shadow_va = 0;
 		csa_va = 0;
@@ -168,7 +165,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		return -EINVAL;
 	}
 
-	if (vm && !job->vmid && !ring->is_mes_queue) {
+	if (job && job->vm && !job->vmid && !ring->is_mes_queue) {
 		dev_err(adev->dev, "VM IB without ID\n");
 		return -EINVAL;
 	}
@@ -297,7 +294,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	amdgpu_ring_patch_cond_exec(ring, cond_exec);
 
 	ring->current_ctx = fence_ctx;
-	if (job && ring->funcs->emit_switch_buffer)
+	if (job && job->vmid && ring->funcs->emit_switch_buffer)
 		amdgpu_ring_emit_switch_buffer(ring);
 
 	if (ring->funcs->emit_wave_limit &&
-- 
2.46.1

