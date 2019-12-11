Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0ABC2D0C8
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63E32077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Lo8GRoSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63E32077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 639546EB80;
	Wed, 11 Dec 2019 15:33:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 144936EB75
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKIF2fcjV3AltaA9HY/1+YeCNDIJk0aek3KNaqAWoCSrbojPmsx/exOI0p6UleK7f7nLGdu5j3H84WrEZKi4vJ8yeFB4Ls44d++2tHwWRK/UzTd5SHoNmRTnVH7B/05Qd8yFT56y+PC8Jf17sqQJpYWXNz0g2hbWVISJ4e+SpYEIiTH6No/Sy27GRncxjJCH5TNja2YkEGEfquoUIZsgrQ2MTo/H3zGGOv+3MAJJHBnybEjG4Nz5ktfaR02tkTlpLBztLNepVqtd49uqjiS3M6bGRZlZ/eSYVobBXAeyvGaLfbdneVYkDAX4xgx8NLqWcifpOpFZxyjvK/IfFPuuOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DeOcvgTsAPDI8DP2Rm2twik6tgWmVQXkuMIPKXZ338=;
 b=F1LnNaYS0nkHbsSfubHaeiZwVh+f9rtHLkcrJGIIpIcMbbrYCxeIej4N7zd3s1VqmLNijBisiNjvkP2QxdqQoOnySv1m25oyvVHjYIH6961JQc4yRFFqlUt6DjeHTA4P/OTroYcOb/Kq8EpYGD8XY3rpvpDI5mqks695gLOMTBifpq+mtDd6nMuQm3cQRTjFrdd57522p0tTT+fOQu4RhoYvZHtY1QwiA06gORXt4OenzXFXgzWqS5vF9Tsm40GP0wLUGNrZzlkeJU1pit700rCG+T5TeQGfF1IyHuLK3LtrR6i/OHGIArVuLEY7FNiQBWr4PHqsj3uM4b0Yj1aaLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DeOcvgTsAPDI8DP2Rm2twik6tgWmVQXkuMIPKXZ338=;
 b=Lo8GRoSPAihyEG4m3rb44Jj6BA4RqUgZ6waUlu5qaihG+mX6epoY09mPBQhk3cT9ml/wBWkz4zXw1npyYgP4nYjghkBT0Fhu5MdUQ+2MILf9UN2UxFibUJNwszW0qeeghqfSrc2PE2pD5w6FfcSlYo5SbNnPuToQ39g3IeZc5+g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2426.namprd12.prod.outlook.com (52.132.184.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:21 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:21 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/39] drm/amd/display: Use physical addressing for DMCUB on
 both dcn20/21
