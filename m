Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D320EC02195
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D1F810E3DD;
	Fri, 31 Jan 2025 16:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s/q60wdT";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3338D10E3C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xw1UKisr5TS/QgsyqdKEvURc3XgpfJRTDgb7Cm5za8k5SLk81gL0tESoKP7tBGnVrjNW1AP9F/m1orLmoa/4OtL2A3OC9poKvgQeZx5uBAH/Nauzw2UFiQInCdVUDRGrYegnAITRto8b7KapnwbXzLKsz8rlqog8xht7BMQDbfG/n0tr4wfeJOWfw61XPzbwWvAGUHr9f59BhMIfu0GXyDEoHox3CBUOY7sEToJGU2QSoX8YOB+r+ZzO+jL4iZb1+HZnB2BCUY6y1OkeZmbgc2/toQwVayNW9CmSkw081KzyqWqMI5XfFHQLzOrf0I7JLCVwfzRVlJCOm3Iu/JAdUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pnMel3ysZJJAa7dhIKp2QA1j48elrRWzT1dk9SgTvo=;
 b=jco5jDn1soNxcMEJdOrk5/K8M/EAUhM85r7etDVdTBfxJKLLhpbre7cK/4soUXteVBehtb1PT8ajqQIxDSgjPHV/QyiMzdnIAIfFzCEDWMC+vLOn4gtR2+1y6QvxGYqpHXv9u44dpyRMq8qVrjCeI9oFAZmP9oNWYOH99Z1htDegpA3LaAUTtVWobcJJOhheCQdvtFOysPEZlay4RBt5hYQfTZ6yk9fWfSjX8ItEwcGIVgkDJHX03tSqV0Dp/oz7zJKoJP5Wq55BRvM9SQw2TdhKKlyh5okTOERQgBjuv2DVK02eFQ2+vc1JqUZbKnCxyeKl1jCzvO+Zc8P7eAtcvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pnMel3ysZJJAa7dhIKp2QA1j48elrRWzT1dk9SgTvo=;
 b=s/q60wdTkB245JnWqYaztBg79Sd3zZuf74eK9xuMwk7o+PYyPanE7w/EHuAtmaDZy2sKRAdXsJ0tAgnSUM7G8nx/fUyJCSiVZ3A6j2pB2zb26LXHfadnOqa/NKALd2DOGx+bdxfCFe25rTA+fmZ03X1UwN0NKiWg/LV2VK8hqSc=
Received: from DM6PR07CA0095.namprd07.prod.outlook.com (2603:10b6:5:337::28)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 16:58:09 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::9c) by DM6PR07CA0095.outlook.office365.com
 (2603:10b6:5:337::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/44] drm/amdgpu/vcn: switch work handler to be per instance
