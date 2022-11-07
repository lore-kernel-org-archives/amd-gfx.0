Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B836C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Nov 2022 14:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87FC810E36E;
	Mon,  7 Nov 2022 14:32:22 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F7510E36E
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Nov 2022 14:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjjZiX29+vTGfIccY1A5UoFb24+B/toL82kaVGsoN7a98RouNfhgGpYRSVwd719TcDjOl4b+QYgXuN3X1bhGg1xLYxA/iVcrAaz4cXizzvXV+mU8e1YU1HfEvzhVcpOOEKGnpMcaRAzRBvmcFtRPwXLSDpT9SSNn/6qqlHTXzOKF6nR8vzOeGEGNLa/FqH2TfAy7W7TKvI9zp5eXOIyu1hQABzQwgMjNfGwZHqT4TCkvWgSU/YAkYjbTiRYKb4x6x6wky9bHcoE78kvmqwzSt6wLOCk44MijSnJPgb52xrvouhzB2kQ5c+ejN9UDWDfL2GFzhSJ31qdy7LBXNLfx5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrBGYtatjWk1s19F6yvFtUHLzl2FVU6rm2IhBjTs7iA=;
 b=ZLnCcDFuLqGZ3cwULc6n5+HzlBJ3LYqOEjsuqzjHHRD3gFt3/3qPntFjJcAlNgNI+5JRNQ9N68eXd3x4e7HYcPbSJ2wDa8nehqG4jTbEEMVxthMEHo9JGX/DqvXsiU55S1PCM9EKbzr8yFQi6QVnkzgzoFHWAvEq/TwBtstZ4lW41uU5r36r+O9FvutsxdxSvquFoqQRbvzD+cvUZXvGWWrUckFDHYuz7XLKcT4cDRon9A1JnGugZcf8F8G1GbGt34I0vVMzJ2o1G/ZE/Ru9WoieY6z+I2POMsao5M2fmtABfNr2piDKsmqNWEwKbOClCOaZFx/s3+zhEt6y2yFRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrBGYtatjWk1s19F6yvFtUHLzl2FVU6rm2IhBjTs7iA=;
 b=lXGO1Xm0/kx5qU2iMkGQToSMsJ9mRTFCQFN6SWky/EDyJfnuN7EIEFuuUPDWpBV34dQdHbiQvrhrBVunmxTbx7mv07o3p8vLHAk/RAXB92bNqpGfKCGptPVrzGImPaL+F9gAktd3Oa5f7HGB6FkyE669V/k6W8T2nooM72XIH+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 14:32:18 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 14:32:17 +0000
