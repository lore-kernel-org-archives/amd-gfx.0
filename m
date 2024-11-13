Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539B1D637CA
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 21:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 047B210E6E7;
	Wed, 13 Nov 2024 21:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RirnkHpK";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A080010E6E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 21:45:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKYWmuZywfuL+TXIm4SxwKpUyFnKtEw1NryeqN0lGpO/vbGmNt6q9LjSohX3dQ0ChSOYArfbyH34M6zbPAv+qc1RZkr1CIIZpNmLZDMUAVaW4Kq19jITPxMKEJyOtBRWszP3kAl8HEQKhlfoAaf/nqTPcu2DnU33BhIb9TZXD9Ha4Os5Ws/pBry49DF72N9U/T+9NvgPF+qbL1XizKfQxLXP/flnjVXhALgyxu3Pvl235QolpqQ71qmPdMH9PN1sw38KAsF1RG8COpkfhaEfWA+oIuvID9JYr6W+/nuG3KfSmw78iOz8Fsnoj7UYM3ANT4BADRnvlbmXrXqjCaZ1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zB1Hg04VdneZGQIbLq6du4R/OUB5lTlSXm+mv3fLyog=;
 b=wP3uZ53FCkH2Nmhjz7O//skxmnQYUIOlhoQxLqkq29aEasAuo8DKJigPfarbqfSAb5Xhgf0MQ2DTSTYdVRxtu1J/kMKso7QUdjgsSK/WIDCufEwmvRPGeF/WhCwMg2lI11nqcyY2JUFkGwtBfLOuozQBqe0rOZ722EHdiFQG8W9PNlAjngD7e4Y099LUi2S3wQFF8cSTYu/zucbBNiZn/OUK5ieb7noul4+ZtK+JFXdMfXWQzCHZsb7BypMkeusrhJ99pclIeGrII2jZ15X8AhJH9bINvQdT31Zn6oHhxcQFEPPb0WaBUBuMvLMormpIjqZv++iYBxNpKiQowi0Bpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB1Hg04VdneZGQIbLq6du4R/OUB5lTlSXm+mv3fLyog=;
 b=RirnkHpKELqMDoqtgqJ9d48pqC5HG+kvnc84f305WjzcPUC73frr64YRZ4uv+I376rI9RK++/PwhbkoMUCyMBVIc2dQWY5wqSL+cy13HILjrT13MN4TrFBeawYrk207AdK0Suu6WLt89NnxDLdJS8d/dvEmxH5dX5vWvVNqFmes=
Received: from SJ0PR05CA0152.namprd05.prod.outlook.com (2603:10b6:a03:339::7)
 by SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 21:45:17 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::6d) by SJ0PR05CA0152.outlook.office365.com
 (2603:10b6:a03:339::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.14 via Frontend
 Transport; Wed, 13 Nov 2024 21:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:45:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:45:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/15] drm/amdgpu/vcn: switch work handler to be per instance
