Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEDEECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 16:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AB3D10EC92;
	Fri,  9 Sep 2022 16:35:58 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DF1710EC92
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 16:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvNmW98onmiqdkKT+vas80fZI4Kq5fp2J4pcAi9Z01ZidnlE06qys5YADBA+E6HeSZdsw338DbMUsJmvdVVZTyyoTRDygcdLCWgH+KaG3FPxXp6SIYWTj51IFq9lh1UkPOK2QcM4SEqTmq5mUzv1nyH9wEhsJhczy3UVsUY5gQkDI/mz8jus/7kGWFVXC4g2XcFqMpwU21gdopdUaRHcz5d/Fwvbl4bW+9hWjqDHIwWcytB9Ry5PEKlwxFEZGpE1bskk9AXPbvfwXHhCQ1tZgYqyErqzVR9aW/AyO6EU02sBZdo+24v+yvf/HTmDPfLpK3Kym2YG5s0ks5LTUy2t2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EIXbdmRfES3p6XvxWn+m/bW22/Pvs4XSDp60+af+Lg=;
 b=W8el+Om3IguJRMcMCwx3c1kD5STaK7TgvvdbfqZy55zWsJCa0lOrmBreaz6/yDjQavuWOTNS6mt46J6khPuBqpaQTO8bI56Ats/MQMFVsjz/cxvLBwWAO1TRzAnrJuR0StJsq9qNR3ohMsZNY09ZB9j3MkAuxj5IivZDx4wQtYekDHb48+o2f/yhwrD8uSrJwwQHEwm6OP8B7UmyJh5ogrL9ye2laDv8H4VEYYQWqbVBAx7BzQizV59S0+vjl90A30ebNzk2Dy+U+uSWJSTvOCYDbO6/w+ayyIFwmW7qUd2g/+JhdNUmXaXrYiy91ZsbX7Hew4IfgFEVEv9oC1z0lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EIXbdmRfES3p6XvxWn+m/bW22/Pvs4XSDp60+af+Lg=;
 b=oXGXNPzeEC/gKxrIfuDmX/F+2OfVD7jf9uZXV5/cgQ1zgoJBF3eCcoLzbwg37MqqHv4daIbSp3rYqVM2R8GI4kEs5eBiTJivWILes9T0FecPPrYw4V9YL18HkDS/PlywpAiCQdsCyBrKy62n5rW3wRzR4H3DRV+PKjdoDCzeEm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA0PR12MB4590.namprd12.prod.outlook.com (2603:10b6:806:93::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 16:35:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5612.021; Fri, 9 Sep 2022
 16:35:50 +0000
Message-ID: <7f3efefe-de58-2360-00bf-0f7d6fe7b7ec@amd.com>
Date: Fri, 9 Sep 2022 12:35:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] drm/amdkfd: Migrate in CPU page fault use current mm
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220909131219.23677-1-Philip.Yang@amd.com>
 <cbb46a59-75c7-d3fe-d200-fbf4ea402870@amd.com>
 <833f3f80-dd3e-e0de-8941-077777332de1@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <833f3f80-dd3e-e0de-8941-077777332de1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA0PR12MB4590:EE_
