Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8A4C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 00:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7712761992
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 00:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7712761992
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFD816E80B;
	Tue, 23 Mar 2021 00:31:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 651D96E80B
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 00:31:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxgAPSk8INeCDQwzsVITlZwjH2pmxECV0rfF6+ALG6FE/HgRGdjaV/7QXfEIo8kqBorIKBL7unyy3iqorIA1Ajrrl51jFOXFpJc518iFwo6cA2+raJL6YuDCWMwDnr/sotuOuon3dsA56tAR87cOxTt0Zg3Tjtf+Urp7MGwSWNSjlfEBowztqwmC0CMoiZ60uZkQurAgKfKQo5X7jHU5xarvGWSaqOFbPlkEwYMrIa54gTjIvgyVPEBc97brhyJF4n9oAbt5NPqjkGsMoK7qTuXwf/3MQXG8y0+kWhdA1EJ3IRTdKefWPErueT+tYJ6zPKfxXwlrBQsxs3WqMGoXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2imkCJ/D/U7UmW1asjAxTHvIHdtjoZ59yQ8vWm0ngQ=;
 b=IuwYa7EB/ADUKi0+0iScW/EkEWZ2HNc10evIrqMVgLMCHEvKh5pksCUqVin2KGj88iBTfvEXFbfrwTcWo4URlJwQV4O9H38ej30tqVfGMCdIOK71Cf2t7el2f4CXhSaBF9PsiiH16+8J7Fkuy+KFZDRpyK8QX7UqfS5ncVpV5wwK0tm/lmI+qVCFTC27pk56UGI+msj3TIpcrGmEa+qEquc4Old3TIxgiNFWkr1+Gho2uNAMy+TmGB6hGS5CU97u4j7DrxKfYZQ8V5kQi9WZFsLKfHzpx1PfwchD+/3V058aoFAG/JH+2pJdtbMTKL2v1gbhxCEYoGKP9EFGTGGCjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2imkCJ/D/U7UmW1asjAxTHvIHdtjoZ59yQ8vWm0ngQ=;
 b=y4mcV8sXnEgg6jMS7A5Zs99LZe901/y7Jni+PzyCrBSw4n7y/NN2didpIFB1VKzM66MrPNOOYTaOSRsIbDWfsx22zosOb+0kKBowEYPk+fTZmoVKIQXZnIZyaFp3Yb/EcFy/EfVWo+8PcI6/u3+k6HKrf6vBJZfA7Q7lKT9rSh8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 00:31:50 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::60b7:6bfc:44a0:269d]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::60b7:6bfc:44a0:269d%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 00:31:50 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Use DRM_DEBUG_DP
