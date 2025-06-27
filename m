Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FF2C83026
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6032A10E94F;
	Fri, 27 Jun 2025 03:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WYbKlDPL";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8648C10E942
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGzFAte9/DhvO6rvbcPJSFv9wd+bjwiOHjqLjeJcqtb4EHIICQ+10DZqqAPsfM1tgp/n0p6PIY4LFSI9frpFS/KK7KtjeAYFGV0NBBpGZTrTV9DzLpDNfbHcaKMFNRohbDohLRIHTNJ2Fhp6C1vlJy+W+ELv7ACDnoI+4F3IEvcYeOUMqeWfIlUbUVsLjC/435sY/w/xTYAMGLEfli549Ju2whSLz7bO2GUZBSXxkv0zCwvznDsBt/TLJGV5A6Ucu0iyxIICQ1SfKMJKYMKwfisC1XBWgEBVhcYsvMYSVo4ZqCq4GjkKZpOv9r1WHZkPxETMinehWNG7zjUukKt8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUpekgKR2Wrw2sGusV+YLat3RC6Hivt+NCzzSoJDx1o=;
 b=bVTBIu3tDpnRLXywlekfJDsgHhCu8gxzRgLNjI1rGkc4T3EkuxDIB+SZ7gtE61y7ILT5ick/5Ojy0Rq9ycv3+Fu3dZl46X1lFqgP0qY/LfJWFuzKJRFDqJlsV1gkRekiKX10s2Tt9ydtsGQkpyl5sPL83ZA9rjcYvl5JjGvPZzwaTyW2ISu07EAw6sQUmDvoUTDT43NE2gX4UK8a2xmMT7HHnGbe/NRc5+M++wiOhK7R9y3WNlDk1wy9RUThE0oY03q6evO1Tle+Bmw7gKu3EuhZtsfAN06nf4ndWL3k1x54+UspWCLDy++guEXjXwxP9EavLjWQP96o2QUHt7KClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUpekgKR2Wrw2sGusV+YLat3RC6Hivt+NCzzSoJDx1o=;
 b=WYbKlDPLqC26UrLeG/5dFJ7O5gG7eeQ/7eWrxfP5btSCbtmK1xjWAX54BB3tU4lVrzANlRnf5zzzi5dazGJXudxfbSHN9Kcy28WeKhD6zyw+UUqvmvtD312MvLwq9RRdd3EGk3CvBnm8NCei9O9bjfLxvKwt2LUr6KZPdbUsopo=
Received: from BL1PR13CA0186.namprd13.prod.outlook.com (2603:10b6:208:2be::11)
 by PH7PR12MB6563.namprd12.prod.outlook.com (2603:10b6:510:211::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 03:40:33 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::40) by BL1PR13CA0186.outlook.office365.com
 (2603:10b6:208:2be::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.7 via Frontend Transport; Fri,
 27 Jun 2025 03:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 18/33] drm/amdgpu/jpeg2: re-emit unprocessed state on ring
 reset
