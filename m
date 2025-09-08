Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB12CAC586
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 13:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C53210E051;
	Mon,  8 Sep 2025 13:20:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gVIh+0Lp";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2558B10E051
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 13:20:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6snLah+dNO+NseK5fEIs1T7DyXBsa2J+xNjXQLfI4ifyJ1SN3975u/BiixklFR7ws0MXDiXKc6WVOYyAyuJ9g77DezofJ2YA39R8Q4wh+F46qKRCI6QkzWNVEiKaJSZCruzq29zyGb8WY0dAAJzd9tFU/Z5L7SR6upRMJMT4aFzLpoFxdSVRoEp78dyluuhAovX5TX+MUTU1pZ19AcwTDs8D0Clgv/wNO9NgpYkM9RPPog7We8W815/OSaaVbKSu/EyR0JW7IS350Z6CHwXI3fVXmdpIS8fM6VBpKZl+foAG0NlGonUMTqEyhO0Vf1pSYg2uBDcDwY3Y2U14758Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AMWXZ5MA7rg310O8UFWRu7dkLy4KwbP6BRb6Z8GR8c=;
 b=lFa/a5M1+IItFKrA/eSPF0uAhbMbnbfKYZ/k5tTEMUjozc9DzZDToC3qpHkPz0EoeiQz+2gnv68UQZxjITfNpZ72zTJ2GyXOZz7HrWwdR4EAuObzO/MOMWnu48CnwCfu9vrXRkMCSkO6CsGnt7jYcWN1ptRFR/TuJy38ohF/fM0wC/UduZbrvYJ1ei/NOmkD4C6mrLcy4jARuMds3pJMV8qbC7lxVQl5OHYsgG6APcZb8gloDV5VT10KrIV+tnFPugiMS527VLiuQf/ww2q7W5gTCTj0qu4uuWe48tbwUaKG6weBogKMnl3vE+jHEJYPrLGdqEgqts8FYKUIy4dthQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AMWXZ5MA7rg310O8UFWRu7dkLy4KwbP6BRb6Z8GR8c=;
 b=gVIh+0Lp4NYukvMyLD+kdCZiqdDJiboynR3JSXTNrBy/RxEcDhlYsD35TSrv9Kx/WsSe76nz1IOx7tJmwNEqYIl9m0OvjA8IcuVak5DCWeZyYgWP6NIOl+7NgNaKWJvdwRmhAby8UfelsKP46aLZ/xs4w1H+ng+ASjbzZdXOU+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by SA5PPF8DEAB7A29.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 13:20:25 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%3]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 13:20:25 +0000
