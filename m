Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187CEC433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 23:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A704C619CC
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 23:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A704C619CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FFE96E1B3;
	Tue, 23 Mar 2021 23:08:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789386E1B3
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 23:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPrrH6h5f2h/l7ryhz2PIRXENfzWPaSuS6hSShiJa+P8WgyPSwZTO8wxEauKL7LBhhCJ60c5NSC4O0cXtTVZskegVprTs++deXAWcWyCuSFWm6OWWhBSKU57gEN7ALhO0+Esy1Qh3qQXdQfiA3PhGnlHPXAJ3a+Td3heW05rJP4JW/YJ7aO60SM1qgDMcbVzRNHHpYZ9P9NgPwpYF949xfsGVx1LNchUULNNY2u7zlBhOm8cGrjpNsGe/D0ucfXhJgXtvyDxPaxFkR2nF6tWOWnsHyrtlVDh2/iQeeUxK+E7EEDNoYN1fcGtEh/2KXzKyjIvTaNDcbx7TN9Y/UgSZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSNTs36dx7KZGjgzoCOPzjjZm0gtmagT8C41EJlEEfM=;
 b=M29gilwXqOsKxbly6a6n/2e82fYktpqKeHhZOG4exYMiNrGk4EufNJa62Z6/BLhId5ev0J2N8SWcJAvLfQJDANV+5yHdwYonpXmPfz9HwuqbYydKi28TrSWyY2jmF44HnD98dqQ8DfKcIEifWZWCCm6zsS7OIkHzvz6oXylXx0ukqYhQawYcRZAwTikOBwVkMQK8k8rg4EvLzoDy2TiKw2qnkDcfSHXjKvQmcz7qf4M8mQ+xo3jzH8yO9oSpQKUUXKVWBdmyQVkW8NGJ7w2CXB3Tbhwrn8PA6cytFjx3dVMsESWNonkbUQe+7ibkb1BuJ2gRaY6atnCXLFrAlY2gpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSNTs36dx7KZGjgzoCOPzjjZm0gtmagT8C41EJlEEfM=;
 b=jd9foYhiPOLYHzV4P7+woNNByz3iTL+627COgstln/7Ijg7pex7pOZQsyUxQPdJNy/a4UB4uE0MK+L/4nUYEYZm4QWNX9TQYLVoJ6Q/zlMHO/KiTZdxTtCC2+kJjq7VtYOmNmXd6TDfVgb3xZQo0EKeHtCMTCu8KYR7317+Yj/c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3961.namprd12.prod.outlook.com (2603:10b6:5:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Tue, 23 Mar
 2021 23:08:03 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::60b7:6bfc:44a0:269d]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::60b7:6bfc:44a0:269d%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 23:08:03 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amd/display: Use DRM_DEBUG_DP
