Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2C2C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 09:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03667236F9
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 09:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03667236F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C366E0ED;
	Fri, 22 Jan 2021 09:04:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A8A6E9A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 09:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5WjIWBl62F8wOJfYieiyO6UZD1HiJ53apLKSvjESMsWPcIkeU5a+C5451HKKTDbe89WFcD8n4fhiW0Wdcya3pjaqgsGt3GMYZ/fdBwAracB0Bg0pDnCeqQsa8PJDg2kur/rJpPvTSZsYOWQ4YNh83K8MrWLHSHeYyWtWauHmLdGagdZkHmVJ4F/+Rb0t9WOJ5WTRGd+SWLuq4at3XPjKWq4gvm7w6xQQGUNjmi77dc9GJ4nj+lnXkjcxfkMH9eOyDbNaXNgP28ukZxuMYNqkZFTfCdruTDA6GOyR6QmOs1amMhbnPC+kMxyVoeul5qpoY7cHNnJ1H39Y9oIyDWg0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHIGOhI/EYGRXDgJrWrqeR/xAr9IwzgCgGiRiEyOkY4=;
 b=LkZ3AX/6LFljBuV9dTw1TWcPWmdw7klCZ7f0D6rtFSWX5RqTBCOCp9mHxw8/2O7YISAYh/hBf1k0cIYV39CDd6I0BpoLmdXxrM/aYom36Bf4XEywnW7cgh6xNRynx8Z1IihBoKKpSONCp9Owlw/qX9EbFffqp1ZB6AsLRGlC3TrfegK6vaiTnCeExHTwwEsTnVNwJax9SxqOLLzRn7oBtunESS7HxDqgQJHtYnuCX2qvpxTKA+nqnRz3QCs20WNDCRCYgtrgd4wJ9j8/n3samIwRvxtzdFVsEll+lzo56dCCScSr/QiZI6JbS6gidCixhIcVtTQD/xwMP++GyFf9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHIGOhI/EYGRXDgJrWrqeR/xAr9IwzgCgGiRiEyOkY4=;
 b=415+z5ZxORTB+CuKuU3hF8+/BX/pUx61h8/X7qDFOe3eSGoiqN1BM/1+zJkgRX3xFDfEspQOcRJEzIY2stJbbPabJ4V/CYJ8QKZRxNcpYP+s27bEdfhkjX20LJbJdZ/GXcgj0lFQxZIEcx35zwa5aV4F+RrFxd0FaF3sNHsWGXU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 22 Jan
 2021 09:04:01 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3763.017; Fri, 22 Jan 2021
 09:04:00 +0000
