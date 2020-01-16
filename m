Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6EDC33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A352077B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i5Z03jzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A352077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5994E6E484;
	Thu, 16 Jan 2020 20:14:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B34576E484
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZroMCYkvSRgtz032xiCLLOIJ425ucMrjA49F1+npZOyneQtGdiflT+Hi5gpzs3yHq+SycTNrRKdmdoENJOlHRL0MHvio/5e03qS/tyXpwNXpabvtGdqoK5aNLWhT07hHEiVbpAHFQLZZTTVQ1tkbts+Fs2xHjAsBWWEtl6nROUweoTAxirMlQ8Cf77m2wnNatgWNtW40oLRZJamwLfejIsCk0kaaxwuYVZVhIPehn8WlSAeSo7uqAhUqOJUWuGIA6Fl/tZ4lK9A/Deoqqlh3qoGcZ3PE3nK26V8waIabasVCSJQXaVPl0PT+aD9mMIq9H/Xi0nUsWslXWeENOw7fSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/gxcMs4ejFFFw2/LQHh49xjGW9/Oqt/GfhjYiM+En4=;
 b=GcVs2NC0wvG1vXQYPfxTrqcBxf0YVyVIV8EtZXjoHxgCp7QPYSP2yTVfVHH6+sMDAct9d2Mr8C53t7hdPXH4mbtP5+VgiN8DGVzX+C33KTaBcBHYhSYhaQ7qvMhPIHRsm2zMbHVnwqBMW5PpTod08FKGGrQwBlkt9gMfzBraLq7Vo8F+XJjjyDXvaOrJb8c/E/65gFRUcqEARPhXoed8revXacUXsk6flD68VuEbI9AVDf9+FCWOTRS7juBbijlG0NsfF34w6kcZvlh2T79NeldWc9Hgyw+5Xzx8NB/wV7I6yVeURvxs+1EoHIbh8f9Ps5HmdyBXBCNtLG1Vjfrkbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/gxcMs4ejFFFw2/LQHh49xjGW9/Oqt/GfhjYiM+En4=;
 b=i5Z03jzgHKQgyo2+xuerc+5aBJRUdYMLWGtqxwzGlvkKbxOC0zM8HfdzSkX1IidLdJ3g5QD/GvjYGCHnmfUE5C8aZ2DkY9AIldlWl5eMT0P98Rzz6xrgyp96VYXHPDWdlITfTchBLrAVoICxNMf1A4biXv3RirhC5AFGEPWal0c=
Received: from DM3PR12CA0133.namprd12.prod.outlook.com (2603:10b6:0:51::29) by
 BYAPR12MB2695.namprd12.prod.outlook.com (2603:10b6:a03:71::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.16; Thu, 16 Jan 2020 20:14:36 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::208) by DM3PR12CA0133.outlook.office365.com
 (2603:10b6:0:51::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:36 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:35 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:29 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:29 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/22] drm/amd/display: Fix update type for multiple planes
