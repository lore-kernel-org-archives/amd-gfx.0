Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3EBC05027
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:01:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 649F910E3C5;
	Sun, 12 Feb 2023 17:00:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1859D10E302
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftobqThgY7bNiWSUee2mkpkEZyzZbXoGO1UK/v0+Q6MnWoT/59Xo1QsxrQd06O5K513V0LN2O9mcoWI5f8wler8LFMK+NvP/pBAN+dWtpcIelWzpEd+GvABqIYZMG3vWOxJlNpLReuPjrOg4tK7QjzJb0/3OPFkvifo3ii8xXU8izIrCus3VxkJlA2fv4Urz27xP+rawB1TF1vidTGa3rrHqH5h9JUtvnQkRd/VzGiND0K2dBbUseVSJinVgBdOEGqdTEAsS+E8VVUxSq3spSEJRC4/wtb8G3dG1iSKxgT5PqlZetWjOdm2TS2F5xFLU6Tu/8nwLMfBceEK1UQlvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKKmov5y/wFQupfGCZ7+HvaQ70uCatRdLJMXr7XbFe0=;
 b=Mw/Nu3In1Pp5GYjv/lnc/myjhIiK0XUV606T42DQgZAcqKihJp2MbqWw2QtQuLeeJMl8HdcUaBgELB+LF8kpOxowgKx61N/B9MmFhZLybm+9R6wiktMb54EiXTxm0c/cAOrrKivZRc29wS2nax0SiChMnwXR7eLPE4VEvxwAbfBYDMnlLlvFUMKb+84Wp4TxB+ZW5lTGaIycVGRhHqtBaEQvDMMSjhdKCuGhGCGuGWwCVH8vmj0JWQYJlwFUFl/hW7KGQ6YXI7lUS7Cxb6givPJRqN1GFem54O26C067++h8f0IHHh1G8ds0GaR6JJ2NjTCr4TkODmlJ2b0j9qvRIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKKmov5y/wFQupfGCZ7+HvaQ70uCatRdLJMXr7XbFe0=;
 b=FdA3hlfpUt8B5KycWPQTToIqi7omVBjAGF3FZ50dlGHB8eFo/WNRjZxDXTWB9UqtuQnSaIb+tg/G4s2rsVvoUTZwQWMftCakRGKq1j6LweUtAbdv1jWsK/kS/zd70ldpwvD5w65KtceG3je2k2BSrbiSdwOCGyPINX+CGYJq+xA=
Received: from DS7PR05CA0070.namprd05.prod.outlook.com (2603:10b6:8:57::28) by
 CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17; Sun, 12 Feb 2023 17:00:50 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::25) by DS7PR05CA0070.outlook.office365.com
 (2603:10b6:8:57::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.9 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:48 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:47 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/22] drm/amd/display: Add support for multiple overlay planes
Date: Sun, 12 Feb 2023 11:59:51 -0500
Message-ID: <20230212165955.1993601-19-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b737b8d-b98b-4f42-339d-08db0d1ab1e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0iL7Yt4Ej18RSMlw35GNNFnG6OU7M5hzl8z8Jtiq7TIRU+3i4+34mNjCGSUANbAnvUe3aQAr2pv4g+sSYiTckBfzd4U6gglNxSZFbzMFSYO+28uvSZJMp4YbnqqaXpBtd7+o/thFqb00MVVebadxWYXdBn/UzrHjcJdWCZEdOLURkLKoQlNLckoGfeM6mrQVjPsa3Xp0glnfWuPQRZSnCwPfkPmW9zUElCMa9wSgEXhjhEKc7Vsb7oXiHjYWEtYErF+Cys+FTBXWmFFiSyMGEVZ4k1OA3htLalmJl+8hRLr/eBOaVYuFbHzvljriPRC7ore6f94bFy9GWVcNtX5MSwxwanBKIOydbqSOJYzS4LeS7P7B9SvjbRG0oqTvBeYLeztxJN6aEolxIwzAG/dMKyLlbd1KerCAOs4iDTJIDRsglVVTagnQ0M4y1hwXmDs+HZi23bk7w0Yop437SEGVLTzLVHl8zJqKGr/BBxVuBId7Y4JHOJv986vR2xccXPigTDzNLmXz6jQWbZhL4xcncxOTkBDDiaqWbJfbwQK+N1pXL85TsnZZTK2kaqqVlUMK7dX5e3PL/+4dHoQcMnYAv3rsresfRFyBEzBNMEpKUToLnCiC1mvdzujMBNV1yLaefxOHQswQ5DaOTfLXrelv/b4kifs+BwPN28cBqNVFcPRBVFo7r5afcA0y+8XhPIRsPJbByWk2/MprAwtw4lE9cFx9rF9guiQ3lWg8hiAH8g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(186003)(316002)(83380400001)(426003)(81166007)(54906003)(47076005)(36860700001)(40480700001)(356005)(82310400005)(86362001)(82740400003)(40460700003)(26005)(1076003)(336012)(16526019)(36756003)(6666004)(478600001)(2616005)(41300700001)(5660300002)(8936002)(2906002)(70206006)(4326008)(8676002)(70586007)(44832011)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:50.7043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b737b8d-b98b-4f42-339d-08db0d1ab1e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