X-MS-Office365-Filtering-Correlation-Id: 77a7b309-978e-46cd-21b4-08da92815af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjER/bwv0AfW0Bd/FjBzdUSXvbHm3IQ+OOyNoMOfuA7P9yMzbVXEHnvLw3gABB0jEmZ2Q7Xa7macJ+kTJkNp9wQkH3ByInvyYJu+p8chSO2wNQH1EbycpRcdeLpmDJpxq51vw3730os7sJv71xqk4X7zXm7mjDDpJETk6PzaVaFc7VlC7FNrc+CCizs3B/+AUZUTktzq+w9iUyt7dvC2rJg6B7rlLTXMGb0nfs6CLXUu/GFdFu28kaPCumR33D3pXEgPG2Ud0U6ksTmXnbBdTXnx0C4rF62phtY57rLE+sY+mntWNBC7JVaoxjl22szc9c5q4OXdDdC2N59Pc2MbEb+4679jQNrBmTSFwQrRkM2+/5sMFLOgnC8LWJ/Z/jlS+vWGKs/RkohiQIiBrXaQkkJqoG8gGlFf0e9HD6mHCe6zs4gyrXjXi9u8+/Zg1yxkPWYmccPnd4haSs1Ej5+7tfhUz8dDs7t5LadB8EbnEeXIB3JNmiOaG5cb4VkbLHtSNUXNg/X2J59hiZDoBHNqQ/pu0ivvYeKfuxuEvkKdRRuIrQ8qFL+PWYq6GHE1lY6gptDGrlZRG2CmN24lUGfJUlPwf8pYMLt34O+wY4YOjnNpiVmrYzaeC3hFpHKtIIM+X3HYGOPIDEvV5VqnzLVtfr7GyUmxV51Px/I9gSmMSgHzuCfwArtQCi50y2PDQhBgbpKBA5ene6kWP2UrlGb5RxI8ORFCm0tvRNV3DySsNkjhT5oKmXTEqh4i1ynP2hyhtOm/lJM9BXxHL/71temtdizyPZ9AMt1HKUs9mD05h+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(83380400001)(38100700002)(44832011)(186003)(5660300002)(66556008)(8936002)(31686004)(2906002)(316002)(110136005)(66476007)(36756003)(8676002)(66946007)(6506007)(31696002)(6486002)(53546011)(86362001)(6512007)(26005)(41300700001)(2616005)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnhaWTNuREJmbWltSGtaM0M3QjY0SHhnWlVaYWtmcTNoQ3VDTk1ZaGxQMVZH?=
 =?utf-8?B?V2tzdFJvWFkxclFvajJrUGJ2TXJtY0wrbmlBT0o0WG80b3dvbUExQXpNV09z?=
 =?utf-8?B?N05lQnkvK1JGZUovajk2Z2pzUHN3QkVvWGt4ZWxHVlNlVEF2UUNoQWRHZHNG?=
 =?utf-8?B?Z29QcDFGTjRnL0lXcWtWRlBLc3JNUWRtRWZjWDFsc1ZNK2F5ZlNyYlM2VWpk?=
 =?utf-8?B?MTYvTzFaZGZxSzF4cGVlNjNrNExCVXhkclRaTHo1Ti9SN1dIdDJvU0l0Ujh6?=
 =?utf-8?B?VnZ1dmFxMjR0SUF4OUk2cXhUZU9TMUJZOUZkSXVqNnhDT3ovbFlzZ0VqcUdQ?=
 =?utf-8?B?SHlsTmJHRUFUT1AzLzB2cUlIUFRva3VNVE03WGcrOXpHREJvcE5mdCtJSUtQ?=
 =?utf-8?B?TExIUlNLS2pabjBJb0pTSjVCQmRQYThiTzBkVncwOVZZNXBhSzdiMFhoSFNN?=
 =?utf-8?B?bjlBT3FGUHdQdUVmUUhicDM1REI3M1kzRGM2TGR0MmlKaVlranZsZGpma3U5?=
 =?utf-8?B?bjFld3FqVXRZN1pSZ3llbW9HY3hVK3B2VTR6RnlSU0ZIMW9EajlvQmpuc2xt?=
 =?utf-8?B?Z0w4YWxyeGVGUVBSSUYyR3dDYy9BeldlWXowdUFWNU10Qm9ZMDdiVXN4NjJQ?=
 =?utf-8?B?eTIvbTg5R0ZrVWV0OUt0eFBuMDFCN2xPTythcmdOOEZLUjhkSTUyRDdDOGdi?=
 =?utf-8?B?TTVUaldnMUZqZFhROTc5T1YxbTd4NXhVc3g4Z3ZoYldvWHdISE1tZmlGVmpS?=
 =?utf-8?B?ZWZadGtrUkJWV2JlMi8yWjJ0SjBwRnRhYWtUN1E3dFV1VEVzY3RQWjd5alFn?=
 =?utf-8?B?YnJvZXZUY3NVMUVCcC9JSzVQdGRpY1dZajN4TVlRZTNuWk1CQm9Rb0lwbXRK?=
 =?utf-8?B?K1NQYlR4cjlIdVNRSldKSGFSWnZ3UWtjMktDdFNQVzJTemdvR0piVDBLd0Jz?=
 =?utf-8?B?cUoralAxNzV0TVd5OW5WYWtOYTJpQmsweDNkT3NDckM1QXltN3huRjBrY3pz?=
 =?utf-8?B?Z3BpcWtXWXJ0R2g0THN4QUNwZ3JZOGl3SzI4ZHlseFp1QmswaVdqb21uYkxy?=
 =?utf-8?B?R1FZL29seHdEdDRrZ2h2eG04Zlo1SVJHdGhBaUJBMHBpUDZmblNmNUUySmNY?=
 =?utf-8?B?ZlR3OW55alcwMWpSeHB4bndQeHNGWkdkY0ZrcEhobTgydHJ6bU9EVFMwYVN4?=
 =?utf-8?B?UkdXa1cyMTFDanFTTTBWWFFqRGJZR3NubGh6WEhrZzNYNXhnU3o3QVdCb21V?=
 =?utf-8?B?NTF1ZW1VTGpQMThwTkQwRzN4T2Y1dzN2YjBwd2grdE56ZFBna3pqYVNlNWxE?=
 =?utf-8?B?WEwrelo1M0ZEYUFpU0p0V2FQZnlmekhtRHErdlJKT2ZkaS8yV1ZGQkd4OC9K?=
 =?utf-8?B?OFFITG1pNDd4NFJoZTQ3ZGhjamcrSktZc0FtTU5PSUJPdE5mNjQ4TmY1Zk9E?=
 =?utf-8?B?Tlp2SUo1c1N1YTRHUEY4NUpWSGk3RS9weGVzS1gzOTRqNHhRUHE2cXBqcndM?=
 =?utf-8?B?R29IMUFRMFB4akVRUS9OMnN1T0ZRSGRRSEpDV1QzOFdKZmlCL05rL0NCclhZ?=
 =?utf-8?B?aEM2MEJPa0gzVVVEMyswa2FNc3ZoNjdCWnFhZE5NS2FnNkFDdTB4Ymtvd3E5?=
 =?utf-8?B?cnBWMTFob3N3eWViTE1KUVpQWlBvMXZnYTdjVDhSdzN1bmNEeWo2TUFvZDlm?=
 =?utf-8?B?N1JXSkNoSGV1WUxLa3pKOEdzMXV4Rmh4S1ZoUlJ3dUFzZVlybW1MYkszSHQy?=
 =?utf-8?B?UG80MUI1Q3J2RjJpWVQxOFlNZHF3OWtVUTU1dVJNdmpodXdEejlyMEJIVHo0?=
 =?utf-8?B?bE5zbUErbTBBNXlZS1ZpR0M0VXBEZ0phTVNRRGh4akZ4d1BKL013TXRRb3B0?=
 =?utf-8?B?UVlKY1RkTVZkUEZaalB6ZWxEZ1hWVWtHL0JWQ24zZkRIdEhEbm5jSFgyMmEx?=
 =?utf-8?B?MGZERUJSUDFyQk96czN3YnRidnZyZ01TYlVqV1pkOHZpMUZpdEtVSGdvNk02?=
 =?utf-8?B?M2FCaitHN1J4Zzc1R1JkZ09rdDNaNi9ienEzTVdvZFV2djRBNC94MUlrOTZN?=
 =?utf-8?B?d0Zhem95Vy9Kd0FvcytHaDZoRHREb3UyNGFoRDI2WEpzUmF4VUxod09waCta?=
 =?utf-8?Q?HUf3xnDfL1LGM/M0R81FEg4iL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a7b309-978e-46cd-21b4-08da92815af0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:35:50.2031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcEjY8d+PrmHn4eehUYAebt1R2/Q/BcU/9DZFipDD5DK43fmHnf23jygDu+qudF7beQ78Vzy56vbg8k3cHfSow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4590
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

