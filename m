Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EF8D68BC1
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 22:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3834610E7CB;
	Wed, 17 Dec 2025 22:24:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OxrZN5V2";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A281E10E7CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 22:24:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmpGHcwNt1mCDO0XCzgFmF0Tl+WR4t/BxxKFPuwdxIFaiJMjM57dSR5Y33eWhaIOynubLtlBaMtr1uAilOx6emAxvMN8V4DnxMc/2U91Ai5cWwyX5MqqosFPwuMTFWEe1b4DCoRIhquWNRGFOUlqZjpOv+A1ogqsNt7uNyfTzjArVLBfRiKiyDLQypT1eXL02ByJWFTk9ZQwjg3h5zkLwkDK+R7FKfFwnqcFw021oLwFbI1ouGBS04Ex163V9QpTG6IilKgEXAxu1Wx1Rr0Mw0+oWmCV7rR3R9K8ahMgO5mauyCa7FMq6HrEN2NnyLUCXuyGYOjhXiYIv27k2GveAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rPTgNOMOw67KjIxPYUieHARjEZUMPzZ8CWmQQh970o=;
 b=pxT8f0aLyM6b4A0weGjv8VKWjUlg5NFyi1na59HoKxI+J4GyPwKO22gMaBtSKMDJHRYlsUqpHsVBsE6IogDG1P1JXI4ccKEYnGh4m86XKg3mdxpnCL1FgV+qZqIub12boWatQhr30szC/g+SegAO7MMNQSwzPDipNy1EADriTb8M89aqpU4ckRuxiSwr5zUr66Bqv6t4RmDNcsGlFarNrY8EO7idp0LfstC00i3l8y1r1uhTaMgxL7Aku9hSsCfqyyRbdNMmS94gUgqGYkbpYvpNoFEF6vzSGnSiqO0h4pBibYLWYAwMVki482ZQUIIPe2LUkIEQEnO4PPDJGkkyEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rPTgNOMOw67KjIxPYUieHARjEZUMPzZ8CWmQQh970o=;
 b=OxrZN5V2Mg3Lv2sF9/w3/t9g7n4P4v8spQxalSIwoiuf2GdvJo47u/HSUY9yJ/2CQAq6W2nUQPkB7fa3iNsFM46NlCJ8kyJOwYq/tmPIeGRrAQWQvnrCopJCY5RQagweGeX96uiOOWLOCOHzyiIWCWPgOz3a+OM9xXD33z3vBVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB8414.namprd12.prod.outlook.com (2603:10b6:8:fb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Wed, 17 Dec 2025 22:24:17 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 22:24:17 +0000
Message-ID: <03ff096c-87cb-4a11-9a14-155cd5b150b7@amd.com>
Date: Wed, 17 Dec 2025 17:24:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] drm/amdkfd: Map VRAM MQD on GART
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com, kent.russell@amd.com
References: <20251215165630.1172383-1-Philip.Yang@amd.com>
 <20251215165630.1172383-7-Philip.Yang@amd.com>
 <c3415b20-da51-4aac-acf7-841fe9621b3d@amd.com>
 <84a6dc2d-45bb-4f9f-a84d-47b8727485de@amd.com>
 <85112e20-9a07-4537-ae1d-044179248758@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <85112e20-9a07-4537-ae1d-044179248758@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0227.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::9) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c2c2c2-0318-4fcc-4f16-08de3dbb0452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eExMVjdCcGs2R2Rqc2M1OGg5K1V0Q0JxSmZoaDA4a0VUTzVuVGdNOTBnK0ho?=
 =?utf-8?B?QlF5clBKQUs3b0Q5WUNBcmZtZDBqejZyTEZCQ056Z045a2VWVk1Bd2FrRlRp?=
 =?utf-8?B?eThvZ0hqeVljN0REVHdNRmZuYmdDSVJzN0k5bDl1Z0xhNWdMMnA4Tm1UNVg0?=
 =?utf-8?B?ZkdOTnRad05NMkVNUUtHNGZ0SkpRODdaM1JTaHR4VVhCN2RHWk9JVlhWSGpJ?=
 =?utf-8?B?TmFsMzk4QWlHV1pQY1NmYnlRNzgyRE1icXgrMUlxK0hDRDc2bC83QTliYXE1?=
 =?utf-8?B?NUJzMlhHU2J3M1NicUpzQ3R1Y3orcnExY3RVL20vRCtmWklrMXVwRnFZK1oz?=
 =?utf-8?B?SGI0S3pBOU1nT2VXdDdzOVF1N3NxbDB2L01OMHA2d1c4RzMrdGVmSW91clox?=
 =?utf-8?B?MlFML1o0LzlzTFo4emZOSGN1SjJhUDdUZ2U4T09OUG1UeHN4OG9EZktHK3li?=
 =?utf-8?B?NU41eEtrWDZOYlJrcjk3SXg4MFB5UmJVUEZoZUM0WUR2STk4dXdhUStFVkpI?=
 =?utf-8?B?ZGY5Q1d2VGdFUTZ0MFBNT3BrNmMwWk1PVC9Yald0ZWlaOFRGVGpyM2RMbEtN?=
 =?utf-8?B?ZTlUelYyRStUUTVWcXJWbTdIZ0xSSjJHd0tEbzRRSVh1c21iS25ZeXlmQ25G?=
 =?utf-8?B?NkdIMWFNaCtPVFJadkxmc2JKbEVEQTdCZEZjMXJaZ2dBTkVveDRBekJsVnNY?=
 =?utf-8?B?U0JHRnlLMWdyeFhrbXg4UGpRSDN3RGp4b0UwSHEyY2txVHUyLzZPYmdVemlq?=
 =?utf-8?B?d3ZZNnAxR3Ayc1V2YnM4bFBoZVZ5S1FKdDhONWhlN3Z0VkZvSGxhNFZrczZT?=
 =?utf-8?B?V1hKMUE1TnpvVVJ4engyRm9JYlhJV29NeVdSOElib1RZbzIwMzR4NUcrcWZC?=
 =?utf-8?B?TENYd0VjVW9pRXNLV2xUZkc0Q0Y3Y1VNY1lLS0ZBZUgzN0JCWXBKV2lpNWdX?=
 =?utf-8?B?WXBETjRiZkhNY0RjYVo3RldGdXl0Y0U1SHU0aXZUUk4zWmZrZHhSVDlvc2Fq?=
 =?utf-8?B?WW1JUXlyaGV6R0pCOXp3NXNJeUpyOTVYQzZMSnRGRHZLM1RvN0VaYURsRnhj?=
 =?utf-8?B?dzdIbDNYVVFBNXd6RGNwczFpQit0MUJlbWhsbFFtdUx0QmNPZzVodzdQRzJQ?=
 =?utf-8?B?Q2xvdGI3dWM3aUkzOU02U2xGSmtVZ1hsM0hLWXN0aEQxTk5KaE5waU1kd1B0?=
 =?utf-8?B?bmN2aXQvcnh1MnNLMGhxaFpSWHJwSjNJbXQ4clYxbDVYZWtZeElJOW10Rjdp?=
 =?utf-8?B?US9raUtPUkg4OVIwalJiandkUTEvWGVVakl3SmR1NWtVV2lLZVFyZVhRZXF1?=
 =?utf-8?B?eFJjcENXbWNraFNZZHhreW5SU2kvTHZZRXRMMlVOMloxdWNnQS94TitNTzJj?=
 =?utf-8?B?WGtsOTdoaUdTTndIZThiak4xZ0pidE1IMHllQ3dDSjl0WTJPVU91Z1hJajh3?=
 =?utf-8?B?bmF1OGo1c3ZLOXF0ekgvSzl3aHpPRHVOeU42dkVjQkV1RkJzNmhiazk5OXQ2?=
 =?utf-8?B?US93Q0lNdldPeWl1UFA3MmhEVis1MERsMk55UnliSHU5RlJaSnUzcXZDLy8v?=
 =?utf-8?B?RDRYV2c4UExxQlBLVmpQc2pTeDlHUVpHS00yTVBlMmJ0anlsSVVBbndyZFlr?=
 =?utf-8?B?OWY1QXVpelByRk5LZnU5ckwrUWxYQThkS0VtQVgyblphMFUxUFNqcFVJTlFk?=
 =?utf-8?B?dXZjZ09adGR0RnlCNU83UVRyZUMzRlRZZXZUejk0RTRiYTRobUEzR0VxSXc5?=
 =?utf-8?B?eXh5VlJKcFRsdnRWSWR5UGI4aFZvdTF5dFpxU0phWDJESFJEUjVLbGF5SU5o?=
 =?utf-8?B?bnB1MTNaVXdTR2VwR1dBbHlLVkxYUmQrNEl1NGNySlU2SEhkbUxldWVRRWNp?=
 =?utf-8?B?SHBvam93SHBTcFRXb2FOK2YvVitISitabk0xTTZuMVY0Q2Z2V1dqbEpETDNV?=
 =?utf-8?Q?WaZxi7nQ0jmSm3vi/19toj7aYRsbZ90I?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3hlWHA4elZjL21WWXFmOVlIbWVGUWczTkp6SklrQVY2Y0xNUGZFT2NXM3h3?=
 =?utf-8?B?clVaUzltNHpzYWREL2hzTTMza2I5Z2pLS3FTbE9pRDczNklpN3pSVVNhRElR?=
 =?utf-8?B?VjQ3RmRRQ3V4U2VtdGpjWUdEckpWVVYvUmYyYnhzREpHTVYvUlZlK1lUek5Q?=
 =?utf-8?B?RmNRbENaRURJa1JWVVUwNFZGMk92RENOOElKSXZYb3owOFlNcE9hNy9CTk9Z?=
 =?utf-8?B?aFFpRUVnaDYyNFJna3dsUitodFBkc05ZUXIwbC9UZGhsYThweWNLcllZMWpV?=
 =?utf-8?B?UFhEVnNxSjduN2h5d3ZadlRma0xKTTMxV2x3OWJhZFdGSklHSFQ3NEdCSEFM?=
 =?utf-8?B?VGdLR1h6MkxxSWZid3NKcWdBclIxcG9DQzY3cjYwVWx5OUZ6ZituZk5LdUdq?=
 =?utf-8?B?Y2ZXMENzUGJGUkxsNlJCNkdsKzlPTzBHOEZ4M0JDQ1dXR0Z1OGRHWDRmdFlk?=
 =?utf-8?B?eUk5TVVlRkg2MzVRNEpsQjYyNG5tS1MyVXBhVHlFWm54ZUEzQ0djTGhFRUNm?=
 =?utf-8?B?MGt2akU5dm5NM2V1Mk5NeUM4NkdRU0k4TXE1ZDhZUkhncXJOdkF3SklrU0JT?=
 =?utf-8?B?dVZFbjZ0N0RPY0NWTG5nb3UrdVhDeTdqRnpOaWN0U3VhOGtKZTFnNTZZdnhZ?=
 =?utf-8?B?WEtWdTUzcXl5QVRVQWZWNFlZMTMxSERtaVZ3VUxGdGIxd1ppcjdEekNQMVk5?=
 =?utf-8?B?ZkdKRXVRd3BYLyt4bjRtMVpxQUJ4TUh0RTdvNENGWnM2UEdiOWZRM1Z3Undz?=
 =?utf-8?B?OVJYalFIUTlPN1VtK0NIZGF6aFQzbEkzSkZ1RVVianp0bzdNanRvbzcxMDlK?=
 =?utf-8?B?TVJSc2p4S3lIZHBtOUd4VUJTL1RUeEhLY05ScGRoUzdwOGFWTlpCdGV4R0d0?=
 =?utf-8?B?SHIxbmZzVm5uaExzTTBUQjhXUW9EenVRdHFyYW1uaDFpMVl6N0NrVzMwalBT?=
 =?utf-8?B?cVk3ZFFKTUJYYXNxWkN3TkNZWkZKeGhWZmJ2NGhuTGxORGFuNldmRVBMSi9Z?=
 =?utf-8?B?U0dSYWhFeXY4d0JIcnhUZ0c5L3piUW8xb3A5eWRmbFltZDVWUmdWZ3Q2ZnZI?=
 =?utf-8?B?MEJyZXpIRkRLTlRFUFA0WVdUemNnbkovaFMwUjd0c2tYaVNpbGE2eWd6NkxW?=
 =?utf-8?B?SmlxbFdIQ0lWOTR4TVB6TzFJR0ltaDBmZGUvUE9UV3FISE0vSzRKK0xCSzdX?=
 =?utf-8?B?bFF0ZldIU0pMNnpCaXJRWms5cVVKVjFDckt6Wll5TXY2Uyt2aThQRG9YVmo5?=
 =?utf-8?B?cGEyb3MwUEY4alBtL1VyajhIWTRBemFwdlEwMmwxTUtGdHJYRERMRWUwTFNj?=
 =?utf-8?B?VDY2M0ZoN3VDYms4NGI4bVRiQmdpSHY3V2dEUW1VWHJKYXF0N1BpMTNiaWtl?=
 =?utf-8?B?TUY1WFdHeFY1TCtBbVVxdlRiNFhUWmdseHhIWEcrQ01McnNVTnZTN2xIUXhh?=
 =?utf-8?B?QXVpWFg4Mmh2N1hMaTYrS2lETEpWSzMwYThmN3hEVW0vbjZkZ2xseTZEdTZt?=
 =?utf-8?B?TXVORDQzY0lHNnVTSDhvRXd3Y1dhSjhyTE9FOW0zbHFpNVZtSkZkMnlkWC9i?=
 =?utf-8?B?bXdQSkhzaUZiVWpxaDNaUjhxenJReEVxTnJxTHJCYVE0V0kwbG5CZHlBM1VZ?=
 =?utf-8?B?S3FaTmszZjNrOHZMRit2OXY3VHZLdktaMmFXZEg0cnV5cCtnWFh6dW9ZYkc4?=
 =?utf-8?B?M3NnUE4wVkVoM1RqYjRqUUdZSU51bytWWm9HTnhTRE8xTGw0Nk1vS1I0OU90?=
 =?utf-8?B?Y3M2dnhja1ZzTFBPQmdONGtScXF5enBTS01SVU9RRDBnSFJKMFpQbmtaR0Yy?=
 =?utf-8?B?a1FWTHFHREpWZWh5NTVBMFpXazRQYmp0TDhNYnFOTlc5NE96OFY1UGp3aHZP?=
 =?utf-8?B?STZTY3FNcUtPRlYzUnlHWmZ0VjZRVTBIdFhHT3pUQ1BkcjdRT1ZWcWsvSWpo?=
 =?utf-8?B?c1Nsd25vS2Zwd0tucU8vQWh0bld2c0hjNWFuWk9oazMxeGYvTDR4UTc4NGlx?=
 =?utf-8?B?WXZSN0J0dlFsK1V5c2QyWkt1UlE0TmFINmUxR0kyUzFHUDNZWVpCT0EvOEtY?=
 =?utf-8?B?SW5xbzRwWHNwK0RDR1o4MlpramRnRzhWMk8wOUxaQ3dBa3RBM0RNb1ZlYlJD?=
 =?utf-8?Q?9oO0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c2c2c2-0318-4fcc-4f16-08de3dbb0452
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 22:24:17.6678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/juLwWnDuud83My/jppEPZD3x3UXfkV7qRH7ff6e3fidce0juRLUXIkrvyLRe6L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8414
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



