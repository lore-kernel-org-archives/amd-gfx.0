Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92409C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 01:10:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FBE560E78
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 01:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5FBE560E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03A8D6E455;
	Thu, 26 Aug 2021 01:10:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5027E6E455
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 01:10:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6HeJ2/OYki6or4Is33wp/9x5qvKvWATSMRVT7mxOHfbqdNCLY6rxfTIQ+U3FPCUKNsGh0ZO+OMMoq7++8DTy/Iy2LR2AvXJyDisKDYfpQ+quIGaJQIz8CFOZfyaeJzAKJWhZgNFBTKnRrO6AN6pvIbeq4dVQmLKXTiksP6Tgrl6X1Y/uk4sMuDKApGuJ1ewYW2h0ik0GCH81zEbv/P2uScwuQr/3aO/y2Vpnx0uyqO7F/VCOn4WCaHhxU/ZMwYag5V7Ix1jpFMMRUaB8HX2qzzxE1XUWRG5x3U/wn1iVFbHlwWHEsfs6wR3ScEj4X9ml6td1UNCMnsHMwrYIKSyFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHgDi4awqZks/8xpuMZUGyWpBxsLaIKZks1qMhtrv90=;
 b=TAc6OAXGpr681eVyYusKBKsGPQqRSyB843HoREDlwKCdGShPCgkMEqGAzoCwFitKFQ5y58noS7LH60muH5ulWGAbq2yWA3wD9S+9hdvkuxq2Ow5+bComC5sF/DGKrSwGkwiVad34bUVMHF9P1SvZpiQwmBClEzkPtrhWg5vyYYzbA1x0G3wPQtx73Q3NnZ3p9/gbLbXGstZP4YWfZUZmohEq0njdj0lcXu31aQWu/w9ibO59NGOm76wVd/UgvmKmcJW/Q3z2+v1clQmMno4QIBd4NlNkvV34ylbWZb6Bl/61R0O+X3160X5cq+lw21KCDsPoWWU+JTPN4fbt6nEiJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHgDi4awqZks/8xpuMZUGyWpBxsLaIKZks1qMhtrv90=;
 b=gs6pxw39Ab5PA/Z2OkxVUZEaYzYDMfeMkdrahX5ls2hxYk4m5f1cyoAddi6V38MblBcEPiM4y9B16dOYy2eryuXFTLdbInJ6XK8uhCuEGCj7IdlWYIAoezBCayzh+H/TfNHXl9OEx3ebwyNnnXofDaWYBqtjlcc1tfHL2GATBYk=
