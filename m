Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9B5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 07:43:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAC466F3CB;
	Tue, 30 Nov 2021 07:43:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2A666F3A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 07:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejVqZz2dp4OBG0P/9JMqj2r+lpkZ0vMcEE39Js3EV8KullCNLI5y3LIDkaLLKAByDtTdfXFvuSiRUejC/fVSln1BorjXbppBNHk1EWebX9OZ5DNUapiJWqRbc7cMrtC3vL6y1xxm0c3M0LWjiu7fY6NyhLjuEcJRnvSYOOj/zp5oh+0dqLCFemgK4dOW8DQnHyB5+eBxvL1WiKIqO0kLUTDjFPM+P4gVdwbZGI1tcOJoG/u5xzCrOmS2w61PBjwgAU/uuSDE/gFY7UGFSu/PrsIIuk4Jlsw11kUPD+azjP78j4JHLUpw/dPZP1OGQkFkXWftbnc2hG2JkhQk/HC66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YD4LQH3yZR4EUYZcxYeDEOJTGXskbGb+jggNr/iynLE=;
 b=GLeS7LdOk3y2lV9PdtzIyio3//P2J/PMSZdVTVjLfkHFAUlGA7lqLBpqqNvErF/tN2CLNJ+y8zNcPIlNXGzJs8cox2dZdc8VJYCVx/TIK0BYj904YrT9lFuZ3ojMw1dlGHZSdxRwjI9KhiVNitw6UtLEFuf/swJBT3Mf+6+4DKoj/DnTTLL68w1U2dtS7wY3sQGy4fdv2ZNmShYhtiMHitaaymXVuVrcjB3D/3vRalfwLc/VDzwE7qnXGm8l0Sx+TsCs/DZx/Jldnet7u6IAtqtypxCB7hW53+sYqzwZT5FJUCzklqIanxghZ0M5bOHwsAQPsimGndM8b4NuPUAyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YD4LQH3yZR4EUYZcxYeDEOJTGXskbGb+jggNr/iynLE=;
 b=DmAg9wbV6xhCI3C4s1YD7bN1oO/jhSHtlw43rRTqXgMeYxaCSZgIzBtZBq30cBPUzXGQLk+RgSaBMvHrpGAWhqWPRam3LW+061tIQzHJOgCD7j/w+/Ipo7Ozb1Q5UF3id0RJpEIbE/QUJE7PcRoSr+jGVrDgNoy8hRAZfXj0HGY=
Received: from BN9PR03CA0164.namprd03.prod.outlook.com (2603:10b6:408:f4::19)
 by BN8PR12MB3059.namprd12.prod.outlook.com (2603:10b6:408:42::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 07:43:42 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::e8) by BN9PR03CA0164.outlook.office365.com
 (2603:10b6:408:f4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 07:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 07:43:42 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 01:43:40 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 09/17] drm/amd/pm: optimize the amdgpu_pm_compute_clocks()
 implementations