Date: Fri, 31 Jan 2025 11:57:04 -0500
Message-ID: <20250131165741.1798488-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: ce39f4a0-a4b3-4aa5-d0f0-08dd421870f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?THNE6cM8kMP+ersbiIxZqpcNUSMwcejolPioRXuYRMJHLdew+w1DRhNgBtXn?=
 =?us-ascii?Q?tVMFdpZWJ3OHkZwMymgq0l6GgJcJ0Lo1NyPtAP5tOAKSa5ElI2jq7XDoYAus?=
 =?us-ascii?Q?X73tNOmKYO8sCt1RDXLaIo/GTHOqcD/Fk16p7ASL0js99GRPq2FR1KS1INdV?=
 =?us-ascii?Q?s2n1Ervw7cVGg77G0r8dveRS++LGVhGWNeFhUCjE22sh8/FTXJYqZyeIkKiY?=
 =?us-ascii?Q?O8dJPlD/xb4q4w/cwlTu32Z5O4SAnEeOYXOaaoja6xClSOuQmXXKxRSoHlTG?=
 =?us-ascii?Q?EUO0jN/Pe8k5Ajd8H06s8Go2fw1br0Xn4FrlQxphNnp337IAnGSU7bdQdtVY?=
 =?us-ascii?Q?zBvBND0QZc/6vUYnZnl6bq4MMf5uTmzfJ/DQeYiyhosNCqO2HYQovfien45j?=
 =?us-ascii?Q?cWvpcC7BfFQmCQ+HA+YCcqWDnJv9fC0xU4ySzp5K2irQiaZ5hsXXIHiU1Tzn?=
 =?us-ascii?Q?0usxY+pRgkbcaMqfz1d5y8B/fe+egHmka5lLthJtzc0/pD9TZLmy7KCq7EYo?=
 =?us-ascii?Q?t3oZsiaYE7BVDGa394R2oAn/Z1aS1jW3gei0KjH9QtJ6P5dqilKe6a7X6fEa?=
 =?us-ascii?Q?FJOIqWH8M1PUHOiBKyuCTGdbaQPiRxP1JJnHvbgl95Vr8Jz/OBR1M+OORW31?=
 =?us-ascii?Q?MWHYp2l01BPVbqp1KzwVcI2qhCSD+wta6rzFKsymYvCBmZ7cJyFCyOmN55c1?=
 =?us-ascii?Q?EdOz42yehqvZOJeUmASzLARP+sNX1pYJBK70Fnn1GQ1bDAjrmT0x8IJQV5D9?=
 =?us-ascii?Q?ouWjaTNw8GAyxKU4xTspw89IkOJhu/etAAdoRm4eJ4f2MVH2kADHnI7ns6//?=
 =?us-ascii?Q?kh7cNp21vZn99PZtG6Ibl6gVoylgsYv/LBihHouztwHSv9y6lnP4QsZ2hcGk?=
 =?us-ascii?Q?LlEAFyC+0CTKFc39NZTk0RJ87BoQu50NRSIMQBGjndj5m3doAKi62VNXmATC?=
 =?us-ascii?Q?YtsZrxFCK3WKHY8urrZoNnGNJDXPEiZotvxjNTJlLccrxZbpL1641sknmNe0?=
 =?us-ascii?Q?xZy7PgjKby9n3bnAdcnknhKc+SKPLsRiPckJYqYD2V+QKl1d/FPFypEsseNW?=
 =?us-ascii?Q?8+xn8pXsgJbyZ3rmoPkIaomMJhn9ic4V+1wurxIcEdskz0h0jonJFYTMEk76?=
 =?us-ascii?Q?iJTdqNEYfoI7neg012MoH8NnZ9OJxtbS8+Xs1zLMTZkgEBHDNNLkUl+tlPLG?=
 =?us-ascii?Q?kkLUDEMSuPFrSt5R5Saaxa16XFRy3h/md3qPa3TxklVX27D3aKbWnvcnBNpm?=
 =?us-ascii?Q?EfJweHMnZ0+Ftvwk4JeBHycH5dqIXvQjY4d3uswlme9cZTzI3wBvjdbl8DCu?=
 =?us-ascii?Q?xcrr+mCc3kJNj/qXwcTjIiQ7Y6NcLecKAtQ1ZIjq9Ob9YR4afY9+NZXBH6rQ?=
 =?us-ascii?Q?+hUbOSpxBPuiPlrMsVOBr8vyCV+0PW3HClibNbJjJGpTFv40Crh4twq1fUX8?=
 =?us-ascii?Q?RIIGE2Ks+/FNRBGpOixcYGEcyFgKu3i6ozpc2iIjIAozeiNGTBdT9Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:09.6707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce39f4a0-a4b3-4aa5-d0f0-08dd421870f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834
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

Have a separate work handler for each VCN instance. This
paves the way for per instance VCN power gating at runtime.

v2: index instances directly on vcn1.0 and 2.0 to make
it clear that they only support a single instance (Lijo)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 84 +++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  8 ++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 17 ++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c |  4 +-
 12 files changed, 80 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 83faf6e6788a2..0c3081a198d9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -100,6 +100,9 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev)
 
 	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		adev->vcn.inst[i].adev = adev;
