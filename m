Return-Path: <SRS0=0crs=NW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A9AC432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 02:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BCD560FE8
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 02:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6BCD560FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AE4189B7B;
	Tue, 31 Aug 2021 02:45:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7242489B7B
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 02:45:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=By7TjDPzfmO2/Sw5TzHwWaM4pcWl/FgR4WucT1RBaGhe1JAC1n7qwqg7PTeqgOaZCKWea+JkjYF9KqNUMY4BD19vFwKsc8iBYYlk3++CkTRqFSxB4noOR7C/GV83cluxsWj8cAv6nqhYWw8LqrmtGkx+U+Y9LLsZYJnsxei6IYVGrao9Nzc2SQXe83VXcne5HwUNxMGK9EcCBJdH55QKSK87Fgk/cyTyvN6WEY0EgKo68hOj/r3ekPgzHWb0emUQ0t3ldpvz/waL9yYPqLhUSRKOdhxOIY3rx0cvivKR6MsCYRK6D4itN+cK9n9v4mdvfujou6uvcNwQ4m+1UUr4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVQ3AfUSC9Cs8PRUOFopEmx7UCl8Hgvi+V3y9rQtrlE=;
 b=RLuhbOamJHPYdHh++Kjl9091lNv0Hc0yqqxvcMBwbgz0N4cdzHnWUuL8DrXWw026uNjpOWwR+sf4GHRkc1tnF/CaXkSUdpD+BJZ8pPyN5ui/34oppcoJ3RnvqcNIoOErlJ+aJ1wcK8L7QlK/fOXI7QTJbmz1P4Qz/gLn4AOWXnmxMDe8Suc1yPC0nFArpShIBoCiBSXoHhTP3o69mhgEOdccOFapB2JV6GuOEuV59Fb8jULZJlXLu4hQBURTvU/E1D3uUq6dimyhvml0GtgRNI/1FU4kzoRyxj0JwZgZllKD2lFGsgCQpJMepQzqurty/RZWRlWyA1TTvwpgYTlgTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVQ3AfUSC9Cs8PRUOFopEmx7UCl8Hgvi+V3y9rQtrlE=;
 b=zKav7gZFV0MqwYVVLPp+bjM1137TdyDWX7SPZW11rvfOCmXlYS9vf8nRLSpwMYiBpv/qhfsaTmiIdSH7YSDZe4BuhZi+bpWE2PstazjVfvpvyTkYkr3FhKXkP+1F9DkM+CMgT5jIFwE0Q3atPxHRJxtcWPCDJJIZoHU2c1RVdW0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Tue, 31 Aug
 2021 02:45:20 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::c4ac:2505:5bd8:295d]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::c4ac:2505:5bd8:295d%6]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 02:45:20 +0000
Subject: Re: [PATCH] drm/amdgpu: stop scheduler when calling hw_fini (v2)
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com, mike@fireburn.co.uk, alexander.deucher@amd.com
References: <20210830060855.12583-1-guchun.chen@amd.com>
 <7c472a80-9139-9ef7-8b22-a7b925c2fe89@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <44d26a8a-40db-41fa-1342-0a3fa1f2b2ea@amd.com>
Date: Mon, 30 Aug 2021 22:45:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <7c472a80-9139-9ef7-8b22-a7b925c2fe89@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::46) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:fe36:59a5:493:2924]
 (2607:fea8:3edf:49b0:fe36:59a5:493:2924) by
 YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.18 via Frontend Transport; Tue, 31 Aug 2021 02:45:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0d79173-0539-4f3d-bf5b-08d96c295f65