Message-ID: <287fb709-cc2e-4d11-949a-f0e57fcd1313@amd.com>
Date: Mon, 8 Sep 2025 21:20:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Remove duplicated code
To: Ray Wu <ray.wu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Wayne Lin <wayne.lin@amd.com>
References: <20250908130928.1215893-1-ray.wu@amd.com>
Content-Language: en-US
From: Tom Chung <chiahsuan.chung@amd.com>
In-Reply-To: <20250908130928.1215893-1-ray.wu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0046.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::17) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|SA5PPF8DEAB7A29:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e67d75f-0de7-4ae5-97e0-08ddeeda789e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjhzaGwybG1zWnY3WnlWZjQ0REpoM2xjNkdXbHAzSXQzY2doY2JzQnJkaUEz?=
 =?utf-8?B?NFJ4S3VOYTE2UzhCS3hjSDIxQmg3YWlTcit3bVlhMVRHcm1iVVBsbTNMODJo?=
 =?utf-8?B?d0xCTHpuNU14RDN2bHVCVlFLWXBKeTV1dGNGanZScFVFUzVsZ2hWa0FpL1dW?=
 =?utf-8?B?NEpoQUQvUjJCci9qT2ljRWJKZGxsdnROKzR4S3Z1V3QvbGlrY1R3cU5YQk9n?=
 =?utf-8?B?VXB2SU9qZjBReENhdlE2SGNjbVBGbjhub0RRVjNwWDViRWJhZkIxUlZvcG1R?=
 =?utf-8?B?R0RqajJJODF4UUR3cE0xUFhkeGRvTkM2V1NKQzFrRVZUbzNBbGVRL3MwTGxp?=
 =?utf-8?B?SDV3aEJxWkN1ZHJ1WW85UTBHaGRETDUrenVQMytGL2pWSXdFVzdwb3ZNNHRz?=
 =?utf-8?B?ajM5YXVZb0UrS0xOdHU4MDM5TjNyZVVFVUZLQlA5Z3BCZXNaZFpmMWloL0Jt?=
 =?utf-8?B?MEtlWUNZVXRtUGpEcmtqNzV5NWg4ZXRUWmdDelR6ZWNScVNqZ2NVSG03MXF2?=
 =?utf-8?B?YUtQS2IzbUJyY2UydkFITm9qQTZKNjUzTWx4UFZ2SWU1Qng1NHVmb0tVSW1T?=
 =?utf-8?B?QjBCelliT2NlbkZwazdoSXluVkxDcmVnemNFTzd6cWZZOTVvekZTanYzUUY4?=
 =?utf-8?B?L2REeHRIRDZNUzBDQ0pKSjdvMGI0Y21jbnFTVkp6UVpQQ0ZNcUwyc1k4cGtI?=
 =?utf-8?B?WDJZekh5OWxhOEhPOFFQandIdVJCencxMEJMQ0R5VGpSNkI2OWdrYUdBeENW?=
 =?utf-8?B?UGhRRi9jSndtVUdFME02cTlIQkVEZUI5eFhUZmlEaXh4Smo2UTRnYkV6OTRp?=
 =?utf-8?B?bVpvRWdUMHcrK3RIV0puTHdJV21xTjhhS3pUL1VOMHNMUzFTRUpDdzBEdGxI?=
 =?utf-8?B?c1ZtRm55aktTYU1ZeTFRYkNkL2JzQXJsVWF3WEZyK041c1lnMTdhTWN1Qk5n?=
 =?utf-8?B?Y2k4NHFTQU9mNXMzUTR1VGo5T2NMYVphUnVHRnpxRHV4TzZEMlRxdmNGWnlk?=
 =?utf-8?B?dHIzM0trTHg2cVN3aUF3eFMvdVE4aWtQNjNmOTZiZnpBTGhEaGFUOHJjVEJI?=
 =?utf-8?B?K08xQTZmbklwNUJqN3NSN3B6U2JoZzkrc25qTUZRcFFQL2ZLVVJzUWptWG9J?=
 =?utf-8?B?VERPb1JrVHhhRVdCR0tNcnN2SEo0K3pHVGJsVEJqRnFnV3A1azNjVzhrTnp2?=
 =?utf-8?B?MGlqK1FIWXVLMld0RHFtNWEyT044WTJOWnFLaEpybmdYN3ZYa29TVUpybTZ3?=
 =?utf-8?B?R2NNU2NaYWZ6T3FoWWh0YmR3ZFJRT1RIN2NmVXJTWWtHSk9pTTk2TlBlOWY3?=
 =?utf-8?B?eFJadEUvWXNCUXpERldnelZ3RW5jelJLMmM2K2dpRzhqUXl3SDNmdGUzR284?=
 =?utf-8?B?Z0ZZT2V3YWUvaHozd0F3b2VoWnAxT2FLQUJjeHlNUndXZndKQnF1UCt5dWEy?=
 =?utf-8?B?aVpvUFJVdzFIY3VURXRPcHA0V1NGTEptc3RrOUtFZUtEcGkyaFJBR1NHeTFB?=
 =?utf-8?B?QVBDZitpcDROU1E1bmdKNHQvL0xGL3dvTUFuWk9JV3NsczBDVlRtSDNEMU10?=
 =?utf-8?B?UHpJbnQxa1EwbHV6bFcxbFRjYjZGRm9iZEdCWWxqRFhnV0czVmNLQlZhSzZp?=
 =?utf-8?B?WHJlQWxMZXNIODVIUThyUGRoT0RYODJCMUlSOWV5S0NBbTYyWHM3ZW05ZFpx?=
 =?utf-8?B?Q3I5R2hLL2hsZWdvZktMWm5MSkg3S21UWFFJSWl3N1AxNTBOV24vMWkyN29i?=
 =?utf-8?B?UW91SkljYkFVN1drZkJWcTdZcEMzZWJrVWZGUEU5aGhVZG5CeGVKeE41Q0k5?=
 =?utf-8?B?SUlyWkhlOUFzNitGemhoaXNuMFAvcHI2VUJrajNYUVdZTnIxM1VjcHpmRjZM?=
 =?utf-8?B?dVFGblVZelRlNkdPZkRid3B0bnFyamxZVG95Z0JMdDJNaUcwdVpYN3EvcUJN?=
 =?utf-8?Q?IvJSro01rBk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEtSdmljaXlXRkxuR28ybkh0OHZSdCtxT1FneGhoa1pIY3BIT3BtL2pGbnhl?=
 =?utf-8?B?UWs0QUdGb2t2Vy9JS1BuTnJIclFIZHJac2RFVVE5L3Y1Slphb2txM1Z5WmxT?=
 =?utf-8?B?dS92NGV3WXFRb3I3eGFXS3V2TnBNSndwVytHckxvVDRvNTNxaWdPNmVQbnU1?=
 =?utf-8?B?SUg1bk11T0R0U0dHVGJlc0sweGl4N29HRWVRSTByZS9aWkQ2U2xmR3Q1RDJN?=
 =?utf-8?B?SW9MUlRqTUMyM3BpNGxCSjJKR0FMTHk2czFtZGxxcVZlcGhic3JtWTl1NHlx?=
 =?utf-8?B?Z3JZcitrNXU0V0ZnSHhGQlRtS3d3cVAvakh3VTJFL0krYUpRZkVVclBXNjlh?=
 =?utf-8?B?TkRxQ0dycXZiZTM5RFJWNkhGVm5acTVwQkF6Z0tjaFRub2RybU4ySlFzNDlQ?=
 =?utf-8?B?aU9CUmdNWlF0NUN4TXgrcGV6aG9meS91Nmh3bVpYREZJbzM1TVd4VUw1MjdL?=
 =?utf-8?B?QVBFczQ5YWV6TEZGK1RLZVl0YnRKU3IwQ0czZDJTbFk1NmM1ODF1K0o0MEdp?=
 =?utf-8?B?aGtXQXVlR3oyeDZKYk5nY0haZGdma2R1dFNpdEZDUC9ISzhtMWkxVDhVRnM1?=
 =?utf-8?B?SSszeEtacDlYRkNQOEJjZXd2SFZjbFhBTVZ0RStmZXR3WTdsbDFDQVozSVVO?=
 =?utf-8?B?NXVjQWc0c2ZEWUNxTmhiVWhObVNoR0FzckI3QUpnOExHOXJRYTQ0MEJPdDYx?=
 =?utf-8?B?Zkl2ZVhVTVFlaUhYZ0N2SUVoZDFhZ1FrdkZRaHphQm9uOU1tODY0TFIydWVW?=
 =?utf-8?B?RDQ0L1FKQUhlWkVwelZHRzBDVnA0QW1YOTVGREh1bm1PbHI0TUhBWlBKaU96?=
 =?utf-8?B?QTlocXEvNFZ1azdibnczc3ZYRm9aeVZ3VmhFVmVsampmK3lHaHJEVzlBSUtx?=
 =?utf-8?B?R29FdC9GREVlZ1Z3eitsbWdiZ1I0aHRvOGoyZGxWNXhBQnkxVmlHczJOc2JP?=
 =?utf-8?B?WWNnaWFPeFhLZDNUWGNQdm1ER2NGZFZ4UHZrL0tFSWZUTFJjOXJZeFhpUnAw?=
 =?utf-8?B?Y3NqQ3c2K3ZjVTk0bGpwY0NTNis1V0hIQ2NCL1BJRWRlTlBTT002bUJxbGxk?=
 =?utf-8?B?ck9mSENkaXZmVmFidnhDVXoyUVZCZC9YV2JQd1R5V2dhU1BpZ0hGaUEzb1hZ?=
 =?utf-8?B?LzN0dHpLUHJmQURxMSthVmN3L1ZtbEtRV2RBUmVmUzVoY2NPQ0k0YmwvK0Ji?=
 =?utf-8?B?cmd4SGxiRG1aSCtYWldaakJnNSt3d0QxL3p1a1MwSkNmd2lpd3VzM3hZYWND?=
 =?utf-8?B?YTB2WUNVSDZqaVRNZ2dGTlVPZ3Mzbk9QY0VNUjNkcUZadmFPVFpIUHdySjhX?=
 =?utf-8?B?eVd5TFpkNWRPcTZ1NDFqSWdsMi9NOW1VeUxuR0JTcEhRWWlYeVgxZ2JTTEI4?=
 =?utf-8?B?emo2dDBXVW1XcFd3dzM0SklnTTN4RDBORnNhRmdWVDI1Q3duUzFqdHlsYVhJ?=
 =?utf-8?B?VThjdGZlb2w2SHgwaWJ6NTZUT21nM0E5RWJOWFo4YzdCdm1uUWk2NkkyNFJL?=
 =?utf-8?B?VXAvWTcwcmlvamNNUDlMK2NNZWY1MVRYMnNMeDBxTjZUbWNZcEdzZ1dFdHBV?=
 =?utf-8?B?dSt1dW05TWFCeGMvT3N1VjlwS2tSS3N3QkJ2T2FuRHZ3blU3ck9OY3dQZVRh?=
 =?utf-8?B?Ui9nUkFMRmRJM0p6ZitBandqQ3hwNEJIRTE2WXBCWDRTMEl6UkNjYUZXbld0?=
 =?utf-8?B?RG03bEdXSmhmeDVkN0tYTTBFV2xpN1A3aWY3RS9rbE9TaVR3T0lZU1JGL01k?=
 =?utf-8?B?Y0UzanA0TXAvNkZqcnZxczNaZk85ZFVvd3R3cTJYQmFQbFZuZEVXUmxITkxq?=
 =?utf-8?B?S01Ya1NaYnJRR080d1l4bFdjRVZpT3BSYXhYNXhhN0hzYzZ4aEl4MUFnY3JY?=
 =?utf-8?B?bmRreXdLaUR0M094dFlITzZjZ3hjWHFVb3FPQmJYVFgrd0dZZDZxRTBKczIr?=
 =?utf-8?B?b0xpYW00K1lyVzUxSFArbzFmYWxnd2ptODFLZS9KM1pNU2Iyemk1bm9LQmtM?=
 =?utf-8?B?Z2NrR000clJZVWlNeG9zZ0xNSjVXNEV0ekRYSDJpSjZ6UEJhWFhtZ2doWEVT?=
 =?utf-8?B?U3BmakdYbzFJTkQ0Qjl2SDNUcXBPWXhMak4vdHlBcHpoSkNYNUdvSWVqSlla?=
 =?utf-8?Q?6Tm81w/fM9ajArhJYK8S7hYLa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e67d75f-0de7-4ae5-97e0-08ddeeda789e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:20:25.3140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cvb06x/qPongoPUhQ3emn54itEIR5T5P0QA8BkXGgU3E47uaHjDpGv7Dhw5Y9EopKd72SwvelVu8k5Z7p6Pzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8DEAB7A29
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

