Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C034CF3195
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:39:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4900310E68C;
	Wed,  2 Oct 2024 04:39:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="loIb7liC";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11EE410E689
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAnYkHyNz8voI1Xgmr2mzSW6p7HrSxeOqSywfvAvolt+Lt6sbmgqKZjKQY2oRkV+bviwcMelulxf5Bl8v4ysEDw4F3sCD0H+vJnP4MSjqCbrM4n8G9IkfLllk12KeB1Ke/ln5jJfyEEKnJcio6JZDKfgkkl93Hvsc+7pW96/SVB4Xi+1wxEQ0KSO8iTBnORrRPh12HWwa4fvTsLHnG2Jgqw0EgOait+cFaPEH8VQB+IYOeSXoNqA9bWFj9IF4f1z9UxouAu93reEWO4zUOSg3D4+F+rH6bb2Nu7P3CC+sRqxyi4GX/3njZJ+fmvH92tEFbJJfwPt8daHWb6fBhWMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeHQU/wVkh2fderat3I9PsIiJVFWlhk3l6evTJbY94E=;
 b=j2ceZ/N08yHsL+z6w0KFHIC2RJ4HJX0E++d1QaVIM0qnGBO9pgAOUNOZdvtVuMiQ72RMcduP3gA1D50686XutKe7TJB9B/JsCsvS+K3jNMI5UgF5cWG24eHjzYbhZ0jUNwF5786olZ+ZA2ZeFylez6Sb1+xJ2xzqbqHRe0N0LCjENv0HMZ7wxYrmH4wZazqu3a6d3azyl8HXgoeC8w5BqG51hjXQXuqfJff7wnTPezrfU35G1SxSSHSyKuWIjk/+7e+6uR2Fmt+LOxMuwLt6tgrk0/op49BoQgRt6zG8MqCMMdarmNOSrIn76tRkvaXFnGrBODGSD+YXU0uCZ85iHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeHQU/wVkh2fderat3I9PsIiJVFWlhk3l6evTJbY94E=;
 b=loIb7liCGQi/qGCJGMVhHqLbyF7etJ6+NRlOiwV5Ne9zQ5daV6PcFrL2xUUbcQZtH/J2W/NHwBpLMqhSI5c7dT44LfrMYvpIvf50i7be+puYCI18H2AzoJBesTA4CLYHJ3+dw2lhh+vpfHNNbMfWRuOdFMH2BVe6+EZMuX5J8pk=
Received: from MW4P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::29)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 04:38:54 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::7d) by MW4P222CA0024.outlook.office365.com
 (2603:10b6:303:114::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Wed, 2 Oct 2024 04:38:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:38:53 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 23:38:48 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 08/18] drm/amdgpu/vcn: separate idle work by instance
