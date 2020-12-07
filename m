Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21395C4361B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 22:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D86E6239FD
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 22:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86E6239FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49FF889B97;
	Mon,  7 Dec 2020 22:55:45 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690061.outbound.protection.outlook.com [40.107.69.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9628289B97
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 22:55:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NicxBNBxLz+PtiY0S8AWvr7jEZi81m7+XhN3PW5gWTomLdqi0gY+YW1fymY6fHEmhaptlEw9zS+opsuWF7RXQNnPAeH4nj8ifWGdgBmYvORXOAAVklm/uZhBV7Jp2eL5fh94HShdxNnlJuPQhIhUccMHsFH4bBv6eu8sJT8J4ZJeLCEtp4tq90rDPjxtk9p/SAERwpNknd2BN7jeznuFfAlXwL6SdZDquRBudDXAoXsdGCJDQ97uDBgduhTmwQMcSlKwH4CzphPBgBWIGuAzwLYqM3cdpvAVtHc0NcM9DbeX9zZsQVVM6TDJpOm9+/dkl/6hzkjsKSIYzUVg9r7GEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaTZm0ZtMrIo8i0NHkuKxB9H5T2Mu6t/dzZweZuGNFY=;
 b=Hf+IhLG1QJCExFm1L+9C7sfDqIwd58Ys0QjJUe4Tk4EXRZh6qxGJunVrMwCebKaxNzsrOG4By7KQVb5zQaTreuoPcXVw9u/MhRqYqT9y56amvdJSzYZPpdrmCtddXN+SQtDqqqnbwpiDhLboTUpIs9wrAnmxpdGFy0KQYb+XL7QT3j1Y3aB4arl5BBr6kZRnPM+TAVn7bA/PgwnZN/q1UohdEmQCZa6ki9YY2Y5T7oeD4A+8tQno/UBfsiD2BoIirrRwJJYpCg5zk/PShdymfwadJ25w0vxveaByvyMYmXPHoSEWvtomKW1xmyc1jiY6HYSGLGcbUtHpMYjIyw7I3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaTZm0ZtMrIo8i0NHkuKxB9H5T2Mu6t/dzZweZuGNFY=;
 b=ckzBXdEIsaq5cICqSpIFJDBDSMRhJDpHVeT46bscfySW2b/k4+pWf+QSw5aXk8VPKW5BRPbXXSZC1GMn8Aq6wzfyMXI0nU8lmNcdWTpIm5BRxmscfejsJzMGrleExh9GJsDl+Ct2qUgplI5DiBR4kEY6qFtODSyWFS1eAxZn1Pc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4905.namprd12.prod.outlook.com (2603:10b6:610:64::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 22:55:42 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::3d69:e706:b212:e31f]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::3d69:e706:b212:e31f%7]) with mapi id 15.20.3632.021; Mon, 7 Dec 2020
 22:55:42 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Harry Wentland <harry.wentland@amd.com>,
 Nick Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Drop unnecessary function call
Date: Mon,  7 Dec 2020 17:55:23 -0500
Message-Id: <20201207225523.2122889-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [2607:fea8:56e0:6d60::bef5]
X-ClientProxiedBy: YTXPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::29) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::bef5) by
 YTXPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Mon, 7 Dec 2020 22:55:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 80681ee9-c6be-42b1-a634-08d89b033961
