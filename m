Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D8CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 01:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7483310EAEC;
	Fri, 14 Jan 2022 01:37:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB04010EAEC
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 01:37:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNmeJ8WBVAmMdxQmTDv/tJtCdZ3fYlK9cpbZiphe8O+aorXxfX0d2lBFH++fiFqgT+yU9G8+Oazd4KJeTDpUQjMJ1Qsz/peELcTYFwdOQw2wyxbtnnw0Gledb6/tAbgyBbnGDbZcaj7DCfj8YcEc4voXp3H8CrsRBjrtiHJZmxPnWgnwoM3NxdruxVTURV4ijhee9BxzhcYhgVQ9nLWg4s0d8ncxREB7qe/CA2x1WHDRC4iSADiHdeiklPJ9NvMM8Zr7+ZjdeMR8+B1ovDd/Y6jbvHZKn1QbXRsTtO2kqlTdO/AZ3e8hWLBmhoLfC4c2JgIdbJKN7FVJCKF76XnOGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NBXyFOttaZ/3OI+2nGqUMUGT0/pcQG/j//TMP9NvHg=;
 b=DfD0jQPkpYGKICumR/6pVtI6R4tIYJJmjRJfpUel2SOz/pm+mQgALOv0+jWaw+UNK1TEYQTmi/w9cAqjMP10By1KhPSADbtpWpmXyhmmXeE8/vAp+RpBwEEf50glgtM/9effzj6Niknyvn10TtgRvEzvagCIibf3lolCBwuJMAjC0Fak5Wg32McBU08yx0RARjOnS5OI1Pks15oNIPVAWxvcnEAr5zYjSsubAKaFzQMiXO98Ex7wP6geAq9riV3b0bWdxQU6suXUastclZpbCbCd38+jQnYsB2w9TUXfz72NnwiEjNiJQSNN072Z5Hb8En0q2bPgXWjDO42XlXO8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NBXyFOttaZ/3OI+2nGqUMUGT0/pcQG/j//TMP9NvHg=;
 b=jxaOz+1MDcdWag5laKScM3GdewhpIcZs5yuXaJ9HE7vX3OD5xoEADV26bhDm3z2vrgHp89srdluLFBOqYBjKpmrEOP7vYL83jO+rPWwTB07m4oU25tV3oGk0zsSm0ICz8rD4XsF+FJrGQ7B17HwRRbWRA3mX1h7ZqlSohVgpOfU=
Received: from BN0PR04CA0170.namprd04.prod.outlook.com (2603:10b6:408:eb::25)
 by DM5PR12MB1804.namprd12.prod.outlook.com (2603:10b6:3:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Fri, 14 Jan
 2022 01:37:20 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::d0) by BN0PR04CA0170.outlook.office365.com
 (2603:10b6:408:eb::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12 via Frontend
 Transport; Fri, 14 Jan 2022 01:37:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 01:37:20 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 19:37:20 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 17:37:20 -0800
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17
 via Frontend Transport; Thu, 13 Jan 2022 19:37:15 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/13] drm/amd/display: Disabled seamless boots on DP and
 renamed power_down_display_on_boot
