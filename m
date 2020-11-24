Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFFCC2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 20:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F312067D
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 20:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oZiShHo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F312067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB9CA89F6B;
	Tue, 24 Nov 2020 20:08:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36D7089F6B
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 20:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxebkendSKXtyYFCDkXulXgqqfKcyi+/A/dQfiDIUjmY3Ocj9FJyDmoH/bSnYOb5slyiae0L9r5pUnErT8dfWGtjbtsF/4dKETHO8HLbOPr/XbPbc6eJTC4kBZ4AEQJ36+4Rt2isBmRNM9vQVY4HCS8C9uqkxcDuAcF63RLSF2tjEH3Zjhizfdu/s8lg7Xi+zwWeYdNDaK0RuPjbf2JvVC5Xcdc31eydemQd2JjlQumGpIVF5ZrgXCY9gENDtfS5FBQu8xJt4YiXvMPhWKEVl3TF9lg83IBYCNQwqnyY8V8Yw59wdHMKZbBX9e5hKcMtePOQKAB2s+d8Ane8zev1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQFIaxb/wBl0FdRpwLE5720JT4wOG1joJYfZd2tiliM=;
 b=ERoOltdnBwfC4LRS38odeUgQ0qi3ku7v5/pPZe4zzLxEH1XTu4v44SvNJPGwgqJcoRjf3ONktj1VlzVY2j9vWZPYiTTsbnDMMVPoLadRIumC+C+88YKzUYVPPnNQ772cO+d30dpq4NsCZ0NLIUpsM6FGpfBzDk/S0IqKmeOpNVeApzNREYX4GvaiZvqOsqM3K+6QfPVzQZeYBX8/NL9v+gj79WDFU12wORhOa7Iz3inX727W+oD2Aw1PSgm/Y1WYehmClt7KzBR1Oa+GBfkYq5/btAp1d2grEa4zo+AFouVM94EsazyW8NRIfvABn1ZcrzPzd3xDjbJNj4M6WGkQcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQFIaxb/wBl0FdRpwLE5720JT4wOG1joJYfZd2tiliM=;
 b=oZiShHo9I7sniJlYjsm8f5WVn2uZNDM3qeHoc6MJBS22V1V01nDDWSAIZHEnFsSQQLA5EOVqd6TK2IRTQ6LnKe28RxKcivaB6n6qp/YsOYGyBYJSDaYe+PHPYz7YxfweMjBfkyuQ6TTthuR89Yx1T8OCXVNXDB6Qd5VXwRi479M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4524.namprd12.prod.outlook.com (2603:10b6:303:2d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.24; Tue, 24 Nov
 2020 20:08:52 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::95e:3860:8b43:1a35]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::95e:3860:8b43:1a35%5]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 20:08:52 +0000
