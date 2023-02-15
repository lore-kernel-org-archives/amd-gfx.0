Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE10FC636CC
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 21:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F2B10E0B4;
	Wed, 15 Feb 2023 21:59:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77C7610E0B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 21:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU7FFRXAMkv6ro5gFf56bfuBovLAsfwu6AmVxsvkcHPukIBikItDCwd6ctbBpHBup6JhtsGmBSwCL1n2htKsD0iNmGAjMDCY5j7L9MMXrIaUmUCnmjhh8X6x7sxy/6Xhpq3zf5KQ85ZZE9rRtxtTTZO5S+4+oj1m0l2qtKoyTuiryiaYBjhJQxZsqtWCrbU6XYslZZJc6Bj/g2Q0Y6DUkJhaY+0M3u22V92MFlQa1uoT+GYIwwxA0U2CWnROzL0RQscZ0rj0BNOjJQWT59vLbTIAeSQ3z8TEP7fQjdFhXgYdLxy5Qujy9t0kRXWXt1MOJKOIlFUcKPaWyZq5q8iMCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPmX7vN6Y1SzPg2snGNt2sXwH17Hegs2d1DBIL04Ip8=;
 b=iRonNroO1F3tWb213g8t4Uam8X3olNchvOUfs1peuluY/TlXfEpFcTvlO9w1268wPas0cC0jkD2Uqmb/HrSacnzTbOXx4PXxAFCB6C6kaZL4gM5f65MkEGr+i+X2FnFpBUfisC4lSVPASlV3Yts/Pm/kaQxaHtfWmyta9tB603euCCTUBehmkV5AgrNy/wVuVzRIHlA4eKgET3F6uqXqXr7kf/2s7KZLj55/igCeaiU5QmCxssqZDTlgy6HX3xULaxDXMlENsl+M32RZaPPfHzEcux+KM0380wFr0niwk1GIilEkAhX98Nsc9Oi21dAQwtNmyy0L+6o+Hk+5BAG2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPmX7vN6Y1SzPg2snGNt2sXwH17Hegs2d1DBIL04Ip8=;
 b=Pz62Ck4he5oJOACfPhyAle9J4S2PuhJIuuLfplLNqebaZUhLzPgEixrYqmR8gfM12mhRQ+TAXgW/g+b2YCb86FRzYslKWvcqeNWLEUI4LaaF3ZX57nhAlykFMKho/oZNKPHggWpq8sZBLapkOgbzyVVq2bHy2w0A29aFBGLV17s=
