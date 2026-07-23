Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5445AC531CC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4DF110F1D4;
	Thu, 23 Jul 2026 20:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MNQX6oL8";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDFBF10E5EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJDoYVYaS+F4F7EKRzjsD/RtkkEDVbexSkk/sxNSKCTpY0cFputvd/RtokqJ0AtHlRAqGEAkDqqSfB9bn0sptLM9cT4/JBKDFJdDXIrDU+7b2Mnhj0KQAOrj1MZd/sBb0synaKTIEU5Zrp8d+xP/hTxJhx7HS+7rbD8eVR+/mzp20OI0wFXZavdh59rcp/ckoh5v8CGTVNN09E7aiHzLi8KC1G15hP9YR/US8xLKTAfcvbxZP8SUWYdVtGh9khocWxLWsvyBq4P9p4cCuZSBmx1xAsEQuPtTvr6h9WJziUcTJ7rWv4J7OXWehP7XF52rLoqtma4dT+josvD3N7Cm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxvKIQibB9U8HTgIqgSwcMbxy8nIvgX7OLGrKW5FUrA=;
 b=FfJciss8ecM5RKdGHedoeXGNYs9Fi4u/XisJoRF0WT5C2wBN0cGTDoauQa+FFf9G5kjAuHNbs2gfWJETtS/sVgaH6fCCeJo6WOT1KLeQWAPtdaEQV5sH5V9vMNEdOzGAaUdjGkW3qilnJTW/csMz5bwx8Uoho0pyzB/6b4zbCkLJq/LulzDmDy93TNrs/aqS/FvYWXDSIW1eJcRM52q5pd2t2jtprTtvXIdQEe0ltja3Orax455ZQU3idGM36SnAGeUFDhIJjtQMrYu7atDpINGzTmaqdGE7YhgguKGJuxXpATAd1f0DeLoswp8oxJrU5p8KI4fW4To8ECla7gqAzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxvKIQibB9U8HTgIqgSwcMbxy8nIvgX7OLGrKW5FUrA=;
 b=MNQX6oL8k03JPrl1WqI4atL801IJOpbng/lZTlZWvYhS5L8SOk/rpI1WXCvk96rJmatiaT6+N9NqycWYwBxyMsZln2z/a4V2/ReERblvhnbIIqOlGR8f3qAwiE7imBWgNLTbYd4KsEsFyzOsS7NrM12TEaCMVVZ3+Nh53qKxLfI=
Received: from MN0P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::19)
 by PH7PR12MB6564.namprd12.prod.outlook.com (2603:10b6:510:210::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:03 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::4) by MN0P223CA0001.outlook.office365.com
 (2603:10b6:208:52b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:03 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:18:58 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 14/49] drm/amd/display: move watermarks table to pp_smu
Date: Thu, 23 Jul 2026 16:13:22 -0400
Message-ID: <20260723201908.373300-15-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|PH7PR12MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: aeff6a77-0bb6-4c32-0e10-08dee8f7a3c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: C5feZd3+lSprYO8J4jNH76jwmaj09qIDgRlSBpU5xe+TYW1ToSM+DwkGb9dwR128BP0sLSKSeY8a2XHMv+sAuMmhA6D93DdTq5JRhNxe+5571nw1aIci9J1yEmTytmNQZtIuP2DONlXeeUKrwtWg8sN8MSGn5FnH16YUzaYGtTgNCcJ8EruUoJMpGRNW45mYTmUwpALFTVGBzFAooXrKneQfVG0o8mG4ohBOd1vHNqBPI5nwg8v6Xp2nvONizvqMYibSLpPSqlfegozYsKWfCs03JzIijxmhPCqXC1l7SdKKs00HVFFp4qNhfId2fJHED8jjKOWyj4GqvUGOgjDj+7gFtY9KX0UhtLIYilb6YggIBIwvWAtAB9U1KOmUKdyESacRhkDY5/KYVdH1E7QuFQ5boRSsP/Q+G5D24dDONYhJKucIzFIkPJnKe4FZn8W+mrimZrwSJLvoPZEps6sxNAHmaCgku356/OMkL4W4w8js3tbCk3QHjHy5NCEzcr5s4JbntD2sq3IWMR+LL6Qvc5l8hxgXrHvKZcS+JY7JC+zlQ0u8jh0+LHd/gao0KRqw2d2bdVykDFvf2IF9wHroEP4jJViaqvD47wEUbl0WJ5RLuNrztSA8Kbjufb+Nxfb5ATzEqVOurYt2dpS6/MA+yib/Rq3yT2r3JxuJkgy5+bSHUIsmNHkFtV+UbdXjExZlAU07+IUj6KqiYUjAdo/zGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GGJUn1G7bpuQy0CGgFG8lprKXBvPkNJpcAZOsP2mV9J693E/na2C3pNyPdkeShXLPaGV7fSNigAUk9tREREgtlmiVw1Ae8zzj582QCAlvtkwr6+s67WvorzHtEp2XcViqVN03ir1z19wvRdge+eaJrvwcdUHZXgLf/tmu0qY4eAJDTcca5N0VX1UU1bgu7SnBDjB249LtBtm97GaLW4J9uYEcByVKLR8qrIFZ35xYZr9Tr5X6DR7vTQa6mqTTNaeEjzuXjV5fo7ahxpb8crR3g+G83aD0tlNFola9bFMtkUyrOiXql6GNjuXQzr5W2aq2vzhMwMjv75t5FkVaXf115wbpX3beUlg0gSVGu9gXbvIn1yk+F8uEl9sY2fnncCxSUsPlQqgk6qou222GA2QMmfyFzH5SSNJZJtWPsBp47HZVL7WuQnN7bHtRgNM+efn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:03.4794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeff6a77-0bb6-4c32-0e10-08dee8f7a3c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6564
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
amdgpu_dm_smu_write_watermarks_table() pushes fixed dcn watermark
clock settings to the SMU on Navi1x. It belongs with the other
dc-pplib bridge code, so move it out of amdgpu_dm.c into
amdgpu_dm_pp_smu.c.

