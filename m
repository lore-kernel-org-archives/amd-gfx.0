Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5191DC33CAC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 16:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F5620838
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 16:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hmwJmNsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F5620838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 869A56FAB0;
	Thu,  6 Feb 2020 16:54:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC6E96FAB0
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 16:54:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ma3xFDFIDUGYd1dlxzfJzOAjvSmGd9pPmcxtrOaU0G/YYvvhIFeVHDTy042Dze6jiCu3HDL7rqW3zflm549QQxTIvR64bAeeACnvMfiKSNqOyAeHEMqLHNocVOrCGBca4YZXTXWbbns7jXXeNvlE81+fo3L4tHuPYlZGfkf95ZxdwsofzqQFxhFE2lfboG2Z36SGblflpc8SP3Q3b6OP0KMveFtw/u23XO3PKfa6vC1FGwLcBBGa6oIjWx1EBJClJtM14OQw1V8TtDiBQjPdO9aobH18HoNRwyheBWiCtmHo6T9f2A5pulTeuaZOlrPYP3LbL8EOEaWVPGYOIrsfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ltzoPX+8U3H3/913f7ec+3lwlQ1vhTnAxTrCvghP6Y=;
 b=flzwzCsz4slibqEexTDnD/IiYxgmr7XCGBAZ/hOuIdslGg1O98vQQfa8l4sPKX/1IDXjOLpmG4PM8XqA+VlbcosPsgwLkSGrpnvo14prPFWOXqkHIivY+VgSlaM7+tV2/MJxwJyLqun+1zaL5+npfMmBU7Zk6kJ6etNAc2tLRH0ilK12Ol/3d7EMOudf9FoRXg1CzeybbNT7UM64LMFTOSGeY0AQ9tx277qFSiPscegYqCFKb9I1UkXXvMdXmtK3qski65FYUO8lfqZeRWaa6DqozyGCBzrZ0aI+CevXYO5RKtypaziXQgLOeYveyVePmCF2Md9DfHr7xAdUMyG/yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ltzoPX+8U3H3/913f7ec+3lwlQ1vhTnAxTrCvghP6Y=;
 b=hmwJmNsNk7doEOmuWmrMPP4poHkY2M/D2TupHYYcfchnKohOQmaTvn4NwsryX80e6K3RT0lgHGqDiVC1UdNYT37HOvWjNcWdu93aXG7GcdMCxv4lcyxA+gbbny7+ZcZXIfjB1lchMP7Lb5rrzxdIWiOijVQTU2GP22cKpeJjURk=
