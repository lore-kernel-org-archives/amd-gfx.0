Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7C4C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 18:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B42761130
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 18:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B42761130
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F42096EDF1;
	Wed,  6 Oct 2021 18:23:33 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 862C46EDF1
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 18:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AM1I3HEA9T5IkgcOq4dccap665kPiuFSIWnS4z/rQKaVJkXE7mdzEg7pbNXoqOAIKiiDtFp2CBXXph+aAGBL1P/huydZbg2+n2HVVNq9e3TCAIfokmq5LFgyM/k/kulNRncCAggNTQbwSqAcUj5nxrOsPENYql51pyZdsIP2SDS51Gt2oN1+NTohAkCPnrV8fpnkLWQyoGkJnw3LRDu2WN/Wityb0cXWsT+5RJg2Q9/PbIg6v64y4M6j9Zz/h31XUexfQ9tCjN/B7I8OvhkwoFHiX11nJNi9sWqeOCS2o/QM0bR8aP4Nk7xrnaZ2C/Nt9dN+cav2WK1Yiq9wHLFKFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUzOA01DVRt2MrynWTRn2SnNMsEHhRWN11bwylXzWHo=;
 b=R9rtGYvENfnaQsDQogTcS/ckqSyqt2yRWDGfp+SxmaW/dhRhnfKtkOoO8BnniOtITHNeffKf53X+TooqJitw4koAqZgUkpJJqvHqzC+9yYQS8tKmPRxlklLcqDlPk4qjnTTX3BufbhRY065oKcHMRr7uNxAUqJoTeVbRDJEihAN+nAnBzYmJY0W9oVmtKUXdZrPVWH/lMOc+X118T2vKvdZ2ujwF2koQIgaGd/ZdXBRj736b7Guth4PS/SZ7NTCnprs6yAVePreV+4t+Gt28dD/+pqMTLt49XOCy1J7lEDUiidISF2Rk3OnKeyaHUP6sFoU5fn5c5jtoEd9MlqzPyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUzOA01DVRt2MrynWTRn2SnNMsEHhRWN11bwylXzWHo=;
 b=dMjAf8kmbNFAzLbaYrMLqRnotuusyuNednEXvf1WdUAFkjzuq7+XrcCLpCDhJG/9hz0e38eg105NgoPcAMV1VI9m+l8Nw5bjIReSBpVRBXa2aItiPin3oZKpuQAyoBfbQ+fhRYchE5+8PJY/388EhQ8HrpDjRZMUtDjorHgHWg0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB3307.namprd12.prod.outlook.com (2603:10b6:5:15d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Wed, 6 Oct
 2021 18:23:30 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::70bf:51ab:7cba:45c2]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::70bf:51ab:7cba:45c2%2]) with mapi id 15.20.4566.023; Wed, 6 Oct 2021
 18:23:30 +0000
Subject: Re: [PATCH 3/4] drm/amdkfd: avoid svm conflicting with userptr address
To: philip yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211006143210.4954-1-Philip.Yang@amd.com>
 <20211006143210.4954-3-Philip.Yang@amd.com>
 <5fb56030-ac37-3162-48b7-41cd70c08f0f@amd.com>
 <7fc4e4e8-a649-0032-b3cb-e575b5c4d8c8@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <bdbaf7d9-4c5e-4fad-6638-0be9d9861a56@amd.com>
