Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0557C71156
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A3FB10EA75;
	Fri, 13 Jun 2025 21:48:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1+qbM6xK";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D1B10EA6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o48t5e94I0iKPP/XFlUrXDjvPcLMJs42T+kIoMR5mPny+stcUIjC+kErSdGuaiZ18WQyKZMsIbmVjE90xBCoyN4FhbW2Pzvd0C9Gqw6iws0/NEwqu4ZJhrfZE3teZ9srjBeHg7S8eRlE0gf2cMMb+KtB3cM+ETNoD0u8xA8aOYLR/tVuAEi7Bu/3Ia8saEknKjYgtd5CvGEF7e1mJkNCYUjRa+QnfQT24lWmPfmma2zYxr7stde8uYno2vz2tCBhh+qlUz6JwMCd/O0CgAMmh/nOyZ16wtLwmOZGpC4Wl7ipVCff2uyw+tGMqkfsfYI+1QG42+7I193RRVKGc20DNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUc3aHgWoDXrG4LAdtlybOdYkkOhnz2muVc93n9MxI4=;
 b=L885NQ/tfKzA1lGSy4XFygVIivxTi51iqvxXS/AZ32v6bnRDHgRN1H/+Ckm0h9yLJNx/93glf2+u90TQnH3uy8o+fBFESjHvxtX7FhLOXxHoTcW3msQ8ZqLaeUXWUgtQ9yMeQhodVcczYEl3XHdDvzU9+qi6xU+dwAiMbVP5NYCpnyH9upU/k44cZ/YeD2Mi38v1Snfzyx1HsfXbj2HO0ECYA4yziEJ0iXeMK5e4fxkiz6gYYjwY4+FPARgCziQI2LPydsvMf9KH3DGzhYHGLcPymY79PMfUurIg2Fps67r/QrU2LHKukRiqf7aIw5+OyDtWfwCCCLNQC7Gs86rIjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUc3aHgWoDXrG4LAdtlybOdYkkOhnz2muVc93n9MxI4=;
 b=1+qbM6xKsmOcEmhWzQ7dFe0GNtQhRZ9T00iRvi+HKab+uz+WrT9V0O7zuNDPceLRDafg+fuQGUi0uCDOhEQh8U/O0kdfqU+F4hCnMSy62AFSJbHIGL2oajoG9shbYuLG2vlNT/RZw+y56XSCARIktbrBVCYMBtEbOVDu2tDtf7s=
Received: from CH3P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::33)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Fri, 13 Jun
 2025 21:48:19 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::5e) by CH3P221CA0024.outlook.office365.com
 (2603:10b6:610:1e7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Fri,
 13 Jun 2025 21:48:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 27/27] drm/amdgpu/vcn5: re-emit unprocessed state on ring reset
