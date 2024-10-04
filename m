Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BF2CF8840
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 18:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8609A10EA8B;
	Fri,  4 Oct 2024 18:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VMS2b+e2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8E2A10EA9B
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 18:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKgTPl/BUVkEElfrVIn17NF5mpRQEM121ojp4P2+eu3kyiTDKCwU25hwyvdCEBKT1vj580EIUAvaZLEg8qx6nJEjOVxw6KSmnmUjiZYhZFc9zfI8+P52KnXgd7k/m/N6MQR2pan7OjA8shOiycbslt4P/3i6CWBkX+NOKDRhEQ04nG6gA2KOoFsm9PEQZQb7Yz/mtmJHAWhftp1vzH4+WEC+I/UIGYb/nu4KyquOvMw1DhOlg0nYHJ/ORBwCSsQGoGXdcp4IpbYhwpqdizPPfUFQNHD6VDExuAOD/2YV72sYjS3JbBe9Vo4kwWn7KauHx/jakS6veVQkFCkI4hFaoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmEjmASyUADpJZWmf0mbou9eAU80bTzygBZagi6+YK0=;
 b=J2k/PDrHapJ9b6uxhXxhkGmAU1QX7iRypIBV3Kr3W8IF0gPNbIxjD3+LprCqUELsveExSUdTr+227m9KS6kf/lTuQ4rFDQRhQm1xDEUzvQ6HAh07L4q+901lM6U34CIgRARCICb7tpNMtnXiP9FlHg4nP8waQT4n/I88Gy0ZIY+ySU0OnsO2oSYGWz/mkjqt2KHXh9UpIZN7cyMJM86o5Za/liWPm+MWG4Vgsv9YGlZDsC2ILut7TMqdMYA7qtrdavsIxCMaLo+DuO0nrrKEP23y+8E6GpdTVwh+Eh53EjCp6VhRydJA9MONcojq5+IjdSXjAN/ThDg3E4RMOtUpNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmEjmASyUADpJZWmf0mbou9eAU80bTzygBZagi6+YK0=;
 b=VMS2b+e2fVO+zcvzkjKEAN6VRCnHnJkM1daCtz8i226JF/aQ5NnV2TWTFHMKmhBLD0yEGfk3ACusUinHUeGSnvgW43XQdalKPKXbVnEyiWHwO59WKKqcivR3m3MgnvOg38cROk90D0AsUiKmCo1lD3OEWxJhtGyEhlAe0lPRgw0=
Received: from BN9PR03CA0605.namprd03.prod.outlook.com (2603:10b6:408:106::10)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 18:45:10 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::9) by BN9PR03CA0605.outlook.office365.com
 (2603:10b6:408:106::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Fri, 4 Oct 2024 18:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 18:45:10 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 13:45:07 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 17/18] drm/amdgpu/vcn: separate idle work by instance
