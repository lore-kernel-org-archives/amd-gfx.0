Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAC1C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 20:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F6E619C9
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 20:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F6E619C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6F446E8BD;
	Tue, 23 Mar 2021 20:26:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE426E8BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 20:26:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvxcFGLRDTOk6NOmhj45w77ImHQH5vR96PySs8+R2dV8MG3qpAULh6jxmNnIPiXNq0I5b5ZJnCiQ3REA/+4s9h+OkwxBceIXDKAeqe6/bYIJaoIpNAEvvgyWB+M/tYTrWRrkjBIBcYDdt4P1E8JziEd1wdB3IWuEcjj0IWRyl7WAiZRsFb1anfKsrg2sRaOeWayG66duOjEcXM9I8PbvW0T09goYTLFnwCBQ/UELNmvGsVRprD86w596uM9Ra9YopHp04seGetSkQWkIuPPJQ1Syuslc8vkBEfo7FNwmRMjz/OTBa7d+YJOG5maUtAONsF7ZEEAqCHNlWEMqgrLp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwOpW5AivKqBINYke3bHlzj07duzpvrLfs0voxK/qSk=;
 b=DKOZ5jfB15if/nDd+GYqKnNfu89kreVTZjp8JPXNWXaLvgI42N0q+w4ebXkpvoqkae2JQS+0/TMayOvZYiQUkMjFHzxD+GkNU6fZSixKTwDaOWVN6uOjIpxisu/AEohTGtR19ehuzOjtiJnJ9k7zcnvbjyuHyvsUhou8c5+Mrew6jNcIzkxQKWm9Ut1PrVzS1LdV6YHYneVxKBuNP2rrAn7Fgk5smbGNmdud0vMyAtT/ZiRvI5r0fFuHwXI5lJzF2u9BjLrP8aDTecdV5KTf1Dy2eVB6hXlcg8M9S3QsI8JQ+7KxhRnDBNJ+iZw3PuPtGpUlIP2ZIfEcwDTPiHSVEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwOpW5AivKqBINYke3bHlzj07duzpvrLfs0voxK/qSk=;
 b=Pw4jveq/pjkyuRZR/8tg3evg+5FLMQAXBRNBRuMRbAOBBCzR4LgtW846ICI/5ZawT5plbbTGJ9WNGxa9PxvGANGgHvUkl3AoVTORW9ov136Op7gH6zfEuCkSw6QbWqNlChpMhFbdt+3SOAp+oDYXd7QBNC8rKnVI1qC8WGVUKo4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 20:26:35 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::60b7:6bfc:44a0:269d]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::60b7:6bfc:44a0:269d%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 20:26:35 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Use DRM_DEBUG_DP
Date: Tue, 23 Mar 2021 16:26:14 -0400
Message-Id: <20210323202614.20061-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.0.rc2
In-Reply-To: <9042072e-107a-eec8-2357-962698d91d0e@amd.com>
References: <9042072e-107a-eec8-2357-962698d91d0e@amd.com>
X-Originating-IP: [108.162.131.176]
X-ClientProxiedBy: YT1PR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::29) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.131.176) by
 YT1PR01CA0150.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24 via Frontend Transport; Tue, 23 Mar 2021 20:26:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f2d3bc39-4738-4d97-e5d1-08d8ee39f420
