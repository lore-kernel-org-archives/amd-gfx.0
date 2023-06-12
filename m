Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B24C7EE23
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 13:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35E5010E240;
	Mon, 12 Jun 2023 13:24:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C5BC10E240
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 13:24:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2tyjltBmOvM/gyqZ5uEbHLEU+OWU/2alhOgfauxH2TRinjeCG9gKhHDkw/P+vp+0oU6XJE0Y7Qe4uStrEs7xWLLAOil65g1OPG9u1aYVsisX8WDqly8+NlcM9EVc61TlX9qPfYlK2LrDGjCXH7uCNmL3xZ/ZwlbNh7HlmGOyWsvEUbSFjlHhrcpi8jjgM2qRq79zbYygy9o9nK/5jzR37x6Ax+iFQ988+K9/FsHc7AEiQUEqZKwJR4edeTup5Y0voWq2d6hjBC6PyYuKOESqJaP1dTn62xgbIiq+E+sN5+bfn7Fa345K/b8cZyG3LTFM4BwnoIO7fZpL8bLTRmfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xL8TWg5sqf6ib2wsK6XsVO+cnRWtM+a8cGZyKyF+bs8=;
 b=WVHlG0oupi1MfBdS1jVnAQEPouvEC6UYIkWLOPrMu9d+WxK8Nvi5SGzMP+zjs0C2kzcC3uTBtuggfcGYpHWue8mO9yJsTTn3ST21YTvKoHf0qvzk4wptVB5aSorKgXTqWNeMBaT7gWtud7QDM7hvqCknFyFxmUPM2raHEFuhhlq2/tU2nX1lNU025w5KQ+XfQFiE79XmM5H8E2mmMhhQMO44T6XPZs1ZLULjPdzxMbkRMr0xUrExTZbY2OADc30b36+YrwRQGRUUWBR281qWOhUdvgfTaeqE2R0LMubl6ZWi9To/0JdiOJSgjhjMcqGlNz2yKUXNb3ZBx0LtSr96nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xL8TWg5sqf6ib2wsK6XsVO+cnRWtM+a8cGZyKyF+bs8=;
 b=wZug6yucOKBN9QZbraF7n263oeDeoxO2wXEuoLyn8oxnHR15zgxg0fyA1YVOmxPgJwrDSDS7yXQoz/X7lWEtasCxCdiuSZFOaVUt+H8brqWKeBQ1SZVmuUUOdJH2g00BK68BZZKtjbcKP9IO9hKuQez6OnOjP1tqO4L79WQ5ob0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Mon, 12 Jun
 2023 13:24:24 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16%5]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 13:24:24 +0000
Message-ID: <ec78e90d-e4d5-2a92-1e00-db9bdcf41764@amd.com>
Date: Mon, 12 Jun 2023 07:24:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/display: Provide function name for
 'optc32_enable_crtc()'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20230603142823.1930299-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230603142823.1930299-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0489.namprd03.prod.outlook.com
 (2603:10b6:408:130::14) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|CH3PR12MB8902:EE_