Date: Fri, 14 Jan 2022 09:36:46 +0800
Message-ID: <20220114013657.3119627-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114013657.3119627-1-Wayne.Lin@amd.com>
References: <20220114013657.3119627-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb73608e-f2bf-4fa0-53c6-08d9d6fe6832
X-MS-TrafficTypeDiagnostic: DM5PR12MB1804:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1804C746DDB5F096E8190734FC549@DM5PR12MB1804.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 66JxWMBpwDTjlE+mjS63iK2Aff1VsooK9NhuIrLm1QJ9LxXtDC2m9QuyWdbZacJBYk+2y8ftFQy94ge/g/hVMozSOQubMQkf6dQ2uu9cQaqkcz1Pba7yfEI/GY32JNW6EbacmP6U39A5/VgBOSX1cOfoXbkwseydij4bgFYPR4li7qkt1uEZQoZjPcd7fjfgZ5H9U1P0e+3by6voDeMjHrfWfzl0nl0ONnKd3V4i35F8UiqnsDMhyFcrgue4Kuu6pWVWzlTVBDJ/mFLx9mY+x6IbzGT/oDBs+8a2Uv98CbhCkdlfBs3mMD5hPt5C5UUOSfaBQzDN66kf2344TuBkOBCWLAv12L3Djfc1p3PaH/wJV8DkynKmNGEl7Io9QNrmJypSbl1E9uEf7dtHvg+U5Zcn+TvVzSbiHGLLE+PO7wwx0dlbJdtx9JXJXz+I3cpFVdTavdwaeLtJi5Yq5Oyfdb8/3P7Ub++DsSBJgKd2b29OrpMtDIivoaCp7uxmc8tRxKz1cUzho301n5jxk+V64U1DZK1jyLbsWfGZ4sv4OK6ilaPx7LQOVOgiXpaXDwMDuv9q62n8WG3jf/b79tySd4lV8qAlGTqjFzTQ6kIvkiv26IqEk/G2zoPNsrXK7SE/qJe/j5uX+0Z60+K9TeTR5P0HZHGY4Xs3spbjkw6AGIxo/V3f3SygwZ/qjoOpzaBPIgOVAdMYzO7qEpXjRH6sjzvf00WS1/NYAhS6lJ1d965oBNLUk+WvaL1UuItp4glHDVe4TWgy968ZctjeV/sZio/sEZSs3K1IqswVrntVZZI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(8676002)(6916009)(7696005)(86362001)(336012)(40460700001)(426003)(186003)(8936002)(2616005)(36756003)(26005)(6666004)(82310400004)(83380400001)(356005)(81166007)(5660300002)(2906002)(4326008)(70206006)(47076005)(1076003)(70586007)(508600001)(316002)(36860700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 01:37:20.7333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb73608e-f2bf-4fa0-53c6-08d9d6fe6832
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1804
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Jarif Aftab <jaraftab@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jarif Aftab <jaraftab@amd.com>

[WHY]
- We only ever want seamless boots on eDPs
- The naming and logic did not match the context

[HOW]
- Removed unnecessary if statements
- Renamed power_down_display_on_boot to seamless_boot_edp_requested and
swapped the logic

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Jarif Aftab <jaraftab@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  4 ++--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c        | 12 ------------
 drivers/gpu/drm/amd/display/dc/dc.h                  |  2 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c    |  5 ++---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c   |  7 +++----
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c   |  5 ++---
 6 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 17fd37ee6251..921e5a718ecf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1496,10 +1496,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		init_data.flags.allow_lttpr_non_transparent_mode.bits.DP2_0 = true;
 #endif
 
-	init_data.flags.power_down_display_on_boot = true;
+	init_data.flags.seamless_boot_edp_requested = false;
 
 	if (check_seamless_boot_capability(adev)) {
-		init_data.flags.power_down_display_on_boot = false;
+		init_data.flags.seamless_boot_edp_requested = true;
 		init_data.flags.allow_seamless_boot_optimization = true;
 		DRM_INFO("Seamless boot condition check passed\n");
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index b5e570d33ca9..0c64dea4fdd8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1019,18 +1019,6 @@ static bool dc_link_detect_helper(struct dc_link *link,
 					link->type != dc_connection_mst_branch)
 				dm_helpers_dp_mst_stop_top_mgr(link->ctx, link);
 
-
-			// For seamless boot, to skip verify link cap, we read UEFI settings and set them as verified.
-			if (reason == DETECT_REASON_BOOT &&
-					!dc_ctx->dc->config.power_down_display_on_boot &&
-					link->link_status.link_active)
-				perform_dp_seamless_boot = true;
-
-			if (perform_dp_seamless_boot) {
-				read_current_link_settings_on_detect(link);
-				link->verified_link_cap = link->reported_link_cap;
-			}
-
 			break;
 		}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 288e7b01f561..263f7edd42a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -322,7 +322,7 @@ struct dc_config {
 	bool fbc_support;
 	bool disable_fractional_pwm;
 	bool allow_seamless_boot_optimization;
-	bool power_down_display_on_boot;
+	bool seamless_boot_edp_requested;
 	bool edp_not_connected;
 	bool edp_no_power_sequencing;
 	bool force_enum_edp;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 530a72e3eefe..915eecb40788 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1505,8 +1505,7 @@ void dcn10_init_hw(struct dc *dc)
 		dmub_enable_outbox_notification(dc);
 
 	/* we want to turn off all dp displays before doing detection */
-	if (dc->config.power_down_display_on_boot)
-		dc_link_blank_all_dp_displays(dc);
+	dc_link_blank_all_dp_displays(dc);
 
 	/* If taking control over from VBIOS, we may want to optimize our first
 	 * mode set, so we need to skip powering down pipes until we know which
@@ -1514,7 +1513,7 @@ void dcn10_init_hw(struct dc *dc)
 	 * Otherwise, if taking control is not possible, we need to power
 	 * everything down.
 	 */
-	if (dcb->funcs->is_accelerated_mode(dcb) || dc->config.power_down_display_on_boot) {
+	if (dcb->funcs->is_accelerated_mode(dcb) || !dc->config.seamless_boot_edp_requested) {
 		if (!is_optimized_init_done) {
 			hws->funcs.init_pipes(dc, dc->current_state);
 			if (dc->res_pool->hubbub->funcs->allow_self_refresh_control)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 1db1ca19411d..ed0a0e5fd805 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -545,8 +545,7 @@ void dcn30_init_hw(struct dc *dc)
 			hws->funcs.dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
 
 	/* we want to turn off all dp displays before doing detection */
-	if (dc->config.power_down_display_on_boot)
-		dc_link_blank_all_dp_displays(dc);
+	dc_link_blank_all_dp_displays(dc);
 
 	/* If taking control over from VBIOS, we may want to optimize our first
 	 * mode set, so we need to skip powering down pipes until we know which
@@ -554,7 +553,7 @@ void dcn30_init_hw(struct dc *dc)
 	 * Otherwise, if taking control is not possible, we need to power
 	 * everything down.
 	 */
-	if (dcb->funcs->is_accelerated_mode(dcb) || dc->config.power_down_display_on_boot) {
+	if (dcb->funcs->is_accelerated_mode(dcb) || !dc->config.seamless_boot_edp_requested) {
 		hws->funcs.init_pipes(dc, dc->current_state);
 		if (dc->res_pool->hubbub->funcs->allow_self_refresh_control)
 			dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub,
@@ -566,7 +565,7 @@ void dcn30_init_hw(struct dc *dc)
 	 * To avoid this, power down hardware on boot
 	 * if DIG is turned on and seamless boot not enabled
 	 */
-	if (dc->config.power_down_display_on_boot) {
+	if (!dc->config.seamless_boot_edp_requested) {
 		struct dc_link *edp_links[MAX_NUM_EDP];
 		struct dc_link *edp_link = NULL;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 4206ce5bf9a9..b2cfd277b913 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -197,8 +197,7 @@ void dcn31_init_hw(struct dc *dc)
 		dmub_enable_outbox_notification(dc);
 
 	/* we want to turn off all dp displays before doing detection */
-	if (dc->config.power_down_display_on_boot)
-		dc_link_blank_all_dp_displays(dc);
+	dc_link_blank_all_dp_displays(dc);
 
 	/* If taking control over from VBIOS, we may want to optimize our first
 	 * mode set, so we need to skip powering down pipes until we know which
@@ -206,7 +205,7 @@ void dcn31_init_hw(struct dc *dc)
 	 * Otherwise, if taking control is not possible, we need to power
 	 * everything down.
 	 */
-	if (dcb->funcs->is_accelerated_mode(dcb) || dc->config.power_down_display_on_boot) {
+	if (dcb->funcs->is_accelerated_mode(dcb) || !dc->config.seamless_boot_edp_requested) {
 		hws->funcs.init_pipes(dc, dc->current_state);
 		if (dc->res_pool->hubbub->funcs->allow_self_refresh_control)
 			dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub,
-- 
2.25.1

