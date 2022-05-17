Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317D6C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 19:21:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B380011380C;
	Tue, 17 May 2022 19:21:40 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08E70113802
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 19:21:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDK+EZK81r8VE8UAWFPO7lAHy9S2cgDIc81UHi82qPbVXoZaddwL0TmCsjTUGCQrYgJ+Wom/dPOV9KbJuNJM9awtqK72b/ykXzgS8FsDp1g8CK7fhkWssNenZHo2Y6l9NW0vxIffLPBRjFubzSbpp7ocU4JeJMzw9E4jbD4C9M20jROgxmrTW73GioE5hj8JuKqwlwgVAi5zgy/kJFFV3KeQmhE/3HKRnpol6v7ETsksMGlckk2tOlETdpyogqiY+BQRCCNOXpFKSD4QueztYOplDS1khN0Hbw8BaNL/FfwHLALXmg+HTDV2s5pO0TRduAY/Hw1pX/64qFViOKTkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h77PYRlLr/d7L8PaghNvsLA6H9x0znfd/FQ6UZIXFAE=;
 b=dKm82TRtN9heTiqdV3prqXw7xPAHIsBAyQ/cxM8BbJNcvSnmfQmHPwfBNzBD6zqiCaSzcclunJJB8z6eb2+taugAbqQF9qSolKouQo9ngXH8ie0wIcZreQEp0GJN/P4O7Be5lNZMqfFa/OxQEOK98uker3sL6kpEJmEoICxZkh5XildYifVwopffAfwOkeihPQqRWxLd3whBAF0NlrR7tkklt4VhWBN9+8nB6KUAHzfWM+IYnLBarX9SQ1OV3MTwwyB2Uuc5Mf8t/DWgItP4IwQY88wh/D5L3ZKB9YUFSjoceBgYT9Co0qCPnwxYqIbauZUKtC+/2OxfA6O/qCNiOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h77PYRlLr/d7L8PaghNvsLA6H9x0znfd/FQ6UZIXFAE=;
 b=TVdeUuKEPVIlDaSEPzKd+CkHOVJzTBhYH+m56GIDOvzWQ6Ik0TOE+CEC4goSDdQKQPXMFgjWHzv+miWuZchKSunQ28WYelQ+NkrmZsl5nDVHVbiJB4M8kXuRUEnyAWHvIBKfSKpssKhcNpGo3XzdyVKFagqWPpFoxXXdyR5tcIk=
Received: from MW4PR03CA0275.namprd03.prod.outlook.com (2603:10b6:303:b5::10)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 19:21:33 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::e) by MW4PR03CA0275.outlook.office365.com
 (2603:10b6:303:b5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.17 via Frontend
 Transport; Tue, 17 May 2022 19:21:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 17 May 2022 19:21:33 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 14:21:30 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 6/7] drm/amdgpu: Rename amdgpu_device_gpu_recover_imp back
 to amdgpu_device_gpu_recover
Date: Tue, 17 May 2022 15:21:01 -0400
Message-ID: <20220517192102.238176-7-andrey.grodzovsky@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0f3ac2c5-341e-4bf5-6da5-08da383a743e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2447B7A8D670C7A441A41B52EACE9@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hCyamwAm8fBwgSC0Eakvfk3aNAHRlt1GTTo/NGEsVoBCpB2k9U9ju+uBf5aA6HZn7Ew2sGXugIZ82l1tXU0JBiI3kouFVQwWHM4Hz7dieYwwwOUFCpGi85KpVCPaPCZK1wnz4eGYw2XgcGLb5LjyUE05LTKzfQz0lNjoNSZo4gRuu24NZtX7fedM7CipLVFQrQnZmf67YDYfx7awZtt8xldyJRf0CP/B1n6tWeMvnTFk7nm169j3zODkdgsrFYljj/PVaT3HJyVeDcWa48HjB4/obW4jzVoPNPG2bZItXRkKvW4dIjIXorm6xiQ/VW1mxONPZk1PxBcDVoeBGtpgW/hP368UD/GfN7FLwuYuqqz/yVpErBRo8qVwZOFvAaF5/kPtytNNoB+iPeR1g7WzAIHyt8+gJ6kW/KD2QL9sOiwkI6aw+5o4z5ONqLZGZ51kk0JioqDXB0Wvt4GzuarsQKklnhQlxIcm7n8/wB9GddJ5bYdi97aQZfVWekzxLJHO1v5KzmMVfMjdIbGgQF2oHO+hg+jTg0mzMJcywuB1qKlQF6gka6YlYKZ71bY0zOfD1rc0UJLAUno4S0ZkmIlii5oEvNSA3128Eb1oZl0WTDLvUMt9Eu5eAxe7LVCKXfCoVr2vYi+CnE8utYCtf9cB5yWctTDyInsStt2pL7aWFO7CuGsnumCe4sQHRJcxBI+hnjyVIIGc627yFaptDn4qpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(8676002)(26005)(16526019)(4326008)(5660300002)(6916009)(356005)(2906002)(81166007)(36756003)(7696005)(86362001)(47076005)(6666004)(54906003)(70206006)(336012)(426003)(186003)(316002)(70586007)(83380400001)(44832011)(1076003)(2616005)(8936002)(82310400005)(40460700003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 19:21:33.4134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3ac2c5-341e-4bf5-6da5-08da383a743e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
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

We removed the wrapper that was queueing the recover function
into reset domain queue who was using this name.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4ef17c6d1a50..ee668f253c7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1244,7 +1244,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
 bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
 int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			      struct amdgpu_job* job);