Date: Thu, 16 Jan 2020 15:14:10 -0500
Message-ID: <20200116201418.2254-15-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(376002)(428003)(199004)(189003)(81156014)(81166006)(26005)(1076003)(8676002)(54906003)(8936002)(6666004)(356004)(4326008)(186003)(2616005)(7696005)(336012)(86362001)(6916009)(36756003)(70586007)(426003)(70206006)(5660300002)(316002)(15650500001)(2906002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2695; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6183047e-1fc0-44f1-a6ca-08d79ac0b4f4
X-MS-TrafficTypeDiagnostic: BYAPR12MB2695:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2695E27F79240D724D938E60F9360@BYAPR12MB2695.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yom57oSLk0jICOsCVuib29jW3NHthUb04dU8gzmpoCSETaExhvoWY53UMs3GAgBvdHtkoPZKFhgJFMAeviWdDwQCrLDz4tE7WsObzIwhCaJvFpHVWS7nXqUZMN5w/WHDNRxlwTBJmkLkglBbWfa2vYt3tU8yA4eO9r6OMyh3G+m/+LOI3xk7gAMdIB+QA5f1fZ2XymbHmJ1EOEp6dTFU20j/qIOks+Pu0paoqboO12Hem4qRWEWGBdfh8C5EaP32rYArc5FLsF4MjYhTbrcToQllxHc+Oc6wumikm1x4m0DJine1d6cLXI6s/qH46T8yLexrgbUR1dbyhnfH1HgmmPIHuBm8hxy7GAOdEXKpV3QtVXXM8YRVBy9LK4hj41a4cJbcs7zLp5fifqOOTBUk9KHJMS3o1FEKQfefkOhizT44qpwjwiTr552YIZYOmjgh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:35.5574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6183047e-1fc0-44f1-a6ca-08d79ac0b4f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2695
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Roman Li <roman.li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
determine_update_type_for_commit() uses pointers to single instance
of local variable to fill scaling/color info for all planes updates.
This is a bug, that leads to incorrect update type for commit in case
of multiple planes per crtc.
Each plane should refer to separate scaling/color data.

[How]
Use arrays for plane properties.
Bundle all properties into a single structure to simplify memory allocation.

Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 64 ++++++++++---------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 51e51c0eda0c..eed3ed7180fd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7848,24 +7848,27 @@ dm_determine_update_type_for_commit(struct amdgpu_display_manager *dm,
 	struct drm_crtc_state *new_crtc_state, *old_crtc_state;
 	struct dm_crtc_state *new_dm_crtc_state, *old_dm_crtc_state;
 	struct dc_stream_status *status = NULL;
-
-	struct dc_surface_update *updates;
 	enum surface_update_type update_type = UPDATE_TYPE_FAST;
+	struct surface_info_bundle {
+		struct dc_surface_update surface_updates[MAX_SURFACES];
+		struct dc_plane_info plane_infos[MAX_SURFACES];
+		struct dc_scaling_info scaling_infos[MAX_SURFACES];
+		struct dc_flip_addrs flip_addrs[MAX_SURFACES];
+		struct dc_stream_update stream_update;
+	} *bundle;
 
-	updates = kcalloc(MAX_SURFACES, sizeof(*updates), GFP_KERNEL);
+	bundle = kzalloc(sizeof(*bundle), GFP_KERNEL);
 
-	if (!updates) {
-		DRM_ERROR("Failed to allocate plane updates\n");
+	if (!bundle) {
+		DRM_ERROR("Failed to allocate update bundle\n");
 		/* Set type to FULL to avoid crashing in DC*/
 		update_type = UPDATE_TYPE_FULL;
 		goto cleanup;
 	}
 
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
-		struct dc_scaling_info scaling_info;
-		struct dc_stream_update stream_update;
 
-		memset(&stream_update, 0, sizeof(stream_update));
+		memset(bundle, 0, sizeof(struct surface_info_bundle));
 
 		new_dm_crtc_state = to_dm_crtc_state(new_crtc_state);
 		old_dm_crtc_state = to_dm_crtc_state(old_crtc_state);
@@ -7882,8 +7885,9 @@ dm_determine_update_type_for_commit(struct amdgpu_display_manager *dm,
 		for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, j) {
 			const struct amdgpu_framebuffer *amdgpu_fb =
 				to_amdgpu_framebuffer(new_plane_state->fb);
-			struct dc_plane_info plane_info;
-			struct dc_flip_addrs flip_addr;
+			struct dc_plane_info *plane_info = &bundle->plane_infos[num_plane];
+			struct dc_flip_addrs *flip_addr = &bundle->flip_addrs[num_plane];
+			struct dc_scaling_info *scaling_info = &bundle->scaling_infos[num_plane];
 			uint64_t tiling_flags;
 
 			new_plane_crtc = new_plane_state->crtc;
@@ -7901,49 +7905,48 @@ dm_determine_update_type_for_commit(struct amdgpu_display_manager *dm,
 			if (crtc != new_plane_crtc)
 				continue;
 
-			updates[num_plane].surface = new_dm_plane_state->dc_state;
+			bundle->surface_updates[num_plane].surface =
+					new_dm_plane_state->dc_state;
 
 			if (new_crtc_state->mode_changed) {
-				stream_update.dst = new_dm_crtc_state->stream->dst;
-				stream_update.src = new_dm_crtc_state->stream->src;
+				bundle->stream_update.dst = new_dm_crtc_state->stream->dst;
+				bundle->stream_update.src = new_dm_crtc_state->stream->src;
 			}
 
 			if (new_crtc_state->color_mgmt_changed) {
-				updates[num_plane].gamma =
+				bundle->surface_updates[num_plane].gamma =
 						new_dm_plane_state->dc_state->gamma_correction;
-				updates[num_plane].in_transfer_func =
+				bundle->surface_updates[num_plane].in_transfer_func =
 						new_dm_plane_state->dc_state->in_transfer_func;
-				stream_update.gamut_remap =
+				bundle->stream_update.gamut_remap =
 						&new_dm_crtc_state->stream->gamut_remap_matrix;
-				stream_update.output_csc_transform =
+				bundle->stream_update.output_csc_transform =
 						&new_dm_crtc_state->stream->csc_color_matrix;
-				stream_update.out_transfer_func =
+				bundle->stream_update.out_transfer_func =
 						new_dm_crtc_state->stream->out_transfer_func;
 			}
 
 			ret = fill_dc_scaling_info(new_plane_state,
-						   &scaling_info);
+						   scaling_info);
 			if (ret)
 				goto cleanup;
 
-			updates[num_plane].scaling_info = &scaling_info;
+			bundle->surface_updates[num_plane].scaling_info = scaling_info;
 
 			if (amdgpu_fb) {
 				ret = get_fb_info(amdgpu_fb, &tiling_flags);
 				if (ret)
 					goto cleanup;
 
-				memset(&flip_addr, 0, sizeof(flip_addr));
-
 				ret = fill_dc_plane_info_and_addr(
 					dm->adev, new_plane_state, tiling_flags,
-					&plane_info,
-					&flip_addr.address);
+					plane_info,
+					&flip_addr->address);
 				if (ret)
 					goto cleanup;
 
-				updates[num_plane].plane_info = &plane_info;
-				updates[num_plane].flip_addr = &flip_addr;
+				bundle->surface_updates[num_plane].plane_info = plane_info;
+				bundle->surface_updates[num_plane].flip_addr = flip_addr;
 			}
 
 			num_plane++;
@@ -7964,14 +7967,15 @@ dm_determine_update_type_for_commit(struct amdgpu_display_manager *dm,
 
 		status = dc_stream_get_status_from_state(old_dm_state->context,
 							 new_dm_crtc_state->stream);
-		stream_update.stream = new_dm_crtc_state->stream;
+		bundle->stream_update.stream = new_dm_crtc_state->stream;
 		/*
 		 * TODO: DC modifies the surface during this call so we need
 		 * to lock here - find a way to do this without locking.
 		 */
 		mutex_lock(&dm->dc_lock);
-		update_type = dc_check_update_surfaces_for_stream(dc, updates, num_plane,
-								  &stream_update, status);
+		update_type = dc_check_update_surfaces_for_stream(
+				dc,	bundle->surface_updates, num_plane,
+				&bundle->stream_update, status);
 		mutex_unlock(&dm->dc_lock);
 
 		if (update_type > UPDATE_TYPE_MED) {
@@ -7981,7 +7985,7 @@ dm_determine_update_type_for_commit(struct amdgpu_display_manager *dm,
 	}
 
 cleanup:
-	kfree(updates);
+	kfree(bundle);
 
 	*out_type = update_type;
 	return ret;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