+		adev->vcn.inst[i].inst = i;
+
 		if (i == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
 			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw,
 						 AMDGPU_UCODE_REQUIRED,
@@ -124,12 +127,13 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	unsigned int fw_shared_size, log_offset;
 	int i, r;
 
-	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
-	mutex_init(&adev->vcn.vcn_pg_lock);
 	mutex_init(&adev->vcn.vcn1_jpeg1_workaround);
-	atomic_set(&adev->vcn.total_submission_cnt, 0);
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
+		atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
+		INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
 		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
+	}
 
 	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 	    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
@@ -277,10 +281,10 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 			amdgpu_ring_fini(&adev->vcn.inst[j].ring_enc[i]);
 
 		amdgpu_ucode_release(&adev->vcn.inst[j].fw);
+		mutex_destroy(&adev->vcn.inst[j].vcn_pg_lock);
 	}
 
 	mutex_destroy(&adev->vcn.vcn1_jpeg1_workaround);
-	mutex_destroy(&adev->vcn.vcn_pg_lock);
 
 	return 0;
 }
@@ -331,8 +335,10 @@ int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev)
 int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 {
 	bool in_ras_intr = amdgpu_ras_intr_triggered();
+	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
 
 	/* err_event_athub will corrupt VCPU buffer, so we need to
 	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
@@ -388,46 +394,45 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 {
-	struct amdgpu_device *adev =
-		container_of(work, struct amdgpu_device, vcn.idle_work.work);
+	struct amdgpu_vcn_inst *vcn_inst =
+		container_of(work, struct amdgpu_vcn_inst, idle_work.work);
+	struct amdgpu_device *adev = vcn_inst->adev;
 	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
-	unsigned int i, j;
+	unsigned int i = vcn_inst->inst, j;
 	int r = 0;
 
-	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
-		if (adev->vcn.harvest_config & (1 << j))
-			continue;
-
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
-			fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_enc[i]);
+	if (adev->vcn.harvest_config & (1 << i))
+		return;
 
-		/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-		    !adev->vcn.using_unified_queue) {
-			struct dpg_pause_state new_state;
+	for (j = 0; j < adev->vcn.num_enc_rings; ++j)
+		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
 
-			if (fence[j] ||
-				unlikely(atomic_read(&adev->vcn.inst[j].dpg_enc_submission_cnt)))
-				new_state.fw_based = VCN_DPG_STATE__PAUSE;
-			else
-				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
+	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+	    !adev->vcn.using_unified_queue) {
+		struct dpg_pause_state new_state;
 
-			adev->vcn.pause_dpg_mode(adev, j, &new_state);
-		}
+		if (fence[i] ||
+		    unlikely(atomic_read(&vcn_inst->dpg_enc_submission_cnt)))
+			new_state.fw_based = VCN_DPG_STATE__PAUSE;
+		else
+			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
-		fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_dec);
-		fences += fence[j];
+		adev->vcn.pause_dpg_mode(adev, i, &new_state);
 	}
 
-	if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
+	fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
+	fences += fence[i];
+
+	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-		       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE);
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-				false);
+						    false);
 		if (r)
 			dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
 	} else {
-		schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
+		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
 	}
 }
 
@@ -436,18 +441,18 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	int r = 0;
 
-	atomic_inc(&adev->vcn.total_submission_cnt);
+	atomic_inc(&adev->vcn.inst[ring->me].total_submission_cnt);
 
-	if (!cancel_delayed_work_sync(&adev->vcn.idle_work)) {
+	if (!cancel_delayed_work_sync(&adev->vcn.inst[ring->me].idle_work)) {
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 				true);
 		if (r)
 			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
 	}
 
-	mutex_lock(&adev->vcn.vcn_pg_lock);
+	mutex_lock(&adev->vcn.inst[ring->me].vcn_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-	       AMD_PG_STATE_UNGATE);
+					       AMD_PG_STATE_UNGATE);
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
@@ -472,7 +477,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 		adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
 	}
-	mutex_unlock(&adev->vcn.vcn_pg_lock);
+	mutex_unlock(&adev->vcn.inst[ring->me].vcn_pg_lock);
 }
 
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
@@ -485,9 +490,10 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
 	    !adev->vcn.using_unified_queue)
 		atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
 
-	atomic_dec(&ring->adev->vcn.total_submission_cnt);
+	atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
 
-	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
+	schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
+			      VCN_IDLE_TIMEOUT);
 }
 
 int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index c92f683ee5958..f1685283c2f13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -295,6 +295,8 @@ struct amdgpu_vcn_fw_shared {
 };
 
 struct amdgpu_vcn_inst {
+	struct amdgpu_device	*adev;
+	int			inst;
 	struct amdgpu_bo	*vcpu_bo;
 	void			*cpu_addr;
 	uint64_t		gpu_addr;
@@ -316,6 +318,9 @@ struct amdgpu_vcn_inst {
 	const struct firmware	*fw; /* VCN firmware */
 	uint8_t			vcn_config;
 	uint32_t		vcn_codec_disable_mask;
+	atomic_t		total_submission_cnt;
+	struct mutex		vcn_pg_lock;
+	struct delayed_work	idle_work;
 };
 
 struct amdgpu_vcn_ras {
@@ -324,7 +329,6 @@ struct amdgpu_vcn_ras {
 
 struct amdgpu_vcn {
 	unsigned		fw_version;
-	struct delayed_work	idle_work;
 	unsigned		num_enc_rings;
 	enum amd_powergating_state cur_state;
 	bool			indirect_sram;
@@ -332,9 +336,7 @@ struct amdgpu_vcn {
 	uint8_t	num_vcn_inst;
 	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
 	struct amdgpu_vcn_reg	 internal;
-	struct mutex		 vcn_pg_lock;
 	struct mutex		vcn1_jpeg1_workaround;
-	atomic_t		 total_submission_cnt;
 
 	unsigned	harvest_config;
 	int (*pause_dpg_mode)(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 03b8b7cd5229b..8031406e20ff9 100644
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
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 5ea96c9835170..b90d41cd001c8 100644
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
 		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
@@ -301,7 +301,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	bool idle_work_unexecuted;
 
-	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.idle_work);
+	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 	if (idle_work_unexecuted) {
 		if (adev->pm.dpm_enabled)
 			amdgpu_dpm_enable_vcn(adev, false, 0);
@@ -1828,8 +1828,9 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 
 static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 {
-	struct amdgpu_device *adev =
-		container_of(work, struct amdgpu_device, vcn.idle_work.work);
+	struct amdgpu_vcn_inst *vcn_inst =
+		container_of(work, struct amdgpu_vcn_inst, idle_work.work);
+	struct amdgpu_device *adev = vcn_inst->adev;
 	unsigned int fences = 0, i;
 
 	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
@@ -1862,14 +1863,14 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
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
 
@@ -1921,7 +1922,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 
 void vcn_v1_0_ring_end_use(struct amdgpu_ring *ring)
 {
-	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
+	schedule_delayed_work(&ring->adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
 	mutex_unlock(&ring->adev->vcn.vcn1_jpeg1_workaround);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index e42cfc731ad8e..a51691c6d6110 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -313,7 +313,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 	    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index b9be304aa294b..6fb08ed093101 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -390,12 +390,12 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
-
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+
 		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 		    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
 		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index a3627700ed48d..70a1b85a4efae 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -422,12 +422,12 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
-
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index c3eb4278bf465..4a846c9a2b039 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -359,11 +359,12 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
-
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
+
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 6293d1dc02fec..8343cee899c71 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -349,8 +349,10 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
 
 	if (adev->vcn.cur_state != AMD_PG_STATE_GATE)
 		vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index bf0da0da12512..e784f1457ee0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -300,11 +300,12 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
-
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
+
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 6b777ed01d445..03c7252e28ba9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -280,11 +280,12 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
-
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
+
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 25abb303d6698..5950ec4c7f6db 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -206,8 +206,10 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
 
 	return 0;
 }
-- 
2.48.1

