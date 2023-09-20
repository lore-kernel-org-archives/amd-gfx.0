Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C35BC04AA7
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 15:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B32710E514;
	Wed, 20 Sep 2023 15:58:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E48AD10E4CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 15:58:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A14x3A9ijh2uoQ8bx0hb1rK3DfYIvxFYf1VHTKuU0a/SasEBP7Ezfu9233ZobVqDNaYvEzHn6QekU3MYCYzDsJ2Z3TU6kPFiFGkEHJmSoNp3C0q3+fkw8QhKtRc0BqpZDDP/iD3Rn15lqTMpXv98v17+i5i9DDWv9FyjwEoYG62v6obITBr9e4/NcihBZy3L1kuQ+Xi2GEcYlJxNWnZAECzBBAcoL93FQpC+pdNY51HFEhe1xj0DWcka4BfRT1ET/w3RP1NI0Yy5EL7kO9kfmQDY7pEx7fBRnDvMi2Dp36vDoiDT7WhgLqTHF0CNxkpCOapT9uxpL6LGXyMJ8Yk/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KK8hwKV4Nbhu0aoSAZits4gbjJD9oAmFUeWG4l3iFHI=;
 b=Eycy/gGHUs9qeqlvT2ClMppb/43gcLLZdsxeL/sOnCjAPDBoMVIwHXeqxPRgsxn3IzXdhOwjk/JRFQ7Fj7mRxNBbnUDhbfU9ptakNa/WRL7YbSbqBYTTDGANtpTLJvJeHUQjI3oDNV3JEiTICtT21NINh+SQHmEP4W3mxVAcgN3Bp1Xjwo1q/WzFmaMqG1UC4z/q+sfktvMbIWNc8Qaw8/RxWSCTsbQaw41zJjPqdTQDcowrUNRmPBXHXhOfWXBXyZzXFbwSDgAu46IjBg1TK8XzU3k6XKeVTqS+lJxoGN9noumhksgKh7vcko5MlaD9NvOT4B/0VUOMBNclRm4Ytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KK8hwKV4Nbhu0aoSAZits4gbjJD9oAmFUeWG4l3iFHI=;
 b=5lOCThdWa6dnHtqyMpG2pN86pzRzHF1a1woaKyhEw5lL6y6cxGc3JijPU84g7EjN/mfDkVjmhIN0g6P51NOWxz8p3pXRMKZhriZLY8zlIgOX9JDjlibIRJaMPdEafiYRTynIkZbvJx5B9IGEyGKWXEf67Itdxv3PS1EjkNJnCBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 15:58:07 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::db98:f81e:9211:92fb]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::db98:f81e:9211:92fb%3]) with mapi id 15.20.6813.017; Wed, 20 Sep 2023
 15:58:07 +0000
