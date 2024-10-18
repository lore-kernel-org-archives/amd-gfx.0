Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDBAD3C542
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 02:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C394610E34D;
	Fri, 18 Oct 2024 02:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lIwM53lR";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3051710E34D
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 02:31:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoXfqt7oPobnHdRiWUbR4VZwxfceCD4IASrR/lyAdbFkPteKFAFEf74EBnk+PsFfjzpPSIUxZodkCJHSE6GhEVz1lTABuOKeETK8EmYNIPhw3wOzGynCoOl94TIQZLNTw+7m7kCIFZKXJswEgPDb2tD5JGUh8oGUHHBrPFIdvmctlXkV20mio6ADmDWg7KRJQD9m2KSWgKXwAWY/c8YHu9wxGc7eL5GdLp6qWu5bVF8VDGdNjLaKCEfY+0k83f+ijjAghTgri5MTOlx20h9FLbrs6V6Z74Y7f4J9bD6Ynprd9iO0nfonWpS+IqQsjD30rk/Z2eCrKxynWsk3ycwsFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYG07dYHoxQOHMpJ9GgiP/qTjO7l6ctRBi/Hm+PfotE=;
 b=PUDMBF1goRrINt75/rnsABHBjqYmsxjqxnVH4feiLkUr5QABYq0UUxApt4vT5kqeioHpO/uHcYDkS8f2LT4dDYQEXonaYyirTBp+69SinrGxUbaW+8d+sptQNxWOXRac3vYod4bYidGVDe523l479GVj9hJ1Q29+TTgr+c8V8gp2L8eplWg7Sj8FCs+yPh/DaVb5jSfnlpUNnm89IZd7A62/OvRaEF/KBpNcmXUZK63Ojr63lsjR03RNvHvz7NZLoGu11aO1oFN8bh815GfnbVOWHxxhqfaFeUx50y10RYzgNb1TXEiWBhDrYKRCimg8ao1KMH4tJb+2ZVG7JCqdDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYG07dYHoxQOHMpJ9GgiP/qTjO7l6ctRBi/Hm+PfotE=;
 b=lIwM53lR/Z2ZixAXRoOx2kD5qpR34G0CbzAAMv+mVaiDNbUakBiczwTlmnOrq2H2uaihDSc/1qF0aL7IRnXqk3/dVilU2V7sHe8puLB7eWPaPx95HMDBDp3r/+5hy/PsDj9i+zQId5NYTohxPCkm6qleDBUyNhE5oB4uRY/7kjg=
