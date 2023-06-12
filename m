Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A29C7EE25
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 13:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE8E710E23E;
	Mon, 12 Jun 2023 13:23:10 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 894D410E23E
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 13:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6d03inAM/4oNpF1AYXqlojLpK2HII8ngdazzN+CJuJeFTajbx16igx591996iZv2LMiWff2gxxal/dD0lOMxteFtwpzVXcypu7M9qeXfL4cpjmgEWRIB4lDtygSJvmg768HyccR21vTkFuu+hsXgve345p7Di5ulE3eHmMNU9VK0O+b7ZYia6Ll0VKLTePtWoVlpdgmYiL3E2S8h0jCCrjbwuxxKK3eIDjJcVkTLvI+pZH8AkDzBVDNZYiZtLGNpS3PYEsZc0O9PwPWRKFq2xUasJerbPVVi5eBbH4xv0/8cqC6DsC1JxqR5NJUaBEx0MBYMs+mvIO1aeahkHFJxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJuNF0TfOJP4eR56BRJyZats8ixsrrmvUAsw1iWNIVE=;
 b=c6NkcrnbTH7Vx27GH5PtVYP2/O2lbI0dpteQYVu+3383TPldaxQBt6loEJrQp69jKtie7l9OOSVSHLAWqfCOPtP/MitS55rVUe4v+ievMQNo0WhhTJXmzR2pd/Vt92jrtQBjXNmGEvtpn3k4uZOIUVg7MmWIEUoFrc8n/6pLxYzagHYS7//SysxGfdK5XLMtaEt9qNpOMa3Q/m3QzrNR6lb236G7yF1LP66C/krgYuUHuGcxhG/qM8WGp1cKJykUr3l2s2aAJ3Nn330K+icpxSjMJB79v+gE6Dnghy0CpPWiLtVyhiAWfn/MjdhjOLd/cOEx/LvJotrHD9je9VuEqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJuNF0TfOJP4eR56BRJyZats8ixsrrmvUAsw1iWNIVE=;
 b=x7Q2LkCGIfMqRrIOPscwh2/BfMTWXjVvOvNPDzCdQR19rte/4NRLrGllFrdDFawztr/83MQzrbvEtWTpJHZIBomt79mnnO+dr8VSLkpLmrz36Kfxf3pQZ5kPqRDNJbl2tOog7to6H4kD2fgdHMKCbycyIxGQ7OKnlD3f7MRokiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Mon, 12 Jun
 2023 13:23:04 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16%5]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 13:23:04 +0000
Message-ID: <d0bdadb5-c3fe-4a78-eb11-9e53086962e6@amd.com>
Date: Mon, 12 Jun 2023 07:23:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/display: Correct kdoc formats in dcn10_opp.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20230605051059.2101230-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230605051059.2101230-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0494.namprd03.prod.outlook.com
 (2603:10b6:408:130::19) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|CH3PR12MB8902:EE_
