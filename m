Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96EBC2BA2B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9EB821841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p2pTGE0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EB821841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74BCC6E0D4;
	Thu, 16 Apr 2020 23:42:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E60346E36F
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaMWgCng4TmZUs/7esIJnA8LmTlwbh/JxvekoBDTrnWmEkIPd2mnydls7PIN3mlif/3LbfjjH2IBjXSjw4nF7iqbKHcK4d0cvzDshUffuNyUdEWw0MgJIOHH7zBuYqNnlBs/TWs6oO1i1n58wvLZaoNCH2CKw+BW9j0lBAGVWdApIGUd1qpcA3X2+tcVnZNpMPYMYBV8UFh4tBubSDCbkXu9ZZK6FYL71zUuk66bpKCkGjF8oDzukWZAHUUSG34oiQ3KfMxWKnU7fgvnLtF+85sMlPBU+jsX6UiqQMqfeQcVvSLZG5IC9sOqjku8fO+DugbdKT5n1Nhb+vp9aoJLQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O43PBNC5wqZVN8IcDxnF+XnHg1HpR8bXsD+U9QyywCA=;
 b=Tg7dW+Hq5dDXzr2dZ821DVpibGHvVPvBCnqooEykHo9+EMVp1O3nihbPz5+qAn/vT+22HN9CE1G9fg0499O0ruBguSOpjt4xVzMP2LM8CH05rhloLhmZjegZZJHcpANAqCSl+tMIDITg/etCnIGg+Xd9N1QR+OQwVVl+ccV8mrrrWCNxwfckGWq47Li6bgD9DocPhkfjZTw0ksgnaNk2OyygIoNOysFPCN/+T0RaorfhaVEPM4tLGAt0Sn7n2asuzlLsRcJmuqK2lb/AHywfRTJgzfMt3jVM2BJLH8PzvNlVoUia6fPmyY7ehy+AVk8ihCokbDiH4+RRQATpnMd3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O43PBNC5wqZVN8IcDxnF+XnHg1HpR8bXsD+U9QyywCA=;
 b=p2pTGE0onQQdtaL7QtweUOuFKWtq0zd9B+nlmzVdH9GYCpW4DWnHtF25LCWzvfwEXJixk3BCFV8JvKRXELUNf4qs/Vugvp6Yoav7b6HSaSZhBpe2URF0sOlt+k44hpNO1vjDsFzQhUkfRqOtgORXY4lr/B+vrTnD9AYEldQd8aw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:57 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:57 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 34/35] drm/amd/display: Adjust refactored dm for color
 management only
Date: Thu, 16 Apr 2020 19:40:43 -0400
Message-Id: <20200416234044.2082886-35-Rodrigo.Siqueira@amd.com>
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
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:56 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c1235cfd-e2be-4227-6ab3-08d7e25fc073
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB245930A43F27C209EAFE4FF798D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(6666004)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y2kG7dKZwiLLHkZsQ7GsOJzx2vAoRws+J6vIHYF7tRhOAiDNCPQFX9Yv1+FUP5kYiJrPGuOP0tJza2GKy14Tvip6d758RYul/97yjsmEARUtyJ+9s2C7XJA0OVYrOqiUp0kpQtVyECMwrxyboro7BDJVcXspNM4ocZE8FYI/zgKK4SvbBCQs9m/Dap9DYRxEDxRqSiAnMLj+rm6yJdhhxqD8McleWoOBvcSOidnuIBVZVWq5SlfIOhU3PmkyZpoLeJhCJqtkxnMTLLutcgbTJICIUXRBDTOrsBWJH2NeINI3Og3OKnfqHmbAfohpo7gKmKzkvzpU3pt3tBqrck0UtTE7W1v6FtNidt66AfZNHjW30SvPeL5uh/cLE7h8JRPbeDKVq5LsHLUlZNPDTpwuEt6UT52YFkqxrY4YkH11WaXIjYhX2l+V2+V1rN5E0ICx
X-MS-Exchange-AntiSpam-MessageData: UElkrbX3EB2D93uGpBmD7i4Ag4NbKWTnDSJLZDTAhoyeyPVHh25lSdxzTDOahT1CsxuQB44cOyNkI1i3QTdO9tZC9OWgue9ZoA64cPKGHcTM223CqoOlRPKM+7AyVrrzjzsyYAzBQH34A8VnN+cfyemMIx+OA+ht3Kj7/5vq+Dw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1235cfd-e2be-4227-6ab3-08d7e25fc073
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:57.7263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/hoKOzmA4FkBpcEtJKPz2UsDRVwV7IS2DTbo7VQFzAoH/m7whapPe2oELQVEyiklxdPq893Ds9WqtXw97hP+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
Cc: Stylon Wang <stylon.wang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
Commit 4ca3f1217e6106779aea9ebabdd09f695d42f2ff is causing regression
from changing the order of call sequence.

