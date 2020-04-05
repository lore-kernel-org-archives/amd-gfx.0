Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E69C2BA19
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CDD520644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vfOhTNUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDD520644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D56926E2B0;
	Sun,  5 Apr 2020 20:42:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36F796E2B0
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=md2rfM03k1EezUg23WPnvwJUitBJJvUSzs2ewASa3FtXgYAf5o+9YjqL9Y8YDXP9ovPZ2MAGh2OPmVsn5YCcExOceQIwTUjsaA3voDiMrW/VhinLTTDNvIo4DdxUSOH0OcKCdES6he4xzF7A0cmsfCpFlgfmiqJ91BjKcw+SJ7iAWi/JKwz9ii2+hLv3WzqU12f83TkCAZFPh5z8B1mTj6w0+Kp3LukXWB7D/zg8Y5HXYwxb61nkdEn2b1oeH1eDMVWGn9Wq9c2K9sXY9SbqqsXETz1UswdrRE4XpL1sIAkY0LsR7dRGf4lckQmIDkR5YKCnZRu6kQ6ItcoILJ7X6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQXZIprqYFb9MWjxiU6KilGbnw6wtrzH3uZOIe0AQ0k=;
 b=b3vgusTXQUCfXi6+IZ+PqweQiJN8361sk+5EcRfC5snzSIo0CZfuCbyBz3K2UH4bo/2Pm+pooxsVlof61aBUOLka3c1Yqe2VSZMWud322vhs+tS2BfFnHV5L895uc5Cdx5OlyvqEYVpPUrUwRcyqK7f9DLHzzK7VjCyh9LBQ1vG8prt34leU5eJiAqqOvuasasAUCpI5BBNkTAAL1NsFVeS3zHgnQuQAidfRu7OqTN01dXcjGL/j460yEzA4Ubz9IHAmot3UKXARtChKwmtf/4BCcVuM0Um/kmajg6xwKmDEvvoo6E62fRmwK0SNoj2UVQu9eMSe9W3dmHQQkdU+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQXZIprqYFb9MWjxiU6KilGbnw6wtrzH3uZOIe0AQ0k=;
 b=vfOhTNUznODjj5UImcRtAQ5mGbLhsPL5+WzW0lSy6Jy/7xBlYhQEkfm2DdNUbaZCUVZ0hNsOKk+qetrcnRKW/iLAUKf6BjHb9Bc506BE+mgH0LGugN3eOxBStJ5TsyfgYKQyrbtrvoE1INX4kdTob1sF3uoeeN5+d4bIXTpHMkM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:42:01 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:42:01 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 23/36] drm/amd/display: fix dml pipe merge logic
