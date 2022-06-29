Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2149C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 23:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E5A510E621;
	Wed, 29 Jun 2022 23:29:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A53A10E621
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 23:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RG8zX1Yl5eSQrBkMyy8D9swgh2aNggtua13ah59agID6SHJTFn2JOomK3A/dPHXuurtFs6djWvHIDzRrEKU/WtSn9IOSbZjJdbV+zOm8xmhNVCZD/G76Lt8nN08mOKh/8DQPdIqRgXauhj/SdDUn4Z/kTkhW0fG9QcXX6iZDOrPCCBMoV0Mu8YjVeUdtoMPAGaEefMjsWP5f/uHKmGTGaw4PdJXEkDBNB1BpIhQFGtyiKdxFOQtNM3Gcz7PGJ/CcYR5fNPnfjVA/mGlOqYKncBzqdi/iHK9nWqMsuQUcE7fzyzdcGa7MPNR9FDi7DiVHNUWFuOTbqmA7n9Ej5APRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgGCITIA1KPcF6Xh7DI+T0OJ8FT5KPxI1bT7FETLHQs=;
 b=mrbManJCAYXlTsjiVPU/DE3+//V434IKcbtaq0yiHHe9ME1+qxkWfrptO+cjgNKu40pWbHQJCIOT+uKrHVgcLLwQRcDNGqGY4yh6PRpd51qJVBC+fTu2kE2l6ac8RmCQ8m9VhQHoNvcNZQ8zuiB6KO9TfWKC2e2KPDnr85/F9v3auFwPE/xkeGO1dJnRxJrp+Errn7vp0LiuposBRhFs3RnkgdKuvA7N8MKfdtxYo/tS9bGjr5V/UBaAKKA7dHAY7OMaewSYwci2HgAR172iqG4gZq2hzpLJhTcX6NbOH+1+xd0zcSUyT9mkqd1feGwItWWYsgl1iwmaf+H2PQquxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgGCITIA1KPcF6Xh7DI+T0OJ8FT5KPxI1bT7FETLHQs=;
 b=LOU3Aykm8uReorUY918Cosgr5pDWubiGUBKXdXlXiacKpU8fXOoW05HipfvbN9Fu7NGw78EnXNxUTcdZrR0Y0tc5MiVvWrS9UdNoVyd8KokF+fyAzPpjBrOxIYjr4uEdoNdW7zWh+4srfPrb6JdqnsMbx4zzmJcDcd4zTYm1jG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY4PR12MB1829.namprd12.prod.outlook.com (2603:10b6:903:11d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 29 Jun
 2022 23:29:37 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa%6]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 23:29:36 +0000
Message-ID: <c3f52156-1a71-87c2-a84a-323fcaf85251@amd.com>
Date: Wed, 29 Jun 2022 19:29:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] drm/amdkfd: change svm range evict
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220628214315.235160-1-jinhuieric.huang@amd.com>
 <20220628214315.235160-3-jinhuieric.huang@amd.com>
 <99b8907f-9aa7-7aec-4895-cc94b0b58bec@amd.com>
 <4bf772cd-f66a-2dc6-4ace-81c56e3f6436@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <4bf772cd-f66a-2dc6-4ace-81c56e3f6436@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:610:b2::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 023138ad-b11a-404d-7fbc-08da5a273b17
