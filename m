Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9365D38FEC
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 481BD10E61D;
	Wed, 14 Jan 2026 16:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ywVmVOcl";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DD7D10E05F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:47:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rw6N3dLrGQsKr3Qh75uY7V57bI9/dZvqeOzMYwbLw3ypeAAnxs79XoZhrKs9gftrOXjFP97jgLRmMPUavrcdi57rrj1H6Azeote7ZRWqnLvXpr411OxzkPFzmiFkmDpKaCkO2wEjQ96lA2jKFA8XcLTvksa0x+4gqkb/7/428rk+pxx3i2IiTPB654tfsdYRD+ldOlq6yMDrVwn3gvQYCHSIbKf6s6Y4wKMFBjn8chfhKmGaz1cgXqggnqlG5FzyGo1o5aWCYUyOsUM+dNWLdB9ZsOGG/fi1smSzBVziyeC0E/I/ngl9dsEicR8eFMpBcuzVHxc5+rBnFjnPkVuFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6FSnYzs1uJzBGByByaVmXOWJ2jHBh6U3RMG2xpQ1F4=;
 b=Bonkqvp5U/TgYW6uDKg5GG6wDLAHsxZ+x6ABP5813HN0H6UcyezydMd0gHDn1Njo+e9LTBmimJPytDEizBlmdxgiOk15R+JglZFK9xME1EerMhEWwPUsyTJMokfdOiC58H0EYwfkr1XBJGuTW6IMmWm8KWHmjIDCCwuRCnPVRMQrufrNoukF/M7shCeYa0yW+lp1OVgzdnfLXUqqHH9dn9yqU3eTBw20ArFehXhZbG/kidyweWPWcJMUjw1NLQc/rKOA2TDV9utA9tMG8Wx+cZq1LXe2iA0qUNXXfFwCAEJQnD4xhtvVYyVZiVhLs7mTiVle42p3fGbDaUGIPHi2mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6FSnYzs1uJzBGByByaVmXOWJ2jHBh6U3RMG2xpQ1F4=;
 b=ywVmVOclJ620LsR2mlnTMUfHweShCCiHHvZYN17ZgpdTfpmjY7p+OVgU7zernasKk0/3Go/FNLffVwImvBK//Ud/Li+lZtgW+TT3WTvInNNXi8ibssWYi7+MXpPiXDm3kc17cMEAZcce2IsD/b3z6+NPt5flnHuF9jgLD4cpLsA=
Received: from PH8P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::25)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:47:38 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::f) by PH8P221CA0007.outlook.office365.com
 (2603:10b6:510:2d8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:47:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:47:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:36 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:36 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/42] drm/amdgpu/job: use GFP_ATOMIC while in gpu reset
Date: Wed, 14 Jan 2026 11:46:46 -0500
Message-ID: <20260114164727.15367-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9907f6-8f0d-4c8c-e76c-08de538ca082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zypd0BCxxGJpeM6eLDW8H/E/XlzKJxwA0c7xIprGdHuudkxpSSli8LuRl+I8?=
 =?us-ascii?Q?mDQUYiOqQPc8ltk1aaRRXoHX6AFbXRT9+FQBHXuNOHIc2knH6XA1WLUWX/8P?=
 =?us-ascii?Q?Y0ve7sP35+qG0CurnxwIV9xpZTg2oJD6hOBarxzJKf5wXTi0mT0ry4gJQPvI?=
 =?us-ascii?Q?EBLafnrIN3v+9KCZ1vbw40ppyJqXbcbEOua/Wgb5X7aSH9rlVyxoiowXxfr+?=
 =?us-ascii?Q?x+o6+88XAsAtjOmc0aC+RajtY75cAej31Wv1Jr514rHbk6S6LsEByZNe0QOz?=
 =?us-ascii?Q?n+iWJr5iFS9r7HrIYtwRw/lyD6FBut7jcO+RrK+GiE75VxFadDdFYDT2itN1?=
 =?us-ascii?Q?nDF8HY+MAuTb0BUuXbBv6DkT3bs3SJ5E024tva3csIhSzQP2SoWI1sncyA++?=
 =?us-ascii?Q?tYAf7pSvC6FxtxghaP80tSfHBZ6Un7Du5gr7XV4gjRBb6miqjsnWwBseRJU4?=
 =?us-ascii?Q?mUwVR9w8cokTZYllWaHhK8PQ0DDkH4hMbhh5C5yN0NQTHfXYyS8Og+ZbrEeW?=
 =?us-ascii?Q?9khPzHIL9OF6jLBolslmVgGac3hs1AxMhsCHjNKf1sd7yIEI9GYdaxqK6/15?=
 =?us-ascii?Q?hCMPBvrsRJI2r1TjOUypokzmKiD9U2e1jOrtdBo7IpTxN9NL78D5OI2TB0sq?=
 =?us-ascii?Q?30pPGoqy8xqJU2TZquqA5i/X+1eGethUIxgQbPYmz6ZO5resyA6rO8//IEuX?=
 =?us-ascii?Q?iY0lTPpk/v8dYE6mw8dDHdS5NbgnfAzvFyRQHX/yRF/ai3pn1fNXJieWzwhI?=
 =?us-ascii?Q?flmKgP0KD4HyeypQRFjqxdjBagRQyS1ilMxnYUr+smf1BIqdqgt1TvEBD8le?=
 =?us-ascii?Q?PW4xdbtrnmO8C3kCiBtdHDMWdXxXI09lPmrspTkntgARnnqrsSHif5GufDWP?=
 =?us-ascii?Q?F6qLDGSfzHYnJnaFE0PwqcQeD21G+GWt+sNfNzSbYZWHpJ2bItH/sHgtUDNs?=
 =?us-ascii?Q?WFfVQ8MfdE6wR5RNCysKZpuiUUCkd8waUwZkuTv0SnkniePo9LcRcUOXHCOq?=
 =?us-ascii?Q?8Qf722SoDRVHkou0ZdEnSCbm5HEHSETqCiUPO/rEYjDlBzensKd2HfCiyxH1?=
 =?us-ascii?Q?EnyccSS9ThyHyX+kIXCKiCL9VpBpSgC5vTuYSvX+vGStARyHlyRTceXZL+pL?=
 =?us-ascii?Q?9OFEuE1KWONa9xn1Kurb1JpwAzjRlu3F/geoejAyWMoswjSvUSUgkhS/iJAd?=
 =?us-ascii?Q?+rLhJB/kGCBeSVPxKn2d2xkVRFgwRgZOu8sug+3x0+rx1I4TfyGyuu0mbnBv?=
 =?us-ascii?Q?VYrT8SbCACAvyubUcGBJXlcqlG1h+czx2L9bby4qUmENkwqM5RHDkukvD74L?=
 =?us-ascii?Q?eEYOy08JWBnYy3lKc7xdOFuEUrG5wjeZXUuRrD4xhNxLa2i8Kqtd8j+7IUkK?=
 =?us-ascii?Q?JkZYVrW0dQvhl0c5qt2CnztyJTrX68MOKzbbm3KPBTQDQc825z36KFjto8qc?=
 =?us-ascii?Q?EnLBhBTYofBlZM5EnZdt0bbasfbmhVc80NVTX7LptyaK/9JDmDkbvbIYDvhr?=
 =?us-ascii?Q?qL7K+OEkN2upY1vyYVGRakkKzoCC0/bi8kOrWiQ/+fAi7PnCPcNdzhqgle5U?=
 =?us-ascii?Q?7JA49rcRbj6FScesbb1XCdKAgteHMFmNZuRuBp1OlgwluedzPD8w9RTL/AKz?=
 =?us-ascii?Q?kF465tjZw540+t7Wgbc8crxnKysCWSH+Jl+IEWhLtfIC4KgLJG7uxTrpDNlT?=
 =?us-ascii?Q?RGW4wA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:47:38.5784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9907f6-8f0d-4c8c-e76c-08de538ca082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465
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