Received: from BN4PR12CA0008.namprd12.prod.outlook.com (2603:10b6:403:2::18)
 by DM6PR12MB3804.namprd12.prod.outlook.com (2603:10b6:5:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21; Thu, 6 Feb
 2020 16:54:31 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::206) by BN4PR12CA0008.outlook.office365.com
 (2603:10b6:403:2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Thu, 6 Feb 2020 16:54:31 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 16:54:30 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Feb 2020
 10:54:29 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 6 Feb 2020 10:54:29 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Indicate use of TMZ buffers to DC
Date: Thu, 6 Feb 2020 11:54:23 -0500
Message-ID: <20200206165423.18438-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(396003)(428003)(199004)(189003)(26005)(426003)(70586007)(4326008)(186003)(316002)(6666004)(1076003)(356004)(7696005)(54906003)(36756003)(478600001)(8936002)(6916009)(2906002)(2616005)(336012)(86362001)(70206006)(8676002)(5660300002)(81166006)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3804; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e82a63ae-642a-494c-a19f-08d7ab253c53
X-MS-TrafficTypeDiagnostic: DM6PR12MB3804:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3804D673653EEB95945CBFB0F91D0@DM6PR12MB3804.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzumU7w9zir3cn3aRmR4jDKIfABaSTmjiSEk7s6oZP+5e5KJxhKCgBSqpTsniMGIIrOQt/NJ4RAvX5suPlC261H0qwyg/wU+xV8MToof8nlAzinDokjXNvJsamDdtX33ivU045PlrrdUQw8Q0MSN241yXu/n7RwPZiyySb9B2BIUKgUC4QfcY7lTTN3wAInJdmifh1cb3zQffZWOHmO+mp5pwIXybeO0mzHVqRWHOiG/gnimj4jDeNgxEq6v797TmGC3UVNKRp/zDYNgN9FTwZZRNqiprWuRl4eAeosdk58A3b7mzL6ynGqSRsBb56K1zKbmcAmDekddLzM/oKiNpmFxeDiVUqbvJLB6AThPRX5rJzmgsGYsrgeySLR7FCyDZUOkZIPC2HlltB3zs68xMknbNj3pw7kbxCNP6+6RfvWqTLZS7MsEIKWDIZsQf0Tv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 16:54:30.9577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e82a63ae-642a-494c-a19f-08d7ab253c53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3804
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[Why]
Hubp needs to know whether a buffer is being scanned out from the trusted
memory zone or not.

[How]
Check for the TMZ flag on the amdgpu_bo and set the tmz_surface flag in
dc_plane_address accordingly.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 38 +++++++++++++------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7f6d3b0f9efc..73000f1e1734 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3166,7 +3166,7 @@ static int fill_dc_scaling_info(const struct drm_plane_state *state,
 }
 
 static int get_fb_info(const struct amdgpu_framebuffer *amdgpu_fb,
-		       uint64_t *tiling_flags)
+		       uint64_t *tiling_flags, bool *tmz_surface)
 {
 	struct amdgpu_bo *rbo = gem_to_amdgpu_bo(amdgpu_fb->base.obj[0]);
 	int r = amdgpu_bo_reserve(rbo, false);
@@ -3181,6 +3181,9 @@ static int get_fb_info(const struct amdgpu_framebuffer *amdgpu_fb,
 	if (tiling_flags)
 		amdgpu_bo_get_tiling_flags(rbo, tiling_flags);
 
+	if (tmz_surface)
+		*tmz_surface = amdgpu_bo_encrypted(rbo);
+
 	amdgpu_bo_unreserve(rbo);
 
 	return r;
@@ -3263,7 +3266,8 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
 			     union dc_tiling_info *tiling_info,
 			     struct plane_size *plane_size,
 			     struct dc_plane_dcc_param *dcc,
-			     struct dc_plane_address *address)
+			     struct dc_plane_address *address,
+			     bool tmz_surface)
 {
 	const struct drm_framebuffer *fb = &afb->base;
 	int ret;
@@ -3273,6 +3277,8 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
 	memset(dcc, 0, sizeof(*dcc));
 	memset(address, 0, sizeof(*address));
 
+	address->tmz_surface = tmz_surface;
+
 	if (format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN) {
 		plane_size->surface_size.x = 0;
 		plane_size->surface_size.y = 0;
@@ -3461,7 +3467,8 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 			    const struct drm_plane_state *plane_state,
 			    const uint64_t tiling_flags,
 			    struct dc_plane_info *plane_info,
-			    struct dc_plane_address *address)
+			    struct dc_plane_address *address,
+			    bool tmz_surface)
 {
 	const struct drm_framebuffer *fb = plane_state->fb;
 	const struct amdgpu_framebuffer *afb =
@@ -3540,7 +3547,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 					   plane_info->rotation, tiling_flags,
 					   &plane_info->tiling_info,
 					   &plane_info->plane_size,
-					   &plane_info->dcc, address);
+					   &plane_info->dcc, address, tmz_surface);
 	if (ret)
 		return ret;
 
@@ -3563,6 +3570,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	struct dc_plane_info plane_info;
 	uint64_t tiling_flags;
 	int ret;
+	bool tmz_surface = false;
 
 	ret = fill_dc_scaling_info(plane_state, &scaling_info);
 	if (ret)
