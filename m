Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AB5606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ArfzsOTf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DF0F10F293;
	Mon, 16 Nov 2026 15:54:32 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 010ED10F293
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 15:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7eUmaEb7rrT8WeBuFZ4DKOfKLlztpfy3uXv8hJAARD1MmVOZ/1DF/0N6iylbb1eu6xsZ6b2bzi9x0TJAoWvJ5MRNRcUkQXqeOUo6vORiZFdSFGaYaSpDgHYQ/BP9EYXoPxhiPQmg6ohcNxoBVECHUb3ywWqDx/z+ZGeA4pg3RD2zTEDrCt78f144snkORGWaS6T42/9Nc1XWrnqvvz2X7mFAHg9hVgfDfjI0x8qc9h1RqCaAtU5bzBJjQKkUVdrn8CKf+tXcSAhRluWBF0ByPXaOnybw8HWAtooZH/G//5ljyf/vQepgMuQWDDr9FmxEPxdL71tU6ceM214cdV08A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GQk/t6iNLNmrg+SNM4vSrNniKXHX6mLSoWgu68+fws=;
 b=xBOLAGU0RrVB1VIJv8k2RdjZUuVr/scF5AXXV4o1JBq5TApA97viHiHaJi1oJjQZ8h9bpw5e06MXGMndloO2vnLH0aAEQNBKgw32PiVL63agZtnA57w7JMfK/bZKiU/T56zEJyDMmFuLueyDH9uria0fRFB9Fsz5WFhaQf4fUneBXuNwC/HmzuX6GIIA0zBtZjae1Aj5yjf0iD76hlAnxMtvR2OSKvp9n4CMjD5VGeHdksR8XAIEhn+n70mW4gYbrLjnkdweJrECvbe/Ef4bYAiqJNHrmOG8+dPfzNdJkGFfcyPo6fvYct97L9MJLTOAh5gnktiLneCcN7SKHZAGhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GQk/t6iNLNmrg+SNM4vSrNniKXHX6mLSoWgu68+fws=;
 b=ArfzsOTfrESuKJNM58NvUq0yIOmi41v0nhoIO428cWPG5VL30zOYuIBglrSwUyyQATU627xQzLJhQTvjLKZkVi1hDWFGXqf2YxurTmTa3h2JUSvidDUMH6xNJt4ZrkNgx8/Wu2NTse0KAwu//NWuOUWkUX84w2wbe1Cp+aawxt4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by IA1PR12MB8221.namprd12.prod.outlook.com (2603:10b6:208:3f0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 15:54:22 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 15:54:22 +0000
