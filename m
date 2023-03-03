Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13491C7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE0D10E6D0;
	Fri,  3 Mar 2023 15:46:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16E6010E6D0
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3piewAFk2Lv7ieBSxoVh4kfAHZprapEewcJyORIMipZ33bNi+eCqPRRnpKo9IV5Ij+LWmve4W0Xmrf9RnKY11zJu7OFp7P9/zlm9wDe9ugSR5WeAFQHhzn6d8pXIRlNGbrvsRqIKGiQlZx12VaUsjEP/h72M+0Ne5ETZv76/GOW1AO7zokA7CKdGU6Xp00Su08anfuBhEyRnDHn0JlH1F/AB0cNjhlTjF0yb+yhXAAq+HIrfouqd172M2Epb2n6b57eyEIJQM754PZOQsjUGaw2j/l0UMepiPtEnM597QE2S67N0WlTGy0r5zxzpZXPeypM2PJ0pOxOhT01H33mGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owEA8sQe5dZQA0l5pohBAnQPeF+Y6Q+yRjv1U9zxq0s=;
 b=Njyfl2F4rEJeA6MEuX5/y8xsfc+00ra+qzuHzXioaqm8UQNlX2T/+43gBt05T8+YRqSR4HwFSEg8E1hqB546kXgH9QvdP/n48Tlmc43fX1SMOKhRX7g2yMRWhWCjy8693FoD5aVyluCcHq6PwvXgDTm54xQM/EInzvU3VyXr3NnOUVPSGuAApF/9N6X2WlryVbP5TO2R3kyhSZdy9LpRmdv5x5LbdSoXVDABiRpVCSPZCmhlgi0PRk8PGLlsOzhEeu7zjoOjgCDj0dXoncPi/t+pIPVVvCCAqbi89upj2DqjCL3souJwx8t61eVTHn1MZdZ+YuxTNV9tucipxej3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owEA8sQe5dZQA0l5pohBAnQPeF+Y6Q+yRjv1U9zxq0s=;
 b=MrwpXAw2QmEDQPMa6XncLm0ceoI0ONoB8btVIKYuxAFrhm83YiX+wmKpc63M2Pu3csnnSJWMPORz3/52Pe0unE96dnCxBn1vKlw99LlBVocTBfjBJTGkPFHLVHhwA0eW3Ng9SxHFhAx2ckyR72YOIpOywom69DvN6qUqhEBanZM=
