Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C612C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 03:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE10F10ED10;
	Mon, 13 Dec 2021 03:53:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E879010ED0E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 03:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcuWmx9H5ouwYRccJesCTCNwjhCdE5oWs/3gt0ByO8Ln+R2EYEZXQCEoelIV4QK3PqbG9BgawTSeEUHC5tMU4TuzKUQ42S0B7sw/XajjHgbngY57b6bxwzQ5329k0jXw1Lyupu0wlNDUonqptYheZu7kJbO08rJJlF7jDHhfVWHtyxJ9r0kZRb+RR8s0rpLjVpLpb/GWmBGOfLpUkeBtmcSuJm/rCw+F4T7GSeHkWLHxUgTHfn1KJBCra5F1NA6Q77ych3pOtCSgaa5akyY1Y6t+dzHL/OIWWghrshIwZNdItfphEWxWfDY8Byy/aBdy9upCuLxf5S2jIaypfy5B3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNcHMtdMCt3usfPecbiVYlJa42Rrsknn09LdK6yoL5E=;
 b=Rrsrag4bz9MeWxnWkK5FNIujd087y798DAaRCxASGd+sAWa7d1bxLHW0Ip5EbTKvhNtbCgIjlBzs84eYoIDnTyRPIPJXtaBpK/r0fkiifRp3N24LrU8dvD0IvZCgZimW8XRNrC+KmwyW/V1ZUnize5pir/c3pf5cjRsPcLvNszuYNz9N0Wr6i90xJp4qTEqRF+QKpBcLItlUKchRND6sdg0gyZi6FYAz2g/T5XwPrO6/uK3ZMXWI/zBTJ+6DKr7kvaqKhOEfW8vAMgYX7Jfkrt+h2gDW7ChwNxO4OpMQ6XZEjV8Sp9alIhlM/bl5h67CabjVu1Gz9gwSsr8/GBx2YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNcHMtdMCt3usfPecbiVYlJa42Rrsknn09LdK6yoL5E=;
 b=UagVd75ilAle998BNlZEA/HnT+eet9i3FuIAbMzz/EwCyR8HUxljan51WDQyjSdSgVvnI+qNpfcGkpdvBHpvzLE0Fgowncxk8sTjqH59do5ii7/6mozxHMTIfLd8Tf4YE88M0myzngUbAehJmNuVLOSpFPi0dsQ0HRxtjBc5hck=
Received: from DS7PR03CA0221.namprd03.prod.outlook.com (2603:10b6:5:3ba::16)
 by DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 03:52:58 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::39) by DS7PR03CA0221.outlook.office365.com
 (2603:10b6:5:3ba::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Mon, 13 Dec 2021 03:52:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 03:52:57 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 12 Dec
 2021 21:52:56 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V5 09/16] drm/amd/pm: optimize the amdgpu_pm_compute_clocks()
 implementations
