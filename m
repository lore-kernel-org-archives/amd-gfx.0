Return-Path: <SRS0=FRS3=EE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9279C4363A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2020 13:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2412A20759
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2020 13:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XO2k4Y6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2412A20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8849E6ECC4;
	Thu, 29 Oct 2020 13:33:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CDFD6ECC4
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2020 13:33:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enqgZ0kDKfX7AEuZayCVvzU+coxwVT48jYbbCq/+SbRJ3GtMdvN/8pMI1TTVxhEvBtSddI7Oe9jQ9f/9SLpYAeSDT0O3h0BA4gC2xoR/zKz+A1q9XfJEJo2IythnpXcIITgzNTqMem38bcUBuihQrB+qBWFM92NFTIiuT6hQb+SBQa2QEvimxw+APnYgkY71LKCqekFJJOFInHVyOveqhIV4bWjQ3dGqxlA88Cltn38qELmeVJuLj6JBTj/L9jeDglUZAiaZvr952ZGk9rHBgi6sSLBN9qB5mXuO0W8+Ed97yPJ/jyhBnsWk9vSFGQFbg67CsFA8CLrY6t8lSzq+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+POIGwi17sUVU9Fr72/S41+v7rXsYPDmzGKKHOXDGI=;
 b=GGlTpqNFKFDSNK0qeBaQk0tkhMXa5yQmDNzfCy0xNVwsHosCv9HBlDPtn41kbSi3gxtdFrQDa5fOo+Ml1JJfzEc2SaCrqm9GbtOENWzUR+ya5qjXyYSfKaxKPlWpqlYPK84B0i8r16ziwKmTaMbXquE9nOY5fAcWPan5/1VNY4Bmgg0XCYiwvf9e2PMxA2LgXRVBY4hPAQe/Zf3+rBdzQs8TjYWPEIY01zaEPIylblwX7RxoFhXLWpkY1XYNAUatJoaxq+IavqHnF/lH5w9yUbe6KuuYlTqxch4SpKB8paV08YMQwRQYJS29J0M+oOwotEnUwIPLKDz71nge6EZshA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+POIGwi17sUVU9Fr72/S41+v7rXsYPDmzGKKHOXDGI=;
 b=XO2k4Y6HwDFwz31TMxU21xoOfZWKjBFHJow/NVvse6YI2kfcdAT4ar53letnr2mgRnyl8Q6z8Ma0p2QekwsRDfLxhAxQiUCvWP2ublE9jYl12IqglAkHXIRS9Auwe/WJEbqc2BlbLeGPjklbTQb8pb0urViknMzXLInoFa+0ytk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 29 Oct
 2020 13:33:40 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999%7]) with mapi id 15.20.3477.029; Thu, 29 Oct 2020
 13:33:40 +0000
