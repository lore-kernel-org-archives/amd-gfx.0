Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B012C19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 19:18:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9770689906;
	Wed,  5 Mar 2025 19:18:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ys0rmykP";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B998E89906
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 19:18:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUY0B7CEFg6JuFdHc9Gbcf0NbwCKUpB7G55g09RRvbextU0+3hVlSpVCQRQQjbYoRIyuUhFPBGDm/jdRNWicVTmAfDQxz9c4Sx+Dz3vxZ/R/9CTlmMVn+GlFUOYlOuFWEmhFbsj7d6m7v6dyAPXsCXbINiGs9JN/8Q89vMVAnjKCi3O5TRQoSjIJIMg1dP7UVIMLgrpW5vUPPlT4YM5/NWygXHJ1s08nFU3ObCOxS4mFBdcsO6PjzOxxxyclXxa/r9mONY9XCYlQwhLAXSK98bvdaWJ21aXVxLUmQtVbDM10U3uPYtnvy76gW1kdF2EoQyU6mBSzBKF7C7I2ES/fHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pgo5ZmspFWMOKuaaNgVBtvJFbJFRqm85HnbMSWHlas=;
 b=sjUMIHMD4pWTFnAwk6DATcHquwMQI+TMM8CFJl1XMZZcICdVIusZNaB3UkbMmEQhrv9+QtIZWG2/2tWH2r1FJUkZ7ykhoZqFobwORyuORFm1XyVmoIA+jPLarYa9oZ/XnCGUivm3fM/ZPzzr+oIxZmy06ut7GLGo9vTPEXLC0ttaHlh2jIcGRDDiiWeESA+F/DrkQXlUTzy7CV+T6y3/Z0zd1lsscwxw0lM38SssO6fv3aUMzXsV0CxSMWgtM9gst6GxJAX6YZMzbf/PJwqj6vnEpndiJ1c4k1/zBp3M/g54zGY4rlua/vNmQNlgvXGQxp4BbreNzOa2XJ6Ascwttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pgo5ZmspFWMOKuaaNgVBtvJFbJFRqm85HnbMSWHlas=;
 b=Ys0rmykPrtcwXxhtOcfFIdUaG40we3QnGDX5OUjyrle1PwIwLFrPs0tO/9uStv5CVPQvJNIATfRXLfe0hyuxDLRxDbZBuLB8F3l3KHzYh0bdxXfIQSeleplHvb2Zb69S0V/g8Mn2VTfWX7EO0g3nJ6Eqv5Sk2G8XFRRxzNkRwFQ=
