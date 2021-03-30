Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354A1C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 17:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C621A619CD
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 17:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C621A619CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75A7B6E949;
	Tue, 30 Mar 2021 17:22:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49C5F6E947
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 17:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nu8Y52jO47ahVaUp0M+f/st3TuuNwnmQRV7Hyh08CKcSphPqx+csHTZjqyNYXTn/18lw9LDjsd46xJaxumObXrCqsr1psYKoL+5MvJq4lRdTW6dZGPNvySqWLfCopCWMhcfmnUMyxuuOy5ET1o0q3NzFGCUcXv2+nZmbw70EnV4BT7oI1QFz8eR5s0hU4U/7w8QLQs+kjShFg06Nc0gtQv/lMiV7pIQmtpAGd1LVXFcf8xfbz5IPPXeWDXp8OaccH8b2x/o5sEodAb/9To4xc2cFzJuO+HuL6X4WSpTsvSh32uZgTueaUX3ahKti/TvJRgn9baLlSPTL+w30yOEG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/QgZeVrdPTM52TRrtvEHEkVe/cFspOKMH/r5DozVfg=;
 b=KNzhMExRMTuxSTp61zijEJONeL7ujIFu21SZKW7oaRFplKYx5JTdqRhYUCI3kMEQ5Kh22ObW4trOc7SxEUNJshi+gkq7NGvHpHzjdV6gHVzY9RXjmajdhE92ihOd2Of23O9J03itlssl3kEE04/UFpr/+alqM7KoBqCigmy9ZWUc+5IHJnNZtp5FTCadGo/HiBjL+uTCVcjtuZ4SlJrE6Uw+p3DZQhe1VyQqgSXtXWa7fqxSh+wldLNStcsptDnkGNBCX6uxsVpW0hM7Aq0xpsEP4Acik4RL9/olGExSvQXdZD1CrkkHNdYQzO0/uoF5cTp/be6wCWPbZxgwAW699w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/QgZeVrdPTM52TRrtvEHEkVe/cFspOKMH/r5DozVfg=;
 b=pjaXxPvC9nQmARFDZ/LTb7bejntvUcwsQv1T0PeEwf2aJCh1bscwV4dZ2CFeLEkB9Y0rnF83PuHhCOeDwecV2y09PgFfaUBhk/kWdpm61olSyxKqWWLL7CfQN6fsp4xtSDq0H2dbu6unkl6kC+Y6L5xqtoqP8MsnN6rekeVA5KM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4912.namprd12.prod.outlook.com (2603:10b6:5:20b::24)
 by DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 17:22:53 +0000