X-MS-TrafficTypeDiagnostic: CY4PR12MB1829:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i1dWf7CK8hKFsDl3ogUQZvIGuYVkQv0UA2OvBLAYj83fvXdn5yXFhkyk5+9KuLnKhwF0ouECN26ZjiOiF5pL9SeOJxaKbej7//65KpSMLLW7CZwQvFCFCfdBEYXBU2EUBI847sEWKdqU51j2klXjXgbeTbMoCBWPzWycTAKm+xCgQbIehXPijJAMdxwLdrptngOJBzepoJvowROr6AuFcvEv5ZyD8keL4nxSDCMDxBQae2edJUsYy10YZRPay8v2KBJSmclbXKr1apDKU+K6ygjsa2weeLNlHHqv5c66EDcSqZ5omJ9gOZxcBxswhVCbhp79CB16qSZQ7ZsZpMW9qTVpiaUyu6kiBxlEOIpRR5LBM8WJVoeYK7wKWC7vyOr6wCmtWFbf6nz0ZbhFfoopxNID2LF8gkeB5cI6PbtE2V06gikeudlnDzCZatAkHLmb/1z88lrq4vlHe6ffBBJvNVvcq3n1+MvbJTHWd40svNc9YNRS7UcriLJiURdtCj4nyQsSrJRGYrm6Z7Nl/Kk8jTcaBBm8E5WvKw5gaf9sRo8JCf/1P2SuTszmG6UWscuNVOGordKe3LB9QeMsAaHFEIxaQ7JQIWlehq+7QENy/0xO4dm72YEtINQzeuuHON1NTB0FShVHcJD/t5pZuxZhFV0/tu8kC8Bgf8Q9C5WDWu3TnB9D+47cFG1IWeCf+yX6fcyStnNdU/iYPBwWB+eVvn1yaaHZfZ1TuaeaWxQquFXWwKP4l+fzGmwvled3za6BIjoFfC6eyVBvNI5quyafUuHXiHp5detXcCDfFbA7PW8i/GAO726c4S/gpFlhCOX0hjPa7hbWWp/idgouiENCTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(186003)(6506007)(6486002)(6512007)(36916002)(38100700002)(53546011)(2906002)(5660300002)(316002)(36756003)(31686004)(8936002)(66476007)(478600001)(66946007)(4326008)(83380400001)(66556008)(8676002)(44832011)(41300700001)(26005)(31696002)(2616005)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amt3Y2xyb0tzOWJtZVFVZll1VC9FWkZWTEhUeFd0bFBaT1Axa0hoNXJ2b0FY?=
 =?utf-8?B?eHh0WGlKcFhncXNlZ2NRVnQ0RjU1MGFNeDQzOStrc3k4bVhPV2dnNDBmcUoy?=
 =?utf-8?B?RU1hRWVkcVhxbm9RS0VaSWxJNGZrZnZWcmVRVjJ2enRTcHk3T0NuQVlZVkg0?=
 =?utf-8?B?d3NjWWhLTklmUWIzcmxwTTNXcmdwVXZ5U3RoYWMwcFYwRzRNNm9GR2lGS05y?=
 =?utf-8?B?NVN0RTE0Z29aSVZVK1QvckR0UzhybVZPV0doT1ZXdlZ1bjVncUl4VXVuZ0tE?=
 =?utf-8?B?c2xRb044Tm1xT0Q1VWgzUzFhZUUwaC9BZzlDVHNSOGZKSHlQeUtGL1Y1YXdl?=
 =?utf-8?B?NElWd1JyUitpbGJSQTZZWExocHg2TTJTdzBNZ0FGdi91LzdaZ05MWFgvSnZ2?=
 =?utf-8?B?Z0xZVVh3UFluOUw5YWhDdVVSOHlXRGN3UGdyV01vWjlSSytTZEpKMERNNWFC?=
 =?utf-8?B?YUsreWxWYTdYK2RBOFVqRXVDeXBBYnVWZ3piVElGcXhvUlp2enkzd0NZWVBV?=
 =?utf-8?B?UWNtQVhCZUxiTzVLZGYrRG9WZzl3WStwbWs4bXFlM0VnVlVxK25UN2x4UUg2?=
 =?utf-8?B?eFhZeVpTRGdLaXVUdEVVUk5UdmRQSytSTWhZZ2RwbG1QVWEyVjVaRHNSTkJT?=
 =?utf-8?B?TVAwWXZJVTIrOUFuZnBGK1BZY2J3ZFM2RkpaMXJzcVJrejFXNmJ6MkpWdFhh?=
 =?utf-8?B?a2grelQ3MXFJTXdIMjFVSm16cHdWY2xWenk2MGRGakRIQ3NsYldHTzBkTFd5?=
 =?utf-8?B?OFRIWjhXUlMvK3BzZzZVZ25vNTBOUFIyZXluRUVCbXhRL1hvMzQ2eTNSNkd6?=
 =?utf-8?B?MUcwekhaeHV3dGJGbUlvdUE5dnFSTmEwRWFGVGpTT1ZPcHgxMlF3WStLRmp6?=
 =?utf-8?B?T3RDM0EwcUZTZmJ3ZldMUTJJV1F6ZXQwMVpzRDNCQU56dXBWMGNKcThmNnJK?=
 =?utf-8?B?OEZvcFVHcGdKRGRRbU5uMXhHT2JkRC9NUnNaS0VCR3lNK09HUXc1WDdySEUz?=
 =?utf-8?B?OUd5Wm9ESHJMSUVxa0hmSlRHOEx5STJQK2Y0clBySTRqU0ZBc0g1TTl3Wi82?=
 =?utf-8?B?aUQxeVZiYWZldXowdzZCWitGUlFDU0ZLSU9HSXJQZXplc1o1TmNCU2V6bWM3?=
 =?utf-8?B?c2xKSEVHMEZtRGtwS2lKTGZ5aWhNRy9FUWpRSnBSbGFYRlJnWXFrbDZnR3Ra?=
 =?utf-8?B?ZzlDaHp2dGoxWEZxQ2pYK1d5QURHTUoyYlRvYy9ReE1henc2NUNMM3lCZmR3?=
 =?utf-8?B?dmtGU2Roa3hMSnJqcFR0b0F5OVZNbFBDczZzaWp2S0xERU9zaUR0cWRSeS9U?=
 =?utf-8?B?bmsxMHVUMThGRkxUL292RzFDNjVBOE13UWpKcnVJNmU5STUybUlFN0xGZHpJ?=
 =?utf-8?B?cWdxM0lpZE5sanQvL2c4N3ZIcXY0UWloV1lKa3ZWaDAyRU1kYzdTWDhFSjJq?=
 =?utf-8?B?bTFxb3l3aFBEWHhYbHNORnJuSkMyd2drQXJjNWEydUMxdkNQWnptcVBCUjlr?=
 =?utf-8?B?ZUNBYzdrWlAzeHNEem1aK3VmaWJwa2hsVkhGc0VMTis4d3FkeWZ2R2tMTjV6?=
 =?utf-8?B?RGozQ0pkUEpIZDBFUFJkNFlSQTJITnJXSFVoSXdFNEkrQ3dBdERRVlhTTi9H?=
 =?utf-8?B?RkJTdWtSUmRzaTdpRkx5UWVOdzJoSms2Z3pPdE1XWEQ2Mk0wRVFucnNqSlI1?=
 =?utf-8?B?VVRLekduRG9XQjlvd0ZreEllb3hUbHNpeGV1SEprZGJhM3VwZUZCL283Y0dN?=
 =?utf-8?B?aEZxQnBiZzdlRGt2U2p5YUxHSm0xcGxFK1NoTDRiQXlpNW1NMVhGWVd3c0dn?=
 =?utf-8?B?dEx5WWQ2K1dFTUJzbFUzY1VGYkxHbjk1S0JRUWlPNEF3OU5SUHdvODdnU0Vv?=
 =?utf-8?B?MDlNLythcGtFRmlKT2UxcjQvM010Tk1MVUFCSlUzK25KazdpdW54R0FCMDYy?=
 =?utf-8?B?eDJGU0RKdDkxZVJldFcvTHU0a0pITnF6Um9vd1NhN2dFTmVWTE81YXB6THBV?=
 =?utf-8?B?alMyTDFNVVo5c0JSZFBoelhuS0xNSmhxeEdZM1crS21wcVJPOU9GUmNNb0Rk?=
 =?utf-8?B?b2tjcUdySzdEUmlMUDdWQUZ6c0JZK3FDSkNVcTcvRUN5SEorczZRSERGZlA4?=
 =?utf-8?Q?lWmjnGjHqNfV86pP3aXqY2Rbw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023138ad-b11a-404d-7fbc-08da5a273b17
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 23:29:36.9060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGXmvkEY8MwHhI6ATf0KpZmHJhNSM8kJb8dZ66KjylDSz08vlxXI+KOxtZAyCqoGdfPFfuLfvyv+5u/QRAv7jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1829
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

