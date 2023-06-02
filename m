Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A66EC7EE24
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 18:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE0F910E0D4;
	Fri,  2 Jun 2023 18:08:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 295BC10E0D4
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 18:08:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhuSXfYe0ZVeFoamGIz5K7aYeBcEqyj2Uz9gUI9turNaw2VcgULf5qLHbF1eBzMl6bV8wgLRdCV16qgNP8JyCydaxKwfTvn71BQpKyJWTyX3RDfrU2NkeuCuzGsZAwmi0j6wBfXIs1uPBkhM4jGN3y0/+MMbs07DixKZv9xNaYXb4mL4UJgsdcrSH4sMq/pOLttsfomOFYyQ5L49cdoKzXzc1TOGlNahUkV2DKtqD+hPEbMasLiKtrXnnbH/GHxu5O5jYYg03CWhyjKUKPx4JzzQK/m2jIO59VoK6DNzKVp9ComE1K7R79z82/7jHthh490N/sQN+bTVIMue8f29ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WOAsQX0CpgP96pMljXYIn3lm9cF1QGhzdhNVGQaArg=;
 b=hPkcWaKgQ+u4mRFgY4OssGDFQOHbE2I2OVgZk1Pem5/RcpmU6Kez51qOHJ6T7wQQyYmKrkZmxnb2ImaDYpVI49Lg4i6XEyPcwmA8kjPoLeK1DfTWR/tqRFTNaqrWe6qb5DoJt196n/OAZjGRGSPAE5YTNp0q+yycRSZ1xiyTtImDUQfb2Q/3U9a6Xm1OtqhYeU0GjAmt6Wcd6WoW+VIXHRcblcep8ZJg4jVO8qAPmvNHi/Ah03+ZqD0NaB2LWLMf7YG2Pui9S7xgD+ryXC4noIAor/QnneHVWBLasForPRbnSFe24gsQ7ZEdhWe9DtYkUN6d9ZN7jVv6ztMYUugXqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WOAsQX0CpgP96pMljXYIn3lm9cF1QGhzdhNVGQaArg=;
 b=A5sd88UiZTlTC4W5Tiw8lxSTC7BlEATlwF+MQ3PFxdzMAD0JUWfnYiBWTg6x+5GxRCJyBucEr/F7hL8dgYPsmqSgNcwdR7ffV4T2yR0SfL6NEjyI8IbL732/vdDfNWnbauUWySSuARn1d5gC5cdXf+/C1q9nryyAHERLjvcrUnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2934.namprd12.prod.outlook.com (2603:10b6:a03:13b::25)
 by SN7PR12MB8028.namprd12.prod.outlook.com (2603:10b6:806:341::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 18:08:17 +0000
Received: from BYAPR12MB2934.namprd12.prod.outlook.com
 ([fe80::3bc:3d5a:ee2c:1fb8]) by BYAPR12MB2934.namprd12.prod.outlook.com
 ([fe80::3bc:3d5a:ee2c:1fb8%4]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 18:08:17 +0000
Message-ID: <252164b6-ba07-06e0-f0d4-4bc579f66d5a@amd.com>
Date: Fri, 2 Jun 2023 12:08:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Revert "drm/amd/display: Only use ODM2:1 policy for high
 pixel rate displays"
Content-Language: en-US
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230602180446.273195-1-aurabindo.pillai@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230602180446.273195-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0657.namprd03.prod.outlook.com
 (2603:10b6:408:13b::32) To BYAPR12MB2934.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2934:EE_|SN7PR12MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 540ef190-4789-479e-ac80-08db63945722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1wXgmMZ/AZFimEvhabJE7oQdURWrH2BI18tHHcHOTVmVEfvTgFKYFtGIUT+CoHi6pnanLoQjgFqhnFhHRdMyngGcMa+H110dGt/wlDPWXIH1NFZtj1+v3XtkqY5sImx6ZtZoacpwia60t4uE6rgukqhoajuTARFNa92h9vq2i7yrMErh0nk7hFa3dBNCw24rG6x1tyWMZ3Z+bSbCAPqX9e7ySMY67MlkfiOMnpEJeeyw6LPSxxrBXn/xDsHSjpyAya5+sjTVUQnnWqAHHnd3PIkNAwXo/CZf5nMmYV3VVKTb5dccNDNDtcyshN+ASNyVsO4E2awWK7ROqpYtIALKMy9Lm6nKgybllQKnNlK6ZunOCDMoncTo184Ry2k1eGIH4wwqxyhRtKFfzvuFgD87fPcE4LyFuCVBId7JWgAk/RgbaX0T+h568E3cDjECbTeOV9jWwf5bxDJZ4NT+I4tg+cea56wZkbGfb+mf3rOpbKNw4Ykem/dQqManh/KvE5ngjuEU7Xd0OUd1NvRVOa8eW+JE7mrRxVh/YErUO68jinDnZxGrao37ZQSIbiqk4qb3ON5rMnybTtos8LiqIL4fQ9GVB5Qd+EXQzVUKI6UxQUcEusqlaJMEndwjo6cI/dsDNvP3yGUQzqxpxAksZ52hkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2934.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199021)(86362001)(31696002)(8936002)(5660300002)(31686004)(8676002)(2906002)(4326008)(38100700002)(316002)(66556008)(66476007)(66946007)(478600001)(6666004)(41300700001)(6506007)(53546011)(2616005)(6512007)(6486002)(186003)(36756003)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlZjZ05KYmJTVW9jaGZUZ3MvTEZyZzc5elgxOVBtaHlld1FUWUtFUzh4M2Rs?=
 =?utf-8?B?QjQwZ05mQXZILytjQU1mVlpuWlNxMGxnbGw1TGxVellwR0VrTUNTYk5zRW90?=
 =?utf-8?B?Y09xTXlGeitMYzZTR3c2amJIYUdQQ2I5NW5FQUJHKzgxNCtjT1pPdlRKWVdO?=
 =?utf-8?B?UjNuMitrRnhsRHg3K3RpbDVMZzVtcmdENGtURXNEQnQrVW1DcDFlUmJnaHRW?=
 =?utf-8?B?b0s0eXEzbENNSU9XMzM1V2QvM1ZzRGY5N3YvdWwrV1V3MVNPU3I0K3hzVTFw?=
 =?utf-8?B?Z0w3OGZpSmpaZko5Zk5vUDFiOFkwSTI2UEx2WlpDSzMxeTVpcmZjcnhNVkJW?=
 =?utf-8?B?ZEV6dkVhS2ZLRm00RjhkZ0cvLzI5VWIxWkVWcjd5Q1ViUThJTU54QmJUaU9j?=
 =?utf-8?B?QUt0U3NxdHJXL21BSzFSaGREenFVL0FYOFhiMUpyeXBPQmJnRXFqVE5DbmRK?=
 =?utf-8?B?Z3V6UXBwRks2ZmpsOXpUMDQxait2Q252dS9DWkNWcEtPQVVVTHRFT21leU4z?=
 =?utf-8?B?TGhTRU9lVWIvTml2U1ppcXk4clN5eEpIc2RSTW5XYnJjRmZwd08wMnNwVk1j?=
 =?utf-8?B?dUNYTTc4MnhlbjRVNmdHaGtXaWpjWDUzaGREQ2J1ZkFSTmxkTTdnVUJJN01r?=
 =?utf-8?B?TVNiNFYzV01mNGlzVWI4NWlRcUNhQ0dmMGkrWmY3amdPQzZVdkRxcmFhNG5w?=
 =?utf-8?B?bFgrUHI2VzM3dk5MVjNGdHlnVUdQRzVFZjF2TDhuUDIzUG9uWkxzQ29oSDZs?=
 =?utf-8?B?MHBaOGYvRXFNdVhzdE9Udk42a0xtdkF6akJsbjZnbGhPc2xwYVFJZ0JtTXlS?=
 =?utf-8?B?aTZzcE5xcXZIVjZJOEg0eXRYWEpVckVUL2xoai9Mc2RzSWNiVUw5cmViTU5i?=
 =?utf-8?B?Q3YrbEZlbStYNmw0OURSMy9rV2NWeUJGZWpHSGNPRjFZSnhTMVFrQUxRZklB?=
 =?utf-8?B?dmRXTmg4TGVBaXVmUVRPdlNsZ2hEeWZla3FGSGk5UWpiQlNFWGpjdkdteHBZ?=
 =?utf-8?B?d1pETGhqang5Z1IrWmJybUtDNWdndDhDQmtLVmROL2g2a2NuSC9HUmNsMHRB?=
 =?utf-8?B?K2lWTElPL3NkRFdvd2x0blU5ZjRrWmc1Yi9GektPQnY3eVFET1lYblVFNnlC?=
 =?utf-8?B?QjkxaTdGdWN0a0YxOHNRQVJnZFJLQm0rQ2p4dy9HR3FnVy9xVXhUdVd4SUUw?=
 =?utf-8?B?NWlkaFk4dWU2WGhnZ1Ayb1MvUmQ2THJ1V01GdFljMnJLWHM2aHROYzhobVdI?=
 =?utf-8?B?TThvK3NudUpQM1pXSTQzZXAvcDE5K3lOOWx6WlVwRUJZRXR3L3hrd0lLakRK?=
 =?utf-8?B?UGdsOEk1QkZpWlpNSEh4WUYxUkhsVllEUmJ3UEZKdzJ6UGZJWFY0cUJNN1o0?=
 =?utf-8?B?dktFUVVNbjVXdTdtNFRhbHBnTzhiV3h1Q1RtcE4wRlJKQjZGeEhnQUswb2RV?=
 =?utf-8?B?a25ZdkJLV1lOZXZzOTJVMVdLQXJoRElXbnIyVlcxOG03NmROdWl4dmxRVzN4?=
 =?utf-8?B?WDR3SFZ5N0FCRGJ1a3NXd2FncDA0bWVieFRaQTFTWHpXS003QWdFVi9TN2tu?=
 =?utf-8?B?djV6UytLN29MeU0zdmdZNlh2RjdUbThMb1JxRXcrak9lckl2UHg4cTNvRHdj?=
 =?utf-8?B?ZHAwVS82QjUzb2RrSEN1Zks3Mldtc3UyaU1jN0RRK202QWYxcU5ER3NpNy9I?=
 =?utf-8?B?YUlhWDBnWG9jQXFVK0tZaWxHODNyeklLYWlUWG1NT0YxeEJqUE5lUjkxMVBz?=
 =?utf-8?B?UFJMVGwwRVZZT3FGTjZCeVJ3QVJuMVEyZE9HSlc4MThCNi9EWmppZFg0Ujc1?=
 =?utf-8?B?U05NZkpmRy9jSTc1elF6NUl3ZUVxSldZSG05eWZFZHlFV2JUUHgvSUFjcUpX?=
 =?utf-8?B?ajI5TnkzRHRYQ00xRkRPWWF1YzZvY1FwNEh6RFV2S3JuVi9pWXFIaS9WWVJq?=
 =?utf-8?B?RU0zdkppOEI5ejVkU2dXVllYQXRFWkR1aEgrV3FUUXRrdDVMNktrTFRDRS82?=
 =?utf-8?B?dFRNRWZOeDFYRXFhL2ZUcldJdS95bnUzRE9kNnJZVUhmZ01SVVJpZ3J4WXYw?=
 =?utf-8?B?UHdvYXdzQTA0Nkd4VldKQ3lBeWVySCtDT3E0d01tODlqODVFVWxTcUhuK3pR?=
 =?utf-8?B?YzJyeHk3VlAxckRENTVWeUhNYXBaNk9yTjcyVmZwblNqWlhiamVKaFRjYWVx?=
 =?utf-8?Q?3YyqgN6bCAn4pTjHX1ZWQzeG2oSk/QPgdFWsdOIdck5I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540ef190-4789-479e-ac80-08db63945722
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2934.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 18:08:17.3555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLellg/U46YimUPLlgBEIj007L8/VRhWZLRx6a+tj05E6oU3gAk4P1Ojjr3VkfzhFaOP8ePX+s5Kixlf2va6yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8028
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
Cc: harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/2/23 12:04, Aurabindo Pillai wrote:
> This reverts commit 047783cdd5f604d87398236beb4971abb4d43293 since it
> causes higher power consumption for single display use case (4k60).
> 
> Also, this patch introduced a 35% performance drop in a Vulkan benchmark.
> 
> * The patch disabled the ODM-combination on most popular monitors, including 4K, 2K and FHD monitors at 60Hz.
> 
> * ODM-combination can halve the DPP clock to save power, that is the reason why we introduce ODM-combination, and the PM log shows single pipe consumes more power at 4K@60Hz.
> 
> * ODM-combination has 2 de-tiled buffer involved, which provides longer self-sustained time, that benefit to the memory power optimization.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 1 -
>   drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> index 2e6b39fe2613..8d68f02f5147 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> @@ -1918,7 +1918,6 @@ int dcn32_populate_dml_pipes_from_context(
>   				context->stream_status[0].plane_count == 1 &&
>   				!dc_is_hdmi_signal(res_ctx->pipe_ctx[i].stream->signal) &&
>   				is_h_timing_divisible_by_2(res_ctx->pipe_ctx[i].stream) &&
> -				pipe->stream->timing.pix_clk_100hz * 100 > DCN3_2_VMIN_DISPCLK_HZ &&
>   				dc->debug.enable_single_display_2to1_odm_policy &&
>   				!vsr_odm_support) { //excluding 2to1 ODM combine on >= 5k vsr
>   			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
> index 58826e0aa76e..80bebdf43eca 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
> @@ -37,7 +37,6 @@
>   #define DCN3_2_MBLK_WIDTH 128
>   #define DCN3_2_MBLK_HEIGHT_4BPE 128
>   #define DCN3_2_MBLK_HEIGHT_8BPE 64
> -#define DCN3_2_VMIN_DISPCLK_HZ 717000000
>   #define DCN3_2_DCFCLK_DS_INIT_KHZ 10000 // Choose 10Mhz for init DCFCLK DS freq
>   #define SUBVP_HIGH_REFRESH_LIST_LEN 3
>   #define DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ 1800

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