Message-ID: <b6c80e1b-e6ca-4eac-9fe7-8f67e766192c@amd.com>
Date: Mon, 16 Nov 2026 09:54:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm/amdkfd: Add awareness of THP of device and
 system RAM in kfd svm driver
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261019133845.166916-1-xiaogang.chen@amd.com>
 <20261019133845.166916-2-xiaogang.chen@amd.com>
 <2740efce-be38-4a82-98cf-4ddb6cc1212f@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <2740efce-be38-4a82-98cf-4ddb6cc1212f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0239.namprd04.prod.outlook.com
 (2603:10b6:806:127::34) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|IA1PR12MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d49e40f-5379-42b9-c8dc-08df43f9e165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|6133799003|261009223027099003|4143699003|56012099006|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003|261022113327099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: BSvYXu2r/z/Vfh/aPrIB8zB7ALcLCYi3OZ8H4RI2IzLvXDZfvolD4YoezPigphneoWXiVxvpxAIXZgicLBMvONFEDfJXw3Iml7GltFyvvbgd2RSabprv+x2BJIySrzbTiPuqZ6EHgPqVIw0O9tTr7mPf4Mun34YE4EWG3+oEFx9RnH6e24NGq2xxSaKm0S0rsYyk8mGM0mkLsLY4jozePFonPURhA1w+YW9NYchGnyeCVuJ+/mnIaBFXUBxIAEuK/1fGnhqXbIVRRQGHAastyD8tXlvh4U1CJRTsSOsng9meCgSdES+1sTCx0DrVadDOz2ODgi8jAGr0mQ/AkAG1wlzMt70nJpX+wBeZ1QCQ5anBmijgw9IAj+q3/WGR2YBQd9r9lLX00FX0RFVm/1hWuubXfJ/RQvV1b/J978zLtaquQ2EyMk6bS0Zwr6t4cAxTtqOEfBdVLQ84fp3SNm/OnG+wt6c41oF/awdQyLJ7ykQTqGmoJ9q2XBITFB2MYdGDHXd0bsMIrs4iUZmTMZ1Z/zDP6nd+XFsKnoQflwA70xp/0J+nZdidxUXdoVXz0aOAk2xuEpkIZv3Pa2MYMDKTmjrysVQoSqSTTQU0WhiHqCeZ7ufrKKYRH+D/sP+v7QAMbNTU0gw6ZNB07Ubw4d6CgolJGm1laHbvZ7LZG+/+rXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003)(261022113327099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnRRVEVyeXJjVG9yZlYzaTlWamdmZHl3QW92a2d4bVQ5Nks5TzBFTE9nUlc3?=
 =?utf-8?B?eWVGMkREeU5KQ0NrdWprTWZ3R05TZlB1Qkw3eEdJRVNUSUhKaWdqVC9QSjVs?=
 =?utf-8?B?TXhtWGpvWDB1cEZJbnFCZnExZkhLVmVMMWtYeGRwVHA5WWJjSm9YNDRpWm5i?=
 =?utf-8?B?S0NDNnhxcXppd1IyblRldjl5TVFDTWgra3doN2o0TXpGQlpBcEdLcVEzK040?=
 =?utf-8?B?NTc5OGl5NEVuaW1oSUgreUZPUCtBZzJSWHBWRm5XTi9vODNCSEdiU0xwa0Z2?=
 =?utf-8?B?MHpCNjZ5R2JRRlc5V0taK1JtTTRwby9OQUlKdnpZb1RaQWxWSzlaS0FDRmRk?=
 =?utf-8?B?YldHK01rZ0U4L1NFNS91SW9GK1VNT1Vod2dlK2xBSHBrQnBQcXpaTCtiQ2Ft?=
 =?utf-8?B?b2lVQXFOa2p4eUZGSU5XMVhWbzltT08yN2JkdUQ5cFhlUStyWUwvdGFqc0ZX?=
 =?utf-8?B?OFRCK3NwUTl2ZUJid3FWRWR6dGRBRjd0NlZMMEN0MzVEeDd0aTJTNUZJQktw?=
 =?utf-8?B?SXMwR2cySDFEOXIraUJqMUdmYW5PaVZIMjluWjV2bllSdGtjQlNTNlF6KzV4?=
 =?utf-8?B?UGJOcnE0U0tEaGFwZ3IzWjY2eWlCdXVEV1NZYjNYSXhINjJ3REdHdU1sNzE1?=
 =?utf-8?B?QlVTMVV5QkcxSEp1ZFBaVWhTWm5MZk9teWhxL2s2SXMwdlROZlpEWWloKzd0?=
 =?utf-8?B?ZzVoY0Qvdzg4a01XdjdnMGJhcEF3UG51MFFVYzdtcy9GV3FXSEtWRjZ3WGpX?=
 =?utf-8?B?Q1RLeEROcHJHY2FwaEdDRlRVTTRxZzZabDdLQjJSeFlVN3hVWXNua0lYRFY3?=
 =?utf-8?B?SWxvZkpWa1czcGMxVkYxaGF1bFBRMWNyRW5sc3lOOENXdmo1S1NQT3lwQWZM?=
 =?utf-8?B?dWE2TDlINEN1OGw3bVMvWnU2U2lid05JUWxUMG9OQnJhSG9ZblEzRzBZTVRL?=
 =?utf-8?B?WTJhbnRyYlJ3UDBId3FnbFNZMEFTMllONU5Qc0p6SVJJRW5QbDJqUEFWMWhZ?=
 =?utf-8?B?eFFnNFpxa283Yjh3bERudjd6R2QzRDNqQUhmdXdFUEhxL0IzWWIvaUZ2d1RF?=
 =?utf-8?B?dnZkRUk3dEdjR0gyeG1VcmhjQjhERCtOalFzNERnK3VPUzhoOGZ5WW9iWFVk?=
 =?utf-8?B?d3hjZUl3aU9jdDZRTW44Nk93Y2dmWWpEYlR4cnY5OFdoL1hmNXZUODI3aVRY?=
 =?utf-8?B?YTN4WGp3Zzh0N3BGTHdkQW1FUytTWjI0ek9KbnZLSkNubHp3Mm45UWJOWENr?=
 =?utf-8?B?eFJIWEdUWXE0RUNQZUoxQmJiSWdwclM1bGI5THRKVGpUbEJPSU9oVzMraTdi?=
 =?utf-8?B?L1c1MmhuV0ZQcU12RzVEWUx3QWp2OFExbWVtREdPUHdCdWQwOWcwSFBPMGUy?=
 =?utf-8?B?RlE3N1V1azk5anZqUVRINjFSaVhrOWcrV05DK2NJYnNidkMwWGZXZ0NmUEdR?=
 =?utf-8?B?VDB4Tlk2Y0xzbnpxRnREUnZSaytVN21zM1A1Q2I0QU1sMWtrNWgzdXkrOU1Y?=
 =?utf-8?B?SlBhcTgydkRWVXc0alF0NWZyU1dMZ0kycDY4ZENKeW9JWDY4eWZvVkRhTkNh?=
 =?utf-8?B?WWxwYTdqK1kvdmpoeEJvMEw2bXNhL1dwYXordHk1b2tHTTRJeWlOWHJZWjVj?=
 =?utf-8?B?bEtxTkVkMW0zc3VvK1h6eDloQm10OHlhWFQxelNxeG1laUgvY2YweVZ6cUVx?=
 =?utf-8?B?L0hTcXZWMTJqTUYwK1RXQytQS3ZDc2NleWtYajViV016OGVRLzdlcmNySWEy?=
 =?utf-8?B?K3lIajl5QUVLSXNiZDZYZmFibnZ5NkRJeGJmRGYvM3prb1cyUXA4dGVpRjJ3?=
 =?utf-8?B?bE5VNzdjbkxxbWJTK0F1b3pnZVpsVEV6MlNUWHJnVlpzS2R6Um1Qd2pLODZa?=
 =?utf-8?B?T0s4RVJWaThaRmNtTktleEZkNnZ0enR3U0QyMEZlTUVtQUdWU0JjOWVNRFVy?=
 =?utf-8?B?MmFYY1FUeWxGUnJoWUh1akJYRkdIYzAzOXdFRUpOM3lFSHpocDVtZUc2Y1VK?=
 =?utf-8?B?VTlWNE5QK1RpdVRWQkFrMGtReE52bGtGbjdQRUdiTWdxeklpOVZxTzJ6emhp?=
 =?utf-8?B?NkFZREZjV2E1TEtRS3hYcEE2b2dWc2JrV08rL0ZwTHYybFZoWjM4TXcxVERx?=
 =?utf-8?B?QkhLejRsdGNJU1VCS3JneTNUbGxjbHE2aHNQcjIyTHlpQmE4Q2RtWE1PMTNp?=
 =?utf-8?B?T3h2ckJjWnpJZEdIdzJzSVgzakE4ZG83QUxjRzBJdXFGRnVtVUp3cFZOdlI4?=
 =?utf-8?B?RDVRWEpCV2E0MnU5N3NFOHI1c2x0MDBacjU0UkhJUFlhOXdJZE5KT2tBUEli?=
 =?utf-8?Q?jpFuCngQ7sKQsGv5vP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d49e40f-5379-42b9-c8dc-08df43f9e165
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 15:54:21.9217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vt545EUQLDQCqKIg0hsQ+GCtwGWXINovgKn/QcUzoBNYirP15XLRuwOlkKq+yUzS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/13/2026 5:28 PM, Philip Yang wrote:
>
>
> On 2026-10-19 09:38, Xiaogang.Chen wrote:
>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>
>> Extend kfd/svm functions to allocate HPAGE_PMD_SIZE based device 
>> memory by
>> buddy allocator, each drm_buddy_block is HPAGE_PMD_SIZE aligned; and to
>> allocate THP system ram by vma_alloc_folio.
>>
>> Introduce SVM_RANGE_DMA_THP flag that indicates dma map of THP. THP dma
>> addresss will use this flag.
>>
>> Add dev_pagemap_ops->folio_split callback that is called by 
>> folio_split when
>> core MM splits device memory folio.
>>
>> Reset compound folio of device memory after it got released from core 
>> HMM.
>> So, TTM can reuse this VRAM as 4K pages on next range.
>>
>> These are preparations for following support for (THP) migration of zone
>> device-private memory, no function change.
>>
>> Signed-off-by: Xiaogang Chen<xiaogang.chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 84 ++++++++++++++++++++----
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 37 +++++++++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  1 +
>>   3 files changed, 104 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index 8b96e1fe741a..7a129c9954fc 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -218,17 +218,45 @@ svm_migrate_addr_to_pfn(struct amdgpu_device 
>> *adev, unsigned long addr)
>>       return (addr + adev->kfd.pgmap.range.start) >> PAGE_SHIFT;
>>   }
>>   +/*
>> + * TTM can reuse a 2MB VRAM block that was previously a device THP.
>> + * Reset unused pages so the next 4K init does not see leftover 
>> head/tail.
>> + */
>> +static void svm_migrate_clear_compound_pages(struct page *page, 
>> unsigned int nr,
>> +                          struct dev_pagemap *pgmap)
>> +{
>> +    unsigned int i;
>> +
>> +    for (i = 0; i < nr; i++, page++) {
>> +        struct folio *new_folio = (struct folio *)page;
>> +
>> +        if (page_count(page))
>> +            continue;
>> +
>> +        page->flags.f &= ~0xffUL;
>> +#ifdef NR_PAGES_IN_LARGE_FOLIO
>> +        ((struct folio *)(page - 1))->_nr_pages = 0;
>> +#endif
>> +        new_folio->mapping = NULL;
>> +        new_folio->pgmap = pgmap;
>> +        new_folio->share = 0;
>> +        page->zone_device_data = NULL;
>> +    }
>> +}
>> +
> This is called after the device page is freed. When migrating, 
> svm_migrate_get_vram_page() uses the VRAM page and 
> zone_device_folio_init() does the same initialization, so this looks 
> duplicated. Is it?
svm_migrate_clear_compound_pages() runs because freeing the device THP 
only releases the head folio. The other 511 struct pages stay linked to 
that head, and TTM can hand those same VRAM pages out later as ordinary 
4K pages.

