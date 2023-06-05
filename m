Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768D9C7EE24
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 15:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB18210E2F1;
	Mon,  5 Jun 2023 15:47:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 757A710E2EF
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jun 2023 15:47:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ez/MDrDxpvfcwMU/WcqUXK74O5rFmp5y+fFqMmwTodr4GzS262NpMw9pvJAgEsQ/7HiLhAXECWHd5OWHiIqSEy8JTCXVdkYaLijt4ez6HCJvbTaKeI5Sp2aU4c90L06kqS+/WK2aerjScWBgEGmHTdzj2zI8ilUIiN5NjywTKThOlmobP/SM8QBG8ROAvcExOdXgKgAGMHO77YHBvnElliFJH+1a89AcZUriJGeA6+rrhT1crtbSa700o3F5ozhEreiGPsoX7k7iZH3yS/AyU4aG5ZsokfHb+d05wEND/kGSFgiJx55Y4GQIo03CYFTnxtE/XYe7/k37YVghwKGkow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NxmBxgoljImVcyd3Iu/nN6Ag17sc9ZGlef5d4Ct18k=;
 b=Swg1I2fBSFNeRNKAVLe8kFe7lqJV9fIxvNYPbAW4EndDjXHkvnsNAMmbeQxxpA2rWo0e5MUxO45d1nSpiQUnXgRRMl2CM1jcClFiAqhlkKFJj2JFMT0HYzy9QKeZlST+VCdUtMJXwUoOrq2OQcHgu23+Asx0Hv20dfsysNYc/MZQ5iAqKSQc9onutKztiDfR4JTIeMjWnPnn1AB5WxTBPlv7fXdiDfevtXQ5ELWUf4oD3jBZNpfmoHHPTYv792HACwUZLt4Qd2I1gF1POCGF0O+KLZcOPa3aKDtEIyyPu/0TuIY/pPR2sbOTEeHyTLhk0/aIlbWpZrF9ojdMsnKFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NxmBxgoljImVcyd3Iu/nN6Ag17sc9ZGlef5d4Ct18k=;
 b=Rmgp9KSxnKYUe8HduseIbfHWuq6h8oeNFeCGV4Iz5zlbl5+Vf0GIsrNaQGaCGzbm+h10qCOENKXS2hXxn68I7mLqykF3SIOyMMY8Fo5EB7XKmDBxVCMaQ/zztyHfCIz5MvK/O97ujz0L2XH7s/AHILlFuf3Atoq+zOE64znC3v0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 15:47:35 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::401e:2e7f:7c2b:6bff]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::401e:2e7f:7c2b:6bff%4]) with mapi id 15.20.6455.024; Mon, 5 Jun 2023
 15:47:35 +0000