Date: Mon, 22 Mar 2021 20:31:21 -0400
Message-Id: <20210323003121.7897-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.0.rc2
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: YTXPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::24) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 YTXPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24 via Frontend Transport; Tue, 23 Mar 2021 00:31:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 460e59cd-e6d3-4f28-7fcc-08d8ed930c6e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3370CC848A6486418CFDC6C399649@DM6PR12MB3370.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rq9yWHiVwizBq6tcom7TBcAFdwLOR6jEm+DUOkisBHqb69zPoKntRtp03UmeDj06mDoetlT9Q8hWiPDE5k/W827aKSySF6fvC3HBdosJqi5hPM72NC3MHh76Q7NFaGq2OZ8er3QNQ0eRJ0zGv2mYYFcSQu6rI6tOH7kvqFPUT/BFZ28fbg1PFZ8WzQpGakppFml7H3qrmnI2hNh6+5/PyBZQgoizSCj4c3hUgLzY7IlDMjFQmq7yPk5x2J4HUmXf7FhjwtX4KPjSxg0D1PwXUrm2w3fBhDiBpCmIZ5h8mh5IhlD3tlkSstyhKxaq40ZjZuA735YRrbgIPm1cb41MSRLSIAG6Ujb88i61u85RB2AyC+N4HgSNQhaRUuA+qxu2UGLGPGjuydMI/A0FXFlyjfS8oyMVuS9Jn1VXzSKlFNwGWbkilZdQSn9Y/RBvT/BvWxGCTSVajg5/w72hBwP/nIzcw5nsAtEf8LOGhAqyTFYnGQi6ztoSnj0noJRent86tMr+qIBt27ruS1i3N9uCgyLUcUG3X4PtpVR4bqTpLz9/MeVWiDIJrhPDmF9+NxYZKLXwbhkX8GSDm2pgG1zkG3LjTilzObqtQ+DZIydMLkftHQNtYvjQxdmCrsYFq/MNq0of/eGIXurzAVH7mrGSCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(36756003)(6916009)(956004)(2616005)(5660300002)(66556008)(7696005)(44832011)(316002)(66476007)(54906003)(66946007)(52116002)(26005)(4326008)(2906002)(6486002)(478600001)(8936002)(6666004)(8676002)(186003)(86362001)(83380400001)(1076003)(16526019)(38100700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?c8t5ofcElZcGKEoiZBdFkQJ1VGtWnQU/wZbd+WEdsNC3goL/dSDaoy2sHVg1?=
 =?us-ascii?Q?y++Moq/7VwJ9ALhcTw2AeRXolcF9D9se61d/W/e7RhDcgePbxvFWq7im9xR/?=
 =?us-ascii?Q?7Kvw25s7RmTTJym6WZnLmUUQsOuax66ZsAw5YPs9KtcAfow1jLo4zEL+4cGh?=
 =?us-ascii?Q?54s3SX7Io06BiZivDDau3Nv9s8BL5vWnIE2dAZDCMvgQCIoCNJWFw2pQJ352?=
 =?us-ascii?Q?VQds8Xj3BnL1I4G4cDJSpXpAXWhdnMtP2yTeA0/pztjfu9sIc0HsOlh+kjgd?=
 =?us-ascii?Q?aTGxCSfvtKRt7aqZGJu/7em/utV2k+fpA1dF5IEDGTtSpB3+5Rtx8RTwWLov?=
 =?us-ascii?Q?Cd/x0bJWd+gT8TFJCLqWVvJiVpYRCfTDcSObffkx5TCxbjaZCB/cn9ocfTBT?=
 =?us-ascii?Q?9uTJDylxgqDae8IkobEwUCB+0NOqL2uwtUgh9cJZTKYWHtx3ahUI74BrbI5v?=
 =?us-ascii?Q?SD1+QoPqZFjwcOq+uAYdlsx69CrhSBAgmBnoA9mqp9cAYw9Po+fvSS5bIFUw?=
 =?us-ascii?Q?Is6tLya6bRLWaFnhg1htE7gg/7CCSBUfNkbTtr2VjaNNJvoXi7nR25xz0xtG?=
 =?us-ascii?Q?lISnM6vf8yGrTb6jZe7loAlvWob0hvokLHv3yGPRzsSzjB8cwoW8uzc/2kJB?=
 =?us-ascii?Q?ofQRnPD+LQCeL7hRj2hgpOVuxktSpD9eDFkg84QRx6fseBT3ZUixhgcs9k2a?=
 =?us-ascii?Q?LVOXd9QxbUJbWMNBD3i8CD0wWKTX5sNPWSf+uq5AyLft+AJxb8rNhQErCekC?=
 =?us-ascii?Q?llcXdHLeKa+M3Vld2Fsdh9BKOmlojM/h2XgbA3NvW2sdJ+pyuNlVX2FyLMyN?=
 =?us-ascii?Q?bo2rHbQ549zwFsINci9/n1za9WDe9DsFEClw/PyOxZmc8sGCt9zzIqKiM/hA?=
 =?us-ascii?Q?+gHyuQmvL5FiApteL8LCWKrP5Nj2cGUdWKNln2PHUFConTPS7YneQWp7FzqQ?=
 =?us-ascii?Q?njP7d5w6YA0uAgHVAB9qXBqFEbzt8JhyfCjM0MV67+ket4crPBmAUZGS57rB?=
 =?us-ascii?Q?dRFZCt/ftSStfM02jFovRGFUZuwEJUgKHDhrnSLWQXkUZE6T7WTedUNhKWdY?=
 =?us-ascii?Q?cODtOyXJVebHPWnpECWx9SkUP53SkqJoHUoHJKptotJP4AdkepjLiOD5Ktrw?=
 =?us-ascii?Q?nR5C/PsX2IcfU/vIAJnPzXb7107B6I2MbId/5CPYQ2wIaPc+rX1gk2F8mHpU?=
 =?us-ascii?Q?WHcMbMl1OV4ykhse5Q5fUdq+O3CU0EY8AGoH91iAw91NR3YtdEFE0GNRzN5d?=
 =?us-ascii?Q?OJFcPyBLpOfdc4Zdkwt51PALE+t1ikEp0oox4AJXSh3Il9rN81FEWF0DLk7z?=
 =?us-ascii?Q?7tzgfR3S63mW54Qp0fyZ4xfy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460e59cd-e6d3-4f28-7fcc-08d8ed930c6e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 00:31:50.0976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0kvqpBMZV0J5pGFJZHvtjAlV7Qi+jRC6euR7L4JvSWasxtIoiAl+OUoGOzCdHQC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3370
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Convert IRQ-based prints from DRM_DEBUG_DRIVER to
DRM_DEBUG_DP, as the latter is not used in drm/amd
prior to this patch and since IRQ-based prints
drown out the rest of the driver's
DRM_DEBUG_DRIVER messages.

Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 67 +++++++++----------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f455fc3aa561..aabaa652f6dc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -449,9 +449,9 @@ static void dm_pflip_high_irq(void *interrupt_params)
 	amdgpu_crtc->pflip_status = AMDGPU_FLIP_NONE;
 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 
-	DRM_DEBUG_DRIVER("crtc:%d[%p], pflip_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp %d\n",
-			 amdgpu_crtc->crtc_id, amdgpu_crtc,
-			 vrr_active, (int) !e);
+	DRM_DEBUG_DP("crtc:%d[%p], pflip_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp %d\n",
+		     amdgpu_crtc->crtc_id, amdgpu_crtc,
+		     vrr_active, (int) !e);
 }
 
 static void dm_vupdate_high_irq(void *interrupt_params)
