Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2AFC3271E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 19:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E47D10E3E6;
	Mon,  8 Jul 2024 19:04:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ebNf3dsV";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A853410E3E6
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 19:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BD+v6ZyMWc1ix0xkYL/8MjZrPGGyPSNICzqZ0oVyNdZOFtGT+TPOTsLmhAco21iqi2W/wI4d2MQYbVOusFsum+MiYhd0tbK2XB6Ev3bORWNRZYkwr+4j35qKiN68CsbeuzdgJkGx1P4Qjz/j3OrfxRSUVIrtAhpmijvs173tHTz9oRBxtfG0PWw8flRKQR9OvbChKbM+SVqdA7M3tX0GazslLcE8SQLLoPB62cccxnG0O71HAdx5WgCGL2tkeqnb7/ch2ObMvVasiPTGQ4agZrp66tcWwQO6Qwa+sYbJAs8kNslwo3DTN7yFQ77hibNpQCaRFv4Yfv91XOhjpkEKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwemPGz7LHpoQrCes2Qb/mySWwK30ZlsIvNw47lcgG4=;
 b=hsNO8BhlLQzWSrR4GEOYAPFDtL+uzMLQsyzA4LEBxzUhm4UGDZFTjb3SjkkCRJIxUHlLlH/E3+U08GnK4tG9OqVWi8mhy42nEFV1iIaYk7TVPHgfFSgY/E0XU5NZ6koXgo4kXAvnbU2mVT3MYNkxiQLwuqsMu1q1TKRqKSWamvQtfSpeKtpofPRwk0e6xtFSYK2J1KuoBbhuvexkRh3RuXELUr7J/dAutKqqwBvKzc13QEiqeQFngEMo6TMjLAbdErWNDTJoPWeBt05lQJtKUxE1dF3sAhE001Qau2uNPNxm1YxgagX4nwFNFAeWTSDZPZ9EjihlsLExvtlh2uSQvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwemPGz7LHpoQrCes2Qb/mySWwK30ZlsIvNw47lcgG4=;
 b=ebNf3dsVnl6XDkRJWtz/EJzWE0VrFDrBjv7WzPTJfSrxaueJnr/TyieY6QKtRcG1nKv5W6i2gelgwFOgbq9dQTVXx3SsTrp0yuoRoOO2Acr6baGKdipfTnUkmeZSIZyl4NxdQX6RS6BdpbXA8hlPdQFidCZSPWvmoNi5+k4ZqoA=