X-MS-TrafficTypeDiagnostic: CH2PR12MB4905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB490501E496A82F5DC2CCEA4198CE0@CH2PR12MB4905.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:374;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xiTczEe8AtY11Y/GhRB5B6CDwPA8ljnZG/72A6SF3hxt0NQcOhtxXS75AfCcvZvAkOmipC/6zlavsYyz/k41aMxpqgUejelH28fFIUySi8O9myECy9POFFxCVLHeRHd5mCqMTnCbZ4n3nXpPFxM+1trKJQPMiQQtLlz3CwjsMqnlCqeBoRrR3GXbqG+7avaz0FxtPT6Ep6NLCiBHYJACQcaEShpvH5ce0JAKOp+lRGTAgQNiyGocTF3MP8xuWpsGgmV+07fxzXZCCl5nkJR1wiI9OEccyBQnn67TLxm9U0azTnfYxi1cajX03zvz9A/M
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(2906002)(66556008)(6512007)(8676002)(66946007)(6486002)(52116002)(1076003)(86362001)(6636002)(83380400001)(66476007)(6506007)(186003)(5660300002)(16526019)(4326008)(8936002)(110136005)(6666004)(2616005)(36756003)(478600001)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?66t483f8FxUo3ZU4XQoQFxwS/PSFWtaqdu+dmJJ0erbxcahfZqsxGPZbSnhN?=
 =?us-ascii?Q?QMWgJWR7/Gp7g6ThvbH4QsJkuwk0VQx+5CiZr8jUg/Sloi6p+El1ziJkxVci?=
 =?us-ascii?Q?u5UzQbK+cbbLNz6BWRA+h8AARt84fHp93gMm1hQ9SJjS2dRTdjq+tc0f4pCk?=
 =?us-ascii?Q?Eex3ZyTwQUKqqmrcABQu3SHINE4XdJWWvU7J/5tGRhmc7GNxT3RSJ++Pi5Ut?=
 =?us-ascii?Q?XRozc1fznAsnyqA9hcdTIxFAlhqXcg9aqp0B3caKaThaI63GkXvoCw0e1fg9?=
 =?us-ascii?Q?RzRXis72HVCBEvKB6gctPnS9JBnXnjidbH0aiJSxPcFd/5ZD0QgLNPEPwlaa?=
 =?us-ascii?Q?D3pT4ybZAQtEv1d30aHMxB8JugCoR6lfh5/kR2xKBmEnMxeHueJTOyPkS3aN?=
 =?us-ascii?Q?WvrzaQJsMQdJX/Jb/CvMqDhbW699RpsmR0vd0AGAHwHm5mgnYeb/xHBS9VRE?=
 =?us-ascii?Q?MOvKT4+kBdb28FLgo88WvzpFz+WU2sAmbOnznCvHG8m6unh+PFc0TZj3UELM?=
 =?us-ascii?Q?7+QTwtdzT9t4b6l4GVvaiUwYqewdrbjU9htVg/TD8mRwLXPXghiQS/BByqpV?=
 =?us-ascii?Q?Lruho6q13VqQAuZwIPKMzdmmVPOA550wJ1CUYbWsfarbFKDcnk+UIi8cFbtr?=
 =?us-ascii?Q?OfBz8jBvuRVXhXdDDeMVBx+RBQgFMnFqWs86Dedjmcfz1BSxC7AT1Jza3hJW?=
 =?us-ascii?Q?VwHPoFFSiSs4En6yBDyQWjmOYUw50AVoGznDkRAIsV+/Z58SF25KkrqZsTJe?=
 =?us-ascii?Q?sVe2bdgEscZkmbR5CZb4ukCVFmAd9HIgoTrcMDKCdTUTw94SUHBN+z5YoxB2?=
 =?us-ascii?Q?5Wb/kYBO393MgQfYgbetK09XsrArZTQrlfUO/LWQvn/DNkT0+xLsVKKPbslG?=
 =?us-ascii?Q?H0o8s5qOCTCiO4F70VZgMvujYGiC5lQjUy+M3ON1BteO9BgMmlsc65Ur9PoI?=
 =?us-ascii?Q?PohVyPpF8eKQbYUOjRLJCEf5Dvc6eyXHQM1t/QIpYPBOrWQ3Rnc5YG+Elhl8?=
 =?us-ascii?Q?PoVX+Wr8y6wVKVbHcDeTd2B+DA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 22:55:42.1483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 80681ee9-c6be-42b1-a634-08d89b033961
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QlXtI7dQ5zn+2sERnmIkg0lmvfQBvDNRTYzOGrkIqNvTMj4fy84AeCO+nzZLbi2NvSXo/mgtwQLFACy/1coMZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4905
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After refactor our amdgpu_dm_atomic_commit, this function only invoke
drm_atomic_helper_commit. For this reason, this commit drops
amdgpu_dm_atomic_commit and add drm_atomic_helper_commit directly in the
atomic_commit hook.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a37948f2e596..c89066b1c471 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2212,7 +2212,7 @@ static const struct drm_mode_config_funcs amdgpu_dm_mode_funcs = {
 	.get_format_info = amd_get_format_info,
 	.output_poll_changed = drm_fb_helper_output_poll_changed,
 	.atomic_check = amdgpu_dm_atomic_check,
-	.atomic_commit = amdgpu_dm_atomic_commit,
+	.atomic_commit = drm_atomic_helper_commit,
 };
 
 static struct drm_mode_config_helper_funcs amdgpu_dm_mode_config_helperfuncs = {
@@ -8158,20 +8158,6 @@ static void amdgpu_dm_crtc_copy_transient_flags(struct drm_crtc_state *crtc_stat
 	stream_state->mode_changed = drm_atomic_crtc_needs_modeset(crtc_state);
 }
 
-static int amdgpu_dm_atomic_commit(struct drm_device *dev,
-				   struct drm_atomic_state *state,
-				   bool nonblock)
-{
-	/*
-	 * Add check here for SoC's that support hardware cursor plane, to
-	 * unset legacy_cursor_update
-	 */
-
-	return drm_atomic_helper_commit(dev, state, nonblock);
-
-	/*TODO Handle EINTR, reenable IRQ*/
-}
-
 /**
  * amdgpu_dm_atomic_commit_tail() - AMDgpu DM's commit tail implementation.
  * @state: The atomic state to commit
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
