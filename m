Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F418CC02183
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 06:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 465D710E057;
	Wed, 15 Jan 2025 06:52:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0oE0fkKF";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A87E10E057
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 06:52:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIWUHfiO18btHfL3KW5e4qFJ/4H29k8sazZHzSGJg4fcvVYHjltZg2JFqKbaPEuc3FxmRZiPLImbG9vbOXW0lhxturEMVM+W0kCX0fSkSp5ayO9fXflDQXfPr7rF+/byy2uGW3VFr8bU83UFsm3ia42nEPCqJ9SH22YI5+OYlI3gaqCDNu0MHiyAcJNrkSzEfX4RnGr/GgQckC5ti7q/5Ins12u9NFvjFS2LaoSmQe//gjwhVYbml7t6cnnWg5X5oeVxpU07DEn74FLt3i8J06JtmLwGtAwZsARNKrrgaQzfpJ4H2Z0SrRnbEJaHkGmUr0SK8G/O7GEPbDz0VnzDMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVSs0fklEKEwxtWYSKZ77KRUyfUEO0mQrchdg/3Ej2E=;
 b=YQQAybd9tS76ln1fR22zDb2YbQD4yKpdnqtPb6xEnamLXkt9i6epoo72+ylkz+humu9bWVj5yoWbgMZ3vk2aBkCYpHOdqrGwsXT8vqdFWyjvSQBfPuBEsR5n6Lq0TCDlHBn4SgR6CjMCF++XX9K+pkBqYL2jH+rRra0iNFOELvo52qn+tJH5jpZEAVTaIfHywhuoRhfqd6+y5xfHEFO69fTRZZsgs5DGeJxuV2qM6+Mn4NvdvvSSwxuGM3pq0RHK8oim3xt7zEnLZjgEywYxWwfAKEWaOA259IGBhBSs9+/GK6YNpDBLPRFUETDnemtemFmdJSutK36fqKiDbk+34Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVSs0fklEKEwxtWYSKZ77KRUyfUEO0mQrchdg/3Ej2E=;
 b=0oE0fkKFwJVI5yJunAPrS2ZyeAAoGyCbQ0QPjzqzOeDwvR7yfoI6Dp6ObuZllbj6bqA1bDQSrQkq2uDZS1W9aQI+HKF6In0mJB29oU4t0+ZBnfsFssv79B1XIlFUu9n2ODirgeFRHBNx9ZH2YiifcqFnyPmuk0KIwcfiX0y7qXA=