Date: Fri, 22 Jan 2021 17:03:53 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>
Subject: Re: [PATCH] drm/amd/display: 64-bit division on 32-bit arch issue
Message-ID: <20210122090353.GB735357@hr-amd>
References: <20210122090059.851508-1-Lang.Yu@amd.com>
Content-Disposition: inline
In-Reply-To: <20210122090059.851508-1-Lang.Yu@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HKAPR04CA0013.apcprd04.prod.outlook.com (2603:1096:203:d0::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 09:03:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 706a5571-6fbd-4db3-adc6-08d8beb4a8a2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1248:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB12484B8C5878F7ECC8C9FDDBECA00@MWHPR12MB1248.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s0ZqmqDolTIt11TTv9e6xI/5gtDS2K98YE1Zm2+vT3v8MWLT+BKNIPQfEoUw2cBy5daT/t9cGF9Du5Q9doZEx+jhi1/AxbCG7DT57sOV9wJpsL3l3chbtDD/Gs4hjvSDdXkPugbjv2yoN6gGlWj153XxgInula9YkfYqX7FISbvX+Z1si/RvE0HakCY/CzPib2Ab0WjoFCuqllVf9t5aTxrzMd1LI5yPdqU6eAxF9/qIJmJVKPy99kuqPSuSwenFNFwcH95wOk8Q4Eoy0fC4tvAoZDfJwrRojZhzI5yLYDPL23qAI64LhBNIUpFqQulT9SZ+VViDwVZAuR2KBV08VkfkSdVPUZJt5fOwzTbghJm5pysmIOVuhLJdH8AkbYzVfzxiCHdI7gKCl2O073NU2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(4326008)(2906002)(5660300002)(83380400001)(478600001)(8936002)(55016002)(16526019)(186003)(52116002)(8676002)(6862004)(66556008)(66946007)(66476007)(86362001)(33716001)(316002)(54906003)(26005)(956004)(33656002)(9686003)(6666004)(6496006)(1076003)(6636002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ATmHF+ETZOcQhl+dkSb+uNeHbwwNgAkMGYJy/s2l4tU7+jxRa6VvPJ4M0y2U?=
 =?us-ascii?Q?5ylA80vapeySv7CrcQKxAwtKZi9ZHv38AFVJPuEKdjq2fkDNf8WQyTpjou6J?=
 =?us-ascii?Q?0eISM1uflsYIG+3YpfORfGF+CLRaA85Qkrv1ESZS6ibPEIhmCxNdEKknd9fo?=
 =?us-ascii?Q?Z6UrZDvQSebf+G5Mflb5FD1Yi68UDI7zsOHBcYb9oxNzs9OMsFBm0ijFM7kO?=
 =?us-ascii?Q?SrnEn7Fnv+ZNIgM+QBHeCIfCKks7wjXYJMmBuSWT0QNtMz+BIYmpZwznyIVs?=
 =?us-ascii?Q?mqRkr6Z2rLjSP4jfGPhD5WrezpEu6QTCF3eq8IWT6UGOWZVy9pGtVgyrPhkx?=
 =?us-ascii?Q?VVGAqRPc9JOOjq3WCL/T19yYCOfNZpZ1JtvqFOgdusZfqZ+9mVeyh5/pTECg?=
 =?us-ascii?Q?hdcxtg+o/Frdcu/ERPqpP6BiERc26sWhIxmulRZICt3i4J8TVKs9F1dAw+P+?=
 =?us-ascii?Q?HpnLd7ixj5E83cbF4Uzwj3sxw1mmPTZ6Zzy0xfsqTGcnsgS/n8n7sVwBLBLN?=
 =?us-ascii?Q?9malh2v//Akg7vawFGgiOnn5pNkLTGSzeaJ93+Z+a/pcaYjb/Ch3RDFhl4QG?=
 =?us-ascii?Q?vAdRc0uBRoyKaU5XKMaz2wf7H1TXivhyRhJR/yeOibcTbP9U7jYX3f/SVSw4?=
 =?us-ascii?Q?NfLcUIyGE8Lc+OyyeqRzx7XmsA+2XiBNBxd5fy2EIrVRJDxuXC3hIWDkEJLy?=
 =?us-ascii?Q?hcX8u4mqZFFqyFLBteXi730FBnoDC8o1/gCIRy276rlwr9hbg70ubo3vcTWp?=
 =?us-ascii?Q?8Ah82hi25/inBEbgtuuxnS7CcTn0CKGwUjcEnIhh67i1zYTF+ZHdwXv+CdUD?=
 =?us-ascii?Q?xNKwVK0ZWqdwC0xCbVP+VEFmxM1ZRnNfEvu5vyXPKiKT04J5sEmT6/pPZWkC?=
 =?us-ascii?Q?E1zREr7nvGJbp7e3HM7KA009/HnXY6eg6fqeX4iVlSc0sFBgaXc2wVLT/97H?=
 =?us-ascii?Q?cRht2B3+YoUnUupfkVxjWAQSYvhrV1x5cwCbgNOADY8GOWErXtXVEY8zIVJz?=
 =?us-ascii?Q?ukjGY8UWJ5kYBDZzYz+meNZzF2yglTnLFDAJ5zjm10J8zmHDqPS0M1e7uaOB?=
 =?us-ascii?Q?poPjfUGUY9W2Hv9mcCoKnJPJau5D4Q=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706a5571-6fbd-4db3-adc6-08d8beb4a8a2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 09:04:00.7238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SM8A5BUklPFkXhlmP2jD3Jjdzw1i0J6He3ERO2f+uAwZw1JZpfUyIAql0nJZqUiWgDRwB+qFfbDX4Efz2IM2LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1248
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 22, 2021 at 05:00:59PM +0800, Yu, Lang wrote:
> Replace "/" with div_u64 for 32-bit arch. On 32-bit arch,
> the use of "/" for 64-bit division will cause build error,
> i.e. "__udivdi3/__divdi3 undefined!".
> 
> Fixes: 27755cdf83f1
> drm/amd/display: Update dcn30_apply_idle_power_optimizations() code
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> index dff83c6a142a..9620fb8a27dc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> @@ -772,8 +772,8 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
>  							cursor_cache_enable ? &cursor_attr : NULL)) {
>  				unsigned int v_total = stream->adjust.v_total_max ?
>  						stream->adjust.v_total_max : stream->timing.v_total;
> -				unsigned int refresh_hz = (unsigned long long) stream->timing.pix_clk_100hz *
> -						100LL /	(v_total * stream->timing.h_total);
> +				unsigned int refresh_hz = div_u64((unsigned long long) stream->timing.pix_clk_100hz *
> +						100LL, (v_total * stream->timing.h_total));
>  
>  				/*
>  				 * one frame time in microsec:
> @@ -800,8 +800,8 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
>  				unsigned int denom = refresh_hz * 6528;
>  				unsigned int stutter_period = dc->current_state->perf_params.stutter_period_us;
>  
> -				tmr_delay = (((1000000LL + 2 * stutter_period * refresh_hz) *
> -						(100LL + dc->debug.mall_additional_timer_percent) + denom - 1) /
> +				tmr_delay = div_u64(((1000000LL + 2 * stutter_period * refresh_hz) *
> +						(100LL + dc->debug.mall_additional_timer_percent) + denom - 1),
>  						denom) - 64LL;
>  
>  				/* scale should be increased until it fits into 6 bits */
> @@ -815,8 +815,8 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
>  					}
>  
>  					denom *= 2;
> -					tmr_delay = (((1000000LL + 2 * stutter_period * refresh_hz) *
> -							(100LL + dc->debug.mall_additional_timer_percent) + denom - 1) /
> +					tmr_delay = div_u64(((1000000LL + 2 * stutter_period * refresh_hz) *
> +							(100LL + dc->debug.mall_additional_timer_percent) + denom - 1),
>  							denom) - 64LL;
>  				}
>  
> -- 
> 2.25.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
