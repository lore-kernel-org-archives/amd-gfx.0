Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B87C3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 14:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F7010E922;
	Thu,  8 May 2025 14:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NWBAvxNn";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D050F10E922
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 14:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBLGzhfvLUE0wLI2sPPQb8Y2ZgUm8eZ3d86tHVQpUdDdgeqRlAbK3AiAdqnG2lF15gY6oTrIpHUDCR5O0f1x3wK1xLnof/jGE9gVavqgg3ymr9g3HlTgX6uwA5/PChvA/giXNNepykHXpjHIWYul1FHSYl5WQG5JaNcqUPjBpmP+BNTwLTHmd/wIPaQbpHCK3IYa7dP8bJzZPlEyE4Bp/cxVrN1OjwHZ6PH24G5pQeslgthqIb3AUSW1EOGMu3W3bOq3z1/3s2d03zOxem+vTV/iG/G/vk7bJ+BfAy5AH3JkfjznO8jan2faZX3K/F7X2/T1SqSny/LKh2F0Cd0mfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugD4GjoBW9vYrie6uEnF8GsKY4KA+8Taa5k3a9J//CI=;
 b=gp+S/w6MZWbPM6bXqgsnM2c5zKj9ICRbcc4G2Qeji7NZVx2nzOabgazH4RhfMotzkzNkoaQdvcLwA7QlBpeoYaX2w3L1hS36vz4xHTQZUzSc7ZWE/l1C32gK7eBTCprA5Zn+6e0OT+oURcjk7QymZhrITYV1gr0CL0hs5jLR+f30/L2mSyIJC9NAhR7rgNq3tmlwkDAdVBAIUe4Izm4FOhzACpusn+dPeCtRCgkhQ7INYDBwYGxZilmt9YKQWTAyJHocq33T47sKsh9N2s33H/bQ9rdkSYQT0mxruEEqI6LiC2a6B7tJ29Q5FFNgOincG/eDVdYIolIfw1Dyl8fGQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugD4GjoBW9vYrie6uEnF8GsKY4KA+8Taa5k3a9J//CI=;
 b=NWBAvxNnwmyax09Hf6VVqi3HioAk46vr6svj1GOu2CPv4VgvWvoJgwJthzbbTWYrnWaN5I1mvDVfQsL9cThln3H51WHv0ucR9qpvXilulaZCFJhsP1Eb6eUIeZNyVTB3qOp8wSHqsG+63i4JL0lQqRGg/IQWuJ9d5GlCQMZ0BSM=