Message-ID: <a0ee77e1-7783-803a-1e66-14dc8c7cd9bd@amd.com>
Date: Mon, 5 Jun 2023 17:47:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] drm/amdkfd: Signal page table fence after KFD flush
 tlb
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org,
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>
References: <20230601193117.13143-1-Philip.Yang@amd.com>
 <20230601193117.13143-3-Philip.Yang@amd.com>
 <90a3ac90-4091-4542-89c2-778230d265a5@amd.com>
 <a521c410-787c-d235-f911-e34a9cd01640@amd.com>
 <4e390c3e-b63a-8fbf-8988-2d8bed0688b8@amd.com>
 <9dfb0942-b731-16f3-6792-a0ae1ac60ce4@amd.com>
 <f467155e-4582-9bd7-bc16-bdb584bcfdc3@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <f467155e-4582-9bd7-bc16-bdb584bcfdc3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::7) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: af6982f1-6e31-4eff-2a0c-08db65dc2e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZY9bPofIdjEKRCqz4CLT/uj2mZc82qqJq793XWw7WJh8QuQPvxqED9XgQQC8cw3kWzrEE8vj1+So6+mTaycwrjGzRgB4SPsMRcEIhslJHLDzMIRpvwyJEKkvJwwqOUMtozmG90iVP/Zrr1mPUG4gZkB6kL+DnwwKghoyZ+RcH0ZZ3bff7s91hgodCPswU6+SGXnyTIzllE/TvG3ky1OUZ9rp1VcFYQPyhtBtcaHTey9mrI/M01uRE4djcV9LLzUlr4X8B2CyuUz2021DZR2Rx4aZpwXGX3v8C7Uv5t4hZcrQ0DDgnkC0BTi+aH/3QrF8AUpaTyGUxm17cU85WS1Q4ige10f1b2Q1XO2nfbzsXMSbHq3HaNHcMOypPgitFvFytUQz3yF4PHKWkDz5XEaydZTnO0O3VmmkyoihFTQL2B4TTOjcQgvcl4WsZeBViArpZFMRyZjZVogmihfOXaEDlRt1+cjo6wzy5tJdnAMTecriu8VnR4hdFAwgdTNxznC0LyrejBYPV8s9kS/sB+ExNHzXLLM3z0l5/k8ksA9mEHbsTC9HeV8f6xPv/79MCqsmrfbLpy3AKeZKDeNIquf+uQkEEDq4HvYGC2S52g1D+t3BSe5e47KcCCImtQDkCl9EgrlFH/aBQnjeKZSwyvOOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(36756003)(2906002)(31696002)(86362001)(5660300002)(66899021)(31686004)(83380400001)(66574015)(6486002)(6666004)(186003)(6506007)(6512007)(53546011)(478600001)(110136005)(66946007)(66556008)(66476007)(316002)(38100700002)(6636002)(2616005)(41300700001)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blVLUHBQZTdWaDU4UjdpVXVFM0R2SktRUGFzdDlSWGpZZmVtOXlPMXd0cVpO?=
 =?utf-8?B?cGszUDNBSi9WTzAvaXBMVFNpMGp3bStVcm9KOW9HYWJQczJzVGFYZVlZL0JF?=
 =?utf-8?B?bUpNZm1jdnQ3ZFFNRXkyT0dmSHZFZ1NkZXlQcE9zYkJUMjgrZHZYU0xKK2pi?=
 =?utf-8?B?enJKei93UXUyc1FsVlZSOStoSHR4K1pNSmVuNXRDOElQR0xMUFJiMWZPaHFn?=
 =?utf-8?B?djEwRTZUM0tWVEw1WG1lSk5TL2hoV2NBTjlqbWNYZEUwSXFGMy93Y1Z1MXlv?=
 =?utf-8?B?Y2RSNUkxSk5QbkJ5eDhmbjQ2T0dkUFNnb0hCd3VTYjIzTE8vMEpmTG1LbmpU?=
 =?utf-8?B?MW9OTEJDUjhVQ3FrY0ZzUS9sNVhRemd5cjcrbC82UUNVemJwUUtTVTZESFFo?=
 =?utf-8?B?REpjSUUxYXIxZEd0aENIRmhSdGRxakVQWVhQQUxOVGcvQkI5dXpVc3RlSWhV?=
 =?utf-8?B?aXdFellReWdkVW91anB0WmR4eDVmZmFkTHR6NTdVN0VZeWdrRVZLajhXdW5Y?=
 =?utf-8?B?ektJM1FHWlNKeEYzMFZUWUdOTXM3NlhHd1FINEpVRlBSUWVMRUJkRlJKbnZC?=
 =?utf-8?B?MVlETVVneEFaZUtQcjFPcis1YjFELzAyT0RDb1NEeCtsODByUzI3NWZCOERT?=
 =?utf-8?B?YmNpTlM1a0NYTDJOL3U0NkJtKzhnb0RMZ0xERDV1YWJiaHFpZURQTUZUR09X?=
 =?utf-8?B?OFladkJrSEd5SXhMWlA2cytBMXN4OUJQUkNNRkZOKy9rdDJNcThGSlNyMmkv?=
 =?utf-8?B?cXRyT3hnTUhjSjd2MUpST3FCYkJ0c0U2QWJRdEhRVU5tRDZBTWRXUGx3UWNP?=
 =?utf-8?B?S1orVUdhOVJPcjlORGQ4emYzdUpYWUdMemNWUStBL0E4cVZCVTNiQXJIMUhZ?=
 =?utf-8?B?dGVsTThNSVo2TTdRNUFqeTR6d01CUzV2TVp5Ykh3TjBZSHg1MXNhdHlDRUd2?=
 =?utf-8?B?UjlLQVlXNkE3ZTdJYTdWVEY3dFdxK1I5Y1RDWFhPUCs5d1pPeDllallwOWZK?=
 =?utf-8?B?OEs2ZWpjb0g5dDZkUFNYVVlmUC9uV3ZVNXFlaVRmV2dvWnc0RHdHUEZjMnoz?=
 =?utf-8?B?ZDl0U0I5c2tiOWdVK3ZXZzdXcUpUc2h5TU9FaDJ1VWJoZXZRaDczaUw2UzNB?=
 =?utf-8?B?N3BFTjBRVVV3c3JEd1VWTWtUc0xzb1NiZTFhc0hMV1NFM2toVEdabjk0cC8w?=
 =?utf-8?B?SGNwcC9Lanl4Zm1CZzkvR083SGRaQzBvTzY4TnpmY0R6VDU3MGgxNkFidVd5?=
 =?utf-8?B?bTNXM0cwZHF0aFhrNGJzZUhxWXMzMTZ0bWFzajd1UUFtOHBpamJIQ3VQR2c2?=
 =?utf-8?B?STFxazJDUDJPNVphTWRmdjd3L21BdmdLanhPVXFKaE9DU2hIMk5pTXdZR1po?=
 =?utf-8?B?UzRGVXgrQk1HelZYcHZ6b05TY0JOSnlwREhsK2NlTzV2RHduNi9qZDJha2Zl?=
 =?utf-8?B?cnN4dm1XajRDVkhNdW0rV0xBS2xvQXQyQ1RlWUF2d3lxYVJxWDg3WVJpWTZO?=
 =?utf-8?B?SmFJOXhCNzgrYjRvVnRzdmpuSEVvRGZvMjJWUU91SFQ2NG5ZY3pzSkxpdi9a?=
 =?utf-8?B?VUdadjExeERQUGF0NEJidWFUbGR3UGwyRXpUc2ZBbXIwcGFvdnFKTkFySFpQ?=
 =?utf-8?B?T1lLd0NtczBROFlJdmc4T2cvSVZ4VElOdHRoRUJVSmtDUDZlWGdYU0tTUWVh?=
 =?utf-8?B?TDQxWW4rTzVNTTVyTGsxL3cxOCt6T3QrOFBXTFhDaHRTU2phSTA1djFoMHUr?=
 =?utf-8?B?K2dIbk9haFI3aEdWaklDNnE2c0l2WVJlTExKZS9MMTM4U2RTTllScUVZUGFs?=
 =?utf-8?B?YUFnWkFQOUl6dmZMYndwTHdLRmFiMXRJSlRqbUJaclRETjJJTjBuOEs3dEJn?=
 =?utf-8?B?czZCcVNsZlF4R2JJM0lXRXNPa0hraVRSVHFzMTUya0tSVTYrOFVlY0NLU2Fs?=
 =?utf-8?B?L1NSSCt2aDl5NzU5ZTNjZVV0U25IWTlnUnZxdEd5NzltMjVaUmxKUUpzWTg2?=
 =?utf-8?B?WU0rSk5LM0JzbzRsdm53NFR0RFE4WlUyZEptRmY5MXV0c1FGT2dNTGc2R2pz?=
 =?utf-8?B?Wk5iNERsSVZDRjdzVmFES25OWTB0cm1qbDFCUmMzNHhLRnRSNyt5UTZ1Y0dH?=
 =?utf-8?B?SFRmOFVRVnd5aTVNMFBmOFMwS2xXcE5nUElCTHYrM0VqY2lpUVdGbU5KT0Nl?=
 =?utf-8?Q?siSn2bGnw73xJeDPX8HMK3YYHUdfac7x7VhwidxDUgv8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af6982f1-6e31-4eff-2a0c-08db65dc2e8c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 15:47:35.5636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4knbMN1JFHQv/3jBf6Dpatf1gMyosG95+en+Y7ZNWh84HxnXi5/c6f+/I2WcA2Bf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006
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