Received: from MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::11)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.18; Fri, 3 Mar 2023 15:46:11 +0000
Received: from CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::7e) by MW4P220CA0006.outlook.office365.com
 (2603:10b6:303:115::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:46:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT103.mail.protection.outlook.com (10.13.174.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.20 via Frontend Transport; Fri, 3 Mar 2023 15:46:10 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:45:44 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/33] drm/amd/display: Drop CONFIG_DRM_AMD_DC_HDR
Date: Fri, 3 Mar 2023 10:39:56 -0500
Message-ID: <20230303154022.2667-8-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT103:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: aea10335-2bf7-4910-0d99-08db1bfe697c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYaZlnid2XgUjNditBa97gQxUNmARCv3xJ+uBdqBVpHlv5he8kwKkkTl+SrSclD1KEWAQJ4G9LwqXttDKSnU9UTXDTJ/6PWod8et/dJ5Q+BbLBmgDKsGk+ENA1hp+vv61f80omO47muv37WXUGBe18pdyOEwlHIBKCenmQfSquOzOdiHh+FOy9pydktZG6UhHYos7i6WoRp2Wi0rJNWegKIGE0B3JCODp9z7c50UJpAx/mRvVULkBshkkFLJG1GvXQBYnXbgek4bRr1etWOll15oYdT3ChkWdtmyQ8mxMR4jxdPgZmm9oxjB49y6T0I21ZLgz7xQWE1e/TuNoaZRMedWKcrQpOSCEJnLv465NlgIArA3HVBIsaKZTbgMhU+6Bta+4LAY2/nPXbhe/lgJ4LrmMqiCjeeA9Fa0zqLRQKIb57+AApn9VV3nBAsQ5pXD3hi0DaUVDYhs/f6uxWmRXnkLOmG/AIAfd8jskwDjYx/Q3HLLolfY3LlceVbp65u/HlsMo4NWfClr1tc5+Wq/nPHgB8ov6SuYCKlQ2Xs1rsZqliEIyVOXR6qwY1wc4r6LPFpA/OU7ihfNofHq3b0Ly8t5FNxq+cHYIdw+QnyW4MxuPBhpkY9/GzzeAfHrYFlxhXaTC2Kp2YFXMqsiBBPCwYUiv/UQnNHDuADSD5+svJNQPElOkBSiKMPuWhL6k3DUFpFUFsfV2tIPvI5KC4r6ICV0FJORAyq4279mxbpVSMs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(2906002)(70586007)(70206006)(316002)(82310400005)(8676002)(44832011)(40480700001)(6916009)(36756003)(41300700001)(8936002)(4326008)(2616005)(426003)(83380400001)(336012)(47076005)(6666004)(186003)(478600001)(16526019)(40460700003)(356005)(54906003)(1076003)(36860700001)(81166007)(82740400003)(86362001)(26005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:46:10.6875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aea10335-2bf7-4910-0d99-08db1bfe697c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[Why & How]
Remove dead code.

Reviewed-by: Sun peng Li <Sunpeng.Li@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 129 ------------------
 1 file changed, 129 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 28fb1f02591a..a8d6b06cee95 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -741,24 +741,6 @@ static int get_plane_formats(const struct drm_plane *plane,
 	return num_formats;
 }
 
-#ifdef CONFIG_DRM_AMD_DC_HDR
-static int attach_color_mgmt_properties(struct amdgpu_display_manager *dm, struct drm_plane *plane)
-{
-	drm_object_attach_property(&plane->base,
-				   dm->degamma_lut_property,
-				   0);
-	drm_object_attach_property(&plane->base,
-				   dm->degamma_lut_size_property,
-				   MAX_COLOR_LUT_ENTRIES);
-	drm_object_attach_property(&plane->base, dm->ctm_property,
-				   0);
-	drm_object_attach_property(&plane->base, dm->sdr_boost_property,
-				   DEFAULT_SDR_BOOST);
-
-	return 0;
-}
-#endif
-
 int fill_plane_buffer_attributes(struct amdgpu_device *adev,
 			     const struct amdgpu_framebuffer *afb,
 			     const enum surface_pixel_format format,
@@ -1337,10 +1319,6 @@ static void dm_drm_plane_reset(struct drm_plane *plane)
 
 	if (amdgpu_state)
 		__drm_atomic_helper_plane_reset(plane, &amdgpu_state->base);
-#ifdef CONFIG_DRM_AMD_DC_HDR
-	if (amdgpu_state)
-		amdgpu_state->sdr_boost = DEFAULT_SDR_BOOST;
-#endif
 }
 
 static struct drm_plane_state *
@@ -1360,15 +1338,6 @@ dm_drm_plane_duplicate_state(struct drm_plane *plane)
 		dc_plane_state_retain(dm_plane_state->dc_state);
 	}
 
-#ifdef CONFIG_DRM_AMD_DC_HDR
-	if (dm_plane_state->degamma_lut)
-		drm_property_blob_get(dm_plane_state->degamma_lut);
-	if (dm_plane_state->ctm)
-		drm_property_blob_get(dm_plane_state->ctm);
-
-	dm_plane_state->sdr_boost = old_dm_plane_state->sdr_boost;
-#endif
-
 	return &dm_plane_state->base;
 }
 