Date: Fri, 13 Jun 2025 17:47:48 -0400
Message-ID: <20250613214748.5889-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 097310ea-b69f-45f8-8e98-08ddaac402a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MU84BymIBz0v4C0Vf6igDZfvrp6YmYgnH8cnjkhEMk9c69VdimSyU4jVrMtv?=
 =?us-ascii?Q?qlxHMC0Ttz3PhfFMrAPYgHjpSwizdQDEi4xsQNmqt8DvKSHN2da5ipKKcJuD?=
 =?us-ascii?Q?5MsNp9qISTHgueKjo4/fVG89Xs9lFyz6bBVFX9RuCfNrXEpua98pope+4iky?=
 =?us-ascii?Q?+Xp97KBiPywFN+/cbJEuoUV0WNrCycoiuhz/hh1/v+/ta+vNHGrQbR2Hn7FG?=
 =?us-ascii?Q?G2zplfTxNnOEO+KthCGpAEIYX6kca9/0JAiKu0HbwO0ohMY0M7NiXbMWT8sT?=
 =?us-ascii?Q?U3hrn+IqAm8ttGNao+b78DyI6POwKKLrSUaneNTvwjPoU2090ItDUzX6aExt?=
 =?us-ascii?Q?YlChIMgZpJIpDOV0clIGA+u6+JgLZQS1f85MIgcF5uUlpKWLLl0zVH1CM6PG?=
 =?us-ascii?Q?rGTIELOthzDmhzz1XB/pKtVcjIUL/R4UhzrLPXZka2Y0qLfInT3btY5nIfrf?=
 =?us-ascii?Q?RKAsCzMnL6uQhZnxvET9c3JwepkUu6BSUogoqKfVGAiMeNx/Z3P6VLXN1cLB?=
 =?us-ascii?Q?ZHUkxpjcUGIKzomeQjx08IXbaCU7X1UcW0G4spTCo5mFmOWs5JQt81zc+khO?=
 =?us-ascii?Q?202O1N+KpMbWvDlJdocgvrOpThmR0ZANflubDnNzAtvvgfeUcv5ew9KDL1NI?=
 =?us-ascii?Q?eaKPReTeL/yTTfRwg1GiS4B+3mvH2PBn05USN46u86dvIrR+I3SkIU1M5I1H?=
 =?us-ascii?Q?9tdGCJQdpHeWhhEqzJynBBUBG77Zz6cfANw5DbY0RZ66t/roKEMCa2c/WWDs?=
 =?us-ascii?Q?CxKc3CQFb6v/76bEk2pPbsFFyIEVZbdZF0ay+Jg0Auj8uTZIa+vt7qvIRdgu?=
 =?us-ascii?Q?ZZGTXf48CvSS/GGLN0o+GC753GPP1EQ2iglsjvcwDPH7g2Qurem/PxbWvFBL?=
 =?us-ascii?Q?joVca3z2NO8dX/Uo2mGgZTAQmNC+xdC6uUezKsMJQ5OnYINT+SzgvaTRLaIm?=
 =?us-ascii?Q?hEKqGy7WqBf6fMKWED+yhzHe24Ic4jAggPbN4drhAozc5TcDUKsZC6v5fqIQ?=
 =?us-ascii?Q?kQFb6nhMHFRJ3pAfjA703NyyT+VAPQkALkGy/YfRnAjxUcmKIRcAD4I5QN72?=
 =?us-ascii?Q?Y9YXuP2WF1FUZ6JaSzeUdBvPwRcZuvxCPCL5Q3rsUxnwJPOolw6DWT3sGFDO?=
 =?us-ascii?Q?55F483WwgwGPfhW5I6UDqOVaZacPFKgW7BXDmS64/5TVOcCfBoEfX/ikvwXR?=
 =?us-ascii?Q?7oEhWgPBZqUYcUWYrUf4TrQklY6ih5m596gPJjOa2XVByfDGaW/gUMR8eESU?=
 =?us-ascii?Q?RlVP/M4TRM8ReRdkq55Xiv9RPZNsZ0diLMzkcRfoKmRpATjWN6mhXSMJ0sDy?=
 =?us-ascii?Q?Yir19cxqXpznIrvm+Zdr5ghoMYO2gguPDAkQkCm/f7aQGC8WAxciwEdf0wLF?=
 =?us-ascii?Q?jPSPITReyIfz/lhv9vZLHbLUVXD7OIaBcD/Uf4vSEhJL5RMiXg3phGwIicbD?=
 =?us-ascii?Q?FbGJWHPh6AjjDTJLbo2U5aw9VbqItNnvvLgtBuFrUZhR4xG0gajcM//f9Lm6?=
 =?us-ascii?Q?YjVcaSucg0b6ktGZmJu+8GAhlS0qfLtgAS+c?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:19.0768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 097310ea-b69f-45f8-8e98-08ddaac402a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368
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
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 64f2b64da6258..01bf3bbe8cd93 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1203,14 +1203,22 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+
 	vcn_v5_0_0_stop(vinst);
 	vcn_v5_0_0_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
+
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

