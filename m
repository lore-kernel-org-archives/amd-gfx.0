Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978E0C2BA1E
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3F520644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zpPBLEYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3F520644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 269CA6E29B;
	Sun,  5 Apr 2020 20:42:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97F446E29B
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:42:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lm+KVTQ1sPL6czq58lVWXu7CLxAhRhch5XMA+HmxT/+8cb5+b9W++dyHV369/UZT3frn+CJkh85ZLwk0bH4frTBcThbW3YPEMZwvqX58Fxmfr6KHwdaoMaJrPsGmQO/EGKohanEI30Zz3lNgVs4/S9Eycgv1bbisbMXFlWadH091BILQ+NTyiYoLifozk8B6iViY2ghi1WFIRSTq4/QEY9Asqu7mb4kqY0+y0mPxPDs15fPIOMDLGSIswQbaXvMdvcJfa5D5duMK4C87v/APVMZxND0EejRQjmOQ20xn2xIZ4MriIJljgOy93obYAm/k/K9bxrQ8tUrMbS4a3p/uMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1ySdAXahJvs/9fsazcpIeRiq5cwPkl1Y46Kk+WgRwY=;
 b=frrYUCLHm7xblB5IIElxwQau5FxdufkCzSwYAKD5Or8pHFWbmHZk37YrkUSQNIQ/GZjwvTPs/eMyl6VLl8HwjIUox+hwSpICiwsdmXFBhrRPWx4BVOvHzlLCAVf+E/tZbsr2cSvBed/EyVMA5y0GLaRWzhP3kLygt4XEEQv7QkLjCdBJkpZsuVQSWXXNKM/FvsSl0bJSxHQ2vU4KGhxfeDNmOmYYR9O/d4iTrBhhZTyGrAML2TfNLq1MTo6ribsXIyBCIv0mtetmkr/zAOizfwAMXHDzPWnISYI0m5IkD1lCkLJoxbR1abRoiL43PriZdb71muQUSLWFTInIQVcm7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1ySdAXahJvs/9fsazcpIeRiq5cwPkl1Y46Kk+WgRwY=;
 b=zpPBLEYldwqDsvek3CY610l99pmmNvvoLN3n695IaVJSiDFMVTMgiA5FpReqUBN7z6BnCkX/yy7mxEz242/ZDkf+/QJz41puuxOayQ3l4buY9bSB8+68eqWITC8VB5OChMASSWk7rG6Ro4mWA/ZTDDlWoppZ5B+LQXxFMvT03l4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:42:03 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:42:03 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 25/36] drm/amd/display: Refactor color management to take dm
 plane state
Date: Sun,  5 Apr 2020 16:41:04 -0400
Message-Id: <20200405204115.683559-26-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:42:02 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90488083-7793-4da5-0d4b-08d7d9a1cbfb
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2555F4162666C0C87FD3625D98C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TsPCVWaVWQMMrx3Q3XxBpkzLYAc4eL6tjeR16l9QXCOZfHDru01gEsxY+5wCDH+EoKSkaObytXkbDEebz93Yi8jFO6UZdw+xW7DRer/AvsBq9oJSJUtf8ltU6ohOYRdqrrx0SC+z3plgJ6IyPKZIidPHl5IfI+SiA9zgBkOCQrDWGpYfOW/doO6TKBk1+uI+z+7IWDbC3NPKvYf+Ydk39bEdlcjw2QakEqqPAMmD7OlEhCZo/uVRZZurwROiiv2O+eesI8hM8/cshGoNZwmj71LGU7EJ3laeKXNQ/xyJOirpWOzvFW86PxGaRoGPVgzkkBzVT/QbNGVvf2tDTIn1lIA1aDafmVaioghMr2UHYvd/DR/CscQLGNbfWR/8ztxkqvJi12P6R+KeU6RmizdXpbxf5OMh1bCwUi9uIRZfWRyF7Laaw/c8zH/3ht/gyHsr
X-MS-Exchange-AntiSpam-MessageData: aiJg3pytgXDmLPEY/zXTQBAoPzczQIfzBlcxQnd6UOQvCzQIfH7Ieuh+uSmyyLSpL1J49pBRSF1JyteLYqewFD5W1ELCSE80E5c1b4NEjsxmRQQmo/vrXs2QJceQ30CpJWl9OpBOoLDhAvlfn7LeepmS+yC0xTZuV17/ofYDwGs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90488083-7793-4da5-0d4b-08d7d9a1cbfb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:42:03.4682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1j2wiLMt5gO7qczMkt261uWNaBtCUnxUhwvP2WYEEBMRIvSgrNhiokcinayEcGxHChkWFGza+BUVCoKinBHN6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Stylon Wang <stylon.wang@amd.com>, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
- In amdgpu_dm_update_plane_color_mgmt() it is inconsistent in taking in
dm_crtc_state and dc_plane_state.
- Makes supporting plane-level color management with proper guard more
complicated than necessary.

