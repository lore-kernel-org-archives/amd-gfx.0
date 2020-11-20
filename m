Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247EAC2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B53E622D0A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xhLt3z0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53E622D0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7CBC6E92D;
	Fri, 20 Nov 2020 20:20:34 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680047.outbound.protection.outlook.com [40.107.68.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4242A6E91A
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 20:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/Gl+uRGdKCBD/1ZljYqJz+KuMlDjc510zvAT0zv6fPgr77+7heYdblHEnuxSeA9y8NGM80ESEf33huoXNSOQYQBg3+7niBcA3JOfMfo+VhEszHxsoswKrN+CPU/S/8E9VyeNZXaDf6EeWB2fM1lrZCMuOmDQf6bxwohRWhHQu9f/MqmiXXSAd6yEp0XQ9832DWhgkIvvLgCJvAtKPffJrfDpGovE/NXblIkFAplVa+FcbW007Ws0FNWGqm4EGFcSQftQ/zh7gyG18wSy+BWGNHNRHjPTghdogYOJiP0ihjypQuWQmROgrGD4koocf0TmVupRsBhtmFKPeQzm1hkQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/1MyXYEsc4/XVkzgGl76oUgNG6tdhP0zall2UksNOk=;
 b=N86GGsz++BgUcZx5zr2erDemALYzgHbk4qhCSNIaOe5MeI+y/qJZy3eytXJoe5HTZajH3fIi7Ek6IF8gdnAP56/ceEj+NQHMz6ta57pMvLkVsOBETMuhGsxeMRQRPKRaxi3U2O6BjZGYTLXLbqRJSoV8+RWXAohezcX+SYOhQEZ817QdMdmSZBaGtfsSngHS0EjtgmpkQE0XRVY6Xqb0rYgHfBNmCNpQxKfiRrtQKPtg+aQGyuHs3kS8dTjh3Lq17dhXnlGZXZcsg7KqdfVPvwNIRpfruStNSS1Z+zSIt1l4jdRrv5OwvylWHIDkM5AOveTqmhLWAYoGZzPbNoOIeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/1MyXYEsc4/XVkzgGl76oUgNG6tdhP0zall2UksNOk=;
 b=xhLt3z0X/FbEKayBD21U8y7iS0tgFTn9zSzdkYuyIxPFOcGplkirkucLqjilf84ABsakLGTSeVaD0TlkLbbqKsq8RJXLQz2TS71F0E4/NEdXpplgQOFIl0Xy3GJT1UENyCFXBMcJF0H/8rStPUCPvvCO7djRq27mZZxIt2LOPIg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB3717.namprd12.prod.outlook.com (2603:10b6:610:24::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 20 Nov
 2020 20:20:29 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 20:20:29 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/18] drm/amd/display: Add BLNDGAM memory shutdown support
Date: Fri, 20 Nov 2020 15:19:50 -0500
Message-Id: <20201120201958.2455002-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
References: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::c908]
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::c908) by
 CH2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:610:50::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:20:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 46e32eb4-29e1-4ac2-c5eb-08d88d91b95c
