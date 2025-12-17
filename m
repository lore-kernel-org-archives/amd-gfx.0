Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AA2D65C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 14:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA1A10E354;
	Wed, 17 Dec 2025 14:17:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ap6f5l3a";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EB5B10E354
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 14:17:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/YMce2iYU+LzLG7weshKYz556avpySAcfOPHcEVyt7cu6GWd9lP9r5ZPMYI5msVCPLD0oc8N8dr9YiWuGTVMRc9JGifMzzwPS75mllxEPJEAPeZza2Ij9UVhquxuMxdm68UmtjWNVanwrfFbLOy5Es90QyeFVJok5NmvV9TRl4oX3QXpfUPP9QiJmCBgXWNCQikilgXZFvQGQo0CDg1Bm/+UhAalqJhmgTZ769QrGIE298G2ZiZX7EZkfkH5UezAMzbnlNc4aTv+aldMIns3DgJZbmXSHlWQ87cjs4ufTUFAMrVwVYv6YHUOyhT5FmzwySbPDkXkc4AnXUrQqJaVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7xqo6oBfu3Jm3Nrcv3XH1ugBYKjkS0KDhxyYHPtw4U=;
 b=ofLRT1JePksh+tIqf2NH9LEzyXbvLLV3M/WEWXyb3tZb5NcrsDhneMWxiEIqRk3wJghuCcokXoLxul3eYfSMPFClgyA/btJ/5w36t8ernIFgbp+1rzXIUTww8WorrNt9jREAnpdM8EIPoF1muh+5wRB36bH7e+P+wscjUR6FGWwiT5C6LBni4nAtaZOJVtR4cUdcpOcA01SJRMkIh7KyQHOMt5MvkpR76lp29vk5u+2SO5wrQUcjfYQtEzWKcYqaz22wi3Fx/g9OvVtf2qKtzYIj+oWdF+s5Ro5b5q/TRf0Mu6OMNUnJkjDmviL0MhaFmPShO0mqJmCN8b6PQmoqKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7xqo6oBfu3Jm3Nrcv3XH1ugBYKjkS0KDhxyYHPtw4U=;
 b=Ap6f5l3a0SchzzGVFhsKAVRLbga1wpxsW6aPy93qPbSHrNcWyDH3i8kxDy4muicBFoJP74pwR+11LaibefpcsAmG4GtrtV5Pdk+kIChudXW9tZUrNCq4qZ92yNZaS/L0O+JiaAEZOVwfyCeQ2CmlddhuIPH7zDdEBTfCj4tHZvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 14:17:06 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 14:17:06 +0000