Date: Sun,  5 Apr 2020 16:41:02 -0400
Message-Id: <20200405204115.683559-24-Rodrigo.Siqueira@amd.com>
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
 Transport; Sun, 5 Apr 2020 20:42:00 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4795d071-ec1f-42a1-afea-08d7d9a1caea
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB255586E0791501C137C021AB98C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
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
X-Microsoft-Antispam-Message-Info: UzFZD7tfmoQXlANao6IsPVPCF/Qa+4Bcm0EOzwSr8jOVBHyt20bM4QgON4vyYnhhFGtrnoZAkAtJc/kXZzbvvwh90x6ttPktcPfFZ9XnFhnsbyabdg+k9sadtMKl9rcv8H8RoHhPTMe1h3HhA8q4a6/V7aJPeNw88WsI2y/Fo4YKXOf89sleO9lnl2T2Rb5la/aq5FMy1fQ2H65VSCZtYY7k+0j58fG/bQc0246e9gqRQAaJfp1sx5WJzRqwHLgaCHLLTIJ0ms+IlMb/bZIBo28mFwWSN+EbiEEkGnRMDZVGWRSALcvpVP+ktUben429kfZK/mr2z8wRnw7m+B9sH2hdOIAXPWPbKkc0KlhdYN3tNuJCYxNoXaiI5e29an7tlYrdhoYL+w5eF29rRAxQca/N8BQvKiJRLkd7IsZ5q59iIVuaV3tRwT+RyHFvbFZ/
X-MS-Exchange-AntiSpam-MessageData: IXJPZh8OE8LK+Uf/iHi/H2Crso+K29hecDHVQMl91A3SWP3OwfwyJWDzCzuMdY7clxDOIcuNUlwS8gJfGwNnm3MqcZNPXVP1MY7t2crmINVib0ArFShZqqvQUQ7aoNlOxClThd/gIpUr8wB1YaYUE0K6XJdz9wY899xqQnAgoZ4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4795d071-ec1f-42a1-afea-08d7d9a1caea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:42:01.5703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGLo0xKPOC4IwMkRAmygF6fH4M+8A0qYr9VnNRqzrzbZ/mGHfEFE1ri8/moEyteHejLU6/ND7Nj9IqYoy31hFg==
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Sunpeng.Li@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Harry.Wentland@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Dml merges mpc/odm combine pipes to do calculations. This merge is
imperfect if there is a viewport overlap. This change saves pre overlap
viewport for dml use.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Reviewed-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c    |  3 +++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c    | 12 ++++++------
 drivers/gpu/drm/amd/display/dc/inc/hw/transform.h    |  2 ++
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 7b32a34908c8..12f5c6881cd0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -692,6 +692,9 @@ static void calculate_viewport(struct pipe_ctx *pipe_ctx)
 	/* Round up, assume original video size always even dimensions */
 	data->viewport_c.width = (data->viewport.width + vpc_div - 1) / vpc_div;
 	data->viewport_c.height = (data->viewport.height + vpc_div - 1) / vpc_div;
+
+	data->viewport_unadjusted = data->viewport;
+	data->viewport_c_unadjusted = data->viewport_c;
 }
 
 static void calculate_recout(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 44f056fae3ea..ede0723e667d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2219,12 +2219,12 @@ int dcn20_populate_dml_pipes_from_context(
 					|| pipes[pipe_cnt].pipe.dest.odm_combine != dm_odm_combine_mode_disabled;
 			pipes[pipe_cnt].pipe.src.source_scan = pln->rotation == ROTATION_ANGLE_90
 					|| pln->rotation == ROTATION_ANGLE_270 ? dm_vert : dm_horz;
-			pipes[pipe_cnt].pipe.src.viewport_y_y = scl->viewport.y;
-			pipes[pipe_cnt].pipe.src.viewport_y_c = scl->viewport_c.y;
-			pipes[pipe_cnt].pipe.src.viewport_width = scl->viewport.width;
-			pipes[pipe_cnt].pipe.src.viewport_width_c = scl->viewport_c.width;
-			pipes[pipe_cnt].pipe.src.viewport_height = scl->viewport.height;
-			pipes[pipe_cnt].pipe.src.viewport_height_c = scl->viewport_c.height;
+			pipes[pipe_cnt].pipe.src.viewport_y_y = scl->viewport_unadjusted.y;
+			pipes[pipe_cnt].pipe.src.viewport_y_c = scl->viewport_c_unadjusted.y;
+			pipes[pipe_cnt].pipe.src.viewport_width = scl->viewport_unadjusted.width;
+			pipes[pipe_cnt].pipe.src.viewport_width_c = scl->viewport_c_unadjusted.width;
+			pipes[pipe_cnt].pipe.src.viewport_height = scl->viewport_unadjusted.height;
+			pipes[pipe_cnt].pipe.src.viewport_height_c = scl->viewport_c_unadjusted.height;
 			pipes[pipe_cnt].pipe.src.surface_width_y = pln->plane_size.surface_size.width;
 			pipes[pipe_cnt].pipe.src.surface_height_y = pln->plane_size.surface_size.height;
 			pipes[pipe_cnt].pipe.src.surface_width_c = pln->plane_size.chroma_size.width;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h b/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h
index fecc80c47c26..2947d1b15512 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/transform.h
@@ -173,6 +173,8 @@ struct scaler_data {
 	struct scaling_taps taps;
 	struct rect viewport;
 	struct rect viewport_c;
+	struct rect viewport_unadjusted;
+	struct rect viewport_c_unadjusted;
 	struct rect recout;
 	struct scaling_ratios ratios;
 	struct scl_inits inits;
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
