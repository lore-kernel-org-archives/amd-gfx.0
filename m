Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBC4C433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A037610F7
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A037610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD69B6EE34;
	Fri,  7 May 2021 14:38:25 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760048.outbound.protection.outlook.com [40.107.76.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3409C6EE34
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 14:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jl/xl1dYmbxG5oVUsfJNCS35GXu9WPdIOaQTRTkRnSKDrJYQ31xjtyBUtHHfdkFeAs2TslJW1YAxUZzba3L5NN0b/5vv0viq9leUJEL/mEUX+P+4tVoRV9FClq7GuY1tTW++6fQuWBKORiLHLfI5uY3k+tYihAHxPYIGiIBMvG9ETvLEQLi/l61i3mLOj1pRDdKY/4zvPxu6avuOcJva76pQRysQmfTSm4p9WtskMN0NKPJHR2wR2wuRydLILwTNDkMw19+gPxeHAOvmgysdUC9dkCI8Cmq9yYQE/Fh+BsfSwTGNGOsA1aTStMP5CXJNSGbE2M7mCdqmDEK27ueR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqUgURkQXuIuY3HAR31uXNKVmu5SCCViUiZP6daHn+I=;
 b=ofEOgJYCH6L9310asj2/HyrDOj65IyfOvgOAtasKInt23P6ZyO1pRy2AaWYIPlGIhn554xZTOMroY6mzPzUlkK6BVcF7OcHm8mC4OLAD4YsT/gnqg4wOrcrjY1VlfwlukL/rhKVpdXU1+r0TEIv9A70CK4ineG3Yb92XqaV8kzduRfTaTnLhzlYyQwTiu43pPO6OHLmpTCOgA4VUzn9lqAr5BXspErzNwFMVsui+/k3pTQE/itKSjl0fXKFIp4CNVpIhb1814hE1zx92iTd4i50vjj1BpIqXfxfNzpS3VU0udssAT5XeFLh32Am5sdK/zuzzvuqyb+Y9WdssZ3Yntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqUgURkQXuIuY3HAR31uXNKVmu5SCCViUiZP6daHn+I=;
 b=l6yXH6abEk1RXSm2rHbHGll9ja59Gbniy13FyrE6Whsogk8MKBmYYBk6CS1+vu2+Zu/eMkCVyUtdlmCvTUfd1zZ//yjTBVaAblQIZF+UO4ZFE46A5JIuZIcEb55uLXklA8+V78ey2x8nphqeR7Ac0KyjKD0NH7QT4FYC2iJViF0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Fri, 7 May 2021 14:38:22 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101%7]) with mapi id 15.20.4108.027; Fri, 7 May 2021
 14:38:22 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Make underlay rules less strict
Date: Fri,  7 May 2021 10:37:59 -0400
Message-Id: <20210507143759.1546044-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [2607:fea8:56e0:6d60:ae2c:6ad7:f7d8:54c2]
X-ClientProxiedBy: BN9PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:408:fc::22) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:ae2c:6ad7:f7d8:54c2)
 by BN9PR03CA0077.namprd03.prod.outlook.com (2603:10b6:408:fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 7 May 2021 14:38:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb8d7b95-e743-4d58-99ca-08d91165c3d0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4497F2CB7533312569427EAC98579@DM6PR12MB4497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:428;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uowq+X3nBntGQTiETeZ2Fkp4iNhoLUOjfPwNExqabGq49LALXa9Ic+GROutsTSKc4uaWwXRypF9Fj9ftMLgUyYU5Yi1dFz1xntCAdWX/vM76To5Yncs/p2hETT5km/nRQXAqhsPFty2SpZ0N5dr4WqiJ7IXlcsp1odfZIylnPW/0Yb70faNulXkdeM/rQxNbB1ixT0NTr1iBzqnhLTHUVS9ZRzI7gOwzcwAEjznNLghSPdx4l3pLCs3pXbgLVIDBBxaLQoxLKXJuHQ2ae5L4JkcyLHmcmMPuXBO6y0dJkNZB9+5EiI1Xd5+Lowlhenf60hrepasQR5YdwA+1vub7u3riflQZ4o5CQLYLVxZlegBrrdyGCe+R7AxExF0ImPTX+oG9M1dishZ2LYKxxa+lr/rmilnZnUNI9ogP40jeaCh9VS8XNB3HLxvh+Xeb8dIU/ZKqIGG4Qhipo5OpexwpkHE4mKDV3U6yri89lO2Dy8fH5uVZ8rTHfQmzqOgqhIDLtyoio+hfvtU/kF/g4wPFbLCFMT8snrvdZfYPPvRl+JfB8CEvxDxp3XylUJFzP7XXIP8Y797ggAyG+xkiwntjTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(316002)(6512007)(4326008)(86362001)(6506007)(6486002)(5660300002)(2906002)(1076003)(8936002)(66476007)(6666004)(478600001)(6916009)(16526019)(83380400001)(66556008)(66946007)(186003)(2616005)(8676002)(38100700002)(52116002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5NBYkhAm2JXt86O2p3T49CFyuh3VUh116CvHRCb8Xz5hnfXngoj39HqC9XB/?=
 =?us-ascii?Q?xf92ABZUOtjFpqJdxtQ0OqmEojdPH7HJ809Pz2TkEkZ6udbvyN8Ean78NqnU?=
 =?us-ascii?Q?ikhTLA4ClNAGw6NQoOsrXSYg0kYEX2MlC+A/kv58jWvXapRitdMFBEw6A3Nw?=
 =?us-ascii?Q?k+Z4dFHHtH2CwkTZBq8Wo/TAwgLuPH+pCIxq18SGQ8VhITlQQKHcg4YxTACZ?=
 =?us-ascii?Q?PqDakopNHFjZOBLoHCndOktE7SCCW+ZKQTaNgEFjmL0IXjUsRLGte13LCqvd?=
 =?us-ascii?Q?TPDGUoFvyKQ2jeg5zN2vbbHOLMwtPItloGwBT15PdRnJZZrX6eXpsH91gvmm?=
 =?us-ascii?Q?cCRStymqrENQDOWd8QcMyTH1I/NbcqzkWJ80m7S6TPz5wtCgbVyuOvAw5fEQ?=
 =?us-ascii?Q?mJ6KQI0Lv48d3DVJzfFfN4mmyu9gL4ofXRco2lzcm7yNlMW1TdgtPbwLIv3A?=
 =?us-ascii?Q?jFCsGva0E+9VUGFLH7WSYbGMK5cZV2YEgXc4rwZzfObtAw9s3wkxTrKrpugO?=
 =?us-ascii?Q?KpPpFIPUIV7K8SNiO+wpavmHXpX9Cp73Obk95YKndodMTJJZv5NxPOOm3+aB?=
 =?us-ascii?Q?HVuwdACcaVYIvLhIqq4ZIFNUEq55J9Qf9FroQI2lgci8grTOzJ1Jtm7PHj0d?=
 =?us-ascii?Q?Gda4i51Q+HytTjYC8/VTLZX+PznYT13Jz5TvkxcKii4aQmkES1hg3Row3V3F?=
 =?us-ascii?Q?BjgxvG/uGdiOkrvJ6QulmxN7B+fohMSfz35MgJZoFtX5TgGWkX28eADussDQ?=
 =?us-ascii?Q?FCGZ84r4pIW5BtIKdqo+fmMuw0QqTbk5Ncy0Jr5pgihWhqAve6mBswxHwDNI?=
 =?us-ascii?Q?1GYBb8z4LAxHNG3Ox+xrUn0JwPALwA6k3PaxRUId6h0O2uUXCL2gwn5ZTRG1?=
 =?us-ascii?Q?P5RJQHVtOoCVbf6mCQpwCxMqFYewMornVJVqJYQAhNd02KlNn+nBB2iWqffT?=
 =?us-ascii?Q?v2Xi5vq7B8fxwdz3Js+lzIOE3WVj4IewaqHyiglwQQNJRIpq0R/rE/TjuPdy?=
 =?us-ascii?Q?8V2EYd3a2ZqIhSU+Hg/EJIKRah+c3PNlrpRVqA2WEOjQwS0SJyt+rAi18mJ6?=
 =?us-ascii?Q?Etkl5xNxXYg9QwbdxcKcv+X1wpeh9Ie+wJWmE3CcMzIIz3/ktMuA7hWolzIN?=
 =?us-ascii?Q?kkAswsDRp+5aiZ22GAISgs9QRKAHYyFwvjO4rK92OfobRsT28oM+wQqB1dDq?=
 =?us-ascii?Q?C51V77Va1YZXH2pjb4YLicSeNUS6rv2FtKXkw04KSMTdwUlpoCx5/LugF/j+?=
 =?us-ascii?Q?YDvoHlGpJbuJdGth9+Hi4pKe6+9Vh8Eqd5XQ7lNkrkORPW9oi/npPD0/eTQy?=
 =?us-ascii?Q?T1XDa+HXP8lv3d2tN2Kcm8WRz7Fmtq3Pz/dLsbv5Olu2bsMHGo7qkXEa35Un?=
 =?us-ascii?Q?d0+tI49WKvyOWuJAr+D9DuYPpgyH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8d7b95-e743-4d58-99ca-08d91165c3d0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 14:38:22.5712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBdb47suUd74oiS2d7GyZONF9rbc2OECw1eaXSBeoWIY/HUjqGfb63tdsjOPT+DBjnpxJq7cnTulWoWSdeateg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
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
Cc: hersenxs.wu@amd.com, Bhawanpreet.Lakha@amd.com,
 Harry Wentland <harry.wentland@amd.com>, nicholas.choi@amd.com,
 nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently, we reject all conditions where the underlay plane goes
outside the overlay plane limits, which is not entirely correct since we
reject some valid cases like the ones illustrated below:

  +--------------------+  +--------------------+
  |   Overlay plane    |  |   Overlay plane    |
  |                    |  |        +-----------|--+
  | +--------------+   |  |        |           |  |
  | |              |   |  |        |           |  |
  +--------------------+  +--------------------+  |
    | Primary plane|               +--------------+
    |  (underlay)  |
    +--------------+
  +-+--------------+---+  +--------------------+
  |    Overlay plane   |  |    Overlay plane   |
+-|------------+       |  |       +--------------+
| |            |       |  |       |            | |
| |            |       |  |       |            | |
| |            |       |  |       |            | |
+-|------------+       |  |       +--------------+
  +--------------------+  +--------------------+

This patch fixes this issue by only rejecting commit requests where the
underlay is entirely outside the overlay limits. After applying this
patch, a set of subtests related to kms_plane, kms_plane_alpha_blend,
and kms_plane_scaling will pass.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cc048c348a92..15006aafc630 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10098,10 +10098,10 @@ static int validate_overlay(struct drm_atomic_state *state)
 		return 0;
 
 	/* Perform the bounds check to ensure the overlay plane covers the primary */
-	if (primary_state->crtc_x < overlay_state->crtc_x ||
-	    primary_state->crtc_y < overlay_state->crtc_y ||
-	    primary_state->crtc_x + primary_state->crtc_w > overlay_state->crtc_x + overlay_state->crtc_w ||
-	    primary_state->crtc_y + primary_state->crtc_h > overlay_state->crtc_y + overlay_state->crtc_h) {
+	if (primary_state->crtc_x + primary_state->crtc_w < overlay_state->crtc_x ||
+	    primary_state->crtc_x > overlay_state->crtc_x + overlay_state->crtc_w ||
+	    primary_state->crtc_y > overlay_state->crtc_y + overlay_state->crtc_h ||
+	    primary_state->crtc_y + primary_state->crtc_h < overlay_state->crtc_y) {
 		DRM_DEBUG_ATOMIC("Overlay plane is enabled with hardware cursor but does not fully cover primary plane\n");
 		return -EINVAL;
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
