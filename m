Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05A7C4167B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B158F23B86
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B158F23B86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EFE96E9BB;
	Tue,  8 Dec 2020 19:29:01 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760054.outbound.protection.outlook.com [40.107.76.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E6D56E92D
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 19:28:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHiy9bD2X4LEKctm+OeNousue6UPSLp7fesZ2K3thdbrcbhcZu1+d0nMb+zdo/TnGiy5HZALb/Yp3bQCXYxRg9eINDBcuEWIt00W3zhIqH18slNkXtElLzVCrQ6K138kBwDv3WMY/7klpLkU12+rMer8c1hvrZFknM57HMztKI5uoDr8eTxa5nmX4M5mu2BSgwrRS7OcDIS3+ErWPrstrsWc5JxfulnbzJVuKTGt10GUdSbf93ujOIvDdpAVi4N8/7xNutpmLPuD+o2NC8FOWm4eYA6hdSqA32ps4wrOxlLw4X6oYmh1tUJEyjlYXxAUTNo1TVSTj2Qba2S+NtP8og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7czM/qSUIR0jS4l7aYOJLO3t5dGEcnGKlD7tPHKS8JI=;
 b=mdI0KkjMpdYacUFQVGVQat5hcJRObu7WzfXaHlInilNXw2kp2I1uK7j0sPBTTXZN+mQ1U7X972TMFu16ij/AwWbjpK8bhlOivVUHhq8tdQWZsgecRvJG6X/fecvGPa5iA4PNadU8yrtYCwUeyLiaPVgZgXFdmn00nm4siRKerKhclOu0e5JlrrKCfGIzw+r8fPIQLWfi1eVN4bFFSKbjDcaN8XuI6vAmUVWy9G3oKtV6wFsapTqTD7Srmq9pkV06WlMUqTQd9RITRSpvkokP+MOm9/jNjDLVhEB1y05kfJEox2dnYTHpg/lvH9UxfwgBRgDXm7py+Mfw2RqJxAgHyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7czM/qSUIR0jS4l7aYOJLO3t5dGEcnGKlD7tPHKS8JI=;
 b=rD7BZ3AKro2Dv3pra5z9+XcBqqGquQTZxhy1SKTk/BdV0/DtyGGMdujZK1rd+OJNv+RXkRoKuHaG/1eepkBEQUi5qcK/LYATxniHhzRuaMuwefaKpqC6aqBks6nsjWio90mJsRX8pxZ8I4F+S9oBGC1vCV7Lcw7R1SAaE/kfYLY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 19:28:58 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853%6]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 19:28:58 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/13] drm/amd/display: HP Reverb G2 VR fails to light up