Date: Tue, 23 Mar 2021 19:07:49 -0400
Message-Id: <20210323230749.56581-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.0.97.g1424303384
In-Reply-To: <20210323202614.20061-1-luben.tuikov@amd.com>
References: <20210323202614.20061-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.131.176]
X-ClientProxiedBy: YT1PR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::37)
 To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.131.176) by
 YT1PR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24 via Frontend Transport; Tue, 23 Mar 2021 23:08:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2910b78-e763-45d4-6797-08d8ee50829e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3961:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3961BD7E3D0B9DA5FC8E212599649@DM6PR12MB3961.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: deAdK4A5vO+9p9VHXPx/z4qQ6kNiHfI4NElmph8my3hI4sDEhIUbO+0i/M/hyBtq1Rk/g76E9xsSXEHjC/gRMfA+E04nldGE9Q1x44uwvdqqwcTogAmuvKMiIfCKHfpSVNDe3fMaHIhINJiGNyp+oDuIdh35B5wNFRbiXZgCjWmNF5JO9ODnwMMph6S9KTMpzlbDGE7fZaew3mWzClXHJF8KoyqzWg5+nZk/B2wbwR7xLQzC/gfB5hMrZx/bX1cCnEDeTw5D3LYeXT6emnYcguohQzwfO1iaZ0KJuT88XJbP/vC5iAd7TZ+teFt4at6eEI1ryHk95DZ1x529fF97QsVH6cRdgigcnQQW2NxwJHC3IK6feci53P6uNb4ztIKkRCzKMhWu6iOpg9vBWRS9CySMAw7up/Ff3v2x6uuTvavPr03nbaxeSpxJ3djQqEL7aqks/K+rnbgYTcTCKmpeJ2ufNlJgq+9DFUqV5vcMluZ4049Hb893dD45WwYo9hcPE2VWNTahcvh72MixcmTQToM/B02N4lF9XwZF0h/KsXOdAip265+ijzIiExZ/XLbcjh/D/IaQ9yp0CPMiCANL9jEHXnPIPgaNGLYHTp8bcG5NfEknU8u1Dgn3mEksq2BUhZgsW7fl/LJ8svBXs+XZK9gwal2HTFbIjrO2OhY9QhyXVSFb3kbn/+tJ0kDb2mpx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(316002)(66946007)(26005)(6506007)(6486002)(4326008)(66476007)(6666004)(66556008)(38100700001)(36756003)(478600001)(69590400012)(55236004)(16526019)(86362001)(186003)(44832011)(8676002)(6512007)(54906003)(6916009)(2906002)(83380400001)(52116002)(2616005)(956004)(8936002)(5660300002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QWM7DY6BewMA6Xogd6HOzp86AweZCgAJ10WVGatPzNAL1tvhRfCQLXRuhFXp?=
 =?us-ascii?Q?TdyJgcDNZyXG4Ex2iY52VuXptTPlgCTN2YWVCftW1vRR6+Dq/M/R/cSrC3ma?=
 =?us-ascii?Q?iPiPwVVeKpxpC5tr2CFYd7fca+RJ0xrYHOSC5HXGDRYSnCA+UbKi4x5+JT6u?=
 =?us-ascii?Q?p0zieZMe2kAmE7udu7qd5UJlIO58C/joA21DVjyxFbQ2xCyJ5qSSd3oTUW/v?=
 =?us-ascii?Q?Id+53mvkhtFYkav9BDnmJkM0IKLuhzIwpUop5qQZChAJMAGSdo5K/3Y3BFmC?=
 =?us-ascii?Q?Nf66vJ6MVamLh8XdJNy15qhY2Al8mV8nkZ/C301Gfgkb/Gk+YtqJrR7t6G8j?=
 =?us-ascii?Q?o+0gqMU/lrBNsg6q4VLBj2fD/aiw+V1i5qYAoi34g91YH/5V4O3FSaYw2HOL?=
 =?us-ascii?Q?NIT8KWhPcOqedP+IPU3o+lx1FJbMwYXiYQtSiUGMsbQgcnGrQSF0U6FDshoN?=
 =?us-ascii?Q?0bCXI4tYMZZq1HEt7tNthCqJOQDStnzoe4yWXh4ut4CQTPUf81tofaP0LQm9?=
 =?us-ascii?Q?XCtTeTf8+JMU0aLFYCwfsPb604Eti9kLVtxqAMfVRL8fS9JKg1aXXGZW/E+Q?=
 =?us-ascii?Q?rjohNf64MS0PcpNCKYAic/3MnwgWqWIKERP1MhgEqpN0pmYvi+YX/GjY79Ie?=
 =?us-ascii?Q?OSsLJjFBlOo0iEPLVQr5LD8tK5UrVwCYU4OWK1Oc7qzWZ0fo1j/gEd3osVBG?=
 =?us-ascii?Q?Pg4M9WK25jKGSOrsorzVth3wybesEsjrzZqvaapRNZfngk5hWi5jiCgDsvp4?=
 =?us-ascii?Q?ACsbqM2ufnY2nmTCtRaHxBUdCuLZHMNmCx+Ecp0UDTUkzhSq1Q5m95DJ+kDo?=
 =?us-ascii?Q?SfmmCBpogrvOT30n4UzfkQ2dYF9fzRmbOP5ZTwVAg6jGcehYBOTaz9Po8tLk?=
 =?us-ascii?Q?AMQWvvL1cwXDboy8wzzoCbvgW52kqC2xBQCBtmJBAmxiT+7dxBDg5KJj4cMc?=
 =?us-ascii?Q?ZgYtZms8Guni04yojy+/XFlwy5M4ObHutZa54KtHGRZoTwDVBZNbpnuJkoS0?=
 =?us-ascii?Q?53rKUlZ9nY+L1PEeetn/fc0zFAOB1KhQWIgh3QOhZN1/okJqJ+xBi0D1Xq1r?=
 =?us-ascii?Q?K/iTwcuiwEGwc+LelVUjucr5fqLo6PI1NRON6GlYQxNEp5rStD6QHL/A8pwi?=
 =?us-ascii?Q?M0xsijbx6suAunA+a9853nN3cSmrVk9aKhjZK2ZwXYbSH8M1wqNmEtDTT6NF?=
 =?us-ascii?Q?fKu7a3ZuU3TgXU440Vamhja4oPCgWW1AUq5Yxm7EnD//COAr8tyYmDW/G5wY?=
 =?us-ascii?Q?BoQmNSN5JMeQ1AEhksEaAGOWnumargfDgg+nz40QhT9D3M37P8QwcGRAD+3T?=
 =?us-ascii?Q?jINHe8b5iP8rVvC7Xx18n6CQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2910b78-e763-45d4-6797-08d8ee50829e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 23:08:03.0887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzBJDIWZD6MqLDKxTBI4YM7l+xwzFFlAS2TcI1CgcEGuAVUFFVRUwSwsymF64P0B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3961
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
the appropriate DRM log type, since IRQ-based
prints drown out the rest of the driver's
DRM_DEBUG_DRIVER messages.

v2: Update as per feedback to fine-tune for each
type of DRM log level.

Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 57 +++++++++----------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ce615554faed..e923414777e6 100644
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
@@ -1019,8 +1019,7 @@ static void event_mall_stutter(struct work_struct *work)
 	dc_allow_idle_optimizations(
 		dm->dc, dm->active_vblank_irq_count == 0);
 
-	DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
-
+	DRM_DEBUG_KMS("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
 
 	mutex_unlock(&dm->dc_lock);
 }
@@ -1836,8 +1835,8 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
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
@@ -5014,8 +5013,8 @@ static void update_stream_scaling_settings(const struct drm_display_mode *mode,
 	stream->src = src;
 	stream->dst = dst;
 
-	DRM_DEBUG_DRIVER("Destination Rectangle x:%d  y:%d  width:%d  height:%d\n",
-			dst.x, dst.y, dst.width, dst.height);
+	DRM_DEBUG_KMS("Destination Rectangle x:%d  y:%d  width:%d  height:%d\n",
+		      dst.x, dst.y, dst.width, dst.height);
 
 }
 
@@ -5758,8 +5757,8 @@ static inline int dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
 
 	rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
 
-	DRM_DEBUG_DRIVER("crtc %d - vupdate irq %sabling: r=%d\n",
-			 acrtc->crtc_id, enable ? "en" : "dis", rc);
+	DRM_DEBUG_VBL("crtc %d - vupdate irq %sabling: r=%d\n",
+		      acrtc->crtc_id, enable ? "en" : "dis", rc);
 	return rc;
 }
 
