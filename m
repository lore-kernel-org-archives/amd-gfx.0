Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3132FECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 10:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ADB910E8E8;
	Wed, 14 Sep 2022 10:11:26 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD3D210E8E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 10:11:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuG7tpny9C7sesWqClp6R+FnY0SCjFwzoFohhSa+tIhiy/NTq3tIslvVkSdghYAxxJcNaxpV/r3UtSO86hlnbR85NKWIIX1YyeSbmH+eiK4R1Y209tFA1cLJfp1sx1Lrrhv+I00oTVEr/UotkIDjQD12VQFETkGrIC1kuGhRIzGLFKDugGdm3ZiMmbYoMxJiA8mbRLId48bDewgftpgJo5mVz12+cfDHjuA6UG06MUuAx15nT1YbYS1/b9G7UP3REKlZp/WhD0KxyhF9Fuj/7BCmGodMkU5FwTZeAwfpBi/TTRDTnCKJ5Z77cy1mUVv4gxEPAQknFJGr3JO82wBT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nwoTI3aHqt4XIt1tySPhtBaIGo0XR3XHWKD5giuaJ0=;
 b=WmKhBX0X37qjZ40kGQQ+rzLHYAXbUdmPTqbwCdu4/mYqoBfU7KKzJUdejUPf9lQOJoi6frMwX/TUJAgp98GLhXmP44VQWpFBoADXZyG0s3LzC75CTeZ6z4opBWd7joua++dWfrsrERy/B+6SHXZwRMkWipS8KzuVHtpbAtmCN/UBQ+ssgyvkhuGYL16QXBbfN8QWyxFvZ6SoYnQozgW01zo03jYMdOfgmrTSWST+ekwR942n8EBDjhx9jg2HoXymsZMM+Thx+Yl1qFuX8H/FCx2EYiOXcy8m5gnnPRzng1RQGSMrxim1phmfYT+rzBO0JUMXrHlnIp3W2nGch0u1Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nwoTI3aHqt4XIt1tySPhtBaIGo0XR3XHWKD5giuaJ0=;
 b=MVpw27dl1lNcltRuT4EoZqbuJeHCXoezzDeeJ/Nz82EaSUILIdhqRpuEme/G9XT3K3dT13Qc+h71wAGZBTK+CQ2uWLrVbhhOvaafAchhSXspwVBn4WXFaNXIQKcYx51KmGh7pzJvadGdXqR4gSZ0hTWuwg2iO9nVF7btcNqrJRA=
