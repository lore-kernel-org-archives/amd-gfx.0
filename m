Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12CDC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jun 2022 14:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA6510F8F7;
	Wed, 15 Jun 2022 14:06:16 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2079.outbound.protection.outlook.com [40.107.212.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 272E210F8DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 14:06:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzSdPnIfuMobiLrVi6vjAduG+VkLsb36mEvq2qnB2nYqP3dMfaV6sr/2O3L6Z+RVpqrHAwIgs/Zm6956jA5iuHljOgnaA9tieTM1x16glEGbHJf21c5yD+TD06Tgmpj/CvCf7D0xeTzNj7BTN2VvOurAPu3Q9OzFGY2ouirC0+JS4S0Nt2NPfHaBxCiawezBGBujQn3rVY2KN0ZNRZ7GmuFrj8/I1I3ixcdwKgSlVL1uy66yrQl578nUXIOphh/M5WY9MoyAtuP3qgOvARJRV8B3En6/TIjoUI0+epd9BwIYrWBJc5Me1FSEnNGGY3774G95r9DYJa7dU+bUvrMrZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwIBS3zwPlfj9WU+LNBdhy/Mir3+MEG7gyUFR0YriUM=;
 b=dZEbynO6F1KHxwFZcK01Hrbi1gNHflo1qFkeL7BgmUvFPzJ9OJs2JYWHGP3l0PJZo3Gd8TBjw7/ICHIr1D+MPNZewdOUQf5F7jh5ebWt7cANhyQKREaxJXBqdksPtDylIrikmGY7X3/12eMdJnMovxrhylRBB0t3cryaeTlf7NSFEQ6Wjghra86DBPE0R+mwpdHVnGsuiFwYmRvgjiXfVrNqoj0iZp9oVQozr+01J1rz3NfwMKOpQnvWDHPkWjfdebvl5MPWQHmcuJ3KIoXcoiw+UqNszorROXIlBIKQ1BO6LQzbUdwWaX1cYxdhynvfi0OCG/V4uNPfmbm67emyPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwIBS3zwPlfj9WU+LNBdhy/Mir3+MEG7gyUFR0YriUM=;
 b=AW0nfDfavp0LyAsHqIKgzFhPjvYZHw6ZJP+iDBFJsY5s+dsvKPWS8ZAQeiKzZeNNHCECevhj9EF420/NqNBIKzBjcfG1/uA2jUCJZtvRlj1cs2gamXMq2/5EJMYpJkMmb9R08QiPWHUaSU4noQg4c0V18DbdClZceLgRohckRsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH0PR12MB5371.namprd12.prod.outlook.com (2603:10b6:610:d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Wed, 15 Jun
 2022 14:06:11 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731%6]) with mapi id 15.20.5353.014; Wed, 15 Jun 2022
 14:06:11 +0000
Message-ID: <26836141-d84a-363e-32c8-bd65dc8cdd22@amd.com>
Date: Wed, 15 Jun 2022 16:06:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/3] drm/amdkfd: Enable GFX11 usermode queue
 oversubscription
Content-Language: en-US
To: "Sider, Graham" <Graham.Sider@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220613152001.3045911-1-Graham.Sider@amd.com>
 <20220613152001.3045911-2-Graham.Sider@amd.com>
 <453d57bf-e1b1-9dcb-9022-21444d2c64a8@amd.com>
 <DM6PR12MB30675F77909B21063CD01B8A8AAD9@DM6PR12MB3067.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM6PR12MB30675F77909B21063CD01B8A8AAD9@DM6PR12MB3067.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::27) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1477dc9a-aec7-4b39-fed8-08da4ed8338c
