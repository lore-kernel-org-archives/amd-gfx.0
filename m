Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18365C2BA2B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC67021841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iW7HJ6Ey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC67021841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EA896E156;
	Thu, 16 Apr 2020 23:42:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D859D6E0EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHMQlP6ZcDFSlY5sS7P12gVEYJnnD0WHxFSF8mhKu5iJ9PAetk1pRdseVzUbhSQK6agmNCr4fZ2DPmMpdhPC6F2CD6Zw3hCczi2NtDvvb66taZNRdL1jULVtTykClCPUm8LvWcspQG4QsKW7sUdzySjvnhYPly4nKJMZNUQEwdYjWqqhJ5ioZerd+qNgAmE0tYmlLUsi8mZtmsc/7XlBB0t3p3pc6tlZpJoD+zE8DrYH3l6xczTHTln9HByOpgb47yGFccRJOFUw3wgSPeUo0yNwR1k2EMawlJY7QN+aC7YtvhCFxtR+xJXa39hmjpGM7/fw5ikImdltIPCWao4DYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=To2FvKR4pHHUpmm1qyoSqytBCKWr+r9xfdUD1iK2elM=;
 b=AB5Uq4f37OaPK8uRkLbRvY1W2k0ng0iY8zue00lZ7/oQQsnED5ooRvy0edga9W/hw+9SeaAiB222V9FWToXYAmhI0v2iPh9Qv/0wuFOe4UvdasDow4kyrTs2aYu8oTWmh4MvX/U+cGuoMMV6cNoXZt6inXzAlYQHPqTcc6AISN8WAh5GE7jJa3EsSHBNnN3NT8szbquLJIrKDb2IjMBimbXJPjh3bZGukXxMmW83wyPx5hp6iC2M3lzFblS05VCRZtcUAMXyo2SD5lxLhqNGauT+AzbwLZ0YeC/LRpwf/XxgeaGWj4HowkDLMRLOIFzF1da6Pmy+Wear5XmWn8N/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=To2FvKR4pHHUpmm1qyoSqytBCKWr+r9xfdUD1iK2elM=;
 b=iW7HJ6EyNNnGuNfAcf1m0wUGOQ3rHCVVktR+efMbRXlpfUfguhfKGJOD8VGlqDPN17giubDj9kN6x8UcxZqGAnShqIPIp26nGLb1p4OHZprldYvyQ1sT0qaqQvlSWd+IEPGReCj95N7zEmvtR7ErP4i+582ylMmmrzIquF0SCsk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2491.namprd12.prod.outlook.com (2603:10b6:907:f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Thu, 16 Apr
 2020 23:41:59 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:59 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 35/35] drm/amd/display: Fix green screen issue after suspend
Date: Thu, 16 Apr 2020 19:40:44 -0400
Message-Id: <20200416234044.2082886-36-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:57 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2da13022-fb9b-4de6-123a-08d7e25fc149
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491352281FDA21A90C867FF98D80@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(8676002)(6486002)(6506007)(316002)(6666004)(15650500001)(54906003)(6512007)(52116002)(1076003)(8936002)(81156014)(86362001)(2616005)(16526019)(186003)(6916009)(2906002)(66476007)(66946007)(66556008)(5660300002)(478600001)(4326008)(36756003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/8/s5v5dgIGzGjVm5T2vNQPmyWpREiIFNZxxEzopYO1JQyfDPQbrYauRJ9HAWSR8jBKp6BMgxOULfJrfPj8+FaEUEHrIfIefflMKQZNK4WGWSIDX6wwJ2v/pGWWaHD2qB5R2kxdD8uOOkaOyyLcTxKNSt9mEJ8YnlseUszsC2nhoUUlAuXVXwThiuy3Bfk9E0hn9IksM2odDCHn+KbrPlCxdpwKRikJ/FyfkYgHSpudajRGbsBozWXQZrARARDTXsLjrgMLFepNwvPO0ZvjAJ3+EdcrAb4jGltzcb7Icc3NO69Tw8V34qZ/1rGv0CvZhL1DHfSmXDOCVLsKWXNTTXeGlV0VWkawsuhe9t7TTCWq+MiusUdS4pCmEBjXkN6DkgIOHUBrXuvzGc+OJZaKL79WPo3mBmgITZanykDevY7MHWoXB1XgGt84nz1iSfus
X-MS-Exchange-AntiSpam-MessageData: qM7R3928sJnh+01lmkRHueHZFKIiGZtzkxf41cXFetyrbJ/iNxkjcAy7T9Llb+phtM0Bt5x0GH/gqgHA5Ak35m5VxyKyk7ye1D+RBPoxytuAsD8Dl3QsnD2c0uKOkF+hUvxWDo6dMnFW4khSPe1Blnw6+EwWwLYbmPvmpFAWmrQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da13022-fb9b-4de6-123a-08d7e25fc149
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:59.1295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QD22/UWzqBJH68KSW+o17nZxG2OvrFYUFI2bdJIYy4m8zE/LL6PvZ8zfYKftNoqSZ2PKiOsBg4neV70wS8ZS6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
We have seen a green screen after resume from suspend in a Raven system
connected with two displays (HDMI and DP) on X based system. We noticed
that this issue is related to bad DCC metadata from user space which may
generate hangs and consequently an underflow on HUBP. After taking a
deep look at the code path we realized that after resume we try to
restore the commit with the DCC enabled framebuffer but the framebuffer
is no longer valid.

[how]
This problem was only reported on Raven based system and after suspend,
for this reason, this commit adds a new parameter on
fill_plane_dcc_attributes() to give the option of disabling DCC
programmatically. In summary, for disabling DCC we first verify if is a
Raven system and if it is in suspend; if both conditions are true we
disable DCC temporarily, otherwise, it is enabled.

Co-developed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 38 ++++++++++++++-----
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 209b9bf8bf11..04098b344ca3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3421,7 +3421,8 @@ fill_plane_dcc_attributes(struct amdgpu_device *adev,
 			  const union dc_tiling_info *tiling_info,
 			  const uint64_t info,
 			  struct dc_plane_dcc_param *dcc,
-			  struct dc_plane_address *address)
+			  struct dc_plane_address *address,
+			  bool force_disable_dcc)
 {
 	struct dc *dc = adev->dm.dc;
 	struct dc_dcc_surface_param input;
@@ -3433,6 +3434,9 @@ fill_plane_dcc_attributes(struct amdgpu_device *adev,
 	memset(&input, 0, sizeof(input));
 	memset(&output, 0, sizeof(output));
 
+	if (force_disable_dcc)
+		return 0;
+
 	if (!offset)
 		return 0;
 
@@ -3483,7 +3487,8 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
 			     struct plane_size *plane_size,
 			     struct dc_plane_dcc_param *dcc,
 			     struct dc_plane_address *address,
-			     bool tmz_surface)
+			     bool tmz_surface,
+			     bool force_disable_dcc)
 {
 	const struct drm_framebuffer *fb = &afb->base;
 	int ret;
@@ -3591,7 +3596,8 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
 
 		ret = fill_plane_dcc_attributes(adev, afb, format, rotation,
 						plane_size, tiling_info,
-						tiling_flags, dcc, address);
+						tiling_flags, dcc, address,
+						force_disable_dcc);
 		if (ret)
 			return ret;
 	}
