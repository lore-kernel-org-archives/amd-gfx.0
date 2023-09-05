Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDCBC83F2C
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 15:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26CCC10E0A5;
	Tue,  5 Sep 2023 15:16:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1918110E0A5
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 15:16:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2c+RCyaFkKBEJu5noBnwtxeN2s21qIkEZGUcd2wlrcYSh3XaiYtQygz7vgyxVBGCSM05+fXNnD6RfLS7Rl0qc3KpgJFS+P0gftTv2nhl7rCnbsTgMEGUhLVClWW1CP8oltvI/jpbdi9sRHqtiGmDZD7cKPMdcIapSvCvA/Wf1hhbmkwZMZwq8ye8WTYalertXfkRFXKyMhsCXrHZfh/pGxa6NZF1YMRtZbs49n2VcHAR5WMO3RXZtajRWFoj4iQVCjVCEqkvBHKKMhvkfnFV+jj9hCegUln5eWktT8AxtYwyzfYFS9hoY3dqGxW/xx7LDL5N65MAUkEvax1iW0k9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5CUli21rj9kPDl3Aqpc10AEkJLTmmIDmTwGnzpF15c=;
 b=cphjcoNP5XYDJCTeN8Ki7qbckBpl/YPlAyd3PgzCE1yzMt6rn1OTIeByqC4yZ4A+LCtz6BM252QNsOoj8nSRhYobzZRY51r6ABmq4n49aiMvXENAMt5Cbh8wkwvdSjOd4BIA0ceTN+0beFxBjIh2/zhCmYHhKlIGM+PRnpswfRFW/Gm5BXlM0KtBtNI0npREZvwm1sho7MeqsZgOwew0PbbUQDzyzfpSyazC0BwKngrbpOlOrVaGlbRcgv9NkbjdjWuW6wq+b+Qm1wY4w/VN/hJ3nVI1d0cXQ6gO4Q+rK84eWDlM6NEp4gGYxN6qHoGz7CfJ0CWBZMjj8tKWTGtRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5CUli21rj9kPDl3Aqpc10AEkJLTmmIDmTwGnzpF15c=;
 b=R/7MaMhHTdHEHRifHYDqhtyj25P+or1ZWK55iopRjWDAj4XYps38svER99uO3N2KSbdgoXWB8IgQRCS5yDU1CW//xrUVjR1EauDt9OfMb3j8rWCQC2cSwByun9Yw36ZZwlOo7Y7bxhm9QnMrpFYzF4yCUJSk1b7o7XQUhR2BYGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 PH0PR12MB8126.namprd12.prod.outlook.com (2603:10b6:510:299::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Tue, 5 Sep
 2023 15:16:37 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::757c:f867:1a53:3f2c]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::757c:f867:1a53:3f2c%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 15:16:37 +0000
