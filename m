Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB6DC07E9D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 09:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDF6810E65E;
	Mon, 26 Sep 2022 09:39:00 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C2A910E65F
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 09:38:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G77Zg42O9CnYA06hVJSasQZkEoESEGv8yyq4kawPq7BPfsdTZYYSOVk4xszujPkI1JhuGHMTpQV/MzcWjTz5WEcGS2notvnN7iuIGAnkJsH15gLBuEnsNZwJ11RBcMOSD1plyCzOtfRv+voucqQDWuyDvC2qzmrcHx0wIlHYIQmetaD2al5BdvJAG6l2fFYWjfMgBSGAdUDtzqeeTVrPV9J5YPBJk2rmVEO9E+sfAucoG20fQ2lxSKuGGJKSr5+737mgTCFs2DYyTSvpQQRcBq/gHKUQkGvCgv4IdvqA1T47rJaBUN8YnFKcCCbI8dleR+979Dvay028iG9WhrPu3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaQrG9DfvdtNYcqP8pQRjXxDwYSu3mWLHjfj3A3asoQ=;
 b=Lqj5x1mNK0wMA1ku/qgq6oH23nqZ0pLheylH4GnI737ak40EydXAps1nkwvN3QVeFVJhOkHELl9VZ5HSvTIs86T9KkNmsxuD++1oRIwVOCjfMEUiIo2KvbCVOhP+OKeggKwzcL/OlV7jaVWZ0hOdz8V9o/FTbn3Sb4Bdw5gDHXb5DzbOkwBeAhaXOyYePBjb+Cbtoryl2puhDfdbLuUrx0BxECr1K77wE0LBC/5Ov8YrZPHPH+r6cvhVQqSZ1q5DXqAXA8iwQGJ0WwBaAiLy8jJSjysDmTf67IawhnL1XknQl3NVB7lJ5SohgWHAtV7mK3NDSHC80M+xjFaIAGqYGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaQrG9DfvdtNYcqP8pQRjXxDwYSu3mWLHjfj3A3asoQ=;
 b=xi7sX2yxDaktHteXnDjp1BSRSh81ipuA9PWrdvPrmuKwLFzg1o9RfRdvqqqzzRGvri3z0aMh8Isqmya2+T3yQcpYZ0xvOyXglAYjMtG0bo7NUe089+R3a8jCjIeNUWvj33567vgv8bZsmFW+zunFW2L3gBzS4U46i0J8aYRMeRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 09:38:53 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 09:38:53 +0000
Message-ID: <5236aeb9-490c-9f42-b5db-251717d69065@amd.com>
Date: Mon, 26 Sep 2022 11:38:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: fix a compiling error
Content-Language: en-US
To: Asher Song <Asher.Song@amd.com>, Dillon_Varone@amd.com,
 Guchun.Chen@amd.com, flora.cui@amd.com, yuliang.shi@amd.com,
 jun.ma2@amd.com, amd-gfx@lists.freedesktop.org