free_zone_device_folio() clears folio->mapping on the head and calls 
folio_free. It does not walk the tails. Each tail still has its 
compound-tail marker, so page_folio() follows it back to the old head, 
and page_pgmap() is implemented as page_folio(page)->pgmap. The tail's 
own pgmap slot held the head pointer, not the dev_pagemap.

The next 4K migration initializes that exact pfn:

svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn,
                int order)
{
     struct page *page = pfn_to_page(pfn);

     /* Init this pfn, not page_folio() ? that follows a leftover tail 
to the old head. */
     zone_device_folio_init((struct folio *)page, page_pgmap(page), order);

page_pgmap() runs before that init. On a leftover tail it returns the 
old head's pgmap, or a stale one if that head was already reused.

The clear walks every page of the freed folio, drops the head/tail flag 
bits and _nr_pages, and stores the real pgmap on each page. After that, 
each page is a standalone zone-device page and the next order-0 init 
does not follow the old THP.

>>   static void
>> -svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
>> +svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn,
>> +               int order)
>>   {
>> -    struct page *page;
>> +    struct page *page = pfn_to_page(pfn);
>>   -    page = pfn_to_page(pfn);
>> -    svm_range_bo_ref(prange->svm_bo);
>> +    /* Init this pfn, not page_folio() — that follows a leftover 
>> tail to the old head. */
>> +    zone_device_folio_init((struct folio *)page, page_pgmap(page), 
>> order);
>>       page->zone_device_data = prange->svm_bo;
>> -    zone_device_page_init(page, page_pgmap(page), 0);
>> +    svm_range_bo_ref(prange->svm_bo);
>>   }
>>   +
>>   static void
>>   svm_migrate_put_vram_page(struct amdgpu_device *adev, unsigned long 
>> addr)
>>   {
>> @@ -249,11 +277,17 @@ svm_migrate_addr(struct amdgpu_device *adev, 
>> struct page *page)
>>   }
>>     static struct page *
>> -svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long 
>> addr)
>> +svm_migrate_get_sys_page(struct vm_area_struct *vma, unsigned long 
>> addr,
>> +              unsigned long order)
>>   {
>>       struct page *page;
>>   -    page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
>> +    if (order)
>> +        page = folio_page(vma_alloc_folio(GFP_HIGHUSER,
>> +                          order, vma, addr), 0);
> vma_alloc_folio could fail, then folio_page has NULL access, should 
> check vma_alloc_folio return value. if vma_alloc_folio() fails for 
> order 9, this fails the entire migration with -ENOMEM and the CPU 
> fault becomes SIGBUS. migrate_vma_pages() already handles a compound 
> source with a non-compound destination by splitting the source, so 
> falling back to a 4K page here would be enough. Where is that handled?
yes, that needs fallback to alloc_page_vma if alloc sys THP fail.
>> +    else
>> +        page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
>> +
>>       if (page)
>>           lock_page(page);
>>   @@ -267,8 +301,13 @@ static unsigned long 
>> svm_migrate_successful_pages(struct migrate_vma *migrate)
>>         for (i = 0; i < migrate->npages; i++) {
>>           if (migrate->dst[i] & MIGRATE_PFN_VALID &&
>> -            migrate->src[i] & MIGRATE_PFN_MIGRATE)
>> -            mpages++;
>> +            migrate->src[i] & MIGRATE_PFN_MIGRATE) {
>> +
>> +            if (migrate->dst[i] & MIGRATE_PFN_COMPOUND)
>> +                mpages += HPAGE_PMD_NR;
>> +            else
>> +                mpages++;
>> +        }
>>       }
>>       return mpages;
>>   }
>> @@ -302,7 +341,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, 
>> struct svm_range *prange,
>>           if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
>>               dst[i] = cursor.start + (j << PAGE_SHIFT);
>>               migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>> -            svm_migrate_get_vram_page(prange, migrate->dst[i]);
>> +            svm_migrate_get_vram_page(prange, migrate->dst[i], 0);
>>               migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>>               mpages++;
>>           }
>> @@ -616,15 +655,22 @@ svm_migrate_ram_to_vram(struct svm_range 
>> *prange, uint32_t best_loc,
>>       return r < 0 ? r : 0;
>>   }
>>   +/* folio can be compound folio or single page */
>>   static void svm_migrate_folio_free(struct folio *folio)
>>   {
>>       struct page *page = &folio->page;
>>       struct svm_range_bo *svm_bo = page->zone_device_data;
>> +    struct dev_pagemap *pgmap = folio->pgmap;
>> +    unsigned int order = folio_order(folio);
>>         if (svm_bo) {
>>           pr_debug_ratelimited("ref: %d\n", kref_read(&svm_bo->kref));
>>           svm_range_bo_unref_async(svm_bo);
>>       }
>> +
>> +    /* So TTM can reuse this VRAM as 4K pages on the next range. */
>> +    if (order)
>> +        svm_migrate_clear_compound_pages(page, 1U << order, pgmap);
>>   }
>>     static int
>> @@ -678,7 +724,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>               j = 0;
>>           }
>>   -        dpage = svm_migrate_get_sys_page(migrate->vma, addr);
>> +        dpage = svm_migrate_get_sys_page(migrate->vma, addr, 0);
>>           if (!dpage) {
>>               pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
>>                    prange->svms, prange->start, prange->last);
>> @@ -1081,9 +1127,25 @@ static vm_fault_t svm_migrate_to_ram(struct 
>> vm_fault *vmf)
>>       return r ? VM_FAULT_SIGBUS : 0;
>>   }
>>   +static void svm_migrate_folio_split(struct folio *head, struct 
>> folio *tail)
>> +{
>> +    struct svm_range_bo *svm_bo;
>> +
>> +    if (tail == NULL)
>> +        return;
>> +
>> +    tail->pgmap = head->pgmap;
>> +    tail->mapping = head->mapping;
>> +
>> +    svm_bo = folio_zone_device_data(head);
>> +    folio_set_zone_device_data(tail, svm_bo);
>> +    svm_range_bo_ref(svm_bo);
>> +}
>> +
>>   static const struct dev_pagemap_ops svm_migrate_pgmap_ops = {
>>       .folio_free        = svm_migrate_folio_free,
>>       .migrate_to_ram        = svm_migrate_to_ram,
>> +    .folio_split        = svm_migrate_folio_split,
>>   };
>>     /* Each VRAM page uses sizeof(struct page) on system memory */
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index a99dbedf3cd4..8e1fb5df8abd 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -245,7 +245,16 @@ void svm_range_dma_unmap_dev(struct device *dev, 
>> dma_addr_t *dma_addr,
>>           if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
>>               continue;
>>           pr_debug_ratelimited("unmap 0x%llx\n", dma_addr[i] >> 
>> PAGE_SHIFT);
>> -        dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
>> +
>> +        /* dma unmap of THP */
>> +        if (dma_addr[i] & SVM_RANGE_DMA_THP) {
>> +            dma_addr[i] &= ~SVM_RANGE_DMA_THP;
>> +            dma_unmap_page(dev, dma_addr[i], PAGE_SIZE*HPAGE_PMD_NR,
>> +                       DMA_BIDIRECTIONAL);
>> +        } else {
>> +            dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
>> +        }
>> +
>>           dma_addr[i] = 0;
>>       }
>>   }
>> @@ -578,10 +587,15 @@ svm_range_vram_node_new(struct kfd_node *node, 
>> struct svm_range *prange,
>>       }
>>         memset(&bp, 0, sizeof(bp));
>> -    bp.size = prange->npages * PAGE_SIZE;
>> +    if (prange->npages >= HPAGE_PMD_NR) {
>> +        bp.size = ALIGN(prange->npages * PAGE_SIZE, HPAGE_PMD_SIZE);
>> +        bp.byte_align = HPAGE_PMD_SIZE;
>> +    } else {
>> +        bp.size = prange->npages * PAGE_SIZE;
>> +        bp.byte_align = PAGE_SIZE;
>> +    }
> seems don't need align size to 2MB, this will alloc vram that never 
> used. For example size 3MB, byte_align to 2MB, gpu buddy allocator 
> will return first block with 2MB, the second block 1MB