@@ -993,8 +993,7 @@ static void event_mall_stutter(struct work_struct *work)
 	dc_allow_idle_optimizations(
 		dm->dc, dm->active_vblank_irq_count == 0);
 
-	DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
-
+	DRM_DEBUG_DP("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
 
 	mutex_unlock(&dm->dc_lock);
 }
@@ -1810,8 +1809,8 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 		if (acrtc && state->stream_status[i].plane_count != 0) {
 			irq_source = IRQ_TYPE_PFLIP + acrtc->otg_inst;
 			rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
-			DRM_DEBUG("crtc %d - vupdate irq %sabling: r=%d\n",
-				  acrtc->crtc_id, enable ? "en" : "dis", rc);
+			DRM_DEBUG_DP("crtc %d - vupdate irq %sabling: r=%d\n",
+				     acrtc->crtc_id, enable ? "en" : "dis", rc);
 			if (rc)
 				DRM_WARN("Failed to %s pflip interrupts\n",
 					 enable ? "enable" : "disable");
@@ -4966,8 +4965,8 @@ static void update_stream_scaling_settings(const struct drm_display_mode *mode,
 	stream->src = src;
 	stream->dst = dst;
 
-	DRM_DEBUG_DRIVER("Destination Rectangle x:%d  y:%d  width:%d  height:%d\n",
-			dst.x, dst.y, dst.width, dst.height);
+	DRM_DEBUG_DP("Destination Rectangle x:%d  y:%d  width:%d  height:%d\n",
+		     dst.x, dst.y, dst.width, dst.height);
 
 }
 
@@ -5710,8 +5709,8 @@ static inline int dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
 
 	rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
 
-	DRM_DEBUG_DRIVER("crtc %d - vupdate irq %sabling: r=%d\n",
-			 acrtc->crtc_id, enable ? "en" : "dis", rc);
+	DRM_DEBUG_DP("crtc %d - vupdate irq %sabling: r=%d\n",
+		     acrtc->crtc_id, enable ? "en" : "dis", rc);
 	return rc;
 }
 
@@ -6664,7 +6663,7 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	int r;
 
 	if (!new_state->fb) {
-		DRM_DEBUG_DRIVER("No FB bound\n");
+		DRM_DEBUG_DP("No FB bound\n");
 		return 0;
 	}
 
@@ -7896,11 +7895,11 @@ static void handle_cursor_update(struct drm_plane *plane,
 	if (!plane->state->fb && !old_plane_state->fb)
 		return;
 
-	DRM_DEBUG_DRIVER("%s: crtc_id=%d with size %d to %d\n",
-			 __func__,
-			 amdgpu_crtc->crtc_id,
-			 plane->state->crtc_w,
-			 plane->state->crtc_h);
+	DRM_DEBUG_DP("%s: crtc_id=%d with size %d to %d\n",
+		     __func__,
+		     amdgpu_crtc->crtc_id,
+		     plane->state->crtc_w,
+		     plane->state->crtc_h);
 
 	ret = get_cursor_position(plane, crtc, &position);
 	if (ret)
@@ -7958,8 +7957,8 @@ static void prepare_flip_isr(struct amdgpu_crtc *acrtc)
 	/* Mark this event as consumed */
 	acrtc->base.state->event = NULL;
 
-	DRM_DEBUG_DRIVER("crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
-						 acrtc->crtc_id);
+	DRM_DEBUG_DP("crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
+		     acrtc->crtc_id);
 }
 
 static void update_freesync_state_on_stream(
@@ -8265,9 +8264,9 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			&bundle->flip_addrs[planes_count].address,
 			afb->tmz_surface, false);
 
