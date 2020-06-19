Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1A9C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10C16208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="G3Gp36DJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C16208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A7256EB0E;
	Fri, 19 Jun 2020 20:13:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D56DA6E98A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQHzMKve8XUfH9joG1M+np15RiUr/AXUkah2bN+kQ4jyoRCgHgYf7zQHP1vrWaaIAW6ETrORYgWrDDSAGstciApkokIJHCG2ebEyQUjMKL6JFj/Ss/ts+8RnB69INBX7hBDz80WM+PgITUfltF4/+sF5XqfoGQBTg/aeMWBYNuQrTCJ4bZtYfhgv92hmLTarj6CeLnpUqZDl2oQwWAgru79tnco2dkTe2zfnd9ExxrRwH1RZQEgNDEUiWJJQD2sdzLIPbaqYrJMLFRf7vtiORpfZeXCppswUJ7G9A0CfxdHUtg5irv7eOmHLmvxB0Z0LsLulCw1hYQv1cBSBgD8xtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We+Z6o37NvMTiovQoJMl2riBlmQxC7VlWHq+aZTnwJ4=;
 b=Fh+NLOKzzw00p0Ib02/KtlZooBJe79QWt/t4yHQsUYakKPBNioxWWPB71voqNNToDLgB57nfFuU7gTPWnl2Fgf2/b8kl4xvHSWvxnst2deWjyAGK/Res1O8TC5uWBH5/Zmc4T9pMQJOENuvp0G6D+xgTto0X3RvL7Uil5AH9VXfhZiqMKnSgG2XSDsz27OJVAyuGeQNPm/V5MkIoZ/MY9TLK674vIwtqNbeUH1ZwepR0TuOPB/wLlAV3VtWlpOiZS1vKIj1gZfJ9vpa+nob/piT3ItFXuNQSZx7kHXZ+v7s+aVaJlbQHsm53ngwuL6kdWFzX5FVcYe1KNcQqopc6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We+Z6o37NvMTiovQoJMl2riBlmQxC7VlWHq+aZTnwJ4=;
 b=G3Gp36DJztXU1clmJJxLBKq7xo+UF8cD+8ReFILiOZhMU30Gs09wTVzRPFDkeVTvVz7iZb/b4TnoG6l2WMACuhjb7Yd9/vfLM3Xv8Cm+PFqnIvLpXtyScoWs6KOQWzEaBbX3RXNX5U7Cy1qPMiRQyxvPFAs/8htVBLHQjIa75uA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:12:56 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:12:56 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/30] drm/amd/display: clip plane rects in DM before passing
 into DC
Date: Fri, 19 Jun 2020 16:12:04 -0400
Message-Id: <20200619201222.2916504-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:12:55 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 89bd487c-5c9e-41c3-d3a6-08d8148d276a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB408761389B2C8D1826A8416898980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ALi2yEK2T8CWapv7yXpXQ2lpGowa4HadHrrT5ZTL+iSqk03aTXtVCjzseWf89J2WxAXYC+VM2auk86qW5kf0GnlFi3kAW4xzoxsjNm0BvVBS9l0iMasZoEV2D5xwQcQLqaRub5MeiO8CEN2tnD+ILuHCDvLTb4ikpGabP1zPu/jcVKa/N9xLTf7SffmBgEazxdHUy47BZ8uHjVaQZ0rtmQlrkqZpIFik5eXTBIXE2694BAn75Z+wf7ytESBe2D7OkCf1TnkVqRQAlhabJw6u/tY1b6QhQw9d8oq9QDpHzdixPEZbgAkJTnSfQFdSrIVPmPbbGb8I1WerCkmdA0phg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Panbp8FeZHCFecZJq8E4qbyoIn2P4zmsyuoLd1AZtUPhsDKxpQ/Zpx4Hn2Am92zkfFeLAGVMUyD03s+X51kTn64PchYt7Y1FogMjKE4JHEhXRCLsrHH/d15VLMhX7b7IrwCL+FDRCBCG4gDkkBYGi/IIVdJ31X+IwY0SSNE9tiNk4bz9dN56xfPU8plg03THLzQvOZxOe+HpaXZ9/ko84chTU9TRS3mP6LmsckqokB3uYz6SxAliocM1iZpuTBWmjJPRHgsIR1En5bEnTSp3E8SSYyOhvXBN43W4co/LurbzvTHnRVduXC2ocSYgfo6VgvZJWOnptqSj0pcF/7DAnrOCYIO9AJNWnLYiJ9pJsJqPWnwyci138pPwgWFOP0skf3tNNHg5dvbz5cEz1x+qIOM00OBAiDchAzx4dJfw/pTZ1ugD12VJBVKEqoBPvfxT5csUDUROykMKKhcKY9lDn2OkY8AcGI9Lhm482PXakNUVZK0CtqJX+ZLi028hj1sHhCH+uY7a8cwPI6qyqQwXEg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bd487c-5c9e-41c3-d3a6-08d8148d276a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:12:55.9083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQTzJlrdIzpJc/sEMJUQCMWAFpBhuptd/cfcQL4JHl99symNm7JImj46DfMV2tLV9V/JqhHyQDHr9X3SWd6zoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why]
DC global validation can fail when userspace requests to draw large
plane without performing the clipping themselves.

This is observed in the IGT kms_plane panning tests for 4K displays
where they draw an 8K plane without any clipping while expecting only
the top 4K to be drawn.

[How]
DRM already has helpers to take care of the clipping necessary and to
mark whether a plane is visible or not, so make use of these helpers
in DM before passing the plane to DC.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6be4913a0239..2dc419194817 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5779,6 +5779,17 @@ static void dm_plane_helper_cleanup_fb(struct drm_plane *plane,
 	amdgpu_bo_unref(&rbo);
 }
 
+static int dm_plane_helper_check_state(struct drm_plane_state *state,
+				       struct drm_crtc_state *new_crtc_state)
+{
+	int max_downscale = 0;
+	int max_upscale = INT_MAX;
+
+	/* TODO: These should be checked against DC plane caps */
+	return drm_atomic_helper_check_plane_state(
+		state, new_crtc_state, max_downscale, max_upscale, true, true);
+}
+
 static int dm_plane_atomic_check(struct drm_plane *plane,
 				 struct drm_plane_state *state)
 {
@@ -5786,6 +5797,7 @@ static int dm_plane_atomic_check(struct drm_plane *plane,
 	struct dc *dc = adev->dm.dc;
 	struct dm_plane_state *dm_plane_state;
 	struct dc_scaling_info scaling_info;
+	struct drm_crtc_state *new_crtc_state;
 	int ret;
 
 	dm_plane_state = to_dm_plane_state(state);
@@ -5793,6 +5805,15 @@ static int dm_plane_atomic_check(struct drm_plane *plane,
 	if (!dm_plane_state->dc_state)
 		return 0;
 
+	new_crtc_state =
+		drm_atomic_get_new_crtc_state(state->state, state->crtc);
+	if (!new_crtc_state)
+		return -EINVAL;
+
+	ret = dm_plane_helper_check_state(state, new_crtc_state);
+	if (ret)
+		return ret;
+
 	ret = fill_dc_scaling_info(state, &scaling_info);
 	if (ret)
 		return ret;
@@ -8312,6 +8333,10 @@ static int dm_update_plane_state(struct dc *dc,
 		if (!needs_reset)
 			return 0;
 
+		ret = dm_plane_helper_check_state(new_plane_state, new_crtc_state);
+		if (ret)
+			return ret;
+
 		WARN_ON(dm_new_plane_state->dc_state);
 
 		dc_new_plane_state = dc_create_plane_state(dc);
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
