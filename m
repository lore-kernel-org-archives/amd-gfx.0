Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF957C433E9
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E55664EC4
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 04:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E55664EC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AF206E882;
	Thu, 18 Mar 2021 04:33:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DF136E090
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 04:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSnFNQ94T4/JaPKzEk5t0X2TmtXi9PoVYdlcryC8N9AEOGquB1Eh0pUtMQc+1Bgf2BDEGtbP13afb9MYKSImo13q5A6I917LBIIbM/7oagAYkwq5/6rtJdju/Mg3TaTN0swN+Qe1mcOVm47kYC2x2edVwlIRwWE2DEouT3GnJ2IqeY4KH5qlIOSAcUhzWQ3Vh2YDhJBl+EkIYDpjgK9bfRQ5GoP4SJjgzSvAazevkVAilg+1XkOp+HJxACQNTVyLDsD/+mizNJ/xIV8RvqJPuk3O3l+Y4YPqtwlOQAEJSV+yjX0HXL6w75iH+qL2m4VqrRJExXqS35b10HTrWoehsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=misqi7dVxhfcQejiqVOE5eh7p6xJYQc3DaGXPjxBzNA=;
 b=Z8m6gXvd5oe721EskwFALWZnomntjQEL6x68rBCDTPd+jVp1SaoT72DOAunTCxfa/4Wiaj09AmZ78sgUl0auLp9cAJ58LNML/bNssJx71nZS5w+DbtjwauOe2y87y/OxIVJSaE5rveKie4mgEnsxYTKllVzShSYR5fbKkmyzX6ZMgpWqA5T2BwSVncyPPvM75pbp9xBwq7kOgMFXM+sJcJGQzgwA7U+85YEBw6dgAQFPj4mdJbQfeUIZmvaAspZ7Jff1ooIEWSeJf4bcOfQ2sMJGiOV6JczokH9PaUlGXd8H/JLaU9rERvUxRBz6FD5aifibNH4zGvG9WImpgDusoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=misqi7dVxhfcQejiqVOE5eh7p6xJYQc3DaGXPjxBzNA=;
 b=l+SlBq/QR3LWzUvWhGGiH6W5q26pZoWZ7/Z962o/GwQxJSO9cZmLKwHNHqDqywuLnQa3ZCqNUyd7cRrSTn8n+3bfE8Jpwz97E+gFAPjkr4hcL490nlPmpGAapHNLHp0U4VZcvpDCj18dZDO1BpYTzJf0Cmokah5Jyjovrc01C3Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4016.namprd12.prod.outlook.com (2603:10b6:208:16b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 04:33:45 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 04:33:45 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/13] drm/amdgpu: clean up non-DC suspend/resume handling
