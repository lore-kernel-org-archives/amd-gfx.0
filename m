Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B8FCE79DE
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 15:00:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FFEE10E4F6;
	Wed, 20 Sep 2023 15:00:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 905FF10E4F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 15:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIppRgJSY2HkiSj86H2TzTNFnLztg//ilgLGSFgw6se8h3PyjWRzLz1H5JzLFPWOkLGJmsCKtwwkB6e9jN7thhV3rxQpk40FdhsRgeCHx7TQaPXQrXFgEU/e99cUrDBdI3TtEZdcTAIhb3SMjIGhM6UucC3JxiRqh67w37y7FrFmVGl/gMkUKini5j3Bu0mPLOTt9D647+/wo6Ubth66SAfxP9LlthPXb0J7XoPNOuyJHWN2/tDKTL2opbScaje68CK8/LIJmJH9aY2iRR2gMKFWe86+3nDP3ZwLVRCQPg4wzYLk/dMi+/Df09WXx4TDxIgWMCWUo93kk/qdXcfO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1QVvzQqAK7IcMtVTv57hmFK/77tWRSlVf0/0uNSdPg=;
 b=jWOF+ckR10tx0TfljgbQIAitJvClV0WZfTeSC363Gy5TRG90EkdPQ8D6PglgeYIVazuCpPOKdyP3fZ+2StVbzBqU4gRnkCNSfFNcQsr6akMz5JzF0rQeqXscHBqvxwmxcMt0jXAtT2fNhvuyRekT5SX5UmgB12m50UZ7RerjrS4Tt2PUTzAajcaNtCKV4vZjmCl/nP9bQhGdCt1Fc5SoZaOuWHa7telhES1kldoGqYWB6aSA9dbZlsaAq0zE21HZXYIQNKff8Sz7Wis3qY8zsVNFfLMOp4gQGhC3ADAOj0/0ynpeC+m6Pg1DS48ZVGU69h0U65IuF1Yk0XKTeI6Jhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1QVvzQqAK7IcMtVTv57hmFK/77tWRSlVf0/0uNSdPg=;
 b=A0hrd12/5X49nrgaQe1jCUbclfGWTdKonpWXmUKuN8HWQsxvHYxbrfI9cc5FSOjlMwv8VMA9ZqsGQ+uej7SLe7ydYaATYeUZDrXqfpAMPMPwZfYjEONOCsjYseGBquVW5AFNPK2iU4SXYbJzFzjK3TFUpFriBspZiYtuaVozZ/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 14:59:59 +0000
Received: from MN0PR12MB6270.namprd12.prod.outlook.com
 ([fe80::b1f1:3a4:ac0c:1e38]) by MN0PR12MB6270.namprd12.prod.outlook.com
 ([fe80::b1f1:3a4:ac0c:1e38%4]) with mapi id 15.20.6792.024; Wed, 20 Sep 2023
 14:59:59 +0000