X-MS-Office365-Filtering-Correlation-Id: 998473fd-78d2-47d7-fd32-08db6b485728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uOcM2vVKOglDUBaA494rVD7oRimlMHkXsNFcShFPUB/wSfoRjmJbBqf0IyhvSXZl20JgzNZw//xduCbhqYlcjX4aX/T8niZZPua6BSsrWgFotUr6kxpLCxF/fQliYHarQ4Yzf6hBnkHPKmzHg4QJGvpd1WGmWekVWbMeDBBe6sVPYzA8Hs312eg6gIiTtNcLE82qFADK+SdTwj8C/rLjWMPSIxPPHPutpd/qqGqqnd2ngZ9xqSQ0p6wpXCuZRjDbgS0FRvKUpd2lk06hzWe/qHtP0HPfIJYvunKMDHZD/tcfh8twAP9fqLsNSDKRVt017dyVpWzMLHQ359WOALgtqPngQfbfBAmOPhLY6XWDpHQU/6/Bj3cln91XASeapj3+8UaMbqlcMRqv8z5fcnCuuFq/vVSw6ABcrxRm2ROd3whushjzxSfHIoZdzZclwlVPGBLPnLjcqNXKC10YMwMlh9vcE2tDLsw0E4q18/0lQowU14x6e6GhBcggoXmuGMmKeB1RKUNGNLLzgPqQE9z4A2Sg5j/SbsQ7jh04BwwvRzxkr95q6W/mYq4B4LB4JaWQDYbSKPp33ASQ6NrbTQ/8S0kTPUrWYWTis4lIDabTSHFnwSAyVueCVPlpydU6X3vW5cfG0lABV7PDt094INmtOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(6486002)(83380400001)(36756003)(2616005)(38100700002)(31696002)(86362001)(6506007)(6512007)(53546011)(186003)(2906002)(5660300002)(110136005)(8676002)(8936002)(316002)(41300700001)(31686004)(6636002)(4326008)(66946007)(66556008)(66476007)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnY0R2c3em5vVElvTzlUdklBWHpsaVFIS3ZjNE5zMEdPYVhzUi9EbjFsWE54?=
 =?utf-8?B?NzdNNXY1WGZlbFlqQ3h3T09FR0NTOFpxeGIrMnpsVWdQZGNkSGVRS3VHdzNr?=
 =?utf-8?B?U012MXNidTJUWE1UZVc4TDYyNkQzOXRZdmFHZEVubkNMaGZGTmduMzk4eERM?=
 =?utf-8?B?V2RST0RHdXl6V3dPOHBOWDRQQ2M4dFVRb1diQUpDSjB5S0NRVHYyMjhjdytS?=
 =?utf-8?B?aVRDM3lGWlNSeUFMa1VGbG83YkZxTy9GaHBJQ0tJbEZDTkFlYXhuMjRHV0pK?=
 =?utf-8?B?SHQ1S3dQU2dFNTBKcm9vTStHdmZBRnJWN1FQTy9oY2JoY21FQ1VHYkxFY01a?=
 =?utf-8?B?R3Ntc0o5cVl3OVNmSHdNeVlXclVsYllxZFJPWU1zb0Y4cWJBUFVydU8wa2cv?=
 =?utf-8?B?M3AzS1dadU9uY0l6Ym8yU2pVcVdaeThmVEJpTkNVYi9MWnZNYWlQY1lUVTJY?=
 =?utf-8?B?MmI0WW5wVitsc1czZGw5MUZiOW1wMFYvRGxXWGFuMWJUcFdiQnhDWHhmYzRL?=
 =?utf-8?B?ZGhEQjlYWHcybnFON0FqQXhnT1ZMTDJnTURnUTBva1V2VUlTVDNNdXhEczAw?=
 =?utf-8?B?YzdOeEl1cTRFcWd2NWNuS01acGRZdERlMkJLRDNkNWZ1L0RQcFd1aEdDMVBh?=
 =?utf-8?B?b0dLRFMxb2QzNnVIMEhhVi8vRWt5enNyMW9QTlJjdkR5NWFWUXU2cFZlblRi?=
 =?utf-8?B?b1ZRaHNMbGFkdkxuNElLMDc2RXFJdHBmNStKQkNZUFNERDlRN2ZvUDRxeWFM?=
 =?utf-8?B?NHNsWU5TSDdCWXoxcS9JZDRhUVRxS3JDQnlYSmFTT2VRaHdKc2ZrbDc1SXFs?=
 =?utf-8?B?cEVsL1ROWkhiL3htSUk5dW9GcTVHL2kvaE9WVGJsQUozQ1hXUEU1elFLUUlN?=
 =?utf-8?B?cUJ1TGtNWXJMTCtzUndSWEROVmVxSC9HMlNvelpud3dXaGdIdTIyZldoTjAr?=
 =?utf-8?B?VFIvTUU2NmJFdG9Dc0FKQXlQckhOSXU5b2trQ3JTajk1YjVCb3BpRnllUWlI?=
 =?utf-8?B?T3hYTXdyMzIxQlVhelQrVGZaQVI3SDEvYXgrb3NuSTBQenllWEVjRlVGdi93?=
 =?utf-8?B?NFFPSjFTY0pVbm1kQnZVMWpKbkJ6SWxvdThuamtTZEY0d3FxSmt1c1gwRXRu?=
 =?utf-8?B?WVZ3b2JGYThhZEgyekxCZ2FiVHFETVVmOUxtSUVRaXcwMEVQamlDOHhTV1B6?=
 =?utf-8?B?aUx4TUtMZ2p5TjJRVmM5cmZCZGl6MFVjdGw0Yzh3T2JZMTJia0xWUGtGMmVu?=
 =?utf-8?B?aXFEdWJERG1pTUZ4NzE3ekwzWWVUVzdhamh6V1BuUjJJNXNydFRiUWxsVTVH?=
 =?utf-8?B?NDE4MENmbFI1Zkk0YlBUS09pSm5BK3MrWnpKaldCdUNZenlnMWhvZnZudW45?=
 =?utf-8?B?ayt4STFmSUY4ZkgxdldYRWZWTGNaOVZiMk1jTjRUMFBKdWx1dkVuNStqYXBt?=
 =?utf-8?B?Q0VGTG9TZ21QN201dDc3NG1aT1ozN2xyUWx5TEJkTXl0K0RiYXVMMjUvNkd0?=
 =?utf-8?B?dG16Vm56Wm9iOXdWakdUSFIxM2RLcy9NVG1qQ3N3NUJUQUkyWkFoVXpQZ3Ix?=
 =?utf-8?B?STcvSkxUUTBwdXhJTkliYnBnR1RqTVRWMHRhT3M2NEEvWElwWkRwY2d5ck1W?=
 =?utf-8?B?alZKNzZZcmR4SzRwRzV6QzZHbDZpYnpvTCtrQ1FxeHhlNmhqNHRNYkd1Y1du?=
 =?utf-8?B?SXcxak9VZE9NbzZlclF0SXR0L0hvdmhQamV2aE0yUi92Z0JHMER2Z1ArZnoz?=
 =?utf-8?B?cUo2ODZ2Q1BmR3JXNW5ZMmdXdVZzY1NNWXVXNkJ0d0lwMC9LQ0FVSDE2cklP?=
 =?utf-8?B?RWxkV2dNdndkSi83U3E5RWlzdlIrS3pPRUM0cFJwV0dzWnlqcEpVZDE2R3oy?=
 =?utf-8?B?Y3VLSzFGSG4vMm1DbjZab3BGVS95c1ljelBDcWVNaEhaalBaN21hT1ZNbHZV?=
 =?utf-8?B?MDhpZVpHMTdlQUc2UFlkdVRkaHJrd0oxSGc0eUs0TkEzS1lGUkNQdUp6eW1G?=
 =?utf-8?B?Q0RXb3kwRk5NSVFMczlwblJHRTUzUUxZeW1mZXZ2MEtEQ0ZONHA2T0VzSVBm?=
 =?utf-8?B?dWdzaWIzeUFVekM0aU4xYzFvYlBhY0o4TFkzVjA2UzB3eG92NWZmd0NVdUs5?=
 =?utf-8?B?TFo5bnY2VEs1WmljUm5mUlF4M2xRVHNReFR3OGE3UGdZL2hFYnJCSkxiZ0dH?=
 =?utf-8?Q?EZM8nx+BfCQ1RIzWQIGoo4GXciOprv7Ecbz2bHsobg6J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998473fd-78d2-47d7-fd32-08db6b485728
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 13:24:24.8516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axTTecfxfEUr3S8m1itz5c9dBzhsCHCfAJvyfqGY4o56CXflmuyJnNtmabsNFXIocguoDLje4Mx8vk8Pra7gpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8902
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/3/23 08:28, Srinivasan Shanmugam wrote:
> Fixes the following W=1 kernel build warning(s):
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_optc.c:109: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * Enable CRTC
> 
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> index 2cffedea2df5..8abb94f60078 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
> @@ -106,8 +106,11 @@ void optc32_set_h_timing_div_manual_mode(struct timing_generator *optc, bool man
>   			OTG_H_TIMING_DIV_MODE_MANUAL, manual_mode ? 1 : 0);
>   }
>   /**
> - * Enable CRTC
> - * Enable CRTC - call ASIC Control Object to enable Timing generator.
> + * optc32_enable_crtc() - Enable CRTC - call ASIC Control Object to enable Timing generator.
> + *
> + * @optc: timing_generator instance.
> + *
> + * Return: If CRTC is enabled, return true.
>    */
>   static bool optc32_enable_crtc(struct timing_generator *optc)
>   {

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
