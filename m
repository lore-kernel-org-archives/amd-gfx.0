Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266D7C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Nov 2023 22:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B1BD10E4DD;
	Tue, 14 Nov 2023 22:26:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCC1F10E4DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Nov 2023 22:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAk/u6gI/fxHLaKizCMWv8xCFIH824banjpjQRvOI2OQU7sL8p/oMSiSWgX2hgtw4IqsOJJRMwTbyAgaTS1gzruTxXms2UJEKWHa7a49Lp6c6ruVOsvEZbLkWSQ9H5Ykwdh8i/DNlX+PLU1JhMqW6UORCx0XCKrvy6ra4Y3bFi9rNHboEkQZpvH6odkM4gAfUKmyC/NKYWrDIFKcFRhioZnxlhBmoSqPF9d91ZLm6vOtacefG+f2TuzVC3Sip9jfzGov9byTuM3504EAr/vw+neJr0bVKCIjnQLvPkBXmtb1kC3wHnb/1rRstYxJLMBMMDF+C1S3GZSB3p+FgwpFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbOZRPg8vQIFnflLNbGzq/ieFKDjJrp7WO1gBeW7tHg=;
 b=O4/Km5zCZrCBJODEoVpJBP4QReXfoBQf1Cu1E+J2li3IAkVZvQ4XYhJvrv5vIwSSZndeKBEnr+EQbF3Bi9AtkRzZSiUHKNNm1deULzjoEW10Gn4AIEW4yxiMxa1kAr+ClUSzxvGN+D675xtZew6aGt8U/c84crWInQshfegminsZfpYKFKKJg0aPfMG+PQiK01lk4PKZsNQzb43kvN11IrN3A+QOJRSDlPOJ5ohIMoAKJQdxGq87VWiY4xIs4xajubOHbpGTGUcGldtiS29TMG9gEOKuZiLeiWiXy51qQhFd0GWeAEGyaTFWSTNDL8awuqxNSK7i/HVcyKXPMXrb5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbOZRPg8vQIFnflLNbGzq/ieFKDjJrp7WO1gBeW7tHg=;
 b=twAWnhCftMxzQYpZ3YWyKUrzB/fz86+3HId+HQEO1o1/pjuwA0esg7jYnRAo8pO4miQSmtKnGjGplt0kFIgByu8j0CJy2KtDZEqPNUjxNt+HGAyhXKs3LBrqWqHIIKaXMr0BImX472hDh/239Wz6+9J1vO8bI/MhWVjtgbRjCME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 22:26:04 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 22:26:04 +0000
Message-ID: <aaf3d57c-eb10-4bbb-8e80-4a0da41387e6@amd.com>
Date: Tue, 14 Nov 2023 17:26:02 -0500
User-Agent: Mozilla Thunderbird
From: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH 2/6] drm/amdgpu: New VM state for evicted user BOs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
 <20231107165814.3628510-2-Felix.Kuehling@amd.com>
 <8b63ff39-b1f2-4dc5-970c-29d96c63b18b@amd.com>
 <c3a50dd5-d621-46ac-8cd3-d1fa5bed30bd@gmail.com>
 <9cd52b41-f9ce-49a0-9985-eb4eeff2a0ec@amd.com>
 <1cdf935f-4b59-4c41-9aa8-e1fc7d37d79d@amd.com>