Message-ID: <72c82625-daed-d446-06a5-085ff2fbab0e@amd.com>
Date: Wed, 20 Sep 2023 10:58:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdkfd: fix some race conditions in vram buffer
 alloc/free of svm code
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230920061741.41382-1-xiaogang.chen@amd.com>
 <921f0521-f0ac-3d9b-36c2-88b4c3bd8c3e@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <921f0521-f0ac-3d9b-36c2-88b4c3bd8c3e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:806:f2::24) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 60de7578-9eeb-43c2-67ff-08dbb9f2618f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bf6y+5FfXG9wzz1eTmOJkxTRjw+ydqG2vif7CfDBJpCzkHT8QP0Q/lJ/S+ix+ONWFAZlUnsOO9o/b9wUhBU2cju6PliIvckYhLj5QXnujRs7CAXynNeTELs6TXmuoqMqky9pBCJSAwaEWzqqxuaoz7M/o4HgBrly3lxk22NADylS6X5Gz/c7BTIqK5YVgvVcOoEBBnCB2Uqq8uipMAYEW3Xy5uenk+NvoPY4XnOrSTjwex9JsPHzQjYnK7VlPfXEveNro7HfjbKdH9I+DpQ4ij3YDU9KjYUehL/3YE4B+prvEMc9HNC2kCOGodShlH22mfL0KNHaZphkAtZo6EfJZdcQb9bQj0uG8csl4b9ahG8XNBBZfkdfKP85wAvN0Ebex2w6P22RWnpF7+thxHqiIqGH7bKfKJB/eAyr1qo3m7Zkiv75G7qYdgfAbyZES0+jMyaRaAMAkImDmXJ1sgwU4+T0nYFFgqh6MQhdWSTVJs+wbujg6Uwbm/46AxNTizGAJxvIElCs+ol1E8QIY9WX3MYWkOtUEEXtbEGoYtfWXnI9g9J1nEt6a4z3g+mzwoMwXH5x0yzJSeSgj5sm4Q5zcHiL+ga4PQ9fYHXMam85G7Kyatd07Qqt6Wins/SubYFKke4HgSGUDzzGtkDYpXIN0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(346002)(396003)(376002)(39860400002)(1800799009)(186009)(451199024)(26005)(8936002)(2616005)(4326008)(83380400001)(8676002)(2906002)(36756003)(31696002)(5660300002)(86362001)(6506007)(53546011)(6486002)(31686004)(6666004)(6512007)(478600001)(66476007)(41300700001)(66556008)(66946007)(38100700002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2ZzY2RhVURUZDNFc2ErMXNwRlZZcUVWa3BpZ1Zpa1JUSEtTWjV4OWdWMU1N?=
 =?utf-8?B?dXgzMXNwa0FGeVpYUkhHb0dzMUREb3FvMUlKcFp1Mkc0UDJWZjhRd0Roc240?=
 =?utf-8?B?YnVzWkxNUzJPUk1RM08xbWF6YVdFK1QzbnRRY3YzWnAyUWd6emhQN0ZsNS9q?=
 =?utf-8?B?ZkVTY1NrVS9odjVhaU9lOTI0dG9vWldCNHp6RjN0bERibmJKaWpMenBqYlR5?=
 =?utf-8?B?bzY3MHBJY1BUYm9MWlBjVlZEa1c3RThqQVB3TWlWUFo3bk9Sc1ZCWFRoOGoz?=
 =?utf-8?B?bVA0MVZvMHFWT0VpTlZaM1pqczVLNlkxODBjVlhQdVEwV1dub0VWRkxQS2JL?=
 =?utf-8?B?QzFWWkM2MXVjVEFPMUZEWHZYRmJpM3RiR00vRGM1MFRhWk5HeXFrbWNhWllU?=
 =?utf-8?B?VmNDTGtxZ0VSZTVxVThheS9CeFJpSnJBNHlpbXc2V3VZVDFtWWlLSGh4dHVX?=
 =?utf-8?B?VDZySVhIeDZyaXVuQmMvL0g1WEd6dGZxcmx5OFE1dUpHdE1FZklXSEhaYk5h?=
 =?utf-8?B?NUhoQUhDV04rRzdkMWRxOWhLeGlZM1EvQlRNcG8yaDRUc0lKSmNrV2p3cDBu?=
 =?utf-8?B?RzJZSjZjcVlGMFNiSHJQUjRoTGsxUmwzMGZWM2haVkxvVDZibkRlWXBJQzA1?=
 =?utf-8?B?VzZGdlhlSlpoYjZXdUVlWityblNPSHF0VThLdU9tRzRZUlBVL2wray8xS2Zm?=
 =?utf-8?B?RU5PaFBmV0N6cjRYRk96cmxPYTVaYVBIYkF0MXNSTWsvMEhvVktGMG84dTRl?=
 =?utf-8?B?cC9seHd2Vk02K3ZKVE5qSCsrOWNIUnpIVW82NDBhYlpsTkpzckR4bHYxR2I2?=
 =?utf-8?B?VE9tN2FPUG9zUWU5RTlpcyt1QnlyNFFneExETTlCKzRPUkltRWc3MnFnMTha?=
 =?utf-8?B?RlVrWDh3UXE4QXl0a21iM0dQaVhLQzJrWFNWcjVGTVVzTHdWTTIzcEJnUkNY?=
 =?utf-8?B?Q1l3T3ZYbUZKT3Y3d05maU9hOURnQXVuMWdOVFdFM2wwZDg0ajlqSjRxRTN1?=
 =?utf-8?B?dVhxREJBeCsrd3c5dXU1dHNqTG1MblNjTjlDZ2Q5dkdTZVdtdUxtc20zUzVm?=
 =?utf-8?B?SmtMeVNWbEtEbkRlSHV2R3d2OWJIVW02Uk5tbnFsL3MxRHVLS3U4dWdqRHVS?=
 =?utf-8?B?QUZ2eGxZQktrMGRzTlpnK2h2OGZrZ01wMDdKa2UvZUtYR2xuaGs5YlpGbTRF?=
 =?utf-8?B?L3N4ZWVEcVVaVFFBYVBObXYzUFZKZElXV2RIQXdycnNaOU1nazNuVW1DWnFt?=
 =?utf-8?B?dEdtYTVLVFpvOG5oWmZ3U3p6dktoN1ZTV2VtY2oxTVk4b1JsTkdsVDZYNFVy?=
 =?utf-8?B?WEJzbWh6cGh6UUhtRTJkNHRISEhvSW1LdkxBUHRLNjdpdGJJMTJjYkNJdzE4?=
 =?utf-8?B?UGwzUWQySkN1SlhDV3NQNXZYNzV0UjgwT1BnbzdWc2F3NVcvbW5hOGlheDBU?=
 =?utf-8?B?OXNNZmFNZGxaT1l2eHZOaUZUTlZjSjN6R0FuYnZxSzNuSkJRKzlOZFZ3RzF6?=
 =?utf-8?B?VEMxOTMxanFvUFAxWFdrNFZtc0ZvMFh3Z3JhQ0ZsdlpMZG1PdUpyNlAwRW03?=
 =?utf-8?B?UnYzZ1JaNGpSRitHVWozWnNIZVRqZlFFalNoS0NzeVd6bi92Tk9qNXpsaGdY?=
 =?utf-8?B?ZE9USm8vcFF1STViY0E2UDh4bEZ1S0xZZnYyWXBOY3RhR2M4THdmWld0VzA4?=
 =?utf-8?B?K0szMk1wZHhoYzl3ZUdIU1dBMHdlWEU0NmVOQW9RK2VIdkNFb3l3YkVlWlMx?=
 =?utf-8?B?WHU2Q2QzcWdoMHNsMENTSno2bUxrcEFSMUJWdm96Q2p0RlJLeTdPWEl0REx1?=
 =?utf-8?B?ZVNOYkU3SnZMajExMG9RcFRPbXpodFMrUFlDbk5QdEdZV2VvZno2bEtiRjdY?=
 =?utf-8?B?NWVzb081S2lucVFYeU9tVUUwNHArazNab2hZQnhERi9QREtsSVNRNFhiRUhw?=
 =?utf-8?B?UXVqZlZCTnBxeEt6aGllL01OcEk0bEdQR0tWbVZsMkJ1SHdvTEk0N1FYTG9s?=
 =?utf-8?B?bDNsZEY4c0dkazNhME5DWGFBMnlFRUVoZXYvSFBJSzYvdmpJTEk1MExCYTZu?=
 =?utf-8?B?RjhTRk45b3kvbzlRMkZoNFpTd2JkVzlzRXFGaDZDcHE3YlFsQmJiRWUvT2Np?=
 =?utf-8?Q?vuWc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60de7578-9eeb-43c2-67ff-08dbb9f2618f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 15:58:07.4405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbCXQqeLm4TyLpuwmkKXLJ70p00jmQb96lMoKwYyQTRY7B9/NOo+g6ziOabsCvbe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
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


On 9/20/2023 9:55 AM, Felix Kuehling wrote:
>
> On 2023-09-20 2:17, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> This patch fixes:
>> 1: ref number of prange's svm_bo got decreased by an async call from 
>> hmm. When
>> wait svm_bo of prange got released we shoul also wait prang->svm_bo 
>> become NULL,
>> otherwise prange->svm_bo may be set to null after allocate new vram 
>> buffer.
>
> I agree with this part.
>
>
>>
>> 2: During waiting svm_bo of prange got released in a while loop 
>> should schedule
>> current task to give other tasks oppotunity to run, specially the the 
>> workque
>> task that handles svm_bo ref release, otherwise we may enter to 
>> softlock.
>
> We had a similar discussion a few weeks back for another soft lock and 
> I pointed to  cond_reschedule, which seems to be the preferred way to 
> avoid soft locks in the kernel. Does cond_reschedule work for this case?

cond_resched() also works. I will send new one to use cond_resched() 
that is safer for schedule.

Regards

Xiaogang

>
> Regards,
>   Felix
>
>
>>
>> Signed-off-by: Xiaogang.Chen <Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index bed0f8bf83c7..1074a4aedf57 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -502,11 +502,11 @@ svm_range_validate_svm_bo(struct kfd_node 
>> *node, struct svm_range *prange)
>>         /* We need a new svm_bo. Spin-loop to wait for concurrent
>>        * svm_range_bo_release to finish removing this range from
>> -     * its range list. After this, it is safe to reuse the
>> -     * svm_bo pointer and svm_bo_list head.
>> +     * its range list and set prange->svm_bo to null. After this,
>> +     * it is safe to reuse the svm_bo pointer and svm_bo_list head.
>>        */
>> -    while (!list_empty_careful(&prange->svm_bo_list))
>> -        ;
>> +    while (!list_empty_careful(&prange->svm_bo_list) || prange->svm_bo)
>> +        schedule();
>>         return false;
>>   }