Received: from MW4PR03CA0121.namprd03.prod.outlook.com (2603:10b6:303:8c::6)
 by SN7PR12MB7251.namprd12.prod.outlook.com (2603:10b6:806:2ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 19:18:13 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::18) by MW4PR03CA0121.outlook.office365.com
 (2603:10b6:303:8c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 19:18:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 19:18:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 13:18:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: fix idle work handler for VCN 2.5
Date: Wed, 5 Mar 2025 14:17:56 -0500
Message-ID: <20250305191756.1132583-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|SN7PR12MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: a61a044f-c280-4627-ea48-08dd5c1a77f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0kFi7ziHnIgaT3ovxefuFCuPL+0q5oFqgg6aqcunQ4SQpdvNwChrwd/q38Py?=
 =?us-ascii?Q?u//EdvkaIPFWEkpwl/viAlMbIIIbajkzqhS7gM4ax3OLxxMU63tAdouSE25t?=
 =?us-ascii?Q?Oe1F1xWrR/+W6vc5OUbA8motbhNNDx5FNL/Bj3cBDqE3Sv8VpqlG5wO8s1K1?=
 =?us-ascii?Q?WASbqxrH9pseHw7xCCtP+JyqLp0qWADGccdf2MlsqF2X8v7tTqyMHtEiax06?=
 =?us-ascii?Q?K0Pa3WIHdFnFZ9CH8dITWDEbD2mqB8Eame61dI3l0Zn/0gVtRA+VlnlYOQHj?=
 =?us-ascii?Q?2A2JVjvx6v3rTC7l37y/3WewAIUMY2WWlQQCnk6rqHcMMojlOKaQckXVIupA?=
 =?us-ascii?Q?T3jAJvHTEhH2hSjMJyyRbI+E75Pgbi3Rt0iqm0mGyEJkT0vBGL/Qn3Y4tIAu?=
 =?us-ascii?Q?P92kJTO0iUfT4lTp0XOfCE4P62SXp0kp5/KObDLUOImk8t2n6XWlmuxZT8lW?=
 =?us-ascii?Q?9AmzAcLxXwGqvM9juft3i+t3oW35RY+44QibA1jyo7zoCuuvVPjK1uETdwSe?=
 =?us-ascii?Q?Vl36VjoiFKd5KgGnrL+zuJZxcBt82aaI2FaZwzUj/FwFrd4zqREZorofMSNR?=
 =?us-ascii?Q?xsSMuOz5Vti6pbaPyZwcRMx3tbxzyQAnHI6GVhSn6YBAY+ZkjI517YIMmAxJ?=
 =?us-ascii?Q?ZX3B/BwMyqac0Pz3k8c0DIAIgNuaFRPweSBOfm5MxLp8G6SLr2b0Kok84Phk?=
 =?us-ascii?Q?ykmT3bzeyIowsKDXbsHjXnwPmbRTsYXck8Ae1IIwWiMsyxevyntgWbKiT1Vl?=
 =?us-ascii?Q?iJ0xbD9wqdEMTbW1fFc7BfDeNGFBrh6SRkus8J/1rJywwrTdjBW+Tdw7TiS/?=
 =?us-ascii?Q?8mqJBb/CJETQpXl1A7MkxAPrR4xeXRYW9WU4qGGlNZjUZ304vW40t6MoIUYl?=
 =?us-ascii?Q?L5iB0g7EoTSAklto9fRdYmy3ADFiRoxt2UL3Q3lWb6TlcbRJC8dzlk0kgSV6?=
 =?us-ascii?Q?hp+Krb0wZjlkpZnsyLpQr7qc4RYczd4vUekHX0ZiW6S/uR91alzMbTy9k5vS?=
 =?us-ascii?Q?+2RcVFRc67ZWZ1cz44i26FSxKJfEoJeOIWLfCiWHpQXZUbOTEA8VOUY9RF6V?=
 =?us-ascii?Q?G0AiIindTGLaVRC+y+6tMVYX2ZKFMHFA78QihPjL8Vb9Hmht/vHZa8gncwrK?=
 =?us-ascii?Q?cK3okYJWvCsYvqsVQIj12zcAwwe+QOKzTeE+2GPK38eOo7S3y7RKreMA6WVo?=
 =?us-ascii?Q?WVftAzD74KjfSdtHBUqw39k52YHZ3sf+S+Hjk6BFsxywdN3AXMXMx7Ut3r5G?=
 =?us-ascii?Q?ayKjM4ZEtm/Zy14zCDL0pKmts1wNUnYeueS0KY58+tS5SDES/3CJbzYp1jBZ?=
 =?us-ascii?Q?nlluD817eoXlnvyL487J47Sswt6QrY/+d8RFgUshBMKxK67P5wT+/Cridx8e?=
 =?us-ascii?Q?3VQ/CLHMs6ws9c6xRXvefpB1h9aG1MzpKCUFyjTbPJrBPBTAHDf7GIZNcPMx?=
 =?us-ascii?Q?AF5O5PmlpXiuDJ2OMqSlus/LVG9aXEoBW/hXYfUPo+/k2FRHZkEvsA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 19:18:10.6229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a61a044f-c280-4627-ea48-08dd5c1a77f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7251
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
v4: fix logic in DPG handling

Fixes: 4ce4fe27205c ("drm/amdgpu/vcn: use per instance callbacks for idle work handler")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 120 +++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index dff1a88590363..ff03436698a4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -107,6 +107,115 @@ static int amdgpu_ih_clientid_vcns[] = {
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
+	struct amdgpu_vcn_inst *v = &adev->vcn.inst[ring->me];
+	int r = 0;
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
+	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+	    !v->using_unified_queue) {
+		struct dpg_pause_state new_state;
+
+		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC) {
+			atomic_inc(&v->dpg_enc_submission_cnt);
+			new_state.fw_based = VCN_DPG_STATE__PAUSE;
+		} else {
+			unsigned int fences = 0;
+			unsigned int i;
+
+			for (i = 0; i < v->num_enc_rings; ++i)
+				fences += amdgpu_fence_count_emitted(&v->ring_enc[i]);
+
+			if (fences || atomic_read(&v->dpg_enc_submission_cnt))
+				new_state.fw_based = VCN_DPG_STATE__PAUSE;
+			else
+				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
+		}
+		v->pause_dpg_mode(v, &new_state);
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
@@ -201,6 +310,9 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 
+		/* Override the work func */
+		adev->vcn.inst[j].idle_work.work.func = vcn_v2_5_idle_work_handler;
+
 		amdgpu_vcn_setup_ucode(adev, j);
 
 		r = amdgpu_vcn_resume(adev, j);
@@ -1661,8 +1773,8 @@ static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
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
@@ -1759,8 +1871,8 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
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