Received: from DM6PR12MB4912.namprd12.prod.outlook.com
 ([fe80::28c0:704b:5f81:6a81]) by DM6PR12MB4912.namprd12.prod.outlook.com
 ([fe80::28c0:704b:5f81:6a81%8]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 17:22:53 +0000
From: Victor Lu <victorchengchi.lu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Use pr_debug in DM to prevent dmesg flooding
Date: Tue, 30 Mar 2021 13:22:32 -0400
Message-Id: <20210330172232.986998-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN8PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:408:ac::31) To DM6PR12MB4912.namprd12.prod.outlook.com
 (2603:10b6:5:20b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN8PR07CA0018.namprd07.prod.outlook.com (2603:10b6:408:ac::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25 via Frontend Transport; Tue, 30 Mar 2021 17:22:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1d990fd-3073-4f72-de71-08d8f3a072e0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4203:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4203638BA42F538210359E3AFA7D9@DM6PR12MB4203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bxeLY4cistVoyRnVr55kXRcvPraGLzQ9LHVyCZGa/TMvrJ4mrt1mF/eZLFYt8iyvT+SFxoBiFW9OiNui4bVfr0agObP5mXHEsOU4ye7tkbNnpF0mknJmO+NiZUzDwilh/QgkKcvdtvLk/FhUfglRRxUR2/JMqNUNxy/+WpQ2MRfJlyrbEXtSePvUt+XBGDhMd+uWgZvW385oK5GWWJFIHnN5X+1D4Ubvo3kXv7SYDc5R3u2lcO4y5kzBmdg1OlwwYAES12diNBKo30loMXiq+I6v+exlgeC9H6Vny4zOg0X1+Hj10mahBtd1/mKkgC+7yUwm8CpA0fySR4Y7esP6rS2VdCSIHxdxHs83YtdJsOGGB6HqWkR9H6ZCp2dyjE8qQerb7d6UR7+R2za4xdxJPviFb8Hhl/gkXqz25T8g6Ae5zP+0yEh3j8IAvrfEublkN17BA6Pl58wBOBwv8gdUkatYSNAXlOp8LYzBy/cnx/XS0i9PkOEHOOQqB5pNo0HuzHuj4bvywu7rNssRTQNpU4MRweAMA2blYPdvnY3yy8fPjIPraCVKq8jpVRCZ9COflw9nsGmEzmW0D1MXTqqPNnGzJ1NVSIn1h5Rz0IvuffRx8wdOkRf5KmFn5HeKgg0wN84XxiGX/f7V808DbRk28HjwPDLG+GA+iGv3hBmk4sU8oiNd1xq3UE7zQDXfCjkj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4912.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(86362001)(8936002)(8676002)(316002)(83380400001)(52116002)(38100700001)(2906002)(66476007)(26005)(6666004)(66946007)(69590400012)(16526019)(5660300002)(6512007)(186003)(1076003)(2616005)(4326008)(956004)(478600001)(36756003)(66556008)(6506007)(6916009)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?IBIAE2irfzxFEA924w/nFdq4Zpmzo7BbGN4HQQsr9YcaV4MY/OTfA0XhoNrz?=
 =?us-ascii?Q?bYcj8ZIfR9rPXMlYkORB/hxnOil/jO4Ji0t0vnqDyvmHne9YQnpbu47YDmQ2?=
 =?us-ascii?Q?XN7k7g8kdTBlORndIebd1RLv1Y2efKKoKyaIa57q5cuT7B1TUEnxGBI02FW1?=
 =?us-ascii?Q?eKkMot+wSNgkSdpsPbi+iSUro9+5IKfPM9KY8FfJ+ehbZ4P7miuWBLRv6u0Y?=
 =?us-ascii?Q?plm9l1Pp+h4Dbm1aemrrqnW5+V2+9BSdI2j/9ySQvaKWCxCfSF1yex6bRsDn?=
 =?us-ascii?Q?yk1VcA8S3I8UF+PXfH+5Aw/1VBxA6YGpHLWU04iWZRP/UvAKDgfNnntWF5i/?=
 =?us-ascii?Q?eiXBByE6RJGEltEC4A69RrwACGlQECL/tL7vWf3JaFR2lbLa+ISCr5QiDoIa?=
 =?us-ascii?Q?cURuJ3UkjHHaSRduqKHImEmulJeRRESFvsJG26KhOX+Xha66aOPvRKlfSJ46?=
 =?us-ascii?Q?mvvIv64qZCyP/+ur5qW/n0sLzrkNZcc1ya2NIs9s2j1C40GYj0UjCY8iMBUm?=
 =?us-ascii?Q?vEUKTWzb4hAxxdE5e6oGMYimaLbUweF0dobnTsLawjAcQbFrIld/MSNYxMTS?=
 =?us-ascii?Q?K8q2Cyqdh12iONiNWQgGK3cJZ/fZGaX19qO4BVoQmQNKuJ0FriJTOUmYMzpH?=
 =?us-ascii?Q?T7heX4bMBJsF8DWVTEFK1Vlzh7JIFiBw71G5EOF/fMJq0DsFlyUL7lVyHOfJ?=
 =?us-ascii?Q?jy/p3A7Vdt+XkvjfbPFVD+khYySkcycZyfsGoGP2/wn3fLVtC8CCdPa8KYoh?=
 =?us-ascii?Q?JmZKg2TKmGSvnuikMyzVI2v/wZXURfs8VSwHV8KlJBkvLoDdmBy+ulj442Jd?=
 =?us-ascii?Q?L8Lw9dwj2BO4bw2g9zFP+dSUPeBDRpd/JjkkykUOQOG7iu/EaB9WDsliVEnN?=
 =?us-ascii?Q?E6x4fCHlMOGCWzhmxqNVD6HNPRRvY4XP+H+NXdrHT6/dL+P9aW+PLvImebph?=
 =?us-ascii?Q?d0MkiMaa7N7o7wCeuaOpdCh0PVaPZNgEvtn7lhvh6im+eBnkoaVSgjutSCrP?=
 =?us-ascii?Q?IfuL/5WUa/adYtC32RLeRiOHfGYJU9/1nJwXl+2w6I+4E4/hsuVI4afN/Wo0?=
 =?us-ascii?Q?jJiotu7tJ+zZ18KgM84Uk1k/iJ0ZRCLXwZevK+pHyM1BFt5ccFSdPshV2VRd?=
 =?us-ascii?Q?BpsUW1yFbpUiBiuJlhEYGwfL2x1huwM+1izWXyERzUy/mWHvgjcfgwtb+lMO?=
 =?us-ascii?Q?o3tFy9vgy/xbHz5CdWsyH7J15l1PJlLCYj7dbUqzavFhGD7D3s94OPVXzHuI?=
 =?us-ascii?Q?SKBZqU7EDfAW3L44CDcXwPvJ+yp4Qr/eTL3ZjlFFx9VVxVVdoSSIWpCd4kme?=
 =?us-ascii?Q?paNcXgnK/2JKcUpIegbmN8zY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d990fd-3073-4f72-de71-08d8f3a072e0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4912.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 17:22:52.7680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++LBKKSzAKhmZq0EMVnJqOflGOfxjVOe6QMprcL6FaPPYwEb8cYOOIVEAQkS0oFjnjfxdhwPZ1+TGA/JGCluHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
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
Cc: harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
Enabling drm.debug=0x4 can flood the dmesg due to prints on every cursor
update or page flip.

[how]
Define and use pr_debug macros instead of a few spammy DRM_DEBUG_*'s.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 +++++++++----------
 .../drm/amd/display/include/logger_types.h    |  3 +++
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 92cee957b424..04dbcbc7578d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -372,14 +372,14 @@ static void dm_pflip_high_irq(void *interrupt_params)
 	/* IRQ could occur when in initial stage */
 	/* TODO work and BO cleanup */
 	if (amdgpu_crtc == NULL) {
-		DRM_DEBUG_DRIVER("CRTC is null, returning.\n");
+		DC_LOG_PFLIP("CRTC is null, returning.\n");
 		return;
 	}
 
 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 
 	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED){
-		DRM_DEBUG_DRIVER("amdgpu_crtc->pflip_status = %d !=AMDGPU_FLIP_SUBMITTED(%d) on crtc:%d[%p] \n",
+		DC_LOG_PFLIP("amdgpu_crtc->pflip_status = %d !=AMDGPU_FLIP_SUBMITTED(%d) on crtc:%d[%p] \n",
 						 amdgpu_crtc->pflip_status,
 						 AMDGPU_FLIP_SUBMITTED,
 						 amdgpu_crtc->crtc_id,
@@ -450,9 +450,9 @@ static void dm_pflip_high_irq(void *interrupt_params)
 	amdgpu_crtc->pflip_status = AMDGPU_FLIP_NONE;
 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 
-	DRM_DEBUG_KMS("crtc:%d[%p], pflip_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp %d\n",
-		      amdgpu_crtc->crtc_id, amdgpu_crtc,
-		      vrr_active, (int) !e);
+	DC_LOG_PFLIP("crtc:%d[%p], pflip_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp %d\n",
+		     amdgpu_crtc->crtc_id, amdgpu_crtc,
+		     vrr_active, (int) !e);
 }
 
 static void dm_vupdate_high_irq(void *interrupt_params)
@@ -482,7 +482,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)
 			atomic64_set(&irq_params->previous_timestamp, vblank->time);
 		}
 
-		DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d\n",
+		DC_LOG_VBLANK("crtc:%d, vupdate-vrr:%d\n",
 			      acrtc->crtc_id,
 			      vrr_active);
 
@@ -535,7 +535,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
 
 	vrr_active = amdgpu_dm_vrr_active_irq(acrtc);
 
-	DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d, planes:%d\n", acrtc->crtc_id,
+	DC_LOG_VBLANK("crtc:%d, vupdate-vrr:%d, planes:%d\n", acrtc->crtc_id,
 		      vrr_active, acrtc->dm_irq_params.active_planes);
 
 	/**
@@ -7991,7 +7991,7 @@ static void handle_cursor_update(struct drm_plane *plane,
 	if (!plane->state->fb && !old_plane_state->fb)
 		return;
 
-	DRM_DEBUG_KMS("%s: crtc_id=%d with size %d to %d\n",
+	DC_LOG_CURSOR("%s: crtc_id=%d with size %d to %d\n",
 		      __func__,
 		      amdgpu_crtc->crtc_id,
 		      plane->state->crtc_w,
@@ -8053,8 +8053,8 @@ static void prepare_flip_isr(struct amdgpu_crtc *acrtc)
 	/* Mark this event as consumed */
 	acrtc->base.state->event = NULL;
 
-	DRM_DEBUG_KMS("crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
-		      acrtc->crtc_id);
+	DC_LOG_PFLIP("crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
+		     acrtc->crtc_id);
 }
 
 static void update_freesync_state_on_stream(
diff --git a/drivers/gpu/drm/amd/display/include/logger_types.h b/drivers/gpu/drm/amd/display/include/logger_types.h
index 21bbee17c527..571fcf23cea9 100644
--- a/drivers/gpu/drm/amd/display/include/logger_types.h
+++ b/drivers/gpu/drm/amd/display/include/logger_types.h
@@ -36,6 +36,9 @@
 #define DC_LOG_DC(...) DRM_DEBUG_KMS(__VA_ARGS__)
 #define DC_LOG_DTN(...) DRM_DEBUG_KMS(__VA_ARGS__)
 #define DC_LOG_SURFACE(...) pr_debug("[SURFACE]:"__VA_ARGS__)
+#define DC_LOG_CURSOR(...) pr_debug("[CURSOR]:"__VA_ARGS__)
+#define DC_LOG_PFLIP(...) pr_debug("[PFLIP]:"__VA_ARGS__)
+#define DC_LOG_VBLANK(...) pr_debug("[VBLANK]:"__VA_ARGS__)
 #define DC_LOG_HW_HOTPLUG(...) DRM_DEBUG_KMS(__VA_ARGS__)
 #define DC_LOG_HW_LINK_TRAINING(...) pr_debug("[HW_LINK_TRAINING]:"__VA_ARGS__)
 #define DC_LOG_HW_SET_MODE(...) DRM_DEBUG_KMS(__VA_ARGS__)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
