Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F6EC433E8
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326D920768
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="G2N3PCw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326D920768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE326E266;
	Thu, 13 Aug 2020 21:35:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D51A6E264
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 21:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBqRQoy93GZfNPlV0U+r1JLW/Gev6KoJUZxs3aA2eAdDhLWm+KwQeQSsT0wCpYhxnOZN4ZI7D5j+VDEpENBILOyng7pOBfg7EGzK/gdbxwX+n2UecGIRrxG/mzHajxHK+NsrfqJBuB1NnztuB5WQIGQKhZDss48NpV4GB8hZFQ96ZhLUImwnAqSVv0Cpm5MrZQqvtCqxpb5zLBJkOQXDLtMk27u+zf6LV++57O/nLLsfpduv/gqxsnPNQf94RBKqG0iV/fHNh4ClrGBrMsNJ+h8mz7TkzKQrTQgDI7J/ipZmsGIEAEvlabSNrDYMSs6RL0IGBRJ5kFHy9emZ8tfmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXK4w3coOzwoRwOdb6ommcTYCZUkWjawdLfsr+SxHrE=;
 b=I25zYT+fYKxBcIxFShfouTRhrzl0Imz0Q5GYhHNhqLxwE/rj3mloppe/TiWnuXceQwC7nngN4/Tv4MQGRTNmj/K91hjasZFGa7ik9nEHBI+kui1a7ok3S9OLUuyucimGGT1Ovi0VljH1+2o74PkEgLJLHhRlX/uwCNbLxxpJGQIVK6YoeEOE+cbWNnT8NYA1BKGd1BkX/1OtVopykk3slx8rcdTpKvgvOjg0JYRthSH/YhB80I3w7Se31iTO5Pf/UcjURYZhomGPjMtpaZ2AaBqcYpnHGgdQckMW+vwEA+48z6x0/YFB1zpADbsn0AdjP/L+EK3KxOVCl1h5fj6dbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXK4w3coOzwoRwOdb6ommcTYCZUkWjawdLfsr+SxHrE=;
 b=G2N3PCw2mPftQdZ743pdAU4aGwxyQYF63mqfixsy9a0zZnmjNIhEaLhGjIDNYOIiImmIYjaLJ7WL1rJSgbbed0AKmtvyaywGTdV3M+mcd2WlJX4br65RIhhd45LG9wb97n5hGhpYgb6eN+lkPHv52mpjJvXn1yHMM/9kDUSO9Ac=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Thu, 13 Aug 2020 21:35:36 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7%9]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 21:35:36 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/17] drm/amd/display: Mask DPCD field to avoid reading
 unsupported field value
Date: Thu, 13 Aug 2020 17:33:55 -0400
Message-Id: <20200813213356.1606886-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
References: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::18) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::2db6) by
 YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 21:35:35 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2607:fea8:56e0:6d60::2db6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92eba52c-e79b-4f51-74d7-08d83fd0d09c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1355FF3FE44E60F952C2420098430@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6tJ2A2MpkSssjk6Vr65pddhR/0wi2/4opf7tH8gYZtUBuqBOi6YfrW+TOLehfmy2PYphQa7nieyVTAeG4Y+3/H3BHej9ZoM7O+TTP+UAN17moSYBny+6Yx+Do+UUp7Akb/4SLZecw1HA52biOQIh6P0XVyJQGnoKJgrDXyg3mH4kBr2Sfw2clak1Avuu48RuM87skDgJnRdPPUKODlVJbXROLTTqCF9egidVPQg/toGBV0r4ks1ERANOicnp5aaVn/ov3SuLlVJZmipeFIeseeZuG/A5KWFAFuuS4WI8m+wfTkH7amSQVzSWe0abxIAy9AaCs5WEyHxwNMsEG8l4yA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(2616005)(6512007)(83380400001)(6486002)(4326008)(316002)(478600001)(1076003)(6916009)(66476007)(66556008)(36756003)(52116002)(66946007)(2906002)(6506007)(8676002)(6666004)(54906003)(16526019)(8936002)(5660300002)(186003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: snUx2SDKx9UpstYgxOQc3ZMgvLR+dBqtrnrfGeAGHmBHP6xVecsOeHx/FLtZBPG/HYHqvYdiIECd/Y/PKkFBhK/+hrSTr1cw1CEt2XjpBk5bxnjKXXyWdy9TcRR8bSR4rJBUxP3mNrgWFYthp0fKHR2lPTDTW5RfeX1T3tB2uDVmeW8H4Q5OLulGZp1UQgfVSgmm0VKjfDeOKPU+Ot0SDBo/jOUf69B31kh3pBGpTK67+bdOWpoZf4SCVBZX5wrdH0w7knV8Mrs/evKocsPudgDUEAuhRyYNFE3HwIYszFbO5OvwJeO6KoMOdgKKhhkLu4IkEjWOSBsjzRewRGCLnRS7LftD+gfmsiPg8dbwXDrr3AMNzmgRj+KfPoL1e6WkTA+uGKRS6SdmphCtayO6m9c8RCCEwqhUVJlH3gAbBRss2r1H6ukIHkkV0ILT9SSjXRCmB7YK4uu/wnWhpNxFLivWU/atPKBk1W8dtOlaLPlMKMHGHqwmaeyL1bpmXnwy4Bzl7E08wADUJVcoWUt5j11w6l5tvAeA2fJ5EFo7Jj603WDFqWht62q28TliuX8R+NoImUREojaSe93QCeSRw3V/OVN4IWHcLcdPFuhglyrcKXuFHk2z2mZhxM1oMDfUQ1XI6/zQctnRKRzAWZPc/JS8+RLW0tfpf8HZFel/YTk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92eba52c-e79b-4f51-74d7-08d83fd0d09c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 21:35:36.0667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9IZaufKJFmGX9FLSw71KhqqUpoJYg/u74zylNLqFP5H9ra2gSrUjTjg8taMrlMWKlj4U/lT+F7Uh+N8WydtPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
Cc: Eryk.Brol@amd.com, Jaehyun Chung <jaehyun.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jaehyun Chung <jaehyun.chung@amd.com>

[Why]
DSC will be disabled if DPCD 0006F[6:3] is set to a non-zero value
because bits 6:3 are not currently supported. When 6:3 is populated, an
unsupported INCREMENT OF bits_per_pixel value is read (DPCD 0006F[2:0])

[How]
Mask the INCREMENT OF bits_per_pixel field so that values in the
unsupported field are ignored.

Signed-off-by: Jaehyun Chung <jaehyun.chung@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index da1b654833d5..4c844cfaa956 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -192,8 +192,10 @@ static bool dsc_throughput_from_dpcd(int dpcd_throughput, int *throughput)
 }
 
 
-static bool dsc_bpp_increment_div_from_dpcd(int bpp_increment_dpcd, uint32_t *bpp_increment_div)
+static bool dsc_bpp_increment_div_from_dpcd(uint8_t bpp_increment_dpcd, uint32_t *bpp_increment_div)
 {
+	// Mask bpp increment dpcd field to avoid reading other fields
+	bpp_increment_dpcd &= 0x7;
 
 	switch (bpp_increment_dpcd) {
 	case 0:
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