@@ -6712,7 +6711,7 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	int r;
 
 	if (!new_state->fb) {
-		DRM_DEBUG_DRIVER("No FB bound\n");
+		DRM_DEBUG_KMS("No FB bound\n");
 		return 0;
 	}
 
@@ -7944,11 +7943,11 @@ static void handle_cursor_update(struct drm_plane *plane,
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
@@ -8006,8 +8005,8 @@ static void prepare_flip_isr(struct amdgpu_crtc *acrtc)
 	/* Mark this event as consumed */
 	acrtc->base.state->event = NULL;
 
-	DRM_DEBUG_DRIVER("crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
-						 acrtc->crtc_id);
+	DRM_DEBUG_KMS("crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
+		      acrtc->crtc_id);
 }
 
 static void update_freesync_state_on_stream(
@@ -8313,7 +8312,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			&bundle->flip_addrs[planes_count].address,
 			afb->tmz_surface, false);
 
-		DRM_DEBUG_DRIVER("plane: id=%d dcc_en=%d\n",
+		DRM_DEBUG_ATOMIC("plane: id=%d dcc_en=%d\n",
 				 new_plane_state->plane->index,
 				 bundle->plane_infos[planes_count].dcc.enable);
 
@@ -8347,7 +8346,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				dc_plane,
 				bundle->flip_addrs[planes_count].flip_timestamp_in_us);
 
