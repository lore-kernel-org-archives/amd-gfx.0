Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D1FC5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 21:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08CEB10E3B3;
	Wed, 28 Feb 2024 21:17:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nXIfznWy";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D27D910E3B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 21:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMcPNOwJ3QPZJ90U0kRPyCqxOzKyLUMjnr4ini74aYG9n47GG7WJlWw7V4TDqB4ekQHDymUA1ZVztCO7LAQ81S3qwy75l7fwsCUbn7c7Yxr1m00Ap/vpvTDmr6by+vmFY8btth5kIE47HPLy2t5aNr4nucTMrZgIHFFsXIcLZxhqGS4mrcjW+iBkEJ5MSeZFP5TdLEGlwieQ4YMztW6CtgQSHihi/+iMczDnu7iF0uSimkgr7TRYyg3kgxZqYOLwdjl1q2YPjMmgm7YULo+8ktoQEB0D+LQ/rquUffPUy15/ut2cPKbIH9b8xpkwfjrtxEKYnhI8A470D5OGhRIs9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIgnYEj0YlKdBwiLETFcXRH7R9pMTx9pVdl+fPoTRT8=;
 b=iI5NboOCLFHLH4iz/2nu0HWoyU8kbS0kqAn0eyMbMYtYglILuhtGcGO7kXsBsyW19Jh+DTxHL9/xVd7xXcS6VN0PGS4DB0RGUNDPf8nIPyEw5U98o/EDTx4/1g7x/5R1l77kYI15N3uqWGqqAF/od2EcmlHm/m8KikAW/zCzOz4wfUbhfhWbVsmNO+1masfQvS5SOKd23JxiPnKif318k9ZB2gz5RvdJdbDevdB/RfT8BbYylqwOYWnIeC2k+OBXcDoSld3/RlGBtf7ykHYh7gMO2sbte2ZSXMkUWH4tpr/No9g/PMDEVmsGG3Y2rhSfNAO2Ud8llA51VgUfLUsu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIgnYEj0YlKdBwiLETFcXRH7R9pMTx9pVdl+fPoTRT8=;
 b=nXIfznWyzB51CFHKH1mNX1XXbNfZWuiUIsnODQ1opf38jwiTNAJAOmg+vYCrk5F9aBirGzKo3svAY/t+RX+EhHWK12skFMOa5JFj9j7RNOESIphfA3khBJTM0odyhAFJZEnIqlhl3zIIKibaO915nvwv/DEf7BC/xByPM067cB0=
Received: from BN0PR04CA0008.namprd04.prod.outlook.com (2603:10b6:408:ee::13)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 21:17:09 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::71) by BN0PR04CA0008.outlook.office365.com
 (2603:10b6:408:ee::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Wed, 28 Feb 2024 21:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 21:17:09 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 15:17:03 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 6/6] drm/amd/display: add amdgpu_dm support for DCN351
Date: Wed, 28 Feb 2024 16:16:37 -0500
Message-ID: <20240228211638.36109-6-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228211638.36109-1-hamza.mahfooz@amd.com>
References: <20240228211638.36109-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|SA3PR12MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c300c12-4138-460a-3769-08dc38a29fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HF7OkD+ZR3RQFlvN6/T/whynEUZtA7W8AqGFEohOWx9w50OCfkf+76ArS74xrhs8Os52hZfKJX2FNXhw5utTik+hvk5aSzwE71gnb9jgvmbcaXEMYnTy8lCWJqjNJTYrtsY+iWkTT5oXwu3LSzWZWa6jbJLMVAbcKVPsXlsQbmx6Hb7s5ZcJ6bkYjZYCH3brV+L99GwW6rmDD1iTdSRkRLjGC1vQwj9DA6EIskFM1T+Gf8vw1Dp5n/q9tLAgscxu6rwz8Tq0nwGmD4bkqNpQv3wFDxc8EdZnPkHYjQFofl+ldC5t6rIH6Pe0aYMvFI6pPS292DNBytbewKVZogc6J50668FR/24OuNaLcTCg2/TCwUwJpeZ3MI+VnoSCgP/PfDtZDaw9wNKtCwymoTiTs0IXE8b2sXvu9cKakJasdrg3stWUbyyFBrtE6hih0NlPeuQeVn/66mbS0qe2hI+LnIWnqgD/omTkyz3Lybsy/hFpcIJpbo2QdgDEBfl/q9jou0Fbl4QNPHg9ETW9AXgP4S16fCTTR3X2gOT6o1OYOCJ6hy16GSp9E8KoSOFkSpAwmO5LZHGV0+S2WVy8R9ODpS/40FAXhGt76o33OduBzk5NWsA65QzXSfnD2778RtSAbwMo/de4iHOEGiOPtjtLp93lKv10VRrUKlN2fI0GlIV3k9SZ1JAYr/6HkBd4YhAANHUJ+wTTa9PpUAOCPLX05M3opekmRyqkl/ZDF0ImWqI8BJUIaAyDyz6sIxcft4YU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 21:17:09.3299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c300c12-4138-460a-3769-08dc38a29fa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157
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