Received: from DM5PR08CA0040.namprd08.prod.outlook.com (2603:10b6:4:60::29) by
 MWHPR12MB1133.namprd12.prod.outlook.com (2603:10b6:300:d::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Thu, 26 Aug 2021 01:10:10 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::ec) by DM5PR08CA0040.outlook.office365.com
 (2603:10b6:4:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend
 Transport; Thu, 26 Aug 2021 01:10:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Thu, 26 Aug 2021 01:10:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 25 Aug
 2021 20:10:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 25 Aug
 2021 20:10:07 -0500
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 25 Aug 2021 20:10:07 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <nicholas.kazlauskas@amd.com>,
 <alexander.deucher@amd.com>, <aurabindo.pillai@amd.com>, Daniel Wheeler
 <Daniel.Wheeler@amd.com>
Subject: [PATCH 4/4] drm/amd/display: Move
 AllowDRAMSelfRefreshOrDRAMClockChangeInVblank to bounding box
Date: Wed, 25 Aug 2021 21:10:02 -0400
Message-ID: <20210826011002.425361-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826011002.425361-1-aurabindo.pillai@amd.com>
References: <20210826011002.425361-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef0aa02f-b3db-4f09-27ad-08d9682e3fbd
X-MS-TrafficTypeDiagnostic: MWHPR12MB1133:
X-Microsoft-Antispam-PRVS: <MWHPR12MB11331621E34850953C57226D8BC79@MWHPR12MB1133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7nOlJIv4W1vsCzOxWRIwuKUxmPZTxUdNvVWhfIh2HxCjo776BEu0Wkq57sPNwNB1CuJQMBm3vWUINmElbHLcJeTeRDrYxXXrcYvtuPziP8C+B7RqH3WyOWGSIeCwd2boYTKBnfvMOoFaeqgPQ/epJ4W+6rNLd2OwVMJ+rndImjlN3IdXj8jVLs1TxLtSI6l8YJdRGuYw1KPsizcop34IIXVuUyv1QW1Q0c8kJ7fhRVZgjIl90c0kRCfilqJYMYGKG2sCzQEh9/pJ8MEK7TKynhQXxRaeLRXvxr/rBJ/6qLGSY0+6yMqUpmz9C9Jw92vTdGHD88tFUe/iMlibg+1ZIcD/oMB1EFqiU778FwzIEhNxHAi+cmD6xW0bf49H4Pzjc8PY7FGVoXEAENtJMKuiwsWgne1kzuxv6ti1edZSEuyDXy1ZnPT85VEzPqMYPGz5e39qu6wZLcm6tP07smvqklEaQkKqqGJx86LwVR13JJvD3+CMIACMAcgecEKZov3CyBayYc3xBPf4c08onbN+5rBheLHObLhcUwTiNAj0oQWNWNw7Ss6jwJfzagjWyo10spddBfay/+LjqyqOZo52RTv+EKK98u1uFP5+BF+t3MWt8A9IvVhs4oP+mDQo0N+9rkDxH2MPSYZcG/ey+xEkso6vITGGyqhJXqIVF0crhBx944PLMEAwC9TbQlBkLRmdzRoZNkdOAoseRXm1qutliUqck2TTdAMQbz0neCcmj7nDcPoLbQJN2EssIi+9pIOSW3OEqisloEm2biwMH4isFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(6029001)(4636009)(46966006)(36840700001)(54906003)(316002)(508600001)(186003)(1076003)(6916009)(44832011)(36860700001)(2616005)(36756003)(8676002)(2906002)(86362001)(70206006)(47076005)(6666004)(70586007)(5660300002)(83380400001)(336012)(4326008)(426003)(356005)(26005)(8936002)(81166007)(82310400003)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 01:10:09.3843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0aa02f-b3db-4f09-27ad-08d9682e3fbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1133
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
This is a global parameter, not a per pipe parameter and it's useful
for experimenting with the prefetch schedule to be adjustable from
the SOC bb.

[How]
Add a parameter to the SOC bb, default is the existing policy for
all DCN. Fill it in when filling SOC bb parameters.

Revert the policy to use MinDCFClk at the same time since that's not
going to give us P-State in most cases on the spreadsheet.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <Daniel.Wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c      | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c | 7 +++++--
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c      | 4 ++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index d090cb916767..2feffe75ca62 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -92,7 +92,7 @@
 #define DC_LOGGER_INIT(logger)
 
 struct _vcs_dpi_ip_params_st dcn3_0_ip = {
-	.use_min_dcfclk = 1,
+	.use_min_dcfclk = 0,
 	.clamp_min_dcfclk = 0,
 	.odm_capable = 1,
 	.gpuvm_enable = 0,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index e1a961a62add..e3d9f1decdfc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -3644,8 +3644,7 @@ static double TruncToValidBPP(
 void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
 {
 	struct vba_vars_st *v = &mode_lib->vba;
-	int MinPrefetchMode = 0;
-	int MaxPrefetchMode = 2;
+	int MinPrefetchMode, MaxPrefetchMode;
 	int i;
 	unsigned int j, k, m;
 	bool   EnoughWritebackUnits = true;
@@ -3657,6 +3656,10 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 	/*MODE SUPPORT, VOLTAGE STATE AND SOC CONFIGURATION*/
 
+	CalculateMinAndMaxPrefetchMode(
+		mode_lib->vba.AllowDRAMSelfRefreshOrDRAMClockChangeInVblank,
+		&MinPrefetchMode, &MaxPrefetchMode);
+
 	/*Scale Ratio, taps Support Check*/
 
 	v->ScaleRatioAndTapsSupport = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 73f5be26abc4..0fad15020c74 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -244,6 +244,8 @@ static void fetch_socbb_params(struct display_mode_lib *mode_lib)
 	mode_lib->vba.DRAMClockChangeSupportsVActive = !soc->disable_dram_clock_change_vactive_support ||
 			mode_lib->vba.DummyPStateCheck;
 	mode_lib->vba.AllowDramClockChangeOneDisplayVactive = soc->allow_dram_clock_one_display_vactive;
+	mode_lib->vba.AllowDRAMSelfRefreshOrDRAMClockChangeInVblank =
+		soc->allow_dram_self_refresh_or_dram_clock_change_in_vblank;
 
 	mode_lib->vba.Downspreading = soc->downspread_percent;
 	mode_lib->vba.DRAMChannelWidth = soc->dram_channel_width_bytes;   // new!
@@ -733,8 +735,6 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 						mode_lib->vba.OverrideHostVMPageTableLevels;
 	}
 
-	mode_lib->vba.AllowDRAMSelfRefreshOrDRAMClockChangeInVblank = dm_try_to_allow_self_refresh_and_mclk_switch;
-
 	if (mode_lib->vba.OverrideGPUVMPageTableLevels)
 		mode_lib->vba.GPUVMMaxPageTableLevels = mode_lib->vba.OverrideGPUVMPageTableLevels;
 
-- 
2.30.2