Date: Tue, 30 Nov 2021 15:42:51 +0800
Message-ID: <20211130074259.1271965-10-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211130074259.1271965-1-evan.quan@amd.com>
References: <20211130074259.1271965-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 198058d8-4aa9-4fb6-fa85-08d9b3d521c9
X-MS-TrafficTypeDiagnostic: BN8PR12MB3059:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3059BCE3A215020B088C17F2E4679@BN8PR12MB3059.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Q8Iilb8aRNHmW5WbgbwnAxAQNnt5oIFQ+Q2LB+KJYM5EZpDuou4Oo3lDUWTJTcMjEKvTUXaFLImt875TCgHbWNgzbHsSXLUZUYD9ipeHtm4jrqTcaFrM72UWegCKCOFKLDvavYPekGnLPnqnI/M72hY+ppVG/nbEtvWDp1C1tEoZoag4IvhOK83Qa2dYehzdk1O9B9/pDyJWxtBASByCsGipq6ESDJF9AT8sBJrkJi1lKXsI2FhTp+z6xQUAgGOxtuCeD55TpwRpE03mZVKo1bc2wdaLimLclpKafITnIj7GxuYLAjwAHxdEP8MUVswg65e5Us1A28CckrG8g9u8KDJFDY5d/9+nZ6Dc/3CO8nyTv6puYD2IhpMc1rUs7EMQXlysK6WsN6BNWfJw9sbwV1iMCtc9+3rMKCdCr8f4Yo+39TfOdwiuL6WHj8DljfHhNL2+IMi3We5txrhX6JuEwrbyS8rBw/9zKVGh6DreVQ80qiO6dLMPv3tbIw+4vaY/nwCEklp3VZPkmiUNVLPLhG763ZlW3RELqVDTKxlIn91bCF5xmMQRKLsjo9xzIct8SMLyI1E/eQVG2LzJqL3/lJ82h2UBYDyJGvwxmeyKFZOaARa2NarbFGcETy+30Jwr9MY0bKxamgqaQ4v2MsP24uWjcGqv6FpmpPd3oxVp+KIZnEhUXI+lT4IiDTeGmhAWn7wK8s7BZsVoSuoMKIUkU0K4Rr/ON6bNARonzDSxjfKSJXYQ2ciV2GSKztld4LmtqFgzQd1+h0KVb13RfSaJVY9+C/YQjANjS0tUeBcPqX9Q0v3M5Y7boqRWVeY9Nt3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(86362001)(1076003)(70586007)(4326008)(6666004)(70206006)(44832011)(6916009)(2906002)(16526019)(47076005)(83380400001)(426003)(356005)(336012)(186003)(54906003)(8936002)(2616005)(26005)(8676002)(81166007)(30864003)(508600001)(82310400004)(7696005)(36860700001)(316002)(36756003)(5660300002)(40460700001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 07:43:42.5477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 198058d8-4aa9-4fb6-fa85-08d9b3d521c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3059
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Drop cross callings and multi-function APIs. Also avoid exposing
internal implementations details.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I55e5ab3da6a70482f5f5d8c256eed2f754feae20
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   2 +-
 drivers/gpu/drm/amd/pm/Makefile               |   2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 222 +++---------------
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  |  94 ++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   2 -
 .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |  32 +++
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  39 ++-
 drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c     |   6 +-
 drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c |  60 ++++-
 drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h |   3 +-
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c     |  41 +++-
 11 files changed, 295 insertions(+), 208 deletions(-)
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
index c6801d10cde6..1399b4426080 100644
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
@@ -432,111 +365,35 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
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
-	amdgpu_pm_compute_clocks(adev);
-}
-
 void amdgpu_pm_compute_clocks(struct amdgpu_device *adev)
 {
-	int i = 0;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	if (!adev->pm.dpm_enabled)
+	if (!pp_funcs->pm_compute_clocks)
 		return;
 
-	if (adev->mode_info.num_crtc)
-		amdgpu_display_bandwidth_update(adev);
-
-	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
-		struct amdgpu_ring *ring = adev->rings[i];
-		if (ring && ring->sched.ready)
-			amdgpu_fence_wait_empty(ring);
-	}
-
-	if ((adev->family == AMDGPU_FAMILY_SI) ||
-	     (adev->family == AMDGPU_FAMILY_KV)) {
-		amdgpu_dpm_get_active_displays(adev);
-		adev->powerplay.pp_funcs->change_power_state(adev->powerplay.pp_handle);
-	} else {
-		if (!amdgpu_device_has_dc_support(adev)) {
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
 
-		amdgpu_pm_compute_clocks(adev);
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
 
@@ -544,24 +401,10 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
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
-		amdgpu_pm_compute_clocks(adev);
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
@@ -730,10 +573,7 @@ void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
 {
 	adev->pm.dpm.user_state = state;
 
-	if (adev->powerplay.pp_funcs->dispatch_tasks)
-		amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_ENABLE_USER_STATE, &state);
-	else
-		amdgpu_pm_compute_clocks(adev);
+	amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_ENABLE_USER_STATE, &state);
 }
 
 enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev)
@@ -903,12 +743,9 @@ int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
 
 	pp_funcs->set_sclk_od(adev->powerplay.pp_handle, value);
 