X-MS-TrafficTypeDiagnostic: DM6PR12MB3963:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3963E06DA27DE8903F34E3E999649@DM6PR12MB3963.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tz4hBhEd1THcBMtM7R3ypfIdVdV/SsLjxERWmpF6pgQ2aXGG7623vmMecKEjupA+kH2Rn/IjM1StTqTlgzHyUZtv1Vbh7+S3e7gx6m7FkwmyaWIi79N9wOXsWisQdGJoFxKK9ptOidkkGK5pNjAArVQ9xFXXojhgpEAkVg6XVUvKIUkuuXD87jwkI9EmOt8rDFRGDmKaT/HJwqlLVsQP0zu0yFLSjWUR+iko7HCvy7WExhM6A3ZKTFWh6Ouph/5vfPC/62uqUltCHE+BTyS1HZ0grdGD6r8ifRuXMI8Yj4X1p4o/6i3FgDwr5yIakLaeEZZ4PR3BPtKHIKnQmXyNMgXe9Pe1pahC1SwND4/qcAxScIKgIlrMTSMgATBJDo1gQ+/XzcNvMsS+7dhQbrzJ+B7qrvJkYNA94dwRsZ9f/HABf8faMVSTGjecCQl/xMQlxr/gAO+EVvcOFeOpAtboO/ayjj9pd8nTQIEbasVFR013vz834bcdWd2JY5xtRbKADS0z34vWho+JC6Xr4TYd6pAhG1vCs4VFxlUs9aBU3fgj3E9qS4Bx3AnK377TudOYrt3ahcKLxMK14A2gpkM61XECi5i0C/dVJfeylG4tvMwES1hUzXhXNIGNiAYj4QKTQGOxNtr8zMzfcYTJDfPokxnSBiMhdfvrRyYBKcOdS5jg5Q9zBojGDshSTdKrjZ4Q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39850400004)(346002)(376002)(366004)(8676002)(6916009)(2906002)(316002)(38100700001)(6666004)(8936002)(86362001)(478600001)(956004)(2616005)(36756003)(55236004)(83380400001)(6512007)(52116002)(66946007)(54906003)(16526019)(186003)(69590400012)(44832011)(66556008)(6486002)(5660300002)(66476007)(26005)(1076003)(4326008)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tK0Q4/P+qVwjEvKPislTnVMp5ujPmd31cNjhggBIKhf0s2uqIqwpeH+fKbAi?=
 =?us-ascii?Q?YkxVXjQWrKAfTqBex1UG97vBTHUNdD2c+eoZWMUWxJRyLNJKCOx/Vw5RUIoq?=
 =?us-ascii?Q?d6Bt/IVG2lhJv4RCjnB0ENpV8ufU59kgpTm7gR9wsnhGlooPqeE/tRHCQt/f?=
 =?us-ascii?Q?buoeLltJKzmqC/eMDoPtPw7im8pAmbYioN8ulhAzm3566ojDqAQ6hZvnwIOM?=
 =?us-ascii?Q?QwCP5e2O3yjjDUS/PjKY/hG1EArtqRt9oESYEOSlatyyhHUr9hgnAhPYcLW/?=
 =?us-ascii?Q?A5ccMdfZRX4M9uwi61e4nzM4jS5d034QJNTV1Me0cDJerLkljVjYo486GasG?=
 =?us-ascii?Q?CgPrLJ6nj5FddQ2cF1WaSJ5AdYxI6GoRwoRtSyZx+PZZmSNx7xA/6z++2/dc?=
 =?us-ascii?Q?Qtp9/PbSyp/4lf1RmJpaHUOTDlTFf4DkRa+dHN+hGvbo3g4q0Bz6MHPr33+a?=
 =?us-ascii?Q?sreLDj6XG588z7UILwwDVNh80Jv3su/zaAcTNz3XWOWKU8CX77/Dol90BYzy?=
 =?us-ascii?Q?TCpwjRWX4e+CsDpzAtGBRJ1dOnt5Zbre33wpNn3/MZk3L7G+UASV0ckxCImY?=
 =?us-ascii?Q?9ACQPA19IMq07jP07DnL658yNXTS/znOsdLYyzKFG/lE+p5LwxA3Zzb5Zcb5?=
 =?us-ascii?Q?1N2zo7GCSHAl8xFkab/zqNE69+QlNHZzbGDASVZJSd5OH5OERKxb3fOFV7Ve?=
 =?us-ascii?Q?lSS9gr018N2DZA6GAgxy95VeKh14zJAtUAxEMYxgQWezJJJ+usShQqq6h2iB?=
 =?us-ascii?Q?VQIqGeufWDPunLqAQ+yFR+170Sle2Guy1N/6kuJNAg9IsEHMx6JRInQrClXC?=
 =?us-ascii?Q?U3KMm2VQsI5a0oDE/Vs4sxgI11b42X+aFXPJGo67vE4ZIrJzfZG7UZQiomnJ?=
 =?us-ascii?Q?2rhwPv68K27dbRaj6g5yRcaFyvWPiL42zZQs1Yp5uIp+CL/gkFwNUk4AtThh?=
 =?us-ascii?Q?QsSgA9yeuVGWWqanJ7j5F3E3MNlOQOpGmVXPT68th0bcJfrpBFxekvU5nvYw?=
 =?us-ascii?Q?6l9DrfaAHQESNbpj8l0Dl5j+KV2TxopGdrld63rn5Uxyh3bJr2K3E8k4ytvG?=
 =?us-ascii?Q?vteXhPAYmySivQ5EIIWqOOY19Rngt/OYOH6C9lPOgGAvZVhUpl2y/of7yE7X?=
 =?us-ascii?Q?nLiuAAHzo5zs6sSIKGEP9WxStc4oUwybxbBqIiqDeVxuJGN3hWeL4V/Se6ep?=
 =?us-ascii?Q?8risR7WUoe0mV9mEEwLo/HIbVnMxYmaz4mjZCobQn6RAnxliM11lL4YOtt5K?=
 =?us-ascii?Q?2S2+Cb9a7chiPVAdoWxmr+mS06z5Ah+rNK7Oz5TPhliTzYEIMEbWEXJtrE51?=
 =?us-ascii?Q?qEQc7rp5JGEcjYaWAwbnbGzg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d3bc39-4738-4d97-e5d1-08d8ee39f420
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 20:26:35.2336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1wTanhlxAeIx0RTu5umDu9jZJcycX0ZHsi1HyRFqUb8L4LdFMC+4LuVUmYQ8lnk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3963
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
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 57 +++++++++----------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f455fc3aa561..9376d44ce3b4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -449,9 +449,9 @@ static void dm_pflip_high_irq(void *interrupt_params)
 	amdgpu_crtc->pflip_status = AMDGPU_FLIP_NONE;
 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 
