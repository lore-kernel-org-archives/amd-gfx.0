Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B220FC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 11:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B60F112B99;
	Mon, 29 Apr 2024 11:11:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j7TLlOCn";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C821C112731
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 11:11:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RV4xB3oMvEX2nay3eEeco5RFfCTA34PD+DbWfSk6Z6YOGX84BkW8Vf74miPkoZsBLd3o2T/456W+8ngfnaeCsBgbFbVvvt4h4mIlLdxR3wezkQqQ1DBoOpZ32YpMCgIxvyZtULwXB4r/bK6bkS8YIh2BiOqFI63rOnTusvPzR59TOtgSuohHbx53ZtRtW8kHXwdAvsAdmAtPluAYroPi3tkhIP1uIEEfhLwijD8UvqDzQ3HEjmb3jduZmy5ry2BudCf/Pt5Va9lyoTGnv4Edxq8gY9/bzTZ/iusRj2U8qpV4dBe5vvLe4YF8ScMwuL+390qkGH3rFMbrj8NA71MVuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2iqGNWjunY0QC1Uwa8bhZY0tXagVui6kxe9NMyNOvM=;
 b=SvryDSafuoYDNan/vAbFMa6dMKl4cA73PAcr7dFhk855z6nH3a+WmXu6jObntdvQdBxQ1fec541/fXrfMjdEgSH2E372lYiX+y+5Bi4Ez2inklQZSFbPUsywwqrT34Eg+DbAsMwg3/y8tzzirT6vQOE97YvCHAs60z2xX42fvm2KED55my2UsXRtehapaap+mu3N9UiRLK3BPIhK9IaqhDNsAusU0pcZYRLLNmVSkGIpPTYwiIknVwZ8hID2nzrAzTcIy6PEis6PJtoZ2ffDchwHIMWG7GgD3WApp+lSkaTlZfefY5SCvl3mTG8Lz80SdAMXD3U9ANAuhNlJrXK7gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2iqGNWjunY0QC1Uwa8bhZY0tXagVui6kxe9NMyNOvM=;
 b=j7TLlOCntfBaTKxZAcWwTzGjlAY5eVeOMgrj0T+s+HruFIfJhQhT52Xm0ZCNHnpYicgrD0W2ZbcZs6MYEBLoFQUUFmZVAmSoEcwe7bRNErvn7uZFfp+Sl/AOarHRJy2pGR0VB5Dtw7LS7Aa0VuzhKP80rGAQa6gruVgT4nS8qf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Mon, 29 Apr
 2024 11:11:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 11:11:39 +0000
Message-ID: <494956d9-7055-4384-a569-1381bf0380b3@amd.com>
Date: Mon, 29 Apr 2024 13:11:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Fix pinned GART area accounting and
 fdinfo reporting
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Tvrtko Ursulin
 <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com