Am 05.06.23 um 17:40 schrieb Shashank Sharma:
>
> On 05/06/2023 17:18, Christian König wrote:
>> Am 05.06.23 um 17:13 schrieb Shashank Sharma:
>>>
>>> On 02/06/2023 16:54, Felix Kuehling wrote:
>>>> Am 2023-06-02 um 07:57 schrieb Christian König:
>>>>> Am 01.06.23 um 21:31 schrieb Philip Yang:
>>>>>> To free page table BOs which are freed when updating page table, for
>>>>>> example PTE BOs when PDE0 used as PTE.
>>>>>>
>>>>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 5 +++++
>>>>>>   1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> index af0a4b5257cc..0ff007a74d03 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> @@ -2101,6 +2101,11 @@ void kfd_flush_tlb(struct 
>>>>>> kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
>>>>>>               amdgpu_amdkfd_flush_gpu_tlb_pasid(
>>>>>>                   dev->adev, pdd->process->pasid, type, xcc);
>>>>>>       }
>>>>>> +
>>>>>> +    /* Signal page table fence to free page table BOs */
>>>>>> +    dma_fence_signal(vm->pt_fence);
>>>>>
>>>>> That's not something you can do here.
>>>>>
>>>>> Signaling a fence can never depend on anything except for hardware 
>>>>> work. In other words dma_fence_signal() is supposed to be called 
>>>>> only from interrupt context!
>>>>
>>>> We are signaling eviction fences from normal user context, too. 
>>>> There is no practical way to put this into an interrupt handler 
>>>> when the TLB flush is being done synchronously on a user thread. We 
>>>> have to do this in such a context for user mode queues.
>>>
>>>
>>> We are currently working on adding a provide a high level kernel API 
>>> which can be called directly to perform a TLB flush. Internally this 
>>> API will add a deferred work to use the SDMA engine to perform a GPU 
>>> TLB flush work (to compensate for a HW bug in Navi Chips). If my 
>>> understanding is right, by interrupt context Christian means to 
>>> perform this flush and signal from that differed work, is that so 
>>> @Christian ?
>>
>> Well more or less. Ideally you put the TLB flush in a work item (or 
>> use the SDMA for the hw bug workaround on Navi 1x).
>>
>> The point is that you shouldn't have it in the same execution thread 
>> as the VM page table updates, because any memory allocation or 
>> grabbing a lock could potentially depend on the TLB flush as soon as 
>> you have published the dma_fence (by adding it to the VM page table 
>> BOs for example).
>>
> Would it work for everyone if we add this generic API (say 
> amdgpu_flush_tlb_async()) to add a TLB flush work and will also send 
> this dma_fence_signal from within ? KFD can simply consume it from 
> wherever they want, do you see a race condition if we do like this ?

Yes, that's pretty much the whole idea. amdgpu_flush_tlb() should just 
return a dma_fence object.

This dma_fence object should either be the SDMA workaround or signaled 
from a work item.

We can then fence the BOs or just wait for the dma_fence object to signal.

Regards,
Christian.


>
> - Shashank
>
>> Christian.
>>
>>>
>>> - Shashank
>>>
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>>
>>>>> What we can to is to put the TLB flushing into an irq worker or 
>>>>> work item and let the signaling happen from there.
>>>>>
>>>>> Amar and Shashank are already working on this, I strongly suggest 
>>>>> to sync up with them.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> + dma_fence_put(vm->pt_fence);
>>>>>> +    vm->pt_fence = amdgpu_pt_fence_create();
>>>>>>   }
>>>>>>     struct kfd_process_device 
>>>>>> *kfd_process_device_data_by_id(struct kfd_process *p, uint32_t 
>>>>>> gpu_id)
>>>>>
>>

