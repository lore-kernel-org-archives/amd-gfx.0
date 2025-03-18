Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28945C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 15:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A7410E212;
	Tue, 18 Mar 2025 15:08:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bWZYPwhG";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A54C10E212
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 15:08:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXuyTRDtiVhIbHrXoPDlb5kj9lBe1gnFNVP+JvxHo02tKs9wcELKcrCvvvbrZIkdC5wwdXJhyZWQHRFhfXtFvbzq8bHVTjaMP1eGfteKgeMTl0eSoSEvpKbpBlk8TVvJ6srrCaOlURS0M7mFUq7SJ8TgQkJJA8iPhkHBqOj4sSgK+UwnNpb05kMXeqt86DJ1F8U25uJ8K+QiKqLug4GiogJnipamokBzA3WPzX3LcD9fm61eKsCohMi+LEnK6gkIbmuhBvp/D7918Zt8orxsF77M00P0AIbs/mG+KirxeqBFWRmQYwGdOMi+JQaM3OIPSR7+x/laKr+J3kNXkCxhkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9xrEEro5D2hNDhpHDqMDK71KaZAptkK/eawPzhS8Ug=;
 b=PmSEo8LapSBTF/v3NVcEqpdaTkR3GpLV3VK2E4E8KdMWJCqUcSWCyGgbgKAhP0nQ+4U/+IM1Dx/55ggFW5kgRxfhJBQAozI/waLNlbzR7RsXSSrlfmW+/Y3l10u7iFz9RSjkzyStVj8zQNEF3N+wlKckTlvWcB3MWwTb49JytVFKrmcYHvz/SP2CAx6/sovB48a6TSIELQG7t7iIwQ3pz6dCzL5S4dZHc5zk1LxU5ODbksMcPs4vGz7hp9ZPma33W7CObusrbkEnVZkwZ29xd9FnfawkTlkTkm0/J2zWDuwx6PTqlAPTEY8pNvr0ddgDD7igKLTb04mj1/hkN47yzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9xrEEro5D2hNDhpHDqMDK71KaZAptkK/eawPzhS8Ug=;
 b=bWZYPwhGV2JoB377tyFyBYAZmKe9ugz7DNYNPlOlmftprcGJ/E1x4IhVMndrsdw1M6HJG8l3LLKI83N7wVFEjCj1lguhTaM+byWuhUMUQ6Gp9OQUGWXdkUIHaaywNftj5zY1waNMrT+0oEnMHUhbdh23N9G90iG6llF5mkL9ypE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6287.namprd12.prod.outlook.com (2603:10b6:8:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 15:08:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.026; Tue, 18 Mar 2025
 15:08:18 +0000
Message-ID: <06a9fc7d-2aa9-42ca-9493-09d0735834ec@amd.com>
Date: Tue, 18 Mar 2025 16:08:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Where do ttm->pages come from?
To: Matthew Wilcox <willy@infradead.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <Z9h54wu2Nqbf4OqF@casper.infradead.org>
 <fc78716a-c3ee-40e5-a87e-4068e362aa5c@amd.com>
 <Z9mK3OfAxilKqJci@casper.infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <Z9mK3OfAxilKqJci@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: a8791487-2cd8-4055-ba98-08dd662eb6f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGRjSnhTN3RWOWpsM21zVkd0K0xpMjZEd0pQaFpKWTlxbGo3WVBNUzMvUnpV?=
 =?utf-8?B?REM1L2lKWldqNWpnUGsxaVVhNnFTK3YrRU8rck84MkpxaW4reFFuRWZBNlhS?=
 =?utf-8?B?bnFHTDJPcTYwTDdCNkdmZlRCK3VhMFVQdTlzYUZ1RWZ2UEJUQXNsdnRGc0Va?=
 =?utf-8?B?NllXSC90YmF0REdZS28vYkRHV0REZ0FGOUdiRWZDOXp1ODI0NlBNank3NmJ3?=
 =?utf-8?B?UE8wUHRnT0FUZ0dlR21JSEZZd0JUTXI3Ti92MmlDNitaZ2VhbWFCVU53eENr?=
 =?utf-8?B?MXpnbVllZ3BDWWZtZ1NSVHNqYXRvUUhTWC9FOUMxMExrWWxic3duYmtqUm0r?=
 =?utf-8?B?UllwSGM1d0pHb1N3WGtBajlRRGliTkhWTzdQYzE4RmRSVGhIcGh2cEwvK0Qy?=
 =?utf-8?B?bFVtd3JXaWFmVUtnYkc3T2QzRUwyNVVpTFcyZzkvNmZXcVR1ZW9IeFVMR2R5?=
 =?utf-8?B?UGFtcUUwZUlNUm9VUE5IbXNsZzNJS29KRVIzc1FlZlZuQXp2Sm9nRE4xY0hO?=
 =?utf-8?B?YnAyNCsvVy9HQ3p3emZGMWJBVWN0Q0oxOU9HYysxRW8rRnVSRFZUWUtUQ21C?=
 =?utf-8?B?a2hudVkyYXZkbDljQW1QditBeEFBb1ZVQnUvOHg2QWMrVkJZTFltUEJIV2Nm?=
 =?utf-8?B?ajZxeWo2S1IzL05GMm53aW9LMEZNWGU1ZGxyUU9oSGFaNXNNYWRkV2pNaEox?=
 =?utf-8?B?bVpqS3NWbVRaSVEyalZYWTRtOFB1b0xEc0JtZ2tIcnBVQ1VFWEhYZ3lHMnpw?=
 =?utf-8?B?UlJ5bC9TNEkwbklsMmdRUzM2MVNTSnRxMW8vcCt3d1FsMzBoNDVOeHVKbElm?=
 =?utf-8?B?bjE3cjNiY2M1YVdGeVF3TzJGYklpOHUyYW1WY0lFblFmcGZaK1NJRmJqNlUw?=
 =?utf-8?B?bTJ1d3A0Z1daMUxZSVJ4SUJveklrOUNFREdMOWdpRFJXcklhcFlVVDZiNG5Z?=
 =?utf-8?B?OFUwa0MzM0c1bUw1UE9zSEJyaURCNkhpeUZFNjBiMytKM1VUb0R3R3B3OGw0?=
 =?utf-8?B?NWYzdzV6bWhQcFVxdXVBcmhnV2ZLMnk1WnJQYzU4ZTBMVjZUb2x3WnhLOXlW?=
 =?utf-8?B?M004RTBTTW4ySHZML1BNa0dROTdHdy92dTBoZHVldk5TK2RlMzd1Ui8renNi?=
 =?utf-8?B?T3hObytLNjVjallkN3hUTzJqbllLOTd1TTh3QU5xMnQ4dFBEb3lMK1FOcUpH?=
 =?utf-8?B?ZHdidXdJVWVpVUJadDBoTkEwUld0VlZHTUsrS2FzQ3ZqcVBhQU94SUY2NUVC?=
 =?utf-8?B?VVBDOURBajBQd2hMcWlPaVJWRitrVGhOYWFvckpoeGhyV201TzY1dlhhRUdG?=
 =?utf-8?B?TS9RNzMzaFZKdFhLVGMxanZjLy9vNk01eFJzVFJmNFRUOHY3dWc3TUxLTGd2?=
 =?utf-8?B?OFFpOVNWRXErQ1BtL253d202VlNtODg1ZzAyQXh3K1hVRlVwNExRRWl1Nktx?=
 =?utf-8?B?Ymd4MmlaS25VUDMyNXFQKzhEVmtVUHRpTGFrQzFKd0ZHdVBucXIwdlNoRWQ4?=
 =?utf-8?B?M2R2a2FtQ0lhOE1SVGhtOGs2bXRjRzg2TGN6UGs3TXhWRHdOcmx6aFQ5REx6?=
 =?utf-8?B?ZEdVdGVsVm11bDJoMURuSGtsdDE1M25rYmxqNTNTc0s4Q0VVREtzNkdaVVNX?=
 =?utf-8?B?b0pwQjhRSEZhbklESFkrN0pHRTNWNEIzT0E3UTVxUjRqOFlkaTRIUEYwNWJq?=
 =?utf-8?B?Z01kZDlUTWROazJYamFrWURFcjNLZlA0TnJWVjFmbVViUHRNRjdVRDVoSXhs?=
 =?utf-8?B?U0tpcnA2SmQyRGlxT0l4djM2RXFXNEt5cGxwdGtnK09GZDd3OGUrOVFGSVN4?=
 =?utf-8?B?UTZJb1FPRWZ2aVQyU2R2Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFVPR2o5UDNnMGI5S2dWUytpbWpkTXk1NlN1VEQ3SlZPWndZLzFSenpOVGxj?=
 =?utf-8?B?TkxjdVN0V1FLeWdhK25TRElIMGloaUwzNzBLRDUveVVMeFF2cnh3T2htTkUz?=
 =?utf-8?B?b1NwU2Fxbm1ZK1BIRm40clY4MXNaYUovS2swL3l5aUUxNVU3a2F1Q0lJUzBQ?=
 =?utf-8?B?UVRpZjhaZDkvMDhaWlRHMExSSjZaTW1MazFTTFFWbUZwRmw2NkFvd0ZwQjNp?=
 =?utf-8?B?ZWl4ZHBjYW1jQWd3RXg0ZTRZQ1VjVmZvT2tqUldDL3FZTFVBaExjYVIrQXdW?=
 =?utf-8?B?R0laSkpBOFVjMEJ6SEFVZVZTeUpPQjczSlpMaTJHM09EemxhQlR6M2lzM1RR?=
 =?utf-8?B?SlZjbThzRU5LNWFVSC9CcTdWUDFnN21NcG9yeTZrSEJoQWlZMjBwTktBOVpE?=
 =?utf-8?B?MExqWkFKWU9VWHlBQWNhcUFlY3Fnc2c4bHFROUNURndKdVJvVzZWWXcvTUo2?=
 =?utf-8?B?Z0JzTE5KVFlNS2twSlBmaGlvNGxiSnNOa1p3Q0c4K21OV3VPMGhEbUdGaHZw?=
 =?utf-8?B?ZXlwTVprOHNQMTJJL1JkY2l4WnhPbkwxeHlkZE5qVEhaTlV4Tm4xQ204ZG03?=
 =?utf-8?B?WExmMDJjOE1xbFZUSllPaFZwRVM5QTFMZTVFQW9zSkNST3BxV0VhL0o1YUo2?=
 =?utf-8?B?eXJwVThTdStCenpNVUM0ZnJIQWJrcU90Z0MrNlQvMmo1eTIxdE1HOFRqbWRj?=
 =?utf-8?B?S0IySjhEU3ppeEdVWVlRY1JxcjRRN3c3SUZQZlp6RVdxNUVUL2FVMTJzU0dJ?=
 =?utf-8?B?eU11eHN6aVVRWndGcy9tMWxRaTR5dFpHTVNLSTdsNmMzaXowYWpoZVpTVWlR?=
 =?utf-8?B?c0ZTa3dDNHA0dkpxNTB1RUhKVGlxcU5PZlQ2Q3ZpZC9FNDJ3Y041TzNIdzd5?=
 =?utf-8?B?QnRQbTZOeGhYczdDQjN2RnNzenVFOHZ6cUFxME0vVDNwSDFuQ1FVNUF2eWZ1?=
 =?utf-8?B?emhFZlYxblUycTg1ZENJaVl0RW05VlQzZWlqNXZwbzYwYjRrU3lQa3RsbjR1?=
 =?utf-8?B?TlpVaTd6NmhONk9hZHdPak55TnpzalA4QzJPWmZ0WWI1RVBuWVhCMlZwTWZZ?=
 =?utf-8?B?T1JxK1FibGZnNHJVbmdmTUhhbG5Nc0wzeWs5UU5Nekk2WDNJK3F0dk1HV1k3?=
 =?utf-8?B?TlJhMUxGMXh0NkEzR2laUzh1QzFXQ25MWHZvVVhJc01aaDI1WnErcW5JQysz?=
 =?utf-8?B?RXJkeDNoTlBaY3pKTkZEcmcvbVFGWHFabWwyQjh3ejBJMXBVZ0NWTktSQ2M2?=
 =?utf-8?B?UW5wN2Q2TUIxdnhZNTFIRC9mL3VLaVIrTldrK1R3bkdoT2hmNURZY256RGZr?=
 =?utf-8?B?bk9WUlRrREpEaURLbWhtT3JEVVpGSDNxbDlodFlGZGtPYmhqK2s4cFVCTExF?=
 =?utf-8?B?L3pWaXdpeWtjK3l3SWtjUkloZDRKbGNyN04rSzZqS2dybnZkcjlDbk4wbm5i?=
 =?utf-8?B?K1kzSUpXSzVTWG1mOWprWXNRR2dyREpIRTh3WktXMnh4elQ5dmtUbDk4UVBO?=
 =?utf-8?B?enVuaUhrbWIxZytZWFJDSDFGQXJXbHV3bWMxRnE0T213YjIvM2t2MzhRcEly?=
 =?utf-8?B?SXBRS3hjVVB2V2piWWxhdUxEQ2hpTmJ4SEgrKzRqUG8vTC9WLzExSUMzejFj?=
 =?utf-8?B?TDE2bHF1MDFiQTBNZGxDYm00K2ExU3RwNHJESy91SmdxZ1hLY04xTlgzYmhw?=
 =?utf-8?B?YW1LMytISlc5OHQ3Q0V6THZMWGxRUFgxR05OcFdKZHhtSkNSMnd0WitJNUdS?=
 =?utf-8?B?eXhqcnFJbjl0andMbk9BOUdBbTJZODdFQndPUUYrTlBpTUgzOExVQWVjK0tu?=
 =?utf-8?B?ejFrVDdUaE9tR3hjdlYyaFNzcVFLOGQ2Z0MwNFRmZmkwaW5MZU81WitVdEJx?=
 =?utf-8?B?aG5QYjFkaEtZWldDdXlTZm42aUdnRFZmTlMxelJIV2R0cHhud0dkb3cyclc2?=
 =?utf-8?B?aXYvK2psQ0pmWVladmxuSDhyK2pwT0Y1b2dtT1BHRFhTVWFxSmMyN28rSXlR?=
 =?utf-8?B?dDkwZ1diRTlZWXVyTFBWSVYxUjZsUGF2dVlzOFE5b3NkZ3BNUEVuOXllN0xJ?=
 =?utf-8?B?MFlHQ2F6ZENhNzZVSkVUTGE3NWRSS2hPNWJRM2dMYm5xQmtBL0Y5M1JSSytC?=
 =?utf-8?Q?9QJRbbanaTqZeMQtSbKxF6EdH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8791487-2cd8-4055-ba98-08dd662eb6f3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 15:08:18.1946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7B1K53AUSugK6sQRMJkMwSRbfRIqqcY2vWzpjMm3+DHJTSRZz9Echwr6a9AenQy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287
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

Am 18.03.25 um 16:01 schrieb Matthew Wilcox:
> On Tue, Mar 18, 2025 at 09:37:42AM +0100, Christian König wrote:
>> Hi Matthew,
>>
>> you actually got your understanding exactly inverted :)
> Thanks; that's very helpful!
>
>> Amdgpu takes a look at page->mapping to make sure they are *not* coming from the call sequence starting with amdgpu_ttm_tt_set_user_pages() or be imported from another driver through DMA-buf etc...
>>
>> The only pages which are allowed to pass this check are the private driver allocated ones, see this code function amdgpu_ttm_tt_populate():
>>
>>         for (i = 0; i < ttm->num_pages; ++i)
>>                 ttm->pages[i]->mapping = bdev->dev_mapping;
>>
>> So far that has been save since nobody else should be using the address space object from our drivers inode under /dev.
>>
>> But when you plan to remove page->mapping we probably have a problem here.
> OK.  This makes the problem a lot more tractable.
>
> From the MM side, we have a short-term and a long-term goal.  The
> long-term goal is to reduce struct page to a single tagged pointer
> called a memdesc.  Details here:
>
> https://kernelnewbies.org/MatthewWilcox/Memdescs
>
> In the short term, we're removing page->mapping, ->index, ->lru and
> ->memcg_data, leaving ->flags, ->_refcount and ->private as well as the
> newly-introduced ->memdesc.
>
> So if all you needed to do was identify which pages belong to you,
> I'd suggest setting ->private to a unique value (eg bdev->dev_mapping).

The problem is ->private is already used for something else in that use case. See the code in ttm_pool.c.

> But it feels like you need more than that; you need a refcount, and you
> need to map pages to userspace.  Do you need to support GUP on these
> pages (ie can it be the user buffer for O_DIRECT, can it be registered
> with RDMA, that kind of thing), or is this memory just for userspace to
> do load/store, and no fancy stuff is allowed?

GUP is actually strictly forbidden. We have a repeating problem with people trying to enable that and running into data corruption after a while.

Userspace mapping is just using the PFN, so no refcount needed either.

> At this point, I'd suggest that you allocate folios rather than pages.
> That lets us continue to use folio->mapping to distinguish these pages.
> There would be an opportunity to save some memory in the future by using
> a slimmer control structure once we understand the new system better,
> but maybe it's OK to just keep using a folio forever.
>
> Thoughts?

Yeah, switching to folios in TTM is on the TODO list for like as long as folios exist. But that is easier said than done.

Regards,
Christian.