-	DRM_DEBUG_DRIVER("crtc:%d[%p], pflip_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp %d\n",
-			 amdgpu_crtc->crtc_id, amdgpu_crtc,
-			 vrr_active, (int) !e);
+	DRM_DEBUG_KMS("crtc:%d[%p], pflip_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp %d\n",
+		      amdgpu_crtc->crtc_id, amdgpu_crtc,
+		      vrr_active, (int) !e);
 }
 
 static void dm_vupdate_high_irq(void *interrupt_params)
@@ -993,8 +993,7 @@ static void event_mall_stutter(struct work_struct *work)
 	dc_allow_idle_optimizations(
 		dm->dc, dm->active_vblank_irq_count == 0);
 
-	DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
-
+	DRM_DEBUG_KMS("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
 
 	mutex_unlock(&dm->dc_lock);
 }
@@ -1810,8 +1809,8 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 		if (acrtc && state->stream_status[i].plane_count != 0) {
 			irq_source = IRQ_TYPE_PFLIP + acrtc->otg_inst;
 			rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
-			DRM_DEBUG("crtc %d - vupdate irq %sabling: r=%d\n",
-				  acrtc->crtc_id, enable ? "en" : "dis", rc);
+			DRM_DEBUG_VBL("crtc %d - vupdate irq %sabling: r=%d\n",
+				      acrtc->crtc_id, enable ? "en" : "dis", rc);
 			if (rc)
 				DRM_WARN("Failed to %s pflip interrupts\n",
 					 enable ? "enable" : "disable");
@@ -4966,8 +4965,8 @@ static void update_stream_scaling_settings(const struct drm_display_mode *mode,
 	stream->src = src;
 	stream->dst = dst;
 
-	DRM_DEBUG_DRIVER("Destination Rectangle x:%d  y:%d  width:%d  height:%d\n",
-			dst.x, dst.y, dst.width, dst.height);
+	DRM_DEBUG_KMS("Destination Rectangle x:%d  y:%d  width:%d  height:%d\n",
+		      dst.x, dst.y, dst.width, dst.height);
 
 }
 
@@ -5710,8 +5709,8 @@ static inline int dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
 
 	rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
 
-	DRM_DEBUG_DRIVER("crtc %d - vupdate irq %sabling: r=%d\n",
-			 acrtc->crtc_id, enable ? "en" : "dis", rc);
+	DRM_DEBUG_VBL("crtc %d - vupdate irq %sabling: r=%d\n",
+		      acrtc->crtc_id, enable ? "en" : "dis", rc);
 	return rc;
 }
 