X-MS-Office365-Filtering-Correlation-Id: daeee9b6-7ce8-4bbb-4095-08db6b482765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ohClidZhAJgSkKJsKZ7ul3Cb1pPPBVTN4V7y0ksMz3T4glgbXarUdSyVT95n6cuB4d6pHV48efvYFp9rLFakfWNv9oIGtlAF3uxAa1wk3yj1gqQKs84SvghcFMK/37t8HvQhs3JLso456czLkSNauZNbHCPd9D39rE28iQNWMbYGkwUrLfq/D1sP7GhQueu+zi135bpP3HmiJnkUFooHtgmCCpSB7PQGn2Y9XBcubzJt8skJHYBP9pfeaEpL2PNGAxyve8tjVu3vQbdZEu8nrXUn4hLcXbw8OOx1riM0GsFMrgq9sUQQguBf2UPQXxIpZkXD/NqZpIE/brdg9Yl42xZPGaPAQLW3tVJsDIUVHXCn8wSaNXDPLfj3zHSpkbAgbKpLLuHdHbzO4p7xEzIT+cuAbrCoZoSN64WGaA5LPajyA0LxG5P7sb85GAQCC+H7WT+nUKAmMO3hwZFqPvuBbMmUc8jJ72V9Ml7igk1muibgm4kxwBuo8FTW+4omNw4dl81SbwotKJF4AZ5Bzfbp1MbrNybk1hX3ytNilUuow/meYQ3efqAqjU72NHoP46CBjtQ09NreV0zofwnRAr1/XqIWeom7cL3eoEC0B+VjdBpEYOyct59471L5oeLxC3uQpmv5c7mJ3qoyTW2+Z/0K+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(6486002)(83380400001)(36756003)(2616005)(38100700002)(31696002)(86362001)(6506007)(6512007)(53546011)(186003)(2906002)(5660300002)(110136005)(8676002)(8936002)(316002)(41300700001)(31686004)(6636002)(4326008)(66946007)(66556008)(66476007)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzB4b3lsalpRbHA0S3Fyd0tmai8wNTdvbERFRURaRzJYZ3MwMHNuR0RTZ2pI?=
 =?utf-8?B?a2RtR25LY1IrRW10MEsyampHVUh2b2RaL2F0V3Vja3NLL01TWFdlQXdTZXhF?=
 =?utf-8?B?aVdJeGoyQm1Pa2EyRWlWdHVJaytXSEx2QWJSQm9oNXhUZHBwRkgxT3NVRXBn?=
 =?utf-8?B?UGNvN3A3YVJObzdLUWhpWEVUUmhPK1hnbzBtQk1ITTY4RHNDTVhvSWkvVjVJ?=
 =?utf-8?B?RHBMT2xRQXY4SWphdFVPN1hBS1M5K2pseDJPUC9mbnkxQXhFblpBTDBhQWJR?=
 =?utf-8?B?eVpCZGdUbm4zMndkdlJlTVBQb2c1VzdqeWN5MEpESHRRcnJkQVh6MndyKzdR?=
 =?utf-8?B?YnduRUdqOWJVUnNrSUVEQmdzV0xSZXlreElxeFJ4VVZDMXhGSmxwQnFabEMz?=
 =?utf-8?B?aFBTT1dHU0hqYmkwR2ZvSXIrZUIrNlk0c0d1MTFOeVhkdiswTlpxZFc0aXoz?=
 =?utf-8?B?dXhZZHVPWXBYSWpDbFZUMVZYVGxKbHo0VUdKc3FLbmtMWU1rdTFHUUVtdGVD?=
 =?utf-8?B?dnFENE1Jbi8zZHVKSmhBNmRMREJFTm1MbkkySitvMWJ4VUN6RmYvcGl1ZWpn?=
 =?utf-8?B?bUMvSUsxcG0yWlgwSTdPdkd4cmE5bjFXQllEUllueGlGckJyZktuc0tGakVH?=
 =?utf-8?B?WUtad0NyS3hQMHdML3NZbUYzZ09Vc2N5THRwUlJBYlNyQm54TENHRUVYMmNj?=
 =?utf-8?B?eUhVRzRlZVdaVG5LZTAvN1BrVnJEWVRGSHhmRVRoUkNheUN0Mk13dHpuNWQr?=
 =?utf-8?B?Q1Z2b1ZKNUZuZkdIRXJTc3JmZFBaOHIyTG9iNDJ1TUhGVjVlNDVNTU94czd3?=
 =?utf-8?B?TUxnSkhEWnVDREUrMU8xSjBNd2RzNTBWTkZaL1J6WGdkSUNrWldnTzQ5cFlT?=
 =?utf-8?B?SjVoL0lFWEpVWHN0NDZKU0VOcEJzMC9mQ1g0S200YUhRUW1UM2tlUTU2TDdH?=
 =?utf-8?B?R3M5Ymg5aEQ5ODNaelNYN2c2OERHYzAyQnRCN0plenZIM0VhMFNUN0NRTjhT?=
 =?utf-8?B?UDRYaHVsdFJkVCtXRE5HbGMvWGNRSE5EVkVzQzQ5eldpbE01ZXhnQWFZZG9X?=
 =?utf-8?B?cVZueDR6clZ2cTEzV3FGdTc2L3I1d0hsYzhybGtOSjZQWi9xdHBzYWtKalA1?=
 =?utf-8?B?K2ZrTTlUQXVqQk1XaFhkVlpFRC9JaHRaNUYzNy9GZEpLMlJXK2NSWWFFaElj?=
 =?utf-8?B?N0hKRnFYSFRNUVZDZUFVcUlHY2JMZjRGS2NPZlI4K1h0Nis4ek9hNmpLbC9l?=
 =?utf-8?B?MWNXakVNMlFuMVRyOU9TNlV0MFdRTVZyV3NibDB2ejBqSzFWQ1YyL053UmNS?=
 =?utf-8?B?ZWg5dHFXL2ZmQXBkaHlydW9CRTl6bE9qc0NBL3FHL1B6L1VyaXQvMG5POHdQ?=
 =?utf-8?B?K0l6Y3QwZkZ6eEFXQUdCN2hqQjF2V1B1WnUvVm44Zm9yczJEbFhKMUVCVDlO?=
 =?utf-8?B?dWhCdGxPTFM3cUhKN3g2TGplR3JSOVk5aDN5TzVqSTJqVVhnTzUveldGWUlq?=
 =?utf-8?B?dWFSVG1lUGVwSXkxemZoUysrRmNBUHRLaTV0UjcxSERRT1ZGZ0Y1VFRjK3M3?=
 =?utf-8?B?K0hFRzB5K21ZMThIYjFNWUpJQ0NSVkk4WlVvQmV6WXcxSGZVbmRyb2ZOdGVE?=
 =?utf-8?B?R2ZvMUg3a09LSFluU2I4cFpRcGlQaDc0SC9HT3VoT014S3VRQkNzOTVZdVh2?=
 =?utf-8?B?SUZnZkp6cEx2VUVobmlPMjJhZGNtTHMzMmhZSEhGeW9xV1BRUUZ1aGhZYWtC?=
 =?utf-8?B?T2h1eGhIS2Rmckh2R2dQYk03NkdPK1FXRGR3dlRyQ1p1bk9qdjQ4U3JRNndv?=
 =?utf-8?B?Q09KajVtdUJMQ1FpZEhvNmxRQk40MlkxQ1BnUTR3enJCMVlKd2x6cUZEOEh1?=
 =?utf-8?B?bkdXWnYwMWlOMFhBOHphOVM1TGRLdjZRUTNYQjNNakQzNitNMW56VHdvb0Q4?=
 =?utf-8?B?WmVNUSt1YTJabGk2Z1BlSURGYXlFV1UxTEtUSG1Ea0VJSzBwS1MraC9sSklm?=
 =?utf-8?B?SWJkR3hFQjlvT21mTlNwcjlPYk82bzNtUFR3ZXZKaUZHekh1NXQyZ2pRUE4r?=
 =?utf-8?B?Y2c4c0dEc3lmTjJBM1krczhheWZxODRPVFQzQ205dS8veTVZdEpVdWZPTFNk?=
 =?utf-8?B?TURjREs5SzQyejR5citzVENpL0ZLdFN2YnVabzRSelhHVytuTlN2SndJZGNz?=
 =?utf-8?Q?aBTvAaCXj6Zh0rOX5Aa4HNTuvylpbZ6npNn32IP6JVLT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daeee9b6-7ce8-4bbb-4095-08db6b482765
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 13:23:04.7134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1g22tk5avsg5OZmTw+7/F/s9gz04E2Lk/pIPjvUiMsEXdx7jeKHkr/LzY7//Ybcjs/+A38swfiwV+vsONGi+9g==
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



