Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E75C63777
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FC3B2408E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3cU8b8of"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC3B2408E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBB7789C54;
	Fri, 20 Nov 2020 20:20:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33E3089C54
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 20:20:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MohzAOzDG8vh+FMajy9Wr5NDdzgfsC/TKhqGW+mHtoEk57JlYVYQg7NFrXSc5qMEHly5LyBwicFB1QhhwMjDgAaRoVZO5Ub5/t2EOzF91INmszoeu4Hq6fG/LV5qI8mRUaA5rDOx6jF4lAdqIvbUKUNA2oQspmjVJWiRmESL9S7hO8GB5iVSiJdp44911POXIyix4zyZUG2xeAco4d2IyQ3cMPPcaCRsqQkm//g4mPChTRYmAGHp9puqb/eaZpPDqdc1Vl4UmEV9hKxF4ODRdWf/+5UKBESEtBoX0BqULyulA6rHdnNHuSTB0B+q1iGz5/+yOqssdEQqL9DvXCoN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGCs7WQ0YsdZwxwgZXyjhOzlKwLbdHk/1aijOCZ5hNg=;
 b=KOUqLcrXguynwdFnb3cX+4R7tLqxQtxXbwnSoB+q4r30bggMF8STQzi8P/SjWIopRHEXE6K676wDxAoKet4gdk0VLnLNZI2OaPfldAnrT+ZI/mAy7ignugzAMqn4hysJBcnn4xjx8EvVCTkONIZUuFNVeO03HaMihhhH3sDwnd8UpFvCmbIvCY2Cc8L73CW+AQU8ggMbkMuFDDPObZe3Wb0wgkt3aVL9zvzUzhzD0VtfMWyZoc0+uRxLt1W5Ebt6KctGj2lB4zCEleig9IR6zLjiTq8Y2Ma9sj4JT5kQS0DukrbejoylvZD1gzy6COngZuaTpTXRMzBerX2v8lPBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGCs7WQ0YsdZwxwgZXyjhOzlKwLbdHk/1aijOCZ5hNg=;
 b=3cU8b8ofZYCUWYvwWrLflm/KlSRvOBTYi/ScKinCoW5PccE5X7V3ixz/WCDd2/4Grmi/pEx2PVE+uF9RmuPyYa63mGklR+48wdTkU/LNq+1da6fRor+IBAe2kwU1PLQOZzyvKfV2nnXwKZ5SDhVXYCmjxlDG0uG9ieCyPNs8i4E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Fri, 20 Nov
 2020 20:20:22 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 20:20:22 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/18] drm/amd/display: add i2c speed arbitration for dc_i2c
 and hdcp_i2c
