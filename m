Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E256C55ABD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C055E2224A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2MXBoP+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C055E2224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F126E846;
	Fri, 13 Nov 2020 20:58:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C99B16E843
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:58:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkAJ8vTWlL+OS93eLqi2nM9/iPlG9m1pfB8jkWkh6t/dMZOi2LjHZULoWXg++sWZVjKKaCb4Lm7csHl6RZgRRc9fFg4BQx3E7RE4HHYICIJvChacQweV2zc2mBGJMHCIbzry2EMDzwfdqFK6n/8FkdjKXUrjDQZbPODz9wihcwkewiIHHEQWvNpaOMDbW7y0JafusHY22u6OVgQz2eRFkJb/7WbXBRXFinaHnaQYgh4kRyvBxmF1Mks570/WNjf4CuLy6tAQrN+DIY7c5Dq5S2uq/061YD9TdokXsBKDbGE++6TG5B3BPtXRVnz+IqRUPmyOakTmOI67o+Ru3ZgAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mo/DAwA8qS1UL1X4uPSufzPDsXMLgJ6PCFHvXFvLq+I=;
 b=XQLY9ENG+Ymjko9DsMRmGM+dk9O979yrIM3zIaKre2kqK3s5hOXF9yfW1uqLL5XYAWxF5dSQP0Y8vMs7UPnEkA+25xyR/4X6BpGIl+5p3bDXPIM37qyZx7xo0yfbLIi1Mo/b6b87gdxSn9fuWbEOKjbik9NEIIBdeijUS2BHifW4/QRmT++CIe8PfDrfTMWVLW0vs7GW+4VoQAVFlBso52Mrvcfk4rmFXE7g0gnDZeIdcJhbl+rrh6ZchBPnpaFZVX3XnMCiwQWqg0AtUahi0DYXZIaHTzE0kK6AYmuMzgDBrPkMOSXKz10r4u2Zj+XNlTE/pdZ6S9ojR9einA530w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mo/DAwA8qS1UL1X4uPSufzPDsXMLgJ6PCFHvXFvLq+I=;
 b=2MXBoP+rw8fK9ypUURAcpn8gSG8V4ekhwnyIAOYnZIzNm2XfnG67zJ1ySkQOMDsAqGqguUIEAzbukJ2lkqkRRvC93MAxp+v1hLaWqJdCFvohx2LNFQL1liWyFyL92ZyGsnkz4n0FSS2Za7tsbCGVTZGT4eXg9clkCR/AUlmwYaM=
Received: from MW4PR03CA0344.namprd03.prod.outlook.com (2603:10b6:303:dc::19)
 by BYAPR12MB2997.namprd12.prod.outlook.com (2603:10b6:a03:db::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Fri, 13 Nov
 2020 20:58:10 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::58) by MW4PR03CA0344.outlook.office365.com
 (2603:10b6:303:dc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Fri, 13 Nov 2020 20:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 13 Nov 2020 20:58:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:58:08 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:58:08 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 13 Nov 2020 14:58:07 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/17] drm/amd/display: Expose new CRC window property
Date: Fri, 13 Nov 2020 15:56:41 -0500
Message-ID: <20201113205645.640981-14-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113205645.640981-1-bindu.r@amd.com>
References: <20201113205645.640981-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a68741fb-fb57-448a-6d37-08d88816d3c7
X-MS-TrafficTypeDiagnostic: BYAPR12MB2997:
X-Microsoft-Antispam-PRVS: <BYAPR12MB299761A5A9461CB69556F7B5F5E60@BYAPR12MB2997.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aNbMXM03u+Q8RMEJdXDW5O6sOqj8KJtGw6puJWRtdjcxQ1urz84vbuzpRqivzXN2E4DhPX6ISWM4k3hV9GVjgIdsX/aKJHmh/x4krLfRWBGLJqLprrRD7MX6uIgVsoYr7YvvbuHIbFvN+X6fOvCR0KQ/Cj8CQfHrraIBxN+AbCEDrws0SgoQ7Ue6fyCkqwul5neBjHFS8uZa8Mfg4PJQZdWY+P4p/S2VkEIJ75Jh8Nv/x/+WdCavJgrmuLlyRBncimQJbk/Fa90QkKgganSsrsX4R36rqFz5pkS9Ypa3UHsINb6F8y2a9ybn1CAP0PHMHEABC4T2ut9TKQ1MsuCxojy+/K+oslwCdLnXz15fODCOF28OYveLlw6UHU4RC4q4vcBs9hyc2k5ao1oTBtIbRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966005)(2616005)(1076003)(336012)(8676002)(2906002)(478600001)(70586007)(7696005)(6666004)(82310400003)(30864003)(316002)(6916009)(26005)(86362001)(36756003)(83380400001)(186003)(5660300002)(4326008)(356005)(426003)(82740400003)(70206006)(8936002)(81166007)(54906003)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 20:58:09.5036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a68741fb-fb57-448a-6d37-08d88816d3c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2997
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Instead of calculating CRC on whole frame, add flexibility to calculate
CRC on specific frame region.

