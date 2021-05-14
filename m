Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D04C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E770D61447
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E770D61447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C4F66EE00;
	Fri, 14 May 2021 04:51:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81E5E6EE01
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1TkPA53yjDhHSkKCJYeD3Scb9W+hffxOLQ8+f163AVqVLrpolOUea0/sy4NKB2UgUVPG7eLyvDPjFJigDL/YQ1CkwnG2Fj5a/MJRBffJZ3cudWN80inzUAxJMDWIiejyOAb1E02WLmiPh++xM9/Q0sE5bCaZwJyLWyIb32Ji09BVVuxzj7RE1adaClLezRKxqjzZ/LPF//ZR1bahE9SjKy6XxGjj7kQXEZEuBVCjdYNmI3fdONGYM5sy7gCeyUaMel9S8y3TQ8HPzzgOn7i3yTbj5oMLa/Ih+ffDE09A+ZgrjFIAKrS226bjz+kBh1XuUy6vpSniweVa8mRVm4nsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cUsp/9hlpmGPOzsw1W84uKHSOa0ssnKwPUhrrrqXHc=;
 b=lDTOHFIOsh1lMBir4blfc3w+ygEoQCHLsgdnaTPjj7+KOCjzt4WbcUhP6oi4moIogv4SZSXTljWAj9GcSuaTWTZOJ2MHMEqubesHsIX2RnSewCzqozxLd5k/54exsOYtNZXxso3gxaBW7kDBHAJN5UDjpFbvy+SgMfUWGZEz0qeOuYRvAqDjqyjNdzgx9d/6+6lPfY4Iy7vG8rqXY269537SVpdefZWB4WHUOYgjij3Y+5WUzzsoTehQXF8xU0GfdnMckcpgb0O3xGIsZL1VFciIj47MRROQVUF0HCogikDS9yJCsScHnsL7ZKfW0D5LQCtN6ErIbw5NY1MyXSmHIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cUsp/9hlpmGPOzsw1W84uKHSOa0ssnKwPUhrrrqXHc=;
 b=pdzOfOFHjMabSbs2U9X8t8N0S1iXeGsWQpBKyigV5o/1PKhdTODLy2w13J0kXj7qi2VcUtq9Dh0VeTIL1RiqUB9E+QVBcXFoBzfY9etuaG4VJFiqdYswpgMK5kWNTosfeo0nEDwa5kG+2OeiwS5Xw1kmtDNO7In8awqohO+G0QE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 04:51:20 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:51:20 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/20] drm/amd/display: Correct DPCD revision for eDP v1.4
