Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0015ECD37AD
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 21:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8064F10E68C;
	Fri, 15 Sep 2023 21:33:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88A7F10E68C
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 21:33:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0rz9Z09HA21HRWl+c8Qzzh2w5u+aDiqf5uT56ob4MCT2X7xD5JY2GcauS5mG6jLYkbTBBMGlHfTujKLPwCAEuLMBbGU2kJITHmMXbirS0eMKEgsu47EmcpImYQUCyKuULJ3654KYA1HInFwuhkLFoWUx6rq69FR0PTKXW4fZ6oztdp/bCdMwCC2l6fllyUKH7Cq4kx90GqWIBQ2PtUOg0jt2qXOZoICZq9KoQbiZGDhFEs+9kl82+Eifv7Xr57OrxGALauPzG2DLYvLfw+sx28lhOUwpaIrXl1aCj83jS8ka4XL8NItCgtHdQdaC11rpw5a3MgPaPxxyJ1QHoeybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKR4chtShFwSTrRIzL/Kkoky5uoSjdFVeQ6raQ/CCLY=;
 b=mrUfjK7atIo+jgEyiCmJcJEneuAfVzCtp3BnsWWv5eEbXXJLI2belrYdtHiVINqs2OqRdUlh7zb9a1acpW0E+3ziDRYVGK/zYomfZvfDjaLt7D++6rTTaEWal8IRE3+8g5HdoEtwxn7+O4O8ermeMYfb3LONCinHYPFdE5fO2MeoEPSDxMAI2ArqPRCxK0YIodLjcOi87v3AvyDOkkmQMDeQO6GVeNtB4r7LuPUe8lvOCbcb7Nm7KSlwgVpvI9wtKjD3+2F7uEaKzPKypdJpEI3+keqzBnwOMFodbK2jnwsHET8GE0kpefrw48SUVys9O0q92u9RWugsYBU7Y9kSWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKR4chtShFwSTrRIzL/Kkoky5uoSjdFVeQ6raQ/CCLY=;
 b=WlAl8AihnQQ5RDdiZPr2waKFippxwfvEKENt2/DzjsEEpy+R+X9pqY2x3m5uGcDxekqEdXvO1XLi64OgNNYeOlzL9c7anftFXybtGp/jDmwZMQWCGL1ZtlpMH/Fi0AyBPoRmZMTVmY56EvQnAjHI1W392K1vFpBzgmLpt2Bzp+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 21:33:37 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::5502:371d:cbba:aed]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::5502:371d:cbba:aed%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 21:33:37 +0000
