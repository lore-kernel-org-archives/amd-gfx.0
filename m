Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F181BC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 19:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FA6D113809;
	Tue, 17 May 2022 19:21:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 972A0113803
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 19:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoG6n+1IKcWLqxMIGdxoEK20uqXbA/STmAnmYn2WH2HWnlSbTcde22tzH4/pW/zwtxQ/eCFfJ3idsspklgQjZ3q0O9ghmtylBjkk2c28tm0NYgMhVUtj8CRd0T1AMmrFKJhPCnEwBt1Q9xUmgVyOmTwVRQ4Y3rZu/XuHBo3z3Sx2PURAjVkv2tTvoYSMQ5no1YI8Gnt6iMChe6QnuBQJv0jQNrZaQW2opOefCcXXNMmt2AN/2TlCRiLg8j9nMUb4CvegywUStquxzRDdOGruFYMkyVUVmR3o8Wc7n5H/a1+f2tcCGbklHLKxGVlSPz1tuXibKkPZryFDsAJuhhSENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chLPQE5uSvMudoKynOE0GEGzEF0tE40V29VTMtLC8E0=;
 b=MjH24JytQ8EORO1tRreXeo7zpkawMo4SzjqVTifd99MecO9aLjzv8L/xShxkWAFILr7eayg3L3KoZo5YO5LR1cX847qbtclvw3rpIx4hpnwRdDu5o10jtnohEW1Q7OmToEWJWaTid7fzRBzuDmA/g6J/uo54w4aZGhuioo+Tj/ZiomHWAiIHdtxELd+SvcDnIVMu2NZQ95X2L3jEhvdlgab6Xbzjiy+2GLNxQwnvx7qz+tilAXdSQ+LHip3ZLcZN30YZwVWJNDek01JYdZIMA3Rf46MicrJpQmOgNPW/AqCVzzlo/F4e8+8MQ+sFFxQVnp3nkptiub2cBC2E1AANzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chLPQE5uSvMudoKynOE0GEGzEF0tE40V29VTMtLC8E0=;
 b=FYsuPCFZofa4VGt1ZxX9bUbao8B68Kfvxc7Rc7fz8H6u031+lE7St3vSun8jKN+zneJb+ffCjvxsMF6aE9QyXbByT2n04BJD3U1eGYK3PshtVJzTGcolIChhqo0bCLZMnsdRCsvVy2LE+JuxGkDIqOS0eJBZLbcx/aUfmPSHiM0=
Received: from MW4PR03CA0295.namprd03.prod.outlook.com (2603:10b6:303:b5::30)
 by MN2PR12MB3647.namprd12.prod.outlook.com (2603:10b6:208:c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Tue, 17 May
 2022 19:21:32 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::9) by MW4PR03CA0295.outlook.office365.com
 (2603:10b6:303:b5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Tue, 17 May 2022 19:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 17 May 2022 19:21:31 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 14:21:29 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 5/7] drm/amdgpu: Add delayed work for GPU reset from kfd.