Date: Wed, 13 Nov 2024 16:44:47 -0500
Message-ID: <20241113214453.17081-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113214453.17081-1-alexander.deucher@amd.com>
References: <20241113214453.17081-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3bfb88-7885-4d03-92bb-08dd042c76b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aCByyCXAoLSfCjAgiWWRvkHfZ5c6O7h7cIYxgmIG+MkjyRp+1onnZ4bHhg3k?=
 =?us-ascii?Q?DQVoI4bUFPyNbtB3q3SisFf1WwDc2MP+XHeDUBxgR8iDxxnoxNc2668P1NvW?=
 =?us-ascii?Q?KQnwDXLfejn4ssXDzQQA7DCM3IduHWWVuwaCokncNc15Oc/K08rEa7luXi1U?=
 =?us-ascii?Q?32uBodF5zqHOc2yUSpb0WMnN21AjeZW0wauecF9M51z+YK1Dr8cbuADUf8x2?=
 =?us-ascii?Q?ey7VgXiZSNC+ALvNorqr7jDd7XKdP9TfznpAzqlo+9nTkwtI14AKkH8IlmCC?=
 =?us-ascii?Q?+K5zEUczi11RIW9I7kjmtfjFQQx9RUIUZLfJy8+7P0p2V/5lwke4p9+mnj8g?=
 =?us-ascii?Q?8FHmEgkc7BN9aq8dxjfvsNzHSgMcbQwGNmbPNk/xMpTzvpyzIGmvEQPMIj90?=
 =?us-ascii?Q?74gDagq1/YYkyLryrOkwWb0bs3ruuyyyfpilGkuvNhSbvnbRy5uUOuaTGnlq?=
 =?us-ascii?Q?PMUjYPeGMWkWWMpJKq9W836sKkY7jllcDEbavhT0SjPhvoJpWprlAjPjZP8C?=
 =?us-ascii?Q?Q9Uom2v9M8TDkaBzhSXFPHfq8B4wLDmJqcxvH/V24ONQhjr/Kas77gicICMX?=
 =?us-ascii?Q?MVLtLGLrwavia8XmM5Mmj8i/c7bbu+b09XhKmv8H7iQ+w5s3WF5256UjJNte?=
 =?us-ascii?Q?DDY91bnViHN4N2wuGq5bGLB4z9Mlf2yZ+a7N4OZN98RLXapcclZNYVciVdjC?=
 =?us-ascii?Q?DjQEj3BJqDUj9u8Jkwcz85enqCCmZBqr8KWw/t0R1LB4Xjazf2A0XdrVzyLJ?=
 =?us-ascii?Q?zA/0iKLWf5DcsNhQyAFBDy5TXc/1FAyst86BXKA8WTzGL7bu29sx8m9QCGx8?=
 =?us-ascii?Q?oKjM03db0thx+xlmXNpgLfo/X5jQRTAUslQITDA1gVVTeW7H6GI2UCzvEbJJ?=
 =?us-ascii?Q?RfX8aaKvK0v1RY8AYEpfbC+1OBytHwGh/NiOAw7phtGZ/ZjyxZnRO06OluAh?=
 =?us-ascii?Q?f/FSiMRpRIo+ThYFVkPF7az+6rF1TwRKICwWV43nwmry2J2+PjwwnNr7rGOu?=
 =?us-ascii?Q?EtvYIw3VukhVTK4TIbFlLOPu6k5TStKADlMqfvLa+L1GL8apD05V3QtEXGXi?=
 =?us-ascii?Q?nSYyqA/FT5N+MXLUCy2Hipe9YfK4+tLbVAt9HsruaJoxa8ve2qpt+Q+VHLoa?=
 =?us-ascii?Q?VgxpVTarclIV8c8qvdEJ2AkCio4SnEp5C0L2oj6IpYgDUDh0FAmlW4FxKx+j?=
 =?us-ascii?Q?/o6HmC9BtnXJMSxom8Q70O/8OnZRZS1qUOCoEIn89JueLte4Mi35G5QNfoln?=
 =?us-ascii?Q?BiBbZ+n24I5O6ixTDsg+TbulzxSYLi7wGb6bxjYrQ5DWnZiGbQuSSlXOt4mV?=
 =?us-ascii?Q?ntnhwNwhpu94PMeBwvYVSP8IpBpYOGpo831SH84JRJbnQeeRBCgXY0bR4a8f?=
 =?us-ascii?Q?JoFB231cjgPM8CI8vwFRD6phEHEFxgTbymBHyidKVfMIeeZY8Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:45:17.0192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3bfb88-7885-4d03-92bb-08dd042c76b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 83 +++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  8 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 17 ++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  5 +-
 10 files changed, 75 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index b4a550795470..3383e4146c6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -118,12 +118,15 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	unsigned int fw_shared_size, log_offset;
 	int i, r;
 
-	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
-	mutex_init(&adev->vcn.vcn_pg_lock);
 	mutex_init(&adev->vcn.vcn1_jpeg1_workaround);
-	atomic_set(&adev->vcn.total_submission_cnt, 0);
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
+		adev->vcn.inst[i].adev = adev;
+		adev->vcn.inst[i].inst = i;
+		atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
+		INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
 		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
+	}
 
 	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 	    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
@@ -271,10 +274,10 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 			amdgpu_ring_fini(&adev->vcn.inst[j].ring_enc[i]);
 
 		amdgpu_ucode_release(&adev->vcn.inst[j].fw);