-	if (amdgpu_dpm_dispatch_task(adev,
-				     AMD_PP_TASK_READJUST_POWER_STATE,
-				     NULL) == -EOPNOTSUPP) {
-		adev->pm.dpm.current_ps = adev->pm.dpm.boot_ps;
-		amdgpu_pm_compute_clocks(adev);
-	}
+	amdgpu_dpm_dispatch_task(adev,
+				 AMD_PP_TASK_READJUST_POWER_STATE,
+				 NULL);
 
 	return 0;
 }
@@ -932,12 +769,9 @@ int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value)
 
 	pp_funcs->set_mclk_od(adev->powerplay.pp_handle, value);
 
-	if (amdgpu_dpm_dispatch_task(adev,
-				     AMD_PP_TASK_READJUST_POWER_STATE,
-				     NULL) == -EOPNOTSUPP) {
-		adev->pm.dpm.current_ps = adev->pm.dpm.boot_ps;
-		amdgpu_pm_compute_clocks(adev);
-	}
+	amdgpu_dpm_dispatch_task(adev,
+				 AMD_PP_TASK_READJUST_POWER_STATE,
+				 NULL);
 
 	return 0;
 }
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
index 1462c4933ca1..5b68f9fe4fde 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -420,8 +420,6 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
 			   void *data, uint32_t *size);
 
-void amdgpu_dpm_thermal_work_handler(struct work_struct *work);
-
 void amdgpu_pm_compute_clocks(struct amdgpu_device *adev);
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
index 90f4c65659e2..72824ef61edd 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
@@ -3088,7 +3088,7 @@ static int kv_dpm_hw_init(void *handle)
 	else
 		adev->pm.dpm_enabled = true;
 	mutex_unlock(&adev->pm.mutex);
-	amdgpu_pm_compute_clocks(adev);
+	amdgpu_legacy_dpm_compute_clocks(adev);
 	return ret;
 }
 
@@ -3136,7 +3136,7 @@ static int kv_dpm_resume(void *handle)
 			adev->pm.dpm_enabled = true;
 		mutex_unlock(&adev->pm.mutex);
 		if (adev->pm.dpm_enabled)
-			amdgpu_pm_compute_clocks(adev);
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
index 9427c1026e1d..9e6bc562fc5a 100644
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
@@ -1378,9 +1380,8 @@ static struct amdgpu_ps *amdgpu_dpm_pick_power_state(struct amdgpu_device *adev,
 	return NULL;
 }
 
-int amdgpu_dpm_change_power_state_locked(void *handle)
+static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ps *ps;
 	enum amd_pm_state_type dpm_state;
 	int ret;
@@ -1451,3 +1452,58 @@ int amdgpu_dpm_change_power_state_locked(void *handle)
 
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
index 4adc765c8824..3c1f02a63376 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h
@@ -65,6 +65,7 @@ int amdgpu_parse_extended_power_table(struct amdgpu_device *adev);
 void amdgpu_free_extended_power_table(struct amdgpu_device *adev);
 void amdgpu_add_thermal_controller(struct amdgpu_device *adev);
 struct amd_vce_state* amdgpu_get_vce_clock_state(void *handle, u32 idx);
-int amdgpu_dpm_change_power_state_locked(void *handle);
 void amdgpu_pm_print_power_states(struct amdgpu_device *adev);
+void amdgpu_legacy_dpm_compute_clocks(void *handle);
+void amdgpu_dpm_thermal_work_handler(struct work_struct *work);
 #endif
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
index a2881c90d187..b8dbddefb74e 100644
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
-	amdgpu_pm_compute_clocks(adev);
+	amdgpu_legacy_dpm_compute_clocks(adev);
 	return ret;
 }
 
@@ -7849,7 +7883,7 @@ static int si_dpm_resume(void *handle)
 			adev->pm.dpm_enabled = true;
 		mutex_unlock(&adev->pm.mutex);
 		if (adev->pm.dpm_enabled)
-			amdgpu_pm_compute_clocks(adev);
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