Date: Mon, 13 Dec 2021 11:52:16 +0800
Message-ID: <20211213035223.772700-10-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211213035223.772700-1-evan.quan@amd.com>
References: <20211213035223.772700-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff0c66a7-8347-4da3-e28e-08d9bdec0d2d
X-MS-TrafficTypeDiagnostic: DM8PR12MB5429:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB542981C009F0EEE1655A27A9E4749@DM8PR12MB5429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yI3pHFk90pxmaEPY61wLS+TrXOMSPCx5SECC2twv/9Ui/Ek7KVjoJ9iDQ5bhPIg8og2CEGsu+tXKLpGlmPFevGrihyBdkycb5HlXrR18Zq5jdssngYoNcLQHBQUY+KJZuwh9I4wy+NRYG8pKGBmJ2+uS0vuTadqWsdVNu1cK5g6c6eQ07rksNxkAqrI8kKk/yQVSo253HG+ywgWWJIaIsXG88ufizvPuksEToXv5gHttEEGHBiH3ukg1npI0EZBQGL3NBftKkFh4qmjixvqczESWD1bb0FDWJs5B5349rVUMvvl0fQqZ7SYXDNnHv45yy3RYpP3vQg9DnpqK2qfYuX0y+/BtyPx0KtP23izLoaSohtyGa79amFJZfvxoMYDB8eXeADuJrP8ihOEoA4RhP808yVkdN6uEybsMyodT7gVhz5H5Il3y1W6AVZ2EaVcQvZBc4/RBAQIGvbyXTFoA4yG83ScelQwdoEtvm/XvvIU7Y2lJ1/F6xdfv65/fzMxR+7S9/qgt0wQYgum/oe9tAO5RuXuGifVqgMjQ2eZJNp3hgGFq1XevqEiFgvW4h6c1/oQX62y6X+PYcV+oWmCaxVAo0FjXMw89QUyk2+GX61/aXCHqxSsYuhMCCCvKGvQ4xZ5i/NM7qxLZ4NJ97HxUnCGxyJKAKilOdv2OphTHxj27qz/Byg8xXh+aM+xlSfGK5+nklelwM7duPbZotbXFhqjHX7TL6jRHWmFXqpExXUVzOhq6DtdpgPWqLbntL4zBlzC4e2C7Lz3oU0DcsDelqtclOTGaCTpjqCyfUyk4k4lETrJlFBhBALjLir1entdy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(356005)(40460700001)(83380400001)(44832011)(36756003)(6916009)(7696005)(82310400004)(36860700001)(81166007)(8676002)(1076003)(316002)(54906003)(86362001)(508600001)(2906002)(8936002)(186003)(26005)(70586007)(70206006)(4326008)(6666004)(426003)(2616005)(47076005)(336012)(16526019)(30864003)(5660300002)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 03:52:57.9740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0c66a7-8347-4da3-e28e-08d9bdec0d2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Drop cross callings and multi-function APIs. Also avoid exposing
internal implementations details.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I55e5ab3da6a70482f5f5d8c256eed2f754feae20
--
v1->v2:
  - add back the adev->pm.dpm_enabled check(Lijo)
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   2 +-
 drivers/gpu/drm/amd/pm/Makefile               |   2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 202 ++----------------
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  |  94 ++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   2 -
 .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |  32 +++
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  39 +++-
 drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c     |   6 +-
 drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c |  60 +++++-
 drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h |   3 +-
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c     |  41 +++-
 11 files changed, 289 insertions(+), 194 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
 create mode 100644 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index cdf724dcf832..7919e96e772b 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -404,7 +404,7 @@ struct amd_pm_funcs {
 	int (*get_dpm_clock_table)(void *handle,
 				   struct dpm_clocks *clock_table);
 	int (*get_smu_prv_buf_details)(void *handle, void **addr, size_t *size);
-	int (*change_power_state)(void *handle);
+	void (*pm_compute_clocks)(void *handle);
 };
 
 struct metrics_table_header {
diff --git a/drivers/gpu/drm/amd/pm/Makefile b/drivers/gpu/drm/amd/pm/Makefile
index 8cf6eff1ea93..d35ffde387f1 100644
--- a/drivers/gpu/drm/amd/pm/Makefile
+++ b/drivers/gpu/drm/amd/pm/Makefile
@@ -40,7 +40,7 @@ AMD_PM = $(addsuffix /Makefile,$(addprefix $(FULL_AMD_PATH)/pm/,$(PM_LIBS)))
 
 include $(AMD_PM)
 
-PM_MGR = amdgpu_dpm.o amdgpu_pm.o
+PM_MGR = amdgpu_dpm.o amdgpu_pm.o amdgpu_dpm_internal.o
 
 AMD_PM_POWER = $(addprefix $(AMD_PM_PATH)/,$(PM_MGR))
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index be3a509889ad..f62c253e35d3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -37,73 +37,6 @@
 #define amdgpu_dpm_enable_bapm(adev, e) \
 		((adev)->powerplay.pp_funcs->enable_bapm((adev)->powerplay.pp_handle, (e)))
 
-static void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
-{
-	struct drm_device *ddev = adev_to_drm(adev);
-	struct drm_crtc *crtc;
-	struct amdgpu_crtc *amdgpu_crtc;
-
-	adev->pm.dpm.new_active_crtcs = 0;
-	adev->pm.dpm.new_active_crtc_count = 0;
-	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
-		list_for_each_entry(crtc,
-				    &ddev->mode_config.crtc_list, head) {
-			amdgpu_crtc = to_amdgpu_crtc(crtc);
-			if (amdgpu_crtc->enabled) {
-				adev->pm.dpm.new_active_crtcs |= (1 << amdgpu_crtc->crtc_id);
-				adev->pm.dpm.new_active_crtc_count++;
-			}
-		}
-	}
-}
-
-u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev)
-{
-	struct drm_device *dev = adev_to_drm(adev);
-	struct drm_crtc *crtc;
-	struct amdgpu_crtc *amdgpu_crtc;
-	u32 vblank_in_pixels;
-	u32 vblank_time_us = 0xffffffff; /* if the displays are off, vblank time is max */
-
-	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
-		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
-			amdgpu_crtc = to_amdgpu_crtc(crtc);
-			if (crtc->enabled && amdgpu_crtc->enabled && amdgpu_crtc->hw_mode.clock) {
-				vblank_in_pixels =
-					amdgpu_crtc->hw_mode.crtc_htotal *
-					(amdgpu_crtc->hw_mode.crtc_vblank_end -
-					amdgpu_crtc->hw_mode.crtc_vdisplay +
-					(amdgpu_crtc->v_border * 2));
-
-				vblank_time_us = vblank_in_pixels * 1000 / amdgpu_crtc->hw_mode.clock;
-				break;
-			}
-		}
-	}
-
-	return vblank_time_us;
-}
-
-static u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
-{
-	struct drm_device *dev = adev_to_drm(adev);
-	struct drm_crtc *crtc;
-	struct amdgpu_crtc *amdgpu_crtc;
-	u32 vrefresh = 0;
-
-	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
-		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
-			amdgpu_crtc = to_amdgpu_crtc(crtc);
-			if (crtc->enabled && amdgpu_crtc->enabled && amdgpu_crtc->hw_mode.clock) {
-				vrefresh = drm_mode_vrefresh(&amdgpu_crtc->hw_mode);
-				break;
-			}
-		}
-	}
-
-	return vrefresh;
-}
-
 int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
