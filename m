Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D87C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D3F410E0BB;
	Thu, 20 Oct 2022 15:48:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8805610E177
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSpC080GGOtQpk7yikzRs5iYaI2FD8C8pyHSf7AiGM5lSyByu7DaAyETiOERsfNXSkxGaxRITWw2k6Bk1a2qGPy4HCxN8LsFzKRFnCb+7LQeaYn5XhRVe6mWV9GehBxyC02S6Jo8eLFCGUefjpauIhsmG745NXk3q4zuT0lzuQnaIE3BOQwrdrX/wvQVbh9PHTrvTNXqP7sn/5MpsPQ+f6VLptPnwwfFQBR3m+5AOsoJFUo6LU0QQFRYIYVH5u7nEiuigmK1zBAumZIAY4nP5HaD2wI7oK37hqb1fC2ReMTNnfFbJoKQhIH1L5BlTt/Uka51m/9Gpli5ob1CYDPZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOVAMp0X7Yk7HK8DeIqyp+taK1+rMNel45RgMgpcmqU=;
 b=O1B+J43mm3i1MYQAvWxJc3NUVVFyfdZCa9u6DfWtyIvbHXZXBbRgngUxUs7oYqkw4ZqHFv38LVdldBod/ess5tUatLhJPuj+T2e9GNQmIva1MkZ1F/nKQzs/B2j0/7jV6Z8Uw0RcFWEbQG+qoT8g4EP6+59EUlOawhhgMFdBAyu1bKFiZ0TjENHZr2c3D0k3M7rFy5Yt5UBsWg9SGFsfUfa+p2w4LVYxi1bJedT8czR2rtAsPI3t7IelFMvaspSgrVP0bggs+O2krp0hz4RAR1+JjIb1faFQLvcw2kVvlvV5i1WFg4nZWDXe8X/1hA4GWQHgFEllaQrOWuo81q+Imw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOVAMp0X7Yk7HK8DeIqyp+taK1+rMNel45RgMgpcmqU=;
 b=B8xLrPoU6N4Fzmk1hbYDLAfAiSORh1jor4tPATCvEupS9EnLy7/UOOVI0XIua7xY98rzRdZ/jm9NnFzEAiZ4Xx80lG0PNSfgOKhdMK9BN9pZpjCUS0UVrcsOTSlUoCp2AeWiRz6m1OONQZzyIXpaWP3WoI8GvFaIBwYiV7ApRqQ=
Received: from DS7PR06CA0016.namprd06.prod.outlook.com (2603:10b6:8:2a::29) by
 BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.34; Thu, 20 Oct 2022 15:47:54 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::d8) by DS7PR06CA0016.outlook.office365.com
 (2603:10b6:8:2a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35 via Frontend
 Transport; Thu, 20 Oct 2022 15:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:47:54 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:47:51 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/33] drm/amd/display: Drop struct crc_region and reuse
 struct rect
