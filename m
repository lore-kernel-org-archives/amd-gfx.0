Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A642C19F21
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 10:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B8AA113B41;
	Thu, 28 Jul 2022 10:31:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96D65945FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 10:30:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIWU2EA6SSFEWyBWC5blrLX+8MXD56pZ0z7SF4BJ+opUALfN6gnuiBe0srrOLKjhdy1t56kpjCJ+3raWWuDdPdCyuZs9/TmHuJTwIXwWIVqVob9nqW3jr+d4/JCcC/u1hfFtVz2mfrXN3KsFupS929eCHV6kKeqeVK1pK/QpRCnE3rqcj8qEEA3XpH3YbY1v/hf8iVaaWOiEYenLC5DUy88q9uWuZkz7Bb8+M4HHpX+iI7FUYBn1md2RCXuwbsZKo4jbQi96CezdSty4bBc0fYIbl4RguHlIpo2AiwRrQ0Z4xba/8++KI45YA7bFoDslq+KjQpbzkxUSMa8m0KO1Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2G+PbasTQI3SwEMpH47iJU+hl6SPJf3spBs45RSM+/U=;
 b=Sg52KiefZaXb4mn406EopokpRg3GO5nJfLGO8444NOGKXidCagJmSJqXwJPuR5IxmX/OFUJ/nqFUCu891//ulJA2QiEp+oixUVYSESi2mR2V8P2pCeJqknyOpaO3+ZLRQffW5w2pFEakpsAvytFksZwefabvn2r9XjoqpgqzNZ49tkjkfiCGYtK5RlFXm3r87LxMwtTZiLlJKQ69Udo9wjIEKckyzmLhV0554QP5gWMrLAP4zHS1BLKAtD/EQnSViV0FrOEj6JSZTmMK9Pg3b4tZ02XCBwUboIEmNrjVigxgvyPcKqAE9phwqbHnvjg+Vvu2FBLETQdGkblXlRTmAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G+PbasTQI3SwEMpH47iJU+hl6SPJf3spBs45RSM+/U=;
 b=p7lqmLJMc1dIUV9v7iuCM5x5Ku66EvYWmck30KOrJa2oUWPvjRQqQxfTJLwabU58w+IYhO/EWs6NjWZZrfnNA+vvigTNc7HnOw/yqsWTvG5wKc46yDq5uOOg5bCTmmsun3pmtFEXUUzBJrSDDGo/70ug5hUEXSMzJ84D/FIfR0Q=
Received: from DM6PR02CA0047.namprd02.prod.outlook.com (2603:10b6:5:177::24)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Thu, 28 Jul
 2022 10:30:51 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::48) by DM6PR02CA0047.outlook.office365.com
 (2603:10b6:5:177::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24 via Frontend
 Transport; Thu, 28 Jul 2022 10:30:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Thu, 28 Jul 2022 10:30:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 05:30:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 05:30:45 -0500
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 28 Jul 2022 05:30:43 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 5/6] drm/amdgpu: revert context to stop engine before mode2
 reset