-		DRM_DEBUG_DRIVER("%s Flipping to hi: 0x%x, low: 0x%x\n",
+		DRM_DEBUG_ATOMIC("%s Flipping to hi: 0x%x, low: 0x%x\n",
 				 __func__,
 				 bundle->flip_addrs[planes_count].address.grph.addr.high_part,
 				 bundle->flip_addrs[planes_count].address.grph.addr.low_part);
@@ -8669,7 +8668,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
-		DRM_DEBUG_DRIVER(
+		DRM_DEBUG_ATOMIC(
 			"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, "
 			"planes_changed:%d, mode_changed:%d,active_changed:%d,"
 			"connectors_changed:%d\n",
@@ -8703,7 +8702,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 		if (modeset_required(new_crtc_state, dm_new_crtc_state->stream, dm_old_crtc_state->stream)) {
 
-			DRM_DEBUG_DRIVER("Atomic commit: SET crtc id %d: [%p]\n", acrtc->crtc_id, acrtc);
+			DRM_DEBUG_ATOMIC("Atomic commit: SET crtc id %d: [%p]\n", acrtc->crtc_id, acrtc);
 
 			if (!dm_new_crtc_state->stream) {
 				/*
@@ -8736,7 +8735,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			crtc->hwmode = new_crtc_state->mode;
 			mode_set_reset_required = true;
 		} else if (modereset_required(new_crtc_state)) {
-			DRM_DEBUG_DRIVER("Atomic commit: RESET. crtc id %d:[%p]\n", acrtc->crtc_id, acrtc);
+			DRM_DEBUG_ATOMIC("Atomic commit: RESET. crtc id %d:[%p]\n", acrtc->crtc_id, acrtc);
 			/* i.e. reset mode */
 			if (dm_old_crtc_state->stream)
 				remove_stream(adev, acrtc, dm_old_crtc_state->stream);
@@ -9346,7 +9345,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
 		goto skip_modeset;
 
-	DRM_DEBUG_DRIVER(
+	DRM_DEBUG_ATOMIC(
 		"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, "
 		"planes_changed:%d, mode_changed:%d,active_changed:%d,"
 		"connectors_changed:%d\n",
@@ -9430,8 +9429,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 
 			dc_stream_retain(new_stream);
 
-			DRM_DEBUG_DRIVER("Enabling DRM crtc: %d\n",
-						crtc->base.id);
+			DRM_DEBUG_ATOMIC("Enabling DRM crtc: %d\n",
+					 crtc->base.id);
 
 			if (dc_add_stream_to_ctx(
 					dm->dc,
@@ -9776,8 +9775,8 @@ static int dm_update_plane_state(struct dc *dc,
 		if (!dc_new_plane_state)
 			return -ENOMEM;
 
-		DRM_DEBUG_DRIVER("Enabling DRM plane: %d on DRM crtc %d\n",
-				plane->base.id, new_plane_crtc->base.id);
+		DRM_DEBUG_ATOMIC("Enabling DRM plane: %d on DRM crtc %d\n",
+				 plane->base.id, new_plane_crtc->base.id);
 
 		ret = fill_dc_plane_attributes(
 			drm_to_adev(new_plane_crtc->dev),
-- 
2.31.0.97.g1424303384

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
