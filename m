Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5485CC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 09:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C22720639
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 09:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dAf9rL7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C22720639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E50989131;
	Tue, 18 Aug 2020 09:30:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1198488FD2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 09:30:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NT/mr8SOQJKbe5CAWVHCh63JZnjATJ1GThiyCCdPDK4w1tuh9i28CJ5HOGVEVrIziKjhIsJQ/VvgZ11ENXJHOeO5fGHM8lmzk6to9J5dkawOtdOH4SqMTAC34H5HFWk1GaNq6G0Kf4keQgz+R7/bpHHw7Kz74qo/OMR3kYYzopWXCGVLhDyVXCdARKYW5F0pY8+GW6/86lY5/c5CvIuxIzCPvohmKA9Q/4wmGzuV8wb4YGj+ce09sAzeiJKMFEbNqILwI9syBvLjzWEA/x+tECjGb0aesIWcqkEcAcQDku6ncaTek308lIz03GT82I0nftHCpMkZ65xBqvgYZ/4xNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbILUNko5c1FtQFu3k2KegQId2JoFwdUBE805PK6Uh4=;
 b=XkxgkSNGA2nH8ZEOCoIAHetWHseD4WKHvQYoPh3PaMp4eb95eVE7WOEKq3jB1ki+pcwtm/n7Sd/cJf/7b6zO9LnQkJPEgMt5cSFjtDTWrFU8xLc79oHITd9243Xu3IQ/QZ2c32W4ZcGds2qbYimx6JYmSKJcgPg6NqTRNfE+VW51/BC8IiIKT2m5BAIeYqb/oduzF+ihg5z+6yJeNutDDqYI8MYl8qORyiZlROcApEGiJ8DaxMXjowTuPEHkGR1zLK3Sy4dyb1WjgQkByXPf3XnAuBw5YmCgYA2Y4d011JSF9alC1AkPMnoX4CvHxvrUYIAdyMHseEr/OFHG7a3wKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbILUNko5c1FtQFu3k2KegQId2JoFwdUBE805PK6Uh4=;
 b=dAf9rL7lryb802Od/YHol52QML/9Oeh3hf6OJrGSnzqI5hcK4yMxV6QKh9xYVx/k5jhXR0iTy+GPUUnC7lPo/Jlll6Qn/27I+7IBYv11VCeRD4a5I0Jln44ZxQhXPc+zGa84LqqHpBlaOmZaD8khrdH9TfC2ODxHb7VuabmKoLQ=
Received: from CO2PR18CA0056.namprd18.prod.outlook.com (2603:10b6:104:2::24)
 by BYAPR12MB3430.namprd12.prod.outlook.com (2603:10b6:a03:ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Tue, 18 Aug
 2020 09:30:12 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::84) by CO2PR18CA0056.outlook.office365.com
 (2603:10b6:104:2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Tue, 18 Aug 2020 09:30:12 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3283.16 via Frontend Transport; Tue, 18 Aug 2020 09:30:12 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 18 Aug
 2020 04:30:11 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Tue, 18 Aug 2020 04:30:10 -0500
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Fix repeatly flr issue
Date: Tue, 18 Aug 2020 17:29:47 +0800
Message-ID: <20200818092948.378676-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34ea2205-00d4-4763-3899-08d843594ec3
X-MS-TrafficTypeDiagnostic: BYAPR12MB3430:
X-Microsoft-Antispam-PRVS: <BYAPR12MB34306507142555E11A503CDD8F5C0@BYAPR12MB3430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F2NpYUfWV7vcdXdH9LuFrG6iKm9PF92AP3WApDML4OpgcD9TOluuEFgxeh9t66T/SOXqHrnn/c/7atvrj2QJQX26uCPrX+jFKoRKrlA2rvdKrDy93ifVWkeu7n8W6Ug2HLQVF8DaJYsvIXSmX/EWl5iblCePAR9EyFNgh+tcUeF4PBUCGU2u5x/VjLgiz5URGzAxJWPkbHjfdc05RzPLuWVSI70HeVzNKfgjQ3tRznEYUbS3GkA94jqML46dhB9o/DQgm74q2P+/WY1rKzWl1fh3uhEVeRkiERgmoqaCEJFEvIOBnux9x78iV6Mf+pex8I366ediSj/TkrumAG6aiCyd+Zo05PFJdAfAtBNIX6Hpf2VuCMOgjsFNtsVsPe/Ucgx+FHXkEH9w+hAeAwAovA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966005)(6916009)(1076003)(8936002)(186003)(86362001)(6666004)(70586007)(82310400002)(70206006)(26005)(478600001)(36756003)(356005)(47076004)(82740400003)(7696005)(8676002)(316002)(2906002)(426003)(336012)(83380400001)(5660300002)(4326008)(81166007)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 09:30:12.3913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ea2205-00d4-4763-3899-08d843594ec3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3430
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 29 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  4 +--
 4 files changed, 33 insertions(+), 3 deletions(-)

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
index fe8878761c29..e17f632efd07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3925,6 +3925,35 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	return r;
 }
 
+/**
+ * amdgpu_device_has_job_running - check if whether has job in ring mirror list
+ *
+ * @adev: amdgpu device pointer
+ *
+ * Check whether has job in ring mirror list
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
+		if (job) {
+			return true;
+		}
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