[How]
Add few crc window coordinate properties. By default, CRC is calculated
on whole frame unless user space specifies the CRC calculation window.

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 142 +++++++++++++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  19 +++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  43 +++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |   3 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   3 +
 5 files changed, 201 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 77c06f999040..f81c49f28bc9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -943,6 +943,41 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 }
 #endif
 
+#ifdef CONFIG_DEBUG_FS
+static int create_crtc_crc_properties(struct amdgpu_display_manager *dm)
+{
+	dm->crc_win_x_start_property =
+		drm_property_create_range(adev_to_drm(dm->adev),
+					  DRM_MODE_PROP_ATOMIC,
+					  "AMD_CRC_WIN_X_START", 0, U16_MAX);
+	if (!dm->crc_win_x_start_property)
+		return -ENOMEM;
+
+	dm->crc_win_y_start_property =
+		drm_property_create_range(adev_to_drm(dm->adev),
+					  DRM_MODE_PROP_ATOMIC,
+					  "AMD_CRC_WIN_Y_START", 0, U16_MAX);
+	if (!dm->crc_win_y_start_property)
+		return -ENOMEM;
+
+	dm->crc_win_x_end_property =
+		drm_property_create_range(adev_to_drm(dm->adev),
+					  DRM_MODE_PROP_ATOMIC,
+					  "AMD_CRC_WIN_X_END", 0, U16_MAX);
+	if (!dm->crc_win_x_end_property)
+		return -ENOMEM;
+
+	dm->crc_win_y_end_property =
+		drm_property_create_range(adev_to_drm(dm->adev),
+					  DRM_MODE_PROP_ATOMIC,
+					  "AMD_CRC_WIN_Y_END", 0, U16_MAX);
+	if (!dm->crc_win_y_end_property)
+		return -ENOMEM;
+
+	return 0;
+}
+#endif
+
 static int amdgpu_dm_init(struct amdgpu_device *adev)
 {
 	struct dc_init_data init_data;
@@ -1084,6 +1119,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 		dc_init_callbacks(adev->dm.dc, &init_params);
 	}
+#endif
+#ifdef CONFIG_DEBUG_FS
+	if (create_crtc_crc_properties(&adev->dm))
+		DRM_ERROR("amdgpu: failed to create crc property.\n");
 #endif
 	if (amdgpu_dm_initialize_drm_device(adev)) {
 		DRM_ERROR(
@@ -5409,12 +5448,64 @@ dm_crtc_duplicate_state(struct drm_crtc *crtc)
 	state->crc_src = cur->crc_src;
 	state->cm_has_degamma = cur->cm_has_degamma;
 	state->cm_is_degamma_srgb = cur->cm_is_degamma_srgb;
-
+#ifdef CONFIG_DEBUG_FS
+	state->crc_window = cur->crc_window;
+#endif
 	/* TODO Duplicate dc_stream after objects are stream object is flattened */
 
 	return &state->base;
 }
 
+#ifdef CONFIG_DEBUG_FS
+int amdgpu_dm_crtc_atomic_set_property(struct drm_crtc *crtc,
+					    struct drm_crtc_state *crtc_state,
+					    struct drm_property *property,
+					    uint64_t val)
+{
+	struct drm_device *dev = crtc->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct dm_crtc_state *dm_new_state =
+		to_dm_crtc_state(crtc_state);
+
+	if (property == adev->dm.crc_win_x_start_property)
+		dm_new_state->crc_window.x_start = val;
+	else if (property == adev->dm.crc_win_y_start_property)
+		dm_new_state->crc_window.y_start = val;
+	else if (property == adev->dm.crc_win_x_end_property)
+		dm_new_state->crc_window.x_end = val;
+	else if (property == adev->dm.crc_win_y_end_property)
+		dm_new_state->crc_window.y_end = val;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+int amdgpu_dm_crtc_atomic_get_property(struct drm_crtc *crtc,
+					    const struct drm_crtc_state *state,
+					    struct drm_property *property,
+					    uint64_t *val)
+{
+	struct drm_device *dev = crtc->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct dm_crtc_state *dm_state =
+		to_dm_crtc_state(state);
+
+	if (property == adev->dm.crc_win_x_start_property)
+		*val = dm_state->crc_window.x_start;
+	else if (property == adev->dm.crc_win_y_start_property)
+		*val = dm_state->crc_window.y_start;
+	else if (property == adev->dm.crc_win_x_end_property)
+		*val = dm_state->crc_window.x_end;
+	else if (property == adev->dm.crc_win_y_end_property)
+		*val = dm_state->crc_window.y_end;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+#endif
+
 static inline int dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
 {
 	enum dc_irq_source irq_source;
@@ -5481,6 +5572,10 @@ static const struct drm_crtc_funcs amdgpu_dm_crtc_funcs = {
 	.enable_vblank = dm_enable_vblank,
 	.disable_vblank = dm_disable_vblank,
 	.get_vblank_timestamp = drm_crtc_vblank_helper_get_vblank_timestamp,
+#ifdef CONFIG_DEBUG_FS
+	.atomic_set_property = amdgpu_dm_crtc_atomic_set_property,
+	.atomic_get_property = amdgpu_dm_crtc_atomic_get_property,
+#endif
 };
 
 static enum drm_connector_status
@@ -6689,6 +6784,25 @@ static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	return 0;
 }
 
+#ifdef CONFIG_DEBUG_FS
+static void attach_crtc_crc_properties(struct amdgpu_display_manager *dm,
+				struct amdgpu_crtc *acrtc)
+{
+	drm_object_attach_property(&acrtc->base.base,
+				   dm->crc_win_x_start_property,
+				   0);
+	drm_object_attach_property(&acrtc->base.base,
+				   dm->crc_win_y_start_property,
+				   0);
+	drm_object_attach_property(&acrtc->base.base,
+				   dm->crc_win_x_end_property,
+				   0);
+	drm_object_attach_property(&acrtc->base.base,
+				   dm->crc_win_y_end_property,
+				   0);
+}
+#endif
+
 static int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 			       struct drm_plane *plane,
 			       uint32_t crtc_index)
@@ -6736,7 +6850,9 @@ static int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 	drm_crtc_enable_color_mgmt(&acrtc->base, MAX_COLOR_LUT_ENTRIES,
 				   true, MAX_COLOR_LUT_ENTRIES);
 	drm_mode_crtc_set_gamma_size(&acrtc->base, MAX_COLOR_LEGACY_LUT_ENTRIES);
-
+#ifdef CONFIG_DEBUG_FS
+	attach_crtc_crc_properties(dm, acrtc);
+#endif
 	return 0;
 
 fail:
@@ -8363,6 +8479,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	 */
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
+		bool configure_crc = false;
 
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 
@@ -8372,21 +8489,30 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			dc_stream_retain(dm_new_crtc_state->stream);
 			acrtc->dm_irq_params.stream = dm_new_crtc_state->stream;
 			manage_dm_interrupts(adev, acrtc, true);
-
+		}
 #ifdef CONFIG_DEBUG_FS
+		if (new_crtc_state->active &&
+			amdgpu_dm_is_valid_crc_source(dm_new_crtc_state->crc_src)) {
 			/**
 			 * Frontend may have changed so reapply the CRC capture
 			 * settings for the stream.
 			 */
 			dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+			dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
-			if (amdgpu_dm_is_valid_crc_source(dm_new_crtc_state->crc_src)) {
-				amdgpu_dm_crtc_configure_crc_source(
-					crtc, dm_new_crtc_state,
-					dm_new_crtc_state->crc_src);
+			if (amdgpu_dm_crc_window_is_default(dm_new_crtc_state)) {
+				if (!old_crtc_state->active || drm_atomic_crtc_needs_modeset(new_crtc_state))
+					configure_crc = true;
+			} else {
+				if (amdgpu_dm_crc_window_changed(dm_new_crtc_state, dm_old_crtc_state))
+					configure_crc = true;
 			}
-#endif
+
+			if (configure_crc)
+				amdgpu_dm_crtc_configure_crc_source(
+					crtc, dm_new_crtc_state, dm_new_crtc_state->crc_src);
 		}
+#endif
 	}
 
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, j)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 963a69877455..f2aebbe4d140 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -336,6 +336,13 @@ struct amdgpu_display_manager {
 	 */
 	const struct gpu_info_soc_bounding_box_v1_0 *soc_bounding_box;
 
+#ifdef CONFIG_DEBUG_FS
+	/* set the crc calculation window*/
+	struct drm_property *crc_win_x_start_property;
+	struct drm_property *crc_win_y_start_property;
+	struct drm_property *crc_win_x_end_property;
+	struct drm_property *crc_win_y_end_property;
+#endif
 	/**
 	 * @mst_encoders:
 	 *
@@ -422,6 +429,15 @@ struct dm_plane_state {
 	struct dc_plane_state *dc_state;
 };
 
+#ifdef CONFIG_DEBUG_FS
+struct crc_rec {
+	uint16_t x_start;
+	uint16_t y_start;
+	uint16_t x_end;
+	uint16_t y_end;
+	};
+#endif
+
 struct dm_crtc_state {
 	struct drm_crtc_state base;
 	struct dc_stream_state *stream;
@@ -444,6 +460,9 @@ struct dm_crtc_state {
 	struct dc_info_packet vrr_infopacket;
 
 	int abm_level;
+#ifdef CONFIG_DEBUG_FS
+	struct crc_rec crc_window;
+#endif
 };
 
 #define to_dm_crtc_state(x) container_of(x, struct dm_crtc_state, base)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index c29dc11619f7..ff6db26626ea 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -81,6 +81,33 @@ const char *const *amdgpu_dm_crtc_get_crc_sources(struct drm_crtc *crtc,
 	return pipe_crc_sources;
 }
 
+bool amdgpu_dm_crc_window_is_default(struct dm_crtc_state *dm_crtc_state)
+{
+	bool ret = true;
+
+	if ((dm_crtc_state->crc_window.x_start != 0) ||
+		(dm_crtc_state->crc_window.y_start != 0) ||
+		(dm_crtc_state->crc_window.x_end != 0) ||
+		(dm_crtc_state->crc_window.y_end != 0))
+		ret = false;
+
+	return ret;
+}
+
+bool amdgpu_dm_crc_window_changed(struct dm_crtc_state *dm_new_crtc_state,
+					struct dm_crtc_state *dm_old_crtc_state)
+{
+	bool ret = false;
+
+	if ((dm_new_crtc_state->crc_window.x_start != dm_old_crtc_state->crc_window.x_start) ||
+		(dm_new_crtc_state->crc_window.y_start != dm_old_crtc_state->crc_window.y_start) ||
+		(dm_new_crtc_state->crc_window.x_end != dm_old_crtc_state->crc_window.x_end) ||
+		(dm_new_crtc_state->crc_window.y_end != dm_old_crtc_state->crc_window.y_end))
+		ret = true;
+
+	return ret;
+}
+
 int
 amdgpu_dm_crtc_verify_crc_source(struct drm_crtc *crtc, const char *src_name,
 				 size_t *values_cnt)
@@ -105,6 +132,7 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 	struct dc_stream_state *stream_state = dm_crtc_state->stream;
 	bool enable = amdgpu_dm_is_valid_crc_source(source);
 	int ret = 0;
+	struct crc_params *crc_window = NULL, tmp_window;
 
 	/* Configuration will be deferred to stream enable. */
 	if (!stream_state)
@@ -114,8 +142,21 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 
 	/* Enable CRTC CRC generation if necessary. */
 	if (dm_is_crc_source_crtc(source)) {
+		if (!amdgpu_dm_crc_window_is_default(dm_crtc_state)) {
+			crc_window = &tmp_window;
+
+			tmp_window.windowa_x_start = dm_crtc_state->crc_window.x_start;
+			tmp_window.windowa_y_start = dm_crtc_state->crc_window.y_start;
+			tmp_window.windowa_x_end = dm_crtc_state->crc_window.x_end;
+			tmp_window.windowa_y_end = dm_crtc_state->crc_window.y_end;
+			tmp_window.windowb_x_start = dm_crtc_state->crc_window.x_start;
+			tmp_window.windowb_y_start = dm_crtc_state->crc_window.y_start;
+			tmp_window.windowb_x_end = dm_crtc_state->crc_window.x_end;
+			tmp_window.windowb_y_end = dm_crtc_state->crc_window.y_end;
+		}
+
 		if (!dc_stream_configure_crc(stream_state->ctx->dc,
-					     stream_state, NULL, enable, enable)) {
+					     stream_state, crc_window, enable, enable)) {
 			ret = -EINVAL;
 			goto unlock;
 		}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
index f7d731797d3f..0235bfb246e5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
@@ -47,6 +47,9 @@ static inline bool amdgpu_dm_is_valid_crc_source(enum amdgpu_dm_pipe_crc_source
 
 /* amdgpu_dm_crc.c */
 #ifdef CONFIG_DEBUG_FS
+bool amdgpu_dm_crc_window_is_default(struct dm_crtc_state *dm_crtc_state);
+bool amdgpu_dm_crc_window_changed(struct dm_crtc_state *dm_new_crtc_state,
+					struct dm_crtc_state *dm_old_crtc_state);
 int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 					struct dm_crtc_state *dm_crtc_state,
 					enum amdgpu_dm_pipe_crc_source source);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index f522b664d3c6..5790affc7d61 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3259,6 +3259,9 @@ void core_link_enable_stream(
 			}
 		}
 
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+#endif
+
 		dc->hwss.enable_audio_stream(pipe_ctx);
 
 		/* turn off otg test pattern if enable */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