Received: from BN0PR02CA0049.namprd02.prod.outlook.com (2603:10b6:408:e5::24)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 19:04:36 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::35) by BN0PR02CA0049.outlook.office365.com
 (2603:10b6:408:e5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 19:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 19:04:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 14:04:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/job: Replace DRM_INFO/ERROR logging
Date: Mon, 8 Jul 2024 15:04:19 -0400
Message-ID: <20240708190419.3615363-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf95177-6088-42ac-1259-08dc9f80cfa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g/8VuHheKv03RBbJolhA0HLsnMeNlZAoVRLfcrf38wfAIWvrnjRzaFKyaq0w?=
 =?us-ascii?Q?+n86iiFlsIzqwS3VmmmxPcsZL7Zsjd2itriNDHwXGGn3OzNO/ac3X12HYIeQ?=
 =?us-ascii?Q?ARBchTxkwhoyDf3goMvdF4zhpgJ4YAAeuG2D7X94jrcFHV5Mz5BZ7bwqtj0D?=
 =?us-ascii?Q?XrnHtUoCT6qR2Zs2eivmSilJeetRDbUOxioYNNQ8nkZ4kHam5X8Yurp9Qknd?=
 =?us-ascii?Q?xFJ3BcPLjs/gBlG+Yoan4tczt5kBm9IDpQC8trMsUwaWh1mjC0M5r87bnp0n?=
 =?us-ascii?Q?tfAEZfDQH560ew0AULfURGC9uCr44DL9utCDL7beEPy8iHfNlTfJhJolTvpC?=
 =?us-ascii?Q?hS4EbVJv092ArB+eTzfUiQNHJbSmtF1hhQNASDSwNSCEgl13t5wrmxiL1TZc?=
 =?us-ascii?Q?WssZ9QvKt7xGWEyWaHu3LNeOgPLgZZqJxuZeJtgCCXgfqADpSePQ1Qej2rhO?=
 =?us-ascii?Q?fMLPK8YsxWFfHAjLlQ2zwa7dQoMjE3GnjV6NVLqfDpi5ieMwXXpWYipd1GLw?=
 =?us-ascii?Q?A91jPvmkgTvIhAKSUqgz5l/WJD1NNgnyerF6oHv9+kcNKrGfM1++VZ1FDCjJ?=
 =?us-ascii?Q?MZDmYiSC+XOvSpD74UjjRste2t5B1eIxNIg6ioKlPb17Rj0J/YZ5+lPTpdSN?=
 =?us-ascii?Q?te1CzuXL8X6swDfhKh5ZFYs5vXhFxgWQH8T46J20duy14p+BAMQy4kKCWiId?=
 =?us-ascii?Q?KVuD55WTcmBEPL6ktHESitmnQNaHjcvTT0ZePvTCzWRs/dpBFyxc+Lc+ghkq?=
 =?us-ascii?Q?ZjBTENimeUtLsJ31HdGyc+Clc9xbDvCKNKNYZWFzdXF1SYUJ8R/6VDXclzgW?=
 =?us-ascii?Q?LxBz42OR0Yk/r6kgmMf2ZEkgcM59vwKO3VGKjSOCVtWXIJVqkkYW+9gsqueB?=
 =?us-ascii?Q?lx65IVY3SObxIbbXqau5JUwSj8DNYatkORb/7XNXM2THUb69woZeetOHJNHa?=
 =?us-ascii?Q?Gay83wA5EFVcIBtH8jqPhJCh1jKwie+GHzqxLF1k8uxDFVtdiX36xX+2yaKb?=
 =?us-ascii?Q?lindZsosv7VI7BKL86kZ5+0VWCMChoRjctg9WXIldEW+RxHsWoEdkP3q+Jba?=
 =?us-ascii?Q?W/KGuqJ3BzfdlRwZY6nZXcCIUWwV7fdwQHGN+3OElDspdsdwdRHz1tslzP6I?=
 =?us-ascii?Q?/uIqnRQZUrSZGRSuLK8CHMhc+w7mlgEp1A3yz8TsTQEIj71sTP0zgg3bXCQy?=
 =?us-ascii?Q?XcCXT5u3E/TvKQA9rSl0carXNifVK8MO0V5Kk0V94a07rtNg+fH4N0yHGJzQ?=
 =?us-ascii?Q?eqfzynKFcZw/vhgwgzpH9iplGMHwNR6bHjFdpYfyJe9VzDFM3+zJsxnPuOO8?=
 =?us-ascii?Q?tn03+/YETd2dxkPU8Kavb5ih6d2GkdTidHgRjIXiOQsv6o8Mgd9hQQP0qy8A?=
 =?us-ascii?Q?nw6bEablMYoqAEOij01g4oZgUuvqQcW8ePyuV8onoEKXcLTJm/OeMhi1bFF5?=
 =?us-ascii?Q?RuaQ2M306Awbx4zNuJLxa8MjJheMfpu0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 19:04:36.2368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf95177-6088-42ac-1259-08dc9f80cfa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
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

Use the dev_info/err variants so we get per device logging
in multi-GPU cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index cf0c4470ab9c..e238f2832f65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -41,7 +41,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	int r;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
-		DRM_INFO("%s - device unplugged skipping recovery on scheduler:%s",
+		dev_info(adev->dev, "%s - device unplugged skipping recovery on scheduler:%s",
 			 __func__, s_job->sched->name);
 
 		/* Effectively the job is aborted as the device is gone */
@@ -53,19 +53,20 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 	if (amdgpu_gpu_recovery &&
 	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
-		DRM_ERROR("ring %s timeout, but soft recovered\n",
-			  s_job->sched->name);
+		dev_err(adev->dev, "ring %s timeout, but soft recovered\n",
+			s_job->sched->name);
 		goto exit;
 	}
 
-	DRM_ERROR("ring %s timeout, signaled seq=%u, emitted seq=%u\n",
-		   job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
-		   ring->fence_drv.sync_seq);
+	dev_err(adev->dev, "ring %s timeout, signaled seq=%u, emitted seq=%u\n",
+		job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
+		ring->fence_drv.sync_seq);
 
 	ti = amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid);
 	if (ti) {
-		DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
-			  ti->process_name, ti->tgid, ti->task_name, ti->pid);
+		dev_err(adev->dev,
+			"Process information: process %s pid %d thread %s pid %d\n",
+			ti->process_name, ti->tgid, ti->task_name, ti->pid);
 		amdgpu_vm_put_task_info(ti);
 	}
 
@@ -82,7 +83,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
 		if (r)
-			DRM_ERROR("GPU Recovery Failed: %d\n", r);
+			dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
 	} else {
 		drm_sched_suspend_timeout(&ring->sched);
 		if (amdgpu_sriov_vf(adev))
@@ -274,7 +275,7 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
 	while (!fence && job->vm && !job->vmid) {
 		r = amdgpu_vmid_grab(job->vm, ring, job, &fence);
 		if (r) {
-			DRM_ERROR("Error getting VM ID (%d)\n", r);
+			dev_err(ring->adev->dev, "Error getting VM ID (%d)\n", r);
 			goto error;
 		}
 	}
-- 
2.45.2