Date: Fri, 4 Oct 2024 14:44:43 -0400
Message-ID: <20241004184444.435356-18-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004184444.435356-1-boyuan.zhang@amd.com>
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8b4f58-5d93-456c-090b-08dce4a4acc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JCGmzKOJSqn1JuIQkAMH6io0gfoqe7l8h+aT5p1m3q8ogL9c5q/M9rCDCnTc?=
 =?us-ascii?Q?JjS6aToCLahpLWe2F70GxrYNcR8fEuniU6Hj3unBjEXBrGk+/QmTMBCP+AlM?=
 =?us-ascii?Q?SBB69VkRMe6F/F2te2Z+nUi1ud+rWKgXjR14Nd0DDDJrws2epn+J4lCiY19O?=
 =?us-ascii?Q?Xj0V7DIT8f2xMpDdQh4FzG2n41L/UVkIu6DsfqJgboUw1+i7VF0pt1mMhCSo?=
 =?us-ascii?Q?U/gka60CLtABXE3tSDl5IQpuwcCCkVCJLKNydKOe34iLqS9cKo9JW+2DAAif?=
 =?us-ascii?Q?TUaPzfAC5ey2AapeQVqfJXKpe3/I3/796zE9zs2zvj7LHrlfbpOnbG524jW1?=
 =?us-ascii?Q?b2iZoHkuOMIRAJOkbvN6bbWwmL76CnlwSkyp1+ElBQrUEddizEjg96MgP5GN?=
 =?us-ascii?Q?7lljRPA70XqFopnJfM9xOSiILOYQwCdtniyNAFs/mfQvsuE3kza+mPwfKNRB?=
 =?us-ascii?Q?cNFSwWOEHBTYPRE5jw6dNB5AacNcIHUaNC2SPJdWup9R72aME7NNjri3FuOt?=
 =?us-ascii?Q?fh2QReMQA4IX9GPdIlwi3pC81K36dFvbjSibUnBCpI2mGGrsk7RxFlO+1JuL?=
 =?us-ascii?Q?2SOBnG9cRxoETVkXZb7IUYm8rSoMr1vy1eNsRHu1hZmmA4/BbexggRVuVwfh?=
 =?us-ascii?Q?2r3PeyX3e6qBXlyqAd2JZoiS1rt88WUiNW5363+V2XcDZ7/2KP4kbKkZtuTD?=
 =?us-ascii?Q?LvTt/XpNjSjSL+YznwiDIo2gN6YLM95yASXQLfUPkbTimCE/Y0OFXNJfPsWy?=
 =?us-ascii?Q?CVG/FQ+mUEsXaypZHYIv9t8pWu8XT+gw4vDdeXDLWnrEOkC4QRYqLU/sZEXG?=
 =?us-ascii?Q?mJHcBWyCDQ6i2L5c+D0tvSBsP/BYlWTY8MyODERTXUqnI2Yl5aoKJmOtlbIA?=
 =?us-ascii?Q?jhFvBJsokYUhJKVsh2DZW5/ratWDY2Qs8TERMKygxmf1C03EDrWx2TiSEp7B?=
 =?us-ascii?Q?AW9EoJcmfPQTuigbNUsh1FRupDmPE1cOnmpfxDrm9Yvzf/QvgFohTFoJkceJ?=
 =?us-ascii?Q?DNxEbRQAoygdCnOszvU+8AHSkavj+tbf6HKv8d40C6ajMkWSfndOxIm1umIy?=
 =?us-ascii?Q?BvJLUgCPmxJ9lIsiz3BWCDQSdSinaOxYsAkUXDSgt85KnYUij1YS+NPflHaF?=
 =?us-ascii?Q?Wdot6BRa6DXjlpFR/yGI5z94AYoZ0Egn5K3iX2OhVqq//IMpUApYsXXzbB5D?=
 =?us-ascii?Q?BV9Gyw5qXpHgOnoCbbq8KKD8Vq75kwD0fxyI/leN3xwp4m6YTDGVk0FRJPkP?=
 =?us-ascii?Q?zkTP7V60PPWyrZE6d5XLH5F90twYdFkSKN5CpBxaa33rSrJABou51Ia8P1yj?=
 =?us-ascii?Q?5FaPiQGWltEp7rHg+nT5z+LBOurWdyenFm2sYV9xUmu8s/lpiqJKbP7fW5V0?=
 =?us-ascii?Q?veMQmOE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:45:10.2215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8b4f58-5d93-456c-090b-08dce4a4acc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009
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
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  2 +-
 17 files changed, 58 insertions(+), 54 deletions(-)

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
index 03b8b7cd5229..8031406e20ff 100644
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
index c5f692a45bee..4a8dc87dc6fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -150,7 +150,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index f1ddef8e60ee..7188184f8551 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -211,7 +211,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 69f0a9006b96..5af54669091d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -164,7 +164,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index e304108d7024..b369c7f4f122 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -195,7 +195,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 2a28eb479a34..19a94f837841 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -219,7 +219,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 692d0083b5f7..685eb88f4c1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -161,7 +161,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 4f768c6097d8..f7ea5b289281 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -150,7 +150,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	/* Override the work func */
-	adev->vcn.idle_work.work.func = vcn_v1_0_idle_work_handler;
+	adev->vcn.inst[0].idle_work.work.func = vcn_v1_0_idle_work_handler;
 
 	amdgpu_vcn_setup_ucode(adev);
 
@@ -277,7 +277,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 		(adev->vcn.cur_state[0] != AMD_PG_STATE_GATE &&
@@ -301,7 +301,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	bool idle_work_unexecuted;
 
-	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.idle_work);
+	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 	if (idle_work_unexecuted) {
 		if (adev->pm.dpm_enabled)
 			amdgpu_dpm_enable_vcn(adev, false, 0);
@@ -1830,7 +1830,7 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_device *adev =
-		container_of(work, struct amdgpu_device, vcn.idle_work.work);
+		container_of(work, struct amdgpu_device, vcn.inst[0].idle_work.work);
 	unsigned int fences = 0, i;
 
 	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
@@ -1863,14 +1863,14 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
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
 
@@ -1922,7 +1922,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 
 void vcn_v1_0_ring_end_use(struct amdgpu_ring *ring)
 {
-	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
+	schedule_delayed_work(&ring->adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
 	mutex_unlock(&ring->adev->vcn.vcn1_jpeg1_workaround);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 1b9085ddc00f..6e3a79b4ae64 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -313,7 +313,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 	    (adev->vcn.cur_state[0] != AMD_PG_STATE_GATE &&
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 1f8738ae360a..413fa0c8d0c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -387,7 +387,7 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int inst = ip_block->instance;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
 
 	if (adev->vcn.harvest_config & (1 << inst))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index ea79c83aa21d..84486438abde 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -420,7 +420,7 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int inst = ip_block->instance;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
 
 	if (adev->vcn.harvest_config & (1 << inst))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 1555e823abe2..19783d163be3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -349,7 +349,7 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int inst = ip_block->instance;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
 
 	if (adev->vcn.harvest_config & (1 << inst))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 97e3b10ba414..502cb8d36031 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -315,7 +315,7 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int inst = ip_block->instance;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
 
 	if (adev->vcn.cur_state[inst] != AMD_PG_STATE_GATE)
 		vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index b91a64de66ea..badb38e8bdc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -298,7 +298,7 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int inst = ip_block->instance;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
 
 	if (adev->vcn.harvest_config & (1 << inst))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index c6f06f778dbf..054d1b9df3f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -262,7 +262,7 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int inst = ip_block->instance;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[inst].idle_work);
 
 	if (adev->vcn.harvest_config & (1 << inst))
 		return 0;
-- 
2.34.1

