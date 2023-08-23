Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B70EE49B5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30CEC10E45A;
	Wed, 23 Aug 2023 15:52:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFC1C10E447
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRtAj5W/30CPyxVxqGOEIwwXcJsTxWw+5yv8aO4mDL84Bj4eA7WtrK5VHWafbPVSl0+BOGpsnTCthWTsvfRwKP4LXHBiMJiCycUDB6fr+06Ks4prDWh+G//b2FA/Mt597+nNYOXCEIVCTlzcCvC3DbFSR5yaBdgSqarrgZOrqYLy8Uog1CGF7g3s9Iu62jexLwKDf6MZ6CkreRQSlEQwG0BqzCJX7Yhqeuf7YlY2IJxMpEewyhBihEZOlgGZHngI+yiGOSJIEwEkcPKfeDW0RTrgvqPfb9iG1i8Gmlcc7GqPlfH/J3QmvGnvSsN1zl0fwunevSeGM57trVgzsYHtzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUt6HMUBaXPtU9dLRMMXZsXZavN4sfaUgJDtFwNOY1A=;
 b=aIuq87eBS+/j1mptyYm41AfrJAQxjXt5WSXVqqJhi4X5otoMdclOt7iBYBIagktvykC7Y9TYFdCvLPkLGFCJDyGFH8yhrK/ZYEDhdx2rG6NUQ8y7UHh8XjnGvFTQ+P7Ibv1fa/zRgrg0STEXNgDrRGg7gsVxEjk0LDG68wTJEGggWOeBQ7NNAXBzbR5LkL8S2MyOAeJZrFAQgwHqerKQwBht5+JTIKZp2Rmh4ktJmPaPqJJhuSqfTvtl21feFfBDIQ9FAULpFhx9JqgdeviIyl+bc+VhkGaIqP6OqoHnMtDu+8JQuU46TPcdrNexBLs+zR3DNDy++YZWwVDcGzzbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUt6HMUBaXPtU9dLRMMXZsXZavN4sfaUgJDtFwNOY1A=;
 b=e8ITYbFJHNjrtu/o4smggK/25SvlJRlp9U/epSIs1T3DyoxYvLva/11RPbiwz7v7llNvOKf8p5KDNRREtd1NF4S5ozFgZGqjT9dV+hUARK7AdlUWzJVLP1TO6JrhRovdYEblPPGdM7229L6tstAqDbdcqpj96Y/h6917pTR2C3A=
Received: from DM6PR11CA0067.namprd11.prod.outlook.com (2603:10b6:5:14c::44)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 15:51:28 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::12) by DM6PR11CA0067.outlook.office365.com
 (2603:10b6:5:14c::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 34/35] drm/amd/display: Add DCN35 DM Support
Date: Wed, 23 Aug 2023 11:50:47 -0400
Message-ID: <20230823155048.2526343-34-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c8b0db-a4a4-4696-ebd9-08dba3f0d032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/eU4kg94XpqaLC7ioMA1lnGOeTdKMlCe7V+z7afaRl1/4Y+QlwrXZenzbAh70V0kcLi1MjW8zXRrx5GRyGwHjVFCw/hDjUotKYDH6omKyCH/EA1OCS9OczoJ6K0zMnlz4XP+np8x+dUH9Ibvqxn/K2Xte8FO5r4YjS1O4PSYx2kS4HaIxK8qDFuYE3D+NzJI28Yms+iXKP9ssiuZcVQxlAkSkLP9wtsl8E2RZKaGvM7a6A0/g/qGDV1bOl3TRB+5kIEQMJRT3ZlD19gs5wIWZ6omwvjIkAYXVnLVoEEoN7iCHXcqvwOMowkVIunR8HiFWkMbRKzAYAwELxNZtJmRaGjCIwvsHGhuhojXtgHRMKZYRrCSW6yzGnx3pUnXw9bgmjIerPwKFzIVablT6LccI18IIjVC5N6Rpn8Elor3RhSFeXakRRRFTt/kt4tMjWDXWSw8A8VpoZQLR2763NnL2GXoKitNDNgI/faDvnTUGyheENmSbiYjmxaAjh68w5CKsvWsSvLgjKkAN3Bza2yRKAV0MP9ipkVisSPE4KVWvUn3svM0W5PzG6RDdoE0uxrHGfIrUj8v6RYJosmuapvOvUu/oJontBM+ai8Lg1g0nz+pdNl9qA/VJplW1p57+wM3Q4UZ4prqv8OOxqBJAvtsC0+GtNjkFop1+ACs9MkPSMtEPQARD/ejYat0wHrrC1SIgVDY69BkXq3nwHsD/Rrhxi6Fi00lvpqYd11dI2dRxcyGkNNTR0TX17S7eGUKzyPcCwBkbQ4X/fmd2J93YWbeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(82310400011)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(40480700001)(7696005)(5660300002)(426003)(336012)(16526019)(26005)(86362001)(47076005)(36860700001)(8676002)(8936002)(2616005)(4326008)(70206006)(316002)(70586007)(54906003)(6916009)(478600001)(81166007)(82740400003)(356005)(6666004)(36756003)(40460700003)(41300700001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:28.2596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c8b0db-a4a4-4696-ebd9-08dba3f0d032
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Add DM handling for DCN35.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 +++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  1 +
 3 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 968d8fb74373..1bb1a394f55f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -142,6 +142,9 @@ MODULE_FIRMWARE(FIRMWARE_RAVEN_DMCU);
 #define FIRMWARE_NAVI12_DMCU            "amdgpu/navi12_dmcu.bin"
 MODULE_FIRMWARE(FIRMWARE_NAVI12_DMCU);
 
+#define FIRMWARE_DCN_35_DMUB "amdgpu/dcn_3_5_dmcub.bin"
+MODULE_FIRMWARE(FIRMWARE_DCN_35_DMUB);
+
 /* Number of bytes in PSP header for firmware. */
 #define PSP_HEADER_BYTES 0x100
 
@@ -1173,6 +1176,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	switch (adev->ip_versions[DCE_HWIP][0]) {
 	case IP_VERSION(3, 1, 3):
 	case IP_VERSION(3, 1, 4):
+	case IP_VERSION(3, 5, 0):
 		hw_params.dpia_supported = true;
 		hw_params.disable_dpia = adev->dm.dc->debug.dpia_debug.bits.disable_dpia;
 		break;
@@ -1638,6 +1642,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 4):
 		case IP_VERSION(3, 1, 5):
 		case IP_VERSION(3, 1, 6):
+		case IP_VERSION(3, 5, 0):
 			init_data.flags.gpu_vm_support = true;
 			break;
 		default:
@@ -2021,6 +2026,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 6):
 		case IP_VERSION(3, 2, 0):
 		case IP_VERSION(3, 2, 1):