@@ -3684,7 +3690,8 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 			    const uint64_t tiling_flags,
 			    struct dc_plane_info *plane_info,
 			    struct dc_plane_address *address,
-			    bool tmz_surface)
+			    bool tmz_surface,
+			    bool force_disable_dcc)
 {
 	const struct drm_framebuffer *fb = plane_state->fb;
 	const struct amdgpu_framebuffer *afb =
@@ -3766,7 +3773,8 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 					   plane_info->rotation, tiling_flags,
 					   &plane_info->tiling_info,
 					   &plane_info->plane_size,
-					   &plane_info->dcc, address, tmz_surface);
+					   &plane_info->dcc, address,
+					   tmz_surface, force_disable_dcc);
 	if (ret)
 		return ret;
 
@@ -3790,6 +3798,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	uint64_t tiling_flags;
 	int ret;
 	bool tmz_surface = false;
+	bool force_disable_dcc = false;
 
 	ret = fill_dc_scaling_info(plane_state, &scaling_info);
 	if (ret)
@@ -3804,10 +3813,12 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	if (ret)
 		return ret;
 
+	force_disable_dcc = adev->asic_type == CHIP_RAVEN && adev->in_suspend;
 	ret = fill_dc_plane_info_and_addr(adev, plane_state, tiling_flags,
 					  &plane_info,
 					  &dc_plane_state->address,
-					  tmz_surface);
+					  tmz_surface,
+					  force_disable_dcc);
 	if (ret)
 		return ret;
 
@@ -5429,6 +5440,7 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	uint32_t domain;
 	int r;
 	bool tmz_surface = false;
+	bool force_disable_dcc = false;
 
 	dm_plane_state_old = to_dm_plane_state(plane->state);
 	dm_plane_state_new = to_dm_plane_state(new_state);
@@ -5489,11 +5501,13 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
 			dm_plane_state_old->dc_state != dm_plane_state_new->dc_state) {
 		struct dc_plane_state *plane_state = dm_plane_state_new->dc_state;
 
+		force_disable_dcc = adev->asic_type == CHIP_RAVEN && adev->in_suspend;
 		fill_plane_buffer_attributes(
 			adev, afb, plane_state->format, plane_state->rotation,
 			tiling_flags, &plane_state->tiling_info,
 			&plane_state->plane_size, &plane_state->dcc,
-			&plane_state->address, tmz_surface);
+			&plane_state->address, tmz_surface,
+			force_disable_dcc);
 	}
 
 	return 0;
@@ -6773,7 +6787,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		fill_dc_plane_info_and_addr(
 			dm->adev, new_plane_state, tiling_flags,
 			&bundle->plane_infos[planes_count],
-			&bundle->flip_addrs[planes_count].address, tmz_surface);
+			&bundle->flip_addrs[planes_count].address, tmz_surface,
+			false);
+
+		DRM_DEBUG_DRIVER("plane: id=%d dcc_en=%d\n",
+				 new_plane_state->plane->index,
+				 bundle->plane_infos[planes_count].dcc.enable);
 
 		bundle->surface_updates[planes_count].plane_info =
 			&bundle->plane_infos[planes_count];
@@ -8196,7 +8215,8 @@ dm_determine_update_type_for_commit(struct amdgpu_display_manager *dm,
 				ret = fill_dc_plane_info_and_addr(
 					dm->adev, new_plane_state, tiling_flags,
 					plane_info,
-					&flip_addr->address, tmz_surface);
+					&flip_addr->address, tmz_surface,
+					false);
 				if (ret)
 					goto cleanup;
 
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