The fallback is align to PAGA_SIZE. Do you mean the case above? That is 
aligned to 2MB.

Regards

Xiaogang

> . Regards, Philip
>>       bp.bo_ptr_size = sizeof(struct svm_range_bo);
>>       bp.destroy = svm_range_bo_destroy;
>> -    bp.byte_align = PAGE_SIZE;
>>       bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>>       bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>>       bp.flags |= clear ? AMDGPU_GEM_CREATE_VRAM_CLEARED : 0;
>> @@ -593,9 +607,17 @@ svm_range_vram_node_new(struct kfd_node *node, 
>> struct svm_range *prange,
>>         r = amdgpu_bo_create(node->adev, &bp, &bo);
>>       if (r) {
>> -        pr_debug("failed %d to create bo\n", r);
>> -        mmput(mm);
>> -        goto create_bo_failed;
>> +        if (prange->npages >= HPAGE_PMD_NR) {
>> +            /* fall back PAGE_SIZE granularity */
>> +            bp.size = prange->npages * PAGE_SIZE;
>> +            bp.byte_align = PAGE_SIZE;
>> +            r = amdgpu_bo_create(node->adev, &bp, &bo);
>> +        }
>> +        if (r) {
>> +            pr_debug("failed %d to create bo\n", r);
>> +            mmput(mm);
>> +            goto create_bo_failed;
>> +        }
>>       }
>>         svm_bo = to_svm_range_bo(bo);
>> @@ -956,6 +978,7 @@ svm_range_copy_array(void *psrc, size_t size, 
>> uint64_t num_elements,
>>       *vram_pages = 0;
>>       for (i = 0; i < num_elements; i++) {
>>           dma_addr_t *temp;
>> +
>>           temp = (dma_addr_t *)dst + i;
>>           *temp = *((dma_addr_t *)src + i);
>>           if (*temp&SVM_RANGE_VRAM_DOMAIN)
>> @@ -1628,7 +1651,7 @@ static int svm_range_reserve_bos(struct 
>> svm_validate_context *ctx, bool intr)
>>       uint32_t gpuidx;
>>       int r;
>>   -    drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT: 
>> 0, 0);
>> +    drm_exec_init(&ctx->exec, intr ? DRM_EXEC_INTERRUPTIBLE_WAIT : 
>> 0, 0);
>>       drm_exec_until_all_locked(&ctx->exec) {
>>           for_each_set_bit(gpuidx, ctx->bitmap, MAX_GPU_INSTANCE) {
>>               pdd = kfd_process_device_from_gpuidx(ctx->process, 
>> gpuidx);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> index c7d7adae4476..f2b3a05cd8cf 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> @@ -35,6 +35,7 @@
>>   #include "kfd_priv.h"
>>     #define SVM_RANGE_VRAM_DOMAIN (1UL << 0)
>> +#define SVM_RANGE_DMA_THP (1UL << 1)
>>   #define SVM_ADEV_PGMAP_OWNER(adev)\
>>               ((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
>