References: <20220926092226.96988-1-Asher.Song@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220926092226.96988-1-Asher.Song@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: d5229791-576a-4af6-c127-08da9fa2ec6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EjuCTS0Mv7dKjUiLd3rS/fvmc3S8NvjIOFLxsQOVPKMOrSWzfuUZOOP91D0goVZKVZYifSvmFoj+iNuI37FntJHZXAKxqv/eS/U0uCLwtUQ/8hBQHbT7cx1apw2RIFKsxhgfvcfHJ6neYIAwCso/wxg2wdV2112iew62TLdoUj40Twh5rFn6i0DROy9oqSz9s9i38fgzP9lg5F//UZQ5ODUCy+3xV6HR3vBpNkPa2cqkFnKVeLSy2/7IXg/R+OAYi+thItbnIH4oHrYpumFatbLsfyzM6l6HxsxgFqk7CltPC5y3U4VAmcy/IXfb2yQ2RH6qp7DN0kMpcikzDNER0olVQkMmC4JMCbFxTY5birnEkMBAwrf4HqOSM8Uj3kj3oga1ZjRvh+bn5tQRAKY2GxogioBhKzyzUOFFmrZQzV/HlqQxIRna4ML+aF6ePKaL45b00kQ/yL9O8BfdeyikO3BkiYEU31yLv7OKCToSARoACbrLIIFoWh79cS8k5YlCvRsx3GXovBCUw1Q4IPefRqZtl0Q8RDrxAP4ZSoEosCJm0ODFvOF/lycXGCN1aSzjAyfJ97zRHfaGGYc4/gUfC/ImL1kXu0wEtAKCepnQPCrFnte2rtbvLfa/FJ/KThs3xHykIMGhW3ps2SaLnFScNcBp0COtJTTSnBtEcH73+g7lRhGBkv5KMTsb2qFN1z9WtK6rLBM2lPe1R9akpzl6RsvdRMe7TGGfu6UsGRkcKa+VofcBtyMvzn/8ZJFLKO+DHRmldHZ+StYx9rBdUHmDumj9DCMgEgUWzO6HV0mtOog=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199015)(316002)(31686004)(31696002)(66556008)(66946007)(66476007)(6486002)(8676002)(86362001)(26005)(6512007)(8936002)(83380400001)(36756003)(5660300002)(6506007)(41300700001)(6666004)(2616005)(186003)(478600001)(2906002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0Z1dnF3OTRsaXh6OVpSb0pubUl2dGk0NDFnZXNyYlJBMkRvSGlEUnlUYzlO?=
 =?utf-8?B?WVlRdzkrcGFZaitSMFdsR2R6eGNGOWRiRnRBM3JyYzNDQ1ZSanhFNnRlVS9T?=
 =?utf-8?B?ay9NT2cwSE5HK2x4aUw5OUtWMTgxVHRoL2E1WjIzSzNIelZQN2Rsbmp5Nmor?=
 =?utf-8?B?Q2pTUWpveXFYaWVnS1dDdzQzR3lITW1NLzRnQ2tJWTJVSWljYU5SWFk0eXJC?=
 =?utf-8?B?WmVxYUdwcXJKb0JjbTR3eW11VDk2YmJrYU43eWFpbGR4SkFtSy9Uekc3Z3Uy?=
 =?utf-8?B?dkVZazZzeWVQa05nSFVXWEdnYjVSbGhaUjZzTG9xb1hLNm1WaWpFcllVZWx2?=
 =?utf-8?B?N2JxSzlSL3ZpS2hObTJYUlIybVlsbHNlRUNib3ZlTnJwRFExbzEva3BSQ0gx?=
 =?utf-8?B?TnJRMXdidEF1WiszcWh3bXNNNy92SmU2ZFEvTVFGdndEcTQvWHFWYXRJZlFs?=
 =?utf-8?B?bXlmejZOMjFXWFk1L1cxMmJOcWpuZXZ1V1p5VDlSZDZqTlk1SmVPSXV3MjhN?=
 =?utf-8?B?bjNlQTE2aEtnazd5ZjZtK1J5NDVVWGRIcnIxT3pKeXlXN1prTlpRdjBlVEIx?=
 =?utf-8?B?TUdvSDFtZUdVY05YUFNzUHFadWZIUld6ZU1oNlBhTEdHWTVQV1dvbWpXeFRn?=
 =?utf-8?B?dlRFYllsVmlJT296dVJ3anFqL1I2OFZySm9jWGtWUEtrWFh1cVNGMDlOWndM?=
 =?utf-8?B?dHljY0JZMDFVZzJyeGpSVzI2d20weFk4NXI2eDQ1eWwrL2M4Mlk5WG9hMDlS?=
 =?utf-8?B?Z1BESkY0UGhoQThGOEw5Rit5eVBZN3Rhb0t1dk5meEwvdXNnWFJ0RWZqcmh5?=
 =?utf-8?B?cXZtS1gySWxUdGt5cjk4SDlSZ25jNjhheHFYMThpaWVNMHRidkx3bUxrUGpY?=
 =?utf-8?B?YUFSSFE0MDVGRUk5bEo0Y0xscmpiaXRaZjR3SGM3alk3VHMyNnRJQVkrRlFC?=
 =?utf-8?B?MGdxMEY1QjdRTFpVN2VLOFRGV0tGVkc3Wnc4dFhpY01ZbGJmOEpDejJuSitM?=
 =?utf-8?B?SHJrMW54SWRrYnJJNWlJb1QrZ0tBbGlzQzEyTWtQOFF2T0JXMzdteW9Rdm5Q?=
 =?utf-8?B?SW5QOExzMHhJcnZIN2pMeDBoWS9LbThIRHNtRzFqT1FnR2krdm15NlQwT1lX?=
 =?utf-8?B?cVBiQ2lTR3g3ek02VXpEN3o1ZDQ1RmFTcDlmNkoyQlJLSklLcFhIR3B6T3Jr?=
 =?utf-8?B?elNDVENBQTlvOUNwdDVHRjIvai9Bc3picUFsbTNPYzZMcUJ2aENFNEdTYm1G?=
 =?utf-8?B?WlpvTll2cG9tY1VrRWdKc25zSE5zZlkxNlVqODR5YTlhSjJxYmFqaVBQVyts?=
 =?utf-8?B?a3F2L3U3dVdCUklzMjVxLzhqMmtGSWlXakVVRzZMSFZCcEFQWHlhZ0gvdGU2?=
 =?utf-8?B?SE85WDkzOWRnOVdwVEpXdVlYSWttVG8rL3cvakIzNFNNMDJWSGdzY2lUUEJh?=
 =?utf-8?B?TElvYTdJaEpkWWswSTdQZXJCZDJqMzhHQU5TSDE0REY2VDZQS2pteWpFbzRj?=
 =?utf-8?B?eE5xVUFBdWJPcXdndFhwWk5IZWI5azZxenlRdDFjaVY3NGdzRSthWFZOM01H?=
 =?utf-8?B?L2pkcVhrVzNYM29nTW5UeG1ldGcxS2JWeU1MZWE0ZHFWTXAyMExpNVlIN0U5?=
 =?utf-8?B?V0pmZ2N6TTRuaTlybi91TWhNU1FrZ0E2Ry9wV3ZGMUhEK2ZaSUhuVWYvNEp2?=
 =?utf-8?B?bG1KQkE2Z3ZhZENqRFNGYUNMYmZDRzY0WWFKTFNuS2ZVUUlVa3cwR1RDT0ZR?=
 =?utf-8?B?MkgvbTNZaUJhQ3dYYXNzemFiYWJHS2RzYmpkUzFFWitscVJaZVpvcW45cGl2?=
 =?utf-8?B?OXBnUlA1TktIOXJ0TEJEQ0YwK3RRV0FtTkpJWlJmZnNtL1hXSFhPQk5zemV5?=
 =?utf-8?B?Qzd1VGhiVzlRa21NUXFKSFduc0RMOHN1U093cnovQXdjV21BQjFONlc2Qmh5?=
 =?utf-8?B?azdQK3I3ZjFsbFdvMjVRZzhBa2pqV1YvRDJLNjdjTWVFa1pjYi9tZFI5bVRF?=
 =?utf-8?B?RThDWXBRcXhxWnAweVdTTEVhejVsS3BNWWtWMlZHc3NHckZyQXVFL1B6MHB2?=
 =?utf-8?B?b0JPc0F6RFdzNlc2WUhUSHNNYnRKOFFITHFTOStuOXhxbFFBWXZ4aGZCU1BO?=
 =?utf-8?Q?WRqpFTnaid23VVlA1ZtnalI8/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5229791-576a-4af6-c127-08da9fa2ec6e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 09:38:53.0295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sW1xphQYjEE66h+QfcHW8zIDTcdipyhngwpSXDXzR2lRuuRZnrTmEo/WyBy+RwAz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
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

Am 26.09.22 um 11:22 schrieb Asher Song:
> The patch fix following compiling error:
>
> error: ‘for’ loop initial declarations are only allowed in C99 mode
>    for (int i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {

Newer kernels are compiled in C99 mode, so this in now legal.

We should probably still fix that issue since we often port back things 
to older kernels.

>
> Signed-off-by: Asher Song <Asher.Song@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> index 772ad200c5da..d58c5085600a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> @@ -1405,8 +1405,8 @@ void dcn32_update_dsc_pg(struct dc *dc,
>   		bool safe_to_disable)
>   {
>   	struct dce_hwseq *hws = dc->hwseq;
> -
> -	for (int i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
> +	int i;
> +	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {

An empty line is required between deceleration and code. Try to use 
checkpatch.pl before sending out the patch.

Regards,
Christian.

>   		struct display_stream_compressor *dsc = dc->res_pool->dscs[i];
>   		bool is_dsc_ungated = hws->funcs.dsc_pg_status(hws, dsc->inst);
>   

