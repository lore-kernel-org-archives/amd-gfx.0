Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BD2C83F15
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED27C10E53F;
	Mon,  7 Jul 2025 19:04:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TH9LRr/R";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 336B410E532
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckh9oA09OU1Iikf4C6BJIlUvWpjP19ZncTahEG7BE2ixjvmmombdeVGL7XDyFp26PCXkq9cIwO7zkAZgqM5tkkp4W8n53Li3WgXkt38wPcpN9TF3vU2QMby6Ta1opKF4NQi80nZxN/0JqZUtvICawMEHGIG90HJJfVBHpkhhBny6ZKpZReqoNjUroxObndQvf/YFkZMKNNzckAdF5vwWzjp+nFEk59WfiDIq6Z/lMuiUhJOAyWMGNBcONpBrY1de2pUXEx4tlDZC9fZRtnNuWEiHbSyoFKk3dkD5fGuNdlVGn7BpALo5G4ECe1pPkrp540if0HVEr/S8IV480lUOBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVp3vdsmrvuoLKAyKBAZvYKXmVqIlmzpYGqS7bXnerw=;
 b=au5hoj7hhUkUi8PpDSYDi/o+a2Kq4ogLRHt8l1k1NqFl98N+GVaBSqByefLGjGAWEgDNlqIlA79H1nUcn53ezhUS7wLCITZ5ZyXQaBOqYZYsQUBoO62ZZtDaSasZeqSxrssDk/DLlDe58ATD9iRHnIDdQT3n3Qo7A9eZWAq/mxn6VItR+OSIX4/IEWMefNgwyBQiff5xWYxGygjzzebGKjQAUSpUXyMuUyMq14yiY/e44zFBraYTJAzS9OUvKyJE67YeLlbvO/HYgbBuZw5dpHq1WRHTnsqDnz83Q0X9hTEub4l/mqxnoYuL4WRezZ2hsNf4jS/Df9GiRfJOnN6Z4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVp3vdsmrvuoLKAyKBAZvYKXmVqIlmzpYGqS7bXnerw=;
 b=TH9LRr/RwD0yu1WR5luTQOWgRqf8yV/j7UbRly/bQKbLo2l8jT0n61vqK7l92YiYzzI82kQ82b6TtvaNIemT6DeIfPgqmHbC0HDiZ0z9VVkUCPK9SH8iH662mdB0mY1QuL9R2myX2dM2YcaIa023bpkVk0+/Bq9MfPpvB39PDtI=
Received: from PH8PR07CA0033.namprd07.prod.outlook.com (2603:10b6:510:2cf::20)
 by LV8PR12MB9691.namprd12.prod.outlook.com (2603:10b6:408:295::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 19:04:24 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::ad) by PH8PR07CA0033.outlook.office365.com
 (2603:10b6:510:2cf::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 20/36] drm/amdgpu/sdma7: re-emit unprocessed state on ring
 reset