[Why]
We only allowed 1 overlay plane. But now some ASICS can support multiple
overlay planes.

[How]
Use max_slave_planes as the number of overlays we can support.

Also since we cannot draw cursor over a video plane, we need to make
sure that we reject commits where the topmost plane is a video plane
(overlay only).

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 25 ++++++++++++++-----
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 22 +++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |  1 +
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 922adc10894a..10699a519d33 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4250,6 +4250,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	const struct dc_plane_cap *plane;
 	bool psr_feature_enabled = false;
+	int max_overlay = dm->dc->caps.max_slave_planes;
 
 	dm->display_indexes_num = dm->dc->caps.max_streams;
 	/* Update the actual used number of crtc */
@@ -4304,14 +4305,14 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		if (!plane->pixel_format_support.argb8888)
 			continue;
 
+		if (max_overlay-- == 0)
+			break;
+
 		if (initialize_plane(dm, NULL, primary_planes + i,
 				     DRM_PLANE_TYPE_OVERLAY, plane)) {
 			DRM_ERROR("KMS: Failed to initialize overlay plane\n");
 			goto fail;
 		}
-
-		/* Only create one overlay plane. */
-		break;
 	}
 
 	for (i = 0; i < dm->dc->caps.max_streams; i++)
@@ -9505,7 +9506,8 @@ static int dm_update_plane_state(struct dc *dc,
 				 struct drm_plane_state *old_plane_state,
 				 struct drm_plane_state *new_plane_state,
 				 bool enable,
-				 bool *lock_and_validation_needed)
+				 bool *lock_and_validation_needed,
+				 bool *is_top_most_overlay)
 {
 
 	struct dm_atomic_state *dm_state = NULL;
@@ -9613,6 +9615,14 @@ static int dm_update_plane_state(struct dc *dc,
 		if (!dc_new_plane_state)
 			return -ENOMEM;
 
+		/* Block top most plane from being a video plane */
+		if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
+			if (is_video_format(new_plane_state->fb->format->format) && *is_top_most_overlay)
+				return -EINVAL;
+			else
+				*is_top_most_overlay = false;
+		}
+
 		DRM_DEBUG_ATOMIC("Enabling DRM plane: %d on DRM crtc %d\n",
 				 plane->base.id, new_plane_crtc->base.id);
 
@@ -9813,6 +9823,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	enum dc_status status;
 	int ret, i;
 	bool lock_and_validation_needed = false;
+	bool is_top_most_overlay = true;
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct dsc_mst_fairness_vars vars[MAX_PIPES];
@@ -9945,7 +9956,8 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 					    old_plane_state,
 					    new_plane_state,
 					    false,
-					    &lock_and_validation_needed);
+					    &lock_and_validation_needed,
+					    &is_top_most_overlay);
 		if (ret) {
 			DRM_DEBUG_DRIVER("dm_update_plane_state() failed\n");
 			goto fail;
@@ -9984,7 +9996,8 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 					    old_plane_state,
 					    new_plane_state,
 					    true,
-					    &lock_and_validation_needed);
+					    &lock_and_validation_needed,
+					    &is_top_most_overlay);
 		if (ret) {
 			DRM_DEBUG_DRIVER("dm_update_plane_state() failed\n");
 			goto fail;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 3c50b3ff7954..28fb1f02591a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -67,7 +67,16 @@ static const uint32_t overlay_formats[] = {
 	DRM_FORMAT_RGBA8888,
 	DRM_FORMAT_XBGR8888,
 	DRM_FORMAT_ABGR8888,
-	DRM_FORMAT_RGB565
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_NV21,
+	DRM_FORMAT_NV12,
+	DRM_FORMAT_P010
+};
+
+static const uint32_t video_formats[] = {
+	DRM_FORMAT_NV21,
+	DRM_FORMAT_NV12,
+	DRM_FORMAT_P010
 };
 
 static const u32 cursor_formats[] = {
@@ -1616,3 +1625,14 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	return 0;
 }
 
+bool is_video_format(uint32_t format)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(video_formats); i++)
+		if (format == video_formats[i])
+			return true;
+
+	return false;
+}
+
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index 286981a2dd40..a4bee8528a51 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -62,4 +62,5 @@ void fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
 				    bool *per_pixel_alpha, bool *pre_multiplied_alpha,
 				    bool *global_alpha, int *global_alpha_value);
 
+bool is_video_format(uint32_t format);
 #endif
-- 
2.25.1