References: <20240426164355.1563-1-tursulin@igalia.com>
 <20240426164355.1563-4-tursulin@igalia.com>
 <a60dede1-8e81-4c79-8058-257391930621@amd.com>
 <fe80a8db-3ece-4818-8b23-2ccf5293a6c2@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <fe80a8db-3ece-4818-8b23-2ccf5293a6c2@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 94267d46-48de-4889-7b93-08dc683d2473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YW9EblF5T0lvZjFod1ZVT2FMQmMvOXIwOTg3QlFZUVFCYmorRExNU1VBRFkz?=
 =?utf-8?B?bXlITDFIdk42ZUI4Ri9EdUxhTUNmVDlsOWxQVGVHdDJNVHJ1S0hXa3E0MU50?=
 =?utf-8?B?MkgxeXM0QlNZNWxUS1h5eWtIUWUyYkJmY3MrVDZ0dXV5d1FJMm92K3lxaGU5?=
 =?utf-8?B?S0JlUlF3Q3F4VW94bFhtU1Q0UEVyb3NhWW9adlRZQmVkYjc5dHpDdUcxYi82?=
 =?utf-8?B?Y1dtbVEya0lHcVZibHRCTXBicVdJbGJKc2ZGWXdCZVkwRHhoUVVzR0xHWjA5?=
 =?utf-8?B?Qm5oSERkdS9aeUNRUzAvZnE3MitSNVh5UGh5TDBDeUsxbGlnNXBDdjFyT21I?=
 =?utf-8?B?b3YzZGNSZXpmeGZtY0syaG1NMU1iaFJqQkJXWHBZMmN6dTNxUjc3Q1RzZ2Z0?=
 =?utf-8?B?MkVVL3JnbFdIRkdjc3hSYlcvanZBVHdsQmFEOWZLQ3d2OWJKdVNXQlRqQnI0?=
 =?utf-8?B?bHE2Q1F2VE5RMlY5VVZyREhmL0hHQ3h0RDlsUituRHVCNmJDenV3cXlGZ3Nj?=
 =?utf-8?B?Wm9EWS9hNDU3bzBSMlRuTHRhRGhJZlhnRnI3MEc5Z2NLYllNUFduRDk4ZTJ1?=
 =?utf-8?B?VVMydjJqMnNDRHVUOVl3SW9Ld0RKbzBKd2p3ZGZab1BNazMwTzRreEJxeE8z?=
 =?utf-8?B?SUlwZmtMdEs3NXBpTU93RDVXQUF5MENoUy9tWDVsL1I1YWMyb0h4eUswOEt6?=
 =?utf-8?B?Ykl5bTlEZldjdGd4RnBibzVXLzdpcjZUOEM3cE9pRHR6YXhuZ0Z4T3hRellm?=
 =?utf-8?B?VDZmMjQrempsczVIaW1JMkZwZVp3YWFUang1dTEwd2ZBNzVYeDlKY2RUSUVi?=
 =?utf-8?B?SVVGTXI3cElxeHJPSkNzQm9FbFBVSjl1dXAwVXZMR0RtMWNYeGtaTU14SXdK?=
 =?utf-8?B?WXhJVHhaUnNSYzAwTyt6QjgxbkQrZEFsbW5ISXZNdDNkV29OaEh5Nzc2RG5y?=
 =?utf-8?B?ZFBoRmlxM2VRLy9YOG9zbndVbllGa1RaSHJqd3JzaHMzaWcxNUovQXdzQ1FS?=
 =?utf-8?B?WkJkb0Qxbm4xS2RGZ29DbWlnUlk2UUFWeHc2ZHRra2xwVTNjMkZHRFBYMEVx?=
 =?utf-8?B?dlpQZnA0TmxTYjZrZkc5aXRrb3Fpa3hTZ1JaSy82cGMrSnVvS3dDNDBoY1hU?=
 =?utf-8?B?V2JGb0dXSWFGTUc3OWtTZkl0NG1VbmRsSkJlQ0Z2RmJiY0hGckQ1cFBvamNN?=
 =?utf-8?B?bXdvMFJpY1JVaXZrSXE5ZU51SHFtQ2ZYdDlubjVPNkhtRkcrS2RaQlQ5akZZ?=
 =?utf-8?B?UnljUERPY25LZk5zNzhTQ1JlbWNQQkg3NzBGM1ZzcGxUR1Y1RDR1MmhacFlv?=
 =?utf-8?B?eFhobHRpK0Nsa21aVHpZVHhoT1lUaVZqS0VidXZmdDFXaGdDaGtyMVNuQmY4?=
 =?utf-8?B?SERtNVNVZzBoVGhTYWl1SVpucVZlOENLZlBSY0dNZnBFWnJ3c0pLcE5SczVD?=
 =?utf-8?B?eTJ0NUNCMEFObUFhNlVtWmRGNkhMNThoWmVSbGFoYnVlQXl4TGNONytvSW9V?=
 =?utf-8?B?cC96TjJ6aC9qSXhpTVVzaUlyK1BySENXK3JHcFJrT1FzeXU4bk9WVlBMdFZQ?=
 =?utf-8?B?ajlsRDJjdFhaM2Y2dnhEelc0bnoydXIzZTJ2TEdKU0hZakczenppZFdWN3Ri?=
 =?utf-8?B?T0w0bzJPZm1jSVdUTmxNM3g4S1lobTJnNzZETUthWDRkUEk2OGFibDhmdTht?=
 =?utf-8?B?SUFXUGJ6NVN1Y1ZKcHpZVjQ5dGJKdE5CUWhISEFPWW8vUk5oWExLcW9nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGcyY3BmRVJ4ek5VYmp0WHFBZVdLZzF4SHl2SmlKNi9HTjBuMGxQeFhlVDRk?=
 =?utf-8?B?S2UxM1R6TXFGaGJlYTc5R3pwUUNvUTdSRHowZXVaeUh5eVhYYjV2TzdkYWxG?=
 =?utf-8?B?YnJLbjBWcUJtYmhkRVNXVURiMnlic0NhRnhNU2ZKbkxGV3B1RUpScFRXcjZ3?=
 =?utf-8?B?NUVBbjd0WWJ2SFVWRENDZGo1ZjJOVy9zSlFpMVdsY1V0dHMvMTBHRTBzZG1r?=
 =?utf-8?B?NzBFL2R0Z2VwQkw0RnNpaXNuZkxEWkNrbTJpM2NOYnN2S0Zlc3VGYlBUbEpM?=
 =?utf-8?B?THg0K2hQVmQyOUlJamZGbVU4aW5Ud2JKd3U0Q0lWSndKNkE5alFLcEtiSWN0?=
 =?utf-8?B?M2dmUEovOW11aHoyWnFnVGR0S3JVamxqR1h5cFo5ZjhjaC9pN3U2KzRqaFlE?=
 =?utf-8?B?SVNJbWs4amw5MHRWenQwQjJkVGlEbWFYQ2I5azdzeG1KVUdHb29wODRxUVBC?=
 =?utf-8?B?Tk9oWDFzcnZOdlpRZ0JqQVNCekhiRDdTS3JyOHhBRnkwOXJWVEo4aHFOVmxZ?=
 =?utf-8?B?bWJRQ0ltVmpKQWVaNlNGYnFnL1djaXlYbmFmUGl0bG1IdFhMOUlKTmU0UW9o?=
 =?utf-8?B?L0tuYnR0bnI0NFFham1kSTduWmUreUhpNnpiL1FkQ3dYZm94TnlSb3paelpu?=
 =?utf-8?B?MllaZWh3RkNxSUFOR1RLWGprWWxLOVhncEJycS9oLysyUDhMT0M3OXVyWWxm?=
 =?utf-8?B?dUlZaDZsd1FXQThtY0ZsVEdEeUdEZ1dwOS9URHBINVdUR1hBRDNqVUJGbWY0?=
 =?utf-8?B?NHFlalkwWFhMVk04K2trMWdzM3pMUmZzNHMxdUhEUENnZUZmcFdWUjVqeFAv?=
 =?utf-8?B?YWIvWVRRVnpZbEx4TldyNEsrWWdheWppVmdLZFVtQ3hOdTRoazc5Znl4eFJK?=
 =?utf-8?B?dzVIM0EweFhVMzg2T2VRL2RFT0lJd1JEb0xOdzh6MEttNGdOcTc0djJ3MWlp?=
 =?utf-8?B?dENrMjViSC9kVklVYkR1QTFPejk3bjllbFFIa0hlRktCaWFZSXVGQ0taZS8v?=
 =?utf-8?B?ZThieGFyeS9MaURUQ1YzQldjRnhlSktnbFdac0Z5VldsaHNzRHlnZWlyYzAz?=
 =?utf-8?B?WHV5M1U2WFNxVVR0WmpyVnJrbGo3RytYK1hWME1oMk56NWxOUVFKaEhUc2Ur?=
 =?utf-8?B?a2J1emV0Uk9WT3FmZE1XSlgzTmd2NCsxNlFhUHFGOXEzOVd1WkhrdU03RXVt?=
 =?utf-8?B?VkdNVGw5bG5qRkZiRTVzTFdISkhoMmhTekt1UTNZUzBqajI0d3lMREJ1WmZT?=
 =?utf-8?B?RTBodkNGVVErVHlIRkQreUNTdTZwNEQra3ZSb1JLY1pvWEE5dnRZWisyWWdi?=
 =?utf-8?B?dW5PSkVORk5peDZDQ0dRZXRwakJVdXRVSmtkYVI5R242c3JRZG9ydmMwOEV3?=
 =?utf-8?B?eEhITkw3c1J2VmhiT1hCcEN3UzZadnhZeHVNZi96Rk1QemNpQkJzMmI2YXFx?=
 =?utf-8?B?bDRwRHN3UVpuaU1OOEJ3Njl4NEU2MHVESHRMVE51S2c0NkJLREJDZVNQMU4w?=
 =?utf-8?B?eDBxOEhUWkV3UTVJOG1EUndLOHFGRERRUGEwUVV3UFZ5ODgva3YweGdVZnpv?=
 =?utf-8?B?Y1FhY0xyYWFsMHJtMlJvcmZYbjZQQ0tqSWdnYmVKVmxqdENrZ3lpbVJVenhB?=
 =?utf-8?B?L0VMZDNyREQ5R1ZZaGR1SDZ2V211WDJBR2V2L1ZrcnBGRVozamVLRFNCK0ha?=
 =?utf-8?B?Mnl4TWFaN0Q4UlZjLzcyV0dpVHFrMWlqanJlNnVrUzdmMWM5c2JkdVZGWmdv?=
 =?utf-8?B?K0R4ZjUvd0Flcm1VM05RQVVKaWVQelRJNTVaQTRXWEZpS29RMHdybGdKRlhv?=
 =?utf-8?B?YUs3WjAreG1yUzdQaVkyMC9oOHlRM0lTWmRhNnpxbkdWRTZQL3R6UlRPQ1V2?=
 =?utf-8?B?cnVRbGtIblU3N2IzSTVZd2xkWmZKcHdidmxScGcyL3ZJb0pyTS9EZVJRd0R0?=
 =?utf-8?B?c3pldjAxSUUveVN5ZDBjSG5oR1FlTEl1TWtsT0R5RFNhNHEzcTRUbElITkdC?=
 =?utf-8?B?Q3gwdUpjdkJGdnI2OUZIaVRLbDJGdFZFeDhHYUhzSDZDOGtmRitmMkkveUhk?=
 =?utf-8?B?R2V4cFRwQldBMCtUYkZMamxFQWQ5aEFVK0MzTmNkYUphanJLRFFVaVlrSHFQ?=
 =?utf-8?Q?sC3M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94267d46-48de-4889-7b93-08dc683d2473
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 11:11:39.5146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfSlliwMlBQgY0g3fsXmjO9BhkiRgKZh5Adnrhy9N2Iu8ITB4QMCC9UKBigst5MM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337
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

