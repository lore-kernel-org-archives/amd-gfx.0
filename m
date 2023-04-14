Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C013CC77B72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2552310EDC6;
	Fri, 14 Apr 2023 15:54:15 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C9C10EDC2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NR84D4oeK5osjaNstDmHRch1g3BEzWYxgzCyYAqrDVzAxgm+1vX+fWZmQE8mPUs78uNoveYaaJGSKQxFgM3dwznDLQW4jB+oKgWO99fXazDnmJ/IFO18HkCnhXds6n9FtAa1v0hk1Xl3c9uCw0HB8VpDJHELMsNhSmI50XNt9I0KVRAi/OhBPa7RvyV3AHZYb1eQy6unVu2msFIPKjELtagKvkWYoHhZwtBkJmNvLBG8ONk4ok4xGNPDihFzqDGFlE/V1t+5HpG3Q3y0+QSE7zd0+igfJuxggWk4lUToAl0SLpmgHPcAqzGaeMwwmLzVydoXZ5agHVDpVOcWgVRQaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwlRVwxlg4mM7+clvF6Qyi1tlREUKmKW0PW0KRAObB4=;
 b=Py+JegL0qczcGNToOpd5MX2F+Kg/e9g3wjauuZ8z1ePs3kgLDs5vyUEJXLayOA6Y5EtbDp+EjEgHPZmD5Nln0xEKHZ2EXc2XJ2CFzas9jdA5dPlOTPjn6KQb/7lRiCmYYrjHDQK3JAp1StY88OOksDTcgsERT3oEvepjTNC6Hx6z7mR0O24hfh165K4ReDHGBymXAipRR3wuvvDIeYy/8JOKwfsaxWu5gnnu17sDuwdYNvkAidWcgnXYkxHUmXcjgHuX0HfaON8U9wq0MdmQApKjNgKYF8+Vanf1XpVLV6led88wVv2ox1Kwx1QkG7Aqn3EiCZbhhPcS80lWlXSTdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwlRVwxlg4mM7+clvF6Qyi1tlREUKmKW0PW0KRAObB4=;
 b=FgNJHqS60RY8KQN3dIUZ13jw2uFVbFyO0G/jrLtbd8W7pK+H3upclpjUH0lh6J+vLH5n+6cLjvMygTvFF7rEI6A2Apcc+Sgxk9Dqksxb8wtFNvfYykheba4dwS1tAnhptPQiLUOIoGYFbuPu1ITLdmOYDACz9HZ9etTV7Tkmqc4=
Received: from DM6PR06CA0043.namprd06.prod.outlook.com (2603:10b6:5:54::20) by
 SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.36; Fri, 14 Apr 2023 15:54:09 +0000