Received: from PH8PR21CA0022.namprd21.prod.outlook.com (2603:10b6:510:2ce::7)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 14:47:06 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:510:2ce:cafe::f) by PH8PR21CA0022.outlook.office365.com
 (2603:10b6:510:2ce::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.3 via Frontend Transport; Thu, 8
 May 2025 14:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8746.3 via Frontend Transport; Thu, 8 May 2025 14:47:04 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 09:47:01 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <philip.yang@amd.com>
CC: <Felix.kuehling@amd.com>, <christian.koenig@amd.com>, <jamesz@amd.com>
Subject: [PATCH] drm/amdkfd: improve performance with XNACK enable
Date: Thu, 8 May 2025 10:46:51 -0400
Message-ID: <20250508144651.16745-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f8c044-9106-4ab4-a094-08dd8e3f32e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ny7rtuRXSr2c/JJjmWxKgbC6jhUA0i/kBU/0pnAPWwUDLgJMwCMsVZ050Xo0?=
 =?us-ascii?Q?2H8j7chsyaj3JtIuUlG9ds9VsyFr9l1XR5fIZjp6elsG7SJeIztxHznbOzK+?=
 =?us-ascii?Q?w37P331yIakI7j0euEE59p4q/+9euBFcasUXykDfpYe+krKDzrRZ++SG8pps?=
 =?us-ascii?Q?9qh9t2wtMAjEQ42+xEqgPPV53uKTMI75gVXgZvkdXiCNR9tK+wX3doybUbnK?=
 =?us-ascii?Q?bmwuuIAtlG8IppiV2k95JORoEGxLpkirdA1tdiNsY0lZX9nytdJZ2QxLDErb?=
 =?us-ascii?Q?I/aFHIvtw31nGZB1qQg/a4g7m0t0g0GeDhqamA56MVPOQf5MiKzCTvtPuuBd?=
 =?us-ascii?Q?ZppZSJu3fTkqWmBNUErvKdD5CJ8MbMVfr07zeK/1QpInm6vFtWbV52J751Rn?=
 =?us-ascii?Q?7+nrPrF2smR288/0jSbttbdIfcW6UR7cU01RGvb1QVmUTQYL1D2Zs0J9Omwd?=
 =?us-ascii?Q?53XisZBlVVdsKElEv3opbTtpUfM09km42tBjqHuDhq6sYHWoBmgZB1+s2Snk?=
 =?us-ascii?Q?XWs6OFP71cuQ+Hp7B08f8BXzqThtn4GbEsro0BP8xA/oKf3uex2WZc+nOF5w?=
 =?us-ascii?Q?7yNhF0LNxVwH3VsKkqGB/3iCsRlqF5zHfaIyt0drY0YMBRCzCB+HP8pLThmy?=
 =?us-ascii?Q?BEu8RBDWAGkx+0FJG0AQbv4bnmZxhG+AShfJ3r93MaIDJMmvZKhmoydTGeS3?=
 =?us-ascii?Q?Dzv7w74KSpI7/PGHntOILjWSoKzjUm9hwK3q9/bnWTTg7aF4lkgIZpWqucri?=
 =?us-ascii?Q?GkzOem531no3W2CW4zvl11csGKn2hOXDSdHOMy4SX/DdKcACgrzvMWER48Em?=
 =?us-ascii?Q?r5EnoFABrQRcxFi5Aq/Xc1xWMNw38nYj2/lzq5EkJKERxvkYuYXKjTZCGMqk?=
 =?us-ascii?Q?MpIIVFGfP8WDHJOk7eAFiMq3xnvZdq+mjgn23g+zXbrLYt+FQuKIkVJFzcPc?=
 =?us-ascii?Q?kj9DtXhUor8SEE1gVUmV9O6KKX/Zd3p4Jercuq0BBQqBVE1t4Wet7JK0D2qA?=
 =?us-ascii?Q?+1QHddbIpxQ0bN1S6j3D7SNFlAVaPhDFQ5qVpOlI5QxulABTUeYMHuMaP8d3?=
 =?us-ascii?Q?uHGuxZiJ8h/Hnx9ew2jWVsqAdlMNaQbmS83xc/As+xJJItfrWgCa6Q6b/1DY?=
 =?us-ascii?Q?B0HiAmxYFRm94Mflpds7KOeWbPLcEGaSPcToBM56H+Ly5dupZvaQReK90uwN?=
 =?us-ascii?Q?FZaHpPL1XwFI76WlJbDXDm5qoW6NZPrTFpo5dFpEpwvpV1tgzLn/vsp7unl1?=
 =?us-ascii?Q?X+GQTyaaDUGFg2SAOcP0p6kZoML2OBlvHMXnTTXMkU0KHEQ9fkrANDIcD0s5?=
 =?us-ascii?Q?7i4VnLkGc63vkmhPg2OkeeYFQcnbdJhGFK2PthETtOE+y0FWHCxBc5SfChVB?=
 =?us-ascii?Q?uySWlMQXawQ70Sc8QthFHox+qHTE05okKcBedxMaUTApQnyySCge8wGqO27D?=
 =?us-ascii?Q?7ScmGGlgNBOUwpdQYMLFnAiHladF9PpoTlg93GggAsgaDhomA5/WKEQiYA95?=
 =?us-ascii?Q?Mr4DkpvvupjnKVGcyZ10qhTYsqcxVp+d+JqE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 14:47:04.2931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f8c044-9106-4ab4-a094-08dd8e3f32e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
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

When XNACK on, hang or low performance is observed with some test cases.
The restoring page process has unexpected stuck during evicting/restoring
if some bo's flag has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting:
1. when xnack on, retry pagefault will invoke restoring pages process
2. A. if there is enough VRAM space, simply migrating pages from ram to vram
   B. if there is no enough VRAM space left, searching resource LRU list, and
      scheduling a new eviction work queue to evict LRU bo from vram to ram
      first, then resume restoring pages process, or waiting for eviction
      timeout and try to schedule evicting next LRU bo
3. for case 2B, if bo has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting,
   queue eviction will be triggered.So restoring work queue will be scheduled.
4. step 1, restoring pages process will hold one mm->mmap_lock's read until
   restoring pages is completed
   step 2B, evictiion work queue process will hold one mm->mmap_lock's read
   until evicting bo is completed
   step 3, restoring work queue process is trying to acquire one mm->mmap_lock's
   write after the above two mm->mmap_lock's read are released, and in the
   meantime which will block all following mm->mmap_lock's read request.
5. in step 2, if the first eviction bo's size is big enough for step 1
   restoring pages request, everything is fine. if not, which means that the
   mm->mmap_lock's read step 1 won't be release right the way. In step 3, first
   eviction bo's restoring work queue will compete for mm->mmap_lock's write,
   the second and following LRU bo's evictiion work queue will be blocked by
   tring to acquire mm->mmap_lock's read until timeout. All restoring pages
   process will be stuck here.
Using down_write_trylock to replace mmap_write_lock will help not block the
second and following evictiion work queue process.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 72be6e152e88..5f6ed70559b7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1794,7 +1794,11 @@ svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
 {
 retry_flush_work:
 	flush_work(&svms->deferred_list_work);
-	mmap_write_lock(mm);
+        while (true) {
+                if (down_write_trylock(&(mm->mmap_lock)))
+                        break;
+                schedule();
+        }
 
 	if (list_empty(&svms->deferred_range_list))
 		return;
-- 
2.34.1