Message-ID: <18588297-a934-4e51-87b3-b2aa453f7672@amd.com>
Date: Wed, 17 Dec 2025 19:47:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: Remove __counted_by from
 ClockInfoArray.clockInfo[]
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251217140151.1984057-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251217140151.1984057-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM6PR12MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: b8458dd9-00ff-4636-ea5d-08de3d76f526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elM1dE5CUjNoUVJKdU92Y3JyUXhONzVXVjdtMzlaejVpSjRXaW1BcWhYcHpJ?=
 =?utf-8?B?VWwzZVRjUlB1NEttNk42Z0tYdW1MSTg3a01JOVpHU1NXSVhxdkVuSVlWZEJV?=
 =?utf-8?B?Umk4ZkhlaURNdFQ2STlQK0o4UEQ0eVloYjVqRFA4WStwWXBoYng5aU51V1ky?=
 =?utf-8?B?bEtkYWlsWGRtRXFWY3BmeGdrV2xJdkRPUE13ZGpQczd5enZXY0I2Y3Y2SnJF?=
 =?utf-8?B?NGpiOFoyV3FvZTBVaXJFQU4vWkVDZURtU3lxbWp2cDlWQ05idG5BaDB0VUl6?=
 =?utf-8?B?NXVReVVTTk9RdUdVL2ZOcHJoUVRjTll5MUJPOTh5WTFzMlYyaVUrbkZ2RTBI?=
 =?utf-8?B?cjUxM2xYQy9ZNlpNYWhvSTZEMFpKSVBEMWlURGIydTVlVnNsWEFDR1pBVDJh?=
 =?utf-8?B?bnVmbENna2d5ZTNRait0WWQ4T0pvYzh6VlJvUWk5Y3NVcEJ1bmpqY3drbzBs?=
 =?utf-8?B?Q2c2cEswT1ozM0FoVHVrR21DWDg1Vm1MWnpBbXRBd1ZxNnFWWnR1N2plQitL?=
 =?utf-8?B?ZlFmL2EwM3UvRHVaN3BjOXk5S3NEVVBjOVBsRzFTWjRxSmNtd3N5RlFITHVl?=
 =?utf-8?B?UWlldzdwcE9GZ29PZEVRUllYUVcxc0VsZHpwZ1Q0dWRISXFRc0JlNkI5UlIz?=
 =?utf-8?B?Wk9oalE1QWNMK3hxQ1BWcW45NGttUTAveEhKOEhaOVBHaGpFYXVnaVYzYnlD?=
 =?utf-8?B?TUR3cWMyeHkxMmxSMUJJdGRLOEZydk5uTTRKVlozdWtRZ29GN1Q1ZWY4bmdq?=
 =?utf-8?B?dVJSdndZdkI1clVDamREbkRqTGlIYlZaaG9zSmJZRlhlMjhGNmFHMnJITnRC?=
 =?utf-8?B?UU5RZ3JFa0t5RWtYOXlZNWFaUUljOU9zTDRBWFZwTmcwak95NkZzVUxnL0ov?=
 =?utf-8?B?STNxRWdpd0hFUTUrVGtFMG14TWR5cE9ybWY0QWxvb0NreExSdGs2V3JNWXZ2?=
 =?utf-8?B?MkRXM25LY0g5VDJFQnpKQTVNWUdiSnpETGFPZXlsbDk1N0xVYzl3R1drQXov?=
 =?utf-8?B?YnU2TjZ4dkNydS9yV0FPU3BsOHJhdDN1QmVMeTZzTHhBdkJGT3lsb2RhT0p3?=
 =?utf-8?B?a3BnOHpPWjA5cER5dmN3OC9EdTJ2UjI4NzJGVkgvWmZ4WjJublk1d0NYdzVq?=
 =?utf-8?B?NWEwY1F2UTQwb1ZvYjJVbW9UbU5VNEpQditIR25xK3AxNlBBRUJTNmlnbG9T?=
 =?utf-8?B?RWZwQ0QxY1BLTzBCTGhCUjNOSHVjeVJ5SiszV25xTFFOOTMvOTV3b2NwZFJn?=
 =?utf-8?B?dmlmZXlxNFlWdElieTB4aUVrbUJ3ckpYWVkyelB1TUU4aTJKTUdIdHZsVUZT?=
 =?utf-8?B?OVVhK3dYUnJTdDkyQkVmSnVyeDBMeEt0WjJrS2srYXYrTzFSMGdJUVhnNkJM?=
 =?utf-8?B?RlpudVgzWDJZV1FUSHI5Rm1oZlV3ejNHb1hpWUdmbU9GUURNeEZPT01za2tV?=
 =?utf-8?B?ZjVUOGsyRnVPRDYrdWNCRVVadVVBcEljTE0rN2VoeWdPczU4MFFEZ3d6ei84?=
 =?utf-8?B?d3plSHhRVzdUT1JvVW5NY3FoNVFZZUpzM2c3aW90YnhqbGV6WEZObTlwS3A2?=
 =?utf-8?B?dUhnU2l4Z2hOMVZOa3ozWWZhVUkxL0poby82aFZJZjNZR2oxeXM0L1c0bjBr?=
 =?utf-8?B?Q0VQVWt6N2xjUU4vTTFQL2QxY2RsU09ZV1Rjbk1aRU9Va3NSZElVVUNuYlZT?=
 =?utf-8?B?TUI1SUtIYXVjK2J2bjhIS3FQYithZ3VpS1d6REJUQ2Nzc0RNbnVEb1ZMTkQ2?=
 =?utf-8?B?SmtPVnZPYnZocnJnZ2dvR0p6bTYrYldVMUV2QTdvRVlCY0NaL29TeGZhUnNT?=
 =?utf-8?B?aVdzbDZidm5hSUE3SkFlNkwvOHpZSDNOSWY3amUwNWphVnc3Q0FzbjdYbzNw?=
 =?utf-8?B?QXRyZmpJZi9DNkpBak1kQVhvSWdabm5oNlB6dVhhNDVNeGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHFVc0lzeVRyRGErQytIbmJlcnhwMXY2d3EzV0V1UzRWS2QrYmdSbTZMUmlN?=
 =?utf-8?B?YUR1NnpMcXJKYStjZjB5NUZiVlMwT3NMU3F6bU1MSW5aRGhDTlMzREUyeTU2?=
 =?utf-8?B?SENDcE9XNzR2MFpkdm5hRUtjeFUraW9jRjRKSlFJWCtHeHd3ZkF2ZUFwRlZU?=
 =?utf-8?B?RHN2Wk8rZ1VFME50d1luN1hYYlNxMys5dHd0OGJkODZsckYycnJRVHgzTitj?=
 =?utf-8?B?Y2cwNGNuWCtsQUdUTDZ5SkFRYjdTU29GRVdLUWJBdXBJSm14Z3YyMStSTHln?=
 =?utf-8?B?VDFudmFGWnVFeFkxUjNWbjdUc1pYWEgvbElabkVaTXdZa1RFdmUwY2k5dy82?=
 =?utf-8?B?dHlISy9CbC9McWg4OERZaUh1SzhQNktyT3NHOWI1SUYydVFBa3lLdlQxRTRR?=
 =?utf-8?B?WmhqcDNkQks1VEFQYTM0SElSbW0yd20xa09ML3MxaWZ2bmhwdmJnWjF0Vjcz?=
 =?utf-8?B?Y3g2Sk8wRTk0MlNZdnRVZXp4UE9hV1dBcnNBN2dqc3ozVm9UbHRwdUNPaWhk?=
 =?utf-8?B?emYrSGRKcTZjNk1iWTViREpMTjNzUzJ2TjNLWHZsMkhDYVJucmQzVWdGUkZD?=
 =?utf-8?B?VjhoTzZ3cEtFNitocDVEb3l3dGtZUDNTeDlWZjhnRnBLaytrR2lJc21tVDBi?=
 =?utf-8?B?TkUyWFVpNzhkazZnNWluRFJlRXovUG82SG0rU0lLNUdXbWtEREVBTzlxelRH?=
 =?utf-8?B?VDU1OHUzdzZvTlBuVHp6eURLR3VwQi91eElONmFmaWdjVnFUbW40NXlpNk1F?=
 =?utf-8?B?RVZwa2FML29NajVUTlM2T20rdHFrTVNPcEVzUk4zdmpPTXlzWnd2OEhheWw2?=
 =?utf-8?B?cTdBaXBkVis5d1F0L0h4ME9GK2RYSGtjVG9KWU1tRWw5SjNrcDI3aVY1NjF5?=
 =?utf-8?B?MGk5UnRERVJFb2Q4aVpla0NDOVJ6bk1RVTlMNy9hY1I4UmlLejhhd0s5c0wz?=
 =?utf-8?B?dkpUeFJsVnpHYkJwL2FEdk1hZ25CTytNRTBOaVpnamU5dWNFTjdQKzV0ZVdx?=
 =?utf-8?B?ZzdzbG9VenpqbGhSYThtanJyWG1jV0hpcHEwK0lCTVp2TVV4eUxOa0ZaUmFy?=
 =?utf-8?B?V1Zjc1l3THZxbTdDWUl1WU1TRlZvLzJYcGFRLy92OHMzdkdOQUlCK0Yxb3Rw?=
 =?utf-8?B?d1ZsYlM1R2RTMG4ycm8rTkx1QjkxV0o2Q1JxZy9YZHp4dDROTXA1b0puWUsv?=
 =?utf-8?B?aHY2OVVmWUVIRkVjWXFiK1U2RklGSVJGL0tLa3UrYkd4R1JBb29pcFJ2VXdH?=
 =?utf-8?B?V0dTeDlOWHhJR1huTHJJMFhESnY3UXpuMGxqZ2Q0SHZXOGNMK3d0bThnT3Vi?=
 =?utf-8?B?cng3TU5RYmxkTFBJNmJ5TEs2THNzNndqN3huNEJ2YUVjaTdvWnZjK0NvS0NH?=
 =?utf-8?B?WWhQWnBndkx5c2hUNmRYOFhaeTdqSkhLYlc5cVhEQlFJQ2RuLzVFWkl5aTJX?=
 =?utf-8?B?UWRmSmdRK2MzdnNxc25ZZWF5MW5Bd2xUK2MyaDYxYWJidG9Ccy9HMHQwVlJS?=
 =?utf-8?B?ZHR1R1FvNVF1RVF0cmp4cEJjSFlmeTBoYks0Z2xibGRmYytaWTJKamJjTEd5?=
 =?utf-8?B?YUVZVzJWVmtLcEpjbHVodVc3RUcwZFFzbmZZUFhrcW9XU3RzY0JRY0Y1YnBX?=
 =?utf-8?B?SWdRQnRjSGQ1b0Y5b2lXRXh6WXNjbi9MYy9yZ0p6RFZYdGtGampxQVk4dVhw?=
 =?utf-8?B?WWxKODNYMExqczBLK2xTcTRBdHhWcGlzWjNPcWF0VldCeHhqeVZFRW1JQ1pJ?=
 =?utf-8?B?bk1UZGE4QlVoQmovdmJMbkZjRGdzdzUyTC9HUDIvdkVTaE9zN0NOZXF2Y3FN?=
 =?utf-8?B?SGxOeHJNOEpjSGxwdlFaS2xrZHJuRVRKajduYy9XMS9ZOWhPSWN2c01VamRk?=
 =?utf-8?B?UXRSdmpyMVpWdGZLaWtkT2wwVnpVZ2FEd2lEQ01ZQVJNS0hmL0tPdUNLOGpn?=
 =?utf-8?B?bXRZRzNuUGhabmQwdlorNjkzVjV6bkFlaDJOVnVwdUswTmxQTDFRM1Q5bUN1?=
 =?utf-8?B?N1hsNU1nc0ZDQzlraVc4NkNwRTJWM1o0OG1BbEszOTR6eklQVlhtOEFmR1hC?=
 =?utf-8?B?S0pab1ROZWNIMmhSVmxRb0lJWVJLUmEySmg2VUIvOEROWTVjVTZlQWxoSU9C?=
 =?utf-8?Q?De2jDDZWDNlgAImbnLWUzcX0h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8458dd9-00ff-4636-ea5d-08de3d76f526
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 14:17:06.2796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k41keAQdlHPqz7FenluNE1a842IGHksq52io1kYwPrucVISOhyPKaC4Nll5YI9R1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
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



On 17-Dec-25 7:31 PM, Alex Deucher wrote:
> clockInfo[] is a generic uchar pointer to variable sized structures
> which vary from ASIC to ASIC.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4374
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

There is one more -
https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/radeon/pptable.h#L463

Thanks,
Lijo

> ---
>   drivers/gpu/drm/radeon/pptable.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/radeon/pptable.h b/drivers/gpu/drm/radeon/pptable.h
> index 969a8fb0ee9e0..f4e71046dc91c 100644
> --- a/drivers/gpu/drm/radeon/pptable.h
> +++ b/drivers/gpu/drm/radeon/pptable.h
> @@ -450,7 +450,7 @@ typedef struct _ClockInfoArray{
>       //sizeof(ATOM_PPLIB_CLOCK_INFO)
>       UCHAR ucEntrySize;
>       
> -    UCHAR clockInfo[] __counted_by(ucNumEntries);
> +    UCHAR clockInfo[] /*__counted_by(ucNumEntries)*/;
>   }ClockInfoArray;
>   
>   typedef struct _NonClockInfoArray{