Subject: Re: [PATCH] drm/amd/display: Tune min clk values for MPO for RV
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>, hersenxs.wu@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20201029043105.144595-1-Pratik.Vishwakarma@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <9a949fed-9172-0b18-17b3-a1161c55189b@amd.com>
Date: Thu, 29 Oct 2020 09:33:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201029043105.144595-1-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Thu, 29 Oct 2020 13:33:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ca74fda4-ac0f-4b8f-3278-08d87c0f3f7b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4292:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB429205548B8B7F713C19D351EC140@BY5PR12MB4292.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: huYODEQ1QAM+vvPj4iSVNuIzLP2hRyyAVZYhmmb+Qd8Y0d7CIqXYhRah5QJf48Maf4ExbjjITX0kMmZsftmbHXSCT3ZZQG3mciEal7sSgkUf7nG3rnqVHyptj4a9+5tqxw3DeIXallfCFtlnSQA37AuGd0c/Iv6mjjf0CtQ6S09DWHY/zgbcX8CJ/HeV5xlCwyG1zDu36NuBzr4UV4u60xozRhRlUQB5ZFmZ6uYaoK69c8/USCFvaTathdNgosBAg5HqDQpdjYibxPdVyrOHtcAQ/rgJydAiSNhlmu6F4gz24qNb/03ieaqHlivb8ajY15pajThaB6FrkfGifp2HPFqqlzNHBWI3Gy4NX+oceyxXop8rKRHED9i7P7EFBkW4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(26005)(8936002)(6486002)(83380400001)(86362001)(16576012)(5660300002)(2906002)(8676002)(478600001)(956004)(2616005)(31686004)(316002)(53546011)(66946007)(66476007)(6666004)(36756003)(52116002)(16526019)(31696002)(4001150100001)(186003)(66556008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: dkl1Esq1s9+p6Nt1P+OgIAJ6f2gyxGiL8SatHkPP+V6hwSp50/gx4kcy/4uW5NhkKg/xUtKElnni8AEiEM+MUyBzZLmVypApq6dSy0SzApAE35K8BK1YNwIAQ49yFhrTSNfmTxHrNi+oKnTKa3lQqE1f7f+55HQ1syT03/J6SWA0ISCPrX4zdmklJgif7GbeuzUmpTENf9spjMY+boTd6eOt7jaNYlhHwElXph8RX+tnVLeLceosRRlJYba7l/czMuk+78o+IAgFYiQqA+ynInV/46A9NojBlGVUK2GgTKmTsHvFoNQQMasx7qYqD6OOLU1lKsYhMNy/hru35TJ2NAy6Tw64lFejMHYWUFMiK0hO4NSV1owJlLurQruyqmJDggkABDXrbkMu+p880uyhyeEm//W9C63AZ4FeUzoj2FO2YfiHFHwCeVDbSO0EcQoqB135ThfBQgKIQ1DxvOJZddaz+SjZBPDx04edADJTKkPiXadF7iuB5SeRgTuJMiFV00KcDpeBc/FAO1Nok19pykxPn7O8RICcwL3AYMNyZ5ZXav17WMRpvJ+jlJP2Hg1NFjbpIGoikL81R5rSS4UInJSqNS2a3bX/hTiUbdjuRs/y/AxzUoXOqW2Q9TjHMG7pM0GZBMeovbzXF1hJ4f1pzw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca74fda4-ac0f-4b8f-3278-08d87c0f3f7b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 13:33:40.7805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X999doAct0doX1+XGgotL7JBYoEOdBsP3pPsnoJm6YU1FK31LJaUFems40EhGxJuj5QbrfpK9aHlTqrsRvWixw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-10-29 12:31 a.m., Pratik Vishwakarma wrote:
> [Why]
> Incorrect values were resulting in flash lines
> when MPO was enabled and system was left idle.
> 
> [How]
> Increase min clk values only when MPO is enabled
> and display is active to not affect S3 power.
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Fine for now, but I'd like to understand what DCFCLK state we're in 
after this change.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    | 35 +++++++++++++++++--
>   1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
> index e133edc587d3..c388a003956b 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
> @@ -187,6 +187,22 @@ static void ramp_up_dispclk_with_dpp(
>   	clk_mgr->base.clks.max_supported_dppclk_khz = new_clocks->max_supported_dppclk_khz;
>   }
>   
> +static bool is_mpo_enabled(struct dc_state *context)
> +{
> +	int i;
> +
> +	for (i = 0; i < context->stream_count; i++) {
> +		if (context->stream_status[i].plane_count > 1) {
> +		/*
> +		 * No need to check for all streams as MPO
> +		 * can be enabled on single stream only for RV.
> +		 */

Nitpick: We can return early here regardless since DCFCLK isn't per pipe.

> +			return true;
> +		}
> +	}
> +	return false;
> +}
> +
>   static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
>   			struct dc_state *context,
>   			bool safe_to_lower)
> @@ -284,9 +300,22 @@ static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
>   		if (pp_smu->set_hard_min_fclk_by_freq &&
>   				pp_smu->set_hard_min_dcfclk_by_freq &&
>   				pp_smu->set_min_deep_sleep_dcfclk) {
> -			pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu, new_clocks->fclk_khz / 1000);
> -			pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu, new_clocks->dcfclk_khz / 1000);
> -			pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu, (new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
> +			// Only increase clocks when display is active and MPO is enabled
> +			if (display_count && is_mpo_enabled(context)) {
> +				pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu,
> +						((new_clocks->fclk_khz / 1000) *  101) / 100);
> +				pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu,
> +						((new_clocks->dcfclk_khz / 1000) * 101) / 100);
> +				pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu,
> +						(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
> +			} else {
> +				pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu,
> +						new_clocks->fclk_khz / 1000);
> +				pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu,
> +						new_clocks->dcfclk_khz / 1000);
> +				pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu,
> +						(new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
> +			}
>   		}
>   	}
>   }
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