Am 2022-09-09 um 11:42 schrieb Philip Yang:
>
> On 2022-09-09 11:13, Felix Kuehling wrote:
>> Am 2022-09-09 um 09:12 schrieb Philip Yang:
>>> migrate_vma_setup shows below warning because we don't hold another
>>> process mm mmap_lock. We should use current vmf->vma->vm_mm instead, 
>>> the
>>> caller already hold current mmap lock inside CPU page fault handler.
>>>
>>>   WARNING: CPU: 10 PID: 3054 at include/linux/mmap_lock.h:155 find_vma
>>>   Call Trace:
>>>    walk_page_range+0x76/0x150
>>>    migrate_vma_setup+0x18a/0x640
>>>    svm_migrate_vram_to_ram+0x245/0xa10 [amdgpu]
>>>    svm_migrate_to_ram+0x36f/0x470 [amdgpu]
>>>    do_swap_page+0xcfe/0xec0
>>>    __handle_mm_fault+0x96b/0x15e0
>>>    handle_mm_fault+0x13f/0x3e0
>>>    do_user_addr_fault+0x1e7/0x690
>>>
>>> Fixes: 5e5bbf36a2c0 ("drm/amdkfd: handle CPU fault on COW mapping")
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>
>> For a quick fix, this looks OK.
>>
>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>
>> For a better fix, I notice that svm_migrate_vram_to_ram only uses the 
>> mm to look up the vma. But you already know the vma here, so that 
>> look up is completely unnecessary. So could you just call 
>> svm_migrate_vma_to_ram directly? Then you don't need the mm at all 
>> and you save yourself an unnecessary vma lookup from the virtual 
>> address.
>
> Thanks, call svm_migrate_vma_to_ram directly works, that was my first 
> approach, but the prange we want to migrate may include multiple vma, 
> it is safer to call svm_migrate_vram_to_ram to handle this case.

Is that because we always try to migrate 2MB at a time, which may span 
more than one VMA? I think we could probably limit this to a single VMA 
for the page fault case. Separate VMAs are most likely separate 
allocations. Migrating them together due to a single page fault is 
likely unintentional.

But I agree, that should be a separate patch if we want to change that. 
We can tackle that as part of a bigger migration optimization. There is 
another item on my TODO list to get rid of splitting ranges by 
granularity and use partial migrations instead.

Thanks,
   Felix


>
> Regards,
>
> Philip
>
>>
>> Regards,
>>   Felix
>>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> index f62c4561f0f4..1cfa4fcd28b3 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> @@ -947,7 +947,8 @@ static vm_fault_t svm_migrate_to_ram(struct 
>>> vm_fault *vmf)
>>>           goto out_unlock_prange;
>>>       }
>>>   -    r = svm_migrate_vram_to_ram(prange, mm, 
>>> KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU);
>>> +    r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm,
>>> +                    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU);
>>>       if (r)
>>>           pr_debug("failed %d migrate svms 0x%p range 0x%p [0x%lx 
>>> 0x%lx]\n",
>>>                r, prange->svms, prange, prange->start, prange->last);
