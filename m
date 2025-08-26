Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60B2CA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 19:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4632410E3AA;
	Tue, 26 Aug 2025 19:38:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1lkarXfJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0B1910E3AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 19:38:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyeMfx4oreOdGXUgqp6tofF08HUPXAooMF4Y6CZ6Ucbogvqcerwt0+ueCRvg7K5dTPCb/Gx6j3cZ638VzuOOi3s1MJK0Bwe5pK6SWof24K+61zJ5SGGW6/F3QLpCn70VeGMp+D7X7JtaH6g6FmoJheF1WwLMd4Dic1F4iIrEPb0xJQ41tYRJ854u7eT6u14da5R++PnoqLc4l5ML3rOlFSvLEA07yicE5mov6oR4weNgEvMUzdWxUDE6rTpiPuls/XD2wQxhCC+66zVKCPi6HoFWCmw2IAJ5omcc3XpF28fyumXMEOQac3iZLSRh3EVH4kKLEuCw64QnB+ZQDP6h4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmZdPVklkot8AoePaLK++BI1fcioNjoPOEjdsLsFcn0=;
 b=DnBIZZOviTLmMedGbo14oA/mSkEe07JNaisWF/EypyDja8OrZ5x2F/00DgUrhCDBq51zBAlRcE1StX/oZMxHxIh1nO8vvX5NM5itTQkqWicbhvXMcyI9mf2cQvoRii71nmTp65gynw84WmaW2c2VAgUFXMHXJGf7MycNH8oOrinxpDh4QbtaTdO86gKhsyKFu1Pi8uqzsKveTlvGfzwXeyBqLzJDGVQWLbGMeCXhInPiOrkulPKWmtjM0M5DznHPFXZxmfj0nky6Kna7jpfdB6nI2DWPNqQAeXoV3zdviMidxOiJcjS4g5IOqLAlCIhN6EIdMIEglu6QD8/jqehP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmZdPVklkot8AoePaLK++BI1fcioNjoPOEjdsLsFcn0=;
 b=1lkarXfJtB4okxN0ZOH/sx/iNhg/hRckX8QIAfzTa1DCs+dkwJBsulhOYQGSxaFR3Xnf+i+yIhqDYRewlK84loKajMuU8wd5UO16hMMpB8NiDuvdYRzCFzVr0u0X+UQlbYmUC5IoF/RX+SHmsXDkD4GhRLeuRnWEkNwpoFDxHOg=
Received: from BN9PR03CA0491.namprd03.prod.outlook.com (2603:10b6:408:130::16)
 by IA0PR12MB7578.namprd12.prod.outlook.com (2603:10b6:208:43d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 19:38:38 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::7e) by BN9PR03CA0491.outlook.office365.com
 (2603:10b6:408:130::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Tue,
 26 Aug 2025 19:38:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 19:38:38 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Aug 2025 14:38:35 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: protect potential NULL pointer dereferencing
Date: Tue, 26 Aug 2025 15:38:21 -0400
Message-ID: <20250826193821.869445-3-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826193821.869445-1-David.Wu3@amd.com>
References: <20250826193821.869445-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|IA0PR12MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b37dcb1-c2cc-4a95-ca9c-08dde4d827a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GaYVeC4M3eB8sNgL7xErtj6c/G+VceWPu8ihfLOr5Fr04THWMxAKA8nYupIw?=
 =?us-ascii?Q?cUrwJMLdIpJ6sH05Yjcr/nN8RP6MWqY5vFD1ksZ17DY65VFUFIezpLBvR//c?=
 =?us-ascii?Q?+OltbyYzgu1BX3gVnUuUOH+E2DwDKeSnTyetNt6gzyCHHAwMpIvfgl/kz9Ak?=
 =?us-ascii?Q?GWtRQ0tCORbqN7VrrUpbZ+bitq1X90OoAJZvQ5C7zBwmin+QF61ZPLrv+INz?=
 =?us-ascii?Q?gu/doy9DtkjrNvTp5YaIszEi/rmTZIvQYZOuxNJaMmtwxRN0EBFUysfgNVvO?=
 =?us-ascii?Q?hxh6wYed/S/gmUkQAqhuU7V9/dp+fEFo6ftldRbhZxPB8H52ZWwEfdpYNgHq?=
 =?us-ascii?Q?e4gkkZh0JkAc9eGWfJg0V24/HJHB8NR90BIPnaip9na18ZSDugoOOmgIjBp5?=
 =?us-ascii?Q?nTPGQYwlw7vJpVp3LmEnr62ixsGwSwixpA6ncLcBtcSCl1/XEBh/ou3RFVsM?=
 =?us-ascii?Q?wGiv+uERREAW0LdQbEJyvNqIMqGkV30k2BzWP9pKS3MvqRZ7pPtcVqAy33VJ?=
 =?us-ascii?Q?mBwXdtmyjXPJn1W4ABnceXdEWwya3So9rHed+lx6cT0RgTjd+6JIHHo04rZJ?=
 =?us-ascii?Q?PBA1YGU+5TQltbfMEhscB9Kfa6fMEX5wWt3HghpatzWxlEdBMFFP7kxfrkiq?=
 =?us-ascii?Q?dk3dqfuUqKvGyHVFgQbrWIO0XUOhMwwR9PUMz2kyIxeF4mBGss6fJ7KlvQUQ?=
 =?us-ascii?Q?121DhArXeqy4sB1UaAGzxTXrPC0SkhH3gOWqtpi7azAZ1u8ZyGrH4R73D/XU?=
 =?us-ascii?Q?wfR/3FXNrgaU/5FynuiDrBGYg4qBkWivFddwnhwYxWnDxHep8BOax2WTYOmC?=
 =?us-ascii?Q?A5EKYW726Jc/YsO4SZIq/NolM53VNjtMGixBn2ZqTRmKAT/P1g8716QHO6Wb?=
 =?us-ascii?Q?+PpiW7TUB7rgmj2f93O6noVPaSX1weny7mZ6dvFrhFRzQHdl3U51Ze48ZYHe?=
 =?us-ascii?Q?VBng9dyNoXXaSqVdnfFzNJdRxH10u3ZljoZYH3J1TTuwLws2P0SoPCO1wbeE?=
 =?us-ascii?Q?zpT5oyTfP8v5+dD6StyVdx3BecfPXWYk/KZc0Z3h8Hz6ZSvj3Q1Fk/I6c6ny?=
 =?us-ascii?Q?zWjG4eUtbWmr/DO2zL7zFgvK3ga9AQxgWjE7ANe4THEyRmHaBq5SHYMFoWrI?=
 =?us-ascii?Q?oRt64azddxq56gasgHCVmZQPRVFRCAtY8tdGmMfIDB8//TvfmmIxl2y0uZzh?=
 =?us-ascii?Q?MNT+uuxRiau0YmD0jH0xWZgKb8im5BL6Eflkrtu712EedkT02VUE2lhOz/3z?=
 =?us-ascii?Q?zclsDtyR0k79wwqA3fqrecwENeaekRzzEXtpfdnUZhP/fhkc+IelghQgv8NQ?=
 =?us-ascii?Q?nohYF5b20RlbigpwKf3SejG3b6VyZwzS14Szb13S3P4f4/ZNfDQa84w1Mr2e?=
 =?us-ascii?Q?kwsUtvuFwNA/6V4+n0oufb8o+5OfiO7ap5q0giEZrF+Tqo70DkN0SyOkPdfU?=
 =?us-ascii?Q?6sEotTMzSN2qXcp9FE/hLfiGffFITFUKdK8O8MklmABTTOLhHFKkR2KFv6F1?=
 =?us-ascii?Q?LA8kyOMXOWj3ur3A2Q6rMXkTBs7Q6pzZKf5/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 19:38:38.5540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b37dcb1-c2cc-4a95-ca9c-08dde4d827a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7578
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

to_amdgpu_fence() could return NULL pointer which needs
to be protected for dereferencing.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 2d58aefbd68a7..1432b64d379ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -160,7 +160,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 		}
 	}
 