Date: Fri, 14 May 2021 12:49:58 +0800
Message-Id: <20210514045003.3069681-16-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514045003.3069681-1-stylon.wang@amd.com>
References: <20210514045003.3069681-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:51:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcecdd2e-67c5-4ee4-faec-08d91693eab1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3129AD6C66A1B1A2518C1897FF509@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5r/ZUuhKtBa9mdpqM3ogwdz4RO49b+DQRze366A4z9zdHtvMgh6tTcCr5u93cfXPsuSEWv0/kDuXsyhrIEN9DUOd5Vz3hDFNLE3x1kIGaQX/7rWD+JUFjpAIFV2sG2nhmtZF/or9CRieZs9qNXnUtkY5vLR9D5BXnnde4XunfgkZ9as1OENrLiKr58Fso/EZ/3iabndzhZukD65M90uGpGgWdbar6lTEFRcZ852JDF1+BTR70pcx196YG1wlDJFg95vrYc6VfcnHy5IOKlEPuCKF2gB1GDmkwk0U1UFwmnocZzmEHl/lUVGu8SCVdrfdpgE93BQrrvmrv5sFN3O5YcFMYZ4aQOzAkGE6F5EeBeiVOoY88+o8M7CtjdzoLKyRogomp/Ft2hCbCAwQvX6fjgVPl2p+EDKAUHSUczUDE6E3a/Wb+K+g9HU1IbsRjH6F3vzcyNlcHsBYI3jEyaEa7sZFEoj2LscIuPsQo0bvGcaLXiOAXONgQW1xClkfQg2yTjNbnU3wmFHQLetmhylRyPm58vg0wpw5Wr7qyWR6lAi8junwlkOJocz7USw/4VA//oMdYXTFCDzT4PfKz322WPcAvfzwK1vyjD89na2eu3QO+3BAr2OtX0M80IOpMFpx6ue14PeJW7FJCAudIH5R4dI0HqA+bhpozpalQ0x9zO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(8676002)(316002)(478600001)(83380400001)(26005)(956004)(86362001)(54906003)(7696005)(4326008)(38350700002)(2616005)(6916009)(1076003)(44832011)(38100700002)(186003)(66556008)(66476007)(66946007)(16526019)(6486002)(6666004)(8936002)(52116002)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?d/Xx8Cnln9B4bt2zkovk8NWGGaLggaiyqB6rdOkDrb26zxe7Hi0FlAOdqgok?=
 =?us-ascii?Q?FCHNlPIhHndJQTPAu338fVEMOVJ1bk5BfHgg9kxm+q6OiQdXqvNkgh2YAhNS?=
 =?us-ascii?Q?6Ad7gdHiyTMnFU98zwgqhjDxLugUuj7KltlePMT80cxRUQJt45OXf9eGJzHO?=
 =?us-ascii?Q?Om3AaEco0hEE9ZfzkSA2V7tqCV+nEp2XMmCqW9Uq8Qg4QkpR1CqYIG+FfXEG?=
 =?us-ascii?Q?uxhx4DR3vFlsMFoziDiFM7h3WM8lx/TzyUM7Ij+e6vt9+sG7JzWY+bxyf9Kx?=
 =?us-ascii?Q?1wXSZ2TdVbOX1iCcMx7dRcZuWfKPxiSCMPiz4TVPRlgaZAGMKVF03NTUxMyf?=
 =?us-ascii?Q?xf4hBpd+9ALqytvkg1u86wTNbVCGxmgmEEr3eNNivZw7scXD9nk8MYqAuFVU?=
 =?us-ascii?Q?xiR5m/BoPw2BpDVytsZCkdsB7XRQuMTOsCT3SYQiTChj2/ScD+0Bd+qiSWpC?=
 =?us-ascii?Q?5ko1X/2ZL5UWX/xQBrQJoXXYRa/H1yAqd+ODaiOVXnnvZAaOnFo1wi1vVECX?=
 =?us-ascii?Q?rYR2zqFVG1lSydinvfh9XaHZLaM6CyCY0bUlIvt75KnTRreciUwlXn+os576?=
 =?us-ascii?Q?gssd/jqf+o7ZeJ1p5pdHeq0jMBKIsEPPMY0Q+QZcSqfVyKdH1xhg60gKw2h0?=
 =?us-ascii?Q?b7quyCjh9dCr8zz+9FJp2I9Lmm0ScEnNL+KA10YHL027sv4x5VEEEbuQNelF?=
 =?us-ascii?Q?1SHnGeZhVikWSwIVfswd2+su1mQc1CwkkBtm8uUJx+7bAuxmJa2Cnzj+GEee?=
 =?us-ascii?Q?vcPasFuTT1foY1zze6wHLkAcOWj1fAAw/CNeHzhZrFHf2/ook3XlGejgpjRm?=
 =?us-ascii?Q?Ob8TdAFgYc+JMuZqiFzXe2TtKMMpvk+5ToOWjBG3/r+w9USkziwGuExarEOK?=
 =?us-ascii?Q?n05IHpADGSoL0aEpQZcbNe2Om8vpjY6OJVBaLwahQsnbY0MjxxNoFWdeTaoo?=
 =?us-ascii?Q?AFaOEi9rISlYTInRMSPKK/CjkMPjYWb7XUGpy7xCWzm0ivcj45RdiI5WwGp4?=
 =?us-ascii?Q?TA99vQTG7jS67xyc+AGF4d78H78eHCfsJ7Mp2285RmD9uqE/yGczBv/Fi/EA?=
 =?us-ascii?Q?8WPsHeG6AS48uIk9aWBaVbrIuDNTiukRNGVuKQ4YvFd6Ep+Z+FkXsyQoDcDG?=
 =?us-ascii?Q?Cx1l4co2Ai/bKUf7i33QPBEDxXMt9eGPH4JSizeNANSaO7n3LN1bCWHyr/Ns?=
 =?us-ascii?Q?yG1/68STTHZmspj3V6b6i7nSPFAVJJOmvmdOb4VBbynmp+F156dSxgXTXzOf?=
 =?us-ascii?Q?0stqzHcEBSxHHTBz0ZjJye8uODwOEYcZMmOqDqw269xiSLQ9Oy6ShOlShLAf?=
 =?us-ascii?Q?kw5PoPrTcvwPZ6PxCuf7zUFoxc6ejmdmqf/kHpSr8zij7A=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcecdd2e-67c5-4ee4-faec-08d91693eab1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:51:20.5810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLC3e0A3GkOF12Q5MKHQgK/jv+zgTVzhB/5nngIQhZKi969AXM1ebeJQyyJ6i+Wl1D+OsNRmVAHXzKB9SocRag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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
Cc: Stylon Wang <stylon.wang@amd.com>, Zhan Liu <zhan.liu@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Nikola Cornij <Nikola.Cornij@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhan Liu <zhan.liu@amd.com>

[Why]
eDP version and DPCD revision are different. Per VESA
spec, "The DPCD revision for eDP v1.4 is 13h".

SUPPORTED_LINK_RATES is valid since eDP v1.4 (DPCD_REV_13).

[How]
Correct DPCD_REV for eDP v1.4.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
Reviewed-by: Nikola Cornij <Nikola.Cornij@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index e860d7cd4fc6..9e08410bfdfd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2595,7 +2595,11 @@ bool decide_edp_link_settings(struct dc_link *link, struct dc_link_settings *lin
 	struct dc_link_settings current_link_setting;
 	uint32_t link_bw;
 
-	if (link->dpcd_caps.dpcd_rev.raw < DPCD_REV_14 ||
+	/*
+	 * edp_supported_link_rates_count is only valid for eDP v1.4 or higher.
+	 * Per VESA eDP spec, "The DPCD revision for eDP v1.4 is 13h"
+	 */
+	if (link->dpcd_caps.dpcd_rev.raw < DPCD_REV_13 ||
 			link->dpcd_caps.edp_supported_link_rates_count == 0) {
 		*link_setting = link->verified_link_cap;
 		return true;
@@ -4018,7 +4022,11 @@ void detect_edp_sink_caps(struct dc_link *link)
 	link->dpcd_caps.edp_supported_link_rates_count = 0;
 	memset(supported_link_rates, 0, sizeof(supported_link_rates));
 
-	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_14 &&
+	/*
+	 * edp_supported_link_rates_count is only valid for eDP v1.4 or higher.
+	 * Per VESA eDP spec, "The DPCD revision for eDP v1.4 is 13h"
+	 */
+	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_13 &&
 			(link->dc->debug.optimize_edp_link_rate ||
 			link->reported_link_cap.link_rate == LINK_RATE_UNKNOWN)) {
 		// Read DPCD 00010h - 0001Fh 16 bytes at one shot
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
