Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD2EC2BD05
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 08:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D07E10E3A6;
	Mon, 24 Jun 2024 08:19:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C9drNmMC";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 069C010E3A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 08:19:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4SiLobP+u9J4smaCKU6ngOKg7TXFLYy0WyxD7rdJOWCMtjajRqwuJshCVP9w9ThwSJ4I19/gw1ApgbCC1/XPetIlSxYJzD4AHe1qUdqPLzM5y0y9Jw8kMaKzpfUTjh/SHoaowgjs1/dE68TcWK0VdwzCusZr1Ar0O5ebaBBeyeMZLHqmBLKH31PUivmJTd5A7qHCFVNfVqj/0itmhs4xKuBHOO6Vzrf9tIao1Wo+W4wb5d+xHWMzZv8/Lw7Wo8+vRs5t5wGZpc1sVvIFDXqEueoK5DOXLseF0zM8JKGF892efY8OrTde5z3oUC7M2z/5csKCNwG5fFNt59ib8iWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NE3zcI0Gfh+AHbl3eIXZfVGwkiByvLsRqEhcdKiZX9g=;
 b=LxG4KLUX9f8Hu0aHsfqOilp5tOeNeTh6McPuYC3XubtBW8T+i/egqsSwHrgAaJiLCO3P60ccTJjcZ69zsNEqFU5WGrSagchgRv3Yy+UCfJIRIOg5AY/HdM7HeX2GWs5L4bCC4gvkYvl+3B4sz1BLPDi4ZrwX1/OucN0vpFfGKrhPbygB2AXWmq9j1rrLYr2AIF+BcHDZow2d+nmfOctmhqC4aRnjwEQFWM1EDIbgJUI/86vP2UVXu0ELNWPugG0wUbplYmG/VjSq0hklLtLGFIHxBCJLZHuzfa5ej4/8XPskevHZVv1VtthVgXg5+vgcQ6US3kdQP9PTdfQdfD0hDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NE3zcI0Gfh+AHbl3eIXZfVGwkiByvLsRqEhcdKiZX9g=;
 b=C9drNmMCTt+5doAHSHfn9JeS5vrP9lVbNsY32jIEjMZVHEEHA8XIJXTr8SXLSnKV0zGVY09i49jyWsdBfiZF6cUpcd6GWRkPumPp4vN5zUNn7+RLikmHCuZzKMRJJSVCoL1AtejGDrOBf8uw29nhnbwHX1oA16sL2Y9U57F7hZw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 08:19:14 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 08:19:14 +0000
Message-ID: <28cd1870-1760-456c-a4a3-8bad87724d7b@amd.com>
Date: Mon, 24 Jun 2024 13:49:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: normalize registers as local xcc to
 read/write under sriov in TLB flush