Received: from MW4P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::20)
 by SN7PR12MB6984.namprd12.prod.outlook.com (2603:10b6:806:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 21:59:38 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::30) by MW4P223CA0015.outlook.office365.com
 (2603:10b6:303:80::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Wed, 15 Feb 2023 21:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 21:59:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 15:59:37 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 15:59:36 -0600
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 15 Feb 2023 15:59:36 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: disable SubVP + DRR to prevent underflow
Date: Wed, 15 Feb 2023 16:59:36 -0500
Message-ID: <20230215215936.2009032-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT011:EE_|SN7PR12MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: ab038f2d-58a0-457b-19f8-08db0f9fee99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSKovNJu7/MGaF3jTgqdv84LyiPUfK5IC0+abMCn4+CnTB3qEMutym8Ih5J9p753GjcSuxQMJ25ufq+c41y/BwlKDXBsV85E7528Gp2OfNdCOONkwO8a62Sk4NZ2d2luk2cvJlAY0vHFsa0fsc1vXfeUv9+Ef8OQq9v6lALo7OOsOU1MrIkLH8E8G4VjRU8wSf5TlMWkEjW3/ECa4EEeTMXhmXf70PtX8zyoBkVHerouYgzIYbCskjgNOz+PbehsoDOiHV18SJYmcWHj/9VWK6kOq0ZKA8xEdfSY3KB102NSPsTwtOgGjK0ROoK/7pZNYmgpB5qvZ3W0iv525Q6A6mh8XdGeq2BATQTZIa/haHHBJ8/1AyaGma2aeIWmbdOA+gkpN8/jitPzrIBROeehXwyspPKQCTvVzlP6uGvPWLMr1El3QGpS04HvHT5ElfHP4s6yOrvBY7Olt5xN6Ljt//y/lUy2xr3J1JC7xQeFQYs3VwZqj264/jyTxgaj6PL3HEc3pJ/3SOdxY33+dNw+lmwQWL2qN8s1sUD5J74xyWiQ0DVcjrHOw3MAoknF6FdlO7BuXQWmHbcSNlu8UmTrkGOjbV75gcrd4/qp59WKi/Uxcw2cI5znvqDZeaJKGC+tX0eANe5rCvoBvpuwxnmGD8jeN4xAztUVykK7VWBHIxE0KMk4kPavuMOnBr8txtGoP6Nu1mq6mrVRN/9g9Dte4FdecUSIA/t6JdJAn4F5Tzg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199018)(46966006)(40470700004)(36840700001)(356005)(82310400005)(4326008)(2616005)(40460700003)(36756003)(44832011)(2906002)(41300700001)(8936002)(5660300002)(8676002)(54906003)(6916009)(70206006)(70586007)(40480700001)(316002)(86362001)(26005)(186003)(7696005)(1076003)(81166007)(478600001)(82740400003)(426003)(336012)(36860700001)(83380400001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 21:59:37.8566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab038f2d-58a0-457b-19f8-08db0f9fee99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6984
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com, aurabindo.pillai@amd.com,
 rodrigo.siqueira@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Temporarily disable SubVP+DRR since Xorg has an architectural limitation
where freesync will not work in a multi monitor configuration. SubVP+DRR
requires that freesync be working.

Whether OS has variable refresh setting enabled or not, the state on
the crtc remains same unless an application requests VRR. Due to this,
there is no way to know whether freesync will actually work or not
while we are on the desktop from the kernel's perspective.

If userspace does not have a limitation with multi-display freesync (for
example wayland), then this feature can be enabled by adding a
dcfeaturemask option to amdgpu on the kernel cmdline like:

amdgpu.dcfeaturemask=0x200

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 5 +++++
 drivers/gpu/drm/amd/display/dc/dc.h                  | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 4 ++++
 drivers/gpu/drm/amd/include/amd_shared.h             | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 599ee6417bce..5cb9e2b4ef2b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1604,6 +1604,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_feature_mask & DC_DISABLE_LTTPR_DP2_0)
 		init_data.flags.allow_lttpr_non_transparent_mode.bits.DP2_0 = true;
 
+	/* Disable SubVP + DRR config by default */
+	init_data.flags.disable_subvp_drr = true;
+	if (amdgpu_dc_feature_mask & DC_ENABLE_SUBVP_DRR)
+		init_data.flags.disable_subvp_drr = false;
+
 	init_data.flags.seamless_boot_edp_requested = false;
 
 	if (check_seamless_boot_capability(adev)) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2bf0a467d45f..1fde43378689 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -409,7 +409,7 @@ struct dc_config {
 	bool force_bios_enable_lttpr;
 	uint8_t force_bios_fixed_vs;
 	int sdpif_request_limit_words_per_umc;
-
+	bool disable_subvp_drr;
 };
 
 enum visual_confirm {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 3372ede2dc28..e47828e3b6d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -880,6 +880,10 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context, struc
 	int16_t stretched_drr_us = 0;
 	int16_t drr_stretched_vblank_us = 0;
 	int16_t max_vblank_mallregion = 0;
+	const struct dc_config *config = &dc->config;
+
+	if (config->disable_subvp_drr)
+		return false;
 
 	// Find SubVP pipe
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index f175e65b853a..e4a22c68517d 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -240,6 +240,7 @@ enum DC_FEATURE_MASK {
 	DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
 	DC_PSR_ALLOW_SMU_OPT = (1 << 7), //0x80, disabled by default
 	DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8), //0x100, disabled by default
+	DC_ENABLE_SUBVP_DRR = (1 << 9), // 0x200, disabled by default
 };
 
 enum DC_DEBUG_MASK {
-- 
2.39.2