Message-ID: <a01a8dd1-c4b2-b632-1116-40836d2a5007@amd.com>
Date: Fri, 15 Sep 2023 16:33:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] drm/amdkfd: handle errors from svm validate and map
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230913151617.18894-1-Philip.Yang@amd.com>
 <20230915132804.20813-1-Philip.Yang@amd.com>
 <28e8c90b-0ca8-6c66-0ac5-18277aa0ddf3@amd.com>
 <5ee60075-10a2-e3d5-4e5a-538fca90bc58@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <5ee60075-10a2-e3d5-4e5a-538fca90bc58@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0238.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::33) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: bbacd4d6-0843-454b-bd88-08dbb6336b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CbH2Z/sHhHFvD4ekKz4+G5eNrdwOnQE0HYot53Km7jAq8Y/gLPzZ64W+pkcxKnyfl4xLTWO3T7f86ztr937HserA0P5iUM4Mvm8oay7llIuGoAAtrvvVyxJCUqvFAbG8t9wkS7VeqziVKLp0UuDQ2YVOitHCATVGWLqikxLswR71AL+G8hh+OVbYAGLSuKxq/PbRkmHloC8AfihM7lv18V4whg8qC2xjYx+9RrlPPC/9ecM5l5B8EGTB8V0l++vu/mTvwPutQtW3Py7xSP1SVmufZnT8F8fHMnArpO4ooGWaDfXdkbj1yxvV8Zmn9eydbkvErbh07KdJM7pHsQh/gEOIOwanuTeKIg4FRJBQY58MZqCdeRUsslSe1fXIq1WdSduBr6U0QvkGFiDtw78F32odklq3kBlMvrwmoom1UM5otHTD612D6b1fUofRWF6k80vBImMie2AOCj3ga3D1Tg6MvKsGZwC9jDZ552rbFGcnIHeRVJvJ/j1XktkJGxv6VzasnZGQz3zIIRlftBsTtAjuCIFZ5UijjClr1DnYMWmRuwfAs0hPyFSQvsvSBRrlETo6grhqP1sXwwFcVHcvkHw/5RP4i/2GQUvPirZtOONTlp0GwbpPN4OGKhbzIFNMrucuFACk5xO+X4tETEWRRzDKIpb7cg30liRrplNz3Ui6CAX1fjkpH/nvrYqnYOFe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(186009)(1800799009)(451199024)(6512007)(316002)(110136005)(6486002)(66946007)(53546011)(6506007)(83380400001)(66556008)(66476007)(478600001)(31686004)(6666004)(41300700001)(4326008)(8676002)(8936002)(26005)(5660300002)(31696002)(38100700002)(15650500001)(2906002)(2616005)(36756003)(86362001)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1F0ZVlsN3pxbkpNT1FJYVhMOEEwd2ZxOGxXbWpPR1FPemRaL1ZBRnRZbDVV?=
 =?utf-8?B?cU12NlZJaEVoVkpvSS9aWmIva1g1aVYydlhGMnYwbUZDamlWaXh6eURMR0E5?=
 =?utf-8?B?Y3dSSkVYajRaMHEzUkxkTlZQbXpCclF4QnRJN3VsaEpXYXV5ZXVYSERNemt5?=
 =?utf-8?B?VVRiR2xGdGdwU1o3eDl6aDlGNnY4OXppTjV6Tjkzc0JYdC9DaWg1WURYNmFG?=
 =?utf-8?B?T01uMSs2QWNWeGdvOWJKTDdmOXpkK3AxZHROTmQ4MkJJV0d5c3VaMEFXMWN3?=
 =?utf-8?B?QkwrM0E1NmNDdzVQcjZzRGh6WkgxKzA4TkRHZm1MdStTZmIrOXNXV1l0eG8y?=
 =?utf-8?B?amlGV2NaQzMyS1F0WUFRVHdZZmlTQXl0d0NCemN3QkxZY3VGVkpRdHpQME9N?=
 =?utf-8?B?Q1BDRnhRWGxpNDF5V0w2bXpoREdBUE9wKzArdkk1dmlFQUxzdHViam0wb0tF?=
 =?utf-8?B?alQ3Q2NhdC9yYUpwbXQ2dGRiU2lRRGNOVlhib0NEWk03Q1p0WExnbm5HMklz?=
 =?utf-8?B?ZENnYldTdUZZRnFvWkRVMjdIS1RoT3g4NkhJMnpNUXQ5UzBxUG12ZmpYc21B?=
 =?utf-8?B?bjBnWVVFY3J5Z2d0WG9BY0g4b3E2SEF5UEJmWDlKenU4RkJsNlZLZUFnaXBD?=
 =?utf-8?B?K1FPSFluNWgzNDl2a0hoOHV5d3RIRk51WGZxNDUyckVwbXpTcmRwZXpSdmE2?=
 =?utf-8?B?TnJWQ3J5dzhHNHNYTllNMDV4UUx5eTJOOU9NTGhWOGNac0FUTTNoYktudXpJ?=
 =?utf-8?B?dmMvL1BCdU90b2FTWnZBcHlsV3piTjNIQ1JoMlJLWEwvOTNIMjVSMVFlUnFT?=
 =?utf-8?B?Zm4wY0FxVnZPZDFESFJnV2NYajBmWGNXa0Y4cFdOalI2anZ6THZLSytoQUs3?=
 =?utf-8?B?MnJaeEp2aEVqNngybkVwZ3pDSW5PRjI0aGw0ckNqZnV0NFhQYS9RVk5EZmZV?=
 =?utf-8?B?aGtFa29DQTFjdWNDZW4wV2pydHlmVTQ3OVoxQk4xSDhUdnNpcmZuaXgzL0VM?=
 =?utf-8?B?M0N3a2ZseUt3NWZPbWdHNGtFanBFZnQ1M1hJSUN4bjBwYS9hNHMzM1NJenZr?=
 =?utf-8?B?RGRRZTN0UTZDc0JKaGo2NFNRamVVb05DWk05ZWlKVk1kMzBBcFU0b3BXU1Z6?=
 =?utf-8?B?Sk12WkJneGxyaytHM05zUFkxbnovcnFBOFYzTXpHN29HNjhydDlKZHZEYktn?=
 =?utf-8?B?anEyaldtS3A4cnl0RWhQQk1sNkIvVVFMNEYzSGFNNHJXVElSRGNqZXFheE9r?=
 =?utf-8?B?VWE0eVFqSFZGTWxQenZGVE0vbWZCd3liM1E4dndiWjlhK1gyRlJPck96ZDVV?=
 =?utf-8?B?T1JRK2YvZU8yd2xlc1hqYnNJNmt2dks5SnlhTkhlU3BNOWZHK3dwaTNxM2c4?=
 =?utf-8?B?QW1qcUVhZk5wWjNXNHVFTklOZFpaV0RXNUFQd01rWnpKSlQ3aTJuRUZUQVRy?=
 =?utf-8?B?ZDJ1T3FTaEo4QjVyU2NKUkd6ejdZazZkTkwzaG43dzBVcm1jdnFQZHptM2VK?=
 =?utf-8?B?NW9iUmptbURjL1BqNUhTTUs4YlZQQlJFUkd4UW5za1poTWR3SHdRaks2dFk4?=
 =?utf-8?B?RVNSc0w1SlRpVTJzdGFkVUwzMVh4andSbG9NUWExRC9pUi93TE50SUYraCtB?=
 =?utf-8?B?Y3N6UTc0d0J5b2tQTnkyUVRMODM5TVdSVXFzMmxGaE9NSzFQdFVZNjhrU2R4?=
 =?utf-8?B?WHVWZjFFSGduS3E1MnN3Qy9DZ2RFWG04cEQwd3lGaDlvUWRCdXIwQ25UdGp6?=
 =?utf-8?B?c1lWQUw5QnordFRzNm50NmRjN1M3Si9FbEh6UkpVOW50NUZpU3ZPeUpDN2NM?=
 =?utf-8?B?Q3RCOHR3WlZyaEpNZ2FHNUROai9uTlRWL2pmVzJtNzl6Vk40MXJRcWZOMmFG?=
 =?utf-8?B?dWxBSGN6Um95U1BKWWJvNjYyS0gvOWR4b0ZYWWFHc0U0citSR1hNdzFBdXpB?=
 =?utf-8?B?MlRqeEduY2pDZUFSeEZ2ZnFZcSsxbktzMTF2QU1rVm5YUWdtQlp0ckdGaU9y?=
 =?utf-8?B?QmZXSnBxZ3BFd1BBQW5PSzAwbUEvbWpkNU5OYnVmVmVFa1JPOEQ3ZXVHa2R0?=
 =?utf-8?B?ZVlpTisySXIvcUN5MEJTamwwMFNUUU1sVGc3QXlTQk1RcVQ5MTRGZmFJVjhM?=
 =?utf-8?Q?rH5Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbacd4d6-0843-454b-bd88-08dbb6336b96
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 21:33:36.9578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbbDDZhOB7JWQFB6Uc8+fbGBMb/diX8HF1gLT9/7iN/SHavX80NfrflC+VexW/XR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
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
Cc: alex.sierra@amd.com, Felix.Kuehling@amd.com, james.zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 9/15/2023 4:20 PM, Philip Yang wrote:
>
>
> On 2023-09-15 17:06, Chen, Xiaogang wrote:
>>
>> On 9/15/2023 8:28 AM, Philip Yang wrote:
>>> Caution: This message originated from an External Source. Use proper 
>>> caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> If new range is splited to multiple pranges with max_svm_range_pages
>>> alignment and added to update_list, svm validate and map should keep
>>> going after error to make sure maps_to_gpu flag is up to date for the
>>> whole range.
>>>
>>> svm validate and map update set prange->mapped_to_gpu after mapping to
>>> GPUs successfully, otherwise clear prange->mapped_to_gpu flag (for
>>> update mapping case) instead of setting error flag, we can remove
>>> the redundant error flag to simpliy code.
>>>
>>> Update prange->mapped_to_gpu flag inside svm_range_lock, to guarant we
>>> always set prange invalid flag to evict queues or unmap from GPUs 
>>> before
>>> the system memory is moved.
>>>
>>> After svm validate and map return error, the caller retry will update
>>> the mapping for the whole range.
>>>
>>> Fixes: c22b04407097 ("drm/amdkfd: flag added to handle errors from 
>>> svm validate and map")
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 ++++++++----------
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 -
>>>   2 files changed, 8 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 5d7ba7dbf6ce..26018b1d6138 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -818,7 +818,7 @@ svm_range_is_same_attrs(struct kfd_process *p, 
>>> struct svm_range *prange,
>>>                  }
>>>          }
>>>
>>> -       return !prange->is_error_flag;
>>> +       return true;
>>>   }
>>>
>>>   /**
>>> @@ -1724,20 +1724,17 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>                                            ctx->bitmap, wait, 
>>> flush_tlb);
>>>
>>>   unlock_out:
>>> +               prange->mapped_to_gpu = !r;
>>
>> I do not understand why set prange->mapped_to_gpu here? It handles 
>> one vma, not for all prange. If there are multiple vma and first vma 
>> handle is ok, and second vma handle fail at 
>> amdgpu_hmm_range_get_pages or svm_range_dma_map, you would get 
>> prange->mapped_to_gpu be true, but only part of pragne got mapped, 
>> right?
>
> If all vmas map to gpu successfully, prange->mapped_to_gpu set to 
> true, otherwise, prange->mapped_to_gpu set to false, and then svm 
> validate map to gpu return failed, the caller will retry if error code 
> is -EAGAIN.
>
if second vma handle got failed at amdgpu_hmm_range_get_pages 
prange->mapped_to_gpu would be true since the code would jump out of the 
loop, right?

Regards

Xiaogang

> Regards,
>
> Philip
>
>>
>>
>> Regards
>>
>> Xiaogang
>>
>>> svm_range_unlock(prange);
>>>
>>>                  addr = next;
>>>          }
>>>
>>> -       if (addr == end) {
>>> +       if (addr == end)
>>>                  prange->validated_once = true;
>>> -               prange->mapped_to_gpu = true;
>>> -       }
>>>
>>>   unreserve_out:
>>>          svm_range_unreserve_bos(ctx);
>>> -
>>> -       prange->is_error_flag = !!r;
>>>          if (!r)
>>>                  prange->validate_timestamp = ktime_get_boottime();
>>>
>>> @@ -2106,7 +2103,8 @@ svm_range_add(struct kfd_process *p, uint64_t 
>>> start, uint64_t size,
>>>                  next = interval_tree_iter_next(node, start, last);
>>>                  next_start = min(node->last, last) + 1;
>>>
>>> -               if (svm_range_is_same_attrs(p, prange, nattr, attrs)) {
>>> +               if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
>>> +                   prange->mapped_to_gpu) {
>>>                          /* nothing to do */
>>>                  } else if (node->start < start || node->last > last) {
>>>                          /* node intersects the update range and its 
>>> attributes
>>> @@ -3519,7 +3517,7 @@ svm_range_set_attr(struct kfd_process *p, 
>>> struct mm_struct *mm,
>>>          struct svm_range *next;
>>>          bool update_mapping = false;
>>>          bool flush_tlb;
>>> -       int r = 0;
>>> +       int r, ret = 0;
>>>
>>>          pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages 
>>> 0x%llx\n",
>>>                   p->pasid, &p->svms, start, start + size - 1, size);
>>> @@ -3607,7 +3605,7 @@ svm_range_set_attr(struct kfd_process *p, 
>>> struct mm_struct *mm,
>>>   out_unlock_range:
>>>                  mutex_unlock(&prange->migrate_mutex);
>>>                  if (r)
>>> -                       break;
>>> +                       ret = r;
>>>          }
>>>
>>>          dynamic_svm_range_dump(svms);
>>> @@ -3620,7 +3618,7 @@ svm_range_set_attr(struct kfd_process *p, 
>>> struct mm_struct *mm,
>>>          pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] done, 
>>> r=%d\n", p->pasid,
>>>                   &p->svms, start, start + size - 1, r);
>>>
>>> -       return r;
>>> +       return ret ? ret : r;
>>>   }
>>>
>>>   static int
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> index 9e668eeefb32..91715bf3233c 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>>> @@ -134,7 +134,6 @@ struct svm_range {
>>>          DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
>>>          bool                            validated_once;
>>>          bool                            mapped_to_gpu;
>>> -       bool                            is_error_flag;
>>>   };
>>>
>>>   static inline void svm_range_lock(struct svm_range *prange)
>>> -- 
>>> 2.35.1
>>>