Received: from DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::e) by DM6PR06CA0043.outlook.office365.com
 (2603:10b6:5:54::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT072.mail.protection.outlook.com (10.13.173.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:54:09 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:07 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/66] drm/amd/display: Fix in disabling secure display
Date: Fri, 14 Apr 2023 11:52:39 -0400
Message-ID: <20230414155330.5215-16-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT072:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c546d4a-429a-422c-82fa-08db3d007c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gGb3tv7Do9fp42to4ARFSgdQlJW19k5eOVcC5yYzmwDeEjubE7V3Qadv/dAsSKuWSn8om8T+chzRALc0iOrmFV5K8yl0ykQi+RGvaJg5AxQjxrwVMyyvZ75t0XPgsVW8VixJ4pyvrmjlbVLGYfjTm84gbZGPmty8SGWCDXWM7yyfUG+g7Cytl/oWF0qi5AYuG7RJdLV4ZRKmYu4ImJ1wNOZ3Ha20UwCd5NO0NO+HdYOlMbT04HdDD3eWw4CfkMSzM8eRX7Of5mpRRzfms/2Qckj0U0dEhpIyBJyP9DEEnxq0QrEeosUV+ime6dQc9uV0YTLg5z00X8Teo0zxC87ZrlIJY4i3nZsqxyHAZ4dXBdgkiimJKuWgzWDZw6mwC6LN0Y3/P2iMRhYMf9Up40s+V7wnMpuqtGVN431s15wk85CsAMaSb/PF2/T8wwB+sdOqnYs2a70L86YgzYxP0aY3BsKhx2b4WX/t0Tk2AtDLkCoNceGDae68ddxC6bUQx3QClqiCbzCt2N3X6pxlpqzar7GHM7rmfpLBibIJ85wsSSiRa23IylNo60dl9+w3WV9VGwDDTSaHfEs4vpIJXAM2cnizvVFJltYegsVh3kgw0CSOEqwG59R25cv/L3c7goUl68JMSaJ5GMQLkkJ3a8BiwjkdLIqpPxNUW+piyiTV91tFSxC0koDthYa9zPYqQoOceJv8MshE9TLBBtjsXLn3TivoCN4CG8u3kzseVUQXAGg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(46966006)(40470700004)(36840700001)(81166007)(86362001)(36756003)(316002)(54906003)(41300700001)(70206006)(6916009)(478600001)(8676002)(70586007)(4326008)(40480700001)(82310400005)(8936002)(36860700001)(5660300002)(2906002)(82740400003)(16526019)(186003)(356005)(83380400001)(1076003)(26005)(6666004)(336012)(2616005)(426003)(47076005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:09.5189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c546d4a-429a-422c-82fa-08db3d007c31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Wayne Lin <Wayne.Lin@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alan Liu <HaoPing.Liu@amd.com>

[Why]
Currently we don't check if secure display is enabled before we send
command to disable secure display in dmub. It will accidentally cause
some other igt tests to fail, eg, crtc-linear-degamma.

[How]
Refactor the code we reset the secure display state to check secure
display was enabled or not before stopping it in dmub.

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alan Liu <HaoPing.Liu@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 31 ++++++++-----------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 27711743c22c..0802f8e8fac5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -83,12 +83,15 @@ const char *const *amdgpu_dm_crtc_get_crc_sources(struct drm_crtc *crtc,
 }
 
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
-static void amdgpu_dm_set_crc_window_default(struct drm_crtc *crtc)
+static void amdgpu_dm_set_crc_window_default(struct drm_crtc *crtc, struct dc_stream_state *stream)
 {
 	struct drm_device *drm_dev = crtc->dev;
+	struct amdgpu_display_manager *dm = &drm_to_adev(drm_dev)->dm;
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
+	bool was_activated;
 
 	spin_lock_irq(&drm_dev->event_lock);
+	was_activated = acrtc->dm_irq_params.window_param.activated;
 	acrtc->dm_irq_params.window_param.x_start = 0;
 	acrtc->dm_irq_params.window_param.y_start = 0;
 	acrtc->dm_irq_params.window_param.x_end = 0;
@@ -97,6 +100,14 @@ static void amdgpu_dm_set_crc_window_default(struct drm_crtc *crtc)
 	acrtc->dm_irq_params.window_param.update_win = false;
 	acrtc->dm_irq_params.window_param.skip_frame_cnt = 0;
 	spin_unlock_irq(&drm_dev->event_lock);
+
+	/* Disable secure_display if it was enabled */
+	if (was_activated) {
+		/* stop ROI update on this crtc */
+		flush_work(&dm->secure_display_ctxs[crtc->index].notify_ta_work);
+		flush_work(&dm->secure_display_ctxs[crtc->index].forward_roi_work);
+		dc_stream_forward_crc_window(stream, NULL, true);
+	}
 }
 
 static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
@@ -204,9 +215,6 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 					struct dm_crtc_state *dm_crtc_state,
 					enum amdgpu_dm_pipe_crc_source source)
 {
-#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-	int i;
-#endif
 	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
 	struct dc_stream_state *stream_state = dm_crtc_state->stream;
 	bool enable = amdgpu_dm_is_valid_crc_source(source);
@@ -220,19 +228,6 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 
 	/* Enable or disable CRTC CRC generation */
 	if (dm_is_crc_source_crtc(source) || source == AMDGPU_DM_PIPE_CRC_SOURCE_NONE) {
-#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-		/* Disable secure_display if it was enabled */
-		if (!enable) {
-			for (i = 0; i < adev->mode_info.num_crtc; i++) {
-				if (adev->dm.secure_display_ctxs[i].crtc == crtc) {
-					/* stop ROI update on this crtc */
-					flush_work(&adev->dm.secure_display_ctxs[i].notify_ta_work);
-					flush_work(&adev->dm.secure_display_ctxs[i].forward_roi_work);
-					dc_stream_forward_crc_window(stream_state, NULL, true);
-				}
-			}
-		}
-#endif
 		if (!dc_stream_configure_crc(stream_state->ctx->dc,
 					     stream_state, NULL, enable, enable)) {
 			ret = -EINVAL;
@@ -363,7 +358,7 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	/* Reset secure_display when we change crc source from debugfs */
-	amdgpu_dm_set_crc_window_default(crtc);
+	amdgpu_dm_set_crc_window_default(crtc, crtc_state->stream);
 #endif
 
 	if (amdgpu_dm_crtc_configure_crc_source(crtc, crtc_state, source)) {
-- 
2.34.1

