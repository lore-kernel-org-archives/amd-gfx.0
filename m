Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC13C7EE24
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 15:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9A6610E09D;
	Fri,  2 Jun 2023 15:08:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D880910E09D
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 15:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtzNzwJFBtJL4H8nIdISwLgwKPKibdt5toaVJmwy95MGAZ2IEQvv6tjhHvfG9xCR2KZZlNtBCbWmvWyIKzzrZ7pU8z6eZhFoeXLuvi2do29Rjm0qixVfE00zAJIpGEhtNNlE0hsLUiL0T+PrZVTJcc4kQNM4eQVAqJY5e04PZCeBegOfOkA78FD/5uh6y0+GlKE3+Um5vJI8ChCAW4Xn+fgV7s/+5TQQsXq1FWqlCruR605CT8hLli6JENAMu2ndu50wYESzT0ZypOTDlWGWfGhJhgR6eSLpNMxXrPIHxL+p/+IZvUNhE2ajRi90LEnrnklLT6Y77dQRCbmEi1glqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gbMd/tPUJonzn775GMPUpWAKWQh9MVWVjpXJl0/U4o=;
 b=KIgajcswUp9VJ/n3o9cn3jJN6eDV9tdb01N7t65JzkK5M0kUJIsz+IhrpyjdOX4HcNUIBkH6jbOkoH/uxaE61jI4yjkAe9umPL7TSDaEX0ZuxBoWJs2ILGXgmH+H7pIUTi8jgGHY18y/flqI5MbgeHD7zl21wBt73M0DNjOyMHxiQe+ne8sKYjdITngIPtx/9WmB0CfhnZ4k5oZYySGs2gsY3dbKOeUBbBtu2XOk6SuUlr6430WVmZV5z4DAq2/VH3Kk1S7eMxkz+PiKy5okAnqsXqM3U5AZWUN6gZ1AyQM7e5XqE53IKzHFVDJIroinTdeeoTDrLapfxyYUMqIvwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gbMd/tPUJonzn775GMPUpWAKWQh9MVWVjpXJl0/U4o=;
 b=nMdBzTFE8fJEhAegAHkoGawtOWPD9Y3zaYdLLb2r5jnMSFduVfq7aUjx+gxgB34pF5VH5VoBbEfmwgvxI0684Z7eG3rpwRUfEYDFNPnqyWomDD9aZ1mDT6ef/J5uqsR9s9xfIQA4q5Jz0B+u/N+bZi/WR9v203XEjpnC/kvoVcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by BL3PR12MB6426.namprd12.prod.outlook.com (2603:10b6:208:3b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Fri, 2 Jun
 2023 15:08:37 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16%4]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 15:08:37 +0000
Message-ID: <1026f84b-f7b7-fbbc-bae1-abec1653b9bb@amd.com>
Date: Fri, 2 Jun 2023 09:08:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amd/display: Program OTG vtotal min/max selectors
 unconditionally for DCN1+
