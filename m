Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D99C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 14:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C1064EDB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 14:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C1064EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F2B6E9A8;
	Wed,  3 Mar 2021 14:39:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 517196E9A8
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 14:39:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRL12IuZcmZi8tB70qDH59yTucMqO9frmMO7P2SFWz2F8PWceeb4Oup6lf88YLyBQ+K0tzAET7CUeEVE+88SdsFgPeTn/Tg6BqWdB3hu9dFiHBVfKhmRybNSJynh0RSGDrCqH6xP5RU+itGwvw3CDvwI77PFcK9LzLafh96jJSnjA52iKVuXVqwVKNWgpnC8pB/hIH+44utvsJ2Wylny2dMQjoY4QnupSSWgY0WDbI87vcBMVCiDkb4O0YJ7dMAvObXfTVHiAjSi/R/3HmNRXgljM1N/qkaY/evnNkM539RrgD+j7yOkmM0t1ou8t6Twz2FP0eKaoR7vctLk9RP8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVyQVgiGkcAEipiuu2h9Nijz2q8gqhvam5xvqiaVU50=;
 b=RoWb5Kygrw1sq3BlmVEnsE2C0I0oNsNK7ZsmoFF5iiaWnZPsYf3APWE56TroOkc5X54XEijQUaWtSE5Mzuj3DsHxfEI0Z7mdz85aBt1Mts3/4vKH+fiAnPwetL7VhBbUJaRTltuJSivi1ohvcETxjG/AKUwNmWXSTCxECWVzajjylyo+rYmaGqPzo6mcdZdJugd25M68nhu1RpoXVZwTtbWgbuEiQ9bBv8/pHquRTt4zx+EDeXZT+I3tHoR50kHTg9x+Jqt3432iMb4v/l6U/uPzU8UQhVW4XF7lWvHjMhDpKgwuYiVzMT+EjanJT97IHHYFYjtPIrlhG4mYDHsglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVyQVgiGkcAEipiuu2h9Nijz2q8gqhvam5xvqiaVU50=;
 b=0XH9UpajukV0Eo+TdiCPSzv58cU3Tmbx42Cy/2q829aIcqPUrQyZ5TYeeYQD0mwdlJBzoNeNv1WRINTJJsI6Qix270zcKboZqwo75i7D2oGNeLQ5q24BQsqwHRlJrJHbljY6ZhFPto99B1u4WY6Rs3n7XJQSwvmQKA184QEh1yE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Wed, 3 Mar
 2021 14:39:15 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3890.028; Wed, 3 Mar 2021
 14:39:15 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amdgpu: Verify bo size can fit framebuffer size"