Date: Wed, 2 Oct 2024 00:36:17 -0400
Message-ID: <20241002043627.102414-9-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043627.102414-1-boyuan.zhang@amd.com>
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: a19341c3-b27f-468d-1f97-08dce29c1ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BJbxPP1vieQbUPOkW1x9zdKSXWOWKK3jQE+Pp02CiiebAgagMNJ+KgQUbHGh?=
 =?us-ascii?Q?LyYxEC8Cdf8M8figrEApswTYpt19iFsVBVrPEO4zVJObgBobH1lLuOZWAIA8?=
 =?us-ascii?Q?MdWlpGBMOYl0UZhtEw6fF5g5OZNIE6aCz16O41iaDJkRimB2VoUFgFvI/xVK?=
 =?us-ascii?Q?HEwuvZh3R1EC7C60Le67wzDsxihq4FUZeQfRa4c3gn3rJOtpTehHMRg1bL0I?=
 =?us-ascii?Q?A/VZ2Ev57v+96ClfiNHVsqHSWVvayws/bpPPz6Ean5qDt+d4CkvDrlAfdhTa?=
 =?us-ascii?Q?8Vfn73lj2Y9m/0MvmmE0sr24BLNFmASqbhPSdUbOiplQCrDBslk35EW8zSBj?=
 =?us-ascii?Q?IFzOK8Baj9H8G4tKbErKOkJ8zTPZbAuvvsxDPqdwwg2XNm5T5TRXy/Wv8Hdt?=
 =?us-ascii?Q?MRVVrBGXtpYnm2a037A8No/tJkisV6szCcg0V669FKKglw4oLOzP6CpxF+iZ?=
 =?us-ascii?Q?IYyP28IMCaeqcOYNZ3ZLXxkpLPtOLAE6mZ8ei9VdvcXepCEKei55e05lUlEk?=
 =?us-ascii?Q?SqHitmoxKIzKxuCPPoT0AP7yOZHbBt298fttYTc6SjXQwqHalNQc+bhVg6af?=
 =?us-ascii?Q?CQ9LTE7tOg3QV3eHOPwOB75LexGjQuU7hUuD/Qh2dktn0c+z76YLl76hfGuO?=
 =?us-ascii?Q?+0SM50Dv1FCLNdHGY8wuLcyDY0X/ZwDBwZQFBBoDLpGku8v0eXTilRl/cT7J?=
 =?us-ascii?Q?ghg6L8VLL5ejSar5cvNzABxt4b/JYQoYD1Jxfd3ZBj0En13xRiVOjxmmJbR2?=
 =?us-ascii?Q?sOz3O+7hzvTUOuZEVdNpXEhY8Bznuv/7PQSU8iBblHyeq3Oh2gUDbzWuxHh8?=
 =?us-ascii?Q?D+z2Yvyjt/UDiqk+jit3UWcRw70d5jEv+WsmIZkgkgzVIG+q8d5cAWX8W2q3?=
 =?us-ascii?Q?Gpr8s3m6ET1s3SdbpfdngtgI/HT8pzA0YKkKJvDztQcBL5xuEt7sSdAUVRn7?=
 =?us-ascii?Q?Kjn7ybDuqDnbhXn0ZERy49qc1RmPg87BUVywHapM4RyWdlZ0Ci/0570CFwIZ?=
 =?us-ascii?Q?9suNK5HGPgENSES3NA7Rd/cp2eYf2+xaGAZB/sbvaIZ/51T8ICzImeblDg6L?=
 =?us-ascii?Q?2jwVUkTBKCS8uvZ6stihYmaa+Iwplckn49p9XHS1MaKul+8cgzJ5BoiEk/1d?=
 =?us-ascii?Q?nSQzPIWCSEbtWqPqaVQj8l2Zlf96Q9Lp4D+v8fS/gPymQH1j/paPuQRsj/4C?=
 =?us-ascii?Q?EhTQ/aiMW4QRX5QS127BHTxtQpwdJfO6jshQdoBrAGmrzRqtxbQyOIGd15TG?=
 =?us-ascii?Q?PGL8v8ngnwawbIh7S9QAgF98Gs2o9W3N8x6l16Sj+0KuZsIUbrYDosoc7BHB?=
 =?us-ascii?Q?q4h8Ba3mJgClz/TGkH2S/nblMXroZJ9sPmzE1tny/r0Ba0xwSCZ8a/s7LoDn?=
 =?us-ascii?Q?QJsTSv53qyIrGPUsfJboSYItUE6EXv6bvt8oyla8t5R/FlCTcK9uGkw+vgXa?=
 =?us-ascii?Q?+AUr02i2DYLjp2WOO0E6U8W0a4K81mOa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:38:53.8093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a19341c3-b27f-468d-1f97-08dce29c1ed0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414
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

Previously idle working handling is for all VCN instances. As a result, when one
of the instance finishes its job, the idle work can't be triggered if the other
instance is still busy.

Now, move the idle_work from amdgpu_vcn to amdgpu_vcn_inst, in order to
track work by vcn instance. Add work_inst to track the instance number
that the work belongs to. As a result, the idle work can now be triggered
once the job is done on one of the vcn instance, and no need to consider
the work on the other vcn instance.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 66 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h  |  4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 14 ++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  6 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  3 +-
 17 files changed, 66 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 43f44cc201cb..28c5e15d166d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -118,7 +118,11 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	unsigned int fw_shared_size, log_offset;
 	int i, r;
 