Content-Language: en-US
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230602150144.259187-1-aurabindo.pillai@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230602150144.259187-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0736.namprd03.prod.outlook.com
 (2603:10b6:408:110::21) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|BL3PR12MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 5033c6aa-f007-4e8f-6898-08db637b3d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0uWjPugEQmjZHVkIGvVPcjvY1xbRVDIPV99+HRkoVdvImWikpaILEfSuFNcrz2t1XgdBvphZbmn+j1qXkb3NKvwMoDVYMBkKAd5IfZE5OuRdU2C7uvIa00ZXWFe+Ia5c7EhrRjkrl3oSaUmFBfOptcT8VehPggmbirB6L32hUmt9jduw3ORTen6GyZW4ArlJTxMxABWQr6F6f/9hT1yuWG7lwNcxANocaMxyVpIB4Nzbj/4xw37redyz6Tva3KzdlODqIcbzn3aq425b/8u+S/fBB4hjTVERmO3t4FBev1ttpk7xWMmGvm26M0Wix6LIwWn3gJgaZyNwtDrInZEBpb7vyA2eKAUXCjjaJyvn3aQylyRJfbfaCzPgQ8A3XJwRvYrjL/SIz3g1Yd6GSeIolgtlGMNn0f1M6zZp9/H2GOVTZFIYAPl7Rf29HXxmKksZ7jzH04IUZnvBhMv20zAEO2056HhsR5+5q0S9EwXhzfW4piMMVFBEWd1wZNQ2keQLo0ZzQNVf1ad3p1uUKrs2IFUaNpvj5fW5r/7CrbUVOe9fb4v2mYvuojLv14IuYxwbYVYKLY6DeYUbl9EzfCU7hVz0+Pqqx9wYsCCnXPRc3R0S2Dtdv98KQYAI8NaFaHbhFRbldjpR7GbBNHRWqWmPuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199021)(6666004)(478600001)(38100700002)(83380400001)(6512007)(186003)(2616005)(6506007)(53546011)(6486002)(36756003)(4326008)(316002)(66556008)(66476007)(66946007)(8676002)(8936002)(31696002)(31686004)(5660300002)(2906002)(41300700001)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVJtU0VEYlVIVVVTdkp4WExFUElrdW1WZlk0ZjBHTEc4UEptZ2NzaFBUN250?=
 =?utf-8?B?dVZHNmU1QVMxc2JQdkljZFF6M2d5VUtuQm5sUVJFeEY3MWY4MFFkc0hYUGRM?=
 =?utf-8?B?OENjY3NQbTZsVVNEVDJwaXZvb3MvZ3RIMU4vN2JwTEV6UGVqcHdqZEs0RlNG?=
 =?utf-8?B?amowbzArTHAwY0R5TWR2bzZBNys2dDUxWTVqUG53MllYaFlpTjhNSGpneUFU?=
 =?utf-8?B?WEp6SGJLdDA0MGgxTnhuTmQ3bkZIMnNhREpyVEpoNytZY2dkMW5INHBUNDlv?=
 =?utf-8?B?OG9kOFIrclhneE9idTE1SXJkajhOUjNUOUNGaTUvaEZqVnJhd0xyM1BBaUlT?=
 =?utf-8?B?OEhYdW8zVFhhdEs1NzFHRE9JR1NtTTVzaWU2OTFLQzZHM25yZTkwa2VXSTRx?=
 =?utf-8?B?QkhGbjlxOC9SWHQ3M1AvZmw2c241SmxnQ200SlR1S1VTYUhTRGIrbGFqVmg3?=
 =?utf-8?B?NjErWHM4OWl2b05KbGg5L21CMEE1WHZpYnpvNXdMRjZDTm80alZDdTVJNW12?=
 =?utf-8?B?anNnY2IrSzJTZHFqSDVzdmdzbGE4Q2R3QmozSk1MUTRTbzNoazNqZE5iVG54?=
 =?utf-8?B?VVNZNzVOWkQzOUU1NkViTmcrSmFOQVVvNG5QNk9TSmRqbE5KMFZuUDVNR0NY?=
 =?utf-8?B?azR5a1NadWpyNXFGbWJnQUFBRHdYdERYYXBXVWRqREtZTnd0VjlNdUhta2FU?=
 =?utf-8?B?SW1ONWxyZitTQmoxR2hSamM3Q3U5cmdpU0E4RERLaWxLTUd5ODdPN1c5NkFJ?=
 =?utf-8?B?UzMwWGlxZmNQTEVqVHVLK0tOaGxzaVpyMkNQSkczSThta29CZ0h0VG5DT214?=
 =?utf-8?B?bWx5K0Z2c2hyZnZrb2RlSmFqNjhsbHdKSVZuWHZZQzdMVzJWVHBnbjJ2d3BQ?=
 =?utf-8?B?T1N0Q1JtVk0zblNnUlRaWWNJVW0yQzJqZktUdlJjSE9iN0I4TzRFajJ6dXVS?=
 =?utf-8?B?U3RwYzFMc1U1c05PejZNQUU2Sno0Q3R0RGt2bHROdmd4b1Z3QU5iVndDblJn?=
 =?utf-8?B?STRGOGpJZHFQZDlNenlMMmJtdjBaMjJYZExiYXd3RVlNM244VG9tQ1FYWlNK?=
 =?utf-8?B?bGlLbWdtT2VyRTRPSkxmdmhDenkvVFppTmlQdjcrYlU5eDFrTTQxZk5aMUxC?=
 =?utf-8?B?ZzVkTDVxMGxRYS9rbmZPWE9YQjgzVlp0NzZWRDVSV3I0ZERHdGswNTY3Yzc2?=
 =?utf-8?B?bEY4bUkrYWR5RjJlYWczRFhpTHVZTVNCR0NnYnMyQkMyNWkrais4T3lFNWwy?=
 =?utf-8?B?OW1jcy9mbE5VNjJKTUl2ME5TcURkSUhmQWw2MGZ6d2pNUnViSytlcUZ3dTRC?=
 =?utf-8?B?eEhYUTd6UzFKRnVMbXFydnpuTVlGMUl4K0xHVEF4Y3JjRXBWYjVnR1dqRnJi?=
 =?utf-8?B?S2lIOFUrdFRRRTM2d1Q4M1E3MkRWS0ZLSTdVK1RacDZ5N2VQWk5KU0hzb3pJ?=
 =?utf-8?B?VzNpK1BsdGxjQ3RnN3hzOGUyY0t2eStreHhMcjk3T1p0WWRLNVRpK2ZvLzM1?=
 =?utf-8?B?UzJtaVZoOUJlOUw3ZFBEdW1HNi9RSVRLNkRBTk0ydFNoVVpnUytBanpoTmxw?=
 =?utf-8?B?S09lK0wxVjZycUg1VXVlTUFHYmZCcDlsRFBZU2dwa0NEUXV5TWloZGRYRHBX?=
 =?utf-8?B?blB6UGF2WWk3VUVLaEFFWnR3VmIwTHpYUUxBMVR4c1pycVdtODdvTXgwV0Rk?=
 =?utf-8?B?VXhmRjJSYWp5NGhHU2dQYUJIRllHczBaMWlZT0xMUmZub2FJZUhRN0pkNEto?=
 =?utf-8?B?N1MzMm9PZnZMOXdVb0pKamx5ZEc4WlBBWk1uWDluRFBZbnZUTG9VbXpSdm0z?=
 =?utf-8?B?MVlFc1Z5RTZWbnBKS0wzWDlybit6OVo2VlVVdEpXRXJkVXl3N2hTeElqamVQ?=
 =?utf-8?B?MXQ3N2hWTE5JejJUby9OVTRtRGhOMEtkWHZTZzRqZis1NlNtWDlEWk5qRTA2?=
 =?utf-8?B?MEZPOUN1MndVMDZQcG9qbUFWbjIxWHRES3RLOFNXQWl3cUd6d1JJYXZ0OGdK?=
 =?utf-8?B?WmVVaDg3SFAvQ2dUM2NWNnlURXdjdG8rQ1dyZDBtV3BnMjVsRTNjdXpQVllp?=
 =?utf-8?B?eE0wN3djeTVCZko4NURFZGhLNysvSGhSUzBKWUV0MlF1Yi9LT3dLSUhPWXZE?=
 =?utf-8?B?aVp5WERxdDhkNjQ4MncrdVdWdFQ4R0ZucHJOdE1OS2VKTTRUdjNSZlhWUmFS?=
 =?utf-8?Q?vG62cGTUXmUuN2iVM1jtMlUYjLHdXHJ06ZbvBvHCc7TD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5033c6aa-f007-4e8f-6898-08db637b3d8a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 15:08:37.0403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6V3GxE05YIhvhQLlyQRxqrtwK/mhYEC7D1/6VoLQv9huLh2qBB3xcyLxVg3OQZchTyu003sAjOt9vbv53LH52g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6426
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