-		DRM_DEBUG_DRIVER("plane: id=%d dcc_en=%d\n",
-				 new_plane_state->plane->index,
-				 bundle->plane_infos[planes_count].dcc.enable);
+		DRM_DEBUG_DP("plane: id=%d dcc_en=%d\n",
+			     new_plane_state->plane->index,
+			     bundle->plane_infos[planes_count].dcc.enable);
 
 		bundle->surface_updates[planes_count].plane_info =
 			&bundle->plane_infos[planes_count];
@@ -8299,10 +8298,10 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				dc_plane,
 				bundle->flip_addrs[planes_count].flip_timestamp_in_us);
 
-		DRM_DEBUG_DRIVER("%s Flipping to hi: 0x%x, low: 0x%x\n",
-				 __func__,
-				 bundle->flip_addrs[planes_count].address.grph.addr.high_part,
-				 bundle->flip_addrs[planes_count].address.grph.addr.low_part);
+		DRM_DEBUG_DP("%s Flipping to hi: 0x%x, low: 0x%x\n",
+			     __func__,
+			     bundle->flip_addrs[planes_count].address.grph.addr.high_part,
+			     bundle->flip_addrs[planes_count].address.grph.addr.low_part);
 
 		planes_count += 1;
 
@@ -8621,7 +8620,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
-		DRM_DEBUG_DRIVER(
+		DRM_DEBUG_DP(
 			"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, "
 			"planes_changed:%d, mode_changed:%d,active_changed:%d,"
 			"connectors_changed:%d\n",
@@ -8655,7 +8654,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 		if (modeset_required(new_crtc_state, dm_new_crtc_state->stream, dm_old_crtc_state->stream)) {
 
-			DRM_DEBUG_DRIVER("Atomic commit: SET crtc id %d: [%p]\n", acrtc->crtc_id, acrtc);
+			DRM_DEBUG_DP("Atomic commit: SET crtc id %d: [%p]\n", acrtc->crtc_id, acrtc);
 
 			if (!dm_new_crtc_state->stream) {
 				/*
@@ -8688,7 +8687,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			crtc->hwmode = new_crtc_state->mode;
 			mode_set_reset_required = true;
 		} else if (modereset_required(new_crtc_state)) {
-			DRM_DEBUG_DRIVER("Atomic commit: RESET. crtc id %d:[%p]\n", acrtc->crtc_id, acrtc);
+			DRM_DEBUG_DP("Atomic commit: RESET. crtc id %d:[%p]\n", acrtc->crtc_id, acrtc);
 			/* i.e. reset mode */
 			if (dm_old_crtc_state->stream)
 				remove_stream(adev, acrtc, dm_old_crtc_state->stream);
@@ -9298,7 +9297,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
 		goto skip_modeset;
 
-	DRM_DEBUG_DRIVER(
+	DRM_DEBUG_DP(
 		"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, "
 		"planes_changed:%d, mode_changed:%d,active_changed:%d,"
 		"connectors_changed:%d\n",
@@ -9382,8 +9381,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 
 			dc_stream_retain(new_stream);
 
-			DRM_DEBUG_DRIVER("Enabling DRM crtc: %d\n",
-						crtc->base.id);
+			DRM_DEBUG_DP("Enabling DRM crtc: %d\n",
+				     crtc->base.id);
 
 			if (dc_add_stream_to_ctx(
 					dm->dc,
@@ -9728,8 +9727,8 @@ static int dm_update_plane_state(struct dc *dc,
 		if (!dc_new_plane_state)
 			return -ENOMEM;
 
-		DRM_DEBUG_DRIVER("Enabling DRM plane: %d on DRM crtc %d\n",
-				plane->base.id, new_plane_crtc->base.id);
+		DRM_DEBUG_DP("Enabling DRM plane: %d on DRM crtc %d\n",
+			     plane->base.id, new_plane_crtc->base.id);
 
 		ret = fill_dc_plane_attributes(
 			drm_to_adev(new_plane_crtc->dev),
-- 
2.31.0.rc2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