Message-ID: <2874fb08-3e61-f0e9-1330-5686e8497390@amd.com>
Date: Mon, 7 Nov 2022 09:32:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdkfd: Fix the memory overrun
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, keescook@chromium.org
References: <20221107070806.1217215-1-Jun.Ma2@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221107070806.1217215-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: c00bccd8-7d60-4a49-a98d-08dac0ccdf1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6p3Fdf2q3EFs0bwTdzAd6LLDOBESjqDcs5P0FcWoH9ofKTg9aAkqNhYcjss4gLpVTZXK985DH5EkJlQ5dYA7sjZN34Eoc3Mg7+0XTX1yfwaBpwSXM1Ep+rs+7E0Ai4+HaD8BtH/CuYW1p/fqid8W8zCLtUJMAxsvMySvek0iSwRo1nE19MBe6AD4nI3dx/sjixKrFknNcxEfvgrB0LSWX1hdq7yoAYd58zA1wGo/xx1mEicijw1bTJB1QE5rrqmX995s/Jopv3413ZNo18BdNmD0Y4ooxLAgRqXJ5S90EUGWQZa8P7CNYXK6LlqavP7k5EQpTakWJoAgCeTiBs/cn/g8MAPwAVz7S/2qX5V2xFs7tmX5z0XWTD6sA+ul3ilkvbeIxEYeW9JWpoDpdrT0UP0PuHJ+JKrPfMVitN42Kkaj0SCoxLaGT+ihhmMqa2QimhcgLg/2a1F8ip9vohvGBO9vnMsfppd3ydb1eRBzwBBkX1hiG5mlcSrcy+4acbGUYXpZV7/TcRaWLo8KOxlZP/zGn7X9E3ITR+hsWejeseaqB9/27yLm7t9MSX1bTft1b+9qKO1RxSY1FAyZEMDNykVl3dALKzrhRhd9hBSzEu35vtHyKsLejt1S27zNMGP75MYzLZxsEJw+n9uoLlRrRfzvgWBgWpW+KhccNpvlRYbthFWfx6KP5EdbBeesYVn2G68lzw4j6zLz4yRMPQ4QUxFTCpV1orQ9rrgqjfBKka+FY+GaEVRVEMEBLtuqH/F92IV2NXB/tW4xDmhDe7p27Usr9ggGOd67teUK+hLjJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199015)(36756003)(31686004)(86362001)(31696002)(2616005)(83380400001)(44832011)(2906002)(6512007)(6506007)(186003)(38100700002)(26005)(66476007)(66556008)(66946007)(8676002)(4326008)(478600001)(316002)(8936002)(6486002)(5660300002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aERBeSs2THMxMkdnSVJoeW1rRmwycWxLU0tGUjc3aWlrTFBlUkNMdmZvL1NV?=
 =?utf-8?B?eU4wOGhrVDVHbFF4THpSd2ppelo2YnZrYit5RG9TaXdDUE1YQlpFemJXbUQv?=
 =?utf-8?B?THh0czk0VDlnSjYvRWYzVEdQVHIyY01adkl0dE5KUHRLR21ZTTN3My9OVm5q?=
 =?utf-8?B?WHJya3hmbVNYT1RkcTJ0SjBQLzVWZHh6djhuT2RmTlJTdGV6NXAxMmZ4TDZq?=
 =?utf-8?B?QzJDUGpQclg0OXAzQzlTcmJwOHV5dFY1Qy9vc0I4ZjhjbnNNREVQS0JJOXBr?=
 =?utf-8?B?NzEzUG5yeXp5YTlTVjVhNWVRNm1majJGck9iZHlHSW44c0hsc1hYWG5aeVBI?=
 =?utf-8?B?M3hIRWJhUHpMa2MxQUNCVVdMVnVxTzFhZGV4V1JsZUhmL0pyRng1SXNQZ2tv?=
 =?utf-8?B?M0pKdXFySVRMV3BiRmxUK0dWOEs3MGl0bWxUZ3ROVCtZc3ZSYiswT1hxK0JP?=
 =?utf-8?B?N1JsK3JOUE5Mb0RaTHRkSjdSeWQyOXpjcXdBb0xOQTd1TWMwWG1LckluMHUy?=
 =?utf-8?B?UWowVUNSUEM4M0ZQSE9kcVF4MVRqSzZpcC90ajZxdW9paDYvUGdiVC84ZTNm?=
 =?utf-8?B?ZE50Slp1c2VYS1ZGVkcxaEovYjZ5bzZKL1NGS2s1aW5IdUZ4VDVQVllYN2d6?=
 =?utf-8?B?Qng3Qk9POXEyYnFTdGxqcHdqY1pPcjN3dUI1d0ZaUFh0MkZyWEcySEo2LzI4?=
 =?utf-8?B?NW1jWDJRK1FUUWdoYkhIZW5tdEtFQUVlREgzczJPOENQRWt6Wkx2YkxjSXNR?=
 =?utf-8?B?dEJ6UTBvN0pzZzZvaHhTKy9FeHdnZ0RwRFVEY2ZmSFNTeEQrcHk3MDF4SnhJ?=
 =?utf-8?B?RkgvSCtwZnhaYTFZTGNweHdPMkZ4UWM3SDFHL2poaXlJMGJyZDBZK2g3QzB0?=
 =?utf-8?B?ZWFsaXJZSWZONGY5KythRTY0bjhieTlLWHdOVkxQRFk2dnRhb012VnhaYVBG?=
 =?utf-8?B?WWJRN29IS2NpeUhxTi9jTzN0OERZWERnZnFaTTYxbHEvS1dvOEpnZzNRcmZB?=
 =?utf-8?B?L2FObXEvWmNrY2lVc0IxejRBUzRyay9TZWpYV0hPWGhtUTM1Y0U5OC9lSlNu?=
 =?utf-8?B?bERqK0ZIU0JwNTE2d2Zla0kzOVRFVEhhRVFMeldvWEJBbEtxb0ZpQVRHak5G?=
 =?utf-8?B?b3oyTWJVaUZvVkdoQXpaOU5NZWVOU2NLNWFlMVo3bTRlcDRVc0FkWmpSVmlm?=
 =?utf-8?B?WUx5R3NLMzU2aXM0ZHo0Q2ZyaEtHYzNqa2xJeVVoYk0yUEFxczNrTGRjbFZw?=
 =?utf-8?B?clJhUXByMU9JdERQL1BBT3NiZDZKSDFacjRRUmIyNGRra2ZoZm11VDRsVWRE?=
 =?utf-8?B?dXlGUm40UU1acHFLekdOeWwrYTJRY25CT1c2Wk03VDNmRjF2ODBtWGpNUTUv?=
 =?utf-8?B?aWp2L2pickpNdkFXZEw0VDlWYVROUk9SWTdlWVhPL2V0WGdiSnROTnBjMDRz?=
 =?utf-8?B?STJ2NDUvWHdrQXljVmRDVjVteVMrYXVVS1pzdWlUdmZSemdJRjd6S3pVRW1s?=
 =?utf-8?B?Sjk3ZnVYRTV4K0J1THlvWnZuZnJXakpuVEZZQWhaeHJZOWlvWldNTElwbEFM?=
 =?utf-8?B?Y0krc3V0c1JaZG42bFJjMlkxVE9hRDJ3NVQzNVM0Z0tNS2lVK255eElZSHA0?=
 =?utf-8?B?ZEpDSVp2MjhaWnV1WXRiL1BZRkJFL0RmQzJCU0x1T0ZhcmJRYTRaSTN1VnZP?=
 =?utf-8?B?ckNjYVJnL21QU3AramlmU2d4ZWlqRldKVU1QTGhKYnNLMVdjZ0YwbXlUZmJL?=
 =?utf-8?B?VTNldE9UYjZyWHdSbHQ1Njh1VEoraHVXT0hxSmYzYWxPd21sK3JwS1JVeERL?=
 =?utf-8?B?eEVVa3crc2VvZTJFM1hJZlNzVzVHbjhSQ3plYTAraXI2TEFDNU52RmZpRVh2?=
 =?utf-8?B?OXhlbUI1R29HL2dYSHRySTRNcDV2ZUFvV0NYdkRLbG1NRHhnRk5mV0gycW9a?=
 =?utf-8?B?VTMxNnFvd2RHV1hJVUJEb0xXQjlLd3BSbEpuNEJUTXE3VHpDNFZEUmJHYjRF?=
 =?utf-8?B?SmFWUWFBeVc0OTM2ODZ6ZnJ3N251Y29xMzh6Sjc2WW5jdTBhMDNGdG53RlBV?=
 =?utf-8?B?ajFvd0RmMVIxN2swbFY0TThWL1NKY1kzcVBkWTkxWVUrT1g2bSt5OGJuMlN5?=
 =?utf-8?Q?TI3k4Bo/0VKftJZLg61bqWglY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00bccd8-7d60-4a49-a98d-08dac0ccdf1e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 14:32:17.7411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VnOYEKuD8MDlitOpl9uJCzzJN90C1lOhRuH+PGnqLYqG9Bga132/riruoPlLXlQKf5PuUv1/Mp/wTJux1IEnAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-11-07 um 02:08 schrieb Ma Jun:
> Fix the memory overrun issue caused by wrong array size.
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1527133 ("Memory - corruptions")
> Fixes: 6246000093863 ("drm/amdkfd: Fix the warning of array-index-out-of-bounds")

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 7029e3bdff3e..6e81f50ad912 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1111,7 +1111,7 @@ static int kfd_parse_subtype_cache(struct crat_subtype_cache *cache,
>   			props->cache_latency = cache->cache_latency;
>   
>   			memcpy(props->sibling_map, cache->sibling_map,
> -					sizeof(props->sibling_map));
> +					CRAT_SIBLINGMAP_SIZE);
>   
>   			/* set the sibling_map_size as 32 for CRAT from ACPI */
>   			props->sibling_map_size = CRAT_SIBLINGMAP_SIZE;
