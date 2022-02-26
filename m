Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57DAC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Feb 2022 15:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4156810E29B;
	Sat, 26 Feb 2022 15:41:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00A4B10E29B
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Feb 2022 15:41:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHwq5KTxp9XRZx5V4v/Fz9bodZSCYE7UT8prl8DbliFachixbyyaB982uZqccAu5ZFN4sNYBLaGYzGEdY6bBNfMr5U9SNGfJ72kAoBtAvtvva8T3plxn4gikH6ks3MdaxI2eNPA1Ilya6v2DHq2+dB7Nxq3xGn7Tci43ZPQAj9+O+H7kyTwOxVJY9hTTqghtc30UhvnGRIpD604kIwyLHO2xcJIOXdoPurx2HtvbainmgaLif1msNauCQyrZf9haXIQSGV0Y5QEwtYplhN1ceg+oe9gSMHtpHje/M52iEpd7+c0FmOMh/mwGukK+FQb0bPRqD9nDYHwYlC2aofzJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGULr15Rf/fFP+UYWOGwMbyp82k98T2sjrLEAO6pIlM=;
 b=andeweyE0gWvynnXXKfzdGSPiir8d4/JHQxDz7vZrLy2Wl62N0xC9UyqR6NqpqZfNNX962R6d27to0BdBF+CqZPZ6k2tdHLeaqSopURZOCndYFzyF4tdJhKT0gTKhGq7s5TKv20AP7PY1hkDIdWU8kFuACZSDW/lZoFkEoo2K4FNWDeaAxiUl/5wvQIXCZhqwP+gM4LUoy8G2G/iIIH9oxaoSokFxvcOCs0YxYddMJ6fI2umxOfF8dtcGTwFAYMJecIZQX6XtcM8xjb/EnAtiFCZEAqEco3NQL/q386SkNey7OA4TjZfjxLXcVKivJnCA36yIJ07eA2EbXeWZ5C25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGULr15Rf/fFP+UYWOGwMbyp82k98T2sjrLEAO6pIlM=;
 b=vn46wJ/mANO2L5CsPneeeAxtB/wMwpmbb8uxOrf99nv0WAkzkoL4nCVfHb7mvOZGSTGlZyuwhFbz0axjEY23BxrgTQS0cB1e3BLms0vPQnppiDP0fcOCf4gvRyzfp4PjbsCyZ6Rxjc6opAZMqJp/0pkov/YRKlN265ZJoeMLyLQ=
Received: from BN6PR19CA0069.namprd19.prod.outlook.com (2603:10b6:404:e3::31)
 by CY4PR12MB1575.namprd12.prod.outlook.com (2603:10b6:910:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Sat, 26 Feb
 2022 15:41:47 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::d7) by BN6PR19CA0069.outlook.office365.com
 (2603:10b6:404:e3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26 via Frontend
 Transport; Sat, 26 Feb 2022 15:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Sat, 26 Feb 2022 15:41:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 09:41:45 -0600
Received: from alan-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sat, 26 Feb 2022 09:41:42 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/14] drm/amd/display: Add frame alternate 3D & restrict HW
 packed on dongles
