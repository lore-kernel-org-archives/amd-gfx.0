Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CD1C35646
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1FBD2067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uIbLcX6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FBD2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1C9A6F4B0;
	Fri, 21 Feb 2020 16:04:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C39116F4A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGtDSxgSwJ72VOyYcYq5qWJvA8KdNjNwQyyWCq5atKbhzOrvFFaZ1L8XlSA4TmlWsEmLOJ80SgcEZ53rOv7JDl1XoeoEesNwEdnnF+MWw6X9oqjjJPtw0WBxemxwtpMr+LxfYghyQfzUaRvGKOMw+vTz1/It/2f2SF6kste5FOKowVA8feKEnkgKRyAL2+XROSlhZSa6w+B/7I0rXjGRV8jqBbC7n3arRNry1ymkRtKHQBC4ucImWUThZhNyY3K5byYqYXuGaFhpnilwHKxVOWoGaLGVMo7m9RqsqpP2ul2CVBTgq5qO5K0ouexmvSNbxiAHDhphVyQz5/mHx1Z5EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yLSGlY/DgNXLypjv1eeK7iKujW69f7XHuZjWcY4N2Y=;
 b=WvaCbf91EO3s8ZrzjviUYlVs1VAxZqLXCaXU7am506RbtXaNo59efCh70qHtqBgebV304jKLHjyFyFlUKxIF5QvvzAkja38HnOlfyM/sPYbeSgZcjOKFXtzDEsqtkXaLcXaAud7/6A8r4f6lME84dWezlaT8rQ7fz3CQVKsDMAIctZOLgcmrHp05qsaZoT0grl3Kd1iRlY+DsOUJdnl7MnkdiPDovp2KqD3Ki9Kg/ijidJg1/LtrYnbKy8iZDpKHgm3t7FiZIVUJPYSHaXo0BW4pr+K+r1QKB0dhS7jCR6es9dCcUN7V5MuS7du9FqnLjMUOINtaOI4zSaVqxbFbnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yLSGlY/DgNXLypjv1eeK7iKujW69f7XHuZjWcY4N2Y=;
 b=uIbLcX6aFtojYpmIBlD2ajndhfoBaOD6tdoTPe2UDnspW+nelrtKnkGJ9wsWDY4dVLcbAFlrEFi0koC6twQ+ZH2ontXEMIXX/NXDX9OXMUPSIYzCY2Qd2nMuQdPNgx59+lHgIAcLDWsMR49RbhSCosM1aHZ5W3edoYHnb0s8Hyw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2409.namprd12.prod.outlook.com (2603:10b6:907:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:04:00 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:04:00 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/35] drm/amd/display: programming last delta in output
 transfer function LUT to a correct value
Date: Fri, 21 Feb 2020 11:03:06 -0500
Message-Id: <20200221160324.2969975-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:03:59 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 554315e8-e310-4142-8b7c-08d7b6e7a9d3
X-MS-TrafficTypeDiagnostic: MW2PR12MB2409:|MW2PR12MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2409A0EEA3829503754A701498120@MW2PR12MB2409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(16526019)(36756003)(66946007)(66476007)(7696005)(66556008)(6916009)(26005)(52116002)(6486002)(1076003)(5660300002)(6666004)(4326008)(8936002)(81166006)(2906002)(2616005)(956004)(81156014)(54906003)(186003)(316002)(478600001)(8676002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2409;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 03dPMNgROvZ3fB0m3P/i2jffZFqE33DFW7ckzVt4pl/dy3OLYWA6XB8sEqRoyYImQl74O0cP0uebhbrTr/4aPQmieAjpNCplyPvLXePsl09CUf/R2hlEVwYkhfMJcZWF8YUjG9i+/XynE80SO49P62U5+wMOtBE/Z7tEPp9pI35l/m3EcCa9Qq9jAS3a+yjj1jU6Iyuz4lgoqa/I73+al73UIF/ERa8DHexFISNwbz55AJLA+1uh332W8iuopxgzeRDZFlHhohK5UxL8WiTYpr3XdOvl+XoMSmb99eiB0c5J2ljYJeqbXWX3ciDpr5TK1UH1WSJktNF53z5mGDB6auKnidjdmJ4YFMeQJbRDFOkzpNnycWawNJF8Lyfu0dY0Fz8nUmeY52cqIafGNqD3iyJDUe6Uy+x+YT/10SoHzFjrBPjK0kIwpy0w8jimo7x7
X-MS-Exchange-AntiSpam-MessageData: QXpeqwZ9yHSffLBcKq559AMHTJreqmkjg1uxoc/2Yyx9H9SThJN/FPfCr6pOsNgER4TmMWxYNhs4eT8lOh2J57LtuJktXYlA8DXZukvcQfXVr9Cf1umgv5Pj4oODcBgznqEIQAeO/eVFC9clwVkAFQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554315e8-e310-4142-8b7c-08d7b6e7a9d3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:04:00.0937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gnhFIQDSTxpIhJBu3JH/+5r/h4Gmm04860Uqs5PsCEH/Ai8kPLL9cbgben7zZaOr31GVi20YTfONjQaSqmnvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2409
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
Cc: Sunpeng.Li@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Rodrigo.Siqueira@amd.com, Vladimir Stempen <Vladimir.Stempen@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vladimir Stempen <vladimir.stempen@amd.com>

[Why]
Currently DAL programs negative slope for the last point of output
transfer function curve.

[How]
Applying a check for the last PWL point for RGB values not to be
smaller than previous. If smaller, initialize the last point values
to a sum of previous PWL value and previous PWL delta;

Signed-off-by: Vladimir Stempen <Vladimir.Stempen@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
index bbd6e01b3eca..47a39eb9400b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
@@ -316,6 +316,7 @@ bool cm_helper_translate_curve_to_hw_format(
 	struct pwl_result_data *rgb_resulted;
 	struct pwl_result_data *rgb;
 	struct pwl_result_data *rgb_plus_1;
+	struct pwl_result_data *rgb_minus_1;
 
 	int32_t region_start, region_end;
 	int32_t i;
@@ -465,9 +466,20 @@ bool cm_helper_translate_curve_to_hw_format(
 
 	rgb = rgb_resulted;
 	rgb_plus_1 = rgb_resulted + 1;
+	rgb_minus_1 = rgb;
 
 	i = 1;
 	while (i != hw_points + 1) {
+
+		if (i >= hw_points - 1) {
+			if (dc_fixpt_lt(rgb_plus_1->red, rgb->red))
+				rgb_plus_1->red = dc_fixpt_add(rgb->red, rgb_minus_1->delta_red);
+			if (dc_fixpt_lt(rgb_plus_1->green, rgb->green))
+				rgb_plus_1->green = dc_fixpt_add(rgb->green, rgb_minus_1->delta_green);
+			if (dc_fixpt_lt(rgb_plus_1->blue, rgb->blue))
+				rgb_plus_1->blue = dc_fixpt_add(rgb->blue, rgb_minus_1->delta_blue);
+		}
+
 		rgb->delta_red   = dc_fixpt_sub(rgb_plus_1->red,   rgb->red);
 		rgb->delta_green = dc_fixpt_sub(rgb_plus_1->green, rgb->green);
 		rgb->delta_blue  = dc_fixpt_sub(rgb_plus_1->blue,  rgb->blue);
@@ -482,6 +494,7 @@ bool cm_helper_translate_curve_to_hw_format(
 		}
 
 		++rgb_plus_1;
+		rgb_minus_1 = rgb;
 		++rgb;
 		++i;
 	}
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