Date: Tue,  8 Dec 2020 14:28:34 -0500
Message-Id: <20201208192844.23580-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208192844.23580-1-qingqing.zhuo@amd.com>
References: <20201208192844.23580-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 19:28:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0902b0c7-a2da-4c54-2c02-08d89baf8263
X-MS-TrafficTypeDiagnostic: DM6PR12MB4388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43884D71B2AAA1CE987E7CAAFBCD0@DM6PR12MB4388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 679H1iAByEgFDk4LbCevTLFtMf9Ks6qVSrBCfnAhre8N7sz5SWyqlGPYys8MjTAYJi+01rY5Lo/pWugvjmMEJbRKBMWfVwL6/vAObBb1RoyH35+68FP8SCw9AcY9D+BpvktG+LFNWA9w+oH+Za489QlReAwiI742nC2Nkt8bKn0K5KIiqjUum5m/N7Cb0U+UNruGRGn+taecREyx/ReaqItPA/Mhlr7hz2Z8JvQnIYgvqi/TH+loGz/1fDmIskwFiN1UIHtG9EzaodYYoOxOP2CBKVKK/+Izz56/Z4Dgm/Nb8HLcBtahlsK/4UdjDFfhVgGN7D5ZmAApP9Ug/6ZZL9+mnwlyjAUqGpljtZW2H1k0/W0f9ZiOSZ5Jxj1mD+4oFmS7QH7ifx4fRTyGr+m/hdb+LXN8oqKmRy24TPzqHo8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(6666004)(86362001)(83380400001)(34490700003)(6916009)(44832011)(8936002)(956004)(2616005)(186003)(6506007)(36756003)(52116002)(66556008)(26005)(6486002)(5660300002)(16526019)(66946007)(4326008)(2906002)(66476007)(8676002)(1076003)(6512007)(508600001)(69590400008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?S0Rhm8tLAvdvFzAivLonFq2rHv9+IFNMf1h2GpH1mcZZu1n3My7mR8uSKXjr?=
 =?us-ascii?Q?fXOaLaH8rEHnPNgdh+bbNhjPHKRj8cmdW9t+Jey/dR1x8aqgaq5d0bMEuyWs?=
 =?us-ascii?Q?9hjry32+yyFyo26DAhWMsqRLlruUrLb3gSA70U42hhQoI8OoiRFbnORGcuf8?=
 =?us-ascii?Q?JSni4iKv0E0cY2reN01jjGjT/0XYuA73VZpaf5hTrPifwOerf0bfQ3bkKI+M?=
 =?us-ascii?Q?9JiwkZ5wV0iRj2wshBskTriGKHlj84s/lRBEiI/PKcdtI3E4CIWRlkSQF0Pf?=
 =?us-ascii?Q?CbUPd+cew3r3joz7Tc5jDQFWsxWWVBW5WIN8jkvE18jIbgfwCJ8t8gdt7zD3?=
 =?us-ascii?Q?dr1ijmmaERhMamSce8UYlY/2NeSf33DIxq+2zctqC8C5mhZ4nEuQg3hf0Svr?=
 =?us-ascii?Q?4NJDN39jrmqzLzalHsmcgRYl3CxWVl4BoDW9/VVqwbReHSPU9fQ8j4dJIBkk?=
 =?us-ascii?Q?rqjbdIo20Jst6kFDt8nBb6SccqrP75jamXrGk4/x43udzp8tH4HoZkEMl9mB?=
 =?us-ascii?Q?JqFyo33VOY29myB88hAIa0u2TvqvLjmAZGz03GB+FSN8oyF+KDT7pWTAQLlu?=
 =?us-ascii?Q?rzYxWjeWJ333Kfs4sPeGnoVrI+KoGCTdbV6ZcuGsHcMRoZ9s26ykTWGMRxWl?=
 =?us-ascii?Q?IX8DNBfXGN8sEChW5/+g+Xq6/v/P8I+sFTY3b27dFP479QQEI4HAdRG/7tul?=
 =?us-ascii?Q?xB1/EXCUA77RkZQ3098SOQ44Y5p3gR/EIFhNLdoTnVCVkUedLZKpfVHXVvDy?=
 =?us-ascii?Q?OU05q7wcjQX+Ap6cbGYmnMtSMJwOmcibCI/bRoptqU70fkiX01Iw1iaesGij?=
 =?us-ascii?Q?nbCkgn9zq1n0ZiatoMc9wen+8n1K6fzh4VmKve+/mLm0V4cyDgTSDr/sIqyc?=
 =?us-ascii?Q?EbdOv2UD8a+IktTkqTpqd2xOKJEi+hNrCCIgC+wt1LE1WzevZnpJ8A+hVcab?=
 =?us-ascii?Q?fytY7xZFmu9BfLmSc3PkFOE0FI13nAue+N3iJ+UcsmZJg9FtZOM6Y76oc573?=
 =?us-ascii?Q?q7ha?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 19:28:58.0415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 0902b0c7-a2da-4c54-2c02-08d89baf8263
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfVrgDOmwtEq5AyFJn/BZXrSOk6hbri3vCp0tmNpHROaljmUL1irq4jGpbqTadIj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
Many VR headsets require a HSYNC width of 4, but DCN
has default minimum of 8.

[How]
Change the arbitrary minimum HSYNC width to 4 to match
DCN20.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c               | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
index 82bc4e192bbf..915fbb8e8168 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
@@ -1268,7 +1268,7 @@ void dce120_timing_generator_construct(
 	tg110->min_h_front_porch = 0;
 	tg110->min_h_back_porch = 0;
 
-	tg110->min_h_sync_width = 8;
+	tg110->min_h_sync_width = 4;
 	tg110->min_v_sync_width = 1;
 	tg110->min_v_blank = 3;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index a125d3f05c81..48ccdcc17ede 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -1540,7 +1540,7 @@ void dcn10_timing_generator_init(struct optc *optc1)
 	optc1->min_h_blank = 32;
 	optc1->min_v_blank = 3;
 	optc1->min_v_blank_interlace = 5;
-	optc1->min_h_sync_width = 8;
+	optc1->min_h_sync_width = 4;
 	optc1->min_v_sync_width = 1;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index b1f228fc119a..3ba3991ee612 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -350,7 +350,7 @@ void dcn30_timing_generator_init(struct optc *optc1)
 	optc1->min_h_blank = 32;
 	optc1->min_v_blank = 3;
 	optc1->min_v_blank_interlace = 5;
-	optc1->min_h_sync_width = 8;
+	optc1->min_h_sync_width = 4;
 	optc1->min_v_sync_width = 1;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
