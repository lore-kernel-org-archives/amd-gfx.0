Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA36C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 13:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C81AA206DA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 13:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tHkBmhY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81AA206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77EF089CF1;
	Tue, 18 Aug 2020 13:29:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5695489CF1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 13:29:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Si5Ln3iYGaiWX3VdHgUr+OOQTG+gyWIcV3PrQwrelek2n8plMQK35QViYrOcqSMwm6a0TrzOkEJ6dGoLtwo/xtIQEuj/gc1tpw+7Fn8nAJbkV4OrNjrAnFgYgJYIxnBqAk8+ajZSp76FQFsMJsboFnOlAIKTQFNtt2Fjv0trSVKAY2bcjyj1f0c1GkMY90MWRTbH0/FsQEGdW8f3IZBrEyO/eUbLODpfolOUxMJLZv8YfQHFun7VLyDtx70P8L4PYGQkhBdox1e9GUeWxPF+PCZeAGz4r2pPotNlVxXSmddtfKxHerQBRwDxVEwJ3TkyJ+dJoP00dgF3gp6qpcvqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/CEeHajvs6wDiRVMVGEGRQYTw/4GAcQkU5GGoVoyr0=;
 b=ViTDkuMUYtqRJ+9qayDIok5RALqI69mgOZwmTASrNBCGnIvILgg1jCFJ4wP/ukgx+zJvDFJsZ3q53Y5n51VzlTq+K2Z+oWTNKzcK9p7Sp1COVT2WH4ySFjPQkxDrBDyiL/+7/uAxtvvV8J5ZK6W0CKHXLsnzGkubmxk398nIvyqxw1h0eMIjuW2P/k+0G/1kwDaC2vQ7Hgfb82RBoSHpdjmehkWKYc9JuoL3XnaWlH0XnHjZrK+3N5s/hUN335bSeK0NtDefDpc/OeTyIpzXsQCTYJ50VjsPvmO2BZfZQdQ5wrQ709TZzaIgg9zp6SySwkOczTLLL+8QteC6KNhUlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/CEeHajvs6wDiRVMVGEGRQYTw/4GAcQkU5GGoVoyr0=;
 b=tHkBmhY5O13qjFbzBDjXM5O+0UJsMUluQUCMKBiQhvz49sFv2AQZFGLQUtGXcP8vDvS//0rJhsZyxPoaVE1XheSG9Ps+uzbEo7Hp9Vc4rU4UNGTTrOjzMHGU1/4ciCCVoPsL+P9rv/IPJVMuZWC1X5etKxwXIOEh5VZ9RKdYyus=
Received: from DM3PR03CA0003.namprd03.prod.outlook.com (2603:10b6:0:50::13) by
 BN7PR12MB2596.namprd12.prod.outlook.com (2603:10b6:408:29::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.24; Tue, 18 Aug 2020 13:29:21 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::8f) by DM3PR03CA0003.outlook.office365.com
 (2603:10b6:0:50::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Tue, 18 Aug 2020 13:29:20 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3283.16 via Frontend Transport; Tue, 18 Aug 2020 13:29:20 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 18 Aug
 2020 08:29:17 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Tue, 18 Aug 2020 08:29:16 -0500
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Fix repeatly flr issue
Date: Tue, 18 Aug 2020 21:29:12 +0800
Message-ID: <20200818132912.37875-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d7bbd8c-4d65-4c9e-aecb-08d8437ab6f0
X-MS-TrafficTypeDiagnostic: BN7PR12MB2596:
X-Microsoft-Antispam-PRVS: <BN7PR12MB25966B0D6EBF738FE6CD61178F5C0@BN7PR12MB2596.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ntf0sQSOgyrgLSZgKJZG0mcstpp1vSwL24UCxqktwOEwchpod5iUdsRO7Bw1Tr8AmRfHl9chXl6+3FkMkFd37RSbHLj9YCf5TywG9wBWDwCaJPaFSNedu5Ae+/fKfNDW0PMibX5BYya8WykfqFTKk2r6Cw5vCgTQkiXAIerIOtSuhtCvhmyGtjQGDh5EGLh/EIqP101K1Ys4ogyuRAb0X5W1oY0mJaIhjJE4CKMXqYEkQcYbtprSs9oWProYiRXTRX/B24iFOkYkuSuE8D6FB4cXOI8fyJxoN8y/K+GAWh5+Sd89HAojBrwXLJ/s8JBthgFzC5aiz/LzC+7Q8sdaubKOjLd7o8bRA7TwQMsC9wOuxnEIL7s3CYapdwFq2U6m9bnd69zB6p5rlp/f8BfpqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(46966005)(316002)(478600001)(6916009)(186003)(70206006)(2906002)(26005)(82740400003)(36756003)(336012)(7696005)(70586007)(4326008)(2616005)(8676002)(8936002)(81166007)(82310400002)(86362001)(426003)(83380400001)(47076004)(5660300002)(1076003)(6666004)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 13:29:20.6393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7bbd8c-4d65-4c9e-aecb-08d8437ab6f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2596
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
Cc: jqdeng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: jqdeng <Emily.Deng@amd.com>

Only for no job running test case need to do recover in
flr notification.
For having job in mirror list, then let guest driver to
hit job timeout, and then do recover.

Signed-off-by: jqdeng <Emily.Deng@amd.com>
Change-Id: Ic6234fce46fa1655ba81c4149235eeac75e75868
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 28 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  4 ++--
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1f9d97f61aa5..69115781be05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1136,6 +1136,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
 
 /* Common functions */
+bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
 bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
 int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			      struct amdgpu_job* job);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fe8878761c29..de4bce6d7516 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3925,6 +3925,34 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	return r;
 }
 
+/**
+ * amdgpu_device_has_job_running - check if there is any job in mirror list
+ *
+ * @adev: amdgpu device pointer
+ *
+ * check if there is any job in mirror list
+ */
+bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
+{
+	int i;
+	struct drm_sched_job *job;
+
+	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
+		struct amdgpu_ring *ring = adev->rings[i];
+
+		if (!ring || !ring->sched.thread)
+			continue;
+
+		spin_lock(&ring->sched.job_list_lock);
+		job = list_first_entry_or_null(&ring->sched.ring_mirror_list,
+				struct drm_sched_job, node);
+		spin_unlock(&ring->sched.job_list_lock);
+		if (job)
+			return true;
+	}
+	return false;
+}
+
 /**
  * amdgpu_device_should_recover_gpu - check if we should try GPU recovery
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index fe31cbeccfe9..bd4e7c2d0dd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -261,7 +261,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
-		&& adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT)
+		&& (amdgpu_device_has_job_running(adev) || adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT))
 		amdgpu_device_gpu_recover(adev, NULL);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 6f55172e8337..d5c14745a9d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -281,8 +281,8 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	up_read(&adev->reset_sem);
 
 	/* Trigger recovery for world switch failure if no TDR */
-	if (amdgpu_device_should_recover_gpu(adev)
-		&& (adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
+	if (amdgpu_device_should_recover_gpu(adev) && (amdgpu_device_has_job_running(adev) ||
+		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
 		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
 		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
 		adev->video_timeout == MAX_SCHEDULE_TIMEOUT))
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