It is called from dm_resume(), so it becomes a plain exported function
declared in amdgpu_dm_pp_smu.h (now included by amdgpu_dm.c) instead of
STATIC_IFN_KUNIT in amdgpu_dm.h. Relocate its KUnit test from the
amdgpu_dm suite to the amdgpu_dm_pp_smu suite. No functional change.

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 53 +------------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 -
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  | 52 ++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h  |  3 ++
 .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c   | 20 +++++++
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 16 ------
 6 files changed, 76 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c6b9cd1ce489..d49f0cd3b113 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -70,6 +70,7 @@
 #include "amdgpu_dm_audio.h"
 #include "amdgpu_dm_dmub.h"
 #include "amdgpu_dm_connector.h"
+#include "amdgpu_dm_pp_smu.h"
 
 #include "ivsrcid/ivsrcid_vislands30.h"
 
@@ -1372,58 +1373,6 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 	drm_connector_list_iter_end(&iter);
 }
 
-STATIC_IFN_KUNIT int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
-{
-	int ret = 0;
-
-	/* This interface is for dGPU Navi1x.Linux dc-pplib interface depends
-	 * on window driver dc implementation.
-	 * For Navi1x, clock settings of dcn watermarks are fixed. the settings
-	 * should be passed to smu during boot up and resume from s3.
-	 * boot up: dc calculate dcn watermark clock settings within dc_create,
-	 * dcn20_resource_construct
-	 * then call pplib functions below to pass the settings to smu:
-	 * smu_set_watermarks_for_clock_ranges
-	 * smu_set_watermarks_table
-	 * navi10_set_watermarks_table
-	 * smu_write_watermarks_table
-	 *
-	 * For Renoir, clock settings of dcn watermark are also fixed values.
-	 * dc has implemented different flow for window driver:
-	 * dc_hardware_init / dc_set_power_state
-	 * dcn10_init_hw
-	 * notify_wm_ranges
-	 * set_wm_ranges
-	 * -- Linux
-	 * smu_set_watermarks_for_clock_ranges
-	 * renoir_set_watermarks_table
-	 * smu_write_watermarks_table
-	 *
-	 * For Linux,
-	 * dc_hardware_init -> amdgpu_dm_init
-	 * dc_set_power_state --> dm_resume
-	 *
-	 * therefore, this function apply to navi10/12/14 but not Renoir
-	 * *
-	 */
-	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
-	case IP_VERSION(2, 0, 2):
-	case IP_VERSION(2, 0, 0):
-		break;
-	default:
-		return 0;
-	}
-
-	ret = amdgpu_dpm_write_watermarks_table(adev);
-	if (ret) {
-		drm_err(adev_to_drm(adev), "Failed to update WMTABLE!\n");
-		return ret;
-	}
-
-	return 0;
-}
-EXPORT_IF_KUNIT(amdgpu_dm_smu_write_watermarks_table);
-
 static int dm_oem_i2c_hw_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_display_manager *dm = &adev->dm;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 617328497203..70220997cde9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1157,7 +1157,6 @@ int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 struct dm_atomic_state *dm_atomic_get_new_state(struct drm_atomic_commit *state);
 void dm_atomic_destroy_state(struct drm_private_obj *obj,
 			     struct drm_private_state *state);
-int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev);
 bool dm_should_update_native_cursor(struct drm_atomic_commit *state,
 				    struct drm_crtc *old_plane_crtc,
 				    struct drm_crtc *new_plane_crtc,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 8431e164a0db..3280bfadc6a8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -792,3 +792,55 @@ void dm_pp_get_funcs(
 	}
 }
 EXPORT_IF_KUNIT(dm_pp_get_funcs);