Date: Tue, 17 May 2022 15:21:00 -0400
Message-ID: <20220517192102.238176-6-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517192102.238176-1-andrey.grodzovsky@amd.com>
References: <20220517192102.238176-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0497a63b-8e4c-4daf-06d8-08da383a7350
X-MS-TrafficTypeDiagnostic: MN2PR12MB3647:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB364772D4C41B41319E592AFEEACE9@MN2PR12MB3647.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PEzyH6dDRq530x0Cx7sfuYTQuNP2sTeUYY6zxC01JBUX14ou3CUuJ22wNv2jTHThpnlUEnKbtUpSqrx7+k8W8PiF7YwR8bb9WF+1NUIw1T62IK6M9E5tI5GSREVdJvXmd5S0R7lWQ7UnVbM/chanyKfM6DvQYPYpAg0uri91Cnz5ulXeeFFBN6BNsyLH6foGCKy6gUYI15LbLY81KfHGNVJxDQkSHhxtr29IYm2yWHpN1wB2sqP0biW1pLrizVUM1gnPchAsl5OvasP24kGyR0R4K5B+onIivjqqeXuMkAZ1etg/hEWJA/anTt3sT34N4RxMCHJkR2YpTrqWFz8sBiwGDpuMdEh0WxmuzfzmrHXbsJ2g5jYe8VZH6EQ3f5uSXybmLmo8uHThamBnRNeuKyc5qAvqbTuQcWxWELRCNZB7GzNrcf2zCKsM40Wr9IHouceHxKQNVGpVYelJCmgPSslExll8IafQ10NR9qB/PoKDXCu+kAhNlUbDEfh/mf4pTk/czBPzvagYK4tMvyA1aSw8DDHtPsTRcmuBcPpsUpQeFSun45/YOyzujxPcGV73HM/FnUYRjPHuch+SurMOwgZmNbiaYgHjOdxOcY2eBXsR3jNtRJ5+cRcANmhSuWCko7mkW3VHMF5AHh8qShDQcYtP27tFypz1BcQWRxIvnXNXS52bN6XBQi713B+iehtRkGP9VfyO0nG6ZitkvnUMFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(54906003)(40460700003)(8676002)(356005)(26005)(4326008)(426003)(6916009)(36860700001)(508600001)(8936002)(70586007)(336012)(186003)(1076003)(86362001)(316002)(47076005)(16526019)(44832011)(7696005)(70206006)(82310400005)(5660300002)(36756003)(6666004)(2906002)(83380400001)(2616005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 19:21:31.8354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0497a63b-8e4c-4daf-06d8-08da383a7350
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3647
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
Cc: Zoy.Bai@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 lijo.lazar@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to have a delayed work to cancel this reset if another
already in progress.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 ----------------------
 3 files changed, 15 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 1f8161cd507f..4cc846341394 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -33,6 +33,7 @@
 #include <uapi/linux/kfd_ioctl.h>
 #include "amdgpu_ras.h"
 #include "amdgpu_umc.h"
+#include "amdgpu_reset.h"
 
 /* Total memory size in system memory and all GPU VRAM. Used to
  * estimate worst case amount of memory to reserve for page tables
@@ -122,6 +123,15 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
 	}
 }
 
+
+static void amdgpu_amdkfd_reset_work(struct work_struct *work)
+{
+	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
+						  kfd.reset_work.work);
+
+	amdgpu_device_gpu_recover_imp(adev, NULL);
+}
+
 void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 {
 	int i;
@@ -180,6 +190,8 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 
 		adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
 						adev_to_drm(adev), &gpu_resources);
+
+		INIT_DELAYED_WORK(&adev->kfd.reset_work, amdgpu_amdkfd_reset_work);
 	}
 }
 
@@ -247,7 +259,8 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev)
 void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
 {
 	if (amdgpu_device_should_recover_gpu(adev))
-		amdgpu_device_gpu_recover(adev, NULL);
+		amdgpu_reset_domain_schedule(adev->reset_domain,
+					     &adev->kfd.reset_work);
 }
 
 int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index f8b9f27adcf5..5e04dba8c7f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -96,6 +96,7 @@ struct amdgpu_kfd_dev {
 	struct kfd_dev *dev;
 	uint64_t vram_used;
 	bool init_complete;
+	struct delayed_work reset_work;
 };
 
 enum kgd_engine_type {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ea41edf52a6f..ae4c37c89ac7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5308,37 +5308,6 @@ int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
 	return r;
 }
 
-struct amdgpu_recover_work_struct {
-	struct delayed_work base;
-	struct amdgpu_device *adev;
-	struct amdgpu_job *job;
-	int ret;
-};
-
-static void amdgpu_device_queue_gpu_recover_work(struct work_struct *work)
-{
-	struct amdgpu_recover_work_struct *recover_work = container_of(work, struct amdgpu_recover_work_struct, base.work);
-
-	amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
-}
-/*
- * Serialize gpu recover into reset domain single threaded wq
- */
-int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
-				    struct amdgpu_job *job)
-{
-	struct amdgpu_recover_work_struct work = {.adev = adev, .job = job};
-
-	INIT_DELAYED_WORK(&work.base, amdgpu_device_queue_gpu_recover_work);
-
-	if (!amdgpu_reset_domain_schedule(adev->reset_domain, &work.base))
-		return -EAGAIN;
-
-	flush_delayed_work(&work.base);
-
-	return atomic_read(&adev->reset_domain->reset_res);
-}
-
 /**
  * amdgpu_device_get_pcie_info - fence pcie info about the PCIE slot
  *
-- 
2.25.1