@@ -432,115 +365,38 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
 	return ret;
 }
 
-void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
-{
-	struct amdgpu_device *adev =
-		container_of(work, struct amdgpu_device,
-			     pm.dpm.thermal.work);
-	/* switch to the thermal state */
-	enum amd_pm_state_type dpm_state = POWER_STATE_TYPE_INTERNAL_THERMAL;
-	int temp, size = sizeof(temp);
-
-	if (!adev->pm.dpm_enabled)
-		return;
-
-	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_TEMP,
-				    (void *)&temp, &size)) {
-		if (temp < adev->pm.dpm.thermal.min_temp)
-			/* switch back the user state */
-			dpm_state = adev->pm.dpm.user_state;
-	} else {
-		if (adev->pm.dpm.thermal.high_to_low)
-			/* switch back the user state */
-			dpm_state = adev->pm.dpm.user_state;
-	}
-	mutex_lock(&adev->pm.mutex);
-	if (dpm_state == POWER_STATE_TYPE_INTERNAL_THERMAL)
-		adev->pm.dpm.thermal_active = true;
-	else
-		adev->pm.dpm.thermal_active = false;
-	adev->pm.dpm.state = dpm_state;
-	mutex_unlock(&adev->pm.mutex);
-
-	amdgpu_dpm_compute_clocks(adev);
-}
-
 void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
 {
-	int i = 0;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
 	if (!adev->pm.dpm_enabled)
 		return;
 
-	if (adev->mode_info.num_crtc)
-		amdgpu_display_bandwidth_update(adev);
-
-	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
-		struct amdgpu_ring *ring = adev->rings[i];
-		if (ring && ring->sched.ready)
-			amdgpu_fence_wait_empty(ring);
-	}
+	if (!pp_funcs->pm_compute_clocks)
+		return;
 