If we need to allocate a job during GPU reset, use
GFP_ATOMIC rather than GFP_KERNEL.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 9 ++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c     | 6 ++++--
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 72ec455fa932c..136e50de712a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -68,7 +68,7 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	int r;
 
 	if (size) {
-		r = amdgpu_sa_bo_new(&adev->ib_pools[pool_type],
+		r = amdgpu_sa_bo_new(adev, &adev->ib_pools[pool_type],
 				     &ib->sa_bo, size);
 		if (r) {
 			dev_err(adev->dev, "failed to get a new IB (%d)\n", r);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 7f5d01164897f..35c19215a2e0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -192,18 +192,21 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (num_ibs == 0)
 		return -EINVAL;
 
-	*job = kzalloc(struct_size(*job, ibs, num_ibs), GFP_KERNEL);
+	*job = kzalloc(struct_size(*job, ibs, num_ibs),
+		       amdgpu_in_reset(adev) ? GFP_ATOMIC : GFP_KERNEL);
 	if (!*job)
 		return -ENOMEM;
 
-	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
+	af = kzalloc(sizeof(struct amdgpu_fence),
+		     amdgpu_in_reset(adev) ? GFP_ATOMIC : GFP_KERNEL);
 	if (!af) {
 		r = -ENOMEM;
 		goto err_job;
 	}
 	(*job)->hw_fence = af;
 
-	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
+	af = kzalloc(sizeof(struct amdgpu_fence),
+		     amdgpu_in_reset(adev) ? GFP_ATOMIC : GFP_KERNEL);
 	if (!af) {
 		r = -ENOMEM;
 		goto err_fence;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 912c9afaf9e11..7ee0cc46b4608 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -339,7 +339,8 @@ void amdgpu_sa_bo_manager_fini(struct amdgpu_device *adev,
 				      struct amdgpu_sa_manager *sa_manager);
 int amdgpu_sa_bo_manager_start(struct amdgpu_device *adev,
 				      struct amdgpu_sa_manager *sa_manager);
-int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
+int amdgpu_sa_bo_new(struct amdgpu_device *adev,
+		     struct amdgpu_sa_manager *sa_manager,
 		     struct drm_suballoc **sa_bo,
 		     unsigned int size);
 void amdgpu_sa_bo_free(struct drm_suballoc **sa_bo,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
index 39070b2a4c04f..fc13969f8ef49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
@@ -76,12 +76,14 @@ void amdgpu_sa_bo_manager_fini(struct amdgpu_device *adev,
 	amdgpu_bo_free_kernel(&sa_manager->bo, &sa_manager->gpu_addr, &sa_manager->cpu_ptr);
 }
 
-int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
+int amdgpu_sa_bo_new(struct amdgpu_device *adev,
+		     struct amdgpu_sa_manager *sa_manager,
 		     struct drm_suballoc **sa_bo,
 		     unsigned int size)
 {
 	struct drm_suballoc *sa = drm_suballoc_new(&sa_manager->base, size,
-						   GFP_KERNEL, false, 0);
+						   amdgpu_in_reset(adev) ? GFP_ATOMIC : GFP_KERNEL,
+						   false, 0);
 
 	if (IS_ERR(sa)) {
 		*sa_bo = NULL;
-- 
2.52.0

