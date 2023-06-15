Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD26EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 20:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96A7F10E546;
	Thu, 15 Jun 2023 20:40:03 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DF4810E547
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 20:40:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtPIC0I67cgCYYH4Sjt+zCbuCF5PNbrAVSUaa1gI1HtxnF26ZZfOYCKmocaaNMH4rR7nx5Lz60ieJdYVvC+OTJW2mt+X2vrQTjH4UAEc6of7NTYDBjO9BsBgWAzc6srt67TEU8ef7du2IP0Qp3prSyCyvezkh3n6k+TTbxCdM3aKMW7kqaCyzqxTbH+ORvxgHfxAPsJgUcG4n9i7jqGIb/KMeXv3E+kw2mIKPnMIxsUhCNf/aqa43gyXWtHDx5XQhHwfmlSPjox9YCYJv5E5D6pN7RxlZn/GAwMdx1YK/+1Jv5gmsGs4E9Trv3PHiLFsUoRfhuVmLh1jCWDJLG1eNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7uxLKPlQdkQTDrW5jJEGPjkZkWeLenT9GKc1Uc7ws4=;
 b=f08UG5w7qitAILnsSRVv0afKGVcSkwWyM4JM8yi1WKIbJAqQjFlH/Z/rwjVVaAMzvX1ZeRes58/woYtVqCa+4WA3lv7HVS15Glz6K04V5sfxfuNMtnP2Bmy2ygIWcfi8+1NPaVLg4mzIGk0pe4/hZBg20Iwgcl8m6hSZeoUt7dWhp4tmL9i0yh0d6zbxzTEvDGhM7jxcIAPskKbQ16EeOs9lcru1k5XHnIKa5vLm8xMsfLrMIvP9FJRgP820v4cxpcfW53xzW+OqGfwmBNpiBWahullOUoPjAqFtw8hKw44D1i0TYt7XIjf9sW4sNRCW0FA82ij46MUGsC/YOZJQZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7uxLKPlQdkQTDrW5jJEGPjkZkWeLenT9GKc1Uc7ws4=;
 b=liYD1vR2XUNoxls0JpxYYkyTVg6DVNuxwsOfTYbExsaEdu/lwNqxeDLFR3SvFwpqE08hTKNSHjQ84EJLoM4o3wgw880Gs1oqGtoYfUETlVxgHGVIRC+XQeMa44OuNWLAxP4lRR6z8zhbbc8NbTiQ7FuWqcr1UAP68PsC53oEO74=
Received: from BY5PR17CA0067.namprd17.prod.outlook.com (2603:10b6:a03:167::44)
 by PH8PR12MB8606.namprd12.prod.outlook.com (2603:10b6:510:1ce::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 20:39:56 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:167:cafe::44) by BY5PR17CA0067.outlook.office365.com
 (2603:10b6:a03:167::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Thu, 15 Jun 2023 20:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.29 via Frontend Transport; Thu, 15 Jun 2023 20:39:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 15:39:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 15:39:53 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 15 Jun 2023 15:39:53 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 5/6] drm/amd/display: Enable Replay for static screen use cases
Date: Thu, 15 Jun 2023 16:39:29 -0400
Message-ID: <20230615203930.1715722-6-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT015:EE_|PH8PR12MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3db599-11a2-4d73-8dfc-08db6de0adb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8+2VRzKprVWIx5aNOYP36ck2WspFivZ6hwOncYDutlsZXBI+culakwRAFNo+v4i05Dj//FL19vAgAe3+rjTSXZhNrw5f0/uUBzuSLjQym/uuWk2LCZeDuOHWR+Ah8WmWC8c3im5lIC0qb3pLCcn1AAA+fgwlszqlJOgcxds8cBq4aGRLKk2VSn9/Jdx3QqpxZAZOLLN4pSPV380+weAucJHRNPZ3iwngHAyI9o/hmMDWf405PlbQag7ooK7/ucALdx+Olrp8TvsA0+ODHOEb2DZBji6m+RkUMyJnTuiMLWKcqFj9GICyNonjzuLEvvWWGNuE4SrAdvO4LBvslvtj5gYr5fAY6iEj3WWDKi3dHVvLelzgEAFzHoJ+4DvzeggbK5NPCammThx3qe4v+EGTV0okAb5il6hARJv/DKWgxU6oW9PPEkTcGaf9svjvWsf4n6cv64U1DoU2tDJb8Qo3xtU1FBHn5GeyWVl1POvadlLphdp+bcTw51y9IjsMysZxs1pJl84ZpfHCZHibZe7E9PRha0cyk2AA5avDzLvjGKD5Me6WZKtIAgbO3pLXcnR5XwLpn/nhthHIOnQI78nuswU3Dxcvlw+8pPWM9hp4NL9fRzgn/MINrs4kZbdB+hG+41r7ahFaF1TuNp5ow0FIUBEigU0L7dRxxtwRhPMto+N+L/DUCD+ngmtcPuLSo50kJTppio3FcXIeJ2MjbTPKJrxOIvfOvfn4iRj3qeTTsX8rpv3PEkhDpDBTlXrnBkIpHdkHc4GzbUnX+itThliECA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(110136005)(82740400003)(81166007)(478600001)(356005)(316002)(8676002)(41300700001)(8936002)(6636002)(70206006)(2616005)(4326008)(70586007)(336012)(426003)(83380400001)(36860700001)(186003)(6666004)(47076005)(7696005)(26005)(5660300002)(1076003)(82310400005)(86362001)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 20:39:55.6931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3db599-11a2-4d73-8dfc-08db6de0adb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8606
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Setup replay config on device init.
- Enable replay if feature is enabled and psr is not going to be enabled
- Add debug masks to enable replay on supported ASICs

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  4 ++++
 drivers/gpu/drm/amd/include/amd_shared.h      |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2446529c329a..a6551c049cc1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -65,6 +65,7 @@
 #include "amdgpu_dm_debugfs.h"
 #endif
 #include "amdgpu_dm_psr.h"