Received: from BL0PR0102CA0055.prod.exchangelabs.com (2603:10b6:208:25::32) by
 CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Wed, 15 Jan 2025 06:52:27 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::9f) by BL0PR0102CA0055.outlook.office365.com
 (2603:10b6:208:25::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Wed,
 15 Jan 2025 06:52:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 06:52:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 15 Jan
 2025 00:52:16 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 15 Jan 2025 00:52:14 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>,
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Use -ENODATA for GPU job timeout queue recovery
Date: Wed, 15 Jan 2025 14:52:14 +0800
Message-ID: <20250115065214.3698126-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf7f9b5-21bb-42f5-5469-08dd35312c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NrHliEOgXUR0yu4l3fdvnRiIYUypo+UjDK5in4EJGzFV5udmKIPQYt1o8iy3?=
 =?us-ascii?Q?lwkISdYYScRciYUjF8+Q8TTOgaZNRWix4EJMXzmkVcAu7o4mRcorz7Angpya?=
 =?us-ascii?Q?jX5xxog+Kxu/G13zEbQBswIS+kmQMcIVMOOjtohuZcHfM3T2i9uUcWIrhf6F?=
 =?us-ascii?Q?DI0sZvlVQ3wfTB8gU3/6YxZubqwMPk2yCOehYdv5uGxmc8m5A0di2oVe7KyA?=
 =?us-ascii?Q?4L/J3Va4qXzbTNAv5YY1H72w7e8giOU/0GGWTOuPTC6Zl2URweLkOBhsb2YO?=
 =?us-ascii?Q?1lAJfznL341wSRm/z5ie2RIoM1usgJbwbZSglKYeAfWzHXc/D4ngazG7HWbl?=
 =?us-ascii?Q?A4xjXcNomuq9XFAC4PZ79rECcdh84Z2mT7rrVyXD9FNJJYxFWiK1KJK2h+C/?=
 =?us-ascii?Q?LaCP/zGyo6TfouNdZoygsXtoIf4n9BHgrILzm2BAciBvlSqbpzVFDPRbxgIm?=
 =?us-ascii?Q?vQ6e6BZv8u3rB3hDZS0bYqWucrpHlfd9hHUi5LktYu4J2SGaCs3BeZiKcJwV?=
 =?us-ascii?Q?f/DkWzGKXUiKvy/QgvuWsh8LQ3NzqMpqjo4qaFmrEEPbEiPAT8NK4+wvhejX?=
 =?us-ascii?Q?AkSIXZWhpOxNF5lbM2yoEq93cT3JhwexsFOxy/24iCP9h9YVIGlMqN1tu3WD?=
 =?us-ascii?Q?T7UN5b/716/3N0a8HFSy2r6s7/BT3bEzjhqtHQvlqGbDxuBURnXnfmfcsP2K?=
 =?us-ascii?Q?rNuAAyCkLLcsZX2f5ELYDARAw2nhjlddnionsDH0pJky6VTyuTxpMVu1J1vU?=
 =?us-ascii?Q?wuAdXU2AAFWMaiFMSsjqe6A/UYFsnZkA9ecocZ9pshRJk1sYahfETsrxT+lE?=
 =?us-ascii?Q?rgL/CGDuxyR685SmO+wScjmpUACObWl6+MstlRIKd/FZTWVlvRUPP29VVxWg?=
 =?us-ascii?Q?9tg9Wna60IyFYXNUK47vhXrSuesmN4apDROxiVHBYE4aiHVAz4UR2OqjDb2q?=
 =?us-ascii?Q?nxxM8RaGUW2fMoVCXASF86dhmTNF+z3DZHxDk/mdwJHmjQHvYM9/gjlO1TJj?=
 =?us-ascii?Q?j7XuFSYVIygc/BYnVhRean6X/AyK/9lOVKx/mcFahUEQsKNNBK1VNg4qVIsc?=
 =?us-ascii?Q?rDyadLFLTLLaGUjWHXKBGVDj/L4/EwtZ4W6sfRjy8bxdua96QV2djBJsolt9?=
 =?us-ascii?Q?Sp2nJw7MNESz1B9PvI8M2a6romPO5bm052VtWAdYIjA3+2rZNDua8VXNdBye?=
 =?us-ascii?Q?odRh5SlLUNlKXibTx8ZrQylie3RThoU2D+zmA5AWzILnE7ydGoo1oH/Y2emU?=
 =?us-ascii?Q?7R6IfdLQxI77E5hLFUrGPcoVKe00G4cgFyxbaBCPfGKK4P1YWYnbK8yR/O9+?=
 =?us-ascii?Q?SAQOf8ws6mDxPH/wizRwDGUmnLkm2+nV3PTfa3294ob3UgE6zROuLK6ykGst?=
 =?us-ascii?Q?W2on5BkMKSqKVfvDvLAoweb3q2lnpVfLNhNkNGooSjsN83NrsHg7/J0xbwEc?=
 =?us-ascii?Q?lbP9k3Qqy9TfimRHdwLxxPCTq0mxn1h56fBMKKnoGFGb+JExzvonPjEOv3kU?=
 =?us-ascii?Q?Tux+EEfr7xVj/sc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 06:52:26.8763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf7f9b5-21bb-42f5-5469-08dd35312c4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149
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

When a GPU job times out, the driver attempts to recover by restarting
the scheduler. Previously, the scheduler was restarted with an error
code of 0, which does not distinguish between a full GPU reset and a
queue reset. This patch changes the error code to -ENODATA for queue
resets, while -ECANCELED or -ETIME is used for full GPU resets.

This change improves error handling by:
1. Clearly differentiating between queue resets and full GPU resets.
2. Providing more specific error codes for better debugging and recovery.
3. Aligning with kernel best practices for error reporting.

The related commit "b2ef808786d93df3658" (drm/sched: add optional errno
to drm_sched_start())
introduced support for passing an error code to
drm_sched_start(), enabling this improvement.

Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 100f04475943..b18b316872a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -148,7 +148,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 			atomic_inc(&ring->adev->gpu_reset_counter);
 			amdgpu_fence_driver_force_completion(ring);
 			if (amdgpu_ring_sched_ready(ring))
-				drm_sched_start(&ring->sched, 0);
+				drm_sched_start(&ring->sched, -ENODATA);
 			goto exit;
 		}
 		dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.name);
-- 
2.25.1