-	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		adev->vcn.inst[i].adev = adev;
+		adev->vcn.inst[i].work_inst = i;
+		INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
+	}
 	mutex_init(&adev->vcn.vcn_pg_lock);
 	mutex_init(&adev->vcn.vcn1_jpeg1_workaround);
 	atomic_set(&adev->vcn.total_submission_cnt, 0);
@@ -302,7 +306,8 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 
 	bool in_ras_intr = amdgpu_ras_intr_triggered();
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
 
 	/* err_event_athub will corrupt VCPU buffer, so we need to
 	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
@@ -376,46 +381,43 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 {
-	struct amdgpu_device *adev =
-		container_of(work, struct amdgpu_device, vcn.idle_work.work);
-	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
-	unsigned int i, j;
+	struct amdgpu_vcn_inst *vcn_inst =
+		container_of(work, struct amdgpu_vcn_inst, idle_work.work);
+	struct amdgpu_device *adev = vcn_inst->adev;
+	unsigned int inst = vcn_inst->work_inst;
+	unsigned int fence = 0;
+	unsigned int i;
 	int r = 0;
 
-	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
-		if (adev->vcn.harvest_config & (1 << j))
-			continue;
-
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
-			fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_enc[i]);
-
-		/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-		    !adev->vcn.using_unified_queue) {
-			struct dpg_pause_state new_state;
-
-			if (fence[j] ||
-				unlikely(atomic_read(&adev->vcn.inst[j].dpg_enc_submission_cnt)))
-				new_state.fw_based = VCN_DPG_STATE__PAUSE;
-			else
-				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
 
-			adev->vcn.pause_dpg_mode(adev, j, &new_state);
-		}
+	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
+		fence += amdgpu_fence_count_emitted(&adev->vcn.inst[inst].ring_enc[i]);
 
-		fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_dec);
-		fences += fence[j];
+	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+			!adev->vcn.using_unified_queue) {
+		struct dpg_pause_state new_state;
+		if (fence ||
+				unlikely(atomic_read(&adev->vcn.inst[inst].dpg_enc_submission_cnt)))
+			new_state.fw_based = VCN_DPG_STATE__PAUSE;
+		else
+			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
+		adev->vcn.pause_dpg_mode(adev, inst, &new_state);
 	}
 
-	if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
+	fence += amdgpu_fence_count_emitted(&adev->vcn.inst[inst].ring_dec);
+
+	if (!fence && !atomic_read(&adev->vcn.total_submission_cnt)) {
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 		       AMD_PG_STATE_GATE);
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-				false);
+											false);
 		if (r)
 			dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
 	} else {
-		schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
+		schedule_delayed_work(&adev->vcn.inst[inst].idle_work, VCN_IDLE_TIMEOUT);
 	}
 }
 
@@ -426,7 +428,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	atomic_inc(&adev->vcn.total_submission_cnt);
 
-	if (!cancel_delayed_work_sync(&adev->vcn.idle_work)) {
+	if (!cancel_delayed_work_sync(&adev->vcn.inst[ring->me].idle_work)) {
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 				true);
 		if (r)
@@ -475,7 +477,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
 
 	atomic_dec(&ring->adev->vcn.total_submission_cnt);
 
-	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
+	schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work, VCN_IDLE_TIMEOUT);
 }
 
 int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index f6717f780acd..5733dda64713 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -279,6 +279,7 @@ struct amdgpu_vcn_fw_shared {
 };
 
 struct amdgpu_vcn_inst {
+	struct amdgpu_device *adev;
 	struct amdgpu_bo	*vcpu_bo;
 	void			*cpu_addr;
 	uint64_t		gpu_addr;
@@ -297,6 +298,8 @@ struct amdgpu_vcn_inst {
 	atomic_t		dpg_enc_submission_cnt;
 	struct amdgpu_vcn_fw_shared fw_shared;
 	uint8_t			aid_id;
+	struct delayed_work	idle_work;
+	uint8_t 		work_inst;
 };
 
 struct amdgpu_vcn_ras {
@@ -305,7 +308,6 @@ struct amdgpu_vcn_ras {
 
 struct amdgpu_vcn {
 	unsigned		fw_version;
-	struct delayed_work	idle_work;
 	const struct firmware	*fw[AMDGPU_MAX_VCN_INSTANCES];	/* VCN firmware */
 	unsigned		num_enc_rings;
 	enum amd_powergating_state cur_state[AMDGPU_MAX_VCN_INSTANCES];
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 33da094f1a7d..285935df3cb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -604,7 +604,7 @@ static void jpeg_v1_0_set_irq_funcs(struct amdgpu_device *adev)
 static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct	amdgpu_device *adev = ring->adev;