To: Jane Jian <Jane.Jian@amd.com>, Alexander.Deucher@amd.com,
 Haijun.Chang@amd.com, Victor.Zhao@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240621081515.2441125-1-Jane.Jian@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240621081515.2441125-1-Jane.Jian@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4eca68-44fd-4b79-f544-08dc94265574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnRGYzY2c1pjTXRrc0lzZ05ORkNGUmZEWTFudW9KV1VzZngrZjh3TFk5RHZo?=
 =?utf-8?B?QTVvSE5aY3h5emxsanpZbnJKaDBRa29ISVlTRzJ5c0lranlua1Y3SG84UnNC?=
 =?utf-8?B?ZmhlVDJqemtyaU9OS1ZSYUQ1alQ2T3lZd29WOTJpaklKQndtL0hXOTEvZ0ps?=
 =?utf-8?B?aURRa1ZRVTJ4ZitCSUk0YUlETU5tTVl4Z3ZDU3g1Z2hVaG5JNU9XZlllY0FL?=
 =?utf-8?B?QnBJaXZTMzMzQVhhTzBRSU9TMEdoNTZiVUxHM1U2Zk1lUDlMdHM3eVE3SEMz?=
 =?utf-8?B?T3FrbG52YzlMNXNjcVJUdkpxT3BiNWFMMDZCeExwRG9CdCtld2dFZGEyOVFF?=
 =?utf-8?B?QXV1eUdmNG4rN0NuSTFoMHFkTThydnpsQ3JlOENkb0phaWVIaWI0ZVB0clZN?=
 =?utf-8?B?NXNzU3ptQWk4RE9wek1meWlIZkJ6U29PaGxydEt1MUM4c2lFQzZ2NlowVlhm?=
 =?utf-8?B?VnZ3ei85eWY1SkhmSmgrc1pSVlI2YnRoaytLbk1RazBtYXd0K28yQ0pTby9a?=
 =?utf-8?B?Um5IWnI4dHhldkNpNERSTUJHN2ptMm9lL1UySmVBclVsNVZFeFFMWEErc3R4?=
 =?utf-8?B?WHpka2d1eFB6VUgzTFhrYms4OU9kUWNWRVVwNUlzU21YcFRPd0JoQkVxVFg3?=
 =?utf-8?B?UkdCZWR2Y1M4bGVPL1BlSitvcU5YcktyR0RkSjhHampzeGhSUExiUUZ4MytZ?=
 =?utf-8?B?MzRTd1o1N0F2c3NFSk1yL3o5MHBLWWtyT0l1RXdheHZ1ZjliN0JzbnhHYVNm?=
 =?utf-8?B?WlBYNXU0NmpYUnRLN1lBMzgyajlBcWFGMUYzaSsxakNBSzZFZlhSYjdNc3lJ?=
 =?utf-8?B?b0VmUWdwNFRzYjI4NDVlQUp5VFh3Y1pISEJRTm5wS29MSXFGeEpjYmI5a2RD?=
 =?utf-8?B?RG16RE9ON2E2eEl3djBJTmNZaU1EN0RnbDlJbnQ0MTBnWTEvSXVUVjR0Z2lN?=
 =?utf-8?B?TWpBQVh0eXJuRHNnN2hxSHV1WEUzSkpYMHZWRG1hb1loT3V6OWJaY2JlYVVO?=
 =?utf-8?B?OG1MdjlJSWRXZ2w1TTZVTWxGSTBLUHcwUDU2eGVTRFJyeDNOVUVPTmFHR0Q5?=
 =?utf-8?B?cHRBcjdhOEZhZnYzZWdyUTQ0S255b1NZUHZET2plZ0NyWU9Zcmd6QXRza2NR?=
 =?utf-8?B?MzNEN1VETzVLUUsvTHJyYTR4aDhxeUtWeU1KcGNzSFd6Yi9qZzc2RXpYYzNP?=
 =?utf-8?B?N3VETkNsRExoL3FXVllwUzdCLytHTXh0bWk2aTVscXYxUzVwOTVsYUdGVFFC?=
 =?utf-8?B?WG1FN1RVTmZreDJQUHBSWkVvTHRpVG05Zk1TN0RYVGxkdVVXQXYyOG95aHVM?=
 =?utf-8?B?ZURESWd0dTRsOFBBUzdYZXNWTHljVEFUaDdPdm1tdjFLVlZrS3hxSW1SQldr?=
 =?utf-8?B?TlJEUVFRcFFMZlN6ZzJuVURiWFlsR24wSHFNWjBQdnVLaFRBWlJUVFlqVXZP?=
 =?utf-8?B?OEFrRUU1Qk4zYXVnblVLemFDaDB5SHBrQlZFRmNFS3ZiTUh2YitkN3VqRDN4?=
 =?utf-8?B?bkhkb0l2WTg0ck9LM1NjRkcxK3NMblViSHZJU045ekpvSkIzMFBXcSs0SUxy?=
 =?utf-8?B?bFJCWENwZmx5S1AxK3pvRXM0L2pjbDRpQ0xuTkxBRHdsV2FEUzNIalZzWUhP?=
 =?utf-8?B?eHh4MVVQa09aWkFNYVVPaVRlOHZUeUEvcTArN0tUTnNBbVA0QWhabEJOWXkv?=
 =?utf-8?B?S1lmTDh1aSs4aHVlMXZpMGx6VzNkK0ZXTDlWVlZRNGZRcnAydUZvdUFuSldX?=
 =?utf-8?Q?KYa7KHGRAiLIguIpJnL9wrr6i4AH8ziiU1Obgkf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3NjUll5dWUrckNqSFNlRU5TMmhKNUlmckJpTTlORmN0clFEeVNra2FtVGJD?=
 =?utf-8?B?ZEhBUUsvZ1p1ZXU5a0JXMm1QNmd0bi9adnYxUFVRSGRkQnVIQ1dRT3cvZzhQ?=
 =?utf-8?B?V1FCWjhUdzhtbUxaUEh0RjFhT3kwcmdPbjZnaFQ5S3cwc1FPZ0YzRWh0MXhV?=
 =?utf-8?B?QXFIQ2ZlbkhrVnoyOGVsNCtieHNhOS9LUm9vREptNWZMdEJXZHQ4SExQcXJL?=
 =?utf-8?B?RU5OZUswRUVxYks1QlRnaVIyQnZuUGtKNk9McEJNSDBaKzZ0TjVPY2l4TDFU?=
 =?utf-8?B?ZmZGQ2tXL3RWVnNwYUdLVG5lNW1KMzRDUUhMT0hpalBoNG16M2UyUXREcGtu?=
 =?utf-8?B?LzJGaC80djlTTWxSUFY2TkM1a2x6U1J5MWgwV25nQzByNE5PMXhoZTlDZnFy?=
 =?utf-8?B?cjZKNWRsVUp4dlBGaVNOK0Z1bURKWHMvbVBmNVUzcklFKzNuT1ZBZWEwQVNG?=
 =?utf-8?B?N0svVWZCeXFHQUpQQVNjL1VyMCtWTlN3c2haKytWcGlTNXVtOGlvUmpHRHdP?=
 =?utf-8?B?RldWdElFZFRrVjBmemc0aUhmTTZXcS9ySU5xS2IwV1ZQVTN0dkdaY0hvSXBX?=
 =?utf-8?B?UUtlTEMxWENzNjYrLy85MWlOTWV1NW45VTNNdjBidUlaQXNPQ0V5QTNXc1Jh?=
 =?utf-8?B?eXU3WFBtdnZFbzVUWGdkSHl2TXVBczVsMmVCYVM5YXhlMXJPQno2bUJYWHdo?=
 =?utf-8?B?bWdXZE0zR1hHeFJ1dzgwcGIwWXVPRmVkamNGRE5tSmZlQ3pSQy9qRlRQL2FU?=
 =?utf-8?B?MW85bldWTlJaWTR4ZlcwbHRFM0FPWWc1QVovSHhSdU5tclE2eVpuckJXVDhJ?=
 =?utf-8?B?QVdpOW9xdG5oWTVsSWpuTXlrWnAraUVHdHByZm1jOHA1ZDJ2NXE4amtYVTFM?=
 =?utf-8?B?d3hSWmc3RjNGSFJDQXlCTkI3ZUEyeXhwQ2NEK3ZQYkIwZzZENisxM0VPVEVk?=
 =?utf-8?B?V1lPM2xmMUNoN2ZhMWdFaTVXbVFPZDMwd3RZV2lZQ2NwNWtkQk0zTzBVWjlU?=
 =?utf-8?B?bTRQU1IxRmYyOVlPak0xT3FIRkVqTkQrVnk2aUgxVXc2VnBZbDljTGM4ODl4?=
 =?utf-8?B?eHZ1cUU0cXRudW1rL3FKQk5qMzJJSXVTV3lGZ255VW5QQ2dRdXFIb09ibUtq?=
 =?utf-8?B?Vjk3UUlic1R2Y2Zuamoxc3M4c0p1azVZOVQvdUxUY1lrNVVpMEdhZ3ZLQjhM?=
 =?utf-8?B?Q1BaWXZ4bE5FRVJHRGRjL0huRkR1ZElGNzZGVjZDWE1PWWZDYjZHQm1yY1BX?=
 =?utf-8?B?bWdoYVlKUmxUQXFzQ3ZpVVZrV0ZkTWc3VVpHOUxKaVYrR0ZxU0RGaUdzNVgw?=
 =?utf-8?B?azBsU3hyR05YSjRQVDZKdGo4OHFBM1pXUjZrZkVTczlEbFA2NFV3aVozRzhJ?=
 =?utf-8?B?RTloTm0wOEdsa1Eva2Q5elQ1K0kzV1BLaTI4V3drVW5sVURoZ0MrSjdQcWhJ?=
 =?utf-8?B?Q2NNOW90NmhraWNoUzREOGY5ejV3eUlEVDdNb0h1cXJEQXZqRU9CVkQ4cnFR?=
 =?utf-8?B?NXdDVWR3bmpzZmJkRG4rK2dxVHdDQjl6WXN2eWs0eVp4NXJlVzVZTlFYU2kw?=
 =?utf-8?B?NVRkU2gzdmRXUnh4ZE1VVDU3cExBT3R6ODdoVE9PaUE2QW0rajJ3UmFKaGg4?=
 =?utf-8?B?Q21sNVZ0WWhGUGFHelVObEpValJSL3NRN0hBMUZiWVA5VEdPRE5ENEsyZnJp?=
 =?utf-8?B?VFRsQUd0VkJkRXd1NlpZa1pZKzI4aXJvaHpod1c3Ly9iQ3pZOWpBYW1zQnJZ?=
 =?utf-8?B?TUxHWGw4T2wxVUcvc0s3ZnBjbkY2RXQ1eVhjdlN1Q0wvZ1dSVkZoNzBHVmM3?=
 =?utf-8?B?dDB2SzBKbG9WOU5jaEQ1WC8yLytuQjV1eSs0Y283Z1VJU1NseGI5UzA3K1cr?=
 =?utf-8?B?VnhyMHo0a0FJYTYrMEM0RVpyWUVHT1pxMzdyT0k5UU0wRllIQlRvTTcxc0Mr?=
 =?utf-8?B?aXBDNUpxMEtuazU1a0tVMTE3Wk5vNTB0RkkzUndYWThEVEZpZ3BMcHlYa284?=
 =?utf-8?B?Qjc0UDN0c2RCTjZhMDE0VGNtQ3B3ZHo3REJZSzJqbjlLTHpiaitnVXhtTUYv?=
 =?utf-8?B?RXNCNENyS3kzQ1RiRU5pT1dKYlNLSUNBQjJQK1pCRkM5aU1uRGY5N3NBSllU?=
 =?utf-8?Q?1MyLXKdZXEpGuHgp0kbpXbXLB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4eca68-44fd-4b79-f544-08dc94265574
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 08:19:14.6703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNbZV+tvKD1JpzeMILGM+slY4VXe+2kdoxg2BkJlA2A1exTg5AIiYt+Ycj2QxBpD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830
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