On 2025-12-17 11:37, Chen, Xiaogang wrote:
>
> On 12/17/2025 9:06 AM, Philip Yang wrote:
>>
>>
>> On 2025-12-16 17:35, Chen, Xiaogang wrote:
>>>
>>>
>>> On 12/15/2025 10:56 AM, Philip Yang wrote:
>>>> MQD BO on VRAM access via FB aperture is mtype UC uncaching, map
>>>> to GART as mtype RW caching, to reduce queue switch latency
>>>>
>>>> Add GART mm_node to kfd mem obj to free the GART entries after
>>>> MQD mem obj is freed.
>>>>
>>>> Use resource cursor to handle VRAM resource which maybe on multiple
>>>> blocks and use cursor_gart to handle GART entries.
>>>>
>>>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 94 
>>>> +++++++++++++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  4 +-
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +
>>>>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  9 ++
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>>>>   5 files changed, 109 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> index 4f8bc7f35cdc..d7bf96a7b6b2 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> @@ -880,6 +880,67 @@ static void 
>>>> amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>>>>       }
>>>>   }
>>>>   +/*
>>>> + * Same function and MQD description from 
>>>> amdgpu_ttm_gart_bind_gfx9_mqd,
>>>> + * except this is for MQD on VRAM BO and use dynamic alloc GART 
>>>> entries.
>>>> + */
>>>> +static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct 
>>>> amdgpu_device *adev,
>>>> +                struct ttm_buffer_object *tbo,
>>>> +                struct drm_mm_node *mm_node,
>>>> +                uint64_t flags)
>>>> +{
>>>> +    uint64_t total_pages;
>>>> +    int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
>>>> +    uint64_t page_idx, pages_per_xcc;
>>>> +    struct amdgpu_res_cursor cursor_gart;
>>>> +    struct amdgpu_res_cursor cursor;
>>>> +    uint64_t ctrl_flags = flags;
>>>> +    int i;
>>>> +
>>>> +    total_pages = tbo->base.size >> PAGE_SHIFT;
>>>> +
>>>> +    amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, 
>>>> &ctrl_flags);
>>>> +
>>>> +    if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
>>>> +        amdgpu_gmc_get_vm_pte(adev, NULL, NULL, 
>>>> AMDGPU_VM_MTYPE_RW, &flags);
>>>> +
>>>> +    pages_per_xcc = total_pages;
>>>> +    do_div(pages_per_xcc, num_xcc);
>>>> +
>>>> +    amdgpu_res_first(NULL, mm_node->start, total_pages, 
>>>> &cursor_gart);
>>> no need use cursor_gar. mm_node->start + n indicates where to update 
>>> gart page table.
>> yes, that is the last version, change to use resource cursor for both 
>> gart entries and VRAM pages
>>>> + amdgpu_res_first(tbo->resource, 0, tbo->resource->size, &cursor);
>>>> +
>>>> +    for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += 
>>>> pages_per_xcc) {
>>>> +        u64 start_page;
>>>> +        u64 npages, n;
>>>> +        u64 pa;
>>>> +
>>>> +        start_page = cursor_gart.start;
>>>> +        pa = cursor.start + adev->vm_manager.vram_base_offset;
>>>> +        n = 1;
>>>> +        amdgpu_gart_map_vram_range(adev, pa, start_page, n,
>>>> +                       flags, NULL);
>>>> +
>>>> +        npages = pages_per_xcc - 1;
>>>> +        while (npages) {
>>>> +            amdgpu_res_next(&cursor_gart, n);
>>>> +            amdgpu_res_next(&cursor, n * PAGE_SIZE);
>>>> +
>>>> +            start_page = cursor_gart.start;
>>>> +            pa = cursor.start + adev->vm_manager.vram_base_offset;
>>>> +            n = min3(cursor.size / PAGE_SIZE, cursor_gart.size, 
>>>> npages);
>>>> +
>>>> +            amdgpu_gart_map_vram_range(adev, pa, start_page, n,
>>>> +                           ctrl_flags, NULL);
>>>> +
>>>> +            npages -= n;
>>>> +        }
>>>> +
>>>> +        amdgpu_res_next(&cursor_gart, n);
>>>> +        amdgpu_res_next(&cursor, n * PAGE_SIZE);
>>>> +    }
>>>> +}
>>>> +
>>>>   static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>>>                    struct ttm_buffer_object *tbo,
>>>>                    uint64_t flags)
>>>> @@ -1017,6 +1078,39 @@ int amdgpu_ttm_alloc_gart(struct 
>>>> ttm_buffer_object *bo)
>>>>       return 0;
>>>>   }
>>>>   +/*
>>>> + * amdgpu_ttm_alloc_gart_vram_bo - Bind VRAM pages to GART mapping
>>>> + *
>>>> + * call amdgpu_ttm_alloc_gart_entries to alloc GART dynamically
>>>> + */
>>>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
>>>> +                  struct drm_mm_node *mm_node,
>>>> +                  u64 *gpu_addr)
>>>> +{
>>>> +    struct ttm_buffer_object *bo = &abo->tbo;
>>>> +    struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>>>> +    uint64_t flags;
>>>> +    int r;
>>>> +
>>>> +    /* Only for valid VRAM bo resource */
>>>> +    if (amdgpu_mem_type_to_domain(bo->resource->mem_type) !=
>>>> +        AMDGPU_GEM_DOMAIN_VRAM)
>>>> +        return 0;
>>>> +
>>>> +    r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr, mm_node,
>>>> +                     amdgpu_bo_ngpu_pages(abo), 0);
>>>> +    if (r)
>>>> +        return r;
>>>> +
>>>> +    /* compute PTE flags for this buffer object */
>>>> +    flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
>>>> +    amdgpu_ttm_gart_bind_gfx9_mqd_vram(adev, bo, mm_node, flags);
>>>> +    amdgpu_gart_invalidate_tlb(adev);
>>>> +
>>>> +    *gpu_addr = mm_node->start << PAGE_SHIFT;
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   /*
>>>>    * amdgpu_ttm_recover_gart - Rebind GTT pages
>>>>    *
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> index 25640bed7dc9..9f07856433fd 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> @@ -140,7 +140,6 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device 
>>>> *adev);
>>>>     bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>>>>   void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>>>> -
>>>>   int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
>>>>                    struct drm_mm_node *node,
>>>>                    u64 num_pages,
>>>> @@ -191,6 +190,9 @@ int amdgpu_fill_buffer(struct 
>>>> amdgpu_ttm_buffer_entity *entity,
>>>>                  u64 k_job_id);
>>>>     int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>>>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
>>>> +                  struct drm_mm_node *mm_node,
>>>> +                  u64 *gpu_addr);
>>>>   void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>>>   uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, 
>>>> uint32_t type);
>>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>>>> index f78b249e1a41..edb72f4ef82d 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>>>> @@ -225,6 +225,8 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, 
>>>> void *mqd,
>>>>             struct kfd_mem_obj *mqd_mem_obj)
>>>>   {
>>>>       if (mqd_mem_obj->mem) {
>>>> + amdgpu_gtt_mgr_free_entries(&mm->dev->adev->mman.gtt_mgr,
>>>> +                        &mqd_mem_obj->mm_node);
>>>>           amdgpu_amdkfd_free_kernel_mem(mm->dev->adev, 
>>>> &mqd_mem_obj->mem);
>>>>           kfree(mqd_mem_obj);
>>>>       } else {
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>>> index 14123e1a9716..5828220056bd 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>>> @@ -148,6 +148,15 @@ static struct kfd_mem_obj *allocate_mqd(struct 
>>>> kfd_node *node,
>>>>               kfree(mqd_mem_obj);
>>>>               return NULL;
>>>>           }
>>>> +
>>>> +        retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->mem,
>>>> + &mqd_mem_obj->mm_node,
>>>> + &(mqd_mem_obj->gpu_addr));
>>>
>>> Here you create new drm_mm_node for gart page table entries. Before 
>>> that amdgpu_amdkfd_alloc_kernel_mem also creates gart page table 
>>> entries and drm_mm_node. Is there duplication or how do you handle 
>>> the entries/drm_mm_node from amdgpu_amdkfd_alloc_kernel_mem?
>>>
>> amdgpu_ttm_alloc_gart allocate GART entries for GTT domain only.
>
> Why still need keep GART entries for GTT domain if use vram bo through 
> GART here?
If MQD allocated on VRAM, amdgpu_ttm_alloc_gart will not alloc GART 
entries because this check

     if (bo->resource->start != AMDGPU_BO_INVALID_OFFSET)
         return 0;

bo->resource->start is AMDGPU_BO_INVALID_OFFSET only for GTT bo 
resource, VRAM bo->resource->start has valid value.

Regards,
Philip

>
> Regards
>
> Xiaogang
>
>>
>> Regards,
>> Philip
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>> +        if (retval) {
>>>> +            amdgpu_amdkfd_free_kernel_mem(node->adev, 
>>>> &(mqd_mem_obj->mem));
>>>> +            kfree(mqd_mem_obj);
>>>> +            return NULL;
>>>> +        }
>>>>       } else {
>>>>           retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
>>>>                   &mqd_mem_obj);
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> index 06cd675c9e74..55738b30c2ec 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> @@ -253,6 +253,7 @@ struct kfd_mem_obj {
>>>>       uint64_t gpu_addr;
>>>>       uint32_t *cpu_ptr;
>>>>       void *mem;
>>>> +    struct drm_mm_node mm_node;
>>>>   };
>>>>     struct kfd_vmid_info {
>>

