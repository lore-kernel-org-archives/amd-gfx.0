Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9B6C4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 038C72072C
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="09vDrSz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038C72072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98A986E176;
	Fri, 20 Mar 2020 15:12:02 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770082.outbound.protection.outlook.com [40.107.77.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 504D16E196
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 15:11:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4sfVWUQGw1jYCDFVaIuhVRQz2L6uPH1+1R5TydAo4sw+/aOhLZ7K08QYboLP/ie8s/BbgRKwc8Pa/oaBwDMqPHxVDlu3eY6pEj7yFcStHTMK1gMeT0wxNQ+ZV/aqAa1TX1tXEa0hDwkylxK6v9U9BOnuWs8A4pKBuEESI6cqYFzbhcrNLPv2IVHTsWenG87AZdA/9kI9J1VpyErZYvgW3nqWtHqrJnTcoN1fYA3IqfgleURbim9AlfVXcnovYQklR5fSzOim6tBtwXDEz/7Stw11VhDB9T8r7/+7NQUGCDclSADMSJ+t5KaizvC6U9sAdrcQb4XZGMjDx79O8NT+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YamA3EZKLqki1IOmJpSZ14noWesS3sVW5msMN0KhKjs=;
 b=AayjoSj1b8OG7YyS+4nwt68og0JBJWCtT/0CwCPZhDgBbElizyj2qdAcouQPRPGgR/jNc3aAqPIpW1fW1kklkzhLX+ck5+ZVW2+1L9VPJMKhTDU4lgxT7YtU+Htfxj3xXkstAdGNU9XJuGq7qi1rwVzFe600AWodSUB+Yeg71ghRAnLyTdRiJpYJjsLeE9HrqfYdW4i2KApGSRgZKzLmHG5uRj8ZUs25K2fE+cy4hSr0HzzT28KgBlmLq/iFVpbshxEYRyOGi+NaOUUKgePp+1+BQ9UfPNg1KRG3SXWxf27idNgYwDEE7Gzj11Ers9BVw3ZDWRK8jydFdQTEuqW57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YamA3EZKLqki1IOmJpSZ14noWesS3sVW5msMN0KhKjs=;
 b=09vDrSz61WKlculjxPbUVMyHW0l3Yoj1K/KtW1gqvpIBCClCA7VdkxwHwH9ls0rXfl3bYk+0YpfZRgS5r4xYZ/wqq/Vv5RbJA/IxhclXE7TPigZVlEUJWcjFe5J0JNI9SZaEHERPuscysk1nNucYTP1twAPPNWyH8KkIpj74sT4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 15:11:56 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Fri, 20 Mar 2020
 15:11:55 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/12] drm/amd/display: Enable BT2020 in COLOR_ENCODING
 property
Date: Fri, 20 Mar 2020 11:11:27 -0400
Message-Id: <20200320151128.2039940-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
References: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Fri, 20 Mar 2020 15:11:55 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a6aa8f06-0914-42e0-e90b-08d7cce10732
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25720F3DAE07EF7B8A32A91198F50@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(81156014)(66556008)(6506007)(54906003)(4326008)(16526019)(2906002)(8936002)(186003)(81166006)(52116002)(2616005)(1076003)(8676002)(86362001)(66476007)(316002)(66946007)(6666004)(6486002)(36756003)(5660300002)(6512007)(6916009)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x6hCy/pr9PKo+tEuwCxYxYjNo+nYDkq/R7XAz2rDSWyoR6+/gWG9Z8mSDiZydDwsIRGTPze8mdCkfIe2TggniPpaHsjOA2bdd8p3KjRrOFqx2vMWWteoWs+4SLl9fojvjLfzqXTfC1UGGl1scfQe9ntbs5O9UK49oZxycoxwBtPxTA6637Ko/HAJ2UyZAXcw1kASnaV9ArhKlTOR1e9KqJVvDyC8a8WkQD+EGirzFjzQZ1IxzoQZMyUQ9KyJ4YkJzfRzeCQrihSAdtSVC0cTC/qfJU/7VwuELPoz+N1MWmJFgug+fykrDJlL8L62h6UXt64+Oe3IVsxOv0dDSkd6x+4hKsY4rBA5FDOz2Vjj/uS2xMI2/RwAiPXNBym8qP98Zv13sTwP/xVpSCtgazgYOxpVvPl82O6isgrzOXwG4LnHnDkIBgIvTQqWBoKjER00
X-MS-Exchange-AntiSpam-MessageData: fsJToq2CO3s9/dj69ht50odQdwhlFVGFcZm/70/sUME2FQSEqUATkeM1kzGv2pYA+d0JdCG3fq67jvJgavp8Vrmet0dEEdg9YhxdOa1zrDNY/yb25zka5a4JSTR4KCHlNjDtwIlV5agfwN/OrrNtuMCokVAMoTOrzsYPWPdoCbg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6aa8f06-0914-42e0-e90b-08d7cce10732
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 15:11:55.8178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xS/P1OMotjxGUIsq0fM4c3wJvG+PqUeLEPZ0hl6gxSV879AT8m8qTwQEtzY0rGC0vgaIfbjMKhLgXWnYDgyTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Stylon Wang <stylon.wang@amd.com>, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
BT2020 is not supported in COLOR_ENCODING property of planes.  Only
BT601 and BT709 was available.

[How]
Allow BT2020 as legit value in setting COLOR_ENCODING property.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 32d946fa7d89..4f58810e770f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5674,12 +5674,15 @@ static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	}
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
-	    plane_cap && plane_cap->pixel_format_support.nv12) {
+	    plane_cap &&
+	    (plane_cap->pixel_format_support.nv12 ||
+	     plane_cap->pixel_format_support.p010)) {
 		/* This only affects YUV formats. */
 		drm_plane_create_color_properties(
 			plane,
 			BIT(DRM_COLOR_YCBCR_BT601) |
-			BIT(DRM_COLOR_YCBCR_BT709),
+			BIT(DRM_COLOR_YCBCR_BT709) |
+			BIT(DRM_COLOR_YCBCR_BT2020),
 			BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
 			BIT(DRM_COLOR_YCBCR_FULL_RANGE),
 			DRM_COLOR_YCBCR_BT709, DRM_COLOR_YCBCR_LIMITED_RANGE);
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