On 6/21/2024 1:45 PM, Jane Jian wrote:
> [WHY]
> sriov has the higher bit violation when flushing tlb
> 
> [HOW]
> normalize the registers to keep lower 16-bit(dword aligned) to aviod higher bit violation
> RLCG will mask xcd out and always assume it's accessing its own xcd
> 
> [TODO]
> later will add the normalization in sriovw/rreg after fixing bugs
> 
> v2
> rename the normalized macro, add ip block type for further use
> move asics func declaration after ip block type since new func refers ip block type
> add normalization in emit flush tlb as well
> 
> Signed-off-by: Jane Jian <Jane.Jian@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 112 +++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c |  16 +++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  32 ++++--
>  drivers/gpu/drm/amd/amdgpu/soc15.c         |   1 +
>  drivers/gpu/drm/amd/amdgpu/soc15.h         |   1 +
>  drivers/gpu/drm/amd/amdgpu/soc15_common.h  |   5 +-
>  6 files changed, 101 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 083f353cff6e..070fd9e601fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -583,61 +583,6 @@ struct amdgpu_video_codecs {
>  	const struct amdgpu_video_codec_info *codec_array;
>  };
>  
> -/*
> - * ASIC specific functions.
> - */
> -struct amdgpu_asic_funcs {
> -	bool (*read_disabled_bios)(struct amdgpu_device *adev);
> -	bool (*read_bios_from_rom)(struct amdgpu_device *adev,
> -				   u8 *bios, u32 length_bytes);
> -	int (*read_register)(struct amdgpu_device *adev, u32 se_num,
> -			     u32 sh_num, u32 reg_offset, u32 *value);
> -	void (*set_vga_state)(struct amdgpu_device *adev, bool state);
> -	int (*reset)(struct amdgpu_device *adev);
> -	enum amd_reset_method (*reset_method)(struct amdgpu_device *adev);
> -	/* get the reference clock */
> -	u32 (*get_xclk)(struct amdgpu_device *adev);
> -	/* MM block clocks */
> -	int (*set_uvd_clocks)(struct amdgpu_device *adev, u32 vclk, u32 dclk);
> -	int (*set_vce_clocks)(struct amdgpu_device *adev, u32 evclk, u32 ecclk);
> -	/* static power management */
> -	int (*get_pcie_lanes)(struct amdgpu_device *adev);
> -	void (*set_pcie_lanes)(struct amdgpu_device *adev, int lanes);
> -	/* get config memsize register */
> -	u32 (*get_config_memsize)(struct amdgpu_device *adev);
> -	/* flush hdp write queue */
> -	void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
> -	/* invalidate hdp read cache */
> -	void (*invalidate_hdp)(struct amdgpu_device *adev,
> -			       struct amdgpu_ring *ring);
> -	/* check if the asic needs a full reset of if soft reset will work */
> -	bool (*need_full_reset)(struct amdgpu_device *adev);
> -	/* initialize doorbell layout for specific asic*/
> -	void (*init_doorbell_index)(struct amdgpu_device *adev);
> -	/* PCIe bandwidth usage */
> -	void (*get_pcie_usage)(struct amdgpu_device *adev, uint64_t *count0,
> -			       uint64_t *count1);
> -	/* do we need to reset the asic at init time (e.g., kexec) */
> -	bool (*need_reset_on_init)(struct amdgpu_device *adev);
> -	/* PCIe replay counter */
> -	uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
> -	/* device supports BACO */
> -	int (*supports_baco)(struct amdgpu_device *adev);
> -	/* pre asic_init quirks */
> -	void (*pre_asic_init)(struct amdgpu_device *adev);
> -	/* enter/exit umd stable pstate */
> -	int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool enter);
> -	/* query video codecs */
> -	int (*query_video_codecs)(struct amdgpu_device *adev, bool encode,
> -				  const struct amdgpu_video_codecs **codecs);
> -	/* encode "> 32bits" smn addressing */
> -	u64 (*encode_ext_smn_addressing)(int ext_id);
> -
> -	ssize_t (*get_reg_state)(struct amdgpu_device *adev,
> -				 enum amdgpu_reg_state reg_state, void *buf,
> -				 size_t max_size);
> -};
> -
>  /*
>   * IOCTL.
>   */
> @@ -728,6 +673,63 @@ enum amd_hw_ip_block_type {
>  	MAX_HWIP
>  };
>  
> +/*
> + * ASIC specific functions.
> + */
> +struct amdgpu_asic_funcs {
> +	bool (*read_disabled_bios)(struct amdgpu_device *adev);
> +	bool (*read_bios_from_rom)(struct amdgpu_device *adev,
> +				   u8 *bios, u32 length_bytes);
> +	int (*read_register)(struct amdgpu_device *adev, u32 se_num,
> +			     u32 sh_num, u32 reg_offset, u32 *value);
> +	void (*set_vga_state)(struct amdgpu_device *adev, bool state);
> +	int (*reset)(struct amdgpu_device *adev);
> +	enum amd_reset_method (*reset_method)(struct amdgpu_device *adev);
> +	/* get the reference clock */
> +	u32 (*get_xclk)(struct amdgpu_device *adev);
> +	/* MM block clocks */
> +	int (*set_uvd_clocks)(struct amdgpu_device *adev, u32 vclk, u32 dclk);
> +	int (*set_vce_clocks)(struct amdgpu_device *adev, u32 evclk, u32 ecclk);
> +	/* static power management */
> +	int (*get_pcie_lanes)(struct amdgpu_device *adev);
> +	void (*set_pcie_lanes)(struct amdgpu_device *adev, int lanes);
> +	/* get config memsize register */
> +	u32 (*get_config_memsize)(struct amdgpu_device *adev);
> +	/* flush hdp write queue */
> +	void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
> +	/* invalidate hdp read cache */
> +	void (*invalidate_hdp)(struct amdgpu_device *adev,
> +			       struct amdgpu_ring *ring);
> +	/* check if the asic needs a full reset of if soft reset will work */
> +	bool (*need_full_reset)(struct amdgpu_device *adev);
> +	/* initialize doorbell layout for specific asic*/
> +	void (*init_doorbell_index)(struct amdgpu_device *adev);
> +	/* PCIe bandwidth usage */
> +	void (*get_pcie_usage)(struct amdgpu_device *adev, uint64_t *count0,
> +			       uint64_t *count1);
> +	/* do we need to reset the asic at init time (e.g., kexec) */
> +	bool (*need_reset_on_init)(struct amdgpu_device *adev);
> +	/* PCIe replay counter */
> +	uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
> +	/* device supports BACO */
> +	int (*supports_baco)(struct amdgpu_device *adev);
> +	/* pre asic_init quirks */
> +	void (*pre_asic_init)(struct amdgpu_device *adev);
> +	/* enter/exit umd stable pstate */
> +	int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool enter);
> +	/* query video codecs */
> +	int (*query_video_codecs)(struct amdgpu_device *adev, bool encode,
> +				  const struct amdgpu_video_codecs **codecs);
> +	/* encode "> 32bits" smn addressing */
> +	u64 (*encode_ext_smn_addressing)(int ext_id);
> +
> +	ssize_t (*get_reg_state)(struct amdgpu_device *adev,
> +				 enum amdgpu_reg_state reg_state, void *buf,
> +				 size_t max_size);
> +	/* normalize offset to keep in lower 16-bit */
> +	u32 (*normalize_reg_offset)(enum amd_hw_ip_block_type hwip, u32 offset);
> +};
> +
>  #define HWIP_MAX_INSTANCE	44
>  
>  #define HW_ID_MAX		300
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index 2c9a0aa41e2d..98b00c0e522f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -1085,3 +1085,19 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
>  
>  	return size;
>  }
> +
> +u32 aqua_vanjaram_normalize_reg_offset(enum amd_hw_ip_block_type hwip, u32 offset)
> +{
> +	u32 normalized_offset;
> +
> +	switch (hwip) {
> +	case GC_HWIP:
> +		normalized_offset = offset & 0xffff;
> +		break;
> +	default:
> +		normalized_offset = offset;
> +		break;
> +	}
> +
> +	return normalized_offset;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 88b4644f8e96..7542a75f068b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -853,8 +853,12 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  	 */
>  	if (adev->gfx.kiq[inst].ring.sched.ready &&
>  	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
> -		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
> -		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
> +
> +		/* Select lower 16 bits to write in local xcc */
> +		if (AMDGPU_IS_GFXHUB(vmhub)) {
> +			req = NORMALIZE_XCC_REG_OFFSET(GC, req);
> +			ack = NORMALIZE_XCC_REG_OFFSET(GC, ack);
> +		}
>  
>  		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
>  						 1 << vmid, inst);
> @@ -979,6 +983,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>  	struct amdgpu_vmhub *hub = &adev->vmhub[ring->vm_hub];
>  	uint32_t req = gmc_v9_0_get_invalidate_req(vmid, 0);
>  	unsigned int eng = ring->vm_inv_eng;
> +	u32 low_distance, high_distance, req_offset, ack;
>  
>  	/*
>  	 * It may lose gpuvm invalidate acknowldege state across power-gating
> @@ -986,7 +991,18 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>  	 * release after invalidation to avoid entering power gated state
>  	 * to WA the Issue
>  	 */
> +	low_distance = hub->ctx0_ptb_addr_lo32 + (hub->ctx_addr_distance * vmid);
> +	high_distance = hub->ctx0_ptb_addr_hi32 + (hub->ctx_addr_distance * vmid);
> +	req_offset = hub->vm_inv_eng0_req + hub->eng_distance * eng;
> +	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>  
> +	/* Select lower 16 bits to write in local xcc */
> +	if (AMDGPU_IS_GFXHUB(ring->vm_hub)) {
> +		low_distance = NORMALIZE_XCC_REG_OFFSET(GC, low_distance);
> +		high_distance = NORMALIZE_XCC_REG_OFFSET(GC, high_distance);
> +		req_offset = NORMALIZE_XCC_REG_OFFSET(GC, req_offset);
> +		ack = NORMALIZE_XCC_REG_OFFSET(GC, ack);
> +	}
>  	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
>  	if (use_semaphore)
>  		/* a read return value of 1 means semaphore acuqire */
> @@ -994,18 +1010,14 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>  					  hub->vm_inv_eng0_sem +
>  					  hub->eng_distance * eng, 0x1, 0x1);
>  
> -	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
> -			      (hub->ctx_addr_distance * vmid),
> +	amdgpu_ring_emit_wreg(ring, low_distance,
>  			      lower_32_bits(pd_addr));
>  
> -	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
> -			      (hub->ctx_addr_distance * vmid),
> +	amdgpu_ring_emit_wreg(ring, high_distance,
>  			      upper_32_bits(pd_addr));
>  
> -	amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
> -					    hub->eng_distance * eng,
> -					    hub->vm_inv_eng0_ack +
> -					    hub->eng_distance * eng,
> +	amdgpu_ring_emit_reg_write_reg_wait(ring, req_offset,
> +					    ack,
>  					    req, 1 << vmid);
>  
>  	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 8d16dacdc172..e6e61fc77080 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -927,6 +927,7 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
>  	.query_video_codecs = &soc15_query_video_codecs,
>  	.encode_ext_smn_addressing = &aqua_vanjaram_encode_ext_smn_addressing,
>  	.get_reg_state = &aqua_vanjaram_get_reg_state,
> +	.normalize_reg_offset = &aqua_vanjaram_normalize_reg_offset,
>  };
>  
>  static int soc15_common_early_init(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
> index 282584a48be0..f1e974604e3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
> @@ -124,4 +124,5 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
>  void vega10_doorbell_index_init(struct amdgpu_device *adev);
>  void vega20_doorbell_index_init(struct amdgpu_device *adev);
>  void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev);
> +u32 aqua_vanjaram_normalize_reg_offset(u32 hwip, u32 offset);

There is a mismatch in prototype in declaration vs definition.

>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> index 242b24f73c17..ddf0aad51821 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> @@ -210,4 +210,7 @@
>  #define WREG64_MCA(ext, mca_base, idx, val) \
>  	WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) + mca_base + (idx * 8), val)
>  
> -#endif
> +#define NORMALIZE_XCC_REG_OFFSET(ip, offset) \

This naming is specific to XCC while what it does is not specific to XCC.

If it's specific to XCC, you may want only this way

NORMALIZE_XCC_REG_OFFSET(offset)
adev->asic_funcs->normalize_reg_offset(GC_HWIP, offset)

Thanks,
Lijo
> +	((amdgpu_sriov_vf(adev) && adev->asic_funcs->normalize_reg_offset) ? \
> +	adev->asic_funcs->normalize_reg_offset(ip##_HWIP, offset) : offset)
> +#endif
> \ No newline at end of file
