Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104D1C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 20:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E34310F9DA;
	Thu, 30 Jun 2022 20:46:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 553B810F9DA
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 20:46:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbQijbdCC1ETemA1y7Pkisyz6luWXSLdYFwvU/LwsbSp9tviFVxjJ0bzU640BvojCLPWL0Y25Fn7+r3tVAZUiIIux/ztOCcKBp8WHxFEeqrfwgzn1boSq9v4M5RMzEQQCxJAJvZ4aAYmmqJJYspGnfZPyf12aCqruwS/J4vQuJ3oN06ttuMsiEuQ9HbDMO1phUtqhqqPZhYKKfBh/WfYO109haDR3TgyUKH7Y0Zflb3Gl95G68hfx6mFLs+WKI9M/C8bJ4oszqrIw/MC+H5MIAlnXoQbAtAeMMwXDB9lRYcc6cKCaORklXunoovWXEfU05HaySRWV6talTwXh/uDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvPibA+5kExpiTD6QoXzGZJZH0OacyACSE+8pmJ4VzQ=;
 b=PNlXmRG4kS+GmBFa25A0ROvhNRyY3Zckz7SSYdkNVrTBlQyTrVX0thoMdtalWYuzZMWfFZSrX0PTlKSD07K7Umb5lwvz1jDvK4KEYqla5pq4E0mtUm1tfy4Cxs5dWblKF0/BJwbjX5shFisN85To1HD8t/sn+sI3fUvUK9F1w6ROBn9x/ynCX+5XvdVEWEji5uo11IM0mFtBFJFUtPEMUDotmRhm+HZiNw9pyiL0nNagRP5BFVYEiUZMTlIBxF8kQsbQ4Y21KOhoI/O3uPr4bLQIpZS8gZBOWuTMk6QGKNObUWoVgVDBG5X0t1qW6KQl9yIE9EvxtSTXALawSjqlQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvPibA+5kExpiTD6QoXzGZJZH0OacyACSE+8pmJ4VzQ=;
 b=bnvQBjUo+L8ARZt6/6wINs8Qjgbz6BYLp+52yk7wci0X9A/CegBgPx4oGnD8rwDrIGvmy9kOXj9g3aruX6od7H6EGxSv2Hafh/vvZyRNCi+N3fR4FpQpFpONYG9UuwzT+q3HWc9KbfloAZHPe2EejYUagnoyBprOh1Sa4xQLhJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by BN6PR1201MB0227.namprd12.prod.outlook.com (2603:10b6:405:4e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 20:46:37 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::85a:3075:1744:8317]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::85a:3075:1744:8317%7]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 20:46:37 +0000