X-MS-TrafficTypeDiagnostic: CH2PR12MB3717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB371757FD14DEFDD8D0CDFE1998FF0@CH2PR12MB3717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XaJrOcdnFExxYfQ85CqInZdlgyz6xHujJ2xKK6lMZnUEHclZsekSPlVK/Su+mwhIONeHJ7/pv8e1m5Y12iLTwdhGj6xYjrMmF0HvhS8Tr/FHV8m58GH7k1rjnBB/s5nx/51GrT96tHkMGfDyK+Y4yUUWlBOYoaupBXKPr35ubu6TTkSRgKh3jYGJiH3koNVFqCYNunrYe9U4ZZqOTZ9luDDIA4SDjnPnsukJBMJStkct3PVjrsewXr43Cl66oV+kfV7vtGeSDsPOXs9YiDyDQ7VNXx5Ygkr/4UAv79dw5MxeUCniWY0lIMtbrnMAedJZ1QjloUQO3CjW+4SyzVK6dQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(86362001)(66476007)(6916009)(8676002)(54906003)(6512007)(8936002)(66946007)(52116002)(6506007)(16526019)(83380400001)(5660300002)(2616005)(186003)(1076003)(6486002)(36756003)(478600001)(66556008)(316002)(4326008)(2906002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: H6HAMofT4YLaKEE8adPMPL7SRqsqTJw9CrZEOQal/cYGvLAcflKozF6t9nHTjijJTzbOB7d+CZOn/lmPqsPOgNMmTBVxHTzZeibcSfpqa6iatYIfEku88lvD6tlqVN8dO3q0sQJua59XgEKKa9IGGXffb4lT+ocB1PHWhXlblLC2gNKoe3ECOT8QTU1lXiHWEgyr7tToTebUslzBSmZgB7GutwOIx/L4njMOVkHORWsojuxMzrxBxmfNRDErv/eRyzvS4YL5glpyldQJBC8abi+T+tFGflnTHXmEtnleelVf6i2537K7IBMmVhMb5yhdrtr6UYdfF1jt9+viDAB2tmAm2nfx8oGhhrIQZHFrPXum5M3DooS1fXsWSHno4pONXpPC0kziiQhrKMWwnQoytZyI2GS8DHcFeHbySu8e8SuwN9jRDxwWOMrkl60woOGxW1TpPr1vHhe1DZbVDzygKVXFPncp/ji8yG22Ph2jKOye5UTfJcd7Rh6lx2S5LMFWQyIPw8B6RDoDNYTtNWioxc1xm7EZcpK84ApjdLkgOaay25ErXGsFronnSKY17EahJMaTlD8DJbQ2f2zdEDSzM/B/I1ZIWcgKpCTIeuItrXprQWy7euiknG4BDfI8ibCJ4MKhnwtEFISVziKysXfpUdQsuXqMEgAoftAFZfZ3RfCiLddV8jfDXvZDtZemGj/cp2grFySOrAbjuWAS+bxGdHwzr030JcWRzybMLpLBBSdDV7IwqpQFjp8WvYVaHoIH2schRAuw/ZFXdVCPWgpBzZRW7Mg0ITT0G31+tHyN4ctma9Ik899QnsvoK0Znxpw4VSkiLaOgnPIYauHa46cRfFdhUBdxbU3dElE4SJLOXQz4dO388Wlj1D2C3VPHpsd2X+zrVhPSU68xcVIogKji5tw+LiO96O4rja1eq5dQyK89BqKFnffbo+SbqAzk/vtU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e32eb4-29e1-4ac2-c5eb-08d88d91b95c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 20:20:29.4183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnuOYkOKEEHe21GGZoPrLBRbu1IZBta9w1WgjahMNWMhBE3E7WFaWZv5wJaDYdUYAdO5VfYk3jwfv+MZhI+2ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3717
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
Cc: Eric Yang <eric.yang2@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Aurabindo.Pillai@amd.com, Jacky Liao <ziyu.liao@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jacky Liao <ziyu.liao@amd.com>

[Why]
The BLNDGAM memory blocks should be powered down when they're not in
use. This will reduce power consumption.

[How]
1. Write to BLNDGAM_MEM_PWR_FORCE to put memory to shutdown when BLNDGAM
   is not used.
2. Added a debug option to allow this behaviour to be turned off

Signed-off-by: Jacky Liao <ziyu.liao@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c | 13 ++++++++++---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h |  4 +++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
index 29231528f052..052bab3e5e8e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
@@ -500,9 +500,14 @@ static void dpp3_power_on_blnd_lut(
 {
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
 
-	REG_SET(CM_MEM_PWR_CTRL, 0,
-			BLNDGAM_MEM_PWR_FORCE, power_on == true ? 0:1);
-
+	if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm) {
+		REG_UPDATE(CM_MEM_PWR_CTRL, BLNDGAM_MEM_PWR_FORCE, power_on ? 0 : 3);
+		if (power_on)
+			REG_WAIT(CM_MEM_PWR_STATUS, BLNDGAM_MEM_PWR_STATE, 0, 1, 5);
+	} else {
+		REG_SET(CM_MEM_PWR_CTRL, 0,
+				BLNDGAM_MEM_PWR_FORCE, power_on == true ? 0 : 1);
+	}
 }
 
 static void dpp3_configure_blnd_lut(
@@ -675,6 +680,8 @@ bool dpp3_program_blnd_lut(
 
 	if (params == NULL) {
 		REG_SET(CM_BLNDGAM_CONTROL, 0, CM_BLNDGAM_MODE, 0);
+		if (dpp_base->ctx->dc->debug.enable_mem_low_power.bits.cm)
+			dpp3_power_on_blnd_lut(dpp_base, false);
 		return false;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
index 81bf2ecc2831..2ae5e1f93dd4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
@@ -343,6 +343,7 @@
 	TF_SF(DSCL0_DSCL_MEM_PWR_CTRL, LUT_MEM_PWR_FORCE, mask_sh)
 
 #define DPP_REG_LIST_SH_MASK_DCN30_UPDATED(mask_sh)\
+	TF_SF(CM0_CM_MEM_PWR_STATUS, BLNDGAM_MEM_PWR_STATE, mask_sh), \
 	TF_SF(CM0_CM_BLNDGAM_CONTROL, CM_BLNDGAM_MODE, mask_sh), \
 	TF_SF(CM0_CM_BLNDGAM_CONTROL, CM_BLNDGAM_MODE_CURRENT, mask_sh), \
 	TF_SF(CM0_CM_BLNDGAM_CONTROL, CM_BLNDGAM_SELECT_CURRENT, mask_sh), \
@@ -446,7 +447,8 @@
 	type CM_BLNDGAM_MODE_CURRENT; \
 	type CM_BLNDGAM_SELECT_CURRENT; \
 	type CM_BLNDGAM_SELECT; \
-	type GAMCOR_MEM_PWR_STATE
+	type GAMCOR_MEM_PWR_STATE; \
+	type BLNDGAM_MEM_PWR_STATE
 
 struct dcn3_dpp_shift {
 	DPP_REG_FIELD_LIST_DCN3(uint8_t);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