-	if ((adev->family == AMDGPU_FAMILY_SI) ||
-	     (adev->family == AMDGPU_FAMILY_KV)) {
-		mutex_lock(&adev->pm.mutex);
-		amdgpu_dpm_get_active_displays(adev);
-		adev->powerplay.pp_funcs->change_power_state(adev->powerplay.pp_handle);
-		mutex_unlock(&adev->pm.mutex);
-	} else {
-		if (!amdgpu_device_has_dc_support(adev)) {
-			mutex_lock(&adev->pm.mutex);
-			amdgpu_dpm_get_active_displays(adev);
-			adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
-			adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
-			adev->pm.pm_display_cfg.min_vblank_time = amdgpu_dpm_get_vblank_time(adev);
-			/* we have issues with mclk switching with
-			 * refresh rates over 120 hz on the non-DC code.
-			 */
-			if (adev->pm.pm_display_cfg.vrefresh > 120)
-				adev->pm.pm_display_cfg.min_vblank_time = 0;
-			if (adev->powerplay.pp_funcs->display_configuration_change)
-				adev->powerplay.pp_funcs->display_configuration_change(
-							adev->powerplay.pp_handle,
-							&adev->pm.pm_display_cfg);
-			mutex_unlock(&adev->pm.mutex);
-		}
-		amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_DISPLAY_CONFIG_CHANGE, NULL);
-	}
+	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
 }
 
 void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
 {
 	int ret = 0;
 
-	if (adev->family == AMDGPU_FAMILY_SI) {
-		mutex_lock(&adev->pm.mutex);
-		if (enable) {
-			adev->pm.dpm.uvd_active = true;
-			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
-		} else {
-			adev->pm.dpm.uvd_active = false;
-		}
-		mutex_unlock(&adev->pm.mutex);
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
+	if (ret)
+		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
+			  enable ? "enable" : "disable", ret);
 
-		amdgpu_dpm_compute_clocks(adev);
-	} else {
-		ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
-		if (ret)
-			DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
-				  enable ? "enable" : "disable", ret);
-
-		/* enable/disable Low Memory PState for UVD (4k videos) */
-		if (adev->asic_type == CHIP_STONEY &&
-			adev->uvd.decode_image_width >= WIDTH_4K) {
-			struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
-
-			if (hwmgr && hwmgr->hwmgr_func &&
-			    hwmgr->hwmgr_func->update_nbdpm_pstate)
-				hwmgr->hwmgr_func->update_nbdpm_pstate(hwmgr,
-								       !enable,
-								       true);
-		}
+	/* enable/disable Low Memory PState for UVD (4k videos) */
+	if (adev->asic_type == CHIP_STONEY &&
+		adev->uvd.decode_image_width >= WIDTH_4K) {
+		struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
+
+		if (hwmgr && hwmgr->hwmgr_func &&
+		    hwmgr->hwmgr_func->update_nbdpm_pstate)
+			hwmgr->hwmgr_func->update_nbdpm_pstate(hwmgr,
+							       !enable,
+							       true);
 	}
 }
 