Date: Fri, 20 Nov 2020 15:19:41 -0500
Message-Id: <20201120201958.2455002-2-Rodrigo.Siqueira@amd.com>
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
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:20:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6cfcc271-974e-48db-222c-08d88d91b503
X-MS-TrafficTypeDiagnostic: CH2PR12MB4216:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4216258FA86CA6ED9A57A2EB98FF0@CH2PR12MB4216.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z94L9Wqcc3rSRuVwlGfmK5OliDEY0jV3g43OUHSRKyoHtBgMXHbuDorJS05KZT9PDTf3FeWCS+wNVNCz/vjnF1X2hCs3Zr1fY5pBOUP0WRqOZKa83UGbAcQR0pR0lBCVCb8LJymMM/7o7fPKsZqpAIy70lrngFlkPm1Ung72wA7EBuPpCP8cFKIL1nClsJCWyhiXZEsT0uqNkOA1lfUJvXdL1vWQ1nrKecAWe/Z1Wwob0+PtKP55tAyRqvgCSX6rUN5QFpX13+qohm7AjWsU1rEo4NE5gjrtL174fmDKw1LL4lAjL0UCAHZ1d9TMaqMV/9kNuoMhITK6NAN0E+gpag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(8676002)(2616005)(66556008)(66476007)(16526019)(66946007)(6486002)(186003)(6666004)(316002)(54906003)(478600001)(6512007)(83380400001)(8936002)(86362001)(6916009)(36756003)(4326008)(5660300002)(6506007)(52116002)(2906002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: dz8e0dt9QP18L4Xf32iafJAgYCahN0WpVuziqft7AqJMKbP/jayG5syURN5nufcUuglXIddB+Rho8LsZs+Ed+hEAxdiPN4YuzroVJ9o7MEOkTCTuChH2J7gb1Z+xCClcpsuPoPrYwitlVdSb07JDJxhfnDB0oWYQ+8RAByGZJP4wndg+plznTkpq0YotMCFW3GkJP+r7lCH5g9R+3wrPbS3M2uijco2bcrxZLb2lCOcD42vKWfRsG6/TkCaHuCte80e7bSW/WXhR0v6Btl1+QI3px8vCBkxMV3CzZOqHeHlTbEEElpkIYDup5QVeRxEqWFpMQmHn+wDvQDvtA6Z/NoNjNqtjMg+dkiZXUecR+vgGmRB13ivKiHkGtPUwMWhAfq8Oh2I2bJghVzjDvlAwiipSm2qmQBfyynQGfa9vP7IZYv+6L89Aecx7vndKXgbnX7wAgCgsAM9jlCsSBE0vUXr5StqDZE6SLhNZuH3SCf78bgLWwnjA8ZsRqoxCv9ZutG1ud8YMAwN4Kxwjyzcxu6B/DRNAdzQ2EVUiE4ota7e5hcqPji6IkQViiNaAYLMkYoeLsRfYlAdLjN+CocK7HfnQSwx5dV1gjMIXF7/9cf6nyHQMLY2ugcdAtgQwr63xbpYcmhW47yCiK/ClyvOomJjg/wy+IUW8Cb2jKhgATrBp/z3d16W0p+YCp1Fp7UVNr14Dkmb6V/Ldr0kMy5v5jvrqLY7P00Tf1xXSyxKmjXKjrmTgl4sJnMyReafAkFzd22rLEMoyhMKcbRo1W/XYQB70JgjO2uIbMz4tyKNfCzTz5QvrXMj2BQN2D0iF5t8anIOkakRpRuiG8xxMYYnEf29e65eKyFhcMyO4tm59lC+Whhl2eAvSnAISfbE90wT1eYvX7CnXpO8QSGIhswa/7E7C/Ow8Rn2KwM3bmk744RZC0pn0OKux68iyeuvb8xYe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfcc271-974e-48db-222c-08d88d91b503
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 20:20:22.1789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1Epo/d1iIhey/T6+eqfDiaY6TjfAYaCGoxhSd90Lzh28BE7UEDNz6qZ7YZLioac1gK/JHXWd38WQU6f4stAgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, Chris Park <Chris.Park@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
HDCP 1.4 failed on SL8800 SW w/a test driver use.

[how]
slower down the HW i2c speed when used by HW i2c.
this request: each acquired_i2c_engine setup the i2c speed needed.
and set the I2c engine for HDCP use at release_engine.

this covers SW using HW I2c engine and HDCP using HW I2c engine. for
dmcu using HW I2c engine, needs add similar logic in dmcufw.

Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 0006d805b3b2..d15220a4eeb6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1759,6 +1759,7 @@ static bool dcn301_resource_construct(
 	pool->base.mpcc_count = pool->base.res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 600;
 	dc->caps.i2c_speed_in_khz = 100;
+	dc->caps.i2c_speed_in_khz_hdcp = 5; /*1.4 w/a enabled by default*/
 	dc->caps.max_cursor_size = 256;
 	dc->caps.dmdata_alloc_size = 2048;
 	dc->caps.max_slave_planes = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 765002e0ff93..15ffd8a21e4e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1306,6 +1306,7 @@ static bool dcn302_resource_construct(
 	pool->mpcc_count = pool->res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 600;
 	dc->caps.i2c_speed_in_khz = 100;
+	dc->caps.i2c_speed_in_khz_hdcp = 5; /*1.4 w/a applied by derfault*/
 	dc->caps.max_cursor_size = 256;
 	dc->caps.dmdata_alloc_size = 2048;
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