[How]
Keep the call sequence and take in extra dm state only if plane-level
color management is enabled.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 ++++++++++---------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  3 +--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 671741713b04..209b9bf8bf11 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3778,12 +3778,11 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 }
 
 static int fill_dc_plane_attributes(struct amdgpu_device *adev,
-				    struct dm_plane_state *dm_plane_state,
+				    struct dc_plane_state *dc_plane_state,
 				    struct drm_plane_state *plane_state,
 				    struct drm_crtc_state *crtc_state)
 {
 	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(crtc_state);
-	struct dc_plane_state *dc_plane_state = dm_plane_state->dc_state;
 	const struct amdgpu_framebuffer *amdgpu_fb =
 		to_amdgpu_framebuffer(plane_state->fb);
 	struct dc_scaling_info scaling_info;
@@ -3831,7 +3830,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	 * Always set input transfer function, since plane state is refreshed
 	 * every time.
 	 */
-	ret = amdgpu_dm_update_plane_color_mgmt(dm_crtc_state, dm_plane_state);
+	ret = amdgpu_dm_update_plane_color_mgmt(dm_crtc_state, dc_plane_state);
 	if (ret)
 		return ret;
 
@@ -8037,6 +8036,16 @@ static int dm_update_plane_state(struct dc *dc,
 		DRM_DEBUG_DRIVER("Enabling DRM plane: %d on DRM crtc %d\n",
 				plane->base.id, new_plane_crtc->base.id);
 
+		ret = fill_dc_plane_attributes(
+			new_plane_crtc->dev->dev_private,
+			dc_new_plane_state,
+			new_plane_state,
+			new_crtc_state);
+		if (ret) {
+			dc_plane_state_release(dc_new_plane_state);
+			return ret;
+		}
+
 		ret = dm_atomic_get_state(state, &dm_state);
 		if (ret) {
 			dc_plane_state_release(dc_new_plane_state);
@@ -8062,14 +8071,6 @@ static int dm_update_plane_state(struct dc *dc,
 
 		dm_new_plane_state->dc_state = dc_new_plane_state;
 
-		ret = fill_dc_plane_attributes(
-			new_plane_crtc->dev->dev_private,
-			dm_new_plane_state,
-			new_plane_state,
-			new_crtc_state);
-		if (ret)
-			return ret;
-
 		/* Tell DC to do a full surface update every time there
 		 * is a plane change. Inefficient, but works for now.
 		 */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index f30dc004bf2b..3f0c6298b588 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -482,7 +482,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 void amdgpu_dm_init_color_mod(void);
 int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc);
 int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
-				      struct dm_plane_state *plane);
+				      struct dc_plane_state *dc_plane_state);
 
 void amdgpu_dm_update_connector_after_detect(
 		struct amdgpu_dm_connector *aconnector);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index d0554082f0dc..838f35668f12 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -416,10 +416,9 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
  * Returns 0 on success.
  */
 int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
-				      struct dm_plane_state *plane)
+				      struct dc_plane_state *dc_plane_state)
 {
 	const struct drm_color_lut *degamma_lut;
-	struct dc_plane_state *dc_plane_state = plane->dc_state;
 	enum dc_transfer_func_predefined tf = TRANSFER_FUNCTION_SRGB;
 	uint32_t degamma_size;
 	int r;
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