@@ -6664,7 +6663,7 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	int r;
 
 	if (!new_state->fb) {
-		DRM_DEBUG_DRIVER("No FB bound\n");
+		DRM_DEBUG_KMS("No FB bound\n");
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
+	DRM_DEBUG_KMS("%s: crtc_id=%d with size %d to %d\n",
+		      __func__,
+		      amdgpu_crtc->crtc_id,
+		      plane->state->crtc_w,
+		      plane->state->crtc_h);
 
 	ret = get_cursor_position(plane, crtc, &position);
 	if (ret)
@@ -7958,8 +7957,8 @@ static void prepare_flip_isr(struct amdgpu_crtc *acrtc)
 	/* Mark this event as consumed */
 	acrtc->base.state->event = NULL;
 
-	DRM_DEBUG_DRIVER("crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
-						 acrtc->crtc_id);
+	DRM_DEBUG_KMS("crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
+		      acrtc->crtc_id);
 }
 
 static void update_freesync_state_on_stream(
@@ -8265,7 +8264,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			&bundle->flip_addrs[planes_count].address,
 			afb->tmz_surface, false);
 
-		DRM_DEBUG_DRIVER("plane: id=%d dcc_en=%d\n",
+		DRM_DEBUG_ATOMIC("plane: id=%d dcc_en=%d\n",
 				 new_plane_state->plane->index,
 				 bundle->plane_infos[planes_count].dcc.enable);
 
@@ -8299,7 +8298,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				dc_plane,
 				bundle->flip_addrs[planes_count].flip_timestamp_in_us);
 
-		DRM_DEBUG_DRIVER("%s Flipping to hi: 0x%x, low: 0x%x\n",
+		DRM_DEBUG_ATOMIC("%s Flipping to hi: 0x%x, low: 0x%x\n",
 				 __func__,
 				 bundle->flip_addrs[planes_count].address.grph.addr.high_part,
 				 bundle->flip_addrs[planes_count].address.grph.addr.low_part);
@@ -8621,7 +8620,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
-		DRM_DEBUG_DRIVER(
+		DRM_DEBUG_ATOMIC(
 			"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, "
 			"planes_changed:%d, mode_changed:%d,active_changed:%d,"
 			"connectors_changed:%d\n",
@@ -8655,7 +8654,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 		if (modeset_required(new_crtc_state, dm_new_crtc_state->stream, dm_old_crtc_state->stream)) {
 
-			DRM_DEBUG_DRIVER("Atomic commit: SET crtc id %d: [%p]\n", acrtc->crtc_id, acrtc);
+			DRM_DEBUG_ATOMIC("Atomic commit: SET crtc id %d: [%p]\n", acrtc->crtc_id, acrtc);
 
 			if (!dm_new_crtc_state->stream) {
 				/*
@@ -8688,7 +8687,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			crtc->hwmode = new_crtc_state->mode;
 			mode_set_reset_required = true;
 		} else if (modereset_required(new_crtc_state)) {
-			DRM_DEBUG_DRIVER("Atomic commit: RESET. crtc id %d:[%p]\n", acrtc->crtc_id, acrtc);
+			DRM_DEBUG_ATOMIC("Atomic commit: RESET. crtc id %d:[%p]\n", acrtc->crtc_id, acrtc);
 			/* i.e. reset mode */
 			if (dm_old_crtc_state->stream)
 				remove_stream(adev, acrtc, dm_old_crtc_state->stream);
@@ -9298,7 +9297,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
 		goto skip_modeset;
 
-	DRM_DEBUG_DRIVER(
+	DRM_DEBUG_ATOMIC(
 		"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, "
 		"planes_changed:%d, mode_changed:%d,active_changed:%d,"
 		"connectors_changed:%d\n",
@@ -9382,8 +9381,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 
 			dc_stream_retain(new_stream);
 
-			DRM_DEBUG_DRIVER("Enabling DRM crtc: %d\n",
-						crtc->base.id);
+			DRM_DEBUG_ATOMIC("Enabling DRM crtc: %d\n",
+					 crtc->base.id);
 
 			if (dc_add_stream_to_ctx(
 					dm->dc,
@@ -9728,8 +9727,8 @@ static int dm_update_plane_state(struct dc *dc,
 		if (!dc_new_plane_state)
 			return -ENOMEM;
 
-		DRM_DEBUG_DRIVER("Enabling DRM plane: %d on DRM crtc %d\n",
-				plane->base.id, new_plane_crtc->base.id);
+		DRM_DEBUG_ATOMIC("Enabling DRM plane: %d on DRM crtc %d\n",
+				 plane->base.id, new_plane_crtc->base.id);
 
 		ret = fill_dc_plane_attributes(
 			drm_to_adev(new_plane_crtc->dev),
-- 
2.31.0.rc2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