Message-ID: <9093e99a-4c6a-6862-6d71-7c6e6899e3b5@amd.com>
Date: Thu, 30 Jun 2022 16:46:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu/display: add missing FP_START/END checks
 dcn32_clk_mgr.c
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220627210415.67100-1-alexander.deucher@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220627210415.67100-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:91::34) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2747b9ce-7aac-499d-e974-08da5ad9a043
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0227:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5MGn4D6F88VQE/mk+g8azBntvI0YIp6J8wKjEH4Nwh0RPjPeHVMRjJi6tbmUNJSdB5D7wXaGs/xfZd6PZyQ5R1/aoLVbOMS+dU7kQc2m/jBEfcphCgqwu5P6NeQJFE/F7rk1WNF/CtfnMFatx1t2wW/zxxRlIDpaVRe16xujz2sHM/0ZATxO/JVHlxt1uuZSkYtnCK8LnMjSG4V9uq4miN12PAKovp/8KikdG/2EAfc/aP6ZD3ZQv/vFUI6tV5RdgT9HCR7TIUyo30UfU3IHiBQn2EUTNwwqzf5jAIUs7Dd2vQWJRtlXA+DSxD9VvA/JqIzID6SkQRQfT+sorfNbugF2HoEevBU24Fv11jWvD5PregemrMHsujLnF4mY7XtdWT55FTOLHS5LwY8r6YGC2WX3l0FqPE1NdYLG7dnP3j+U0CATbm3UcoodL2+aYWMk/W9dTp9G2y18iK/+sNg8akXTysnBE3zCJBiEUaY4EGETVaUytUHlD8+N0DhUVJQUybI50N8XM0qfWAF3NNmeFNAfF4Zrbb5ZV0xaHb4vue7RfWI1/4SSePJINi/IiwODcUfqbHl9f2chm13nKQ5moH7r7Scijd6nzzHPb5VfZi6CKxIpDVVw2b8ztNmL0WPhRW4lwZL3Gt/UGhwXo8SrZV1YoUZpXdU/RwxE1x/iNmbiAU9ftydDlWs7W7GOgzoy5BZyZpBi2chBXrPH9TAv9mTuIw3zXvPhR3a6iwNGOrOkz+5DR+oSfudWGRsTt2k3Xg02wmo13a+QX9fjYXDojC1jr9SKeorH/Bl0u8uCMGAc3yxKRwq5y95iIQG2j2Xyb1PZDBFKsEPYZaT4lC0Z+IkpfchF51bey0VXWWVUQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(186003)(41300700001)(2616005)(6666004)(6506007)(53546011)(6486002)(478600001)(31696002)(26005)(6512007)(66946007)(66476007)(38100700002)(36756003)(8936002)(31686004)(2906002)(316002)(86362001)(5660300002)(8676002)(66556008)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFVzOUtCY2E3L2xoQTROMzdJRG1GaGR0Q1hEOFJRaEZXK3k3KzkySktZbi9B?=
 =?utf-8?B?eGt0WDU4UU5sWU1GUUMwOUd1Q1g3U1lwZ3grRzJMYTg4UXNKSlkwMVprdnBX?=
 =?utf-8?B?aGIveGs0WmxsYm1oYlBtVFdsUXdab2I3TGhxUGFEK2ZaK0FkVUdTZ0k3V0to?=
 =?utf-8?B?dkc0eWtXWm1ZZ3VKVzFmdzNmNUpRTzNIbEpsbk5pTkdOakhMQXczeWdWMEEz?=
 =?utf-8?B?eExVYWdUVCtMeWFpTFhFcWNZRUNPYzA4aXhYSmQvK0NYbGJCWDlQSDVrS3Rm?=
 =?utf-8?B?Q1JnZDU1Y2VycndjQlc4RE1HRWJlVzZPb3hKcmkwN3NIRStHdzVjOHE2Q2Ey?=
 =?utf-8?B?Ri9iV2xGVXJWY3BLcUhud2lzSEQzWWNmNUxvQnp4SW8vN1ExSm1CSVdUOW5S?=
 =?utf-8?B?TW1Ra0EvMjJRQWoyWTN1UlhEdnp6VDFreG14VGdLbVVEUFFqZG5jeE9oMndm?=
 =?utf-8?B?bjFTcWZUbWRRZUxhQ3dDdU02NjRTRnpSZllaQUM3dEtXUkVJZ25BSkxWOU5P?=
 =?utf-8?B?UzIwQTkzSy9IaEFOOUlSeDFTUHA1cjZTNWNHMTFJVTF5NlVaRkN0Q0wrMW1u?=
 =?utf-8?B?ZjQyMUZPZ1Btam80K1M0emVSZ1dRNkhnempXczJkdGtLOTgwVVhqcnBuQUlM?=
 =?utf-8?B?YzYzU1BubGhpZVJLUkNWUW50ZmZpR3dpZll5aHBXQjBYNTJXeVZ1dGRuY2RK?=
 =?utf-8?B?YlBjUnFTZ0FjSmhTV3JnMjNpcDhKa1lMUHRudG5wdFlxZnJzNU9iTGcyVlBj?=
 =?utf-8?B?OThOaFQxNE42TXg1bnRhZitGL095Z05jcHFZQVQrVmQ0ZzFMejd0a2VtTmEr?=
 =?utf-8?B?ME9vMk9ucUhyMGJNbWZZNVB0SkIvOTJGVlBNNTJpais0MEswY3VCcjZTeUNH?=
 =?utf-8?B?WnZ5bzkzTEVmcWRxZUd2VmhueW1BT3Avd3QrcHdnWmVVMlhiY2Y5T1NHU1hj?=
 =?utf-8?B?c25zc04wcHU0S2FQZ2R0cnRRbk9Tek1FclkzY09XRE41OWt6aGVDTThSeTZ1?=
 =?utf-8?B?OUFMd3hsS2gxN0Y1Y0J2QnFpaVpkcHE1R0FRSUdkSXJhVTgwemRHcmRqSXN5?=
 =?utf-8?B?OHR3SGpTSFltNHFuRHd1bG1tRnpIUVZLeDRxR2NuOU1VTnpSWVN5NER3ZDVC?=
 =?utf-8?B?TWplY2J6QXp2dEZNcEpDRzI1Y1orYVpEVXZCVHMvVUdnQlM1UzBFdzU3KzlD?=
 =?utf-8?B?d0lDQ2FGL28xR08xOUgrRHVYcmREbU93ZUhod2tjR2RvMGZUSUo1ZHlxR2hu?=
 =?utf-8?B?bUxYc1pxR2xmbjZwd0NnNmJPODhVZWc2NWU3VXJBSyt2RlZQWjVuMzkxVGNZ?=
 =?utf-8?B?U3RReWNUZ2s1L1RWYkVFYkRkMzVQWVU0SCtmc0FMb2ZzQ2RVekZCU3JkTDJN?=
 =?utf-8?B?YzU5dnUzblVrZE5jamhicklHMGRUUjFhMHdBU05ZZDZHZnZjNmhFYlRyNFoy?=
 =?utf-8?B?a1N5c013RE9ZckJyd2JhV3hpL3dUYTFHaVFtUUkvVEZPMVV3dmhadm4wbi82?=
 =?utf-8?B?K3hRaGRGRWZEWEcxRkEyY0hzMXJNU1J0YTZrV2M5aXNKRngwY2tsejNLak5t?=
 =?utf-8?B?TEZwelRjSHBIRXhDTHNmeG1lMmovZmQ2ZnczOENqTUdEcCtOaDdFRnMwWm5J?=
 =?utf-8?B?Rkp1Z2NvVHZHZ0RNaitXbVdOaE1tRmpIaFFJNzVPYlZnODgrak1nVEpacDJF?=
 =?utf-8?B?cGIyWXJvci80K0ViRVNjbXZqbVY4aVZhK1FHM2tYWXlQaHFlbEZZR051Z0Vs?=
 =?utf-8?B?aVF2Ync3d29FSDVsTlZNRjlOZUVUcGtxeHRIZHdQS1l6VmJjNXJac2N3MVo1?=
 =?utf-8?B?SjBPenZrVEEvYnBQNDJYcUU2WVlYRlNBbUFwYWZ3N2o5aFl0ajYySzFTaDVm?=
 =?utf-8?B?bEpGdk55SG03QUp3VXVsa3lvVHlwZzBKcS9PMVMzWTY4MlF5cmJRRVJMN2Fs?=
 =?utf-8?B?bHJZbnVnQzBGc1o0VGVzTE9wdXNFUnlkck1HUjZCSUtQVERZY0I1MEs3NlJ5?=
 =?utf-8?B?a0JSNHkrQmhKZmdodUY4YVh4MW5sL2orYzRQUjlVY052cHkyVWVHSjVWakRK?=
 =?utf-8?B?NEpGQWdzcmx0ajRvR0U5Q1pCSzl3SFVZWVRRYWlRci9saGdQL1NpWlBsQlBJ?=
 =?utf-8?Q?nQteZ3BbhebB7wpB0vvq0GayZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2747b9ce-7aac-499d-e974-08da5ad9a043
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 20:46:37.1273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGlxCbmbCdB3nd2ssyYrT+S5Jv8CXa09tVg60VcEB7SxFHl0kfPaHnG9eCfQCxhLL7RHB6WHNc4YkZndxvYAgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0227
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-27 17:04, Alex Deucher wrote:
> Properly handle FP code in dcn32_clk_mgr.c.
> 
> Fixes: 265280b99822 ("drm/amd/display: add CLKMGR changes for DCN32/321")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
> index 4e8059f20007..72bbe7f18f5d 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
> @@ -288,8 +288,10 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
>   	/* Get UCLK, update bounding box */
>   	clk_mgr_base->funcs->get_memclk_states_from_smu(clk_mgr_base);
>   
> +	DC_FP_START();
>   	/* WM range table */
>   	dcn32_build_wm_range_table(clk_mgr);
> +	DC_FP_END();
>   }
>   
>   static void dcn32_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
> @@ -724,9 +726,11 @@ static void dcn32_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
>   			&num_levels);
>   	clk_mgr_base->bw_params->clk_table.num_entries = num_levels ? num_levels : 1;
>   
> +	DC_FP_START();
>   	/* Refresh bounding box */
>   	clk_mgr_base->ctx->dc->res_pool->funcs->update_bw_bounding_box(
>   			clk_mgr->base.ctx->dc, clk_mgr_base->bw_params);
> +	DC_FP_END();
>   }
>   
>   static bool dcn32_are_clock_states_equal(struct dc_clocks *a,

Hi Alex,

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Btw, I already start to work on the FPU isolation for DCN32/321.

Thanks
Siqueira



