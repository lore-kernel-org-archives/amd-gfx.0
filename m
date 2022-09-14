Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8862EECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 10:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA13810E8EB;
	Wed, 14 Sep 2022 10:11:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAE1D10E8E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 10:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bq0Kx18X3/BB7UqOd1Gg1sl4K3UiGKK0JIde4IckxFTrAFF6BiDYKYQLOhj/KTrGY+ES0sBkv1OGJR5LYMM9YZxtkAsBA0PLoP0R+Pz4UGB/EopwX/XcruY5d/qnxf8ZVC9PeWexm72obZz+KlmDroJP3Nz8SctT6moFbChYD/M0stXGZio/s/G7RByOmEG7ZsLbeFLJnM7M8pkIXjfPj38bpP9GyDuv8HmlDFlXx2T6zwfcJHm6NSYq3qU1Te69I1rBQd84Vh3wP6xg8QAk6I1G1DxOVBGn6TuCwWoUmjROL5qEaKQBo9URwPDHIk6YJ3tw/C8Zqnyao1T0d9KdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1SopY9rDzN6i/9D2b+fYE2S6faGyAzZWNgzFi1HTM0=;
 b=DXiK138YlFEEFwWTFPQQQ5repUnv4t5BVKC7uIY+yXVhfpM+6q3xY+X4GVXXdXAQ/hR1WIIHAs/k+23n3m957REc3Coz2jTt1lrbrJx1nfanRCzOKmD6W5f8a/r2/z0T7CvqWOUB6kfKNJg69gc3nfGi1ge7KPKHzIvvLyMzC+pnfJilJgWUmLY2CqcNUnq6cWawrd+o8vxhZPZsx1YjLMISKQQBdjKV35bDOqN4NkTovp/B7ukfBU0rE0kFePC4g1OKQrogzpGD1gHb9SI+2urv+Y3PFiLzgWtvQzuYjmWS7pUz6r1N07ZFLpXENXYqSe0kyGnKSdUQr7dsWxv5Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1SopY9rDzN6i/9D2b+fYE2S6faGyAzZWNgzFi1HTM0=;
 b=4VkBCH+s1rYwK8H6Swhle27/sR1zpB1sfQLj/9X0rDujcqwlbepmRloGcBOzWBjtx36Gp6EhW0M85+6r1M78Y940sC3gd3OaKXSSLNW7U7tDTcUi5KI/w0pzIhHo4lP1+frsB67vJf2rWZxVFLxz7vnLlIBrj/asMuageeNDpO4=