Date: Thu, 20 Oct 2022 11:46:43 -0400
Message-ID: <20221020154702.503934-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT021:EE_|BY5PR12MB4034:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc698cd-bac4-4eae-54c7-08dab2b273d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iu1olwGBQ8WlziRdj//4OjFSy69ky1C/kg3HMA2wnSWbDPj6IalzVTS9aWo3XdHSgOUJpDrhiQ6+2o9l0Ee9pETjuN8Bb2NSe45J+GnPg0/WNkXQ2ZzcF4UkZ+aLvj1i9b2Vt1weO8qfhFG2Gnn+XGxOH0vVuFr/0Ru4bQXPsZWXvfHX3iFtm0DVtj81o55a8uBx2jAW4h1WxbyM3V+AB1pHPfejLSG6iFUk9iPzRffaaeIMGpYSCTt+5v/r5eVlFfeJxWlRzYkwLr6Bgv3RWkZ2R4Zy1u8j/Mp01C8CDnsDk41jNcDpZO5AGRo71OS+vYhnpZsORdu41tqmTwUGWohuMLk8eL/nsb5EiPJjCX+4KxULRxzOLJBYratkBDce9UX1K9PWn0ZQahXRw0x04hAnqP0A5SSD+AhIAJgVlwfbfm451mSjutAtk4niOKvlV8jcaf0xkeqeSTZxsq2JmjoWj9s0dDgFAkIM79TWC9SA4Bjh+TlY/XkcBzZp3kUtzMrpG7FtAHFu+z2Fx8kFR9XOHWQAiJ7x614bs2Cok5l4ha5wBKxV/Yy8gBxvxky45MBmlyaDYuvViMOKslVMu0uRn5XH+xpS/e4gv6/oJhIJwxvKDd5QWC1fkBtmpVO4nYJjo6udc5neKskTWei8SepXbbqARUf/gAoprgmTAbuQ2aVEVm49NCCOKo8EXkPkQFh5hcRS9G/Kx+HPKGhy7t7FgXMful4fqZwht6QDaL5IQq71yHK0FCu89+5S5neBcuR/UIFUkSH6VoLI+Pm2cY0ppXEzoq4pX0WmBb/TscDJk0cSLEFRLewzOBn/0MnK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(40470700004)(46966006)(36840700001)(82740400003)(186003)(16526019)(336012)(2616005)(1076003)(7696005)(36860700001)(26005)(316002)(47076005)(6666004)(426003)(40460700003)(2906002)(83380400001)(40480700001)(5660300002)(30864003)(478600001)(82310400005)(41300700001)(70206006)(6916009)(70586007)(8676002)(8936002)(54906003)(4326008)(36756003)(86362001)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:47:54.2848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc698cd-bac4-4eae-54c7-08dab2b273d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4034
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
reuse struct rect rather than adding a new struct.

[How]
- Userspace keeps inputting x_start, y_start, x_end, y_end
- We translate data to x, y, width, height in code flow to store
- translate back to x_start, y_start, x_end, y_end before programming HW

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alan Liu <HaoPing.Liu@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 20 ++++++++++---------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |  7 +++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 16 +++++++--------
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 20 +++++++++----------
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  7 -------
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 14 +++++++++----
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h  |  2 +-
 8 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index a857f6454753..fb077e9af99f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -89,10 +89,10 @@ static void amdgpu_dm_set_crc_window_default(struct drm_crtc *crtc)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 	spin_lock_irq(&drm_dev->event_lock);
-	acrtc->dm_irq_params.window_param.roi.x_start = 0;
-	acrtc->dm_irq_params.window_param.roi.y_start = 0;
-	acrtc->dm_irq_params.window_param.roi.x_end = 0;
-	acrtc->dm_irq_params.window_param.roi.y_end = 0;
+	acrtc->dm_irq_params.window_param.x_start = 0;
+	acrtc->dm_irq_params.window_param.y_start = 0;
+	acrtc->dm_irq_params.window_param.x_end = 0;
+	acrtc->dm_irq_params.window_param.y_end = 0;
 	acrtc->dm_irq_params.window_param.activated = false;
 	acrtc->dm_irq_params.window_param.update_win = false;
 	acrtc->dm_irq_params.window_param.skip_frame_cnt = 0;
@@ -145,7 +145,7 @@ amdgpu_dm_forward_crc_window(struct work_struct *work)
 	dm = crc_fw_wrk->dm;
 
 	mutex_lock(&dm->dc_lock);
-	dc_stream_forward_crc_window(dm->dc, &crc_fw_wrk->roi, crc_fw_wrk->stream, crc_fw_wrk->is_stop_cmd);
+	dc_stream_forward_crc_window(dm->dc, &crc_fw_wrk->rect, crc_fw_wrk->stream, crc_fw_wrk->is_stop_cmd);
 	mutex_unlock(&dm->dc_lock);
 
 	kfree(crc_fw_wrk);
@@ -496,10 +496,12 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 		INIT_WORK(&crc_fw_wrk->forward_roi_work, amdgpu_dm_forward_crc_window);
 		crc_fw_wrk->dm = &adev->dm;
 		crc_fw_wrk->stream = stream_state;