-	bool	set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
+	bool	set_clocks = !cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 	int		cnt = 0;
 
 	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index b7aa37b3a717..1bd1e348dab7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -150,7 +150,7 @@ static int jpeg_v2_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index a0cddb37a541..2f397969fe0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -211,7 +211,7 @@ static int jpeg_v2_5_hw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 45ffea1c759b..3b8c42516ba8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -164,7 +164,7 @@ static int jpeg_v3_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 3f91d79c07f8..774cfcbaa628 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -195,7 +195,7 @@ static int jpeg_v4_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index ad4030ccd917..13128bdd45a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -219,7 +219,7 @@ static int jpeg_v4_0_5_hw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 85fb1a5265a8..e2450f3b1eb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -161,7 +161,7 @@ static int jpeg_v5_0_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index bafdd6d5ff24..38497ba60292 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -149,7 +149,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	/* Override the work func */
-	adev->vcn.idle_work.work.func = vcn_v1_0_idle_work_handler;
+	adev->vcn.inst[0].idle_work.work.func = vcn_v1_0_idle_work_handler;
 
 	amdgpu_vcn_setup_ucode(adev);
 
@@ -276,7 +276,7 @@ static int vcn_v1_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 		(adev->vcn.cur_state[0] != AMD_PG_STATE_GATE &&
@@ -300,7 +300,7 @@ static int vcn_v1_0_suspend(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	bool idle_work_unexecuted;
 
-	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.idle_work);
+	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 	if (idle_work_unexecuted) {
 		if (adev->pm.dpm_enabled)
 			amdgpu_dpm_enable_uvd(adev, false);
@@ -1829,7 +1829,7 @@ static int vcn_v1_0_set_powergating_state(void *handle,
 static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_device *adev =
-		container_of(work, struct amdgpu_device, vcn.idle_work.work);
+		container_of(work, struct amdgpu_device, vcn.inst[0].idle_work.work);
 	unsigned int fences = 0, i;
 
 	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
@@ -1862,14 +1862,14 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 			       AMD_PG_STATE_GATE);
 	} else {
-		schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
+		schedule_delayed_work(&adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
 	}
 }
 
 static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct	amdgpu_device *adev = ring->adev;
-	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
+	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
 
@@ -1921,7 +1921,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 
 void vcn_v1_0_ring_end_use(struct amdgpu_ring *ring)
 {
-	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
+	schedule_delayed_work(&ring->adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
 	mutex_unlock(&ring->adev->vcn.vcn1_jpeg1_workaround);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 72e36fbaad39..37ace062788b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -313,7 +313,7 @@ static int vcn_v2_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 	    (adev->vcn.cur_state[0] != AMD_PG_STATE_GATE &&
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 09b342ad02cd..aa1c96571a21 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -390,7 +390,8 @@ static int vcn_v2_5_hw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index ee9a40443d65..52c8e7767a6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -422,7 +422,8 @@ static int vcn_v3_0_hw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index aaecc680b631..9b18810f00e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -350,7 +350,8 @@ static int vcn_v4_0_hw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 87c04c512357..fb425e27ab89 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -315,10 +315,12 @@ static int vcn_v4_0_3_hw_init(void *handle)
 static int vcn_v4_0_3_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
 
-	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.cur_state[i] != AMD_PG_STATE_GATE) {
 			vcn_v4_0_3_set_powergating_state(adev, AMD_PG_STATE_GATE);
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 2092360e133a..0c093d23a73f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -300,7 +300,8 @@ static int vcn_v4_0_5_hw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 045ac9c8d8be..b9eb12d2cd1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -264,7 +264,8 @@ static int vcn_v5_0_0_hw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
-- 
2.34.1