Date: Thu, 26 Jun 2025 23:39:47 -0400
Message-ID: <20250627034002.5590-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|PH7PR12MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: ac8bc903-5ae9-41b2-ad04-08ddb52c5eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IcyfaPpoa1QCMQxBFnbx7wCVPBBUPevZFizOjf6YDM+slzXOqL6HRCVUGGDw?=
 =?us-ascii?Q?eGXtrZwqso5Yfev5nkvm08Vr/xeQXe9q4ZsdbrbK+TBMyk4NhhgTYXVIX6KD?=
 =?us-ascii?Q?Fm23JdGWmFYdm2gIseCUr/Bgr5VMJYD5YCKKUUP3ZMk8fajNiTI0B5XhY+V7?=
 =?us-ascii?Q?6MJIMl8FpvFtjRXp0JJzP517tmUzRUQ8iIMa0OX2nXpm1dcpI7frrTwTGR3H?=
 =?us-ascii?Q?I7+GVTudGy7FFf1O4YWH7ngOaX5A3bWRSDlfeWWG0gnG7uSGLLW8V/zPBlP/?=
 =?us-ascii?Q?jTEzsNwjYx10kUSE7YuHp9PfpIMgABvbzay8F8N3o19LQXdeKmx3Z1YiOIWf?=
 =?us-ascii?Q?uicNV9hNPlIQzOphdAMaJBoRLzHRyNdIPJa6WGnTsJqYk8hfSxP9DrleELAZ?=
 =?us-ascii?Q?C/4JwPmYpBLYqNxTD6O/akT8PzrX4X1dYC77H3JsBnr80chss5W4pFz5B5kQ?=
 =?us-ascii?Q?qGh8LXDZf9YjHEd5DtjvbveCSLKLZbl/9iGYiCRBmjm6wKJ2VQbYDu0lvJkN?=
 =?us-ascii?Q?uIDumkp62OdbT4Yu09qoEoMAIMsXd+eawYnHjbBZMqZgMekPOkiUW4iBEQxP?=
 =?us-ascii?Q?ADDepyVSE5bEWIPBoPm3CitP9yHOitTaP1WQkJ3TvJpUZXhh3fSv8HQLexpG?=
 =?us-ascii?Q?Dhwm2NbJfILVc/CkRy2BwAt+t6iVHB5omO7C53n3GZ1cDScjQcO+4zaxFmeB?=
 =?us-ascii?Q?8R4AITf0kFtX+z7ZipVvxUVoVb6msg+bYGcAkstPI5cPNeNZ+ZuphewT1If9?=
 =?us-ascii?Q?hVgh5MNRl5kpade5YUhB6EG+cGvfLFPhaR4z+8Mly3EcHunWdXyR66/lQ7IU?=
 =?us-ascii?Q?HUpvXzOhl4TdcfxyIK+eRxLhkshx7HaGjSsHpOF2n4LPvvDAAC7MnZqbH6m3?=
 =?us-ascii?Q?UJUwLX0E6etdWDbBLUzjUQGnXscBn4upCx/IMwcHEguvuicfLVtJ4KBq36DN?=
 =?us-ascii?Q?qC4pxe66lOfE4JiYyU2ps/4f9zzAEZwdzqibUAQtb3wk2M43kGsYtdAnNElI?=
 =?us-ascii?Q?Xa00eHnpWDAbuJHV0vTeGu8EJ2xF3eMe7ZC2ke224UvCSF+rP0BvVvLzrCr8?=
 =?us-ascii?Q?8387Z3TUcQJQyz4P6m8V4saO+YyI2rkY682Ig51VO1AqsTLlzXYKe8vJ3B+I?=
 =?us-ascii?Q?S75OOFCDYlyQ6EmrAHH9WPlsMy5agc6nT1ck+flXXfwsuvce8aMlZ0iRGnCD?=
 =?us-ascii?Q?1NzeikbIrxHa6XTTHOL/MAGaODHWOIIHOCo4bMFXNMKyei66CHVtjv7v8Ldh?=
 =?us-ascii?Q?E/6nEZgx2GesW7tEMCkQbJ5tNwTAcJIiXXtO629oZy8z0WGQLv02NjaWM0n2?=
 =?us-ascii?Q?//+9uvs3AaaoydZjnsywj1lR0mFmg17VNf+bQJQI1ili13O7BGc2WY3ZjDW9?=
 =?us-ascii?Q?II8rcEg7iDdC1a8VHYxib8FmPc40sLYzIeOFoYlm93Vb8iyiGuCJx68SmoaJ?=
 =?us-ascii?Q?P+h+TwH3fkGbltkkQBOOMbLNVW4BbY9KzRgmp1h970aa+mIEcePyfXdnlVxO?=
 =?us-ascii?Q?yDcLSOmwEL8ya5oKM4haZQw3lzJRufHo3hza?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:33.1640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8bc903-5ae9-41b2-ad04-08ddb52c5eea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6563
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

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 781a5a8a83614..cb66eff499662 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -768,17 +768,10 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v2_0_stop(ring->adev);
 	jpeg_v2_0_start(ring->adev);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
-- 
2.50.0