Add Display Manager specific changes for DCN3.5.1.

Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      | 9 +++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5bbe7d1a53fb..bd8cd3a1325e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1219,6 +1219,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	case IP_VERSION(3, 1, 3):
 	case IP_VERSION(3, 1, 4):
 	case IP_VERSION(3, 5, 0):
+	case IP_VERSION(3, 5, 1):
 		hw_params.dpia_supported = true;
 		hw_params.disable_dpia = adev->dm.dc->debug.dpia_debug.bits.disable_dpia;
 		break;
@@ -2040,6 +2041,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 		case IP_VERSION(3, 2, 0):
 		case IP_VERSION(3, 2, 1):
 		case IP_VERSION(3, 5, 0):
+		case IP_VERSION(3, 5, 1):
 			return 0;
 		default:
 			break;
@@ -2160,6 +2162,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		dmub_asic = DMUB_ASIC_DCN321;
 		break;
 	case IP_VERSION(3, 5, 0):
+	case IP_VERSION(3, 5, 1):
 		dmub_asic = DMUB_ASIC_DCN35;
 		break;
 	default:
@@ -4489,6 +4492,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case IP_VERSION(3, 2, 1):
 	case IP_VERSION(2, 1, 0):
 	case IP_VERSION(3, 5, 0):
+	case IP_VERSION(3, 5, 1):
 		if (register_outbox_irq_handlers(dm->adev)) {
 			DRM_ERROR("DM: Failed to initialize IRQ\n");
 			goto fail;
@@ -4510,6 +4514,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 2, 0):
 		case IP_VERSION(3, 2, 1):
 		case IP_VERSION(3, 5, 0):
+		case IP_VERSION(3, 5, 1):
 			psr_feature_enabled = true;
 			break;
 		default:
@@ -4527,6 +4532,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 2, 0):
 		case IP_VERSION(3, 2, 1):
 		case IP_VERSION(3, 5, 0):
+		case IP_VERSION(3, 5, 1):
 			replay_feature_enabled = true;
 			break;
 		default:
@@ -4679,6 +4685,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 2, 0):
 		case IP_VERSION(3, 2, 1):
 		case IP_VERSION(3, 5, 0):
+		case IP_VERSION(3, 5, 1):
 			if (dcn10_register_irq_handlers(dm->adev)) {
 				DRM_ERROR("DM: Failed to initialize IRQ\n");
 				goto fail;
@@ -4810,6 +4817,7 @@ static int dm_init_microcode(struct amdgpu_device *adev)
 		fw_name_dmub = FIRMWARE_DCN_V3_2_1_DMCUB;
 		break;
 	case IP_VERSION(3, 5, 0):
+	case IP_VERSION(3, 5, 1):
 		fw_name_dmub = FIRMWARE_DCN_35_DMUB;
 		break;
 	default:
@@ -4935,6 +4943,7 @@ static int dm_early_init(void *handle)
 		case IP_VERSION(3, 2, 0):
 		case IP_VERSION(3, 2, 1):
 		case IP_VERSION(3, 5, 0):
+		case IP_VERSION(3, 5, 1):
 			adev->mode_info.num_crtc = 4;
 			adev->mode_info.num_hpd = 4;
 			adev->mode_info.num_dig = 4;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index b54d646a7c73..e339c7a8d541 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -741,6 +741,7 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev,
 		    dc->ctx->dce_version == DCN_VERSION_3_14 ||
 		    dc->ctx->dce_version == DCN_VERSION_3_15 ||
 		    dc->ctx->dce_version == DCN_VERSION_3_5 ||
+		    dc->ctx->dce_version == DCN_VERSION_3_51 ||
 		    dc->ctx->dce_version == DCN_VERSION_3_16)
 			hdcp_work[i].hdcp.config.psp.caps.dtm_v3_supported = 1;
 		hdcp_work[i].hdcp.config.ddc.handle = dc_get_link_at_index(dc, i);
-- 
2.43.0