Message-ID: <019cf4e9-7ae2-9ca3-2a66-bda1b64dd575@amd.com>
Date: Tue, 5 Sep 2023 10:16:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdkfd: Use partial migrations in GPU page faults
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230824220834.362948-1-xiaogang.chen@amd.com>
 <d31985b2-74d9-2536-2995-7b693928d443@amd.com>
 <f744c06c-284f-de8b-8ed2-05d0512823a1@amd.com>
 <ed0dd323-bd99-d2f7-8cbf-6a92e5201f8e@amd.com>
 <8670e751-9a76-b9d9-47f6-05461c279f09@amd.com>
 <fef7aadd-fb8f-f5c2-10e6-b5ebdcf4be56@amd.com>
 <347c4bba-cd60-29a5-6fc0-8f445fd31300@amd.com>
 <85f4c2da-2d8d-4c73-a540-f714ebe6b2e6@amd.com>
 <f57a1e42-52af-0d67-0049-9ed6c58fe0ee@amd.com>
 <0da257e5-85a6-4843-4f49-5666d049110e@amd.com>
 <a83c2317-932b-3a7d-2a54-0ccda4dd77be@amd.com>
 <0b40fe2b-7c80-573c-ec1c-64594b840dc2@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <0b40fe2b-7c80-573c-ec1c-64594b840dc2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0148.namprd11.prod.outlook.com
 (2603:10b6:806:131::33) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|PH0PR12MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: 07020c79-0e8b-40d2-61b0-08dbae231926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zWUBTGNmMZEMLX+Q6GsL17SuGyHWKsD4QObhC1ZdoCTLBhpegoy4HVN5Of5vyaxq8Ts5C/4JMawP5Kl9oEcwVZnnZQP9t1aOgx+E9ZGUdAHo0Z2dTff+ON4/pSY/s4mjJYWcSJLAlwp641YKFc+vzgFpJFsMs5OabuJzr57dkGg3sWZRyNFDTl3SN5eZyrDcuGsW9Svpa3A01dnI2JK2yZSpbcXFd1E6VsuUUm4nJO0gyLbFlYOg/q9xVF8tMwe/bBFYGsMDI60689Uu0/oU2Kij6iYBzQxxCxW7mo7vGvuUX6sFm/stlGWNmMRZcvmYubvensYAvtRNc7/bE7zjiBErBvztffQ9I91VSIAwyXPvm1299THzpsYgUs6SMgvY26kxmDjZsHovfLChQDbUl5KG88ddlMhTgi7tV7WCOV/20nKKSYZ7uADV60rNghlXjOn4dcS1aaR0ZGR0TLiw3+wLrJR0dMEWc9yEibeXaDTR23BSD41MUp9642TpKigHGJSMvykPmD3thnTKrGWXIpaZblTDvmYvjKYMAlctZH7HgTKguFCBs8KlSWjXP5hR5Vnh0otKYQrvYKjorZ/iWIHoxweq3GH5nwk9F3Vz7+ZsT9ihCYih8DZfcltTa2hAUzNC2diFTkTpwnjZmcsqUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(39860400002)(366004)(346002)(186009)(1800799009)(451199024)(26005)(6506007)(53546011)(2616005)(6486002)(6512007)(86362001)(38100700002)(36756003)(31696002)(83380400001)(41300700001)(8936002)(316002)(66476007)(66556008)(5660300002)(66946007)(110136005)(8676002)(4326008)(31686004)(2906002)(478600001)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cld6dEE0cWJoK1hMcS9Vb2xuSk0zVUNxbGJIN2Z1S1AxcGEzM2MvNzg2YlJC?=
 =?utf-8?B?TzlHQ3dPemZwUGg3RXg4Y2RyRkQ1cmRqSE10d2NHYlkwRk1TS1djVUsrMGlH?=
 =?utf-8?B?aU9jQ1JFUllaVHV5S25sV2dOdmxEWE1GdGhEajAwQWNQRGdVRnRrYnVhU2Zn?=
 =?utf-8?B?S3d1TkVzYmtYMWs5Lzl6cmJnN2xtSUtJYzhnSWdzZzRBRUN5UUpZN0Z5Z21s?=
 =?utf-8?B?OFBtM3VTMGlrdVZpR3ZRblVNenFiZ3lQVDBLKzVrajhlallLRVQ3YnQ1V0F5?=
 =?utf-8?B?ZHRIUDJ6V3ZJdVVkU3NiSmp1WjRyQ2RXUXROVzVpTk0xSHlOZmJRa2NuZVhW?=
 =?utf-8?B?RzMzQmdXZ04wMG4yeXhtRG42SzN3OGZMeXl1TExpQ1BhRmRJYnhycGlaemNT?=
 =?utf-8?B?U0hsdHRYZ0J6QkJPeHlxVU5sZFQyNTYweEJ3M2d3TklPUXBWRSsxWWJTbE9K?=
 =?utf-8?B?N2psTEJCVVlBM08yZDliaTJQbkxxZGRGS1NjUUpyWGVuTlBNb0UvVWhCc2Na?=
 =?utf-8?B?RjMvREg1aTdaRlFQR2Zvb1ZTdW5aKzZSdHpxSWw1NzhtUit6Zm1QZ1N2c1VN?=
 =?utf-8?B?RUF5RllhRDBQUWhpbzE3U3FyRTBkNnFEWmplaXZPNnp1NGVDNGFSc1NFdFFK?=
 =?utf-8?B?KzY5eWptaXl0NlZkWjlpcnY2aWtocXdlZFd2OVVkVHlkRnBXdGlRaHdESjF0?=
 =?utf-8?B?dnRETnl3MmN0QjR1aVE5T0FiRXRNMVBWQjBleHZYMGw3ejdjT25melJzVkRU?=
 =?utf-8?B?eEtWZHNQL3A3dDNPS09OUlpHVmZ2bGgvYWxtS09nUmUxblVrZWRVaGJpdktS?=
 =?utf-8?B?V0VZWFJxTVlMSGxaR09udllmSTBTYm96OTVNS2dYU3UwU2VpNXRxY3dHSkRF?=
 =?utf-8?B?T1QrTSs4cHpIajNaNUlJL3YvU2FVWDBEQ053UlU3M25qUmFHc3JYWm5zM2ti?=
 =?utf-8?B?MDIyU2FxQmhCMHV5dGtMdXpjMFFKRUhGRWdRb0FVWERmZmFSR2JFZ3MvVGIz?=
 =?utf-8?B?NDN0OS8xOVROYzlWMG5zL3ZOMVFpR05VMmpaWklmdEVWWndrZlJsL1ZtVU1z?=
 =?utf-8?B?c1cxWkN1aGsxdjY4Z01kN3Rmb1VUVVJCczJ0Tm8rdUF6TmNqWG5FaVVzalM0?=
 =?utf-8?B?MTRGc2dZNTRsTDJ0SHV2ckRPc3RGQ2l2bVZDUjd6enNyRGFicGVWd0R0QW4r?=
 =?utf-8?B?Vzg3UTVWNXU5RE9VRXNzcU5ac2Mrb2JTVWtQOGpvSlFHVzNjQ3ExRWw0bUN0?=
 =?utf-8?B?TXpwYVFEVGVOWC9waElFZEkrZmR0anNSYmMvTXB5Uzk2ZGZ1WVh2bzZxVkQw?=
 =?utf-8?B?ejEweXp0VVN2d0ZONWdWd1lRQ2lFUWRZNGVpS0J1ZVE5ZjV1MmowUHZrTXo2?=
 =?utf-8?B?K1JmbFBET2pzcXR0TnRDeVlWVVNwU1R4SUZNcXlkdWhIRHNwUDJRcXNmUjZt?=
 =?utf-8?B?YUZnT3JPZ0lKaDFhb0piY1BrUzBmRk14aldtR1JOTnlUYXgrL1BZbUQwNWpt?=
 =?utf-8?B?MnhDM3VMaGNpUUt4dDkzMzgvNWowWENZSjZrOElIZ2tyaW9NUndLUkRRdEFL?=
 =?utf-8?B?UGNqM3FGSEdXSHA4UXJ5eCsvRW1wc0JJUjEzVlEwcmg2R2tXMGR1VWpRZTNE?=
 =?utf-8?B?Tm5TNjdhOGpoYUVSVGtwTEFydVBYeStaVFI3TU1pNWV6by9VUHRFTFV0TU1n?=
 =?utf-8?B?K2hwaERobk56S3pWcGtJRnBwOVROVmE1OHVwbUpxK1JrNWhSZ3pyUndxK2Zq?=
 =?utf-8?B?U1djZmcyKytxOGVVZ1FOelZDUVVoc09ialZOaHV0R29aSFd6MndCSEx6V0k2?=
 =?utf-8?B?dXRTTy90ZVJtVmE1NFg4bE5IaG9pdVV6eTZEaGhZY1ZGUFhXbjlNdlZWMjBp?=
 =?utf-8?B?a1VWYWJ4ODQ2RGhLa2pMUnZFWU8xaXdWZDIzeERHTkp6TVJyRE5DUEp6MXVi?=
 =?utf-8?B?V1E0aXoyK3NQeW5OOWF5V1J1b0F4ZTgzMzZsdWptWmlwVGJxK3NWZis0SDht?=
 =?utf-8?B?dElwYTNJOTRCemdtYWhsbzdMRUJYckhRZmlibzdiRzdPNEVhYjNRdSt1QXZt?=
 =?utf-8?B?OG9Fam54TzcxOFlLRXBYa0hjVk1wVUtTalFNcENFS0FHeitaMnRvd3M1RUZP?=
 =?utf-8?Q?Yyok=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07020c79-0e8b-40d2-61b0-08dbae231926
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 15:16:37.3759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMy0dqr2eceku8pq4l1hRYAHW4CujR3xuHpZcV356igxZIoTbORBms6xUb7Huf5W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8126
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
Cc: Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 9/5/2023 9:02 AM, Philip Yang wrote:
>
>
> On 2023-08-31 17:29, Chen, Xiaogang wrote:
>>
>> On 8/31/2023 3:59 PM, Felix Kuehling wrote:
>>> On 2023-08-31 16:33, Chen, Xiaogang wrote:
>>>>>>>>> That said, I'm not actually sure why we're freeing the DMA 
>>>>>>>>> address array after migration to RAM at all. I think we still 
>>>>>>>>> need it even when we're using VRAM. We call svm_range_dma_map 
>>>>>>>>> in svm_range_validate_and_map regardless of whether the range 
>>>>>>>>> is in VRAM or system memory. So it will just allocate a new 
>>>>>>>>> array the next time the range is validated anyway. VRAM pages 
>>>>>>>>> use a special address encoding to indicate VRAM pages to the 
>>>>>>>>> GPUVM code.
>>>>>>>>
>>>>>>>> I think we do not need free DMA address array as you said, it 
>>>>>>>> is another thing though.
>>>>>>>>
>>>>>>>> We need unmap dma address(dma_unmap_page) after migrate from 
>>>>>>>> ram to vram because we always do dma_map_page at 
>>>>>>>> svm_range_validate_and_map. If not we would have multiple dma 
>>>>>>>> maps for same sys ram page.
>>>>>>>
>>>>>>> svm_range_dma_map_dev calls dma_unmap_page before overwriting an 
>>>>>>> existing valid entry in the dma_addr array. Anyway, dma 
>>>>>>> unmapping the old pages in bulk may still be cleaner. And it 
>>>>>>> avoids delays in cleaning up DMA mappings after migrations.
>>>>>>>
>>>>>>> Regards,
>>>>>>>   Felix
>>>>>>>
>>>>>>>
>>>>>> then we may not need do dma_unmap after migrate from ram to vram 
>>>>>> since svm_range_dma_map_dev always do dma_unmap_page if the 
>>>>>> address is valid dma address for sys ram, and after migrate from 
>>>>>> ram to vram we always do gpu mapping?
>>>>>
>>>>> I think with XNACK enabled, the DMA mapping may be delayed until a 
>>>>> page fault. For example on a multi-GPU system, GPU1 page faults 
>>>>> and migrates data from system memory to its VRAM. Immediately 
>>>>> afterwards, the page fault handler should use svm_validate_and_map 
>>>>> to update GPU1 page tables. But GPU2 page tables are not updated 
>>>>> immediately. So the now stale DMA mappings for GPU2 would continue 
>>>>> to exist until the next page fault on GPU2.
>>>>>
>>>>> Regards,
>>>>>   Felix
>>>>>
>>>> If I understand correctly: when user call svm_range_set_attr, if 
>>>> p->xnack_enabled is true, we can skip call 
>>>> svm_range_validate_and_map. We postpone the buffer validating and 
>>>> gpu mapping until page fault or the time the buffer really got used 
>>>> by a GPU, and only dma map and gpu map for this GPU.
>>>
>>> The current implementation of svm_range_set_attr skips the 
>>> validation after migration if XNACK is off, because it is handled by 
>>> svm_range_restore_work that gets scheduled by the MMU notifier 
>>> triggered by the migration.
>>>
>>> With XNACK on, svm_range_set_attr currently validates and maps after 
>>> migration assuming that the data will be used by the GPU(s) soon. 
>>> That is something we could change and let page faults take care of 
>>> the mappings as needed.
>>>
>> Yes, with xnack on, my understanding is we can skip 
>> svm_range_validate_and_map at svm_range_set_attr after migration, 
>> then page fault handler will do dma and gpu mapping. That would save 
>> the first time dma and gpu mapping which apply to all GPUs that user 
>> ask for access. Then current gpu page fault handler just does dma and 
>> gpu mapping for the GPU that triggered page fault. Is that ok?
>
> With xnack on, after prefetch the range to GPU, need 
> svm_range_validate_and_map to update the mapping of the GPU migrated 
> to (also the mapping of GPUs with access_in_place), because app 
> prefetch to GPU to avoid GPU page fault.
>
With xnack on postpone gpu mapping to page fault handler may save some 
operations since we update mapping only on gpu that need the mapping, 
but that is not for this patch any way.
>
> After migrating to VRAM, we only need dma_unmap_page from 
> prange->dma_addr array, don't need to free the dma_addr array itself, 
> as it can be reused to store VRAM address to map to GPU.
>
yes, we do not need free dma array, only need dma_unmpa_page at 
svm_range_free_dma_mappings. The array stores both system ram dma 
address and vram physical address. We can free this dma array at 
svm_range_free.

Regards

Xiaogang

> Regards,
>
> Philip
>
>>
>> Regards
>>
>> Xiaogang
>>
>>> Regards,
>>>   Felix
>>>
>>>
>>
>>>>
>>>> Regards
>>>>
>>>> Xiaogang 