+		case IP_VERSION(3, 5, 0):
 			return 0;
 		default:
 			break;
@@ -2129,6 +2135,9 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	case IP_VERSION(3, 2, 1):
 		dmub_asic = DMUB_ASIC_DCN321;
 		break;
+	case IP_VERSION(3, 5, 0):
+		dmub_asic = DMUB_ASIC_DCN35;
+		break;
 	default:
 		/* ASIC doesn't support DMUB. */
 		return 0;
@@ -2777,6 +2786,10 @@ static int dm_resume(void *handle)
 	struct dc_state *dc_state;
 	int i, r, j;
 
+	if (dm->dc->caps.ips_support) {
+		dc_dmub_srv_exit_low_power_state(dm->dc);
+	}
+
 	if (amdgpu_in_reset(adev)) {
 		dc_state = dm->cached_dc_state;
 
@@ -4354,6 +4367,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case IP_VERSION(3, 2, 0):
 	case IP_VERSION(3, 2, 1):
 	case IP_VERSION(2, 1, 0):
+	case IP_VERSION(3, 5, 0):
 		if (register_outbox_irq_handlers(dm->adev)) {
 			DRM_ERROR("DM: Failed to initialize IRQ\n");
 			goto fail;
@@ -4374,6 +4388,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 6):
 		case IP_VERSION(3, 2, 0):
 		case IP_VERSION(3, 2, 1):
+		case IP_VERSION(3, 5, 0):
 			psr_feature_enabled = true;
 			break;
 		default:
@@ -4520,6 +4535,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 6):
 		case IP_VERSION(3, 2, 0):
 		case IP_VERSION(3, 2, 1):
+		case IP_VERSION(3, 5, 0):
 			if (dcn10_register_irq_handlers(dm->adev)) {
 				DRM_ERROR("DM: Failed to initialize IRQ\n");
 				goto fail;
@@ -4650,6 +4666,9 @@ static int dm_init_microcode(struct amdgpu_device *adev)
 	case IP_VERSION(3, 2, 1):
 		fw_name_dmub = FIRMWARE_DCN_V3_2_1_DMCUB;
 		break;
+	case IP_VERSION(3, 5, 0):
+		fw_name_dmub = FIRMWARE_DCN_35_DMUB;
+		break;
 	default:
 		/* ASIC doesn't support DMUB. */
 		return 0;
@@ -4774,6 +4793,7 @@ static int dm_early_init(void *handle)
 		case IP_VERSION(3, 1, 6):
 		case IP_VERSION(3, 2, 0):
 		case IP_VERSION(3, 2, 1):
+		case IP_VERSION(3, 5, 0):
 			adev->mode_info.num_crtc = 4;
 			adev->mode_info.num_hpd = 4;
 			adev->mode_info.num_dig = 4;
@@ -8626,6 +8646,17 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 	trace_amdgpu_dm_atomic_commit_tail_begin(state);
 
+	if (dm->dc->caps.ips_support) {
+		for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
+			if (new_con_state->crtc &&
+				new_con_state->crtc->state->active &&
+				drm_atomic_crtc_needs_modeset(new_con_state->crtc->state)) {
+				dc_dmub_srv_exit_low_power_state(dm->dc);
+				break;
+			}
+		}
+	}
+
 	drm_atomic_helper_update_legacy_modeset_state(dev, state);
 	drm_dp_mst_atomic_wait_for_dependencies(state);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 20cfc5be21a4..b54d646a7c73 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -740,6 +740,7 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev,
 		if (dc->ctx->dce_version == DCN_VERSION_3_1 ||
 		    dc->ctx->dce_version == DCN_VERSION_3_14 ||
 		    dc->ctx->dce_version == DCN_VERSION_3_15 ||
+		    dc->ctx->dce_version == DCN_VERSION_3_5 ||
 		    dc->ctx->dce_version == DCN_VERSION_3_16)
 			hdcp_work[i].hdcp.config.psp.caps.dtm_v3_supported = 1;
 		hdcp_work[i].hdcp.config.ddc.handle = dc_get_link_at_index(dc, i);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 8eeca160d434..894bc7e4fdaa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -676,6 +676,7 @@ static int get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_ty
 		break;
 	case AMDGPU_FAMILY_GC_11_0_0:
 	case AMDGPU_FAMILY_GC_11_0_1:
+	case AMDGPU_FAMILY_GC_11_5_0:
 		add_gfx11_modifiers(adev, mods, &size, &capacity);
 		break;
 	}
-- 
2.41.0