On 2022-06-29 18:53, Eric Huang wrote:
>
>
> On 2022-06-29 18:20, Felix Kuehling wrote:
>> On 2022-06-28 17:43, Eric Huang wrote:
>>> Two changes:
>>> 1. reducing unnecessary evict/unmap when range is not mapped to gpu.
>>> 2. adding always evict when flags is set to always_mapped.
>>>
>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 10 ++++++++--
>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 4bf2f75f853b..76e817687ef9 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1767,12 +1767,16 @@ svm_range_evict(struct svm_range *prange, 
>>> struct mm_struct *mm,
>>>       struct kfd_process *p;
>>>       int r = 0;
>>>   +    if (!prange->mapped_to_gpu)
>>> +        return 0;
>>
>> This feels like an unrelated optimization that should be in a 
>> separate patch.
>>
>> But I'm not sure this is correct, because it doesn't consider child 
>> ranges. svm_range_unmap_from_gpus already contains this check, so 
>> ranges should not be unmapped unnecessarily either way. Is there any 
>> other benefit to this change that I'm missing?
> I will send another patch separately that considers child ranges.

I think this should only be done in the XNACK-off case. For XNACK-on 
it's already handled in the svm_range_unmap_from_gpus.


> The benefit is it will reduce unnecessary queue evicts when allocating 
> context save memory, which is unmapped to gpu.

That sounds wrong. The context save area should never be unmapped from 
GPU. That's the whole point of setting the 
KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED flag. I guess this is happening 
while migrating the context save area to VRAM for the first time, even 
before it's mapped to GPU?

I think there may be another eviction, when the CWSR header is 
initialized by the CPU. That would also migrate it back to system 
memory. To avoid that, you should probably register the context save 
area only after the header has been initialized.

I think avoiding an eviction when memory is migrated when it is first 
registered is worthwhile, not just for CWSR.


> It is for efficiency reason. On the other hand, without this 
> optimization KFDCWSRTest.InterruptRestore fails with queue preemption 
> error.

What do you mean by "queue preemption error"? Does HWS hang?


> I think the reason is the extra queue evicts make HWS too busy to 
> preempt existing queues. There is one unmap_queue packet sent to HWS 
> in current code, and will be three unmap_queue packets with unified 
> memory allocation.

When queues of a process are already evicted, they should not get 
evicted again. That's handled by the qpd->evicted counter. There should 
never be multiple unmap_queues packets in flight at the same time. If 
you're seeing three unmap_queues, you should also see queues restored 
three times.

HWS should never be too busy to evict queues. If you're seeing 
preemptions fail, you may have found a bug.

Regards,
   Felix


> So this optimization will keep only one unmap_queue as before.
>
> Regards,
> Eric
>>
>> Regards,
>>   Felix
>>
>>
>>> +
>>>       p = container_of(svms, struct kfd_process, svms);
>>>         pr_debug("invalidate svms 0x%p prange [0x%lx 0x%lx] [0x%lx 
>>> 0x%lx]\n",
>>>            svms, prange->start, prange->last, start, last);
>>>   -    if (!p->xnack_enabled) {
>>> +    if (!p->xnack_enabled ||
>>> +        (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
>>>           int evicted_ranges;
>>>             list_for_each_entry(pchild, &prange->child_list, 
>>> child_list) {
>>> @@ -3321,7 +3325,9 @@ svm_range_set_attr(struct kfd_process *p, 
>>> struct mm_struct *mm,
>>>           if (r)
>>>               goto out_unlock_range;
>>>   -        if (migrated && !p->xnack_enabled) {
>>> +        if (migrated && (!p->xnack_enabled ||
>>> +            (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
>>> +            prange->mapped_to_gpu) {
>>>               pr_debug("restore_work will update mappings of GPUs\n");
>>>               mutex_unlock(&prange->migrate_mutex);
>>>               continue;
>