Date: Wed, 11 Dec 2019 10:32:19 -0500
Message-Id: <20191211153253.2291112-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: affd8858-2377-4bf5-df61-08d77e4f73f4
X-MS-TrafficTypeDiagnostic: MW2PR12MB2426:|MW2PR12MB2426:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB242685A4895860F45C268185985A0@MW2PR12MB2426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(86362001)(6512007)(1076003)(478600001)(54906003)(4326008)(6486002)(66556008)(66476007)(66946007)(2616005)(316002)(2906002)(81156014)(8676002)(26005)(30864003)(36756003)(52116002)(8936002)(186003)(6916009)(81166006)(5660300002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2426;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cONL3mNccCPM6RJeLeiOz5GJBOEDT3eSrX9w4+qvH/k271AvZ627HtC1yard2V7axGWjkXykTgv/iClRFkDrJWfifWe80tyRekPXyksfrdyiBrSkdAvj0CYvpo6uS6OFlthUe0JrhrfCRNM3XDQOiSSeKcZvNqpm0mcL8GydWrm/aidsCU5k1vj+zJQ9ZPgGvh42kFTCvxe/iUwAhzhIPgSVTV0do5LpL0C/ffCsHmrzUUZmlg58Rp3ITE4wcjeh1lm2qcS81YRtNFpDjXdLdppyGZMO1OIL5VvakcT062PmMyIoMRB5s+nheHtEih7kVt2eEVuvl0B2H45Yvh3z2zQ4jWW3MNkE+DzEY0cOr3tv30rYhJnKw1ghAo8hn8uAve+bDcCh7gUBlkXh0hahE/WThD7Ubt+jEWnVGu5Xssjm6WZZ5MCb1UpfMn8D0c3w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affd8858-2377-4bf5-df61-08d77e4f73f4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:21.1477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzHNLoFeI5r1nYf5wreOzMG6/OGvx9VTDt6jdAUziOICXRA0ojrctH5FDseRAvC+FAoSIAhvxGFQBqwvTmW/Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2426
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
 Tony Cheng <Tony.Cheng@amd.com>, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
CW0 and CW1 need to use physical addressing mode for dcn20 and dcn21.

The current code for dcn20 is using virtual.

[How]
We already program the DMCUB like this on dcn21 so we should just use
the same sequence for both.

Copy the dcn21 sequences into the dmjub_dcn20.c file and rename them.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 59 ++++++++---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.c | 97 +------------------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.h | 11 ---
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  2 -
 4 files changed, 44 insertions(+), 125 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 5760f25c3309..f45e14ada685 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -54,6 +54,14 @@ const struct dmub_srv_common_regs dmub_srv_dcn20_regs = {
 
 /* Shared functions. */
 
+static inline void dmub_dcn20_translate_addr(const union dmub_addr *addr_in,
+					     uint64_t fb_base,
+					     uint64_t fb_offset,
+					     union dmub_addr *addr_out)
+{
+	addr_out->quad_part = addr_in->quad_part - fb_base + fb_offset;
+}
+
 void dmub_dcn20_reset(struct dmub_srv *dmub)
 {
 	REG_UPDATE(DMCUB_CNTL, DMCUB_SOFT_RESET, 1);
@@ -71,19 +79,26 @@ void dmub_dcn20_backdoor_load(struct dmub_srv *dmub,
 			      const struct dmub_window *cw0,
 			      const struct dmub_window *cw1)
 {
+	union dmub_addr offset;
+	uint64_t fb_base = dmub->fb_base, fb_offset = dmub->fb_offset;
+
 	REG_UPDATE(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 1);
-	REG_UPDATE_2(DMCUB_MEM_CNTL, DMCUB_MEM_READ_SPACE, 0x4,
-		     DMCUB_MEM_WRITE_SPACE, 0x4);
+	REG_UPDATE_2(DMCUB_MEM_CNTL, DMCUB_MEM_READ_SPACE, 0x3,
+		     DMCUB_MEM_WRITE_SPACE, 0x3);
+
+	dmub_dcn20_translate_addr(&cw0->offset, fb_base, fb_offset, &offset);
 
-	REG_WRITE(DMCUB_REGION3_CW0_OFFSET, cw0->offset.u.low_part);
-	REG_WRITE(DMCUB_REGION3_CW0_OFFSET_HIGH, cw0->offset.u.high_part);
+	REG_WRITE(DMCUB_REGION3_CW0_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW0_OFFSET_HIGH, offset.u.high_part);
 	REG_WRITE(DMCUB_REGION3_CW0_BASE_ADDRESS, cw0->region.base);
 	REG_SET_2(DMCUB_REGION3_CW0_TOP_ADDRESS, 0,
 		  DMCUB_REGION3_CW0_TOP_ADDRESS, cw0->region.top,
 		  DMCUB_REGION3_CW0_ENABLE, 1);
 
-	REG_WRITE(DMCUB_REGION3_CW1_OFFSET, cw1->offset.u.low_part);
-	REG_WRITE(DMCUB_REGION3_CW1_OFFSET_HIGH, cw1->offset.u.high_part);
+	dmub_dcn20_translate_addr(&cw1->offset, fb_base, fb_offset, &offset);
+
+	REG_WRITE(DMCUB_REGION3_CW1_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW1_OFFSET_HIGH, offset.u.high_part);
 	REG_WRITE(DMCUB_REGION3_CW1_BASE_ADDRESS, cw1->region.base);
 	REG_SET_2(DMCUB_REGION3_CW1_TOP_ADDRESS, 0,
 		  DMCUB_REGION3_CW1_TOP_ADDRESS, cw1->region.top,
@@ -100,37 +115,49 @@ void dmub_dcn20_setup_windows(struct dmub_srv *dmub,
 			      const struct dmub_window *cw5,
 			      const struct dmub_window *cw6)
 {
-	REG_WRITE(DMCUB_REGION3_CW2_OFFSET, cw2->offset.u.low_part);
-	REG_WRITE(DMCUB_REGION3_CW2_OFFSET_HIGH, cw2->offset.u.high_part);
+	union dmub_addr offset;
+	uint64_t fb_base = dmub->fb_base, fb_offset = dmub->fb_offset;
+
+	dmub_dcn20_translate_addr(&cw2->offset, fb_base, fb_offset, &offset);
+
+	REG_WRITE(DMCUB_REGION3_CW2_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW2_OFFSET_HIGH, offset.u.high_part);
 	REG_WRITE(DMCUB_REGION3_CW2_BASE_ADDRESS, cw2->region.base);
 	REG_SET_2(DMCUB_REGION3_CW2_TOP_ADDRESS, 0,
 		  DMCUB_REGION3_CW2_TOP_ADDRESS, cw2->region.top,
 		  DMCUB_REGION3_CW2_ENABLE, 1);
 
-	REG_WRITE(DMCUB_REGION3_CW3_OFFSET, cw3->offset.u.low_part);
-	REG_WRITE(DMCUB_REGION3_CW3_OFFSET_HIGH, cw3->offset.u.high_part);
+	dmub_dcn20_translate_addr(&cw3->offset, fb_base, fb_offset, &offset);
+
+	REG_WRITE(DMCUB_REGION3_CW3_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW3_OFFSET_HIGH, offset.u.high_part);
 	REG_WRITE(DMCUB_REGION3_CW3_BASE_ADDRESS, cw3->region.base);
 	REG_SET_2(DMCUB_REGION3_CW3_TOP_ADDRESS, 0,
 		  DMCUB_REGION3_CW3_TOP_ADDRESS, cw3->region.top,
 		  DMCUB_REGION3_CW3_ENABLE, 1);
 
 	/* TODO: Move this to CW4. */
+	dmub_dcn20_translate_addr(&cw4->offset, fb_base, fb_offset, &offset);
 
-	REG_WRITE(DMCUB_REGION4_OFFSET, cw4->offset.u.low_part);
-	REG_WRITE(DMCUB_REGION4_OFFSET_HIGH, cw4->offset.u.high_part);
+	REG_WRITE(DMCUB_REGION4_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION4_OFFSET_HIGH, offset.u.high_part);
 	REG_SET_2(DMCUB_REGION4_TOP_ADDRESS, 0, DMCUB_REGION4_TOP_ADDRESS,
 		  cw4->region.top - cw4->region.base - 1, DMCUB_REGION4_ENABLE,
 		  1);
 
-	REG_WRITE(DMCUB_REGION3_CW5_OFFSET, cw5->offset.u.low_part);
-	REG_WRITE(DMCUB_REGION3_CW5_OFFSET_HIGH, cw5->offset.u.high_part);
+	dmub_dcn20_translate_addr(&cw5->offset, fb_base, fb_offset, &offset);
+
+	REG_WRITE(DMCUB_REGION3_CW5_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW5_OFFSET_HIGH, offset.u.high_part);
 	REG_WRITE(DMCUB_REGION3_CW5_BASE_ADDRESS, cw5->region.base);
 	REG_SET_2(DMCUB_REGION3_CW5_TOP_ADDRESS, 0,
 		  DMCUB_REGION3_CW5_TOP_ADDRESS, cw5->region.top,
 		  DMCUB_REGION3_CW5_ENABLE, 1);
 
-	REG_WRITE(DMCUB_REGION3_CW6_OFFSET, cw6->offset.u.low_part);
-	REG_WRITE(DMCUB_REGION3_CW6_OFFSET_HIGH, cw6->offset.u.high_part);
+	dmub_dcn20_translate_addr(&cw6->offset, fb_base, fb_offset, &offset);
+
+	REG_WRITE(DMCUB_REGION3_CW6_OFFSET, offset.u.low_part);
+	REG_WRITE(DMCUB_REGION3_CW6_OFFSET_HIGH, offset.u.high_part);
 	REG_WRITE(DMCUB_REGION3_CW6_BASE_ADDRESS, cw6->region.base);
 	REG_SET_2(DMCUB_REGION3_CW6_TOP_ADDRESS, 0,
 		  DMCUB_REGION3_CW6_TOP_ADDRESS, cw6->region.top,
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
index 770d585168aa..5bed9fcd6b5c 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
@@ -51,102 +51,7 @@ const struct dmub_srv_common_regs dmub_srv_dcn21_regs = {
 #undef DMUB_SF
 };
 
-static inline void dmub_dcn21_translate_addr(const union dmub_addr *addr_in,
-					     uint64_t fb_base,
-					     uint64_t fb_offset,
-					     union dmub_addr *addr_out)
-{
-	addr_out->quad_part = addr_in->quad_part - fb_base + fb_offset;
-}
-
-void dmub_dcn21_backdoor_load(struct dmub_srv *dmub,
-			      const struct dmub_window *cw0,
-			      const struct dmub_window *cw1)
-{
-	union dmub_addr offset;
-	uint64_t fb_base = dmub->fb_base, fb_offset = dmub->fb_offset;
-
-	REG_UPDATE(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 1);
-	REG_UPDATE_2(DMCUB_MEM_CNTL, DMCUB_MEM_READ_SPACE, 0x3,
-		     DMCUB_MEM_WRITE_SPACE, 0x3);
-
-	dmub_dcn21_translate_addr(&cw0->offset, fb_base, fb_offset, &offset);
-
-	REG_WRITE(DMCUB_REGION3_CW0_OFFSET, offset.u.low_part);
-	REG_WRITE(DMCUB_REGION3_CW0_OFFSET_HIGH, offset.u.high_part);
-	REG_WRITE(DMCUB_REGION3_CW0_BASE_ADDRESS, cw0->region.base);
-	REG_SET_2(DMCUB_REGION3_CW0_TOP_ADDRESS, 0,
-		  DMCUB_REGION3_CW0_TOP_ADDRESS, cw0->region.top,
-		  DMCUB_REGION3_CW0_ENABLE, 1);
-
-	dmub_dcn21_translate_addr(&cw1->offset, fb_base, fb_offset, &offset);
-
-	REG_WRITE(DMCUB_REGION3_CW1_OFFSET, offset.u.low_part);
-	REG_WRITE(DMCUB_REGION3_CW1_OFFSET_HIGH, offset.u.high_part);
-	REG_WRITE(DMCUB_REGION3_CW1_BASE_ADDRESS, cw1->region.base);
-	REG_SET_2(DMCUB_REGION3_CW1_TOP_ADDRESS, 0,
-		  DMCUB_REGION3_CW1_TOP_ADDRESS, cw1->region.top,
-		  DMCUB_REGION3_CW1_ENABLE, 1);
-
-	REG_UPDATE_2(DMCUB_SEC_CNTL, DMCUB_SEC_RESET, 0, DMCUB_MEM_UNIT_ID,
-		     0x20);
-}
-
-void dmub_dcn21_setup_windows(struct dmub_srv *dmub,
-			      const struct dmub_window *cw2,
-			      const struct dmub_window *cw3,
-			      const struct dmub_window *cw4,
-			      const struct dmub_window *cw5,
-			      const struct dmub_window *cw6)
-{
-	union dmub_addr offset;
-	uint64_t fb_base = dmub->fb_base, fb_offset = dmub->fb_offset;
-
-	dmub_dcn21_translate_addr(&cw2->offset, fb_base, fb_offset, &offset);
-
-	REG_WRITE(DMCUB_REGION3_CW2_OFFSET, offset.u.low_part);
-	REG_WRITE(DMCUB_REGION3_CW2_OFFSET_HIGH, offset.u.high_part);
-	REG_WRITE(DMCUB_REGION3_CW2_BASE_ADDRESS, cw2->region.base);
-	REG_SET_2(DMCUB_REGION3_CW2_TOP_ADDRESS, 0,
-		  DMCUB_REGION3_CW2_TOP_ADDRESS, cw2->region.top,
-		  DMCUB_REGION3_CW2_ENABLE, 1);
-
-	dmub_dcn21_translate_addr(&cw3->offset, fb_base, fb_offset, &offset);
-
-	REG_WRITE(DMCUB_REGION3_CW3_OFFSET, offset.u.low_part);
-	REG_WRITE(DMCUB_REGION3_CW3_OFFSET_HIGH, offset.u.high_part);
-	REG_WRITE(DMCUB_REGION3_CW3_BASE_ADDRESS, cw3->region.base);
-	REG_SET_2(DMCUB_REGION3_CW3_TOP_ADDRESS, 0,
-		  DMCUB_REGION3_CW3_TOP_ADDRESS, cw3->region.top,
-		  DMCUB_REGION3_CW3_ENABLE, 1);
-
-	/* TODO: Move this to CW4. */
-	dmub_dcn21_translate_addr(&cw4->offset, fb_base, fb_offset, &offset);
-
-	REG_WRITE(DMCUB_REGION4_OFFSET, offset.u.low_part);
-	REG_WRITE(DMCUB_REGION4_OFFSET_HIGH, offset.u.high_part);
-	REG_SET_2(DMCUB_REGION4_TOP_ADDRESS, 0, DMCUB_REGION4_TOP_ADDRESS,
-		  cw4->region.top - cw4->region.base - 1, DMCUB_REGION4_ENABLE,
-		  1);
-
-	dmub_dcn21_translate_addr(&cw5->offset, fb_base, fb_offset, &offset);
-
-	REG_WRITE(DMCUB_REGION3_CW5_OFFSET, offset.u.low_part);
-	REG_WRITE(DMCUB_REGION3_CW5_OFFSET_HIGH, offset.u.high_part);
-	REG_WRITE(DMCUB_REGION3_CW5_BASE_ADDRESS, cw5->region.base);
-	REG_SET_2(DMCUB_REGION3_CW5_TOP_ADDRESS, 0,
-		  DMCUB_REGION3_CW5_TOP_ADDRESS, cw5->region.top,
-		  DMCUB_REGION3_CW5_ENABLE, 1);
-
-	dmub_dcn21_translate_addr(&cw6->offset, fb_base, fb_offset, &offset);
-
-	REG_WRITE(DMCUB_REGION3_CW6_OFFSET, offset.u.low_part);
-	REG_WRITE(DMCUB_REGION3_CW6_OFFSET_HIGH, offset.u.high_part);
-	REG_WRITE(DMCUB_REGION3_CW6_BASE_ADDRESS, cw6->region.base);
-	REG_SET_2(DMCUB_REGION3_CW6_TOP_ADDRESS, 0,
-		  DMCUB_REGION3_CW6_TOP_ADDRESS, cw6->region.top,
-		  DMCUB_REGION3_CW6_ENABLE, 1);
-}
+/* Shared functions. */
 
 bool dmub_dcn21_is_auto_load_done(struct dmub_srv *dmub)
 {
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
index 0728b74b68cf..2bbea237137b 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
@@ -34,17 +34,6 @@ extern const struct dmub_srv_common_regs dmub_srv_dcn21_regs;
 
 /* Hardware functions. */
 
-void dmub_dcn21_backdoor_load(struct dmub_srv *dmub,
-			      const struct dmub_window *cw0,
-			      const struct dmub_window *cw1);
-
-void dmub_dcn21_setup_windows(struct dmub_srv *dmub,
-			      const struct dmub_window *cw2,
-			      const struct dmub_window *cw3,
-			      const struct dmub_window *cw4,
-			      const struct dmub_window *cw5,
-			      const struct dmub_window *cw6);
-
 bool dmub_dcn21_is_auto_load_done(struct dmub_srv *dmub);
 
 bool dmub_dcn21_is_phy_init(struct dmub_srv *dmub);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index f530325a221f..16837003721e 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -84,8 +84,6 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		if (asic == DMUB_ASIC_DCN21) {
 			dmub->regs = &dmub_srv_dcn21_regs;
 
-			funcs->backdoor_load = dmub_dcn21_backdoor_load;
-			funcs->setup_windows = dmub_dcn21_setup_windows;
 			funcs->is_auto_load_done = dmub_dcn21_is_auto_load_done;
 			funcs->is_phy_init = dmub_dcn21_is_phy_init;
 		}
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
