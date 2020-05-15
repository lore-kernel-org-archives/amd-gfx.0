Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503E9C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 273DB206D8
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GX0VHqML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273DB206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 902096ED31;
	Fri, 15 May 2020 18:14:04 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700059.outbound.protection.outlook.com [40.107.70.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9A406ED25
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKrADK8AYN90hNPD9R2aOOS/LWPMFs1nmbSHw2UrDwbL4ruf+z+T6os9sosPQNsli2fAYt9K92/J2rzlWaqZa+Hn8pr9kmg0k9HgO4cd/mRqLKJYq4sgvuMc4oxUaCkyfidJ5r4L1aPTcJSAtvVaykyu88NaKJjI/S2KhP02lPPKlUHKSqBfbG8b/ruZ+YNuVJBFfHAoxb4XG2WFHQ3XsMLk9SJM6DDZMIZ1WHF9ugZxFS8l6SVZ7o7VDBnXTslm5x+pZMTXcur6ClI7Yn+acf8u4pZgIYmMc9YpFRoSS4CSK08fnUwR9an2g0w3rjzkse1q+W/oSze9WfhNlF+SuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDAvd+jw4oW9osXwWkOYc6l97k+FEYEetOG8r0/a+7s=;
 b=DOwzrCrqfdF+NwQm7OX0wfTj+1QEEou7HTIQwxxP6o+eQGfRHOkQabrIp8XFm62iGELR5tYGQ0Aq0IL41sVpnQsJuZEuGLsWQEdopaJnrCFkkeukPMGCN5r+D+Alp+u/Jd7jUlD3d1Hqvcn5MlR+k9a74K2YsilswKOMv+OXwYnCp/XrGeeoJa7Usgdv7VtmJldwvK/jD7sSTQ6MRgcuzd/B1ji849MhTk/Wnm91g93bZlqZd9R9b7H0sMA3iX+W3JCkAjQvC/8g9YNWwCvAEq3SHgg9at1U3ynrhjMyZMQWntgwPT1zMZxkMzJLvpWIbP+HGNww8enFz36a8igjrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDAvd+jw4oW9osXwWkOYc6l97k+FEYEetOG8r0/a+7s=;
 b=GX0VHqMLtngr7Y4Vz/vYmjiKibjcra5W9MnA2c9zg8Tt9ndMhu3EJoo92VRpi5PVP4Da966Kb9HbrY2+KChO4KBHMD7Un1oCx+5a+/7RWjV13fYk73u9PMUHu4vUE1A1cs2oQcMoqhcpXkqHREHvOdE+9YaW7XyR7Kes0Yr39gQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3974.namprd12.prod.outlook.com (2603:10b6:610:2e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 18:14:00 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:14:00 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 22/27] drm/amd/display: Support CW4 for DMUB ringbuffer inbox
Date: Fri, 15 May 2020 14:13:09 -0400
Message-Id: <20200515181315.1237251-23-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:59 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 44e6b893-b2c7-46f3-9be2-08d7f8fbbd98
X-MS-TrafficTypeDiagnostic: CH2PR12MB3974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3974A2822E800FAE298D933898BD0@CH2PR12MB3974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZLGzJ6tB5Aro7ejzBVgMfAub0OdUE2hA1Ha4THOpTzb4Xw7PDwH62zCkAO+380xCdD2hIBk5PpE33p8LJhmoZ7h7esLQcjKI7SrDHcWormmNJXYQwrGofSmP9sEXXoxRoFescA1hEYjBxiDzvlPnRiyiEH8qEp9x4F9ZvI+Ton+zkiULRpyp9NOMh+x3NP7AXeNkAoQwPkNkG3Gg1kEpGiyeV4/HyYsk0OfVezhydmn8nZhNEhZv6BD3VX6qTk1puWcKpRHWo0AlcLFWTQPtRwD4mXUd7SGT2ioP2e2JokkHrzXF1L5WVFlRYvO62hUE0O6C/4KYfNLGKjqEiPDT0NuVleF58F3M/irHg7uiw8auJ6O2NE++4t8IFayWGDRU71s35WssYf0TomGFpJ7UuhJPyFAUoOAa6/dcgqHXG7fiuTMxGta35bSkxbWQTM1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(6506007)(316002)(8676002)(8936002)(86362001)(6486002)(54906003)(6666004)(5660300002)(6916009)(478600001)(6512007)(2906002)(36756003)(66556008)(1076003)(52116002)(16526019)(186003)(2616005)(66476007)(66946007)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 40+4EBSA6RqhCG8d4PfKNhRv+Tiyu+t7nszR8CIcdDcjJ7S6Z1QGETNIJGmV7+QgKRoC004mMMKCTOIUpL/X65UoKddYtx0UvUK7MuwlN36JSMP1aZWpY+No188Fcjzarb4u00+g5ujX3HovFDGE1rC4j1X8i4sDPOAsrrc+ELAxcPrIovp52Zp1douQGdvIKPbsIqdHeJV1R/EKpeOUABoTz8Xbi+LcB1aEyr1lXhO4pP8C9X6cEfX8xiLXwyUz7hSRUjMxZPepkxwupfjwdoyUVWaQsmcIVVo5FYT5Pnq15Z1Exovz96uLbmInDHGZ1tZQdT45WpRc8/XlIdhi7IEtU0QwtkOgxmokDM3bCp74DYzo0TyngM65leyW9oEszT45Z/eipCtApV1qRebDvd2xjbRs6HXA1JyTzTDxx+sVLOmLpOmsIj5/LbcYX9J5zpBwQ9+MTj5UPr63dlTwRtgUv47Mr5ZVeWXfSngK8qsRO2u9OMHqUvL50DOqiJtK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e6b893-b2c7-46f3-9be2-08d7f8fbbd98
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:59.9685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsDxxtHvBzL1GeKyM/9KFhLGr3F3NGs0kvAQSWvnmVTO3IBPvhl8zZ0Wez2lOJTkVfjOy2uz2RVPw0PgL7JrUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3974
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Region 4 is non cacheable and slower than using cache window 4.

[How]
Check the firmware version to determine how we should program the
base address and memory windows.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 28 ++++++++++++++-----
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  3 +-
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index edc73d6d7ba2..1e03f6fdabd6 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -215,11 +215,22 @@ void dmub_dcn20_setup_windows(struct dmub_srv *dmub,
 	/* TODO: Move this to CW4. */
 	dmub_dcn20_translate_addr(&cw4->offset, fb_base, fb_offset, &offset);
 
-	REG_WRITE(DMCUB_REGION4_OFFSET, offset.u.low_part);
-	REG_WRITE(DMCUB_REGION4_OFFSET_HIGH, offset.u.high_part);
-	REG_SET_2(DMCUB_REGION4_TOP_ADDRESS, 0, DMCUB_REGION4_TOP_ADDRESS,
-		  cw4->region.top - cw4->region.base - 1, DMCUB_REGION4_ENABLE,
-		  1);
+	/* New firmware can support CW4. */
+	if (dmub->fw_version > DMUB_FW_VERSION(1, 0, 10)) {
+		REG_WRITE(DMCUB_REGION3_CW4_OFFSET, offset.u.low_part);
+		REG_WRITE(DMCUB_REGION3_CW4_OFFSET_HIGH, offset.u.high_part);
+		REG_WRITE(DMCUB_REGION3_CW4_BASE_ADDRESS, cw4->region.base);
+		REG_SET_2(DMCUB_REGION3_CW4_TOP_ADDRESS, 0,
+			  DMCUB_REGION3_CW4_TOP_ADDRESS, cw4->region.top,
+			  DMCUB_REGION3_CW4_ENABLE, 1);
+	} else {
+		REG_WRITE(DMCUB_REGION4_OFFSET, offset.u.low_part);
+		REG_WRITE(DMCUB_REGION4_OFFSET_HIGH, offset.u.high_part);
+		REG_SET_2(DMCUB_REGION4_TOP_ADDRESS, 0,
+			  DMCUB_REGION4_TOP_ADDRESS,
+			  cw4->region.top - cw4->region.base - 1,
+			  DMCUB_REGION4_ENABLE, 1);
+	}
 
 	dmub_dcn20_translate_addr(&cw5->offset, fb_base, fb_offset, &offset);
 
@@ -243,9 +254,12 @@ void dmub_dcn20_setup_windows(struct dmub_srv *dmub,
 void dmub_dcn20_setup_mailbox(struct dmub_srv *dmub,
 			      const struct dmub_region *inbox1)
 {
-	/* TODO: Use CW4 instead of region 4. */
+	/* New firmware can support CW4 for the inbox. */
+	if (dmub->fw_version > DMUB_FW_VERSION(1, 0, 10))
+		REG_WRITE(DMCUB_INBOX1_BASE_ADDRESS, inbox1->base);
+	else
+		REG_WRITE(DMCUB_INBOX1_BASE_ADDRESS, 0x80000000);
 
-	REG_WRITE(DMCUB_INBOX1_BASE_ADDRESS, 0x80000000);
 	REG_WRITE(DMCUB_INBOX1_SIZE, inbox1->top - inbox1->base);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 3559093027ee..d128b0639572 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -62,6 +62,7 @@
 #define DMUB_CW0_BASE (0x60000000)
 #define DMUB_CW1_BASE (0x61000000)
 #define DMUB_CW3_BASE (0x63000000)
+#define DMUB_CW4_BASE (0x64000000)
 #define DMUB_CW5_BASE (0x65000000)
 #define DMUB_CW6_BASE (0x66000000)
 
@@ -403,7 +404,7 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 		cw3.region.top = cw3.region.base + bios_fb->size;
 
 		cw4.offset.quad_part = mail_fb->gpu_addr;
-		cw4.region.base = cw3.region.top + 1;
+		cw4.region.base = DMUB_CW4_BASE;
 		cw4.region.top = cw4.region.base + mail_fb->size;
 
 		inbox1.base = cw4.region.base;
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