On 6/2/23 09:01, Aurabindo Pillai wrote:
> For FPO/FAMS, DMCUB will try to change the output timings by writing to
> the OTG registers. However, the timings written directly to the OTG
> registers will not be honoured unless VMIN/VMAX selector registers are
> programmed with the right bits and trigger source is selected correctly.
> Proper solution needs to go into DMCUB but will require additional state
> tracking to ensure that the selectors are set and reset correctly as per
> driver state. Until fix is merged into firmware, apply the workaround in
> driver to unconditionally write OTG vmin/vmax selectors.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 15 +++------------
>   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c | 10 ++++++++++
>   2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
> index e1975991e075..633989fd2514 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
> @@ -930,19 +930,10 @@ void optc1_set_drr(
>   				OTG_FORCE_LOCK_ON_EVENT, 0,
>   				OTG_SET_V_TOTAL_MIN_MASK_EN, 0,
>   				OTG_SET_V_TOTAL_MIN_MASK, 0);
> -
> -		// Setup manual flow control for EOF via TRIG_A
> -		optc->funcs->setup_manual_trigger(optc);
> -
> -	} else {
> -		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
> -				OTG_SET_V_TOTAL_MIN_MASK, 0,
> -				OTG_V_TOTAL_MIN_SEL, 0,
> -				OTG_V_TOTAL_MAX_SEL, 0,
> -				OTG_FORCE_LOCK_ON_EVENT, 0);
> -
> -		optc->funcs->set_vtotal_min_max(optc, 0, 0);
>   	}
> +
> +	// Setup manual flow control for EOF via TRIG_A
> +	optc->funcs->setup_manual_trigger(optc);
>   }
>   
>   void optc1_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max)
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
> index e0edc163d767..8a93cba64630 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
> @@ -455,6 +455,16 @@ void optc2_setup_manual_trigger(struct timing_generator *optc)
>   {
>   	struct optc *optc1 = DCN10TG_FROM_TG(optc);
>   
> +	/* Set the min/max selectors unconditionally so that
> +	 * DMCUB fw may change OTG timings when necessary
> +	 * TODO: Remove the w/a after fixing the issue in DMCUB firmware
> +	 */
> +	REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
> +		    OTG_V_TOTAL_MIN_SEL, 1,
> +		    OTG_V_TOTAL_MAX_SEL, 1,
> +		    OTG_FORCE_LOCK_ON_EVENT, 0,
> +		    OTG_SET_V_TOTAL_MIN_MASK, (1 << 1)); /* TRIGA */
> +
>   	REG_SET_8(OTG_TRIGA_CNTL, 0,
>   			OTG_TRIGA_SOURCE_SELECT, 21,
>   			OTG_TRIGA_SOURCE_PIPE_SELECT, optc->inst,

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