Message-ID: <63a3cdeb-447e-4cc6-9606-a0d02638b831@amd.com>
Date: Wed, 20 Sep 2023 10:59:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix some style issues
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230920134109.2641560-1-alexander.deucher@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230920134109.2641560-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::18) To MN0PR12MB6270.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6270:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: 393b6a2f-aa15-4c34-78a1-08dbb9ea4267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PAQ0IR7B82+VIv44WZ0J8ueIVZy1xpT9K01lWVyj30wPB3G7WMlbml8ra4Vx82lBbqeGgcuVRGCq7zwYVTl2taUPEqxm35DidVAN9XwquikFhcz9JDCG5VzodbR6NFyC2wWJj3/D1+7A6JgHGqvzjv4RLp3MORyksdcqrQmHZ4DR8gwHuTi4I5vpPaR7pdBqfq6c78VFiP2sNbzN4gHzkYgb8/vsb+sNXJwex6cVIiosMwlYcP60fcJnheIapzJHnU+eTemxDs26xc27Rxw1G15ziA46X1jBhXfy7SVc9IUXs4+Wa7IFtYminBcq5knbh+WPfZesYjvRyAs7BoQiCAf7JvjTVqkG9fJ44N87OI2/sAhQG2ZwSNmO2VMWU97Owg7MdYkKAQFH1C56zSsZx1F2OrpUJ858kcaKaGWuy5aUNYSI/XiG/lhhCbX/tbEgASWUN1vPWLz4ff4co8GzlHuujnylOMUr1R382TBvGGMxrvH+2i60QXEH4UcCwIpQv32OQoNdDq2CWCDOfnDkzA0tHlAsshYpu+F9lwYOG90vT2RAXLL+f8ifXTisEX60WK24iL//UAWMsSDdpmYlbGjr0N8w/Nfgz5wPeUxRWQuJR6TGTQehES6MvnA2SQMXWfLSbqEJBxda1ZiiyDFPIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6270.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(186009)(451199024)(1800799009)(2906002)(44832011)(5660300002)(4326008)(8676002)(31686004)(8936002)(41300700001)(316002)(54906003)(26005)(66946007)(66556008)(66476007)(478600001)(6512007)(6506007)(6486002)(83380400001)(2616005)(36756003)(6666004)(31696002)(86362001)(38100700002)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG8wdkQ4TURCcVRkMDBXeG1FeitHMW5OU1FvTUo2dStMLzd0VjFudG1Xc3Q5?=
 =?utf-8?B?Ui9MV1dlKzAyQmtnUVJrSFhjYmhoNWNuczBvY2d4cURVNHdmd1Jud2Mza3Y4?=
 =?utf-8?B?YmZGbzBscU5wZEJUeC9PY016bXVmVWpWRkhRRitReHRrdXpCcDUrbE9ZbkNT?=
 =?utf-8?B?MmFuNzArYzE5VUQxUzcvaXhtWDhVcWlSVHFnT1Nvbkh6U1N0eGE1UDdPRkU4?=
 =?utf-8?B?Vm9mZnVueEk5WS9rL212Wld0ZXdGSVNSWDN3dGhKU0ZNbWQwNm9USzVlcGdk?=
 =?utf-8?B?RGpLVlJBV2JrSUQrTDFYbktaeG1aWXFyeG1MaDEvN0dWd1lqR1RJa1NMbGIw?=
 =?utf-8?B?dTE0OU9oUVVBTUhuYndFTms0bm5XSmdJVXkrdDNPaVM5QnF2V1ZuczFnUUJ0?=
 =?utf-8?B?dzBHUVErYkxzSm1FOEpocjh4cmdlTFNSS2FER2U5UEdraUhaQnQ3b21UWHQ4?=
 =?utf-8?B?MDVGRDZVYmR3QzhURllTL2ZvZHBsRGx5YjJDeEJmeHVwOTJ3cmZXdmxhZlUy?=
 =?utf-8?B?VDFxVTBCc3RWWHltbVl5N09jQUZONXdySldFbVhvc3J4ZlZ2ZDgzVlhzQUFZ?=
 =?utf-8?B?TXBZS3Z6Mm5ZSy9ZMmJja0J4c3VvazF5Tlp1TTBSVVRUcS94Uko1RWR4YWNs?=
 =?utf-8?B?YnZuS0VFaGFiYmRtMXpxVmV0UmszbHNTKy9nckNxVkRmZnBZdTVFNkdJRDBF?=
 =?utf-8?B?cVRmdE15T0RCQ01saXBZYXVSclpsSUVsbHU1U3ZOZlk0SjY1RzNxRTArZEVt?=
 =?utf-8?B?OGo2UkcwMklXbmRkUVI0ZFpLVjUvM2J0akV2Q2MvcGdGVEFELzVmQTRRN0JM?=
 =?utf-8?B?QVJFOWowdFdyWjF1cFBjWW5NdXdRSUlYNnBEZXp6UnExeGw1aEVFNTJCaGMv?=
 =?utf-8?B?bzFid3NCb1pIMUpBS3F5a0JBendZUkN1VlFwOHNtaG1rOWJqYTdpcmdEdEJr?=
 =?utf-8?B?MjNXU2pMcVhNa2wxeFluVlYrK015YUhFeG92NXlON1RnQzcrVWJ5VVhkQTVY?=
 =?utf-8?B?VDdZSGJ0dkhReW41SVNPb0JzQy9ZMGJiamxZcnphZURHaU1iVU5ZaDZMOUZ2?=
 =?utf-8?B?T0V5TjlUYmovK1JDdTVpc2dBR0t6RzlOK0IzdnVmUGtPbnM4ZVBRd1VjYkl1?=
 =?utf-8?B?ckExaU85T1dpcXJMR0o0STdHQnBnUGt5cjdCdkhHdTAzWTA4UEZRbm9ia0ov?=
 =?utf-8?B?OXFKaGh0RTFWLzBlR3dYVGEyMHNhaUJhNXh2SFlxVUF2MTM0RDNlZ3dBTGR6?=
 =?utf-8?B?VlY2NWhCVTQ3UkpSYkJLTUdYc0VtWVVkTDhyV25kK2VHeTRmclBhNXU0R1Vz?=
 =?utf-8?B?algrZTk1ZU9hSHhCMmdycjc4TXBjbG5QdU9DSmJhbXVwWHhnd0RHUmZhK2lG?=
 =?utf-8?B?Y0Z3R0JqRzdsd0VOKzUrTVBrTEg2ZmF0WnhKZWZTc2dMQ043NWdrdTF5SUV3?=
 =?utf-8?B?bUpkK2VJbmpqdVNBdVZXWi9OcGxUZTVsbC82aDR3bEpIYVRWanNrYUFlcFZy?=
 =?utf-8?B?UDl4aVRKSENPdWo5UTE0UWpsbnZsZFl1azJSNTJ0c3B6czBxQlcyQlRSVFVl?=
 =?utf-8?B?eHptdWx3Z0wrYk82aXlnNVprRGVidCtnVTZsUUZQU0tYSjgxeFVvdnRpbEhq?=
 =?utf-8?B?S01mU25XSGxCb2VlUHZkZEMxcDdja251Qng0N2R0S3BtbHZwR2hCY3J1NXJZ?=
 =?utf-8?B?emkvQ20vTGtxOUxOck1WbXVzUGhSYWNhWE9INEo3SkcrYzZVRGM3Z3YvVEZV?=
 =?utf-8?B?TC95UVhmMjMrSnRTNFpZMXpWWGxtVWVaNGpIdWVrVmJJSFBMeEd0Um8zL3Vl?=
 =?utf-8?B?UmI3bUxKVS90b2RwTzExZkNQbzN6cjBFMU1oL28vQlZUS2RGYXdTamdsK2hS?=
 =?utf-8?B?MmFhVjN4R20rVU5kWkhsNmNBL3p0WGNZVXZmV2pKanJZeGVHM0RsY091N2lz?=
 =?utf-8?B?RUZhSDVGVEk0WXk3VUxFd01DekpzbDhSY3lRWEsvVDhnTHFEdG5QaC9tNW4z?=
 =?utf-8?B?alFlOTNsZU5leFEvNENVWmR4WUE1dzJxQWp2ekc1dFJzc0RGK1lwTXNsWTlp?=
 =?utf-8?B?ZjI1dE96ajJBMVNEeU9WT0pvQXNBbEtnYTFUMDRyYVpyV1JhbHhuVWQ4RDdS?=
 =?utf-8?Q?fYBw7CEzyQQg9KOOHcn9Vqxs+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 393b6a2f-aa15-4c34-78a1-08dbb9ea4267
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6270.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 14:59:59.2555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/dpQ/EV1lPF9ib/X0YwOIbg+dTWEG9j2YAHWH80hQhb6dCj6GdTzeTOvtnbYJGUi1nBp4L58oAbwacc7mvqxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934
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
Cc: Stylon Wang <stylon.wang@amd.com>, Muhammad Ahmed <ahmed.ahmed@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 9/20/23 09:41, Alex Deucher wrote:
> Fixes a few style issues:
> - Only calculate the dto_params and dp_hpo_inst when dccg is present.
> - Fix indentation
> - Drop empty else block
> 
> Fixes: 7f7925e25828 ("drm/amd/display: Fix MST recognizes connected displays as one")
> Cc: Muhammad Ahmed <ahmed.ahmed@amd.com>
> Cc: Michel Dänzer <michel@daenzer.net>
> Cc: Stylon Wang <stylon.wang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   .../drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 13 ++++++-------
>   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c  |  3 +--
>   2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index baecaaf96968..0276db0afab3 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -1175,18 +1175,17 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
>   
>   	link_hwss->reset_stream_encoder(pipe_ctx);
>   
> -	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
> +	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx) && dccg) {
>   		dto_params.otg_inst = tg->inst;
>   		dto_params.timing = &pipe_ctx->stream->timing;
>   		dp_hpo_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
> -		if (dccg) {
> -			dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
> -			dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
> -			dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_hpo_inst);
> -		}
> +
> +		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
> +		dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
> +		dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_hpo_inst);
>   	} else if (dccg && dccg->funcs->disable_symclk_se) {
>   		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
> -				link_enc->transmitter - TRANSMITTER_UNIPHY_A);
> +					       link_enc->transmitter - TRANSMITTER_UNIPHY_A);
>   	}
>   
>   	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> index 19ab08f5122e..fd3f5d437c8d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> @@ -2729,8 +2729,7 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
>   		dto_params.timing = &pipe_ctx->stream->timing;
>   		dto_params.ref_dtbclk_khz = dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
>   		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
> -	} else {
> -		}
> +	}
>   	if (hws->funcs.calculate_dccg_k1_k2_values && dc->res_pool->dccg->funcs->set_pixel_rate_div) {
>   		hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
>   
-- 
Hamza