Date: Sun, 27 Feb 2022 07:41:07 +0800
Message-ID: <20220226234117.3328151-5-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
References: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcea34c1-fb65-4dc4-f7eb-08d9f93e7f1e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1575:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB157573464C755A3011168BE6F53F9@CY4PR12MB1575.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZKUvjuuU+CkM7tY49miee0Nwg1HP8HCexnJneLXoFAq/ccc7bY+IG69YItUzIMuFGLt1+UKg425cp3bnHcaYsbHa96X2piQgckVupByZWzFAUeKrp56MIuSdhjmCCN34vtmBIdue4FstbM73vGpK0pzNJDxbiHqPoyESYshJP38mMrDdRcwEQb0fTr5hP3wEbGpExNjA/f5S4KuPQTK/3BYnUBhCt/Lw1dFAawRqh+5+dYBXukDEdQsTVXIithNcZMkeX1QqUzRaxKso2hW+sulOVGTP9jMbIdQUjc+6upkipBE0+Ltd+DJuSPGH+hu902ocrJuw58aQdyXEfe1HBIo4kR9ySXPdXJHJ5TyI/UCLDSHyTui1EZmzn7ta4Soal7zf/D3Oo2sn/1HLtPo8KdJlcKovcV/tPTnsvfr1QkyfGsE+KzIxXuvZlgL7MxmbCR+ZKYi7YqIdIb7dXTjUJre79STplfQ1t/nJXMmmq3zDq92Vz40ocrxKf6kpJ7C2MR0T9hLtAZINJhRORzUDT5TiuWh1krZdHh6rn63HzP95hGlT6HVhWOngrZZIOmylhnRubUBXdmDAy5xMvK8BE9sGxEj8Zar6Aj008bFkE2aOF6vZIa3f0/IiLXqTKZE7gGUTWkrMuQQy3E79d5bhBwKhCHBfjog0h3BAnV+BRC7dVlZv4gJwLYno6QEbzyjOWZSn0I5CaosLhl3TyMbnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(47076005)(5660300002)(36756003)(8936002)(316002)(4326008)(356005)(70206006)(83380400001)(70586007)(6916009)(8676002)(54906003)(508600001)(2616005)(82310400004)(6666004)(7696005)(336012)(26005)(186003)(81166007)(426003)(86362001)(1076003)(40460700003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2022 15:41:46.4879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcea34c1-fb65-4dc4-f7eb-08d9f93e7f1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1575
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

[WHY?]
Some projectors support frame alternate 3D modes at 120Hz, but DAL3 does
not create timings. Most active DP to HDMI dongles do not translate
infoframes properly to use HW packing stereo mode.

[HOW?]
Create frame alternate 3D timings for displays that support it. Disable HW
packing 3D mode on DP active dongles.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c         | 11 +++++++++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c |  3 ++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c     | 11 -----------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 27f3fc416448..045d33375133 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2801,6 +2801,17 @@ static bool dp_active_dongle_validate_timing(
 			return false;
 		}
 
+		/* Check 3D format */
+		switch (timing->timing_3d_format) {
+		case TIMING_3D_FORMAT_NONE:
+		case TIMING_3D_FORMAT_FRAME_ALTERNATE:
+			/*Only frame alternate 3D is supported on active dongle*/
+			break;
+		default:
+			/*other 3D formats are not supported due to bad infoframe translation */
+			return false;
+		}
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 		if (dongle_caps->dp_hdmi_frl_max_link_bw_in_kbps > 0) { // DP to HDMI FRL converter
 			struct dc_crtc_timing outputTiming = *timing;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 559aa45f27e7..b467c0376027 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3093,7 +3093,8 @@ static void dcn10_config_stereo_parameters(
 
 		flags->PROGRAM_STEREO         = 1;
 		flags->PROGRAM_POLARITY       = 1;
-		if (timing_3d_format == TIMING_3D_FORMAT_INBAND_FA ||
+		if (timing_3d_format == TIMING_3D_FORMAT_FRAME_ALTERNATE ||
+			timing_3d_format == TIMING_3D_FORMAT_INBAND_FA ||
 			timing_3d_format == TIMING_3D_FORMAT_DP_HDMI_INBAND_FA ||
 			timing_3d_format == TIMING_3D_FORMAT_SIDEBAND_FA) {
 			enum display_dongle_type dongle = \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index dc1752e9f461..33d74ecd893d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -707,17 +707,6 @@ bool hubp2_program_surface_flip_and_addr(
 	REG_UPDATE(VMID_SETTINGS_0,
 			VMID, address->vmid);
 
-	if (address->type == PLN_ADDR_TYPE_GRPH_STEREO) {
-		REG_UPDATE(DCSURF_FLIP_CONTROL, SURFACE_FLIP_MODE_FOR_STEREOSYNC, 0x1);
-		REG_UPDATE(DCSURF_FLIP_CONTROL, SURFACE_FLIP_IN_STEREOSYNC, 0x1);
-
-	} else {
-		// turn off stereo if not in stereo
-		REG_UPDATE(DCSURF_FLIP_CONTROL, SURFACE_FLIP_MODE_FOR_STEREOSYNC, 0x0);
-		REG_UPDATE(DCSURF_FLIP_CONTROL, SURFACE_FLIP_IN_STEREOSYNC, 0x0);
-	}
-
-
 
 	/* HW automatically latch rest of address register on write to
 	 * DCSURF_PRIMARY_SURFACE_ADDRESS if SURFACE_UPDATE_LOCK is not used
-- 
2.25.1