@@ -548,24 +404,10 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
 {
 	int ret = 0;
 
-	if (adev->family == AMDGPU_FAMILY_SI) {
-		mutex_lock(&adev->pm.mutex);
-		if (enable) {
-			adev->pm.dpm.vce_active = true;
-			/* XXX select vce level based on ring/task */
-			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
-		} else {
-			adev->pm.dpm.vce_active = false;
-		}
-		mutex_unlock(&adev->pm.mutex);
-
-		amdgpu_dpm_compute_clocks(adev);
-	} else {
-		ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
-		if (ret)
-			DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
-				  enable ? "enable" : "disable", ret);
-	}
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
+	if (ret)
+		DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
+			  enable ? "enable" : "disable", ret);
 }
 
 void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable)
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
new file mode 100644
index 000000000000..ba5f6413412d
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
@@ -0,0 +1,94 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include "amdgpu.h"
+#include "amdgpu_display.h"
+#include "hwmgr.h"
+#include "amdgpu_smu.h"
+
+void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
+{
+	struct drm_device *ddev = adev_to_drm(adev);
+	struct drm_crtc *crtc;
+	struct amdgpu_crtc *amdgpu_crtc;
+
+	adev->pm.dpm.new_active_crtcs = 0;
+	adev->pm.dpm.new_active_crtc_count = 0;
+	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
+		list_for_each_entry(crtc,
+				    &ddev->mode_config.crtc_list, head) {
+			amdgpu_crtc = to_amdgpu_crtc(crtc);
+			if (amdgpu_crtc->enabled) {
+				adev->pm.dpm.new_active_crtcs |= (1 << amdgpu_crtc->crtc_id);
+				adev->pm.dpm.new_active_crtc_count++;
+			}
+		}
+	}
+}
+
+u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev)
+{
+	struct drm_device *dev = adev_to_drm(adev);
+	struct drm_crtc *crtc;
+	struct amdgpu_crtc *amdgpu_crtc;
+	u32 vblank_in_pixels;
+	u32 vblank_time_us = 0xffffffff; /* if the displays are off, vblank time is max */
+
+	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
+		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
+			amdgpu_crtc = to_amdgpu_crtc(crtc);
+			if (crtc->enabled && amdgpu_crtc->enabled && amdgpu_crtc->hw_mode.clock) {
+				vblank_in_pixels =
+					amdgpu_crtc->hw_mode.crtc_htotal *
+					(amdgpu_crtc->hw_mode.crtc_vblank_end -
+					amdgpu_crtc->hw_mode.crtc_vdisplay +
+					(amdgpu_crtc->v_border * 2));
+
+				vblank_time_us = vblank_in_pixels * 1000 / amdgpu_crtc->hw_mode.clock;
+				break;
+			}
+		}
+	}
+
+	return vblank_time_us;
+}
+
+u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
+{
+	struct drm_device *dev = adev_to_drm(adev);
+	struct drm_crtc *crtc;
+	struct amdgpu_crtc *amdgpu_crtc;
+	u32 vrefresh = 0;
+
+	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
+		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
+			amdgpu_crtc = to_amdgpu_crtc(crtc);
+			if (crtc->enabled && amdgpu_crtc->enabled && amdgpu_crtc->hw_mode.clock) {
+				vrefresh = drm_mode_vrefresh(&amdgpu_crtc->hw_mode);
+				break;
+			}
+		}
+	}
+
+	return vrefresh;
+}
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index b7841a989d59..b0791e855ad3 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -420,8 +420,6 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
 			   void *data, uint32_t *size);
 
-void amdgpu_dpm_thermal_work_handler(struct work_struct *work);
-
 void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev);
 void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
new file mode 100644
index 000000000000..5c2a89f0d5d5
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#ifndef __AMDGPU_DPM_INTERNAL_H__
+#define __AMDGPU_DPM_INTERNAL_H__
+
+void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev);
+
+u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev);
+
+u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev);
+
+#endif
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 20cb234d5061..d57d5c28c013 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -31,7 +31,8 @@
 #include "power_state.h"
 #include "amdgpu.h"
 #include "hwmgr.h"
-
+#include "amdgpu_dpm_internal.h"
+#include "amdgpu_display.h"
 
 static const struct amd_pm_funcs pp_dpm_funcs;
 
@@ -1678,6 +1679,41 @@ static int pp_get_prv_buffer_details(void *handle, void **addr, size_t *size)
 	return 0;
 }
 
+static void pp_pm_compute_clocks(void *handle)
+{
+	struct pp_hwmgr *hwmgr = handle;
+	struct amdgpu_device *adev = hwmgr->adev;
+	int i = 0;
+
+	if (adev->mode_info.num_crtc)
+		amdgpu_display_bandwidth_update(adev);
+
+	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
+		struct amdgpu_ring *ring = adev->rings[i];
+		if (ring && ring->sched.ready)
+			amdgpu_fence_wait_empty(ring);
+	}
+
+	if (!amdgpu_device_has_dc_support(adev)) {
+		amdgpu_dpm_get_active_displays(adev);
+		adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
+		adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
+		adev->pm.pm_display_cfg.min_vblank_time = amdgpu_dpm_get_vblank_time(adev);
+		/* we have issues with mclk switching with
+		 * refresh rates over 120 hz on the non-DC code.
+		 */
+		if (adev->pm.pm_display_cfg.vrefresh > 120)
+			adev->pm.pm_display_cfg.min_vblank_time = 0;
+
+		pp_display_configuration_change(handle,
+						&adev->pm.pm_display_cfg);
+	}
+
+	pp_dpm_dispatch_tasks(handle,
+			      AMD_PP_TASK_DISPLAY_CONFIG_CHANGE,
+			      NULL);
+}
+
 static const struct amd_pm_funcs pp_dpm_funcs = {
 	.load_firmware = pp_dpm_load_fw,
 	.wait_for_fw_loading_complete = pp_dpm_fw_loading_complete,
@@ -1742,4 +1778,5 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
 	.get_gpu_metrics = pp_get_gpu_metrics,
 	.gfx_state_change_set = pp_gfx_state_change_set,
 	.get_smu_prv_buf_details = pp_get_prv_buffer_details,
+	.pm_compute_clocks = pp_pm_compute_clocks,
 };
diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
index eed89835231c..72824ef61edd 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
@@ -3088,7 +3088,7 @@ static int kv_dpm_hw_init(void *handle)
 	else
 		adev->pm.dpm_enabled = true;
 	mutex_unlock(&adev->pm.mutex);
-	amdgpu_dpm_compute_clocks(adev);
+	amdgpu_legacy_dpm_compute_clocks(adev);
 	return ret;
 }
 
@@ -3136,7 +3136,7 @@ static int kv_dpm_resume(void *handle)
 			adev->pm.dpm_enabled = true;
 		mutex_unlock(&adev->pm.mutex);
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_compute_clocks(adev);
+			amdgpu_legacy_dpm_compute_clocks(adev);
 	}
 	return 0;
 }
@@ -3390,7 +3390,7 @@ static const struct amd_pm_funcs kv_dpm_funcs = {
 	.get_vce_clock_state = amdgpu_get_vce_clock_state,
 	.check_state_equal = kv_check_state_equal,
 	.read_sensor = &kv_dpm_read_sensor,
-	.change_power_state = amdgpu_dpm_change_power_state_locked,
+	.pm_compute_clocks = amdgpu_legacy_dpm_compute_clocks,
 };
 
 static const struct amdgpu_irq_src_funcs kv_dpm_irq_funcs = {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c
index 67c84b7ad8e7..3c6ee493e410 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c
@@ -26,6 +26,8 @@
 #include "atom.h"
 #include "amd_pcie.h"
 #include "legacy_dpm.h"
+#include "amdgpu_dpm_internal.h"
+#include "amdgpu_display.h"
 
 #define amdgpu_dpm_pre_set_power_state(adev) \
 		((adev)->powerplay.pp_funcs->pre_set_power_state((adev)->powerplay.pp_handle))
@@ -949,9 +951,8 @@ static struct amdgpu_ps *amdgpu_dpm_pick_power_state(struct amdgpu_device *adev,
 	return NULL;
 }
 
-int amdgpu_dpm_change_power_state_locked(void *handle)
+static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ps *ps;
 	enum amd_pm_state_type dpm_state;
 	int ret;
@@ -1022,3 +1023,58 @@ int amdgpu_dpm_change_power_state_locked(void *handle)
 
 	return 0;
 }
+
+void amdgpu_legacy_dpm_compute_clocks(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i = 0;
+
+	if (adev->mode_info.num_crtc)
+		amdgpu_display_bandwidth_update(adev);
+
+	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
+		struct amdgpu_ring *ring = adev->rings[i];
+		if (ring && ring->sched.ready)
+			amdgpu_fence_wait_empty(ring);
+	}
+
+	amdgpu_dpm_get_active_displays(adev);
+
+	amdgpu_dpm_change_power_state_locked(adev);
+}
+
+void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
+{
+	struct amdgpu_device *adev =
+		container_of(work, struct amdgpu_device,
+			     pm.dpm.thermal.work);
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	/* switch to the thermal state */
+	enum amd_pm_state_type dpm_state = POWER_STATE_TYPE_INTERNAL_THERMAL;
+	int temp, size = sizeof(temp);
+
+	if (!adev->pm.dpm_enabled)
+		return;
+
+	if (!pp_funcs->read_sensor(adev->powerplay.pp_handle,
+				   AMDGPU_PP_SENSOR_GPU_TEMP,
+				   (void *)&temp,
+				   &size)) {
+		if (temp < adev->pm.dpm.thermal.min_temp)
+			/* switch back the user state */
+			dpm_state = adev->pm.dpm.user_state;
+	} else {
+		if (adev->pm.dpm.thermal.high_to_low)
+			/* switch back the user state */
+			dpm_state = adev->pm.dpm.user_state;
+	}
+
+	if (dpm_state == POWER_STATE_TYPE_INTERNAL_THERMAL)
+		adev->pm.dpm.thermal_active = true;
+	else
+		adev->pm.dpm.thermal_active = false;
+
+	adev->pm.dpm.state = dpm_state;
+
+	amdgpu_legacy_dpm_compute_clocks(adev->powerplay.pp_handle);
+}
diff --git a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h b/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h
index 7ac30f1aed20..93bd3973330c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h
@@ -32,6 +32,7 @@ int amdgpu_parse_extended_power_table(struct amdgpu_device *adev);
 void amdgpu_free_extended_power_table(struct amdgpu_device *adev);
 void amdgpu_add_thermal_controller(struct amdgpu_device *adev);
 struct amd_vce_state* amdgpu_get_vce_clock_state(void *handle, u32 idx);