X-MS-TrafficTypeDiagnostic: SA0PR12MB4494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44941A699610F59D630EE9CEEACC9@SA0PR12MB4494.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6beEcA46yS9QcEFIqG6eqjr3zfEAG1+gHCJzPmZgOV25FciwMIxIU0OLLxAomLFDz7X1g85mQ/Q1ZGiTRGEJT2kz602h5Z7HBQPtFJOUxOCIMcRNVu5Qwrvdj3s1wnXAr7ss1yQIMCN3zNP85UjHRh0DAE63fEqKRLY1xBjf5QZHjeMdkAtyVo/d5Nj+gxIMqlpeYiFJzhKeWceZ+rKT3hVlKpvFPtO3Nv15UB0f3IcBUQMZiwkaWbzhry4bhpWOs+gkeW9k6AHygUhMeanK9zYSuIUXwS0qpkqMaJ14YmzVIsxBmjtr1CaFJY+mt2uuZKOwxEcOEx6ImkPllaXc6TaOwqdhPuvHKoG7yyZGxAchKvMLbQLTS0yvDm1gq/pjm/vsIJBFUg/AWX3FON9PMoEJz1glPm5ZnXlV1aeXewnxtGfcsS9S8qv2BMWrkQgZhF5pq2sijQ0LKJp5qL9zPKadFOhRFtDDjOfoMly1Cy6sCzc5VmQgJXe5yY0YpQLt+4LdMWDmxpJTpkvJ9gxRx2yUH13MEuurqxl35S9dkIzCbNSLz+Kt5LjOuLSWmi9V60Kevqx1fLbYhY6w68OWlJpn6hWDQ9RUNB22mtYUsvTwA7R5Wk7+7FAagpPhXp/zWUT8PgqTuV5rixvS/8m+sOt3WhEBOn5YTMEdh6caQLO6miYfBSXezrj5sRwAHnq4qQ2yogavd3xoJ1mRRoxxxdILz1u2sIR8XTFTDFIRXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(110136005)(186003)(2906002)(5660300002)(53546011)(44832011)(86362001)(8676002)(36756003)(6486002)(6636002)(2616005)(66574015)(38100700002)(31686004)(31696002)(478600001)(66556008)(66476007)(8936002)(66946007)(316002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjRoU2RBYkxkVExvME1vNVBtUVdVZjVXVEE2bFkxZ2RDb1ZpNjZicVJ3cHNK?=
 =?utf-8?B?cVMzMFBVV0hVZTZIaGJiTHFqeCsvQ1A3RXVjODIrQmNYL0wvNTZZUDE0cGR1?=
 =?utf-8?B?cTNXKzc4OUFqb0dhNHFmQmd4bjVYSkhPaGdRckIrSmw5N0tuV2ZybjBsOXJn?=
 =?utf-8?B?UW9YeSszaUY5Rm5NUTUrdVExMEJZK25FSkQvOUlYWjlRR2NRYkZNcWZyc2Vj?=
 =?utf-8?B?aW5wa08rcUhEYXYraFN1bE4yNUVUeUhPYnlyc1I2Q1NzYlorampTRmZ1NDQv?=
 =?utf-8?B?bTFVTGw2ZDdDTFpQZGgrWVN4YTNRYllOa2o5Nm4vSDV0U0pZSS9ja3RUVDkx?=
 =?utf-8?B?NzBtdHo2SS9YUmF4bVVROHVqSlh3NXh2emRodlZKcE5RVWk3NzJHRVBzZ1ow?=
 =?utf-8?B?SmRvZ3BsL08xQ3FJTWtPS3lzdEtJNkQ1c3BQTnZwWVlySSsrWVFncDRWQ1Mv?=
 =?utf-8?B?eU1BS3ZoWHJCQllXUDdYaE5TNGtDMWdLVVd0TGduRUprL2E1MGFhMmpWRjZr?=
 =?utf-8?B?ejJ6a2Z3MWhrYVFVdkYxaUZKdXEyNlFVckFvOEc3cGhWYjUvMUhWNFdEdnI5?=
 =?utf-8?B?emg3aENqSzYwTTkzUkdGUmVQS29YRkZnZGdpdnRpNWthTjVhUmF0RWFjLzcw?=
 =?utf-8?B?NUhlT1pEYUtlTlV2UDlEUVVTc2tEdlR5a1ZEMlZFOStlTmRybTNGVm1kUWdC?=
 =?utf-8?B?S1Y3QTd3c0RwUTlPVWdyQWdOREVXSm5Hd3IxU0FrVTB1QWdNRklKMCt5dWFQ?=
 =?utf-8?B?eXJXVWUxUVdDUDM5MEdDMDFmeCtVOUNxR0RKNjYrNzNubG9WSlhkUkRCbkpy?=
 =?utf-8?B?M2xtQnRNRVNSbzNrTzlET1NlNk1sWEZaVGFTaWdhLzZnb0h2dXdycXIzUHJw?=
 =?utf-8?B?SEJuN1p5L01OUFpsZWVUVmFWL3kya1dtc1NZOGpJMDZXQUllRkhvbEFxVmtF?=
 =?utf-8?B?ZUJxTk1rN0RSMUtOSjRTTnFsdUZCRkVZMjBiNy94TkpnZ085a3NvS3ZCTGs2?=
 =?utf-8?B?bXpQTytEZ0RWbXd1WFhKcnhjbmVTenpJNG44dEptUHJMaTc2WWo1Q0JxTEkw?=
 =?utf-8?B?aHU0Y2thbnhINjVpY0dmMU1tR3kvS0JtU0xMOUl3QjN5Tk52b0szazZlTlhw?=
 =?utf-8?B?WjBEZzBodHF3SXk3S2FnUi9XaVNESDJwV01hZnRlWXdpdm0vS3FsYkhOTkF1?=
 =?utf-8?B?MDBGbk54bUJKUGROT3JzNVhTM1VLMVk5MXlGQzBBNWxMemZtZHJrekR0WXVy?=
 =?utf-8?B?Zm1RM0NtT0ZuNEZtT0h4cW1xZjRFNmNLT0F1WHJWV2VTam1DMlRmaldmeWhY?=
 =?utf-8?B?WGtyS0s1S1ZwTUt0WnNuTTd5dkJuRVBCaUtDUEJ2OXo1cm5HNjhiNVdpTEFw?=
 =?utf-8?B?VHJMNHRVNCtWWHAydUVvcldrK3dqTk43a0pmZ0kwMy94RlhhM3puS2lHS1gy?=
 =?utf-8?B?UWphNWNEVEhTeUZPT0x0bkhheHBmTnpkUEZKTHBkeHRCNEd3QTI3UGNTYnlh?=
 =?utf-8?B?VzVsUDgrUjVpb1lDZW9IWXhjR0FWUCtKcGJiNzdzSWN0OVloWjJSUkxidnNs?=
 =?utf-8?B?c0xNMUJqWlZuVVlEZmtWcXNwYlZKNE5USUdDenRlbjU2a0RPTXRBdm5NWnFl?=
 =?utf-8?B?WVhpcXl2UlFPeFpxcWc3ZzhjTVJuQ3RlWDVpZGVyQ0lVWGhJWDBWMWVpazIx?=
 =?utf-8?B?TU10T2dzVFdSL0xKUW9WOW5HSmMrUEVjNlFwRitGQjBNUUVMRHJhRllLZ0ox?=
 =?utf-8?B?eG5hTzRDUHY5SktVVTZjdmtlaFhCeDJ6eDJURko0RXBPL2xOMktpVHRsZ09D?=
 =?utf-8?B?YVBDWC9jcFhuV1RTVUpUQTFIQWc1bksyRC9IWjRvTEk5ai9uZXRGOFhtdkpZ?=
 =?utf-8?Q?FGrXC1evBTTBa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d79173-0539-4f3d-bf5b-08d96c295f65
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 02:45:20.3626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLXMs8DcEATzzHPm7ywsvHMcWJrWgiIKcKFxeSwUmEwNz/xa7MR3Gj5A7n3GqbOskRUz4WCj243Ph1jxrDhohA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
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

Looks good to me too.

Andrey

On 2021-08-30 2:17 a.m., Christian König wrote:
> Am 30.08.21 um 08:08 schrieb Guchun Chen:
>> This gurantees no more work on the ring can be submitted
>> to hardware in suspend/resume case, otherwise a potential
>> race will occur and the ring will get no chance to stay
>> empty before suspend.
>>
>> v2: Call drm_sched_resubmit_job before drm_sched_start to
>> restart jobs from the pending list.
>>
>> Suggested-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>
> Reviewed-by: Christian König <christian.koenig@amd.com>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index b439eb7d4177..fd4ba076ff8a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -552,6 +552,9 @@ void amdgpu_fence_driver_hw_fini(struct 
>> amdgpu_device *adev)
>>           if (!ring || !ring->fence_drv.initialized)
>>               continue;
>>   +        if (!ring->no_scheduler)
>> +            drm_sched_stop(&ring->sched, NULL);
>> +
>>           /* You can't wait for HW to signal if it's gone */
>>           if (!drm_dev_is_unplugged(&adev->ddev))
>>               r = amdgpu_fence_wait_empty(ring);
>> @@ -611,6 +614,11 @@ void amdgpu_fence_driver_hw_init(struct 
>> amdgpu_device *adev)
>>           if (!ring || !ring->fence_drv.initialized)
>>               continue;
>>   +        if (!ring->no_scheduler) {
>> +            drm_sched_resubmit_jobs(&ring->sched);
>> +            drm_sched_start(&ring->sched, true);
>> +        }
>> +
>>           /* enable the interrupt */
>>           if (ring->fence_drv.irq_src)
>>               amdgpu_irq_get(adev, ring->fence_drv.irq_src,
>
