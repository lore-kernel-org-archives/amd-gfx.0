Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9BDE66884
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Dec 2025 18:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D381E10E8F7;
	Fri, 19 Dec 2025 18:22:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rOJjiXYK";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013000.outbound.protection.outlook.com
 [40.93.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14F5510E3D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Dec 2025 18:22:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUAdq+kmmwtQXvvTHN18oWxSz3mu1s5LAbNLumDkdYcv2jfuposFckHVW96QcKGe4DZ09KQcGc2kAHjy6d1hGk+7oCfnkXZJ+M9jb/CRTwwKPjMtpDktpJpGu9AiSYWnhX4xK/FQtNB+EE8E2nFbnJccpp9JCWHHr9OkuhzUOnZm415KZJl3lqphonLl5lJbcMsFZPYJproAAUSi3HD9giAceqG2FlssfGRnl6s3yybdikXcUeDBl0MqlxQSi3RSImVZPDHJXROuhDugDSUlYod9H6sJ6iwaEqHmIO/AxBqJBUD1/gJDOzrMbrmE4paB+SkGZUf3JlD44gL5pGlPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6OkdSis1W0JJhLiDDp6bgjEIr9htQWXnY5ouaqYqSc=;
 b=XDRXyM4uYUqNUz8sWTMLXTBbyVyucHtm0mwIQlmO9Ts78d7kNtzjulOhUdnm6Dy/Usxc/P4wayB0EiTPQkWardvSU8SewxzbuNwTp2M9QzN4SWtTUMB+MsmGgD7S0ZGXoGT/H8ew4iAqrs3Knb+J33Fn4EtXomGJBrLGaaLrY0P7X7ZXKlj5TdCGmUXXNQbS+lBVdvx6quRKyJ7D630A4f8Evye64kwNp136iHXs143DZ7LnUdjVdXKwo3spE1m2h36qVG2oeaN99RoQIJ+iQE6J542GIZ64SGiFrf/gSn8ZR0IHU+DLdeiDGICGLz9w4KhuZOLgTF68aCiIe/+6Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6OkdSis1W0JJhLiDDp6bgjEIr9htQWXnY5ouaqYqSc=;
 b=rOJjiXYKTwF+Hb/IhQwhH+CJFbY14yO33bJPu95+8DuoTujoktIIXGz19vz205mFPnJQHeYRHk1RP6+14GQ5di7Eo8o/pai2PPhrgSBJmSYvnylaPJd3OV9VHtkIHOY4KmYSuss15/bHA7jZdpocn/hK/NputWUkvRRjhrFX71M=
Received: from PH8P221CA0057.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::12)
 by CY3PR12MB9629.namprd12.prod.outlook.com (2603:10b6:930:101::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Fri, 19 Dec
 2025 18:22:28 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:510:349:cafe::13) by PH8P221CA0057.outlook.office365.com
 (2603:10b6:510:349::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.9 via Frontend Transport; Fri,
 19 Dec 2025 18:22:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Fri, 19 Dec 2025 18:22:27 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Dec
 2025 12:22:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: mark fences with errors before ring reset
Date: Fri, 19 Dec 2025 13:21:58 -0500
Message-ID: <20251219182201.5722-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219182201.5722-1-alexander.deucher@amd.com>
References: <20251219182201.5722-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CY3PR12MB9629:EE_
X-MS-Office365-Filtering-Correlation-Id: 81814625-af94-4115-b5dc-08de3f2b90a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sQPSZNjA7NTE62gqMATWqPWsxXQifVOm1jhtgY4lOIhPZrR+kcVMh6+ublqh?=
 =?us-ascii?Q?+vz9+6pW+bv8tl9kR3GQJnCiC5svhsHGUDWzzVM2C0AecuJMe636EQx+fUmj?=
 =?us-ascii?Q?p+upfe6fB5KMf4PXIoMDtD8eE0BWDwjzXBPHMLyxlFlFTs0fdy9IqYn2G5cb?=
 =?us-ascii?Q?oyUwm3RwQ5SHEKxg0ACE3fzBcOYI5Gw0uDDGT9fFJ9+x5O4g0EI0Gurda4Ly?=
 =?us-ascii?Q?/hMk1iPF6+ElYvTAYJcdvfrlVqAQxLEE+QYvOGK4pbAksPfxEMROZkYo3UkW?=
 =?us-ascii?Q?171P/XJptWLJ9f1k1SGXaPHxjcn7zU4hGYgTeQXKgAIj6DUZhtktYs/R9bve?=
 =?us-ascii?Q?sjfdNyJtAp7ILdDlXSA/tnbdpYfZo7THVNRk8xm56iEGlbyXBOKbU9c4MZw1?=
 =?us-ascii?Q?Mfm0bEswXe4sX3AGOSeaU8pwN69OKKUAC91KXy1BQS7bPd5dImAtnkgcrVCQ?=
 =?us-ascii?Q?yfEO3ZxPO0I7KLofwUcJo7fw3rlZabqys8JPGyZWuJh7RRGPZKY0DRYrAvu2?=
 =?us-ascii?Q?S+B+rfxXMtYuDHFj1RQc+VseofKYp0MUoM0JGBHlJtbt13c5h7ZevpXoCVUz?=
 =?us-ascii?Q?yIO1TpspUzumvICtfrtMBclRhiIZ5ocxTBF1ORgZNXGS1PSIscyGOSkUZupI?=
 =?us-ascii?Q?aTxEzV3G7Ko9eR8i/0vZG6OQ8icd5CDwtDmCQEJQr8mdrR4H5lGIYjJEOnTs?=
 =?us-ascii?Q?xo9rmwHS9BloQbB1DdTxbj2Ds6ZFo6GyjC4/2i7u5b70qpb249+BiVSOuv7d?=
 =?us-ascii?Q?4TUVn2zDSCP0oVPKbLEzqGwxUSLzF4nN7yYJDY0H/JH/O0PAJ2yPferQbR0t?=
 =?us-ascii?Q?3ov3F75sbVudpTFZqCxWRaCGpINln/MGaZn4wDew5mR1PiX4Z4T5Sodf19xy?=
 =?us-ascii?Q?Y7G3xDOpvwuo+PetJ4cQ7SVrb9kaW1KTBBbA/4PFnYZPlctiBM48j0ySAM6v?=
 =?us-ascii?Q?qIeSJ/p2KFisq2HTlTo3IalH+jOri57uDAcQZUB41JUjwQOaiwXyHHg5WNV9?=
 =?us-ascii?Q?fsemjhTHCasZqb6JEoA0D+TErvg7XZ8FJH+YeKE2+OctpyW12mJP94Gpx0yA?=
 =?us-ascii?Q?HtbE52tVdaejNqAgcCjpH3ZqIkanLyYvZnqNktddouoqm8uohhHX5LKL6MWq?=
 =?us-ascii?Q?43+QEUXileDAgxp7iZaWa6MesQx/pQ+r5wqWLHIrBN1d8aZp7nJ80bIm0cMs?=
 =?us-ascii?Q?XrmhdJEACfrYCDGYBGYMbI2XJx9CMTNDZIw0zmIQ7laZ2BtJ4s5wBnzojb50?=
 =?us-ascii?Q?Pp7MN9Za8DJRWofx41GfW0Wld2etID3Cp4xTFDAmtmehdEbMAtQ5q7RDqNcZ?=
 =?us-ascii?Q?F0mI49LoflLHgyeFPeFoFB9tqrZbKbRUgcD4aakk8GDVKUtdoGPfCZ/VwGbt?=
 =?us-ascii?Q?c8a9ILFRkT+mHUfJsYGXBNlgqsuXTnImJTIMRe+RS9Bid/+3v1uCKqmIyqLJ?=
 =?us-ascii?Q?MkGLMr63dRz5j48kT5ECYoXM+opqUr7RV+3jfXnnFYqOhdVYcFncQ2EUUTjY?=
 =?us-ascii?Q?Pq62Yt6r8w7e4P3GRcqgvmNlqJ7HD0f8upViwyBNW0mHUMDz4InTH1QbltGN?=
 =?us-ascii?Q?3C+a4LkJ8JRmXpgj59s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 18:22:27.5179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81814625-af94-4115-b5dc-08de3f2b90a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9629
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

Mark fences with errors before we reset the rings as
we may end up signalling fences as part of the reset
sequence.  The error needs to be set before the fence
is signalled.  On GC10 and newer, this isn't a problem
since we don't signal any fences.  On GC9, we need to
signal the fence after the reset to unblock the recovery
sequence.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 600e6bb98af7a..5defdebd7091e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -872,6 +872,10 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 	drm_sched_wqueue_stop(&ring->sched);
 	/* back up the non-guilty commands */
 	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+	/* signal the guilty fence and set an error on all fences from the context */
+	if (guilty_fence)
+		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
+
 }
 
 int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
@@ -885,9 +889,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	/* signal the guilty fence and set an error on all fences from the context */
-	if (guilty_fence)
-		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	/* Re-emit the non-guilty commands */
 	if (ring->ring_backup_entries_to_copy) {
 		amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_to_copy);
-- 
2.52.0