Date: Thu, 18 Mar 2021 00:33:16 -0400
Message-Id: <20210318043323.3989-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318043323.3989-1-alexander.deucher@amd.com>
References: <20210318043323.3989-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:23a::29) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:23a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 04:33:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4b6dfb8b-8f39-46f9-d4fd-08d8e9c70419
X-MS-TrafficTypeDiagnostic: MN2PR12MB4016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4016DA85A88B850FFB3AAA6FF7699@MN2PR12MB4016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwoTOvlTjYt73vOiWlOT1fDwyFACNVPI2gUee6GEXY5xs6c//sSQb4CnOtSCLxUncq15sGM59ImoYPNgshrHDHYyJSzGr62wBLoaQW7Ho7OEh2GRSFEGItMDS5LPqGnN9ZuHun0RzgCX0axhMWUjS5xRVYBb/yzXngeTet0TdbdxTjPVnHX5Jhog0EPMwtt7AxrJrpN7svkMWor3gSayuZIM0BtQttbWeboKtArxAWcGIMe2HJnPk7IgMUB3bs3yhLed7+PG4bP3EgQvU4YVgEY6dKJDgY2i5CrFWUvNE9mKueOoTmcpInRttOXyMgrLND0vngxLEhPiSYBPcWK6LwiC92l3dXOI/QPyaMByjPpeHlyO44t6El2BHOBmVuJklTBsWafsoNF3aYIm1GG7OQPzWgAKN7RcvvbGlahEOpErNsFlzGveR7SZv3Bb3G8azLeiWZABotlJ7jfPWraawxNcZ3+ow1IT12bReLtr5em0Pokp5tYniINv+moSvRfqOYOQbNuS90UmjS9UtsSPIoY6pTdD3SQz7C3DeXUaxQ3AM2GMhGm4qPwQIggL5VJgG79VHAQwziWGvMpZr8zhLP0+wOpWfgU//yBaIecNq0zQaDMz192KkrpdXLGA9p2K21z65E04Y1eHcbkf3ASaVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(316002)(5660300002)(52116002)(1076003)(83380400001)(8676002)(66946007)(478600001)(38100700001)(86362001)(8936002)(16526019)(69590400012)(4326008)(6506007)(6666004)(15650500001)(186003)(36756003)(66556008)(30864003)(66476007)(2906002)(6486002)(956004)(26005)(2616005)(6916009)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8ln/tnDelCO5cO5h0x2xycMhpDRT9t1nDiZINatxQfPB60tSr8NpsF3m/HeE?=
 =?us-ascii?Q?gvXcp8epMUBrihV/FSGqFFPCI6mp7GsWkXstmnaF0+MYNRik8Gk75LBF4048?=
 =?us-ascii?Q?D7tzbrNqrzXXPhC4DLroNbQmm2828CeclL9XJ2chLMkRT2mnKBl7VWgeV8/I?=
 =?us-ascii?Q?Lfn6+WtfruMbojMmMq3HcaX9WU+jVyhbm/80UDpXQjQeXjBJR9f0Si4NeSwp?=
 =?us-ascii?Q?GKDbtRi1d40y3peo3UCGxkrU0CwhXx6hXUKY90ToRlRVj/48bn9/OA3pAuJw?=
 =?us-ascii?Q?3buuct10NRJKVAM7Cp6fPeUnK6UWZa8H5RJPp+L9c89b/jctxIb9Yy6gO5CO?=
 =?us-ascii?Q?jRS2DGQn+sgGfiKgs2U+tvEsjtoV/pQYJW7uqCYGpyXRjV5fMpX93XhuxaAN?=
 =?us-ascii?Q?fepZ2bfHMyM9WMAU2N843ZW8UBJoGOemnKw5z/oYHCeTPBoRi++iiNxuOEP2?=
 =?us-ascii?Q?Yu+ZykxjGShFUyXB8/R8psISj8pRh8/IjdYjirKTdhJVAaLwUXI/SvAogaiz?=
 =?us-ascii?Q?TxlxUpFj/MhN37fBBreZCmvt79e1tmuTcPMNo1KmMiYjEe6HKMjPt1UXqDer?=
 =?us-ascii?Q?/8PYT2zNLMNNp3wg3VQWrHbmGtcU7YccN5U2wm4yKSaPM+Cci1rSgiNPQ2uD?=
 =?us-ascii?Q?yUw6Yi2bl+v/nOhLezE5I3zGBtNlCzB5hx9LhHmky0xadKqDLCa5soVYvoUb?=
 =?us-ascii?Q?ZTP5wfmY2FboSEqSj/JljQIvVddfF5D8AWGsUTbejhcoBC2NiwqAm58IU8cd?=
 =?us-ascii?Q?DKzrdSUv1jvt2W+dgifs/RWz0Pn1Fm4iZdqWygvWZA28JJL71kuhlh/8SuWB?=
 =?us-ascii?Q?C5q9kKnNOhJwAgWicyvksukbkZWW1iQXvSiZDgDA2StQoXd+faRyd2Ds1Lhl?=
 =?us-ascii?Q?RrLZWS6pB7Nisv+hZgllhbbIZA5Leon3xIkIOq0cI9+g72WGvcM3KpkLWrsE?=
 =?us-ascii?Q?vK3cmpZo6yf8szja2eAa1w08irxNlbloYNtYYlehGIFCCARc9e8Rf5Uspcz1?=
 =?us-ascii?Q?hrx0C5+oM8n+EefwRX9dJUfr/xHLAw5caLlBtdPtRTHU87LKTXyUHkwdkTqA?=
 =?us-ascii?Q?ElXtvV783TWofTeYgcoSddUYsJPBf4Pr9LNMvv0fg44X9TLDNSe95st+0fgH?=
 =?us-ascii?Q?/YuLrFbOnoUF3oL28V/U/gi8sujmeg6dn08ROwub5VXzjT9V/xvXWazFnz/l?=
 =?us-ascii?Q?7UaS5RTX3OH8IO3PFd0VxDpX0uTqbwfPoQJ9LFyYFLnMQ7H5GAXzNEEmE0wx?=
 =?us-ascii?Q?it68nC4yMCHSPy4pxsTJ2BJKHQfY0yrGQzN2mckZOw3vP3rs/r7X+NRDO3/6?=
 =?us-ascii?Q?0C/vrp8un7ghoEcsUKfDxxmj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6dfb8b-8f39-46f9-d4fd-08d8e9c70419
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 04:33:45.1442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSrf1uAb0/fn26+5pyQT+RoKeIV7v7vkdFiUnkN+Pjl17MEcW2Pned+n6/iKzrwQ5Kzefblin8tZ4yvDog4D1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4016
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move the non-DC specific code into the DCE IP blocks similar
to how we handle DC.  This cleans up the common suspend
and resume pathes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 86 +-------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 88 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h |  3 +
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c      |  9 ++-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c      |  9 ++-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c       |  8 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c       |  9 ++-
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c    | 15 +++-
 8 files changed, 138 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1859bc06ed70..80263bb8a631 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3667,14 +3667,9 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
  */
 int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 {
-	struct amdgpu_device *adev;
-	struct drm_crtc *crtc;
-	struct drm_connector *connector;
-	struct drm_connector_list_iter iter;
+	struct amdgpu_device *adev = drm_to_adev(dev);
 	int r;
 
-	adev = drm_to_adev(dev);
-
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
@@ -3686,45 +3681,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	cancel_delayed_work_sync(&adev->delayed_init_work);
 
-	if (!amdgpu_device_has_dc_support(adev)) {
-		/* turn off display hw */
-		drm_modeset_lock_all(dev);
-		drm_connector_list_iter_begin(dev, &iter);
-		drm_for_each_connector_iter(connector, &iter)
-			drm_helper_connector_dpms(connector,
-						  DRM_MODE_DPMS_OFF);
-		drm_connector_list_iter_end(&iter);
-		drm_modeset_unlock_all(dev);
-			/* unpin the front buffers and cursors */
-		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
-			struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-			struct drm_framebuffer *fb = crtc->primary->fb;
-			struct amdgpu_bo *robj;
-
-			if (amdgpu_crtc->cursor_bo && !adev->enable_virtual_display) {
-				struct amdgpu_bo *aobj = gem_to_amdgpu_bo(amdgpu_crtc->cursor_bo);
-				r = amdgpu_bo_reserve(aobj, true);
-				if (r == 0) {
-					amdgpu_bo_unpin(aobj);
-					amdgpu_bo_unreserve(aobj);
-				}
-			}
-
-			if (fb == NULL || fb->obj[0] == NULL) {
-				continue;
-			}
-			robj = gem_to_amdgpu_bo(fb->obj[0]);
-			/* don't unpin kernel fb objects */
-			if (!amdgpu_fbdev_robj_is_fb(adev, robj)) {
-				r = amdgpu_bo_reserve(robj, true);
-				if (r == 0) {
-					amdgpu_bo_unpin(robj);
-					amdgpu_bo_unreserve(robj);
-				}
-			}
-		}
-	}
-
 	amdgpu_ras_suspend(adev);
 
 	r = amdgpu_device_ip_suspend_phase1(adev);