[How]
Pass in dm_plane_state in place of dc_plane_state in
amdgpu_dm_update_plane_color_mgmt().

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++----------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  3 ++-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3dcd4de0b2b3..47af6e9a31bc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3772,11 +3772,12 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 }
 
 static int fill_dc_plane_attributes(struct amdgpu_device *adev,
-				    struct dc_plane_state *dc_plane_state,
+				    struct dm_plane_state *dm_plane_state,
 				    struct drm_plane_state *plane_state,
 				    struct drm_crtc_state *crtc_state)
 {
 	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(crtc_state);
+	struct dc_plane_state *dc_plane_state = dm_plane_state->dc_state;
 	const struct amdgpu_framebuffer *amdgpu_fb =
 		to_amdgpu_framebuffer(plane_state->fb);
 	struct dc_scaling_info scaling_info;
@@ -3824,7 +3825,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	 * Always set input transfer function, since plane state is refreshed
 	 * every time.
 	 */
-	ret = amdgpu_dm_update_plane_color_mgmt(dm_crtc_state, dc_plane_state);
+	ret = amdgpu_dm_update_plane_color_mgmt(dm_crtc_state, dm_plane_state);
 	if (ret)
 		return ret;
 
@@ -8027,16 +8028,6 @@ static int dm_update_plane_state(struct dc *dc,
 		DRM_DEBUG_DRIVER("Enabling DRM plane: %d on DRM crtc %d\n",
 				plane->base.id, new_plane_crtc->base.id);
 
-		ret = fill_dc_plane_attributes(
-			new_plane_crtc->dev->dev_private,
-			dc_new_plane_state,
-			new_plane_state,
-			new_crtc_state);
-		if (ret) {
-			dc_plane_state_release(dc_new_plane_state);
-			return ret;
-		}
-
 		ret = dm_atomic_get_state(state, &dm_state);
 		if (ret) {
 			dc_plane_state_release(dc_new_plane_state);
@@ -8062,6 +8053,14 @@ static int dm_update_plane_state(struct dc *dc,
 
 		dm_new_plane_state->dc_state = dc_new_plane_state;
 
+		ret = fill_dc_plane_attributes(
+			new_plane_crtc->dev->dev_private,
+			dm_new_plane_state,
+			new_plane_state,
+			new_crtc_state);
+		if (ret)
+			return ret;
+
 		/* Tell DC to do a full surface update every time there
 		 * is a plane change. Inefficient, but works for now.
 		 */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 3f0c6298b588..f30dc004bf2b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -482,7 +482,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 void amdgpu_dm_init_color_mod(void);
 int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc);
 int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
-				      struct dc_plane_state *dc_plane_state);
+				      struct dm_plane_state *plane);
 
 void amdgpu_dm_update_connector_after_detect(
 		struct amdgpu_dm_connector *aconnector);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 2233d293a707..6b58761e4b04 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -416,9 +416,10 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
  * Returns 0 on success.
  */
 int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
-				      struct dc_plane_state *dc_plane_state)
+				      struct dm_plane_state *plane)
 {
 	const struct drm_color_lut *degamma_lut;
+	struct dc_plane_state *dc_plane_state = plane->dc_state;
 	uint32_t degamma_size;
 	int r;
 
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