Received: from BN9P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::35)
 by BL0PR12MB5010.namprd12.prod.outlook.com (2603:10b6:208:17c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 10:11:27 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::1d) by BN9P220CA0030.outlook.office365.com
 (2603:10b6:408:13e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 10:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 10:11:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 05:11:26 -0500
Received: from victor-aws2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 05:11:25 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: move enable irq later to avoid race with ih
 resume
Date: Wed, 14 Sep 2022 18:10:25 +0800
Message-ID: <20220914101025.366954-2-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914101025.366954-1-Victor.Zhao@amd.com>
References: <20220914101025.366954-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT014:EE_|BL0PR12MB5010:EE_
X-MS-Office365-Filtering-Correlation-Id: cdaff571-2d48-4e63-61ec-08da96397c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1KWKZbC8xMMRz0W9K3MEctumkFz0SBOf32+CtUWo7Im6Y6KGOVXJIUJTt6HA159pk2zmHxIRuDaCLTzlx8FtmnfSqjrrAAVHvYlFzdkWDpBbsUE/+KaGZxKZFhk3hOwmZlNsDlfuOghcv5/B6M8Zkq3Rck7JrlkmqQO1W6YaOCE6SYbtVLDxUOTcQlcq8Fm+bQT1d3UqyyFW8iASnGoK0U5yQle8EbabhTh/leCP6J/9rYPdhlotg9fiy1ETAWiNme9WDhdd3wGmJM+pVdUNuzu5tbhNREwZw3NkspQDzxYgnMhsoqWO4hz1WvfFVbbmFbE4ZOG3OQ7rdFCPxWhcAqMa+AC5maxRPlJ1KwhksjGL6lk9EyciNF8PbpGkkZ3ZcUt/tUqoz4hpC4ukQlgNa/geGJnWFBUbpHJ/DQeyfexjKJhjvuTCd2eYjoH75s52F3n6sLVVdxdaNWLAqXezDpTuyyvseAYP6lfVD6g4DLLoKDNPKnit14DV5RCyQ//SjYCEpdhwxXKfhTi/qa/mUR6UOTHaTe7D8FdVDqqErYi+4YUn/DPMdX7NR155MTDt5yjzsyaCdV9xaUT+q/FOLSu6FeyUGzxvEoKdvjUJ1+8yng3RsieTom7UK50RUTr2ngWV1wEdBJWZldiDdNE7y3Yud31h0ugqsRGefeMjiWyZWRg/WIFXXwOTeztWPIRGkZUTRNOi+YzLhqZg2JiXBTp86yJvSh1H0Sb6IirHpZ8L4nciLoUd00fe+gI8fcaoumFvzaNxM3v+ejNuxNf79BdXuaqYJrjLLP/rmb/LW4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199015)(46966006)(36840700001)(40470700004)(5660300002)(4326008)(36860700001)(8936002)(40460700003)(40480700001)(1076003)(82310400005)(2616005)(2906002)(8676002)(356005)(36756003)(47076005)(81166007)(426003)(82740400003)(6916009)(316002)(336012)(41300700001)(70586007)(86362001)(54906003)(70206006)(186003)(83380400001)(478600001)(26005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 10:11:26.9518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdaff571-2d48-4e63-61ec-08da96397c5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5010
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
Cc: emily.deng@amd.com, Victor Zhao <Victor.Zhao@amd.com>,
 Andrey.Grodzovsky@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[background]
On current sienna cichlid mode2 reset, on the slow job hang cases,
since page table context was reverted to completely stop gpu, it
will generate page fault interrupt.

Since the irq are open during recovery stage, during ih resume step,
if this interrupt was in processing, which increased ih ring rptr,
and ih resume meanwhile will set rptr and wptr to 0. This may cause
rptr greater than wptr. Such case was not handled in ih process,
and it will cause rptr continue increasing util reaches the max.
Such case will make fence fallback situation happen.

[how]
Move the enable of irq after ih resumed and before ib test.
Adjusting the position of enable irq on other reset paths accordingly.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c0cfae52f12b..0b658225e9ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4625,8 +4625,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 		amdgpu_fence_driver_force_completion(ring);
 	}
 
-	amdgpu_fence_driver_isr_toggle(adev, false);
-
 	if (job && job->vm)
 		drm_sched_increase_karma(&job->base);
 
@@ -4758,6 +4756,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
 	skip_hw_reset = test_bit(AMDGPU_SKIP_HW_RESET, &reset_context->flags);
 
+	list_for_each_entry (tmp_adev, device_list_handle, reset_list) {
+		amdgpu_fence_driver_isr_toggle(tmp_adev, false);
+	}
+
 	/*
 	 * ASIC reset has to be done on all XGMI hive nodes ASAP
 	 * to allow proper links negotiation in FW (within 1 sec)
@@ -5031,8 +5033,6 @@ static void amdgpu_device_recheck_guilty_jobs(
 			/* Clear this failed job from fence array */
 			amdgpu_fence_driver_clear_job_fences(ring);
 
-			amdgpu_fence_driver_isr_toggle(adev, false);
-
 			/* Since the job won't signal and we go for
 			 * another resubmit drop this parent pointer
 			 */
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index 7aa570c1ce4a..953036482d1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -240,6 +240,7 @@ sienna_cichlid_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
 	* Add this ASIC as tracked as reset was already
 	* complete successfully.
 	*/
+	amdgpu_fence_driver_isr_toggle(tmp_adev, false);
 	amdgpu_register_gpu_instance(tmp_adev);
 
 	/* Resume RAS */
-- 
2.25.1