Date: Wed, 6 Oct 2021 14:23:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <7fc4e4e8-a649-0032-b3cb-e575b5c4d8c8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 18:23:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97cec829-a778-4f86-73a4-08d988f66628
X-MS-TrafficTypeDiagnostic: DM6PR12MB3307:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3307AE73C75D09E4015A4B1092B09@DM6PR12MB3307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWyQD3oOy0O1rNQNWZf7jSadTAUJZnphxcbCxtG1rWoqj5ZzEchjlMCMnUQOUdqooNH8a9K3jXUoJhnEhdWrlJC/ov4lF3CJmX0R1sV63kwtOL7TSsOT8CSdIYLk/ytMLCBr4Pwwf6rtpJs7heEWO8qaJ/dFB18jIc/urRFKpP3u0yDqnV7p6uMm/YyMRE9le8ennq16n/LzrBAb0KNHFy63ViVdQPF/BEseoIQMoehNvuvOe6fg5Gm996bQdUCwWCPnuuNav8yj/+z9YafeS/QJ6dqMaMW8Q7sdH8OHMn88vT3lvchTXqCv/vj2S4X/zwKiVHlapW6Cr3dDGc9ihSSB6w9r1QrWH9ub4NcpkqJM2deF5J76nDctGynGl5lWx6yiM3ex8sEZlD4CmLGMbSL8U0DM7ywXhznnVg23p43i7xlBOlq0UaZmflNJXSTzFHybqmMvueIxYHinriVOxgmmEKIDsyFomrCjwB3LV41rHRvMH5/PWwjN9aBXUc1woPv5bjVmsDt/lJkjtO3iuaQEJG0UJNPoinaGlatjvrK+hFwcL8SAWZiUCx9QKwoOzK3/TexNkei7zkMiAO+G2sUe4wC9LGmX2EXFOsU72c0hO1prowbhVWe68YLZ4vjR53i0brZSkMIRCeHBnbuTZXkZg7afqpt74zwMvLtKshn41vd85y+0/l26fcKqt8tyBGJe/TiWYqIGGIqe0eykbrfr30aaqoeHNKnLbXlT9pvywIOv3VknUQh5VSxlDz1k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(83380400001)(508600001)(2906002)(86362001)(186003)(26005)(53546011)(31696002)(31686004)(6486002)(8936002)(38100700002)(66556008)(66476007)(16576012)(316002)(2616005)(110136005)(956004)(44832011)(66946007)(8676002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEZqNWRCS2t6VXNjbE5ZcGxoVTUreENxN1F3M2E4UlRRWWN2MkRXTTZjaHhs?=
 =?utf-8?B?ODFMNGlkQVhyWVZOS0prS2JCeHFwR2c4M09uK2NjR0FOVC9RazJUWXJLK3Nw?=
 =?utf-8?B?ZkFNT1UxeXlXVUZ2c1RDVlBLbms3RVNOOGR5OXBpZVlUdmpBNnFDek1pcEVs?=
 =?utf-8?B?TDZUVzdnUExhaHlzSkhmeTlrMGNrRm82WFl2VkkxL1RiZDZHNkdlaHArT3hk?=
 =?utf-8?B?eUZsRGwxK1paNFZ2Q2dJZkpwcmhua0QzbHd2dStvYUx1VGxUS2QzOUt0TXFo?=
 =?utf-8?B?bHQ1U2ZrQXhQQjVLYUo1ako1a0pnc1FBUWtGMldldWVta2toVFRWdGJ4ZHVs?=
 =?utf-8?B?VnUrc2M0Zkhia0ZYRU9keFlmbkZnckxiQnQra2tlOCt5dHByM0g3c3RSVWZl?=
 =?utf-8?B?dUZsdTk0VXNselBRNWE5cnhOclljb0dteTU2M0VER3NvRFVQZXpLQkhJQi91?=
 =?utf-8?B?ek9rM0hJUXRTMnNLcjU5SXQ3OWVJUUhydTV1VlhnK2NyeGp2Z2g2U0djQzBI?=
 =?utf-8?B?ZThhZGg1WnAxc2htMEttZklJZ3RTb0UwZE9KekFQYjJFZzhVemJzNTFhVkZF?=
 =?utf-8?B?KzlKQTFTbTF6UEhkSW9qTmVGZXFIM0pEbWdWdVc5WTVwdjN2bnpwNFVlM3Vt?=
 =?utf-8?B?VDZWUy9ra0QvSXdmNXNURmZqZW5lWmprQzNjckZEVUo5TThreHoyeHdMQnNu?=
 =?utf-8?B?ZlNPZUQ4cW9kY202WTBOMkhkNUV6YnhXOUhtV2dlU043bFBFaHZQbkMxbkti?=
 =?utf-8?B?Zm8wTGdGdjlnZ1ZaM3p4UUp1WWN5QUFma0c3czlZSjA5SDR3S0F3LytIR2cx?=
 =?utf-8?B?aEVQbFNEelJROElDbVRGRlkyQ3dUZWZsd1IzT0VNMU1vV2YzY3ZQVmhacFZ3?=
 =?utf-8?B?TGJ1S21OaXNFblM1MnlXMHBZWXpjS3B6Nk5HNnd1UllxM0NkellwRVMxd09y?=
 =?utf-8?B?UjNENXA1UVJlVEd1MUtuM2x0RGxqUDZHeDEwcGNLbWZNK0lEdjVuSVhVQ29E?=
 =?utf-8?B?c3NocDVzN3RSaVIzcFJCa3JoK2hXZjA2YWxJRGF6cVJXcnpZLzlPckYwRE5M?=
 =?utf-8?B?M3laQ255SkFjMW9pdFRRYUlrMFdxSU1zTm1yVVJ2RHZIdEVIMitVSTV6Rkdu?=
 =?utf-8?B?TzJGSHlBWlhZeHpPSmZyZE1tS1BxMUdtUStSQmlZOW9ucloxaW9kRVBCalVv?=
 =?utf-8?B?Kzk3Vkk1SlJ6R2JaeEZISkg2SWcrbGNLMlM3UlhPQkwyaUpHT3FudHlqMzg3?=
 =?utf-8?B?WnlpRTllNUpqcVUrLzRrVmdqa2xjL0RGZkFSN0NVS0tsM1hLeUNvZjQwMGky?=
 =?utf-8?B?K0hFYk1hRC83SXlzbVZ1UUFrajllY0F5alltKzdhSHFLZTRIQjBiU0lQRGlM?=
 =?utf-8?B?c0lVcE44L2c5Q21NMXBaS3pqbGU5MXpFYUMyd2VvcHJpUXJQbWswL0VZdXp1?=
 =?utf-8?B?Y2pRM2dXY0JOS05abEhjZUtIbWFFYWFmZVRNMTRpU1ZKa3NJQWZ0cmlvUjIy?=
 =?utf-8?B?SGpFcTFRZ2Z1OWkvdlBMMDJLRGw3K0drTTFubm1GY1RtaHNFYXlnbXA4N0lm?=
 =?utf-8?B?YlVxZXhsOXhVS0ZEKzFwU1U4TlJHUktzRVZXWHNtZkFzN3dudXpoMUlHbmp3?=
 =?utf-8?B?ZnpkaVdjVE1pQm8rT2d1K3FhRXFoY3pxVitJVjhjUCtselAvYkZtMlRGMXJI?=
 =?utf-8?B?aHFDdnMydUNweU5DYUU5UzlWVTMrMGNSRkI2SDRranRYNENOWE44cTVkNHp2?=
 =?utf-8?Q?fDYKYrEg1GA5BqoT4gyUakp7V3nW0k+xdIEAE+A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cec829-a778-4f86-73a4-08d988f66628
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 18:23:30.8214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOrbSXDAyboxXJf559SFcMl+Ld9uA1+nuJ30i/bPnHTla5G5av3YWTETEeMVKWTJNolg5xttMkuVUTQyNOJrOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3307
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

Am 2021-10-06 um 2:09 p.m. schrieb philip yang:
>
>
> On 2021-10-06 1:22 p.m., Felix Kuehling wrote:
>> Am 2021-10-06 um 10:32 a.m. schrieb Philip Yang:
>>> For ioctl_alloc_memory_of_gpu to alloc userptr bo, check userptr address
>>> does not exist in svm->objects.
>>>
>>> For svm range allocation, look for address in the userptr range of
>>> interval tree VA nodes.
>> Why? The purpose of the check is to prevent the same GPU virtual address
>> being managed by the two different memory managers. So checking
>> args->va_addr should be correct even for userptr BOs. The CPU virtual
>> address should be OK to be mapped with userptr and SVM at the same time
>> as long as the userptr uses a distinct GPU virtual address.
>
> userptr cpu virtual address is registered to MMU notifier, if svm
> range overlap with userptr, then migration svm range triggers mmu
> notifier to evict userptr and evict user queues, for xnack on, this is
> not correct. And restore userptr will fail if svm range is migrated to
> vram because hmm_range_fault failed to get system pages, app will soft
> hang as queues are not restored.
>
OK. Then we need to check both the CPU and GPU virtual address ranges.
Having userptr or SVM registrations fail like that is not ideal. It only
changes the failure mode, but doesn't really fix applications affected
by this.

A real solution probably requires, that we reimplement userptrs using
the SVM API in the Thunk, when SVM is available. That way you avoid this
conflict between the two memory managers.

Regards,
  Felix


> Regards,
>
> Philip
>
>> Regards,
>>   Felix
>>
>>
>>> Change helper svm_range_check_vm to return amdgpu_bo, which will be used
>>> to avoid creating new svm range overlap with bo later.
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 17 +++++---
>>>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 55 +++++++++++++++++++-----
>>>  2 files changed, 57 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index f1e7edeb4e6b..34dfa6a938bf 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -1255,6 +1255,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>>>  	long err;
>>>  	uint64_t offset = args->mmap_offset;
>>>  	uint32_t flags = args->flags;
>>> +	unsigned long start, last;
>>>  
>>>  	if (args->size == 0)
>>>  		return -EINVAL;
>>> @@ -1266,11 +1267,17 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>>>  	svm_range_list_lock_and_flush_work(&p->svms, current->mm);
>>>  	mutex_lock(&p->svms.lock);
>>>  	mmap_write_unlock(current->mm);
>>> -	if (interval_tree_iter_first(&p->svms.objects,
>>> -				     args->va_addr >> PAGE_SHIFT,
>>> -				     (args->va_addr + args->size - 1) >> PAGE_SHIFT)) {
>>> -		pr_err("Address: 0x%llx already allocated by SVM\n",
>>> -			args->va_addr);
>>> +
>>> +	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>>> +		start = args->mmap_offset >> PAGE_SHIFT;
>>> +		last = (args->mmap_offset + args->size - 1) >> PAGE_SHIFT;
>>> +	} else {
>>> +		start = args->va_addr >> PAGE_SHIFT;
>>> +		last = (args->va_addr + args->size - 1) >> PAGE_SHIFT;
>>> +	}
>>> +
>>> +	if (interval_tree_iter_first(&p->svms.objects, start, last)) {
>>> +		pr_err("[0x%lx 0x%lx] already allocated by SVM\n", start, last);
>>>  		mutex_unlock(&p->svms.lock);
>>>  		return -EADDRINUSE;
>>>  	}
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 7f0743fcfcc3..d49c08618714 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -2679,15 +2679,18 @@ int svm_range_list_init(struct kfd_process *p)
>>>   *
>>>   * Context: Process context
>>>   *
>>> - * Return 0 - OK, if the range is not mapped.
>>> + * Return NULL - if the range is not mapped.
>>> + * amdgpu_bo - if the range is mapped by old API
>>>   * Otherwise error code:
>>> - * -EADDRINUSE - if address is mapped already by kfd_ioctl_alloc_memory_of_gpu
>>>   * -ERESTARTSYS - A wait for the buffer to become unreserved was interrupted by
>>>   * a signal. Release all buffer reservations and return to user-space.
>>>   */
>>> -static int
>>> +static struct amdgpu_bo *
>>>  svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last)
>>>  {
>>> +	struct amdgpu_bo_va_mapping *mapping;
>>> +	struct interval_tree_node *node;
>>> +	struct amdgpu_bo *bo = NULL;
>>>  	uint32_t i;
>>>  	int r;
>>>  
>>> @@ -2700,16 +2703,42 @@ svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last)
>>>  		vm = drm_priv_to_vm(p->pdds[i]->drm_priv);
>>>  		r = amdgpu_bo_reserve(vm->root.bo, false);
>>>  		if (r)
>>> -			return r;
>>> -		if (interval_tree_iter_first(&vm->va, start, last)) {
>>> -			pr_debug("Range [0x%llx 0x%llx] already mapped\n", start, last);
>>> -			amdgpu_bo_unreserve(vm->root.bo);
>>> -			return -EADDRINUSE;
>>> +			return ERR_PTR(r);
>>> +		node = interval_tree_iter_first(&vm->va, start, last);
>>> +		if (node) {
>>> +			pr_debug("range [0x%llx 0x%llx] already TTM mapped\n",
>>> +				 start, last);
>>> +			mapping = container_of((struct rb_node *)node,
>>> +					       struct amdgpu_bo_va_mapping, rb);
>>> +			bo = mapping->bo_va->base.bo;
>>> +			goto out_unreserve;
>>> +		}
>>> +
>>> +		/* Check userptr by searching entire vm->va interval tree */
>>> +		node = interval_tree_iter_first(&vm->va, 0, ~0ULL);
>>> +		while (node) {
>>> +			mapping = container_of((struct rb_node *)node,
>>> +					       struct amdgpu_bo_va_mapping, rb);
>>> +			bo = mapping->bo_va->base.bo;
>>> +
>>> +			if (amdgpu_ttm_tt_affect_userptr(bo->tbo.ttm,
>>> +							 start << PAGE_SHIFT,
>>> +							 last << PAGE_SHIFT)) {
>>> +				pr_debug("[0x%llx 0x%llx] userptr mapped\n",
>>> +					 start, last);
>>> +				goto out_unreserve;
>>> +			}
>>> +			bo = NULL;
>>> +			node = interval_tree_iter_next(node, 0, ~0ULL);
>>>  		}
>>> +
>>> +out_unreserve:
>>>  		amdgpu_bo_unreserve(vm->root.bo);
>>> +		if (bo)
>>> +			break;
>>>  	}
>>>  
>>> -	return 0;
>>> +	return bo;
>>>  }
>>>  
>>>  /**
>>> @@ -2732,6 +2761,7 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
>>>  	struct vm_area_struct *vma;
>>>  	unsigned long end;
>>>  	unsigned long start_unchg = start;
>>> +	struct amdgpu_bo *bo;
>>>  
>>>  	start <<= PAGE_SHIFT;
>>>  	end = start + (size << PAGE_SHIFT);
>>> @@ -2743,7 +2773,12 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
>>>  		start = min(end, vma->vm_end);
>>>  	} while (start < end);
>>>  
>>> -	return svm_range_check_vm(p, start_unchg, (end - 1) >> PAGE_SHIFT);
>>> +	bo = svm_range_check_vm(p, start_unchg, (end - 1) >> PAGE_SHIFT);
>>> +	if (IS_ERR(bo))
>>> +		return PTR_ERR(bo);
>>> +	if (bo)
>>> +		return -EADDRINUSE;
>>> +	return 0;
>>>  }
>>>  
>>>  /**