-int amdgpu_dpm_change_power_state_locked(void *handle);
 void amdgpu_pm_print_power_states(struct amdgpu_device *adev);
+void amdgpu_legacy_dpm_compute_clocks(void *handle);
+void amdgpu_dpm_thermal_work_handler(struct work_struct *work);
 #endif
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
index b352ab7191ff..db5f176f0b04 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
@@ -3891,6 +3891,40 @@ static int si_set_boot_state(struct amdgpu_device *adev)
 }
 #endif
 
+static int si_set_powergating_by_smu(void *handle,
+				     uint32_t block_type,
+				     bool gate)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	switch (block_type) {
+	case AMD_IP_BLOCK_TYPE_UVD:
+		if (!gate) {
+			adev->pm.dpm.uvd_active = true;
+			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
+		} else {
+			adev->pm.dpm.uvd_active = false;
+		}
+
+		amdgpu_legacy_dpm_compute_clocks(handle);
+		break;
+	case AMD_IP_BLOCK_TYPE_VCE:
+		if (!gate) {
+			adev->pm.dpm.vce_active = true;
+			/* XXX select vce level based on ring/task */
+			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
+		} else {
+			adev->pm.dpm.vce_active = false;
+		}
+
+		amdgpu_legacy_dpm_compute_clocks(handle);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
 static int si_set_sw_state(struct amdgpu_device *adev)
 {
 	return (amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_SwitchToSwState) == PPSMC_Result_OK) ?
@@ -7801,7 +7835,7 @@ static int si_dpm_hw_init(void *handle)
 	else
 		adev->pm.dpm_enabled = true;
 	mutex_unlock(&adev->pm.mutex);
-	amdgpu_dpm_compute_clocks(adev);
+	amdgpu_legacy_dpm_compute_clocks(adev);
 	return ret;
 }
 
@@ -7849,7 +7883,7 @@ static int si_dpm_resume(void *handle)
 			adev->pm.dpm_enabled = true;
 		mutex_unlock(&adev->pm.mutex);
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_compute_clocks(adev);
+			amdgpu_legacy_dpm_compute_clocks(adev);
 	}
 	return 0;
 }
@@ -8094,6 +8128,7 @@ static const struct amd_pm_funcs si_dpm_funcs = {
 	.print_power_state = &si_dpm_print_power_state,
 	.debugfs_print_current_performance_level = &si_dpm_debugfs_print_current_performance_level,
 	.force_performance_level = &si_dpm_force_performance_level,
+	.set_powergating_by_smu = &si_set_powergating_by_smu,
 	.vblank_too_short = &si_dpm_vblank_too_short,
 	.set_fan_control_mode = &si_dpm_set_fan_control_mode,
 	.get_fan_control_mode = &si_dpm_get_fan_control_mode,
@@ -8102,7 +8137,7 @@ static const struct amd_pm_funcs si_dpm_funcs = {
 	.check_state_equal = &si_check_state_equal,
 	.get_vce_clock_state = amdgpu_get_vce_clock_state,
 	.read_sensor = &si_dpm_read_sensor,
-	.change_power_state = amdgpu_dpm_change_power_state_locked,
+	.pm_compute_clocks = amdgpu_legacy_dpm_compute_clocks,
 };
 
 static const struct amdgpu_irq_src_funcs si_dpm_irq_funcs = {
-- 
2.29.0