@@ -3573,13 +3581,14 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	dc_plane_state->clip_rect = scaling_info.clip_rect;
 	dc_plane_state->scaling_quality = scaling_info.scaling_quality;
 
-	ret = get_fb_info(amdgpu_fb, &tiling_flags);
+	ret = get_fb_info(amdgpu_fb, &tiling_flags, &tmz_surface);
 	if (ret)
 		return ret;
 
 	ret = fill_dc_plane_info_and_addr(adev, plane_state, tiling_flags,
 					  &plane_info,
-					  &dc_plane_state->address);
+					  &dc_plane_state->address,
+					  tmz_surface);
 	if (ret)
 		return ret;
 
@@ -5174,6 +5183,7 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	uint64_t tiling_flags;
 	uint32_t domain;
 	int r;
+	bool tmz_surface = false;
 
 	dm_plane_state_old = to_dm_plane_state(plane->state);
 	dm_plane_state_new = to_dm_plane_state(new_state);
@@ -5222,6 +5232,8 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
 
 	amdgpu_bo_get_tiling_flags(rbo, &tiling_flags);
 
+	tmz_surface = amdgpu_bo_encrypted(rbo);
+
 	ttm_eu_backoff_reservation(&ticket, &list);
 
 	afb->address = amdgpu_bo_gpu_offset(rbo);
@@ -5236,7 +5248,7 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
 			adev, afb, plane_state->format, plane_state->rotation,
 			tiling_flags, &plane_state->tiling_info,
 			&plane_state->plane_size, &plane_state->dcc,
-			&plane_state->address);
+			&plane_state->address, tmz_surface);
 	}
 
 	return 0;
@@ -6417,6 +6429,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	unsigned long flags;
 	struct amdgpu_bo *abo;
 	uint64_t tiling_flags;
+	bool tmz_surface = false;
 	uint32_t target_vblank, last_flip_vblank;
 	bool vrr_active = amdgpu_dm_vrr_active(acrtc_state);
 	bool pflip_present = false;
@@ -6515,12 +6528,14 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 
 		amdgpu_bo_get_tiling_flags(abo, &tiling_flags);
 
+		tmz_surface = amdgpu_bo_encrypted(abo);
+
 		amdgpu_bo_unreserve(abo);
 
 		fill_dc_plane_info_and_addr(
 			dm->adev, new_plane_state, tiling_flags,
 			&bundle->plane_infos[planes_count],
-			&bundle->flip_addrs[planes_count].address);
+			&bundle->flip_addrs[planes_count].address, tmz_surface);
 
 		bundle->surface_updates[planes_count].plane_info =
 			&bundle->plane_infos[planes_count];
@@ -7889,6 +7904,7 @@ dm_determine_update_type_for_commit(struct amdgpu_display_manager *dm,
 			struct dc_flip_addrs *flip_addr = &bundle->flip_addrs[num_plane];
 			struct dc_scaling_info *scaling_info = &bundle->scaling_infos[num_plane];
 			uint64_t tiling_flags;
+			bool tmz_surface = false;
 
 			new_plane_crtc = new_plane_state->crtc;
 			new_dm_plane_state = to_dm_plane_state(new_plane_state);
@@ -7934,14 +7950,14 @@ dm_determine_update_type_for_commit(struct amdgpu_display_manager *dm,
 			bundle->surface_updates[num_plane].scaling_info = scaling_info;
 
 			if (amdgpu_fb) {
-				ret = get_fb_info(amdgpu_fb, &tiling_flags);
+				ret = get_fb_info(amdgpu_fb, &tiling_flags, &tmz_surface);
 				if (ret)
 					goto cleanup;
 
 				ret = fill_dc_plane_info_and_addr(
 					dm->adev, new_plane_state, tiling_flags,
-					plane_info,
-					&flip_addr->address);
+					&plane_info,
+					&flip_addr.address, tmz_surface);
 				if (ret)
 					goto cleanup;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