@@ -1436,103 +1405,12 @@ static void dm_drm_plane_destroy_state(struct drm_plane *plane,
 {
 	struct dm_plane_state *dm_plane_state = to_dm_plane_state(state);
 
-#ifdef CONFIG_DRM_AMD_DC_HDR
-	drm_property_blob_put(dm_plane_state->degamma_lut);
-	drm_property_blob_put(dm_plane_state->ctm);
-#endif
 	if (dm_plane_state->dc_state)
 		dc_plane_state_release(dm_plane_state->dc_state);
 
 	drm_atomic_helper_plane_destroy_state(plane, state);
 }
 
-#ifdef CONFIG_DRM_AMD_DC_HDR
-/* copied from drm_atomic_uapi.c */
-static int atomic_replace_property_blob_from_id(struct drm_device *dev,
-					 struct drm_property_blob **blob,
-					 uint64_t blob_id,
-					 ssize_t expected_size,
-					 ssize_t expected_elem_size,
-					 bool *replaced)
-{
-	struct drm_property_blob *new_blob = NULL;
-
-	if (blob_id != 0) {
-		new_blob = drm_property_lookup_blob(dev, blob_id);
-		if (new_blob == NULL)
-			return -EINVAL;
-
-		if (expected_size > 0 &&
-		    new_blob->length != expected_size) {
-			drm_property_blob_put(new_blob);
-			return -EINVAL;
-		}
-		if (expected_elem_size > 0 &&
-		    new_blob->length % expected_elem_size != 0) {
-			drm_property_blob_put(new_blob);
-			return -EINVAL;
-		}
-	}
-
-	*replaced |= drm_property_replace_blob(blob, new_blob);
-	drm_property_blob_put(new_blob);
-
-	return 0;
-}
-
-int dm_drm_plane_set_property(struct drm_plane *plane,
-			      struct drm_plane_state *state,
-			      struct drm_property *property,
-			      uint64_t val)
-{
-	struct amdgpu_device *adev = drm_to_adev(plane->dev);
-	struct dm_plane_state *dm_plane_state = to_dm_plane_state(state);
-	int ret = 0;
-	bool replaced;
-
-	if (property == adev->dm.degamma_lut_property) {
-		ret = atomic_replace_property_blob_from_id(adev_to_drm(adev),
-				&dm_plane_state->degamma_lut,
-				val, -1, sizeof(struct drm_color_lut),
-				&replaced);
-	} else if (property == adev->dm.ctm_property) {
-		ret = atomic_replace_property_blob_from_id(adev_to_drm(adev),
-				&dm_plane_state->ctm,
-				val,
-				sizeof(struct drm_color_ctm), -1,
-				&replaced);
-	} else if (property == adev->dm.sdr_boost_property) {
-		dm_plane_state->sdr_boost = val;
-	} else {
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
-int dm_drm_plane_get_property(struct drm_plane *plane,
-			      const struct drm_plane_state *state,
-			      struct drm_property *property,
-			      uint64_t *val)
-{
-	struct dm_plane_state *dm_plane_state = to_dm_plane_state(state);
-	struct amdgpu_device *adev = drm_to_adev(plane->dev);
-
-	if (property == adev->dm.degamma_lut_property) {
-		*val = (dm_plane_state->degamma_lut) ?
-			dm_plane_state->degamma_lut->base.id : 0;
-	} else if (property == adev->dm.ctm_property) {
-		*val = (dm_plane_state->ctm) ? dm_plane_state->ctm->base.id : 0;
-	} else if (property == adev->dm.sdr_boost_property) {
-		*val = dm_plane_state->sdr_boost;
-	} else {
-		return -EINVAL;
-	}
-
-	return 0;
-}
-#endif
-
 static const struct drm_plane_funcs dm_plane_funcs = {
 	.update_plane	= drm_atomic_helper_update_plane,
 	.disable_plane	= drm_atomic_helper_disable_plane,
@@ -1541,10 +1419,6 @@ static const struct drm_plane_funcs dm_plane_funcs = {
 	.atomic_duplicate_state = dm_drm_plane_duplicate_state,
 	.atomic_destroy_state = dm_drm_plane_destroy_state,
 	.format_mod_supported = dm_plane_format_mod_supported,
-#ifdef CONFIG_DRM_AMD_DC_HDR
-	.atomic_set_property = dm_drm_plane_set_property,
-	.atomic_get_property = dm_drm_plane_get_property,
-#endif
 };
 
 int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
@@ -1615,9 +1489,6 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 
 	drm_plane_helper_add(plane, &dm_plane_helper_funcs);
 
-#ifdef CONFIG_DRM_AMD_DC_HDR
-	attach_color_mgmt_properties(dm, plane);
-#endif
 	/* Create (reset) the plane state */
 	if (plane->funcs->reset)
 		plane->funcs->reset(plane);
-- 
2.34.1