Am 29.04.24 um 11:43 schrieb Tvrtko Ursulin:
>
> On 26/04/2024 23:24, Felix Kuehling wrote:
>>
>> On 2024-04-26 12:43, Tvrtko Ursulin wrote:
>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>
>>> When commit b453e42a6e8b ("drm/amdgpu: Add new placement for 
>>> preemptible
>>> SG BOs") added a new TTM region it missed to notice the conceptual
>>> imbalance in GART pin size accounting as done in amdgpu_bo_pin/unpin.
>>>
>>> That imbalance leads to such objects getting accounted against the
>>> resource, but are not un-accounted when unpinned.
>>
>> AMDGPU_PL_PREEMPT is mostly used for userptr BOs, which cannot be 
>> pinned. In any case you should make sure that the accounting is 
>> consistent between amdgpu_bo_pin_restricted and amdgpu_bo_unpin. This 
>> patch breaks that consistency.
>
> You mean amdgpu_bo_pin(_restricted) and amdgpu_bo_unpin do not run for 
> such objects, or something else?
>
> If they run, then at the end of pin there is:
>
>     domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
> ...
>     } else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
>         atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
>
> And unpin has no handling for AMDGPU_PL_PREEMPT.
>
> Ah I see.. does it rely on amdgpu_mem_type_to_domain returning 0 for 
> AMDGPU_PL_PREEMPT? My confusion was I misread the pinning check as 
> checking the domain as stored in the bo at creation time.
>
> Although I am still confused by the statement userptr BOs are not 
> pinned. It is not needed to map them via GART on AMD hardware for GPU 
> to be able to access them?

