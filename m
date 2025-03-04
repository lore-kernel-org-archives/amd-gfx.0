Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C39C021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 23:02:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 409FA10E0D5;
	Tue,  4 Mar 2025 23:02:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bmdyk8Dw";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C9710E0D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 23:01:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONcYDZ4DI7VEg9QzVOS/9ECroJyzUQwXHJCX9kfSqH0gM+Pg6TZRzCZ3iU7NcebzbbCy+HQtd+jLYOg6k/E4h3vlv6H33dxh376FzzP5EnOgarEHSkP5m+DIx3RU57f/jIZ3N5wK2UEzuFBJFIQPG46Jn+poJQyCcAJfSBYLJmj73KKeN4hAxSlQEKXoC7DPsBBkTv/Arei8TOojB00L2ATL4TBmpjEtgTtcxDXeB/MFQHDi9irNcfD8ZfCJFZsX48CUdXtdJwCRD0tkZ9HTf7QCi5H3mneyqSZg0ZMWOq3CI59RSSSEh51X5dU+bdE4M2SuciM7v1tfPGvM2+myWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQul0yWQ/8ST/8NDO8EYIG4aXCuT3772IRNfxP+frLE=;
 b=OH7tGD1vLtin6fa4ZqQ6V+gDvmfuEETYSZvWBWOIANOLUWV0UVFptvdW3qd3pFZ+ti0+hesuX1uJYAhPXBS3d9F243/LcTsITmULweqhF+7JbDoeYeCaO3xVdNVSYaH3AzB8hBjVu0c6YzZuHfyU3fKsz3vT05R9ePLh9P6DW+IWLaDqQkIVP8pyUoagD25vMrXrloOFs/gTOqrJKX+8YSrcasOn4dRK5x7lKND9rAtiSSEi+O44gsJhGb7qQza0J7cMpmgQbpA6XSh0jzfpawr79AYbS9WBhc99YCe77aF5s+DEdQ6zoDaNrb7mixLmquZ84BW+BElQl1de9qJf1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQul0yWQ/8ST/8NDO8EYIG4aXCuT3772IRNfxP+frLE=;
 b=Bmdyk8DwXad2PnMcNfM7gVWHu7aFOE+evpjIeSbkeTX7Ky6SF2MIYh/vz3e6GHsYpMc1W2RDjWowfeBJKlTOKuS0oNbTb+zU434C6Em0oNH7Bxx0B0TT6yjKhX748aM5ffK0WcdrzsdvYEpgYX4/Enq72JUJ7eefgFER2zFeu5g=