Received: from CH2PR17CA0001.namprd17.prod.outlook.com (2603:10b6:610:53::11)
 by MN0PR12MB6127.namprd12.prod.outlook.com (2603:10b6:208:3c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 02:31:08 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::1) by CH2PR17CA0001.outlook.office365.com
 (2603:10b6:610:53::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Fri, 18 Oct 2024 02:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 02:31:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 21:30:58 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 17 Oct 2024 21:30:57 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add amdgpu_sdma_sched_mask debugfs
Date: Fri, 18 Oct 2024 10:30:54 +0800
Message-ID: <20241018023054.1601248-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018023054.1601248-1-jesse.zhang@amd.com>
References: <20241018023054.1601248-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|MN0PR12MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 18cdd730-6969-4edf-10ed-08dcef1cec8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LjJW0UGcM7xDRZfMgr8gHwuhrbnMvVSsmyQpyE8MleRMt1xj8JVj3J1v9DOb?=
 =?us-ascii?Q?ay5ll9cAHRBTbCpVjLwYudRKhlYADUq+fEt+mIoveUZnsiBGEWLiUX//Sf9z?=
 =?us-ascii?Q?MK266ZRi8fztBPSqrSlE1q0p7tev0FZkv1qOxOyPSlZE56P22t4gshVAIopu?=
 =?us-ascii?Q?Vm3e3sepS6duRURsZUXQ3VkEG/mYcVX4RdJW6tj9FyCd/Dcn3vUEgDGvzS+I?=
 =?us-ascii?Q?wju8/fQIVeJv3O8ba2Bj5WsCackIngu7BRJHZyP/YPMG0jeVNcIGE+EEiESZ?=
 =?us-ascii?Q?B/7Clw9zBc3NzM+MdcD1cBlQg4v8jVYyy5+qvmGKbpn5vnLuU5K9Unp82/Gj?=
 =?us-ascii?Q?d+DUHpH7QJW5hQDdjbsu20pcwyRJ+T1mkbBbgHPO0txt17f2OgMlkXdsAhbW?=
 =?us-ascii?Q?HbLOP2ubqXLf/GvwwHx/5leZeXO5FVX/NEdQYy3QQSUhzkouXZwqClQ7tmHI?=
 =?us-ascii?Q?i5aCT3/h0HwuAjCg+JoWEy13UuKIsM2HMxHMJ0xLjQOZ9kBsWtre6HBrJW/u?=
 =?us-ascii?Q?CToeP0RdeCt2UxdnMpYLqkfuuuFZmSqqLs9MCFVRMh69PPdxYoi5nwoy5jig?=
 =?us-ascii?Q?nphUnvVAJwZAqsUZET8q5vPVbueAUkJNwZQAaj7kqZeAfHGDg1maVSDQc8pZ?=
 =?us-ascii?Q?DCVEwjTj9gBUoaCQA2bj6RuJvctYLwLIOLdncheEND+8oQbkTGm6QyBbiyl4?=
 =?us-ascii?Q?o6PGY924eFHeF/z4bNN29mN02riHVCFfYwGVBqfiEjGb4MizRixSsonrHOmH?=
 =?us-ascii?Q?MxU/N46LrBHWm9QodgLJFG4DkgsC6XDGaAhWFI2qE6Cu/MTzO1iKoOdqcr3r?=
 =?us-ascii?Q?t4ZH3/Lx/y1wFuj1h0kmyrJyxh1cB2F83abO8c50dH7NBIHpzlvjUC4FRz9c?=
 =?us-ascii?Q?wjJqGLFa3aESKPWAJ9LoXrvgrT6qwda1P8oAP62i3VFm+01xK9/EGU/zEeGu?=
 =?us-ascii?Q?N8Y9VivZWPBfvXITQWpEFYXrOhN9JMfCVMtGiaNfNLngYwXRhBNA5lSFEeXS?=
 =?us-ascii?Q?ie1lmAOgmXiGIUuXfxbgOpEKA2BR6PN8brUqr5qFtyZ8AfZzau66CgjjjkZ0?=
 =?us-ascii?Q?oTkixBxzrxEn8S/SuL5yzbxku4lvJZYZOkkYsnqNddbZ6z79N0sMcU8NRdaZ?=
 =?us-ascii?Q?JQF3xfCbDLH82WIlVuvjVItgCzKwGhq+B1Ynk2DGrBb+bLbKqCh3Dfv70xNh?=
 =?us-ascii?Q?quui6wrmcOBdhit9Rlz9raWwLZVtUCrnJLR012vzgepBCZitv91WhrD1vpy3?=
 =?us-ascii?Q?3f+XN94IP9SBb4ICyMlu1cywZ4dSrTT1o2kY26UFo0+1IQ5HGpttX+ERoktk?=
 =?us-ascii?Q?1fo1p58QEKTzVuGqWSs0Z0mOObN5qQicz43o9wQqXIC+HdnYrInV7ZYbEO89?=
 =?us-ascii?Q?/wWb3BBF+4hmLnyOEGbAN/bP1UiyMVOgSm5LRXyJinE+ZL0lTQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 02:31:08.5777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cdd730-6969-4edf-10ed-08dcef1cec8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127
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

Userspace wants to run jobs on a specific sdma ring for verification purposes.
This debugfs entry helps to disable or enable submitting jobs to a specific ring.
This entry is populated only if there are at least two or more cores in the sdma ip.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Suggested-by:Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    | 71 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h    |  2 +-
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 6e3f657cab9c..c446bfccea59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2098,6 +2098,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	amdgpu_debugfs_jpeg_sched_mask_init(adev);
 	amdgpu_debugfs_gfx_sched_mask_init(adev);
 	amdgpu_debugfs_compute_sched_mask_init(adev);
+	amdgpu_debugfs_sdma_sched_mask_init(adev);
 
 	amdgpu_ras_debugfs_create_all(adev);
 	amdgpu_rap_debugfs_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 183a976ba29d..cacb12a4fa9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -343,3 +343,74 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+/*
+ * debugfs for to enable/disable sdma job submission to specific core.
+ */
+#if defined(CONFIG_DEBUG_FS)
+static int amdgpu_debugfs_sdma_sched_mask_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	u32 i;
+	u64 mask = 0;
+	struct amdgpu_ring *ring;
+
+	if (!adev)
+		return -ENODEV;
+
+	mask = (1 << adev->sdma.num_instances) - 1;
+	if ((val & mask) == 0)
+		return -EINVAL;
+
+	for (i = 0; i < adev->sdma.num_instances; ++i) {
+		ring = &adev->sdma.instance[i].ring;
+		if (val & (1 << i))
+			ring->sched.ready = true;
+		else
+			ring->sched.ready = false;
+	}
+	/* publish sched.ready flag update effective immediately across smp */
+	smp_rmb();
+	return 0;
+}
+
+static int amdgpu_debugfs_sdma_sched_mask_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	u32 i;
+	u64 mask = 0;
+	struct amdgpu_ring *ring;
+
+	if (!adev)
+		return -ENODEV;
+	for (i = 0; i < adev->sdma.num_instances; ++i) {
+		ring = &adev->sdma.instance[i].ring;
+		if (ring->sched.ready)
+			mask |= 1 << i;
+	}
+
+	*val = mask;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_sdma_sched_mask_fops,
+			 amdgpu_debugfs_sdma_sched_mask_get,
+			 amdgpu_debugfs_sdma_sched_mask_set, "%llx\n");
+
+#endif
+
+void amdgpu_debugfs_sdma_sched_mask_init(struct amdgpu_device *adev)
+{
+#if defined(CONFIG_DEBUG_FS)
+	struct drm_minor *minor = adev_to_drm(adev)->primary;
+	struct dentry *root = minor->debugfs_root;
+	char name[32];
+
+	if (!(adev->sdma.num_instances > 1))
+		return;
+	sprintf(name, "amdgpu_sdma_sched_mask");
+	debugfs_create_file(name, 0600, root, adev,
+			    &amdgpu_debugfs_sdma_sched_mask_fops);
+#endif
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 087ce0f6fa07..a37fcd9bb981 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -175,5 +175,5 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
 void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
         bool duplicate);
 int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
-
+void amdgpu_debugfs_sdma_sched_mask_init(struct amdgpu_device *adev);
 #endif
-- 
2.25.1