Content-Language: en-US
Organization: AMD Inc.
In-Reply-To: <1cdf935f-4b59-4c41-9aa8-e1fc7d37d79d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::43) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4053:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f2da2a-e7ab-419d-9c91-08dbe560b055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/DBPlnOGKjv0bQnBUTVdlcQxQc2bXpn4amlFSdOpS+OXofGwWUqBNLbps43ojOoMUNur2vEs/tzZDauYZQPjqpVdlbk3kpJirWlr9KNw0FKKOByzrwQYEs79noruLe5ebxPPX4K6+LoO5SmSxNIdxy1UL+7fkOxEimACvRHzOxs3DvZuNN8xQLfS+QrGdE4yg2FhvBkdyHdy2NJcbfIuikTeTGsO/bEaVEuGJvF0D8vFGE72FOx3rgRvyBzzzBpbEGAstb07xFlrOfuZuPDzHrbUzjw/eyrQmO1USJrJ77/VvaO0TrqdXyJ6OEv8V4qrth4tmdSUHRw5HT+Zg3WMSw3e9ZmAMDk7fSemssLa97wMkf5E1KNad2mT8rBZaWNrEOLQSkRRA11ew14hw6HKyg5UfXZRAazw+9wIfU56AbxXMrheX83N7tLRPNq97hRbK+KV2LPiBrcfq67KRXpPHw9lVr+QcgSYv8nN5B12TRrhygU+j3Rcq53PeYfVyIxO7INNJJOhw/5fHLhiBG3fbV1R/2FtnLy9ViGTpWezDngUFPfH/Vbt0ZaPOZOZxT8S3/9d+zpwcWbdeQo58l8jE3+PnyEgWoGZL3I5Uj4hUuBb3aaWVFib8/vkx3EUQX60R3hvej+wRgmNmLd8lUXqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(38100700002)(6506007)(36916002)(53546011)(83380400001)(31686004)(8936002)(66574015)(2616005)(6512007)(2906002)(41300700001)(5660300002)(4326008)(86362001)(8676002)(31696002)(44832011)(36756003)(66476007)(66946007)(66556008)(110136005)(316002)(26005)(6486002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEk3YmZXblRXckQyK1E0d3hCNDhENE5NSkVqTjhnandUYjMwNTQ5blBOWUVw?=
 =?utf-8?B?RDJUOUxYL2d5RXJUcUFnVWljY0pEODBuakpJbDVOZnE4Z2R6eUgwL2NQZGJu?=
 =?utf-8?B?dWdFSWZmb2JHRUR6TDViSG9SNVdIbDdlUjlONGM1RmIvRStHVTNNSjA1Y3l2?=
 =?utf-8?B?VEVJNExmTXEybmxmdmxNNk44dnA1ZnRFWWdubDRxUGdUUjVVeHIwV3lDOXlF?=
 =?utf-8?B?SmdoUFcwV25OWnIwOXh0eGk2M2gvbS9OdXFoRWt3NVQvTlVFZW9TRXZMS0xF?=
 =?utf-8?B?RkFNTCt6MDlURGNMYlpJWFNvUlZWeDRhNnFYUHJ0NDdROTJ4NVptZ0tFUUNi?=
 =?utf-8?B?aFJaQUo3SGNmUE9ReDY4WGNhYkdSYXAyWVNERnBMNnl2NmQzYXJxelZWWStw?=
 =?utf-8?B?b0I5RE5IZmFFb215MzZQVit2NDRHcnV5YkRYdUdVREJmOFJtb2o2bllUczBM?=
 =?utf-8?B?K29SUlYvTDJqNXFCdjBkQ3NPZnd3YWxGeE9QbHZtOVlFRm1MdDNFQ1dWbWg0?=
 =?utf-8?B?T3J0cVpiZnRLOHA0RWtvbVVLWU5ubnNaVzJ5aFNZR3ByUVJHL0k0cTFaYUNC?=
 =?utf-8?B?SWFlT1pMa0JMMk5VdjVXbHNSMzRuS1RZRHFuSWQ0L2NEblM3T25IYjAzaXpI?=
 =?utf-8?B?UWkrNXlRSGZXRGNHQ3Mzdkx5WGIrS29sbjJ4Y1ZmRDJ1MTFHcmpkSTFvWURm?=
 =?utf-8?B?MDdBWFlyMGVzZDdsZzRmN2xpTmdNYjYyWnBEaFZFd210S1FtSTBYOWZhRkhF?=
 =?utf-8?B?VkpnaVZFbTh5RC9QcVErTkc2a2ExN1pUV25iNHpNM1dJWlVncW0vVE1FTHVZ?=
 =?utf-8?B?YjhwVmgzYjMrQ2prMEFVMnBHZWxUR3djNWpnbWxHRGRCWVcySGFxSHRocUhC?=
 =?utf-8?B?dDlVMmtkeld5ZENoZTJQVjZENjFQcEpIbjE2QlB0YjF6N055akQzNnVMeXdO?=
 =?utf-8?B?Z3ppdEJleG8rdUtKZmVkZXpxVThvZUVob0l0cFFwWmh2T0FXYmJ0S1AyMGxC?=
 =?utf-8?B?cGxZTjBpdlBqaHA1K3BtMUszVDFJdkswcHVhcW1vSDIxMit6T3lYbWVyNXpJ?=
 =?utf-8?B?SEIwQkdzTjVZanJWMEdhemdsbDQ0UkZlL2lwNmVDbWFVeTZBMnVKRUJ6U01l?=
 =?utf-8?B?d2pPQjhzbjcyNjMyYS9uOVdHOFl0MDZOQ3krbWxGb0toc1piRk1qQnlsTnVk?=
 =?utf-8?B?UE1NWE9FT2EvYVUrOEVTTHFiOUpyM0l6K24zbGwyQ0ExVWV2dGdBZDErZmVz?=
 =?utf-8?B?Q0FhUCsvMEFEaktUVXVqM0N5MzUrV1o3NmFEQTk2bWVSOFN3WDlmMS9xdEFP?=
 =?utf-8?B?TXVmMkFIbXJXcW1KUytBU0E2OU5PZlBkRXkza1g2dVJTNHUzVG8yMGF6Yi9Y?=
 =?utf-8?B?akdyYW5wc043SnU3bjJIQ2ZhSmZ0T2t0STV1cEJhQkU5RnVHVHlhN0V3QThS?=
 =?utf-8?B?UTNEYWJNUUtpMlo1YXVNWlRQV1ZOMW8zY2tZSFF4NmR2UHk0eWE5WlBIYjJL?=
 =?utf-8?B?LzRlWThoUDNGUGdRSWdvSXFuN3c1WHJYOGhRcW12elc0eDIwcVplRVRkT24x?=
 =?utf-8?B?N1JTNVN6R0RoSjBXNFZFOUc4QUlsQmo3SVJnSGR2Nnd2V0l2ZlR3RmVIWldD?=
 =?utf-8?B?dHRkMDNWOEVYM080MEk1RHdWV0YzWmR3R0JmeWowS2lYRzdkS3RpK0RoVG53?=
 =?utf-8?B?NjlJVFM5aW8reStqUW5RS3dZMFJtdGN0cW83NGdldGpvUU91ZlNpS2kyV1Mv?=
 =?utf-8?B?TEZkTHVXUzZ3aHlscEhUbENpOVFXUkMvNy9hMDZwZzk4Y3JzRkxUVzl5enFS?=
 =?utf-8?B?TnlHUjRLSzdRYWpCRHowbDF4SnI2NkRUUU81Qmd3b2Uwd252eDNDOFhtZGJY?=
 =?utf-8?B?dnVHb2VtQUpMTGNtZHdiTnZrQ3dVbzZ3Q2d1aEs1ZXlTb2ptMlpaZitlVDN6?=
 =?utf-8?B?MEJKclRWVmNLMG5tNHNiY2FpMWtLRm1PcFdhdVNhUUJmVmxKdWw5OUVPQ1N0?=
 =?utf-8?B?Tlg1YXozcjZTVzkwZ2ZwRW9LZUVyeVp4d1k5SVl1K1pKL0xHQXAvUEQzTTdy?=
 =?utf-8?B?bGllVlBGcU5lRnZpYXovcjd4TC9HL28vc0haeStZa1NIYmtpeE1Ua2pqeCtZ?=
 =?utf-8?Q?rndj4xwldV8yYkKAgnwtSMWMb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f2da2a-e7ab-419d-9c91-08dbe560b055
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 22:26:04.2390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BepVXI35flwA5Wo9PfM6A6PutWz+FmJbYq/la7/4AzdHs/v/eSRDjiLnHEl3MQvafpn3uG/2VlMG64b6pcw39g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
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
Cc: xiaogang.chen@amd.com, ramesh.errabolu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-09 03:12, Christian König wrote:
> Am 08.11.23 um 22:23 schrieb Felix Kuehling:
>>
>> On 2023-11-08 07:28, Christian König wrote:
>>> Not necessary objections to this patch here, but rather how this new 
>>> state is used later on.
>>>
>>> The fundamental problem is that re-validating things in 
>>> amdgpu_vm_handle_moved() won't work in all cases.
>>>
>>> The general approach for both classic CS IOCTL as well as user 
>>> queues is the following:
>>>
>>> 1. Grab all the necessary locks
>>>     The VM lock + either everything inside the VM (user queues) or 
>>> just the BOs in the submission (CS IOCTL).
>>>
>>> 2. Validate everything locked
>>>     It can be that additional BO locks are grabbed for eviction and 
>>> even locked BOs are shuffled around during that.
>>>
>>> 3. Update the PDEs and PTEs
>>>     This can be done only after validating everything because things 
>>> can still shuffle around during validation.
>>>
>>> 4. Do your CS or make the userqueu / process runable etc...
>>>
>>> 5. Attach fences to the locked BOs.
>>>
>>> 6. Unlock everything again.
>>>
>>> I think that is part of the problem why handling all updates in 
>>> amdgpu_vm_handle_moved() for the CS doesn't work and sooner or later 
>>> you might run into the same issue during process restore as well.
>>>
>>> If I'm not completely mistaken this should be solvable by moving all 
>>> validation to amdgpu_vm_validate_pt_bos() instead (but let us rename 
>>> that function).
>>
>> I'm trying to understand what the problem is. As far as I can tell, 
>> amdgpu_vm_handle_moved just runs a bit later in the CS and 
>> process-restore code than amdgpu_vm_validate_pt_bos. But it runs with 
>> all the same reservations locked. My current implementation in 
>> amdgpu_vm_handle_moved has some failure cases when reservations 
>> cannot be acquired. I think your drm_exec patch series would make it 
>> possible to handle this more robustly. That said, in case of KFD 
>> process restore, we can retry in case of failures already.
>>
>> Anyway, moving my re-validation code to a renamed version of 
>> amdgpu_vm_validate_pt_bos shouldn't be a big problem. I just don't 
>> understand what problem that solves. Maybe it just makes the code 
>> cleaner to handle both evicted states in one place? Or maybe you're 
>> pointing to a way to merge the two states into one?
>
> Well yeah merging both state into one might be nice to have, but that 
> isn't the fundamental problem.
>
> What basically happens during validation of a BO is that this BO is 
> move to a desired place (as described by the placement parameter). 
> During this it can happen that we shuffle out other BOs.
>
> Now the issue is that when you validate in amdgpu_vm_handle_moved() it 
> can be that by validating BO we shuffle out other BOs which then end 
> up of the evicted list again.
>
> This most likely won't happen with KFD, but for GFX CS it's certainly 
> possible. So the idea is that we first validate everything and then 
> update all the page tables and not inter mix the two operations.

I have something working now. But I think the fundamental problem is 
what you say, that BOs get can evicted again before we update the page 
tables. It won't be a problem for KFD, because I only care about DMABuf 
imports, and they don't get evicted if I have the original allocations 
reserved. I just have to make sure I validate/move the original 
allocations before I validate their DMABuf imports. This could still be 
a problem for future graphics interop.

The problem is, that I don't currently have a way to keep the validated 
BOs reserved to prevent their eviction. That is on amd-staging-drm-next, 
where I don't have your drm_exec patch series yet. Maybe this will get 
easier once the branch gets rebased on Linux 6.5 or newer.

Regards,
   Felix


>
> Regards,
> Christian.
>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 07.11.23 um 23:11 schrieb Felix Kuehling:
>>>> Hi Christian,
>>>>
>>>> I know you have objected to this patch before. I still think this 
>>>> is the best solution for what I need. I can talk you through my 
>>>> reasoning by email or offline. If I can't convince you, I will need 
>>>> your guidance for a better solution.
>>>>
>>>> Thanks,
>>>>   Felix
>>>>
>>>>
>>>> On 2023-11-07 11:58, Felix Kuehling wrote:
>>>>> Create a new VM state to track user BOs that are in the system 
>>>>> domain.
>>>>> In the next patch this will be used do conditionally re-validate 
>>>>> them in
>>>>> amdgpu_vm_handle_moved.
>>>>>
>>>>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++++++++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 ++++-
>>>>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> index 1442d97ddd0f..0d685577243c 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> @@ -232,6 +232,22 @@ static void amdgpu_vm_bo_invalidated(struct 
>>>>> amdgpu_vm_bo_base *vm_bo)
>>>>>       spin_unlock(&vm_bo->vm->status_lock);
>>>>>   }
>>>>>   +/**
>>>>> + * amdgpu_vm_bo_evicted_user - vm_bo is evicted
>>>>> + *
>>>>> + * @vm_bo: vm_bo which is evicted
>>>>> + *
>>>>> + * State for BOs used by user mode queues which are not at the 
>>>>> location they
>>>>> + * should be.
>>>>> + */
>>>>> +static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base 
>>>>> *vm_bo)
>>>>> +{
>>>>> +    vm_bo->moved = true;
>>>>> +    spin_lock(&vm_bo->vm->status_lock);
>>>>> +    list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
>>>>> +    spin_unlock(&vm_bo->vm->status_lock);
>>>>> +}
>>>>> +
>>>>>   /**
>>>>>    * amdgpu_vm_bo_relocated - vm_bo is reloacted
>>>>>    *
>>>>> @@ -2110,6 +2126,7 @@ int amdgpu_vm_init(struct amdgpu_device 
>>>>> *adev, struct amdgpu_vm *vm, int32_t xcp
>>>>>       for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
>>>>>           vm->reserved_vmid[i] = NULL;
>>>>>       INIT_LIST_HEAD(&vm->evicted);
>>>>> +    INIT_LIST_HEAD(&vm->evicted_user);
>>>>>       INIT_LIST_HEAD(&vm->relocated);
>>>>>       INIT_LIST_HEAD(&vm->moved);
>>>>>       INIT_LIST_HEAD(&vm->idle);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> index 12cac06fa289..939d0c2219c0 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> @@ -286,9 +286,12 @@ struct amdgpu_vm {
>>>>>       /* Lock to protect vm_bo add/del/move on all lists of vm */
>>>>>       spinlock_t        status_lock;
>>>>>   -    /* BOs who needs a validation */
>>>>> +    /* Per VM and PT BOs who needs a validation */
>>>>>       struct list_head    evicted;
>>>>>   +    /* BOs for user mode queues that need a validation */
>>>>> +    struct list_head    evicted_user;
>>>>> +
>>>>>       /* PT BOs which relocated and their parent need an update */
>>>>>       struct list_head    relocated;
>>>
>