Subject: Re: [PATCH] drm/amd/display: Extends Tune min clk for MPO for RV
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 nicholas.kazlauskas@amd.com, hersenxs.wu@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20201124155508.2096060-1-Pratik.Vishwakarma@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <393ee532-7690-ce76-4b36-75a65656173b@amd.com>
Date: Tue, 24 Nov 2020 15:08:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <20201124155508.2096060-1-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR11CA0058.namprd11.prod.outlook.com
 (2603:10b6:404:f7::20) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.2.138] (165.204.84.11) by
 BN6PR11CA0058.namprd11.prod.outlook.com (2603:10b6:404:f7::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Tue, 24 Nov 2020 20:08:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d29ae148-2a93-46dc-62c0-08d890b4c380
X-MS-TrafficTypeDiagnostic: MW3PR12MB4524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4524106C434272BD15F125848CFB0@MW3PR12MB4524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1JYeSY2txDoouH1rMXjEBHsv61RqABKuyH1AQ5sXhHt6PlrHkoXXKLf68HC7rmIBGcEtqbcY46nPsRcdBEe22pmJZ+IHm7Y+cReAojLou5Df7dSggWW6EeS0GE17KEnn3veGQf5mbqW0+5yVJt08qEEhGwnDPoY+qjdbnWtZGqYtAwgAoVd8PLBVBo76gvQO0tN6YqSVB5jpOMNJXixOmiW+42X5UUq8ooTNibHQ0TsOPPRu+Ix5Z9qAaQzpr3MPhB7iUaf9xUD5p2ITDekHREJGfwo/kifCSvn5aV1ssPOZhhpfT7sPGmPYcy0/Bn9dS7SbASSrSd7pDhqazK2cwTId82k5ieVHaKt/ZOLCTq5uCrXGIUgO3MNN1sjB7N69
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(52116002)(66946007)(66476007)(83380400001)(31686004)(8676002)(4001150100001)(2906002)(8936002)(16526019)(36756003)(6486002)(31696002)(44832011)(66556008)(16576012)(316002)(6666004)(478600001)(53546011)(26005)(2616005)(86362001)(956004)(5660300002)(186003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Wyi1I4hk8JWH93R8xlV+at8Zc+weWSjy5UmDY2et+RembgpkCri2ALWDnC30dyfizdE+qOXNGaZh+phf7P7YfEZzUKK0DP/J43e2yupe9RU4i0a+sBAqlwnDRnOgpQfT0BRQRhUToNSQkXPwz5B8A8b5ZUSoU2zVvsOA9OIy4eqXPTF9c6qJDeNmes7iNIePwF8K18B47foSQN74y0mIvdt2WSHp1Xu3GrtGmvz5JC+iypIKsCAC/fF9a9IrLBNoq/W49sOExxKbzfrEfWF8KHUAgqbNYqgNZL5qnoHs5I1KcooDg3EBxNx5003sVdDsp3l2Libkx/kPTWpy3z+kXo4W2b1FxAiAgbN4sxb44uG0trpwH9zLzoNdA8sKyNhhM7N5i1f4X3fDQX1L6E7hhpW9rZgv6b8uSbv0s662qZjmcK2Rg2/Tfv3c5k5Fq8MuMwYu9sTOfvC4N6J8aUX1YG/PA/aF7vMIdtSLD0Kg1kWc1/VNPfVhQpIgO/FecxxLBj1gEvI8OmaUpH+QJEDHUC7m/Iosi4LgTIrLh7cGqGIGJDIB3E/aWu9EgpT0+7JjGD3LWSE1KUFoPpN8giLHvHGCTWm/nIJ9l6fs984Qms6dMzZl3UBy3dGBvqwPG88eLB8B3HhBc6R9/+oeKd+Y7uoJet5LPbPfMC2FyYVOTRmjYZAsBHOn1O4dN4oIc3V1d1WasKBC7+IjR0WO7tJAQ23hBJvwiC/s++PRB29sIheqob3fKr1Ko4iDfb5tNWcvqg0JxrtpUejAIhdrLFE6LPYcfslLEWyOSDeUbd5lbaCYrQyyXvNWTJ2I0eaaDd2hQ4kHgGeQkrcGtVaYMspb02/6mx31mhr3SZ356zxmQQ2tNtuyQ4LpcIAFwSASI2doIF8dvDFRIutl0mfnoIQrbg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d29ae148-2a93-46dc-62c0-08d890b4c380
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 20:08:52.3609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPIru24oajWyOpa5IbMqExSSXl0exF5vunwSICOSsTr/uoIldIcsgAptW85vzcLT8H3PCJEVGggE6yLWkPyaOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4524
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

On 2020-11-24 10:55 a.m., Pratik Vishwakarma wrote:
> [Why]
> Changes in video resolution during playback cause
> dispclk to ramp higher but sets incompatile fclk
> and dcfclk values for MPO.
> 
> [How]
> Check for MPO and set proper min clk values
> for this case also. This was missed during previous
> patch.
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> ---
>   .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
> index 75b8240ed059..ed087a9e73bb 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
> @@ -275,9 +275,22 @@ static void rv1_update_clocks(struct clk_mgr *clk_mgr_base,
>   		if (pp_smu->set_hard_min_fclk_by_freq &&
>   				pp_smu->set_hard_min_dcfclk_by_freq &&
>   				pp_smu->set_min_deep_sleep_dcfclk) {
> -			pp_smu->set_hard_min_fclk_by_freq(&pp_smu->pp_smu, new_clocks->fclk_khz / 1000);
> -			pp_smu->set_hard_min_dcfclk_by_freq(&pp_smu->pp_smu, new_clocks->dcfclk_khz / 1000);
> -			pp_smu->set_min_deep_sleep_dcfclk(&pp_smu->pp_smu, (new_clocks->dcfclk_deep_sleep_khz + 999) / 1000);
> +			// Only increase clocks when display is active and MPO is enabled

Why do we want to only do this when MPO is enabled?

Harry

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
>   
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