-int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
+int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			      struct amdgpu_job *job);
 void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 4cc846341394..434053a9e027 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -129,7 +129,7 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
 	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
 						  kfd.reset_work.work);
 
-	amdgpu_device_gpu_recover_imp(adev, NULL);
+	amdgpu_device_gpu_recover(adev, NULL);
 }
 
 void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ae4c37c89ac7..65f738fd4761 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5065,7 +5065,7 @@ static void amdgpu_device_recheck_guilty_jobs(
  * Returns 0 for success or an error on failure.
  */
 
-int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
+int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			      struct amdgpu_job *job)
 {
 	struct list_head device_list, *device_list_handle =  NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index f980f1501c48..7954ebf16885 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -819,7 +819,7 @@ static void amdgpu_debugfs_reset_work(struct work_struct *work)
 	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
 						  reset_work.work);
 
-	amdgpu_device_gpu_recover_imp(adev, NULL);
+	amdgpu_device_gpu_recover(adev, NULL);
 }
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index dfe7f2b8f0aa..10aa073600d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -64,7 +64,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
 
 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
-		r = amdgpu_device_gpu_recover_imp(ring->adev, job);
+		r = amdgpu_device_gpu_recover(ring->adev, job);
 		if (r)
 			DRM_ERROR("GPU Recovery Failed: %d\n", r);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7e8c7bcc7303..221d24feb8c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1918,7 +1918,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	}
 
 	if (amdgpu_device_should_recover_gpu(ras->adev))
-		amdgpu_device_gpu_recover_imp(ras->adev, NULL);
+		amdgpu_device_gpu_recover(ras->adev, NULL);
 	atomic_set(&ras->in_recovery, 0);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index aa5f6d6ea1e3..3b7d9f171793 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -284,7 +284,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	if (amdgpu_device_should_recover_gpu(adev)
 		&& (!amdgpu_device_has_job_running(adev) ||
 		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT))
-		amdgpu_device_gpu_recover_imp(adev, NULL);
+		amdgpu_device_gpu_recover(adev, NULL);
 }
 
 static int xgpu_ai_set_mailbox_rcv_irq(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index dd9f6b6f62f5..82126b48477d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -311,7 +311,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
 		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
 		adev->video_timeout == MAX_SCHEDULE_TIMEOUT))
-		amdgpu_device_gpu_recover_imp(adev, NULL);
+		amdgpu_device_gpu_recover(adev, NULL);
 }
 
 static int xgpu_nv_set_mailbox_rcv_irq(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index b11831da1b13..d4f721cd34d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -523,7 +523,7 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
 
 	/* Trigger recovery due to world switch failure */
 	if (amdgpu_device_should_recover_gpu(adev))
-		amdgpu_device_gpu_recover_imp(adev, NULL);
+		amdgpu_device_gpu_recover(adev, NULL);
 }
 
 static int xgpu_vi_set_mailbox_rcv_irq(struct amdgpu_device *adev,
-- 
2.25.1