On 6/4/23 23:10, Srinivasan Shanmugam wrote:
> Fixes the following W=1 kernel build warning:
> 
> display/dc/dcn10/dcn10_opp.c:52: warning: Function parameter or member 'oppn10' not described in 'opp1_set_truncation'
> display/dc/dcn10/dcn10_opp.c:52: warning: Function parameter or member 'params' not described in 'opp1_set_truncation'
> display/dc/dcn10/dcn10_opp.c:52: warning: expecting prototype for set_truncation(). Prototype was for opp1_set_truncation() instead
> display/dc/dcn10/dcn10_opp.c:161: warning: Function parameter or member 'oppn10' not described in 'opp1_set_pixel_encoding'
> display/dc/dcn10/dcn10_opp.c:161: warning: Function parameter or member 'params' not described in 'opp1_set_pixel_encoding'
> display/dc/dcn10/dcn10_opp.c:161: warning: expecting prototype for set_pixel_encoding(). Prototype was for opp1_set_pixel_encoding() instead
> display/dc/dcn10/dcn10_opp.c:183: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   *      Set Clamping
> 
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../gpu/drm/amd/display/dc/dcn10/dcn10_opp.c  | 20 +++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
> index 41cec7acf51f..0dec57679269 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
> @@ -37,14 +37,14 @@
>   #define CTX \
>   	oppn10->base.ctx
>   
> -
> -/************* FORMATTER ************/
> -
>   /**
> - *	set_truncation
> + * opp1_set_truncation():
>    *	1) set truncation depth: 0 for 18 bpp or 1 for 24 bpp
>    *	2) enable truncation
>    *	3) HW remove 12bit FMT support for DCE11 power saving reason.
> + *
> + * @oppn10: output_pixel_processor struct instance for dcn10.
> + * @params: pointer to bit_depth_reduction_params.
>    */
>   static void opp1_set_truncation(
>   		struct dcn10_opp *oppn10,
> @@ -149,11 +149,12 @@ void opp1_program_bit_depth_reduction(
>   }
>   
>   /**
> - *	set_pixel_encoding
> - *
> - *	Set Pixel Encoding
> + * opp1_set_pixel_encoding():
>    *		0: RGB 4:4:4 or YCbCr 4:4:4 or YOnly
>    *		1: YCbCr 4:2:2
> + *
> + * @oppn10: output_pixel_processor struct instance for dcn10.
> + * @params: pointer to clamping_and_pixel_encoding_params.
>    */
>   static void opp1_set_pixel_encoding(
>   	struct dcn10_opp *oppn10,
> @@ -180,13 +181,16 @@ static void opp1_set_pixel_encoding(
>   }
>   
>   /**
> - *	Set Clamping
> + * opp1_set_clamping():
>    *	1) Set clamping format based on bpc - 0 for 6bpc (No clamping)
>    *		1 for 8 bpc
>    *		2 for 10 bpc
>    *		3 for 12 bpc
>    *		7 for programable
>    *	2) Enable clamp if Limited range requested
> + *
> + * @oppn10: output_pixel_processor struct instance for dcn10.
> + * @params: pointer to clamping_and_pixel_encoding_params.
>    */
>   static void opp1_set_clamping(
>   	struct dcn10_opp *oppn10,
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