Received: from BN1PR12CA0024.namprd12.prod.outlook.com (2603:10b6:408:e1::29)
 by CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Wed, 14 Sep
 2022 10:11:19 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::10) by BN1PR12CA0024.outlook.office365.com
 (2603:10b6:408:e1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Wed, 14 Sep 2022 10:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 10:11:18 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 05:11:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 03:11:04 -0700
Received: from victor-aws2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 05:11:03 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
Date: Wed, 14 Sep 2022 18:10:24 +0800
Message-ID: <20220914101025.366954-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|CO6PR12MB5444:EE_
X-MS-Office365-Filtering-Correlation-Id: 3573b80e-f9c7-4087-07ba-08da96397778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wf11p+T/acGgcNwmKW7Fxe8Imsz/kZz+U0XKnTeLKvS3dIIiqSYuUkh1u9NfYv5HLPRZghB2vXmGhuKSqNBX8L78O4Jasyw9ymrVQtYBds5Ii0ggiEX3pejrKA2mmdlJ9x9lbymIvrzJIxvlMOZERLetR6McLc/dKR9f+/etSEM205TuDYLOwZCtl60euiTbRMxInjaiPnAoPHzbCUQMe387WBowSO5tsvUo07nJC8nIJvrtAyhsVKdbgNLQeFaxx+EPAN75cGzo29fUTYNZrUxu9aj4odU5W8zhqAqKuTPJOL+CuAIG4yE2lvncxSrqhYPb/a6BCc2kxyVA4Fwtu8Az+S87FyCWvsn9zVkjij5AjlFpRiv6xRzbN99x0IZgPRNx1bRutfuTkfeKf95EEfjcUyeKe+QBMwycpW157PaCsWL+ftvNGYQ1/SL37oaj7Q7/XPZzb87583/MJXkzKd0TaqnUCR9pK0E9uKiRmmPtM9UyDhc7HufXZsVzGbKoQZVJtkGYlhhq1EeOY/Uesh6wXH/8aSmCzpQdoEiZgDSr+KSRPSFMWW5zxfMt8lP9buDYwBAXRNMAQ/AxWjymY+ZXCu8x7qrmity+jU1QBON3ijYpxYRt39G+KJji8f7ywx/GuJQS5PEC3avjXMYI8giC3NpI7y+uARF3z2xQaKX3kv6QFvXc0PUH7GpuLSxx/zmDsrcoI0GjUsFOzafG8sY268dOSaqz803lK8NozGQyOhg+zk21wKHG+/9ABiyjzrt2/2c2ZS/OZ2XdwARho877eFUthxYgoQnh/UC0Fj8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(2906002)(82740400003)(7696005)(478600001)(4326008)(83380400001)(86362001)(70586007)(54906003)(41300700001)(356005)(82310400005)(1076003)(8676002)(5660300002)(36756003)(70206006)(47076005)(8936002)(26005)(336012)(186003)(81166007)(2616005)(36860700001)(40460700003)(6916009)(40480700001)(426003)(6666004)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 10:11:18.7378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3573b80e-f9c7-4087-07ba-08da96397778
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5444
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
For a gpu recovery caused by a hang on one ring (e.g. compute),
jobs from another ring (e.g. gfx) may continue signaling during
drm_sched_stop stage. The signal bit will not be cleared.

At the resubmit stage after recovery, the job with hw fence signaled
bit set will call job done directly instead go through fence process.
This makes the hw_rq_count decrease but rcu fence pointer not
cleared yet.

Then overflow happens in the fence driver slots and some jobs may be
skipped and leave the rcu pointer not cleared which makes an infinite
wait for the slot on the next fence emitted.

This infinite wait cause a job timeout on the emitting job. And
driver will stuck at the its sched stop step because kthread_park
cannot be done.

[how]
1. move amdgpu_fence_driver_isr_toggle earlier to close interrupt
before drm sched stop
2. handle all fences in fence process to aviod skip when overflow
happens

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 +++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  |  6 +-----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 943c9e750575..c0cfae52f12b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4610,8 +4610,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 		amdgpu_virt_fini_data_exchange(adev);
 	}
 
-	amdgpu_fence_driver_isr_toggle(adev, true);
-
 	/* block all schedulers and reset given job's ring */
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
@@ -5214,6 +5212,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		      amdgpu_device_ip_need_full_reset(tmp_adev))
 			amdgpu_ras_suspend(tmp_adev);
 
+		amdgpu_fence_driver_isr_toggle(tmp_adev, true);
+
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
@@ -5228,8 +5228,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		atomic_inc(&tmp_adev->gpu_reset_counter);
 	}
 
-	if (need_emergency_restart)
+	if (need_emergency_restart) {
+		list_for_each_entry (tmp_adev, device_list_handle, reset_list) {
+			amdgpu_fence_driver_isr_toggle(tmp_adev, false);
+		}
 		goto skip_sched_resume;
+	}
 
 	/*
 	 * Must check guilty signal here since after this point all old
@@ -5240,6 +5244,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (job && dma_fence_is_signaled(&job->hw_fence)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
+		list_for_each_entry (tmp_adev, device_list_handle, reset_list) {
+			amdgpu_fence_driver_isr_toggle(tmp_adev, false);
+		}
 		goto skip_hw_reset;
 	}
 
@@ -5276,6 +5283,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (r && r == -EAGAIN) {
 			set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags);
 			adev->asic_reset_res = 0;
+			amdgpu_fence_driver_isr_toggle(adev, true);
 			goto retry;
 		}
 	}
@@ -5711,6 +5719,8 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
 	set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
+	amdgpu_fence_driver_isr_toggle(adev, true);
+
 	adev->no_hw_access = true;
 	r = amdgpu_device_pre_asic_reset(adev, &reset_context);
 	adev->no_hw_access = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 8adeb7469f1e..65a877e1a7fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -287,15 +287,11 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 	if (unlikely(seq == last_seq))
 		return false;
 
-	last_seq &= drv->num_fences_mask;
-	seq &= drv->num_fences_mask;
-
 	do {
 		struct dma_fence *fence, **ptr;
 
 		++last_seq;
-		last_seq &= drv->num_fences_mask;
-		ptr = &drv->fences[last_seq];
+		ptr = &drv->fences[last_seq & drv->num_fences_mask];
 
 		/* There is always exactly one thread signaling this fence slot */
 		fence = rcu_dereference_protected(*ptr, 1);
-- 
2.25.1