Date: Mon, 7 Jul 2025 15:03:39 -0400
Message-ID: <20250707190355.837891-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|LV8PR12MB9691:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa0207b-e178-4602-c415-08ddbd891685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P0s1yK3LlaHDGpp/0G14V/JHsupx2zvfypmuDbxn3fDT0aauV2nzoGF2FtdI?=
 =?us-ascii?Q?naZagrsExvYcSe918t+9qQV/G1gaQiKP/LH9aVC5omYOSv08J0GS9jbio8zo?=
 =?us-ascii?Q?NN6HKTJWmQuimVzg+eifnu0CiGiTPHxLU/B67PBbauTdxWXffxbD7wKf6Lku?=
 =?us-ascii?Q?MNA8S2wcAFgM9r1w11gsVLYEo4aYII/ScKNFYX3aP4MRo3IVfraBmAzsFAV4?=
 =?us-ascii?Q?7IhgmM209PC5X6mSapRChGVx3XPpRcywFPxVgEQWeFj1bB+PfsDmdMfJS9OU?=
 =?us-ascii?Q?nSAbRn4vDUxenu8RCnNzhzL2syqKE0+leswqI22c2raSJBlBsET6GcS7Dl+c?=
 =?us-ascii?Q?u7yYDD9sZzXyRWwnyyPLuaxPn87k+YIHVwLtYQ9CP1T1T/F8mNJgUoZ3E//e?=
 =?us-ascii?Q?N5O+mcD5r5/feEfHcXwRBHlJwpcrx639ZNOaNHoQu+WmGzlzf6+TZQB/93W+?=
 =?us-ascii?Q?Lfp+cMnCvKehJ0DceMMKuZJeZlON2Eg3CzE7EtwgoXcP7Jdm6XF5o9WflpIQ?=
 =?us-ascii?Q?U1gWKOpUdEGvzWzhSbrQfwDaBU/rP/wa+oEnkiQDK5Kyp7aJSnb0a+JOEdaR?=
 =?us-ascii?Q?K1TAVLK/7Jbj3Ljv6Wk6nNvnwbFSNBjJuiutkScFdvc3UPeHxnzUBb4ZFNFL?=
 =?us-ascii?Q?LByTVBVKKd5DFbpQF52UYXPel2MY/8QzVsutFPP9ZjfmuYw5vP7iaRkHcAbm?=
 =?us-ascii?Q?QamC3q101mTmGhCH27ZzEzVvDIeEq0mLMTIYEqVXQzThSs0a9kpH6EZX3HY+?=
 =?us-ascii?Q?nq0fAGJE2pyls1gjZLwaOCfgQ6YOUrRrOBgEeIuCPHscGJw5ujsKT8w0nXBh?=
 =?us-ascii?Q?0cIFw7jRDSKwicwI3LtEnvZ4pQyCkQKE+Ds8zDd6WEl/ReDyda/0H0qpWWi6?=
 =?us-ascii?Q?JRCqWft3KfuMmUAAZJfHx6nReJ248JDYRwxBd+ly1zx+K8VNpCF4031cshpk?=
 =?us-ascii?Q?d/HrMMgMsCGT1St2HxKwUB3LHWKYwLu9K2HiAOvCwEaZuXP65ViY6iLxs605?=
 =?us-ascii?Q?5/nXcMx1YImMR+oO5ryZzfo3Wz45nf72bC13zp7K6Sf0msU55zJHlcFofeOD?=
 =?us-ascii?Q?829ilKaTWdJoZ+64UcMWiXTh/WoMR0HNlOMxV8vc4QY3XERnW+OcZULVzLZ3?=
 =?us-ascii?Q?zhLBtYF/alV5GkSekfg7j93xEcqz50Ow38yl4jpByNQhZ/wn+hrhFtHzGr5+?=
 =?us-ascii?Q?bkMBqHveMe8z0Z4W6/M8FZVGAXIbTzDmooeCbg1yHc2OYBEqntUvJiCKh2tf?=
 =?us-ascii?Q?wLl70HaGvvA/BgIdvF0bJQuk10D90Y+EOojSHaZjBrISHUktxdZxHsEgc+ZW?=
 =?us-ascii?Q?33zvyhx+Ml77yumvAmBJcU1Y0FSbdtc1o7IF1jJGr+DnAidlVro2GXVfbJVe?=
 =?us-ascii?Q?KFqqlBK47ug8miHL2FPi40JCtMr6LCv9RXLw7QTLQsv1H/MvVgQGHnXnRpwn?=
 =?us-ascii?Q?8M4ZNlo2EJskONVNOGC9PoGKfzoLmkAvAPFixKu/zYMJ2UMFLeosOgHeLjUy?=
 =?us-ascii?Q?+gqbXJM59xTMd7d6jOkAXk1Pc6fWR0DMvveo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:24.1622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa0207b-e178-4602-c415-08ddbd891685
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9691
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

Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index b79dc0a37667a..25945fafc5b79 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -817,7 +817,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
 	if (r)
@@ -826,9 +826,8 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 	r = sdma_v7_0_gfx_resume_instance(adev, ring->me, true);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 /**
-- 
2.50.0