Date: Thu, 28 Jul 2022 18:30:26 +0800
Message-ID: <20220728103027.27255-5-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728103027.27255-1-Victor.Zhao@amd.com>
References: <20220728103027.27255-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d94d2202-ff8d-4c14-eeac-08da70843b57
X-MS-TrafficTypeDiagnostic: PH7PR12MB5654:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vcvyCrduW3DeDkg8pLijoeJ9f5Qj5KeyZ0acfY09XbyDSqIxt9quvXBEAFxagAEEYaYBMmcf6dRDX3sgLvKS8+mXpBtsvrn2Eb7zKZ97jqeU1ZtK6rq2VCDk1sO5s2Sgqb5IX6LP7vhUn1y2wAeadCZMWeaXjKNryEONIVRfeuF/5GXvl3LaA4jX1eB/llLKCBSPJQbtJHwKroHs95E5qBvbFlwIZAYzazDOS1qB8S0SPE5XCuDRA6S3Ftq37qmvLIfKYacmwVPoTyh1K3nbw1AsZzhxEVRHBh0E+g8SRtNig5XR6UDDjQFonaTHzMLUaX5rP4Rb3vRFwnEZKvBR06WVkxnmSFoQ89WC0ityTDuhUpG+yrCrztIWSZ+Gk90qnGkwU5lCk46nBKeNe6ADL0UJpbxS030W5a6GQ9vxLxJV0dZCBdxuvKrcelB2sjba25D+QaxyjC5fi7H2RpOn+2TXgto6He/2oNGphLR+vtyPyvD+PgHXM1y154hHMROMBNCO6CVFlWMbdMwLZ0vSJia7ry7864IDQax4f2wj5YdeETgyixMUHAXR7uJS0gpnp7LwaEOnNpVwLwF13c+bYIE0/oQeHIStnTWox1IcLWpA+dSpmiA2PmGNP5ufxFQrFGtELWku5DYQNgAjT2XvkqZsha53pWSB9FnY7sLcQi5qp5d5m1K/FVTbqDCItRVLGMu9VEc4qTMKbsRFmMmxhHn5pqU0znF0Ptwa5zTbam9tUDn030hKtxGrrJ8npDhFDlepHlmXGl8eGhmHr2zcqcqu0bynZkgJMPUK3Zdl7ELo5C7c+5QmxMBgUIDN/RQ5ecNUc7712EeKfRU1loekOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(396003)(376002)(346002)(40470700004)(36840700001)(46966006)(5660300002)(6916009)(40460700003)(54906003)(2906002)(26005)(4326008)(82310400005)(478600001)(316002)(41300700001)(6666004)(40480700001)(70586007)(8676002)(426003)(336012)(356005)(7696005)(83380400001)(70206006)(82740400003)(86362001)(81166007)(2616005)(186003)(8936002)(36756003)(36860700001)(1076003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 10:30:45.9021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d94d2202-ff8d-4c14-eeac-08da70843b57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654
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

For some hang caused by slow tests, engine cannot be stopped which
may cause resume failure after reset. In this case, force halt
engine by reverting context addresses

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 36 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c |  2 ++
 4 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f03750b64f61..debbba842fce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5038,6 +5038,7 @@ static void amdgpu_device_recheck_guilty_jobs(
 
 			/* set guilty */
 			drm_sched_increase_karma(s_job);
+			amdgpu_reset_prepare_hwcontext(adev, reset_context);
 retry:
 			/* do hw reset */
 			if (amdgpu_sriov_vf(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
index f8036f2b100e..c7b44aeb671b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
@@ -37,6 +37,7 @@ struct amdgpu_gfxhub_funcs {
 	void (*utcl2_harvest)(struct amdgpu_device *adev);
 	void (*mode2_save_regs)(struct amdgpu_device *adev);
 	void (*mode2_restore_regs)(struct amdgpu_device *adev);
+	void (*halt)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_gfxhub {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 51cf8acd2d79..8cf53e039c11 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -646,6 +646,41 @@ static void gfxhub_v2_1_restore_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, adev->gmc.MC_VM_MX_L1_TLB_CNTL);
 }
 
+static void gfxhub_v2_1_halt(struct amdgpu_device *adev)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
+	int i;
+	uint32_t tmp;
+	int time = 1000;
+
+	gfxhub_v2_1_set_fault_enable_default(adev, false);
+
+	for (i = 0; i <= 14; i++) {
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
+				    i * hub->ctx_addr_distance, ~0);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
+				    i * hub->ctx_addr_distance, ~0);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
+				    i * hub->ctx_addr_distance,
+				    0);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
+				    i * hub->ctx_addr_distance,
+				    0);
+	}
+	tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS2);
+	while ((tmp & (GRBM_STATUS2__EA_BUSY_MASK |
+		      GRBM_STATUS2__EA_LINK_BUSY_MASK)) != 0 &&
+	       time) {
+		udelay(100);
+		time--;
+		tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS2);
+	}
+
+	if (!time) {
+		DRM_WARN("failed to wait for GRBM(EA) idle\n");
+	}
+}
+
 const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs = {
 	.get_fb_location = gfxhub_v2_1_get_fb_location,
 	.get_mc_fb_offset = gfxhub_v2_1_get_mc_fb_offset,
@@ -658,4 +693,5 @@ const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs = {
 	.utcl2_harvest = gfxhub_v2_1_utcl2_harvest,
 	.mode2_save_regs = gfxhub_v2_1_save_regs,
 	.mode2_restore_regs = gfxhub_v2_1_restore_regs,
+	.halt = gfxhub_v2_1_halt,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index 51a5b68f77d3..fead7251292f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -97,6 +97,8 @@ sienna_cichlid_mode2_prepare_hwcontext(struct amdgpu_reset_control *reset_ctl,
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->gfxhub.funcs->mode2_save_regs)
 			adev->gfxhub.funcs->mode2_save_regs(adev);
+		if (adev->gfxhub.funcs->halt)
+			adev->gfxhub.funcs->halt(adev);
 		r = sienna_cichlid_mode2_suspend_ip(adev);
 	}
 
-- 
2.25.1