X-MS-TrafficTypeDiagnostic: CH0PR12MB5371:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5371F3BD48D97CE0BE05D69E83AD9@CH0PR12MB5371.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YoUBTEpc3OAcgzBx69TA5ypTRTH8E+HOTXLKRaylLjYis7X5i9y7BhWJ3iADZroNMOa/CAp3ga1xlg6FjP6WGHwCM8q3Z50tVpBTMs7QKe4f3qlY2v/5qJGr0SHZ+7EPsRVBrrLDAIcCccxr6yZG8m0DWSptIdpWX1bDdSRdF4OeKHzJ8h7Ix5cyze46ccxLW1fbT/lYUVXr6RR5sgpNklgJzTNsPJIoZspBCGvi9nVg2y0i9CyxIHAIxaGmsYAMBWtvkEFxNqfWs242heV7klVoD5ZO4yRnjuekwTrwmHUefnxkKlSxvMzSHOiaYecOeIWF3NRH+/6KbecBn3WYWRrxBsYnyM9Q6lXWGAhy1m1qOSDfyCOi4+n5P01wvO5MHIHVzRiRqt8mvRv+Jv81zHsDEaijGcWNxhnPw4m/3X0ju7RejF1r1a6dFXQzlC0iPUEjiZs2FjGDHVl66ZTgDITNeXkuCTOA1/daPGfBbl8nH9ZdSXf3DG7xUHND3jD+mQ42Q64zJlCnYG/uyPCH3xxkha165fLbKZB/tWFwUJo/U+13Chslf9yzx5GPFpzgIulQlsjZaIQdyxlWbD1a+rGtmiSLOiqUrug2YO9Hz7ACB8lpTLe7ioilg+QserrqMkuXcf7vwieKpca5PfairccQXBftHW4s7u/d/N3gZixJ2vjjFNNUl3PRFnsRqvLhc7JbCZ0Q5T7RoGH3HvkyGf+RA6QCJaL6Zfe3OzMTmBNp3FSzeVjUpySfw0YbULR9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(83380400001)(2906002)(53546011)(36756003)(6512007)(186003)(30864003)(6506007)(508600001)(2616005)(31686004)(38100700002)(86362001)(6666004)(31696002)(5660300002)(8676002)(66476007)(316002)(66556008)(66946007)(4326008)(110136005)(8936002)(6486002)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWRXdnpvZGFmVng0d3NtczJNSVlyQmpEaVY4NlJoK1B5M091OWRPY2NqQ0k2?=
 =?utf-8?B?YmM0a1IyNmZTOUZ2UnczMkV4NGhpbWR6eS9FNmJ1MXNjdWlENzBkU25Jenpt?=
 =?utf-8?B?NTJaZHJraVViMHd1TlEzVS9JN1Y4MzA1b3ZKL0VnTDU2elN5WkNZVithKzN6?=
 =?utf-8?B?cFl6bVlERStpMXNzaHlrUzA1aVhLczNNMGxjT1Bwd0ZHdmR0dWRYNHNtNHJV?=
 =?utf-8?B?WVBuUDRKNEdxVkE4SWd4NjFQSEpUL25HYWVIMGt4R2k0dW5GdjhtSEIzNldY?=
 =?utf-8?B?UWhrNEFEZXcyOXV2V0hzRmxabUpOajI5aGdoTFNKSzhlUnQ5Z0xpRlhvKzhL?=
 =?utf-8?B?QkZVSVZnaUNiVmRCQzNCa1JSNVZjaXI3R2JUdys2ZHVtb2dEMHF4ejAwOUxs?=
 =?utf-8?B?VjBXUytGR2NncmNLTmNMSU5vUWhmYWxJcElwejVmSmI2aW9FYm1Yckx4SG5R?=
 =?utf-8?B?cThVdHNubk51L3VhWVNndXVLWnZGbDl4eEtnWUYxOUQwWWhkREZSVWNiSG1M?=
 =?utf-8?B?YzlheVlHZSswQkhFeGo5MitxK05TTjREOXNiZHdBbEZqakhVSkpvNmFXOUZM?=
 =?utf-8?B?N3VzcWF4Z0ZVZGloMFNnSWZ5ODlTQ2ZmWFN3eEJtMmZkODhsaXNCN1NESFNq?=
 =?utf-8?B?UTJEQzFFQm1yMDcvbnhJUDUzUEUwWThsYlMzUFI2VDdRSXl4S1IveTFUZ0sw?=
 =?utf-8?B?NGZKaUk2b1hJTjdGbE41UXIxQTdKSlJWQ0JocXo4VGN6b2dhb3R3U1U4b1Vu?=
 =?utf-8?B?Q1NOZWVNM1N2QzkyZE1TMEVMZnc3aytGNnNnMWJaMFIrMk9VMGpGN1JsVk9X?=
 =?utf-8?B?bTV3cHJmRk1tL2ZxNnhCVDlrOUJrZTFMUWpEcnBLckhiOGRjVHBueUU2NEJ1?=
 =?utf-8?B?bm9hTmZhb0d1V3U4VjlKckNrZ3hoSTNDVFVpTG1odndZYjhFRFM5dkoxMnNa?=
 =?utf-8?B?ZG81Qk9LT1k3eHNJMzJudG0vQ255YXZNYzZ6aGJUMWRONms4OUhrQ241VGM3?=
 =?utf-8?B?OWtIK0hBeTRtaEVWTDRpc0ljRmhYbkkxaHFGM3FwckNGVDNPL2tHMnhXOVdl?=
 =?utf-8?B?R2hyc2E0dlc3azkxLzMvelVjcVNRdk5Ea2hxUm9rS3FsWVByZ09qdnBGRHhs?=
 =?utf-8?B?STlxRXlsZG9UOHljOXd3V3dxQ2p4ZnF1dFc0T21aZkpRRitUYmpwclpWdjJX?=
 =?utf-8?B?bEM5T05mbTJheHV1Zm5URlJhcXRVZ0FIQzZIZFdLTjFvSzM4Q0JCdTZPd2hM?=
 =?utf-8?B?dDc2aUdPQ3ZsWTBxdGdycUJyRlU1V2Qya2RoNml5bE9DMlU2UmpaUGx2ZjEz?=
 =?utf-8?B?N1RlTGFjaHA1ZUkxb1ZCM1lLekFnZTBjYXhLOUFsQ0Y4VTRHdGhFTVlhb3lC?=
 =?utf-8?B?dnJsWkNmUW1RbjViRXI0MzFHbVVoRXQ1SDVoMnpIRHFwNXI2NXF6bUhqT1Fo?=
 =?utf-8?B?QTJvb25JMmZmV2tWS0s3UCtRUXg5UTU5R051emlHcHhRTFlHc29sYlhLbmlK?=
 =?utf-8?B?SmRwSURiOFlCanZ4ZnljTGxuZGlyZTV5bUdHQnl2UWp4cmhMV2lFeWVocWxs?=
 =?utf-8?B?eXE4UjJyMjJhUE9Bd2FFblVaMUlaZ0kxZVZrRW9ZYWZYOUJ1dEZyWEhXQ2M4?=
 =?utf-8?B?Qk1ITW5jamRuTVNpS0hoZm5KQTlNZFRQRVozSWJYM0JMaHN2Q1IxWDVzVklC?=
 =?utf-8?B?VlYzZjhqK01HY3RBdWRnNjRQWXJRNXU0eWsyR3dRY1ZNS0ErYSsrTDlBbkRm?=
 =?utf-8?B?bXg3TUxaZUgyMjIwKzh2ay9kZkd0bUVtWDliNkVTY1pvc09FU3pGM3ZDUDI1?=
 =?utf-8?B?TzFiYWhvcXp5NVhIOFNSVTRmTllac254c2oxeU5sOUNOY2cyQ1ZYS3VDdkZO?=
 =?utf-8?B?YVdDNlhIMXV4aUhrMmt4bkh1WE1Odno3aTVPdWVDbzFNV1AzU3F0Qmo1QXd3?=
 =?utf-8?B?bU1sMVhUMlY2TCtna0x0d3dPQlNRVWxua3B1UXltcjZwQkw3SHcwb3c4Yitz?=
 =?utf-8?B?S3F5MkNnZWU2WVBpUk1FVTZSN0x0YzN1NFQ0Uy9IemJuYVliZ0Z1aEhBMHh6?=
 =?utf-8?B?WTcxcThpclNZaFNMMjBHemxRMGVwWGVVb0x2a24vMHVCQS9Sa2tpVXpydm81?=
 =?utf-8?B?b3RtSzRwZlRqZDAvbnl0SU1SOGQ5NEhKMjlBSldtZU5CL3FpcjFzN09JVjVx?=
 =?utf-8?B?b3lFekhVVVE4OFRWOHpyZC92QmdReEZuL1RKejlIaDB5KzdvRk56UGFxZTdW?=
 =?utf-8?B?QlI1MXhqSnpLZlhYdzVjWXdlVjRSRnNWQ25VK2p2OWRLdGErMG5IT3pab2NW?=
 =?utf-8?B?bTJneWlaMzBGcDk0QlltNGpMQmVTNDFRRkVNZjdabi9kN2V0V2VrcVpNOHRK?=
 =?utf-8?Q?hA3TStjd/DdQRVenWkc3nJVaFjNPWKPWRxQh3Dxygbj2T?=
