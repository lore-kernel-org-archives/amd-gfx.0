Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7513DCF042F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F4D510E5D9;
	Tue,  8 Oct 2024 21:16:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S6xOgukI";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB0EB10E5D0
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMdPaO9lGwa+PzGl9NXu+/n7sKe3MtaGyMc7ad6Y7uokxHcPfLirL9oalstDWX013MT7FCu4dorFIySItPZV+YJFxrsYDf6ltpZMk7YoJdK5TnQlZXmJanBYMhm8uNeFicEIF2VaqoEeBlbtCh2ExOXuQL3cT/gmZgR3fcAVdguhf9p11xGmiQAt5/7Wk+qCaSAfy3bJwZWFxh8wuXYeFhEhdqxDXWE3ncLPk8TuJPuttm836AgmCHMXSiduz0FdrIM28OrcQi8hazUIgzcEqnxsRexoAUbM9sVvnxZx2FewKosfm8ERPUrmjTUzPi+iwqf3W0JDkwnHw17uc/kOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izqkUufLIi74p3WqS33aANqkMymzTCI8frfFdlBcqmM=;
 b=UuWIAaVnm/uiY8vl4rH1aXgCDwMxPo628ylwfiGsI8BYFsHFf5LC1fIcssglhs68e2BcEktyp1ZG3ygcHcr55q7GzD/KQgfWQagzXHpo+iSDmj9mVn47VTxlgQHWWc52wauU7y3ZzmmoDiNPs4CtNP7J5tqkkxyFW/LvZJ9wJxdES6AsxGFIVzhjlkSVHYhFWP1oQSPe8IgTK1svE+0q3GeWLN0kkaxXjM0NFcK1l/XwK2xTmcm90Q69kGJaBe4x5BypzQTfbd+946ob/VRZr1Dv0Y+Ko+eZRnWH4bUdKtN3MwqPiDl83ItIyKNYkjBoE/JhBIoYMg82IdutJ13YRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izqkUufLIi74p3WqS33aANqkMymzTCI8frfFdlBcqmM=;
 b=S6xOgukI4VcbbA25WOM7uAn8/h86ppoM6XNkZvtx1FM5gtOBdvGIXminDtrI7U8aW7PqNmdFcy/IGJfB4CRJ/pREeQSd59QNPLJh13Zb0ojNVv38Bnt6xFvUeH7hlOh7iawdkoVmaWw2La45JFP69kNdIuH209V+19opx8Bp1wU=
Received: from CH0PR03CA0412.namprd03.prod.outlook.com (2603:10b6:610:11b::24)
 by SA1PR12MB6750.namprd12.prod.outlook.com (2603:10b6:806:257::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 8 Oct
 2024 21:16:32 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::b0) by CH0PR03CA0412.outlook.office365.com
 (2603:10b6:610:11b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:31 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:27 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 24/32] drm/amdgpu: suspend for each vcn instance
Date: Tue, 8 Oct 2024 17:15:45 -0400
Message-ID: <20241008211553.36264-25-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008211553.36264-1-boyuan.zhang@amd.com>
References: <20241008211553.36264-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SA1PR12MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 8968d3e5-617b-4b6b-1e43-08dce7de7b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zASoMy6K/Z/3RYLwFXZ4cb56thXwCMTuE2++REvlg3g7mWyZD37pOpNUkY84?=
 =?us-ascii?Q?ZUu8o3IYN5GXZS/yUdlhLfr1b869r5MjfjMq/tRdByK1O1rDPvXOJFtRz5bk?=
 =?us-ascii?Q?gKxT5XEyZgUS7S0Ap1wY5YG2KPP96ugdE6eWayjBXJdsCCvdqSxd/rzV0U+V?=
 =?us-ascii?Q?pvSuEMGpTKjNYfCGqkFOEOVbm/qL5hhkERyS0PcLpl1RKdOuUHm2HdFEK5ND?=
 =?us-ascii?Q?mEEmMOT8jDtE69j75NwwtUnTsYdQg49Cb6DIpdBhkwVUPz0JZmb67kIKf0Zi?=
 =?us-ascii?Q?dsDSNBojcUcYnUrhSWrHJzNEnyK+BRB1B9IOoR9aMAvj6bawVWyB6YWDPdS5?=
 =?us-ascii?Q?+pzKCwlBpvZyHvjcpeKutdIYu/89y4tLKcVs11SyUVQy/uN14X1tJ7wNgKiC?=
 =?us-ascii?Q?8NJ2qRTl+q5KkAF9a9JL5GJEezejk3/55JH1lBOlwztJy7YUVXcXKQxQEpZe?=
 =?us-ascii?Q?maQ5PlykS7NeOgnYUw1WNTDmAUKKDtWk8FN8etfo5/tIy3+bb4TONDwOMixt?=
 =?us-ascii?Q?LP1UU2a8k773VCLsLOQPi4khLamSAtN7kNiZwQWhOqrE88uob3/K4IYZFbca?=
 =?us-ascii?Q?7NNt5Gbrn0SWynRSFriX9RefAx2gHJF92dE8lhO65lUjK+mjukaytMJSlFKZ?=
 =?us-ascii?Q?qg7jdM9EtEpw+6V2U9IS7YwUecJj5FhZnUOLdHUXOc8FYZDgxaJkUFmk8sF5?=
 =?us-ascii?Q?ny08kGim3YjivENfm8ba4hnjvTq9YvcFP9PG5Ky71N09dbCFpvqRD6YFMkYO?=
 =?us-ascii?Q?vusAaQEXlLvrQAdKTCHCq/lDMggKBUlN5K4K7GTF0CQudAj/jlAh89JJn0ui?=
 =?us-ascii?Q?uLAzJhq5fbazdby8I0IUtWwM6IBTBnS72vHHk/pmPSge6yz55Io4aVvssRid?=
 =?us-ascii?Q?Ie8eLelqFXhBq0dx6mPEwzC4By48h6MgAk9qhPHZk7bDA/PWy4giRtDOe6ml?=
 =?us-ascii?Q?3GbctK5NKrgnIZbnRl6kk3NnHvQSxXG72ORYk1IT20RaFuCHpWbnkpEnMiNV?=
 =?us-ascii?Q?CJo/OD3QNwPu7uqZLiFvbvePtJbZsI6lwhE3i5NXvP0rdwSpdBSKiJ8XnURp?=
 =?us-ascii?Q?eVHQfHXtTnl6KBsGUIfeUVm1oYhJvtshWRSoPs5FKHR3rTGqMjpy2hbUlkDS?=
 =?us-ascii?Q?8dEX4H564PZYx6TpmHY0afHwN2nMpMZ/QeV3SfQDBi7iepFD+OHZiVKT90IU?=
 =?us-ascii?Q?X1KGXu44pwvIxw10ixE3lyxD1+heDcBtzBXRmmMymzxYUBUFY0FKqf8+kYtE?=
 =?us-ascii?Q?TbFzul17Ypbls1e+NR7o/kZ6NUmzDE2pVxp3CsMb3WCbYPpYKRY+vISHYLiu?=
 =?us-ascii?Q?V4hZ+Ms0p0yI6NaPKevC+JC2w2oEKJx8Qlr3s8bTJe2Io2eyZGnQsf3OsadR?=
 =?us-ascii?Q?+foNvS4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:31.9832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8968d3e5-617b-4b6b-1e43-08dce7de7b8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6750
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Pass instance parameter to amdgpu_vcn_suspend(), and perform
suspend ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 35 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  7 ++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  6 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  6 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  6 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  6 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  6 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  6 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  6 +++--
 10 files changed, 50 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 307615ffeb79..968355228095 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -294,40 +294,39 @@ bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type t
 	return ret;
 }
 