Patch looks good to me.
Thanks.

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 9/8/2025 9:09 PM, Ray Wu wrote:
> [Why&How]
> Remove duplicated code
>
> Signed-off-by: Ray Wu <ray.wu@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 3 ---
>   .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c   | 3 ---
>   drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c | 3 ---
>   3 files changed, 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> index 8475c6eec547..1d1a002f6d54 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> @@ -1900,9 +1900,6 @@ static bool dcn35_resource_construct(
>   	dc->caps.num_of_host_routers = 2;
>   	dc->caps.num_of_dpias_per_host_router = 2;
>   
> -	dc->caps.num_of_host_routers = 2;
> -	dc->caps.num_of_dpias_per_host_router = 2;
> -
>   	/* max_disp_clock_khz_at_vmin is slightly lower than the STA value in order
>   	 * to provide some margin.
>   	 * It's expected for furture ASIC to have equal or higher value, in order to
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> index 0971c0f74186..47912e0861a2 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> @@ -1872,9 +1872,6 @@ static bool dcn351_resource_construct(
>   	dc->caps.num_of_host_routers = 2;
>   	dc->caps.num_of_dpias_per_host_router = 2;
>   
> -	dc->caps.num_of_host_routers = 2;
> -	dc->caps.num_of_dpias_per_host_router = 2;
> -
>   	/* max_disp_clock_khz_at_vmin is slightly lower than the STA value in order
>   	 * to provide some margin.
>   	 * It's expected for furture ASIC to have equal or higher value, in order to
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
> index 8bae7fcedc22..9ba91e214dda 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
> @@ -1873,9 +1873,6 @@ static bool dcn36_resource_construct(
>   	dc->caps.num_of_host_routers = 2;
>   	dc->caps.num_of_dpias_per_host_router = 2;
>   
> -	dc->caps.num_of_host_routers = 2;
> -	dc->caps.num_of_dpias_per_host_router = 2;
> -
>   	/* max_disp_clock_khz_at_vmin is slightly lower than the STA value in order
>   	 * to provide some margin.
>   	 * It's expected for furture ASIC to have equal or higher value, in order to