@@ -3761,10 +3717,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
  */
 int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 {
-	struct drm_connector *connector;
-	struct drm_connector_list_iter iter;
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	struct drm_crtc *crtc;
 	int r = 0;
 
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
@@ -3795,24 +3748,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	queue_delayed_work(system_wq, &adev->delayed_init_work,
 			   msecs_to_jiffies(AMDGPU_RESUME_MS));
 
-	if (!amdgpu_device_has_dc_support(adev)) {
-		/* pin cursors */
-		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
-			struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-
-			if (amdgpu_crtc->cursor_bo && !adev->enable_virtual_display) {
-				struct amdgpu_bo *aobj = gem_to_amdgpu_bo(amdgpu_crtc->cursor_bo);
-				r = amdgpu_bo_reserve(aobj, true);
-				if (r == 0) {
-					r = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
-					if (r != 0)
-						dev_err(adev->dev, "Failed to pin cursor BO (%d)\n", r);
-					amdgpu_crtc->cursor_addr = amdgpu_bo_gpu_offset(aobj);
-					amdgpu_bo_unreserve(aobj);
-				}
-			}
-		}
-	}
 	r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
 	if (r)
 		return r;
@@ -3820,25 +3755,8 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	/* Make sure IB tests flushed */
 	flush_delayed_work(&adev->delayed_init_work);
 