-int amdgpu_vcn_suspend(struct amdgpu_device *adev)
+int amdgpu_vcn_suspend(struct amdgpu_device *adev, int inst)
 {
 	unsigned int size;
 	void *ptr;
-	int i, idx;
+	int idx;
 
 	bool in_ras_intr = amdgpu_ras_intr_triggered();
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
 
 	/* err_event_athub will corrupt VCPU buffer, so we need to
 	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
 	if (in_ras_intr)
 		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (adev->vcn.inst[i].vcpu_bo == NULL)
-			return 0;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		size = amdgpu_bo_size(adev->vcn.inst[i].vcpu_bo);
-		ptr = adev->vcn.inst[i].cpu_addr;
+	if (adev->vcn.inst[inst].vcpu_bo == NULL)
+		return 0;
 
-		adev->vcn.inst[i].saved_bo = kvmalloc(size, GFP_KERNEL);
-		if (!adev->vcn.inst[i].saved_bo)
-			return -ENOMEM;
+	size = amdgpu_bo_size(adev->vcn.inst[inst].vcpu_bo);
+	ptr = adev->vcn.inst[inst].cpu_addr;
 
-		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-			memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
-			drm_dev_exit(idx);
-		}
+	adev->vcn.inst[inst].saved_bo = kvmalloc(size, GFP_KERNEL);
+	if (!adev->vcn.inst[inst].saved_bo)
+		return -ENOMEM;
+
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		memcpy_fromio(adev->vcn.inst[inst].saved_bo, ptr, size);
+		drm_dev_exit(idx);
 	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 883b9f9776a1..0695433a269c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -486,7 +486,7 @@ enum vcn_ring_type {
 int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst);
-int amdgpu_vcn_suspend(struct amdgpu_device *adev);
+int amdgpu_vcn_suspend(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_resume(struct amdgpu_device *adev);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 8203f80be316..806ed6c550fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -226,7 +226,7 @@ static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	int inst = ip_block->instance;
 	int r;
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -300,9 +300,10 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	bool idle_work_unexecuted;
+	int r;
 
 	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 	if (idle_work_unexecuted) {
@@ -314,7 +315,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 0481a07054eb..397aec069862 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -257,7 +257,7 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -335,13 +335,15 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_0_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v2_0_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index f225a0b214d0..088a3521ac5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -316,7 +316,7 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -412,13 +412,15 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_5_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v2_5_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 2d1835d06ecb..bd8322cdbcfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -325,7 +325,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -444,13 +444,15 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v3_0_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v3_0_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index afe2eba9aac4..c195742ee4f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -277,7 +277,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -372,13 +372,15 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v4_0_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 0dc26dc173cb..ed0f25f7ff5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -235,7 +235,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -331,13 +331,15 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_3_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v4_0_3_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 36e4477c99f3..75ea91749276 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -246,7 +246,7 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -323,13 +323,15 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_5_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v4_0_5_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 687d413a50b7..69aa555b7227 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -210,7 +210,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 		drm_dev_exit(idx);
 	}
 
-	r = amdgpu_vcn_suspend(adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 	if (r)
 		return r;
 
@@ -287,13 +287,15 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v5_0_0_suspend(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int r;
 
 	r = vcn_v5_0_0_hw_fini(ip_block);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_suspend(ip_block->adev);
+	r = amdgpu_vcn_suspend(adev, inst);
 
 	return r;
 }
-- 
2.34.1