+		mutex_destroy(&adev->vcn.inst[j].vcn_pg_lock);
 	}
 
 	mutex_destroy(&adev->vcn.vcn1_jpeg1_workaround);
-	mutex_destroy(&adev->vcn.vcn_pg_lock);
 
 	return 0;
 }
@@ -325,8 +328,10 @@ int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev)
 int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 {
 	bool in_ras_intr = amdgpu_ras_intr_triggered();
+	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
 
 	/* err_event_athub will corrupt VCPU buffer, so we need to
 	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
@@ -382,46 +387,45 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
 
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
 
@@ -430,18 +434,18 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
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
@@ -466,7 +470,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 		adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
 	}
-	mutex_unlock(&adev->vcn.vcn_pg_lock);
+	mutex_unlock(&adev->vcn.inst[ring->me].vcn_pg_lock);
 }
 
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
@@ -479,9 +483,10 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
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
index 7b528123b36e..0d9a4d946eac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -279,6 +279,8 @@ struct amdgpu_vcn_fw_shared {
 };
 
 struct amdgpu_vcn_inst {
+	struct amdgpu_device	*adev;
+	int			inst;
 	struct amdgpu_bo	*vcpu_bo;
 	void			*cpu_addr;
 	uint64_t		gpu_addr;
@@ -300,6 +302,9 @@ struct amdgpu_vcn_inst {
 	const struct firmware	*fw; /* VCN firmware */
 	uint8_t			vcn_config;
 	uint32_t		vcn_codec_disable_mask;
+	atomic_t		total_submission_cnt;
+	struct mutex		vcn_pg_lock;
+	struct delayed_work	idle_work;
 };
 
 struct amdgpu_vcn_ras {
@@ -308,7 +313,6 @@ struct amdgpu_vcn_ras {
 
 struct amdgpu_vcn {
 	unsigned		fw_version;
-	struct delayed_work	idle_work;
 	unsigned		num_enc_rings;
 	enum amd_powergating_state cur_state;
 	bool			indirect_sram;
@@ -316,9 +320,7 @@ struct amdgpu_vcn {
 	uint8_t	num_vcn_inst;
 	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
 	struct amdgpu_vcn_reg	 internal;
-	struct mutex		 vcn_pg_lock;
 	struct mutex		vcn1_jpeg1_workaround;
-	atomic_t		 total_submission_cnt;
 
 	unsigned	harvest_config;
 	int (*pause_dpg_mode)(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 5ea96c983517..9ca964e11540 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -150,7 +150,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	/* Override the work func */
-	adev->vcn.idle_work.work.func = vcn_v1_0_idle_work_handler;
+	adev->vcn.inst->idle_work.work.func = vcn_v1_0_idle_work_handler;
 
 	amdgpu_vcn_setup_ucode(adev);
 
@@ -277,7 +277,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
@@ -301,7 +301,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	bool idle_work_unexecuted;
 
-	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.idle_work);
+	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
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
+		schedule_delayed_work(&adev->vcn.inst->idle_work, VCN_IDLE_TIMEOUT);
 	}
 }
 
 static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct	amdgpu_device *adev = ring->adev;
-	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
+	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
 
 	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
 
@@ -1921,7 +1922,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 
 void vcn_v1_0_ring_end_use(struct amdgpu_ring *ring)
 {
-	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
+	schedule_delayed_work(&ring->adev->vcn.inst->idle_work, VCN_IDLE_TIMEOUT);
 	mutex_unlock(&ring->adev->vcn.vcn1_jpeg1_workaround);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index e42cfc731ad8..115f33c3ab68 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -313,7 +313,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 	    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index b9be304aa294..6fb08ed09310 100644
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
index a3627700ed48..70a1b85a4efa 100644
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
index e11bd6cae8fc..656c2a1c4bf9 100644
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
index d4d92d4e2cab..8eea78c498da 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -331,8 +331,10 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
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
index 26bd1954b5e3..7086f98c2ddc 100644
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
index 95b31167f552..4c641813aeff 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -274,11 +274,12 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
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
-- 
2.47.0