Received: from SJ0PR03CA0199.namprd03.prod.outlook.com (2603:10b6:a03:2ef::24)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 23:01:45 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::36) by SJ0PR03CA0199.outlook.office365.com
 (2603:10b6:a03:2ef::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Tue,
 4 Mar 2025 23:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 23:01:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 17:01:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: fix idle work handler for VCN 2.5
Date: Tue, 4 Mar 2025 18:01:23 -0500
Message-ID: <20250304230123.71874-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 115965e1-c131-4cd9-30ac-08dd5b708850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?banw5wEgoWxpjRh1Fb1GIlvkm1Fvd0HjZiivqMLUum1xij/0RP2k6IpkeWes?=
 =?us-ascii?Q?HbgNwCv41uI5/E0rUk1DlF192tqyKzf5IAPTyrWtxZEy5nDL7ij8B4lBDhzM?=
 =?us-ascii?Q?iQH1p4vD79TQvbVQgq5qQCMCw1BqLRzW6W3A7Tzu3W7YXlF8wVXgO5PKhfL2?=
 =?us-ascii?Q?cKpfVRID9R8zYOmsHixPbv4d2nAy+C/MtC5hNhLr+2cBiSBKEy/ztLOnVHWW?=
 =?us-ascii?Q?v+FY6BKCPTuW0G8x/ZjcyvBQNpS0Y/f4V173GAElZ3DWioH081etdoPRWFkV?=
 =?us-ascii?Q?fbwu32dvxBIzSqzJBAidzhaLqTP9vkHBEc5Rgyyml539f/mzqNquloJbMXiD?=
 =?us-ascii?Q?Nxcr0U5noFlFUSH6sowH1dI4DDveIuylfA5I/+gSXSpd3tpKuaCzaTu5lTi6?=
 =?us-ascii?Q?KahnC8V2Y4gdCRs7EM/HL6MgOoa8qWBI5KpVvFYvrAVRuVNOfWGO1lVxQJCj?=
 =?us-ascii?Q?u+jY5KoY90T5bGUmxKzoeCHwfIWc5yink7rM2t05AtKVwMm2mGYRr809BMLy?=
 =?us-ascii?Q?yBJIEyyADnxi6Yelyjm2Azu8wbsmkI52PoPy1aOgzu6f6x1cERbfGHG2NEoB?=
 =?us-ascii?Q?H9AcJu5pIpJ5CQLugTH6PwdAyDuzP8Vu6v/ga1ape7FdxXPj7Df6aJ7PSTeO?=
 =?us-ascii?Q?VzEunOcLBZZMRudV+NzF4JAknmnSartOumO29yBtRsNghp9iXjYRx/AFEkFd?=
 =?us-ascii?Q?9LrlBzaM/2lpfB6IIu1BEz+7MsAYEQ7B9r41dPV/OQIY/7mSlihIjTzyC220?=
 =?us-ascii?Q?bsQm4lwL0ndvce7wQyYXX84W+F39qXTKm9tx573D4dObxbv7kR7ECJluTgid?=
 =?us-ascii?Q?NrSt6GxIxGkusP1zjCOI9+mVYLQayLDjbVu+UivXWD9se1FfzbRJT8kAymXc?=
 =?us-ascii?Q?c6lz/LfN8X3qsM3uaL0ho0umBrJRcT3Mu47lJWXrmnkF5aAUylkVcz8O//C0?=
 =?us-ascii?Q?av/T8RmUADNq7XmhW3LMRZVHu34egKvQPAQvNaO7s/bRt814QSERSblB9aNl?=
 =?us-ascii?Q?D9szJGf8x6ZhrHLCS+dZ+HOvo4gqMfQcZePCzRkEMfgeWqA65u/MUXmqUpx5?=
 =?us-ascii?Q?j+EdN20hEcm15yTfO6BYQkVSA/PwrGei1V8jjjYdTozYa/F5FVQs6FVUPj1A?=
 =?us-ascii?Q?nhG2HRc9wSNYwurCYTE/HU3N8Ay0QPNT6EU3jcMLGpKMCXgqWMx737RhuxNs?=
 =?us-ascii?Q?l4HDoFfwetEgQrGQOGUwSG5xPfd8GjRVCL34ffChXxLtLtrX3u4VroLH3aLw?=
 =?us-ascii?Q?dvozru4kdyzSWBOJCu9MXQqM7TD8WIIKIzBcBfxi//9g1Y0wV5SFEYhv4Ye2?=
 =?us-ascii?Q?qJ/HiuZJZipnDFJ64FVRxWp3d2SEkPCRNvLqqRn3MNoDcgkYKRbqEqlVLCfY?=
 =?us-ascii?Q?dwn0xWZouLEeS+34PHwL2QMklw4cTKugpEzBM3Pve0J0NSfOpA7PbL0BSlpk?=
 =?us-ascii?Q?N2AtUeHoKNs1KsZCQb1e7jjkAADJd9hlCEecmWbkaFtCdejSNr6/XA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 23:01:43.6180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 115965e1-c131-4cd9-30ac-08dd5b708850
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049
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

VCN 2.5 uses the PG callback to enable VCN DPM which is
a global state.  As such, we need to make sure all instances
are in the same state.

v2: switch to a ref count (Lijo)
v3: switch to its own idle work handler

Fixes: 4ce4fe27205c ("drm/amdgpu/vcn: use per instance callbacks for idle work handler")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 126 +++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index dff1a88590363..fa66521b940de 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -107,6 +107,121 @@ static int amdgpu_ih_clientid_vcns[] = {
 	SOC15_IH_CLIENTID_VCN1
 };
 
+static void vcn_v2_5_idle_work_handler(struct work_struct *work)
+{
+	struct amdgpu_vcn_inst *vcn_inst =
+		container_of(work, struct amdgpu_vcn_inst, idle_work.work);
+	struct amdgpu_device *adev = vcn_inst->adev;
+	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
+	unsigned int i, j;
+	int r = 0;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
+
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		for (j = 0; j < v->num_enc_rings; ++j)
+			fence[i] += amdgpu_fence_count_emitted(&v->ring_enc[j]);
+
+		/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+		    !v->using_unified_queue) {
+			struct dpg_pause_state new_state;
+
+			if (fence[i] ||
+			    unlikely(atomic_read(&v->dpg_enc_submission_cnt)))
+				new_state.fw_based = VCN_DPG_STATE__PAUSE;
+			else
+				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
+
+			v->pause_dpg_mode(v, &new_state);
+		}
+
+		fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
+		fences += fence[i];
+
+	}
+
+	if (!fences && !atomic_read(&adev->vcn.inst[0].total_submission_cnt)) {
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+						       AMD_PG_STATE_GATE);
+		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
+						    false);
+		if (r)
+			dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
+	} else {
+		schedule_delayed_work(&adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
+	}
+}
+
+static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int r = 0, i;
+
+	atomic_inc(&adev->vcn.inst[0].total_submission_cnt);
+
+	if (!cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work)) {
+		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
+						    true);
+		if (r)
+			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
+	}
+
+	mutex_lock(&adev->vcn.inst[0].vcn_pg_lock);
+	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+					       AMD_PG_STATE_UNGATE);
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
+
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+		/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+		    !v->using_unified_queue) {
+			struct dpg_pause_state new_state;
+
+			if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC) {
+				atomic_inc(&v->dpg_enc_submission_cnt);
+				new_state.fw_based = VCN_DPG_STATE__PAUSE;
+			} else {
+				unsigned int fences = 0;
+				unsigned int i;
+
+				for (i = 0; i < v->num_enc_rings; ++i)
+					fences += amdgpu_fence_count_emitted(&v->ring_enc[i]);
+
+				if (fences || atomic_read(&v->dpg_enc_submission_cnt))
+					new_state.fw_based = VCN_DPG_STATE__PAUSE;
+				else
+					new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
+			}
+
+			v->pause_dpg_mode(v, &new_state);
+		}
+	}
+	mutex_unlock(&adev->vcn.inst[0].vcn_pg_lock);
+}
+
+static void vcn_v2_5_ring_end_use(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+	if (ring->adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+	    ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC &&
+	    !adev->vcn.inst[ring->me].using_unified_queue)
+		atomic_dec(&adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
+
+	atomic_dec(&adev->vcn.inst[0].total_submission_cnt);
+
+	schedule_delayed_work(&adev->vcn.inst[0].idle_work,
+			      VCN_IDLE_TIMEOUT);
+}
+
 /**
  * vcn_v2_5_early_init - set function pointers and load microcode
  *
@@ -201,6 +316,9 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 
+		/* Override the work func */
+		adev->vcn.inst[j].idle_work.work.func = vcn_v2_5_idle_work_handler;
+
 		amdgpu_vcn_setup_ucode(adev, j);
 
 		r = amdgpu_vcn_resume(adev, j);
@@ -1661,8 +1779,8 @@ static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
 	.insert_start = vcn_v2_0_dec_ring_insert_start,
 	.insert_end = vcn_v2_0_dec_ring_insert_end,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
-	.begin_use = amdgpu_vcn_ring_begin_use,
-	.end_use = amdgpu_vcn_ring_end_use,
+	.begin_use = vcn_v2_5_ring_begin_use,
+	.end_use = vcn_v2_5_ring_end_use,
 	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
@@ -1759,8 +1877,8 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
 	.insert_nop = amdgpu_ring_insert_nop,
 	.insert_end = vcn_v2_0_enc_ring_insert_end,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
-	.begin_use = amdgpu_vcn_ring_begin_use,
-	.end_use = amdgpu_vcn_ring_end_use,
+	.begin_use = vcn_v2_5_ring_begin_use,
+	.end_use = vcn_v2_5_ring_end_use,
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
-- 
2.48.1

