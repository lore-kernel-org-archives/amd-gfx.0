Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C9FC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 03:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695F464F94
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 03:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695F464F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D416EE3F;
	Fri, 12 Mar 2021 03:57:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD04A6EE3F
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 03:57:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRn42d3FNkTICnGFzOXVtuBvevleGY61r2+/IMWtm2pWROwJ11UwztTlDQ+86ulcbpWSa9+GBHZOd/R3IqOhn86e1WnGnxCifxWGgdz4YIHUUHrTFafQwR0yW7x98sj+me2Ei62HmJLFWjxU0YGtUW1Wc1zzzVbnefL9ffaGrhX12k8eLrsdO0ptIWet5uWokWXxOf9MV/ichOjLjukzUzQ2ksuNZyJlIOHEGSjIlfqHRwBIsWDuwdhV04exRzP/5D6+4ICf+xcydT1VJy350cpJniQs7hyMKWTDkS9R78FXBJQ+0CZth4aCWtiO+RhU61Jrq9Vx0yevFhY3eyQO+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPdw71lCR2x8uCYX9KlRXw/p3bdVXOuSv7ljxgHCexk=;
 b=lh8d5J/MxMnFypZTwfAxRpVU3sbMEGTFOJwYDB9WuOi2VSk1imfEHMR7ur5GgBuwl7E2PZ+W3VxcIWQloS+p0fuPMKmy5SkP3qzlzqqWYbrhv7/HQjlIlv2rSPtu+YS0stDBOow2AGb7CwADzCJ5tsOSWhRKJi8qhG4rJwxW3+njoGq3/5HZS0Zp5xjvi5Bff6UH9WBkLUycN1R0ckuHKE20CKzcDklZPxGyUWOP3CaDDktPbPaU0AhmG0XimO5iNzThj+mfwp7ZczT30BqIbIUFYyw+OwKtYUq384mWplCaFyPoQu3cGUufE0xqYLGYvsVBLeqekfovh2+9q6bmdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPdw71lCR2x8uCYX9KlRXw/p3bdVXOuSv7ljxgHCexk=;
 b=JAis5c1x/UU73MYHGta5nvCBU5yqmh/TNtnudQvE/mfqUY/Eatr+7tAmKJalR7ZKxRg6f7LLcj17vOt3dlZXNF8Up+2TJy2a42ni9zcEzhUbTTKtfcnlURP+2DZgusITkB/0YfmPyh/is04pA7qK3tawYBVUffkaB0hqvE5CVTI=
Received: from CO2PR18CA0050.namprd18.prod.outlook.com (2603:10b6:104:2::18)
 by SN6PR12MB4718.namprd12.prod.outlook.com (2603:10b6:805:ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 03:57:55 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::2c) by CO2PR18CA0050.outlook.office365.com
 (2603:10b6:104:2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 12 Mar 2021 03:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.31 via Frontend Transport; Fri, 12 Mar 2021 03:57:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 11 Mar
 2021 21:57:54 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 11 Mar
 2021 21:57:53 -0600
Received: from ubuntuBBNew.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Thu, 11 Mar 2021 21:57:52 -0600
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <Andrey.Grodzovsky@amd.com>, <Monk.Liu@amd.com>, <Emily.Deng@amd.com>
Subject: [PATCH] drm/scheduler re-insert Bailing job to avoid memleak
Date: Fri, 12 Mar 2021 11:57:42 +0800
Message-ID: <20210312035746.1089855-1-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c8bab76-f399-4fe1-af18-08d8e50b045a
X-MS-TrafficTypeDiagnostic: SN6PR12MB4718:
X-Microsoft-Antispam-PRVS: <SN6PR12MB4718C641AC533A2E278074F2BB6F9@SN6PR12MB4718.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5P2gzQra+qV2iBuYOML7r1WSyoi4tUiJwYRODyBhaHnl1RFAXArrn3xRiBXpOdtYpsAJoRVz25c+tI/kUqzYx9FXIHj/ojRMnLRpnywLIH2Thu/4CHbVL5hosNC6QOKE/FeeHW2D4f0zz3cDIRg2dO8DvWf2BWtcCXyIda+/Vs05HJcjYSJVdNV7MFCy+VmtdUzHrvGkeFXQcB6SJo5vOSFb3fa462j6C8a+Uf1R2o8slnhknkpWFChg1DLzH8GY5J6GBp2ZluT58DJQVxDPM7H0SXYf1ajbyfdn9gLSoFskU8sxgqW1CsqnOpVGEAf0c7mItv2CqfxfdjFBakvAVtCu6lX4WxQQIN+GLwUBuxnxdiEO1uo6Q3aL41syTzyKXNhcLOsNc7uuy7oo03NRWn+NFYkQg/sRtaDbntCpEqlRnO4DbeQpdxcpxkYw5Ik3sgmuFV71uaWk59hmKQbb2St/dv+Z0swFd1XdXqqSVLIVHL8gbQZpkoWmUv5w7J0HkegT5AtHUOZVSo0SjQ9VSKzFtCo964vcX/gUbDs57Au3ov7AOA3jHyHRP0VnU903btiioWwl3/Y/7TrXcmyN1hDW3Qum2tTPSb6rwkLZI2X9z03jQw8vQaV5FWIPVNnj8g+pf5wlyx3Vfvf8J9Ui0lBk3j3+Dp5QLbWsRgd25gfeYtQRgLawg7qTxFcDit0k
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966006)(36840700001)(426003)(316002)(6666004)(36756003)(8936002)(7696005)(81166007)(86362001)(2616005)(478600001)(356005)(186003)(47076005)(336012)(8676002)(83380400001)(110136005)(6636002)(2906002)(36860700001)(5660300002)(82310400003)(82740400003)(70586007)(26005)(4326008)(70206006)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 03:57:55.1738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8bab76-f399-4fe1-af18-08d8e50b045a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4718
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