X-MS-Exchange-AntiSpam-MessageData-1: PKIXah4kAHhTfw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1477dc9a-aec7-4b39-fed8-08da4ed8338c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 14:06:11.3158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYaFmlH897QwKRl0XRUX/NqoJb+BpCAfuB7OFceMeEWV4xisZnJaj9SQjIEe36Im
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5371
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
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.06.22 um 15:17 schrieb Sider, Graham:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, June 15, 2022 3:29 AM
>> To: Sider, Graham <Graham.Sider@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Kuehling, Felix
>> <Felix.Kuehling@amd.com>; Yang, Philip <Philip.Yang@amd.com>
>> Subject: Re: [PATCH v3 2/3] drm/amdkfd: Enable GFX11 usermode queue
>> oversubscription
>>
>>
>>
>> Am 13.06.22 um 17:20 schrieb Graham Sider:
>>> Starting with GFX11, MES requires wptr BOs to be GTT allocated/mapped
>>> to GART for usermode queues in order to support oversubscription. In
>>> the case that work is submitted to an unmapped queue, MES must have a
>>> GART wptr address to determine whether the queue should be mapped.
>>>
>>> This change is accompanied with changes in MES and is applicable for
>>> MES_VERSION >= 3.
>>>
>>> v2:
>>> - Update MES_VERSION check from 2 to 3.
>>> v3:
>>> - Use amdgpu_vm_bo_lookup_mapping for wptr_bo mapping lookup
>>> - Move wptr_bo refcount increment to
>> amdgpu_amdkfd_map_gtt_bo_to_gart
>>> - Remove list_del_init from amdgpu_amdkfd_map_gtt_bo_to_gart
>>> - Cleanup/fix create_queue wptr_bo error handling
>>>
>>> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
>>>    .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 49
>> +++++++++++++++++++
>>>    drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 37 +++++++++++++-
>>>    .../drm/amd/amdkfd/kfd_device_queue_manager.c |  9 +++-
>>>    .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  2 +
>>>    drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
>>>    .../amd/amdkfd/kfd_process_queue_manager.c    | 17 +++++--
>>>    7 files changed, 110 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index 429b16ba10bf..dba26d1e3be9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -301,6 +301,7 @@ int
>> amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device
>> *adev,
>>>    		struct kgd_mem *mem, void **kptr, uint64_t *size);
>>>    void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct
>> amdgpu_device *adev,
>>>    		struct kgd_mem *mem);
>>> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev,
>>> +struct amdgpu_bo *bo);
>>>
>>>    int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>>>    					    struct dma_fence **ef);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index efab923056f4..888d08128a94 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -2030,6 +2030,55 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
>>>    	return ret;
>>>    }
>>>
>>> +/**
>>> + * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and
>> increment
>>> +reference count
>>> + * @adev: Device to which allocated BO belongs
>>> + * @bo: Buffer object to be mapped
>>> + *
>>> + * Before return, bo reference count is incremented. To release the
>>> +reference and unpin/
>>> + * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
>>> + */
>>> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev,
>>> +struct amdgpu_bo *bo) {
>>> +	int ret;
>>> +
>>> +	ret = amdgpu_bo_reserve(bo, true);
>>> +	if (ret) {
>>> +		pr_err("Failed to reserve bo. ret %d\n", ret);
>>> +		goto err_reserve_bo_failed;
>>> +	}
>>> +
>>> +	ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
>>> +	if (ret) {
>>> +		pr_err("Failed to pin bo. ret %d\n", ret);
>>> +		goto err_pin_bo_failed;
>>> +	}
>>
>> Oh! Is that something we do for every MQD? When yes that here is pretty
>> much a NAK.
>>
>> We can't do this or create a trivial deny of service attack against the kernel
>> driver.
>>
>> Regards,
>> Christian.
>>
> Hi Christian, could you elaborate on this? Right now this is only being used to pin the queue wptr BO.

Well is this wptr BO per process, per queue or global?

amdgpu_bo_pin() is only allowed if we pin global resources, otherwise I 
have to reject that.

Regards,
Christian.

>
> Best,
> Graham
>
>>> +
>>> +	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
>>> +	if (ret) {
>>> +		pr_err("Failed to bind bo to GART. ret %d\n", ret);
>>> +		goto err_map_bo_gart_failed;
>>> +	}
>>> +
>>> +	amdgpu_amdkfd_remove_eviction_fence(
>>> +		bo, bo->kfd_bo->process_info->eviction_fence);
>>> +	list_del_init(&bo->kfd_bo->validate_list.head);
>>> +
>>> +	amdgpu_bo_unreserve(bo);
>>> +
>>> +	bo = amdgpu_bo_ref(bo);
>>> +
>>> +	return 0;
>>> +
>>> +err_map_bo_gart_failed:
>>> +	amdgpu_bo_unpin(bo);
>>> +err_pin_bo_failed:
>>> +	amdgpu_bo_unreserve(bo);
>>> +err_reserve_bo_failed:
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>    int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct
>> amdgpu_device *adev,
>>>    		struct kgd_mem *mem, void **kptr, uint64_t *size)
>>>    {
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index e9766e165c38..1789ed8b79f5 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -289,6 +289,7 @@ static int kfd_ioctl_create_queue(struct file *filep,
>> struct kfd_process *p,
>>>    	struct kfd_process_device *pdd;
>>>    	struct queue_properties q_properties;
>>>    	uint32_t doorbell_offset_in_process = 0;
>>> +	struct amdgpu_bo *wptr_bo = NULL;
>>>
>>>    	memset(&q_properties, 0, sizeof(struct queue_properties));
>>>
>>> @@ -316,12 +317,41 @@ static int kfd_ioctl_create_queue(struct file
>> *filep, struct kfd_process *p,
>>>    		goto err_bind_process;
>>>    	}
>>>
>>> +	/* Starting with GFX11, wptr BOs must be mapped to GART for MES
>> to determine work
>>> +	 * on unmapped queues for usermode queue oversubscription (no
>> aggregated doorbell)
>>> +	 */
>>> +	if (dev->shared_resources.enable_mes && (dev->adev-
>>> mes.sched_version & 0xff) >= 3) {
>>> +		struct amdgpu_bo_va_mapping *wptr_mapping;
>>> +		struct amdgpu_vm *wptr_vm;
>>> +
>>> +		wptr_vm = drm_priv_to_vm(pdd->drm_priv);
>>> +		err = amdgpu_bo_reserve(wptr_vm->root.bo, false);
>>> +		if (err)
>>> +			goto err_wptr_map_gart;
>>> +
>>> +		wptr_mapping = amdgpu_vm_bo_lookup_mapping(
>>> +				wptr_vm, args->write_pointer_address >>
>> PAGE_SHIFT);
>>> +		amdgpu_bo_unreserve(wptr_vm->root.bo);
>>> +		if (!wptr_mapping) {
>>> +			pr_err("Failed to lookup wptr bo\n");
>>> +			err = -EINVAL;
>>> +			goto err_wptr_map_gart;
>>> +		}
>>> +
>>> +		wptr_bo = wptr_mapping->bo_va->base.bo;
>>> +		err = amdgpu_amdkfd_map_gtt_bo_to_gart(dev->adev,
>> wptr_bo);
>>> +		if (err) {
>>> +			pr_err("Failed to map wptr bo to GART\n");
>>> +			goto err_wptr_map_gart;
>>> +		}
>>> +	}
>>> +
>>>    	pr_debug("Creating queue for PASID 0x%x on gpu 0x%x\n",
>>>    			p->pasid,
>>>    			dev->id);
>>>
>>> -	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties,
>> &queue_id, NULL, NULL, NULL,
>>> -			&doorbell_offset_in_process);
>>> +	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties,
>> &queue_id, wptr_bo,
>>> +			NULL, NULL, NULL, &doorbell_offset_in_process);
>>>    	if (err != 0)
>>>    		goto err_create_queue;
>>>
>>> @@ -354,6 +384,9 @@ static int kfd_ioctl_create_queue(struct file *filep,
>> struct kfd_process *p,
>>>    	return 0;
>>>
>>>    err_create_queue:
>>> +	if (wptr_bo)
>>> +		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
>>> +err_wptr_map_gart:
>>>    err_bind_process:
>>>    err_pdd:
>>>    	mutex_unlock(&p->mutex);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> index b39d89c52887..d8de2fbdfc7d 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> @@ -208,6 +208,7 @@ static int add_queue_mes(struct
>> device_queue_manager *dqm, struct queue *q,
>>>    	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>>>    	struct mes_add_queue_input queue_input;
>>>    	int r, queue_type;
>>> +	uint64_t wptr_addr_off;
>>>
>>>    	if (dqm->is_hws_hang)
>>>    		return -EIO;
>>> @@ -227,7 +228,13 @@ static int add_queue_mes(struct
>> device_queue_manager *dqm, struct queue *q,
>> 	AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>>    	queue_input.doorbell_offset = q->properties.doorbell_off;
>>>    	queue_input.mqd_addr = q->gart_mqd_addr;
>>> -	queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
>>> +
>>> +	if (q->wptr_bo) {
>>> +		wptr_addr_off = (uint64_t)q->properties.write_ptr -
>> (uint64_t)q->wptr_bo->kfd_bo->va;
>>> +		queue_input.wptr_addr = ((uint64_t)q->wptr_bo-
>>> tbo.resource->start << PAGE_SHIFT) + wptr_addr_off;
>>> +	} else
>>> +		queue_input.wptr_addr = (uint64_t)q-
>>> properties.write_ptr;
>>> +
>>>    	queue_input.paging = false;
>>>    	queue_input.tba_addr = qpd->tba_addr;
>>>    	queue_input.tma_addr = qpd->tma_addr; diff --git
>>> a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
>>> index f1654b4da856..35e74bdd81da 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
>>> @@ -377,6 +377,8 @@ static void update_mqd_sdma(struct mqd_manager
>> *mm, void *mqd,
>>>    	m->sdmax_rlcx_rb_base_hi = upper_32_bits(q->queue_address >>
>> 8);
>>>    	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits((uint64_t)q-
>>> read_ptr);
>>>    	m->sdmax_rlcx_rb_rptr_addr_hi =
>>> upper_32_bits((uint64_t)q->read_ptr);
>>> +	m->sdmax_rlcx_rb_wptr_poll_addr_lo = lower_32_bits((uint64_t)q-
>>> write_ptr);
>>> +	m->sdmax_rlcx_rb_wptr_poll_addr_hi =
>>> +upper_32_bits((uint64_t)q->write_ptr);
>>>    	m->sdmax_rlcx_doorbell_offset =
>>>    		q->doorbell_off <<
>> SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index a5d3963537d7..dcddee0d6f06 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -639,6 +639,8 @@ struct queue {
>>>    	void *gang_ctx_bo;
>>>    	uint64_t gang_ctx_gpu_addr;
>>>    	void *gang_ctx_cpu_ptr;
>>> +
>>> +	struct amdgpu_bo *wptr_bo;
>>>    };
>>>
>>>    enum KFD_MQD_TYPE {
>>> @@ -1404,6 +1406,7 @@ int pqm_create_queue(struct
>> process_queue_manager *pqm,
>>>    			    struct file *f,
>>>    			    struct queue_properties *properties,
>>>    			    unsigned int *qid,
>>> +			    struct amdgpu_bo *wptr_bo,
>>>    			    const struct kfd_criu_queue_priv_data *q_data,
>>>    			    const void *restore_mqd,
>>>    			    const void *restore_ctl_stack, diff --git
>>> a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> index f99e09dc43ea..3a17c1ebc527 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> @@ -190,7 +190,8 @@ void pqm_uninit(struct process_queue_manager
>> *pqm)
>>>    static int init_user_queue(struct process_queue_manager *pqm,
>>>    				struct kfd_dev *dev, struct queue **q,
>>>    				struct queue_properties *q_properties,
>>> -				struct file *f, unsigned int qid)
>>> +				struct file *f, struct amdgpu_bo *wptr_bo,
>>> +				unsigned int qid)
>>>    {
>>>    	int retval;
>>>
>>> @@ -221,6 +222,7 @@ static int init_user_queue(struct
>> process_queue_manager *pqm,
>>>    			goto cleanup;
>>>    		}
>>>    		memset((*q)->gang_ctx_cpu_ptr, 0,
>> AMDGPU_MES_GANG_CTX_SIZE);
>>> +		(*q)->wptr_bo = wptr_bo;
>>>    	}
>>>
>>>    	pr_debug("PQM After init queue");
>>> @@ -237,6 +239,7 @@ int pqm_create_queue(struct
>> process_queue_manager *pqm,
>>>    			    struct file *f,
>>>    			    struct queue_properties *properties,
>>>    			    unsigned int *qid,
>>> +			    struct amdgpu_bo *wptr_bo,
>>>    			    const struct kfd_criu_queue_priv_data *q_data,
>>>    			    const void *restore_mqd,
>>>    			    const void *restore_ctl_stack, @@ -299,7 +302,7
>> @@ int
>>> pqm_create_queue(struct process_queue_manager *pqm,
>>>    		 * allocate_sdma_queue() in create_queue() has the
>>>    		 * corresponding check logic.
>>>    		 */
>>> -		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
>>> +		retval = init_user_queue(pqm, dev, &q, properties, f,
>> wptr_bo,
>>> +*qid);
>>>    		if (retval != 0)
>>>    			goto err_create_queue;
>>>    		pqn->q = q;
>>> @@ -320,7 +323,7 @@ int pqm_create_queue(struct
>> process_queue_manager *pqm,
>>>    			goto err_create_queue;
>>>    		}
>>>
>>> -		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
>>> +		retval = init_user_queue(pqm, dev, &q, properties, f,
>> wptr_bo,
>>> +*qid);
>>>    		if (retval != 0)
>>>    			goto err_create_queue;
>>>    		pqn->q = q;
>>> @@ -457,9 +460,13 @@ int pqm_destroy_queue(struct
>> process_queue_manager *pqm, unsigned int qid)
>>>    			pdd->qpd.num_gws = 0;
>>>    		}
>>>
>>> -		if (dev->shared_resources.enable_mes)
>>> +		if (dev->shared_resources.enable_mes) {
>>>    			amdgpu_amdkfd_free_gtt_mem(dev->adev,
>>>    						   pqn->q->gang_ctx_bo);
>>> +			if (pqn->q->wptr_bo)
>>> +				amdgpu_amdkfd_free_gtt_mem(dev-
>>> adev, pqn->q->wptr_bo);
>>> +
>>> +		}
>>>    		uninit_queue(pqn->q);
>>>    	}
>>>
>>> @@ -900,7 +907,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>>>
>>>    	print_queue_properties(&qp);
>>>
>>> -	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp,
>> &queue_id, q_data, mqd, ctl_stack,
>>> +	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp,
>> &queue_id,
>>> +NULL, q_data, mqd, ctl_stack,
>>>    				NULL);
>>>    	if (ret) {
>>>    		pr_err("Failed to create new queue err:%d\n", ret);