No, a GART mapping is only needed if you want to scanout from them or 
otherwise use them from the kernel on the GPU.

Background is that the kernel doesn't has VM with page tables..

>>> Fix by extending the accounting criteria in amdgpu_bo_unpin.
>>>
>>> What also aappears needs fixing is not reporting their size from the
>>> amdgpu_bo_get_memory, which is used to implement fdinfo stats, so 
>>> they are
>>> not mixed with the regular userspace created and driver owned objects.
>>
>> I think that's true. It's a very fine distinction. AMDGPU_PL_PREEMPT 
>> does use system memory and it is GPU accessible, just like GTT. The 
>> only difference is, that it's not subject to the GTT limits because 
>> their eviction is handled by callbacks other than TTM evictions and 
>> doesn't need to wait for fences.
>
> As in you think those two hunks of the patch are correct?

I think so as well, yes. But we still need a name for preemptible BOs 
while printing them in debugfs.

Regards,
Christian.

>
> Regards,
>
> Tvrtko
>
>
>> Regards,
>>    Felix
>>
>>
>>>
>>> And also amdgpu_bo_print_info for debugfs reporting.
>>>
>>> Note that the patch depends on the previous one which broke down the
>>> relevant checks from the domain based to placement based.
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Fixes: b453e42a6e8b ("drm/amdgpu: Add new placement for preemptible 
>>> SG BOs")
>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index fb984669fc3a..5a2bbc793953 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -1032,7 +1032,8 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>>>           atomic64_sub(amdgpu_bo_size(bo), &adev->vram_pin_size);
>>>           atomic64_sub(amdgpu_vram_mgr_bo_visible_size(bo),
>>>                    &adev->visible_pin_size);
>>> -    } else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>>> +    } else if (bo->tbo.resource->mem_type == TTM_PL_TT ||
>>> +           bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT) {
>>>           atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>>>       }
>>> @@ -1298,7 +1299,6 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>>>               stats->vram_shared += size;
>>>           break;
>>>       case TTM_PL_TT:
>>> -    case AMDGPU_PL_PREEMPT:
>>>           stats->gtt += size;
>>>           if (shared)
>>>               stats->gtt_shared += size;
>>> @@ -1599,7 +1599,6 @@ u64 amdgpu_bo_print_info(int id, struct 
>>> amdgpu_bo *bo, struct seq_file *m)
>>>                   placement = "VRAM";
>>>               break;
>>>           case TTM_PL_TT:
>>> -        case AMDGPU_PL_PREEMPT:
>>>               placement = "GTT";
>>>               break;
>>>           case TTM_PL_SYSTEM:

