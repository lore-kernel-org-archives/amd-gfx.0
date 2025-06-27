Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534FAC83013
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C50310E946;
	Fri, 27 Jun 2025 03:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V61VmINR";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3EDC10E940
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggoowbSiBz+7NnATtCyERV2VSNY+pZMmOSVLTfnE1LE3mYE7EcMf6P31VeCO4RgO9t8SRja7GZhcZy5PlQjQ5vycxvD8UJ4JWOVTzGrQey7vdBbMnmGDZNMlfMe9AW7Y0Xk1hVRigq25bZGo9feK3smqTdbgZhgkXh1sIwfDrC8TOum6aXTCYOkZ3PpJ5pP/pmPVhsrHfk1Kk4T8gknOWkOOQO3a3FTB16eHMkzl6v0i0bPcPPwvPHtJUQUSD/syyMyckqe0f0yQZBp2govgsY3DLaw6o5/h5O7haikOwzbWpxtWzicctqvmgGEDgJ13XAk3lwR29cwxJukfzxGTFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VI4E8H730ZyK9YYjWgiBThhhxn098abzxl29nMwaZXg=;
 b=s01I/vUUrnFThZx/+kwr5evMNGtlIBfYtMp3IjsbiPn3WecoiJ8t6UHLdh0ZS1l7thrum4rY3yM7RAa0TSinh0KEH/RBPqPUPyqVrpiDMMV5EuOGXm/9bIKgwJ1WiBYqvhdj4pmg6jUIC+C+k3pab5FaeE69wiYeIeKbgfW+9hIL1bmZU1fMBwcGOc/440imzqpAR8OaXjgCCiC7YUIVW7dTHqkxbSRQPot6cNNwbzWYOg7TQG088mXo/jLU6i415zhIfsbxovWEQHfs0JdENTcX971kd95/iqscpWSdWOe+Guv7jec/hxaWVR7WKMV/eE+13IuihY9QtYPIDIRoNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VI4E8H730ZyK9YYjWgiBThhhxn098abzxl29nMwaZXg=;
 b=V61VmINR4eAyETGla+C+tHaI3Ev/8hsA4PTqQ6gs07PlZblaA1LinC3mCPu3jpLsYKuKeRVeNtwLwXhm2RYAD/6JKF7lgyAReudIBZUKSZgSF8ysPZe9DqmhZn7RoXdnMXMpu/epesJFTA2KzbdYreFegr791X69lZfr/IV46XM=
Received: from MN2PR08CA0004.namprd08.prod.outlook.com (2603:10b6:208:239::9)
 by DS5PPF016FC81DF.namprd12.prod.outlook.com (2603:10b6:f:fc00::644)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Fri, 27 Jun
 2025 03:40:31 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::b2) by MN2PR08CA0004.outlook.office365.com
 (2603:10b6:208:239::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Fri,
 27 Jun 2025 03:40:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/33] drm/amdgpu/sdma5: re-emit unprocessed state on ring
 reset
Date: Thu, 26 Jun 2025 23:39:43 -0400
Message-ID: <20250627034002.5590-15-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|DS5PPF016FC81DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 641fa1e1-2488-48e1-4621-08ddb52c5de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZqBoHeMMeqlyzlLLa8Dr6r/dqXKtCAoGPSuNqxTkHw002PemGLr2b21Mxqlq?=
 =?us-ascii?Q?MrYo6XplqbPiz6t5MSm/VnCpq8C3poKxVWPDkxEKnj7d0GNRHum4r6YPvNU4?=
 =?us-ascii?Q?TBJ0A80s90pml8kVxCjI/fRkQqFJAK0tYDY7zkg4BnqiHk6gBmZIS9kshQkf?=
 =?us-ascii?Q?ZcXKhlS+PTfsM/nN4XRsZm8JRVzlK5Ds38FRIPPr+bmej7sJTd1J3cBiCFVm?=
 =?us-ascii?Q?1rv6O/7l1EcVrUdSABBd8BTidI7+wBz352egVwAodMa+tce5SpHgh1zNKkEf?=
 =?us-ascii?Q?eieNMA27Iv2jsBWFCIQUcc74Rgqptmqzrfnjqesl5pdHT/0WALGNAzOniK6A?=
 =?us-ascii?Q?x4GXRH6Kh+aq1KYn7/s4s51yDlwTl+h+2woECkGV2e3hnotvHtP6MKbtiOxy?=
 =?us-ascii?Q?krqPAFxnDBL86wFQ6Yc0qqjVECHKmdZBEjNSH2UaGqEFKLUfbmUR/OqC1e/m?=
 =?us-ascii?Q?dGpTQmbIhLe3wZCykWsRVEwBn5J1Vjwk2KR1Kez8viGZXaKUQ4m+z8LF+up9?=
 =?us-ascii?Q?nWy8wKoxJYyZRPFJf9TsnrWBZcqpuSFy0xNEIYUj3yq7zvYXfvv/VdXLFMcX?=
 =?us-ascii?Q?CAxamjIAjVDlBTJD9PS2uT78BDZ9VNRxS/OAvXs44EWzNf+/TW+L2/eg7fBb?=
 =?us-ascii?Q?Gb353LizuADTe+L+jaVIFZJ/p4Ri2z3NqY3MrP2ka2PFpCV1+ziRCUtCkFEH?=
 =?us-ascii?Q?NHnxZUxNp3wniZO81aB4+ZvB9ywPF3XJd0U3bCPhPka+2HvhhjsEnzQZf3ja?=
 =?us-ascii?Q?pOz9mi9FeN8Y7t3MTlzxeOO0n9eVktztGNeOMCdCv8UZgVlW+fs4LqeHmUgD?=
 =?us-ascii?Q?tW96IxA8zfdtqXi5LgD43IfcSmF5TonVYumjvuJ/vXpVdU+mSt38gRvQl17q?=
 =?us-ascii?Q?Mpqjs1hU/82nuKlXU892TGr/Jn78dDu3muXgwJM9Mezf1kJ/j2o/dfZp4hpu?=
 =?us-ascii?Q?qUZxFFhSkORzcMLbos3olv/Rlmy0kR5V55SRC1SX23pBmkC3UFaXSWFFpSPR?=
 =?us-ascii?Q?1TSQYAE8CvmvxwQ3laROYFew6NxC4N3/nelkEe0k72PmPkUM5TwgX8TUZF8I?=
 =?us-ascii?Q?ZBrNAOAzr14QNEBHVW+30tvESzFL9u/EM0P72unQQt3oVjvEXOwjcMsi6rhf?=
 =?us-ascii?Q?ODqZbb9uYazuJ0rJBo6cqt87kRSjzPmZHY/5cIWmv0JcfJhK4Mf8a9aVRHhW?=
 =?us-ascii?Q?W6V2Nb8IQl3ae7ygwv73jbierf4M5qdNOpr8JbsJNNapq9MCrhbR8ob/6rcU?=
 =?us-ascii?Q?XptEJxcbEy9sycp8jbR+kfs6U4fDvmBCZ3Ey7p/8j6bTzl6i5qUQ2PNn4+wc?=
 =?us-ascii?Q?nbhCAcuP+3XtiFOhGmJ9Emf3m/2Yoc7Ut/pm4PmPsjEravtjfO/9zP6IqHr7?=
 =?us-ascii?Q?mcngJS60Zko14DhclEZkRmOnDMymGYa0CKYxOJWtnlpXJu2/LktjYuZsyE7+?=
 =?us-ascii?Q?CkqTt93I+c2gw3nXzkLTumaKbI8RTd5nIkupjFF+2xxluz0aRmo+ldE51Q5u?=
 =?us-ascii?Q?loQH5n1Em5pryj4Ur+NqbQe05KmTS5+vGW/r?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:31.4667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 641fa1e1-2488-48e1-4621-08ddb52c5de7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF016FC81DF
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
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 5f4c6a99b06dc..64210c5a7fba5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1535,14 +1535,25 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 inst_id = ring->me;
 	int r;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	if (ring->me >= adev->sdma.num_instances) {
+		DRM_ERROR("sdma instance not found\n");
+		return -EINVAL;
+	}
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+
 	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, inst_id, false);
+	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
 	amdgpu_amdkfd_resume(adev, true);
+	if (r)
+		return r;
 
-	return r;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
-- 
2.50.0