+
+int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
+{
+	int ret = 0;
+
+	/* This interface is for dGPU Navi1x.Linux dc-pplib interface depends
+	 * on window driver dc implementation.
+	 * For Navi1x, clock settings of dcn watermarks are fixed. the settings
+	 * should be passed to smu during boot up and resume from s3.
+	 * boot up: dc calculate dcn watermark clock settings within dc_create,
+	 * dcn20_resource_construct
+	 * then call pplib functions below to pass the settings to smu:
+	 * smu_set_watermarks_for_clock_ranges
+	 * smu_set_watermarks_table
+	 * navi10_set_watermarks_table
+	 * smu_write_watermarks_table
+	 *
+	 * For Renoir, clock settings of dcn watermark are also fixed values.
+	 * dc has implemented different flow for window driver:
+	 * dc_hardware_init / dc_set_power_state
+	 * dcn10_init_hw
+	 * notify_wm_ranges
+	 * set_wm_ranges
+	 * -- Linux
+	 * smu_set_watermarks_for_clock_ranges
+	 * renoir_set_watermarks_table
+	 * smu_write_watermarks_table
+	 *
+	 * For Linux,
+	 * dc_hardware_init -> amdgpu_dm_init
+	 * dc_set_power_state --> dm_resume
+	 *
+	 * therefore, this function apply to navi10/12/14 but not Renoir
+	 * *
+	 */
+	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
+	case IP_VERSION(2, 0, 2):
+	case IP_VERSION(2, 0, 0):
+		break;
+	default:
+		return 0;
+	}
+
+	ret = amdgpu_dpm_write_watermarks_table(adev);
+	if (ret) {
+		drm_err(adev_to_drm(adev), "Failed to update WMTABLE!\n");
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_smu_write_watermarks_table);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h
index f918eb71f0d1..1d153d0e2f03 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h
@@ -11,6 +11,9 @@
 struct amd_pp_display_configuration;
 struct pp_smu_wm_range_sets;
 struct dm_pp_wm_sets_with_clock_ranges_soc15;
+struct amdgpu_device;
+
+int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 void build_pm_display_cfg(struct amd_pp_display_configuration *pm_display_cfg,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c
index 8d1d26bfcc16..fbd07af60230 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c
@@ -16,6 +16,7 @@
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_pp_smu.h"
+#include "amdgpu_dm_kunit_test_helpers.h"
 
 /* ---- Stub DPM layer ---- */
 
@@ -2321,6 +2322,23 @@ static void dm_test_nv_get_uclk_dpm_states_fail(struct kunit *test)
 			(int)PP_SMU_RESULT_FAIL);
 }
 
+/* Tests for amdgpu_dm_smu_write_watermarks_table() */
+
+/**
+ * dm_test_smu_write_watermarks_table_default - Test watermarks table skips non-Navi1x IP versions
+ * @test: The KUnit test context
+ */
+static void dm_test_smu_write_watermarks_table_default(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	/*
+	 * A zeroed adev reports DCE IP version 0, which is not one of the
+	 * Navi1x versions handled by the switch, so the function returns early.
+	 */
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_smu_write_watermarks_table(adev), 0);
+}
+
 static struct kunit_case dm_pp_smu_test_cases[] = {
 	/* get_default_clock_levels */
 	KUNIT_CASE(dm_test_default_clock_levels_display),
@@ -2440,6 +2458,8 @@ static struct kunit_case dm_pp_smu_test_cases[] = {
 	KUNIT_CASE(dm_test_nv_get_uclk_dpm_states_ok),
 	KUNIT_CASE(dm_test_nv_get_uclk_dpm_states_unsupported),
 	KUNIT_CASE(dm_test_nv_get_uclk_dpm_states_fail),
+	/* amdgpu_dm_smu_write_watermarks_table */
+	KUNIT_CASE(dm_test_smu_write_watermarks_table_default),
 	{}
 };
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 72d5a4012a3c..49a1d2ae5588 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -316,21 +316,6 @@ static void dm_test_atomic_destroy_state_no_context(struct kunit *test)
 	dm_atomic_destroy_state(NULL, &dm_state->base);
 }
 
-/**
- * dm_test_smu_write_watermarks_table_default - Test watermarks table skips non-Navi1x IP versions
- * @test: The KUnit test context
- */
-static void dm_test_smu_write_watermarks_table_default(struct kunit *test)
-{
-	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
-
-	/*
-	 * A zeroed adev reports DCE IP version 0, which is not one of the
-	 * Navi1x versions handled by the switch, so the function returns early.
-	 */
-	KUNIT_EXPECT_EQ(test, amdgpu_dm_smu_write_watermarks_table(adev), 0);
-}
-
 /* Tests for dm_plane_layer_index_cmp() */
 
 /**
@@ -1801,7 +1786,6 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_should_update_native_cursor_disable_native),
 	KUNIT_CASE(dm_test_should_update_native_cursor_enable_overlay),
 	KUNIT_CASE(dm_test_atomic_destroy_state_no_context),
-	KUNIT_CASE(dm_test_smu_write_watermarks_table_default),
 	/* dm_plane_layer_index_cmp */
 	KUNIT_CASE(dm_test_plane_layer_index_cmp_equal),
 	KUNIT_CASE(dm_test_plane_layer_index_cmp_descending),
-- 
2.53.0