Date: Wed,  3 Mar 2021 09:38:58 -0500
Message-Id: <20210303143858.20779-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: BL0PR02CA0125.namprd02.prod.outlook.com
 (2603:10b6:208:35::30) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 BL0PR02CA0125.namprd02.prod.outlook.com (2603:10b6:208:35::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 14:39:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4053fccd-b152-4aef-36de-08d8de521e37
X-MS-TrafficTypeDiagnostic: MN2PR12MB4174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4174A24E25DFFAEE1657E8B8F7989@MN2PR12MB4174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0AH+J0vyOyrDEN95xHRRi6lvV++qFeE1n7Yw8947pGJQhFDI/hEeRE0zT0V9FRXq3LCK7lxsfAlQ+KaQ/ad3UvCsSEzUFUBvPtp1jtV2uu7cYr335CpqzT4t43bQWxSfK+zEClBmaco77DxlJO6pU0cWIYI5J2OJafxac1AQhsCRmhZZ5a+HCq8ng6GL9h7IB2Oge5D43cbiPc8Z82MPinU8XNG9tPlftXlcMSSDDCO4y3gHfNrsgc5uVGdBc+zPJ53+ku5VGhoxJiY2E7hb+5MDuIzNazi8lLUbNqxfl83uqV4olaJZfgsLkyRzmOpkW8V3oz+wa4mbnoXngi/Mp04cXgZhO8Pq8I4fayYfvcl5iKfVpRFla9uvO61GOioSTlU5Q97xxNLa89EKeTUW3qk7vtQ82TRZrVqUzcL1wpaVnF3Qc29XZpiDo0mTrOIXXScGVCqI14iT8UzS/foTvSs2qtfil6oHK/gNJpcpyWsVjixJZwj4QrEZfPDrS+cGUAIuHogonzPvaZ9fSHS5+uWzVKMF/kpNdBNStVLTpAPylcO0a6CMLVwKuvyTPA8XxwclgeuCVAuDPfP+kASH4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(16526019)(6486002)(83380400001)(186003)(6512007)(2906002)(69590400012)(2616005)(956004)(1076003)(6916009)(26005)(478600001)(5660300002)(66476007)(4326008)(36756003)(52116002)(66946007)(6506007)(54906003)(86362001)(8936002)(6666004)(8676002)(66556008)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lTtb8Fm39r8aKQ7I82IvjAXrrtHO7R4FGxxfsgC+js6KY2t2lBPCRjNC/okT?=
 =?us-ascii?Q?AromKoOwjG2RjDdy/mm46/ORBu6MjORdsfHreFUtle1QaRUrWpGQv7JtP8Wp?=
 =?us-ascii?Q?pnEd08cCEslIwlOQrCxcxNE+FhRUKAyyzGOikxzZKxmnlsrM329aVwwRHgp1?=
 =?us-ascii?Q?aRQQ0VxQPPma6N3AqqkEKRc2H/3YxPcSyTAvw5sMUP712tR9jMCUZySzxMdF?=
 =?us-ascii?Q?ybK3U8N6R/Yj6llN5TGCVr/Ady/9tCTDz2NobOos35IpUgXN/609OzcPIK7a?=
 =?us-ascii?Q?84Z18l0OoovIp5KMejAdqTBZ+QuMy6MSS1/rwA8bi5EssSGSVCiU3RXXCFEI?=
 =?us-ascii?Q?flTTmGM3eHyt96ukvddOySZMj5C2FvL15FVOfywuBWw2IyDSEGE7bKVBeXMI?=
 =?us-ascii?Q?oWPXhlgS6bmQCgJWXDiTtGHiTat1dtKxqx72NK3AT1rOm6hZJAEa4G6tUEhd?=
 =?us-ascii?Q?3kGE+e7DSn3nBcSs8A1vsQ7rv/Dak06HiMieJZHwdOu51pfqtp4QTstw5RSP?=
 =?us-ascii?Q?1+ee07x0mD/jPJ/ZpxOh7OslWXYsl80ZY2I11yX2fSQVPSzu1+S9R3GyMQPJ?=
 =?us-ascii?Q?6BagsINzkPDEAaOcz6les5q7lx88+WR8EDhOo5A4eWRNznuUQfTWSpiu4TJv?=
 =?us-ascii?Q?lcEMBDnssf5mStl8bEc30gSLWm/rcLyDW+3G11sfMWVB6yol1g+nPv8niXGh?=
 =?us-ascii?Q?jB6BeArs/1oKaq/b/WIOAK6Hb+jKPr5Xa2VPJPmyz7r8XtKqteCJxC8PQ6LW?=
 =?us-ascii?Q?byYqugDHtSlkOHHjM/9r+1Vbh26pj6R8QTNKTDi0HP77VJbc7Nt4DSTIHJRm?=
 =?us-ascii?Q?dfyFOkHksCcRp3TDr/TkBG3egV1HOcsiRuH7zwiEN6ycofbHovFdNPgRaIPt?=
 =?us-ascii?Q?fzAPzAHX/Ke7dTN3w7vBq3WOsbMbOX3XMUXXh5J5ryh4K+giOVSu2dUYTsjr?=
 =?us-ascii?Q?dk+jT+EK6GdmKpXMiIOUrTGB+va7NexGMAfok1/3uwZi2mv/WZ7laTB9RM0j?=
 =?us-ascii?Q?gvHIFDnMK/uix3ujMw+X4GiDVH3wS33d3tFdQIOORPV2m88xq8JFzdGjzPBy?=
 =?us-ascii?Q?+s53r9gkSCWZpzzbvY6TzakYl/HJ/7YLJde5HjiUYJH0UH5XFRSpMjQjoR5f?=
 =?us-ascii?Q?hp30teQNVg/RZaRvOxZiCAUiy6XalQtlJdj8Tp9wnuHXsB8jdmvCiUOYy3E0?=
 =?us-ascii?Q?HoSHnofD00ZyGz7X9ZawaVNoPwTf7DJbsO3hwiItcRPUU0/uFCqa23/NoaDa?=
 =?us-ascii?Q?Yknmu6rxK4ylGUUEN2H2Hhl88doxfwFLhHVThqKeEZflpimMXr9kJu74D85e?=
 =?us-ascii?Q?9f1zEELd2QAA2wvGw5XFBXi9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4053fccd-b152-4aef-36de-08d8de521e37
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 14:39:14.9858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YqeNeTe8nYM0X/srx8tJn56HHA4QIQk6fDGhgSJzGNmNxt3Hjq6s+uNiHTBOc7L3FY9MvvIIg9G2/F0GZdQYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
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
 Mark Yacoub <markyacoub@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit f9d2476012ddf26fab652ee0dff697260040924c.

This leads to a failure to init the framebuffer.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Mark Yacoub <markyacoub@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 8 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c      | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    | 1 -
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 61684d543b8e..48cb33e5b382 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -872,14 +872,13 @@ static int amdgpu_display_get_fb_info(const struct amdgpu_framebuffer *amdgpu_fb
 
 int amdgpu_display_framebuffer_init(struct drm_device *dev,
 				    struct amdgpu_framebuffer *rfb,
-				    struct drm_file *file,
 				    const struct drm_mode_fb_cmd2 *mode_cmd,
 				    struct drm_gem_object *obj)
 {
 	int ret, i;
 	rfb->base.obj[0] = obj;
-	ret = drm_gem_fb_init_with_funcs(dev, &rfb->base, file, mode_cmd,
-					 &amdgpu_fb_funcs);
+	drm_helper_mode_fill_fb_struct(dev, &rfb->base, mode_cmd);
+	ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
 	if (ret)
 		goto fail;
 
@@ -954,8 +953,7 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	ret = amdgpu_display_framebuffer_init(dev, amdgpu_fb, file_priv,
-					      mode_cmd, obj);
+	ret = amdgpu_display_framebuffer_init(dev, amdgpu_fb, mode_cmd, obj);
 	if (ret) {
 		kfree(amdgpu_fb);
 		drm_gem_object_put(obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index 74aa80e11a80..51cd49c6f38f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -233,8 +233,7 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
 	}
 
 	ret = amdgpu_display_framebuffer_init(adev_to_drm(adev), &rfbdev->rfb,
-					      helper->client.file, &mode_cmd,
-					      gobj);
+					      &mode_cmd, gobj);
 	if (ret) {
 		DRM_ERROR("failed to initialize framebuffer %d\n", ret);
 		goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 997b93674955..319cb19e1b99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -604,7 +604,6 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 
 int amdgpu_display_framebuffer_init(struct drm_device *dev,
 				    struct amdgpu_framebuffer *rfb,
-				    struct drm_file *file,
 				    const struct drm_mode_fb_cmd2 *mode_cmd,
 				    struct drm_gem_object *obj);
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