-	/* blat the mode back in */
-	if (fbcon) {
-		if (!amdgpu_device_has_dc_support(adev)) {
-			/* pre DCE11 */
-			drm_helper_resume_force_mode(dev);
-
-			/* turn on display hw */
-			drm_modeset_lock_all(dev);
-
-			drm_connector_list_iter_begin(dev, &iter);
-			drm_for_each_connector_iter(connector, &iter)
-				drm_helper_connector_dpms(connector,
-							  DRM_MODE_DPMS_ON);
-			drm_connector_list_iter_end(&iter);
-
-			drm_modeset_unlock_all(dev);
-		}
+	if (fbcon)
 		amdgpu_fbdev_set_suspend(adev, 0);
-	}
 
 	drm_kms_helper_poll_enable(dev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index b05301e1815c..ce8140c0dd88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1354,3 +1354,91 @@ bool amdgpu_crtc_get_scanout_position(struct drm_crtc *crtc,
 	return amdgpu_display_get_crtc_scanoutpos(dev, pipe, 0, vpos, hpos,
 						  stime, etime, mode);
 }
+
+int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
+{
+	struct drm_device *dev = adev_to_drm(adev);
+	struct drm_crtc *crtc;
+	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
+	int r;
+
+	/* turn off display hw */
+	drm_modeset_lock_all(dev);
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter)
+		drm_helper_connector_dpms(connector,
+					  DRM_MODE_DPMS_OFF);
+	drm_connector_list_iter_end(&iter);
+	drm_modeset_unlock_all(dev);
+	/* unpin the front buffers and cursors */
+	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
+		struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
+		struct drm_framebuffer *fb = crtc->primary->fb;
+		struct amdgpu_bo *robj;
+
+		if (amdgpu_crtc->cursor_bo && !adev->enable_virtual_display) {
+			struct amdgpu_bo *aobj = gem_to_amdgpu_bo(amdgpu_crtc->cursor_bo);
+			r = amdgpu_bo_reserve(aobj, true);
+			if (r == 0) {
+				amdgpu_bo_unpin(aobj);
+				amdgpu_bo_unreserve(aobj);
+			}
+		}
+
+		if (fb == NULL || fb->obj[0] == NULL) {
+			continue;
+		}
+		robj = gem_to_amdgpu_bo(fb->obj[0]);
+		/* don't unpin kernel fb objects */
+		if (!amdgpu_fbdev_robj_is_fb(adev, robj)) {
+			r = amdgpu_bo_reserve(robj, true);
+			if (r == 0) {
+				amdgpu_bo_unpin(robj);
+				amdgpu_bo_unreserve(robj);
+			}
+		}
+	}
+	return r;
+}
+
+int amdgpu_display_resume_helper(struct amdgpu_device *adev)
+{
+	struct drm_device *dev = adev_to_drm(adev);
+	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
+	struct drm_crtc *crtc;
+	int r;
+
+	/* pin cursors */
+	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
+		struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
+
+		if (amdgpu_crtc->cursor_bo && !adev->enable_virtual_display) {
+			struct amdgpu_bo *aobj = gem_to_amdgpu_bo(amdgpu_crtc->cursor_bo);
+			r = amdgpu_bo_reserve(aobj, true);
+			if (r == 0) {
+				r = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
+				if (r != 0)
+					dev_err(adev->dev, "Failed to pin cursor BO (%d)\n", r);
+				amdgpu_crtc->cursor_addr = amdgpu_bo_gpu_offset(aobj);
+				amdgpu_bo_unreserve(aobj);
+			}
+		}
+	}
+
+	drm_helper_resume_force_mode(dev);
+
+	/* turn on display hw */
+	drm_modeset_lock_all(dev);
+
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter)
+		drm_helper_connector_dpms(connector,
+					  DRM_MODE_DPMS_ON);
+	drm_connector_list_iter_end(&iter);
+
+	drm_modeset_unlock_all(dev);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
index dc7b7d116549..7b6d83e2b13c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
@@ -47,4 +47,7 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 const struct drm_format_info *
 amdgpu_lookup_format_info(u32 format, uint64_t modifier);
 
