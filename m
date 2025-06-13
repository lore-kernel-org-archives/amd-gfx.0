Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6B7C7115C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA5C810EA66;
	Fri, 13 Jun 2025 21:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3n2Y4Gxm";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8533E10EA64
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmAB4yG1XvnD45wPqsPvMOM0dAurpfupuFyVJiA/2vR9TZcqucJrzXknkKsT+QmTMg8EIMm+CVMMX/Xj5YY23uCUWeRe8/O9wQ2YU/GrD/L/Rgy1ZgdrgUPuFFQu/NeW5tjXPWAFKUCs2tbmk7Lw8gAcuCpYEJ/OQ6UqUT1q3HmlSbhZmdj5LNJdrHCL9wJ3LqXwbN0sMPiEwJ7R4qlQAuEumHsT6KwbcE2ujp1n5+gLHMPvjP0cS+MsxTlTRGHpdpHAqjnG5NA7STMSrEXMWktKteM+t8Va+k1Ffsz6B01qyfa9CGiHQsdn+Z6LFN0Fl4oLmzymz+e0iIO8aGQ1hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJsMaQcH66+MBhvkDEs/Pac1KrFjHIQy+tc7BqiL7Wg=;
 b=lZTjWJlR5UwEEl7eD/7wXNZGijwRdl3FvqecL6g5TMjJGCV0MixaGFnKLSuVQcZhDbO1u3Ar3EJi8eBQGbvmSp3maGKxEJsYYD6N4kDeR1pI2s9I4cWPE6bUa/xRUwOMyhgjO++fPMM+mHfJE3SsnSDkjFGXb+/D7JJlOlQih75R/nvl1sQiUnrxl+EU0f+0ZKm3kpwyWM0SZe7RTKZT4gv8k3LIls8tcMGZZ8xx+rBqZe7Iy/kLRKdC69e4BxZ71ql6fMsQZVDw6L9HEfP7vQApgC7jyGWJSvLBIjPMq9geNTfeE0OE8rJVEhEaQ94iQaOSFlyE1L61RlCi7a2vhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJsMaQcH66+MBhvkDEs/Pac1KrFjHIQy+tc7BqiL7Wg=;
 b=3n2Y4GxmqolT02u53QX8khbry8ctn/oca7KULRsb+6clnsR8c+WFYA1e4cVyepZhFhJ8TRdsXRviniXH3p6vwAgp/v1mUhuqHdvlnEm6P48oVWQGV73ccIYBJxNuCVcwlhbI7qyQ3GOJuUvPVEouXqn3xWNZIVZJt6Mz2rcxBhM=
Received: from CH5PR04CA0015.namprd04.prod.outlook.com (2603:10b6:610:1f4::16)
 by PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 21:48:12 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::d) by CH5PR04CA0015.outlook.office365.com
 (2603:10b6:610:1f4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/27] drm/amdgpu/sdma6: re-emit unprocessed state on ring
 reset