+#include "amdgpu_dm_replay.h"
 
 #include "ivsrcid/ivsrcid_vislands30.h"
 
@@ -4315,6 +4316,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	const struct dc_plane_cap *plane;
 	bool psr_feature_enabled = false;
+	bool replay_feature_enabled = false;
 	int max_overlay = dm->dc->caps.max_slave_planes;
 
 	dm->display_indexes_num = dm->dc->caps.max_streams;
@@ -4424,6 +4426,20 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		}
 	}
 
+	if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
+		switch (adev->ip_versions[DCE_HWIP][0]) {
+		case IP_VERSION(3, 1, 4):
+		case IP_VERSION(3, 1, 5):
+		case IP_VERSION(3, 1, 6):
+		case IP_VERSION(3, 2, 0):
+		case IP_VERSION(3, 2, 1):
+			replay_feature_enabled = true;
+			break;
+		default:
+			replay_feature_enabled = amdgpu_dc_feature_mask & DC_REPLAY_MASK;
+			break;
+		}
+	}
 	/* loops over all connectors on the board */
 	for (i = 0; i < link_cnt; i++) {
 		struct dc_link *link = NULL;
@@ -4480,6 +4496,9 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 				 */
 				if (link->psr_settings.psr_feature_enabled)
 					adev_to_drm(adev)->vblank_disable_immediate = false;
+
+				if (replay_feature_enabled)
+					amdgpu_dm_setup_replay(link, aconnector);
 			}
 		}
 		amdgpu_set_panel_orientation(&aconnector->base);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 440fc0869a34..44323cef5dfd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -29,6 +29,7 @@
 #include "dc.h"
 #include "amdgpu.h"
 #include "amdgpu_dm_psr.h"
+#include "amdgpu_dm_replay.h"
 #include "amdgpu_dm_crtc.h"
 #include "amdgpu_dm_plane.h"
 #include "amdgpu_dm_trace.h"
@@ -132,8 +133,11 @@ static void vblank_control_worker(struct work_struct *work)
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 			   !amdgpu_dm_crc_window_is_activated(&vblank_work->acrtc->base) &&
 #endif
+			   vblank_work->stream->link->panel_config.psr.disallow_replay &&
 			   vblank_work->acrtc->dm_irq_params.allow_psr_entry) {
 			amdgpu_dm_psr_enable(vblank_work->stream);
+		} else if (vblank_work->stream->link->replay_settings.replay_feature_enabled) {
+			amdgpu_dm_replay_enable(vblank_work->stream, false);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index f175e65b853a..c6d4cca646c2 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -240,6 +240,7 @@ enum DC_FEATURE_MASK {
 	DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
 	DC_PSR_ALLOW_SMU_OPT = (1 << 7), //0x80, disabled by default
 	DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8), //0x100, disabled by default
+	DC_REPLAY_MASK = (1 << 9), //0x200, disabled by default for dcn < 3.1.4
 };
 
 enum DC_DEBUG_MASK {
@@ -250,6 +251,7 @@ enum DC_DEBUG_MASK {
 	DC_DISABLE_PSR = 0x10,
 	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
 	DC_DISABLE_MPO = 0x40,
+	DC_DISABLE_REPLAY = 0x50,
 };
 
 enum amd_dpm_forced_level;
-- 
2.25.1