+int amdgpu_display_suspend_helper(struct amdgpu_device *adev);
+int amdgpu_display_resume_helper(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 7944781e1086..19abb740a169 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2897,6 +2897,11 @@ static int dce_v10_0_hw_fini(void *handle)
 static int dce_v10_0_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = amdgpu_display_suspend_helper(adev);
+	if (r)
+		return r;
 
 	adev->mode_info.bl_level =
 		amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);
@@ -2921,8 +2926,10 @@ static int dce_v10_0_resume(void *handle)
 		amdgpu_display_backlight_set_level(adev, adev->mode_info.bl_encoder,
 						    bl_level);
 	}
+	if (ret)
+		return ret;
 
-	return ret;
+	return amdgpu_display_resume_helper(adev);
 }
 
 static bool dce_v10_0_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 1b6ff0470011..320ec35bfd37 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -3027,6 +3027,11 @@ static int dce_v11_0_hw_fini(void *handle)
 static int dce_v11_0_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = amdgpu_display_suspend_helper(adev);
+	if (r)
+		return r;
 
 	adev->mode_info.bl_level =
 		amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);
@@ -3051,8 +3056,10 @@ static int dce_v11_0_resume(void *handle)
 		amdgpu_display_backlight_set_level(adev, adev->mode_info.bl_encoder,
 						    bl_level);
 	}
+	if (ret)
+		return ret;
 
-	return ret;
+	return amdgpu_display_resume_helper(adev);
 }
 
 static bool dce_v11_0_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 83a88385b762..13322000ebd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2770,7 +2770,11 @@ static int dce_v6_0_hw_fini(void *handle)
 static int dce_v6_0_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
 
+	r = amdgpu_display_suspend_helper(adev);
+	if (r)
+		return r;
 	adev->mode_info.bl_level =
 		amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);
 
@@ -2794,8 +2798,10 @@ static int dce_v6_0_resume(void *handle)
 		amdgpu_display_backlight_set_level(adev, adev->mode_info.bl_encoder,
 						    bl_level);
 	}
+	if (ret)
+		return ret;
 
-	return ret;
+	return amdgpu_display_resume_helper(adev);
 }
 
 static bool dce_v6_0_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 224b30214427..04ebf02e5b8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2796,6 +2796,11 @@ static int dce_v8_0_hw_fini(void *handle)
 static int dce_v8_0_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = amdgpu_display_suspend_helper(adev);
+	if (r)
+		return r;
 
 	adev->mode_info.bl_level =
 		amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);
@@ -2820,8 +2825,10 @@ static int dce_v8_0_resume(void *handle)
 		amdgpu_display_backlight_set_level(adev, adev->mode_info.bl_encoder,
 						    bl_level);
 	}
+	if (ret)
+		return ret;
 
-	return ret;
+	return amdgpu_display_resume_helper(adev);
 }
 
 static bool dce_v8_0_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index 9810af712cc0..5c11144da051 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -39,6 +39,7 @@
 #include "dce_v11_0.h"
 #include "dce_virtual.h"
 #include "ivsrcid/ivsrcid_vislands30.h"
+#include "amdgpu_display.h"
 
 #define DCE_VIRTUAL_VBLANK_PERIOD 16666666
 
@@ -491,12 +492,24 @@ static int dce_virtual_hw_fini(void *handle)
 
 static int dce_virtual_suspend(void *handle)
 {
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = amdgpu_display_suspend_helper(adev);
+	if (r)
+		return r;
 	return dce_virtual_hw_fini(handle);
 }
 
 static int dce_virtual_resume(void *handle)
 {
-	return dce_virtual_hw_init(handle);
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = dce_virtual_hw_init(handle);
+	if (r)
+		return r;
+	return amdgpu_display_resume_helper(adev);
 }
 
 static bool dce_virtual_is_idle(void *handle)
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