Date: Fri, 13 Jun 2025 17:47:35 -0400
Message-ID: <20250613214748.5889-15-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|PH7PR12MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 15d69a00-8466-4783-cc4e-08ddaac3feaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0W46JQ21nX01THQYHT3hYbHC13kZK8DKPOBcRnqn8faWPbx7VDcSGut7ro9Z?=
 =?us-ascii?Q?iiRLZcbrWA0gQ189xrxS4ucH+y9begySS9j7/m4wrfRWNFP6w+lnkzGikyfY?=
 =?us-ascii?Q?0dtbWJJPCuVIUbq3SS0qoXOx4alqk2H1PQ/Hq4BKUBVXhkzqXYl7hbc+Wvb2?=
 =?us-ascii?Q?JMuyYj1TVDA/bSpfYwv4aGlQXhHOwQxVrp7yIkp3gLh8Hiz4GjSq2P3sKKTk?=
 =?us-ascii?Q?Q7e7vNoFwnetK4qZVKu4f/wnhhyWe9gaPBp2mJRp/1g2tie/NdxNxw4Hig9R?=
 =?us-ascii?Q?LOWh8o7JrX2AF2nIEv4dogaOb4+yU8rboVAEeeMHTLKrZA9hMGSfehyZPBZv?=
 =?us-ascii?Q?iHU0Lwg+hdRHJHKkqNBEElK2X1FIC9r+7CwaHW42FDJ5REkq/P5aK5wGAGlA?=
 =?us-ascii?Q?j1tLbSPqeVDWPYP97Jk0N4xr4RUNDuONxFBwBFpmd2lLZCfsY8IvNt/NKUQW?=
 =?us-ascii?Q?G4rEiScTaCRozcO+Q02Q/Fe2htPUI40t+aGXvLM4J6d609jzl8YP+FLAWzUp?=
 =?us-ascii?Q?Ujgle5cEf3KCAmkCxQJh6sm+uhh06XrAF+J6A1uP0uZUIJqo+aP9l4eI2rMj?=
 =?us-ascii?Q?dSaDP8jxBLHjbwUvutvLNSMt7EdPPfKdOyHbGaaftuZ9mCe4S9KnwMEGc5yH?=
 =?us-ascii?Q?nbyYCWxDfZPURDMG/14gfjKhBI9+fqOAPxjzIGoo+H5yj+OV1Sk6I2eijjwa?=
 =?us-ascii?Q?1O4ishTi5TtKcPIS/AQHT7gBKclN2BZCYRl8yYoMrKbtXiRWMbOXzEZPHbWU?=
 =?us-ascii?Q?EXwV+H8LKARrwK2m2g/hR2VMwx+llyB8GzwaqzbvlE0F2x8LxJw+jC5lN811?=
 =?us-ascii?Q?a7ua/tAGUBF25SSNMwri+7LgPIRlZWTSNH4ZrJWmZuTcxoFjQjbKUMnqKal7?=
 =?us-ascii?Q?fLt16SJVFhYPbjTrkik85HzX0/5tNFIb0VU/efNtEG3BujZ2kx8r2fkjLY0s?=
 =?us-ascii?Q?q8LvLAyaLOi6uMKoS3jsCuJMtATAl2sivQYLC+1ufy/bTe4Ge4Bh7cgwRv89?=
 =?us-ascii?Q?t+R2xjUPOt1k+MhMJdCPxjhA3KsUxojMD5gsJpxevAa2W8oF/bcXyhGYtkKW?=
 =?us-ascii?Q?ZByHek8WUy8rEotBjI09RYYuxxTMTFDbaE9czUKvB947XF/EvE1id6vsV7tM?=
 =?us-ascii?Q?tkrdHB6+ko1/6jZ4709rw9BwnwrdBOTxod7hPqTLzR5FMGK29GanM4TP8Ekz?=
 =?us-ascii?Q?dIU7813AuaCRinDlP5Dcug/yoSJb7P4V0AKcZZONiQUNCIkhFLoGc4n2h/1j?=
 =?us-ascii?Q?Gzlrkx92I1vRKFYLwiLEMZQPFVIv5vK4G7lO459YPFyAHtndVAqQIkOTcr5y?=
 =?us-ascii?Q?clmu2dJSE4uep15qDIQ/z4mocUzptZk9XnzAvcjb2ErLIfMWJbMq06rX0rKu?=
 =?us-ascii?Q?0eFzbJv4uqzAuG2kz/joVFSMN7qkr6N22fTOEXVXuDTl48GYzjYhwn9gbvPl?=
 =?us-ascii?Q?5VhAiwWK3uqXslQ3yd/kqHY4qYO/7ThxXeHEj55ThvIyePVB3GdHWWRnDF4K?=
 =?us-ascii?Q?hJ61mIXiCo/q4vvM0QaKfhHwp96xm721sFjL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:12.4205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d69a00-8466-4783-cc4e-08ddaac3feaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561
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
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 29 ++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 595e90a5274ea..00c7f440a6ba0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1537,11 +1537,23 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	return r;
 }
 
+static bool sdma_v6_0_is_queue_selected(struct amdgpu_device *adev,
+					u32 instance_id)
+{
+	/* we always use queue0 for KGD */
+	u32 context_status = RREG32(sdma_v6_0_get_reg_offset(adev, instance_id,
+							     regSDMA0_QUEUE0_CONTEXT_STATUS));
+
+	/* Check if the SELECTED bit is set */
+	return (context_status & SDMA0_QUEUE0_CONTEXT_STATUS__SELECTED_MASK) != 0;
+}
+
 static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 				 unsigned int vmid,
 				 struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
+	bool is_guilty;
 	int i, r;
 
 	if (amdgpu_sriov_vf(adev))
@@ -1557,6 +1569,10 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
+	is_guilty = sdma_v6_0_is_queue_selected(adev, i);
+
+	amdgpu_ring_backup_unprocessed_commands(ring, is_guilty ? guilty_fence : NULL);
+
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
 	if (r)
 		return r;
@@ -1564,8 +1580,17 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 	r = sdma_v6_0_gfx_resume_instance(adev, i, true);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	atomic_inc(&ring->adev->gpu_reset_counter);
+
+	if (is_guilty) {
+		/* signal the fence of the bad job */
+		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
+		atomic_inc(&ring->adev->gpu_reset_counter);
+	}
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