-	to_amdgpu_fence(fence)->start_timestamp = ktime_get();
+	am_fence = to_amdgpu_fence(fence);
+	if (am_fence)
+		am_fence->start_timestamp = ktime_get();
 
 	/* This function can't be called concurrently anyway, otherwise
 	 * emitting the fence would mess up the hardware ring buffer.
@@ -387,6 +389,7 @@ u64 amdgpu_fence_last_unsignaled_time_us(struct amdgpu_ring *ring)
 	struct amdgpu_fence_driver *drv = &ring->fence_drv;
 	struct dma_fence *fence;
 	uint32_t last_seq, sync_seq;
+	struct amdgpu_fence *f;
 
 	last_seq = atomic_read(&ring->fence_drv.last_seq);
 	sync_seq = READ_ONCE(ring->fence_drv.sync_seq);
@@ -399,8 +402,8 @@ u64 amdgpu_fence_last_unsignaled_time_us(struct amdgpu_ring *ring)
 	if (!fence)
 		return 0;
 
-	return ktime_us_delta(ktime_get(),
-		to_amdgpu_fence(fence)->start_timestamp);
+	f = to_amdgpu_fence(fence);
+	return f ? ktime_us_delta(ktime_get(), f->start_timestamp) : 0;
 }
 
 /**
@@ -417,13 +420,16 @@ void amdgpu_fence_update_start_timestamp(struct amdgpu_ring *ring, uint32_t seq,
 {
 	struct amdgpu_fence_driver *drv = &ring->fence_drv;
 	struct dma_fence *fence;
+	struct amdgpu_fence *f;
 
 	seq &= drv->num_fences_mask;
 	fence = drv->fences[seq];
 	if (!fence)
 		return;
 
-	to_amdgpu_fence(fence)->start_timestamp = timestamp;
+	f = to_amdgpu_fence(fence);
+	if (f)
+		f->start_timestamp = timestamp;
 }
 
 /**
@@ -827,7 +833,8 @@ static const char *amdgpu_fence_get_driver_name(struct dma_fence *fence)
 
 static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
 {
-	return (const char *)to_amdgpu_fence(f)->ring->name;
+	struct amdgpu_fence *am_f = to_amdgpu_fence(f);
+	return (const char *) (am_f ? am_f->ring->name : "");
 }
 
 static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
@@ -847,8 +854,9 @@ static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
  */
 static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
 {
-	if (!timer_pending(&to_amdgpu_fence(f)->ring->fence_drv.fallback_timer))
-		amdgpu_fence_schedule_fallback(to_amdgpu_fence(f)->ring);
+	struct amdgpu_fence *am_f = to_amdgpu_fence(f);
+	if (am_f && !timer_pending(&am_f->ring->fence_drv.fallback_timer))
+		amdgpu_fence_schedule_fallback(am_f->ring);
 
 	return true;
 }
-- 
2.43.0