-		crc_fw_wrk->roi.x_start = acrtc->dm_irq_params.window_param.roi.x_start;
-		crc_fw_wrk->roi.y_start = acrtc->dm_irq_params.window_param.roi.y_start;
-		crc_fw_wrk->roi.x_end = acrtc->dm_irq_params.window_param.roi.x_end;
-		crc_fw_wrk->roi.y_end = acrtc->dm_irq_params.window_param.roi.y_end;
+		crc_fw_wrk->rect.x = acrtc->dm_irq_params.window_param.x_start;
+		crc_fw_wrk->rect.y = acrtc->dm_irq_params.window_param.y_start;
+		crc_fw_wrk->rect.width = acrtc->dm_irq_params.window_param.x_end -
+								acrtc->dm_irq_params.window_param.x_start;
+		crc_fw_wrk->rect.height = acrtc->dm_irq_params.window_param.y_end -
+								acrtc->dm_irq_params.window_param.y_start;
 		schedule_work(&crc_fw_wrk->forward_roi_work);
 
 		acrtc->dm_irq_params.window_param.update_win = false;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
index 16bfc2dc35ab..71bce608d751 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
@@ -41,7 +41,10 @@ enum amdgpu_dm_pipe_crc_source {
 
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 struct crc_window_param {
-	struct crc_region roi;
+	uint16_t x_start;
+	uint16_t y_start;
+	uint16_t x_end;
+	uint16_t y_end;
 	/* CRC windwo is activated or not*/
 	bool activated;
 	/* Update crc window during vertical blank or not */
@@ -64,7 +67,7 @@ struct crc_fw_work {
 	struct work_struct forward_roi_work;
 	struct amdgpu_display_manager *dm;
 	struct dc_stream_state *stream;
-	struct crc_region roi;
+	struct rect rect;
 	bool is_stop_cmd;
 };
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index dcd47dd86303..cc8c2ea047ce 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3100,7 +3100,7 @@ static int crc_win_x_start_set(void *data, u64 val)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 	spin_lock_irq(&drm_dev->event_lock);
-	acrtc->dm_irq_params.window_param.roi.x_start = (uint16_t) val;
+	acrtc->dm_irq_params.window_param.x_start = (uint16_t) val;
 	acrtc->dm_irq_params.window_param.update_win = false;
 	spin_unlock_irq(&drm_dev->event_lock);
 
@@ -3117,7 +3117,7 @@ static int crc_win_x_start_get(void *data, u64 *val)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 	spin_lock_irq(&drm_dev->event_lock);
-	*val = acrtc->dm_irq_params.window_param.roi.x_start;
+	*val = acrtc->dm_irq_params.window_param.x_start;
 	spin_unlock_irq(&drm_dev->event_lock);
 
 	return 0;
@@ -3137,7 +3137,7 @@ static int crc_win_y_start_set(void *data, u64 val)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 	spin_lock_irq(&drm_dev->event_lock);
-	acrtc->dm_irq_params.window_param.roi.y_start = (uint16_t) val;
+	acrtc->dm_irq_params.window_param.y_start = (uint16_t) val;
 	acrtc->dm_irq_params.window_param.update_win = false;
 	spin_unlock_irq(&drm_dev->event_lock);
 
@@ -3154,7 +3154,7 @@ static int crc_win_y_start_get(void *data, u64 *val)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 	spin_lock_irq(&drm_dev->event_lock);
-	*val = acrtc->dm_irq_params.window_param.roi.y_start;
+	*val = acrtc->dm_irq_params.window_param.y_start;
 	spin_unlock_irq(&drm_dev->event_lock);
 
 	return 0;
@@ -3173,7 +3173,7 @@ static int crc_win_x_end_set(void *data, u64 val)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 	spin_lock_irq(&drm_dev->event_lock);
-	acrtc->dm_irq_params.window_param.roi.x_end = (uint16_t) val;
+	acrtc->dm_irq_params.window_param.x_end = (uint16_t) val;
 	acrtc->dm_irq_params.window_param.update_win = false;
 	spin_unlock_irq(&drm_dev->event_lock);
 
@@ -3190,7 +3190,7 @@ static int crc_win_x_end_get(void *data, u64 *val)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 	spin_lock_irq(&drm_dev->event_lock);
-	*val = acrtc->dm_irq_params.window_param.roi.x_end;
+	*val = acrtc->dm_irq_params.window_param.x_end;
 	spin_unlock_irq(&drm_dev->event_lock);
 
 	return 0;
@@ -3209,7 +3209,7 @@ static int crc_win_y_end_set(void *data, u64 val)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 	spin_lock_irq(&drm_dev->event_lock);
-	acrtc->dm_irq_params.window_param.roi.y_end = (uint16_t) val;
+	acrtc->dm_irq_params.window_param.y_end = (uint16_t) val;
 	acrtc->dm_irq_params.window_param.update_win = false;
 	spin_unlock_irq(&drm_dev->event_lock);
 
@@ -3226,7 +3226,7 @@ static int crc_win_y_end_get(void *data, u64 *val)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
 	spin_lock_irq(&drm_dev->event_lock);
-	*val = acrtc->dm_irq_params.window_param.roi.y_end;
+	*val = acrtc->dm_irq_params.window_param.y_end;
 	spin_unlock_irq(&drm_dev->event_lock);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 58352de24061..20c16ca935f7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -493,7 +493,7 @@ bool dc_stream_get_crtc_position(struct dc *dc,
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 static inline void
 dc_stream_forward_dmub_crc_window(struct dc_dmub_srv *dmub_srv,
-		struct crc_region *roi, struct otg_phy_mux *mux_mapping, bool is_stop)
+		struct rect *rect, struct otg_phy_mux *mux_mapping, bool is_stop)
 {
 	union dmub_rb_cmd cmd = {0};
 
@@ -506,10 +506,10 @@ dc_stream_forward_dmub_crc_window(struct dc_dmub_srv *dmub_srv,
 	} else {
 		cmd.secure_display.header.type = DMUB_CMD__SECURE_DISPLAY;
 		cmd.secure_display.header.sub_type = DMUB_CMD__SECURE_DISPLAY_CRC_WIN_NOTIFY;
-		cmd.secure_display.roi_info.x_start = roi->x_start;
-		cmd.secure_display.roi_info.y_start = roi->y_start;
-		cmd.secure_display.roi_info.x_end = roi->x_end;
-		cmd.secure_display.roi_info.y_end = roi->y_end;
+		cmd.secure_display.roi_info.x_start = rect->x;
+		cmd.secure_display.roi_info.y_start = rect->y;
+		cmd.secure_display.roi_info.x_end = rect->x + rect->width;
+		cmd.secure_display.roi_info.y_end = rect->y + rect->height;
 	}
 
 	dc_dmub_srv_cmd_queue(dmub_srv, &cmd);
@@ -518,17 +518,17 @@ dc_stream_forward_dmub_crc_window(struct dc_dmub_srv *dmub_srv,
 
 static inline void
 dc_stream_forward_dmcu_crc_window(struct dmcu *dmcu,
-		struct crc_region *roi, struct otg_phy_mux *mux_mapping, bool is_stop)
+		struct rect *rect, struct otg_phy_mux *mux_mapping, bool is_stop)
 {
 	if (is_stop)
 		dmcu->funcs->stop_crc_win_update(dmcu, mux_mapping);
 	else
-		dmcu->funcs->forward_crc_window(dmcu, roi, mux_mapping);
+		dmcu->funcs->forward_crc_window(dmcu, rect, mux_mapping);
 }
 
 bool
 dc_stream_forward_crc_window(struct dc *dc,
-		struct crc_region *roi, struct dc_stream_state *stream, bool is_stop)
+		struct rect *rect, struct dc_stream_state *stream, bool is_stop)
 {
 	struct dmcu *dmcu;
 	struct dc_dmub_srv *dmub_srv;
@@ -554,10 +554,10 @@ dc_stream_forward_crc_window(struct dc *dc,
 
 	/* forward to dmub */
 	if (dmub_srv)
-		dc_stream_forward_dmub_crc_window(dmub_srv, roi, &mux_mapping, is_stop);
+		dc_stream_forward_dmub_crc_window(dmub_srv, rect, &mux_mapping, is_stop);
 	/* forward to dmcu */
 	else if (dmcu && dmcu->funcs->is_dmcu_initialized(dmcu))
-		dc_stream_forward_dmcu_crc_window(dmcu, roi, &mux_mapping, is_stop);
+		dc_stream_forward_dmcu_crc_window(dmcu, rect, &mux_mapping, is_stop);
 	else
 		return false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 26f8f18e675c..4d30ae0ca721 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -522,7 +522,7 @@ bool dc_stream_get_crtc_position(struct dc *dc,
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 bool dc_stream_forward_crc_window(struct dc *dc,
-		struct crc_region *roi,
+		struct rect *rect,
 		struct dc_stream_state *stream,
 		bool is_stop);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 27dd4304ce69..dc78e2404b48 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -994,13 +994,6 @@ struct display_endpoint_id {
 };
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-struct crc_region {
-	uint16_t x_start;
-	uint16_t y_start;
-	uint16_t x_end;
-	uint16_t y_end;
-};
-
 struct otg_phy_mux {
 	uint8_t phy_output_num;
 	uint8_t otg_output_num;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index fbb19e253f50..d3cc5ec46956 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -927,19 +927,20 @@ static bool dcn10_recv_edid_cea_ack(struct dmcu *dmcu, int *offset)
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 static void dcn10_forward_crc_window(struct dmcu *dmcu,
-					struct crc_region *crc_win,
+					struct rect *rect,
 					struct otg_phy_mux *mux_mapping)
 {
 	struct dce_dmcu *dmcu_dce = TO_DCE_DMCU(dmcu);
 	unsigned int dmcu_max_retry_on_wait_reg_ready = 801;
 	unsigned int dmcu_wait_reg_ready_interval = 100;
 	unsigned int crc_start = 0, crc_end = 0, otg_phy_mux = 0;
+	int x_start, y_start, x_end, y_end;
 
 	/* If microcontroller is not running, do nothing */
 	if (dmcu->dmcu_state != DMCU_RUNNING)
 		return;
 
-	if (!crc_win)
+	if (!rect)
 		return;
 
 	/* waitDMCUReadyForCmd */
@@ -947,9 +948,14 @@ static void dcn10_forward_crc_window(struct dmcu *dmcu,
 				dmcu_wait_reg_ready_interval,
 				dmcu_max_retry_on_wait_reg_ready);
 
+	x_start = rect->x;
+	y_start = rect->y;
+	x_end = x_start + rect->width;
+	y_end = y_start + rect->height;
+
 	/* build up nitification data */
-	crc_start = (((unsigned int) crc_win->x_start) << 16) | crc_win->y_start;
-	crc_end = (((unsigned int) crc_win->x_end) << 16) | crc_win->y_end;
+	crc_start = (((unsigned int) x_start) << 16) | y_start;
+	crc_end = (((unsigned int) x_end) << 16) | y_end;
 	otg_phy_mux =
 		(((unsigned int) mux_mapping->otg_output_num) << 16) | mux_mapping->phy_output_num;
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h
index 9a2432608ddf..de3113ecbc77 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h
@@ -86,7 +86,7 @@ struct dmcu_funcs {
 	bool (*recv_edid_cea_ack)(struct dmcu *dmcu, int *offset);
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 	void (*forward_crc_window)(struct dmcu *dmcu,
-			struct crc_region *crc_win,
+			struct rect *rect,
 			struct otg_phy_mux *mux_mapping);
 	void (*stop_crc_win_update)(struct dmcu *dmcu,
 			struct otg_phy_mux *mux_mapping);
-- 
2.35.1