re-insert Bailing jobs to avoid memory leak.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 8 ++++++--
 drivers/gpu/drm/scheduler/sched_main.c     | 8 +++++++-
 include/drm/gpu_scheduler.h                | 1 +
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 79b9cc73763f..86463b0f936e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4815,8 +4815,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 					job ? job->base.id : -1);
 
 		/* even we skipped this reset, still need to set the job to guilty */
-		if (job)
+		if (job) {
 			drm_sched_increase_karma(&job->base);
+			r = DRM_GPU_SCHED_STAT_BAILING;
+		}
 		goto skip_recovery;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 759b34799221..41390bdacd9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -34,6 +34,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
 	struct amdgpu_task_info ti;
 	struct amdgpu_device *adev = ring->adev;
+	int ret;
 
 	memset(&ti, 0, sizeof(struct amdgpu_task_info));
 
@@ -52,8 +53,11 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
 
 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
-		amdgpu_device_gpu_recover(ring->adev, job);
-		return DRM_GPU_SCHED_STAT_NOMINAL;
+		ret = amdgpu_device_gpu_recover(ring->adev, job);
+		if (ret == DRM_GPU_SCHED_STAT_BAILING)
+			return DRM_GPU_SCHED_STAT_BAILING;
+		else
+			return DRM_GPU_SCHED_STAT_NOMINAL;
 	} else {
 		drm_sched_suspend_timeout(&ring->sched);
 		if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 92d8de24d0a1..a44f621fb5c4 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -314,6 +314,7 @@ static void drm_sched_job_timedout(struct work_struct *work)
 {
 	struct drm_gpu_scheduler *sched;
 	struct drm_sched_job *job;
+	int ret;
 
 	sched = container_of(work, struct drm_gpu_scheduler, work_tdr.work);
 
@@ -331,8 +332,13 @@ static void drm_sched_job_timedout(struct work_struct *work)
 		list_del_init(&job->list);
 		spin_unlock(&sched->job_list_lock);
 
-		job->sched->ops->timedout_job(job);
+		ret = job->sched->ops->timedout_job(job);
 
+		if (ret == DRM_GPU_SCHED_STAT_BAILING) {
+			spin_lock(&sched->job_list_lock);
+			list_add(&job->node, &sched->ring_mirror_list);
+			spin_unlock(&sched->job_list_lock);
+		}
 		/*
 		 * Guilty job did complete and hence needs to be manually removed
 		 * See drm_sched_stop doc.
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 4ea8606d91fe..8093ac2427ef 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -210,6 +210,7 @@ enum drm_gpu_sched_stat {
 	DRM_GPU_SCHED_STAT_NONE, /* Reserve 0 */
 	DRM_GPU_SCHED_STAT_NOMINAL,
 	DRM_GPU_SCHED_STAT_ENODEV,
+	DRM_GPU_SCHED_STAT_BAILING,
 };
 
 /**
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
