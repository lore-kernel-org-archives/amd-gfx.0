Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BF3C2BA2B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 923BD21841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DcrsQgMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923BD21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CED56E358;
	Thu, 16 Apr 2020 23:41:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0583C6E358
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/bSGaII5SowTpUQS6q0+H01/pe3kW8TqYE4A/raMP3BZ+SPXCv/97W0smjWGBtxJhR8k5Xzry33UJZoxymHNsyp959Q7/JXti2bemYMxTRyvJu1foSmhLw7Gp7E2mHZaSpsqYcQ/nXKGdU29LaFPoSA3u5X/C08KMB+Ya1ADVhT+bLPhHPabW6AwWj9jjM73gfwNtWP5+Gx1QKvLRqbUwK8WJOtat+uKYNR0gRhXQDUhn0yQdQInkYwEJrHeruNCD3VgWFU1VVWwy07X3AJEVvf682S2xpwXaIpEau+wUSB9CooAvUj3mmWjxU7U4oGs0LF93OYBa8yzAoYwZnHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKnpCgLqF6Gl3/u3CBevp/J1mIjtd8pDTSw+ppZjUAw=;
 b=APFCfAXgJYeGy9lNR7mY0aV63FdwU0ufLEgmAtcA5qV7ee9h4pWiOo7gKOq/oiVlA+4EwUaswCb8dkjZq8Enm7GvMHQ5oJoPrh4hz1Z2nFuRxAPQo7kq9AFjTbESY0rclEw1KiCT6ZfFFWChQtYqeetQLAVtzah7BYrR0NL6b0LHgARIBeVfihjsQA28/+NtHJmzRg03nFq6E2QupsFMp4Dpx8uhB1lQI00Ow62lWq5eOwohdvmwPVFBPW3LIUxDxB4yvPFBEWguXoCTwRp6eW3rdjsoVtYBoz01W4qB4yD88zhFUJ26uMAUDye++Bq7aP1C4SdqI9gxXz1qr5jCmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKnpCgLqF6Gl3/u3CBevp/J1mIjtd8pDTSw+ppZjUAw=;
 b=DcrsQgMz3C/Igq4yFKf+14AIDXWPppn7fNVop9HZQnhp6onhTOUMJRAqg2IF4Zy+/KvTkR5BuVOt1zi3+A0e/jdn82O9qtO1zTwA0GqgqXA84KlIpwbeG3EbPJrgjKxTKTTs/1+6NejyyB4jTl6pAVeTVS03Mumo06reyFfNcPU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:50 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:50 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 29/35] drm/amd/display: Add HW rotation cursor changes to dcn10
Date: Thu, 16 Apr 2020 19:40:38 -0400
Message-Id: <20200416234044.2082886-30-Rodrigo.Siqueira@amd.com>
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
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:49 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6bec0fed-8b22-4f25-a85c-08d7e25fbc38
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2459481687CF7872E0C85CC498D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
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
X-Microsoft-Antispam-Message-Info: 0xIktODW6Y3155kTGgKdMUhhoP6iSuQiLzFqf+YJZ5Pdbbw6EwFTNqdYklY+5TmCtaF5m3i7uggLjlyZbJbHViwtmWyR6yC602M+MpzSvf+wQpVxzu/QaZCblVxz4NhUVN6eXwCvpKDhGpnAh4i0vMsjCfRRcFHE8C/rTAK7IP7Su5FLV4pSb2CWv5QELGXeMTTUCzaOrMYSdPJeIGQSB1Tn8TGUILax9e9s4WnJtjWMwVh56Ezo1S7Gxg1Z9BARFq0TvXMnlN5NOk+4wP4kJ5RDE5UGh9d6ZyWlCf7IYSWCR65b/hA9eOP7os9amL674AztLDjA+J8Ye3iWq7FhlxFAG5/AW2yZu2aO5Z93ZCi5lpgDc2Ycm0YCwhDWodRyhZsl/6QyusLqZE+D5TxJcZCW5GLkNR1f+rnGoR1phmbxqTvYxnFKCQ6ldwXNkKYd
X-MS-Exchange-AntiSpam-MessageData: Cl8Kx1+y+Ko4l9d9RADFDwp2dLZMK3utiqUW18uXR5XgnUsAFndOeRDbC6P/t+KzJd8BlIjguNunzodCzxieVhO02w2bAhB0HXqZh12mm4I+quyNkpT33RyMiU2beo6Uz2JoBDrb54EzLXS0hisBEOnshDszrCkAKW8JNZIz2SI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bec0fed-8b22-4f25-a85c-08d7e25fbc38
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:50.6223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NR6W9MILCcU1u90/vTaRjPhl9WKW6lxCbbdKN3s+odpmZyC181x9UaaiLY7nhh/SFNYWqWhCbeMVusih/+3S5Q==
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
Cc: Jaehyun Chung <jaehyun.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jaehyun Chung <jaehyun.chung@amd.com>

[Why]
HW rotation was enabled in DAL3 but hubp cursor calculations for HW roation
were only added to dcn20.

[How]
Add hubp cursor position calculation changes to dcn10.

Signed-off-by: Jaehyun Chung <jaehyun.chung@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
index 31b64733d693..319366ebb44f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
@@ -1139,6 +1139,8 @@ void hubp1_cursor_set_position(
 	int src_y_offset = pos->y - pos->y_hotspot - param->viewport.y;
 	int x_hotspot = pos->x_hotspot;
 	int y_hotspot = pos->y_hotspot;
+	int cursor_height = (int)hubp->curs_attr.height;
+	int cursor_width = (int)hubp->curs_attr.width;
 	uint32_t dst_x_offset;
 	uint32_t cur_en = pos->enable ? 1 : 0;
 
@@ -1152,10 +1154,16 @@ void hubp1_cursor_set_position(
 	if (hubp->curs_attr.address.quad_part == 0)
 		return;
 
+	// Rotated cursor width/height and hotspots tweaks for offset calculation
 	if (param->rotation == ROTATION_ANGLE_90 || param->rotation == ROTATION_ANGLE_270) {
-		src_x_offset = pos->y - pos->y_hotspot - param->viewport.x;
-		y_hotspot = pos->x_hotspot;
-		x_hotspot = pos->y_hotspot;
+		swap(cursor_height, cursor_width);
+		if (param->rotation == ROTATION_ANGLE_90) {
+			src_x_offset = pos->x - pos->y_hotspot - param->viewport.x;
+			src_y_offset = pos->y - pos->x_hotspot - param->viewport.y;
+		}
+	} else if (param->rotation == ROTATION_ANGLE_180) {
+		src_x_offset = pos->x - param->viewport.x;
+		src_y_offset = pos->y - param->viewport.y;
 	}
 
 	if (param->mirror) {
@@ -1177,13 +1185,13 @@ void hubp1_cursor_set_position(
 	if (src_x_offset >= (int)param->viewport.width)
 		cur_en = 0;  /* not visible beyond right edge*/
 
-	if (src_x_offset + (int)hubp->curs_attr.width <= 0)
+	if (src_x_offset + cursor_width <= 0)
 		cur_en = 0;  /* not visible beyond left edge*/
 
 	if (src_y_offset >= (int)param->viewport.height)
 		cur_en = 0;  /* not visible beyond bottom edge*/
 
-	if (src_y_offset + (int)hubp->curs_attr.height <= 0)
+	if (src_y_offset + cursor_height <= 0)
 		cur_en = 0;  /* not visible beyond top edge*/
 
 	if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
