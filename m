Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011CDC54E58
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 00:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D6610F76B;
	Thu, 21 Mar 2024 00:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iAbdpS7N";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F3A510F76B
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 00:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfWpevLD9NnCrIMk0ddpbFxd0MoQ6RyiSh51hBy4uuR36xCmVh0olnFtq1CxkFiBsvH9BfMSt8lDxN4NWJaezI/NeVdHk6LJ4qS+OJyzBBfDT0SrqP7rXCtdE3pljMt7lcs0bVdexexnXqdKDNNDpKsc8HFS045wq6ICVQiG5JqBmI+grcIrzQB+PMCiZFBVkNHHczIGKKRmDD4ov2jHBQqqbHjf9G4SQGdIp1XqAP4K3Kb31o/4X6H31cpH6Hf+meXtQy2qiBPedLx47SWla68x3+rq7gM+K+7pIf1Gm2DVdNYqf0AFZsj8HFBS4LEjM7SOvwwSj+jyVxtCt2lduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWU1YYNaFNwNHt57+Q7C9vqUpfilKYdRNiZTGn3ooao=;
 b=JtYhL4N8vpBIW9A6LyVULnLIdbuKrVF5tk6EPiX4ts61SPw/ukqMohPgxy7mB2I0p1ntg5mjMGlrNTz42OZY+9jkP81fO/eqFLIuBN8M1ACYLvpL41gRWqXKNsvWJKVLeBWin6L78AiUFO2IR7QlRaPsjjfAaUA58PJeVQmYny7Wd+gAc8FgrxhcuNOAm/CH2O4Co9NgLpkxJXfkzbrv0iejigvQrAW7+W1vYKTIJpRaf1CWWVAxiYcFS3V8x+zp9SPANHsenrMijpzQIgXJrIq8yhYeD1SwWpQ71PiAWAzMkjNBRhIxq02cnhfCcQWu4mp3Dj0QN2JYORrcaJxL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWU1YYNaFNwNHt57+Q7C9vqUpfilKYdRNiZTGn3ooao=;
 b=iAbdpS7NDvN/uYYXDDxM1rGu6xm67fx9EQYo/fwZZ2nzJxcXL92GUh2hbK+uVhb/e6M1Y6+V1xhBq+TNInLyYUXlUWUnQA9C6DTCnTeJz1OWTjsb3QzKiIT51VhdbmhDq9iGwRJQpEGIyRmcjniCct4XscZ1rJPjVtzeC6/sWlI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by DS0PR12MB7560.namprd12.prod.outlook.com (2603:10b6:8:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 00:02:12 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::ed23:2c6c:d0ce:e105]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::ed23:2c6c:d0ce:e105%6]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 00:02:12 +0000
Message-ID: <5888a34a-eb37-c1ea-54d7-896b0dd6665d@amd.com>
Date: Wed, 20 Mar 2024 20:02:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdkfd: Check cgroup when returning DMABuf info
To: amd-gfx@lists.freedesktop.org
References: <20240315181756.685335-1-mukul.joshi@amd.com>
 <48148998-5124-4a66-8d1a-767d94f6c284@amd.com>
 <7e4eb11f-feea-46ab-902f-891f1e15e58b@amd.com>
Content-Language: en-US
From: "Wu, David" <davidwu2@amd.com>
In-Reply-To: <7e4eb11f-feea-46ab-902f-891f1e15e58b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0288.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::16) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|DS0PR12MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: c085e7a2-49f3-4043-187c-08dc493a28f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EAuieP5q6xhEnyOpwPD1ht4Mr+FLnCnTlEUIDTFsApNiN58levCkY7fHJt8tbcf+TNkyHlnxX0O97A2BjEGHhIrK4QJYthyA8s+DECNzyDkRo6nYwEpg2U+Mf0PiImNcYe3JH90p7h6/aD6NGNngtBBq3c5s4xNslMoeaA2BNrshI9I29OTs9DsA58ONebyftgb0qpGAAz3Pcj4lvjoCJ5OWxqw9Hdf4cOXcM8ZWFRIwWb5BJQVbVfRIz7D2ObCCzuEKVBZHbeBcsqdjmd4oHpgyApLJ/PqreMV4/a7WQV7+98yY428OeYn99W8e4oBwNFLnGi41UqM6dY/s1yqkA+pIYnNyaDWq2jPJig/PkO20LmsdVFNKrZVIrBID/4+7EixpT8/KkKBBK5f09NZ62dZTbLQGWHfE3XPBiW2Ii501dHcwLl9OCTVnHhYoZjS1o5eUqGy5MxxD0DlvUO5+Yln5tyYgx/hAd9cTMUevYgXap5CbaznJz//8p1/yIYFThD7N7GKUShtj7xPZbKvuFudjTfUNgGer+zcIXxYuQHQD8ED1ZtDRa23+CSTMtNFEtsStE3d+ulZmRbe78v1G1bfdrBqJztRs5xGKCsUtkSyAiaSwd/u5i/9O2FGWNIKJbj1KUdYCsUWGYDJgRN60y3YlR63oahlN/ECxC+REuRA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEM4NkJDQm5ueVZhdzIxYkxiR1YwUG1vdEU0dGJKN0ZqTHhZSERXbDBtSlVY?=
 =?utf-8?B?K09NNUVxempvTkU0NXFUaWxXRTRmQmFxRTFHWndsNnZkZTdkR3ZwRWtyNXR2?=
 =?utf-8?B?Ty9Wd2NBYTJDZ1ZnaG1JUThDWDlLS1lncENPVThmWlFtZW9MRDZQNFNhQkZv?=
 =?utf-8?B?YStXNWRCQzB0UFlxQkwwQjZ6dVpPS1BPbm5TbVdlRzlzT3pUcWVNWnN1cCtT?=
 =?utf-8?B?M0xMT1o2NG9xK3ljN0orTXBaWXNWNVdVOFRWa1BEbm5rKzh2Qm1YRDhINjYy?=
 =?utf-8?B?NllwckhuZVl3Rkg1dzg4NnFXS25HRTFoRFp1Z004bWxwSGlmMThoN1FJc283?=
 =?utf-8?B?TEs5ODRmb0dqWTRIZGxMQUdnVTZFU3ZJR1ozWTQ0MUZkNmNxaWV1TTBWck5I?=
 =?utf-8?B?RHZwRjFkMnRJYytNSW5rWG1FZFhsY3A2NWFDNFhjMlo2QWlQSFNvaUMxNmph?=
 =?utf-8?B?YlJMMkR1dUsyVUx1VlFxZHFjR2NvZEFQcytXM0V1VG9ML3NSSE84L05CcTdJ?=
 =?utf-8?B?UXd2SnhoWkZxM1ZZTElXMmxVbXRjcVZWYmpSdisvcnIxNmpCdFFMNTMwZDN0?=
 =?utf-8?B?L0V2TitnSXhiQ05FaElCZXpldUl0SWJsb2dGWmgvVFBzaVowRUdhUmN5NGh0?=
 =?utf-8?B?TDNxRVlNU2NlQjBXYnhHWDU1emNHTGgxRnBmVFIyYktsdDFjcEFmT3lUcHhP?=
 =?utf-8?B?UTJDNW5pMzZFZ1hiUUV0YXpWd2F1eHFxNTIyY2RMS3BGNGRybnJlZWdLUnZm?=
 =?utf-8?B?cTQvbjZqa1luR3FFckZRd1FWQjBYQ3YxNU5yT2wrZXg0Z3dRL2M4N0REblNM?=
 =?utf-8?B?djVrdnBJTnMzTU5yNnRsTnQrRUFzR0kvYVEraUhTY2pVcmRzOWRpbXhFdE1l?=
 =?utf-8?B?c0l3Y1VxOWhjTCs4Ylo1Q00yanU5bHdBaCsxbmZlSHo5Z0RnN0k3dldEdjlU?=
 =?utf-8?B?WG5tcnhDcTFqUkk2M1FpUEF5K2M4K3dsNnljN3pkVDFFb3k4RlJxWkkyK1FJ?=
 =?utf-8?B?VVd3a3dKdkdXUUlHMm9YTG9hbjN1ZVFYMnBwSFJMRmNmMzltem8xbG5WM1lz?=
 =?utf-8?B?bWZLNFdiRVJxb215NlVsdmdnRVhwNG9EdnpTQTBFSVRWRXZXaGpNOFlrdXNV?=
 =?utf-8?B?N2xod3c0OEFGVkR5b1FHS2p0dndDQzVlZy9GeERCaG9kYnJFUEJhTVZPMks3?=
 =?utf-8?B?MUhRcmJVK3l0b1hjSGc4eFE2cVBLcHJXQ20xWE8vblgrRmxCb2tGOVhXRmtD?=
 =?utf-8?B?TFUxQzJKRGc1bmY2ZmlZMExnR1Boa0NhelE2eUdUOUdVNDc4ZXBzbCtIVVp0?=
 =?utf-8?B?QWFWb1U3R3hrUjdJVFhYcFAvVm54R28wa0pXa09IcXh3Snk0cTg3K3JJVEdy?=
 =?utf-8?B?djBVelJCTWdJaW8wcDAyMnZmYmNwY2VyVmh3bEhLMW8wQnRrc2NFdjFJbzZZ?=
 =?utf-8?B?RnBuUUwyajU1cFZWQ3doNHNRL2RCQjZxd0Nhbm5Sd0RSaElLa1kxSjcyZW12?=
 =?utf-8?B?clVaeFVCU0JuSUZLdWJrVG4yeUdtTU9QN0xwNW9nT0krempHdmowbEljeEtE?=
 =?utf-8?B?S1pQblJOVVlrOFV6Ty9tWE1ERjFQME5CUkUrZ2taZmVsTGorUDhodllLM2Ir?=
 =?utf-8?B?bm9CSVJZQmZscUh2dzliSElNY3RQMjFDelIyUmxaZGpXL0RFNk5xakc2TCt3?=
 =?utf-8?B?REZONTY5V0lKNVljL2pjSWkrSGpRNHBXQnA4OW11RUowVUg5RU92UWNJN0dB?=
 =?utf-8?B?djN4QUJlL25IQUl2clY3UEN2alFvWHRrL3NSUzRQdW12YzZEdUFkbXpueXBv?=
 =?utf-8?B?RXZLQXVjVys0Z1JJLzRVODRmZE5EaSszNUxPY2JJNDZWdGpMRkdxWndDNzg3?=
 =?utf-8?B?VVJ5ak9Wb0s3dTl0UWpwcXVUenBUaDNZNEcrVzRPMkx2cTdsay9oUkk5NlNO?=
 =?utf-8?B?MFFxcGxJYXVJd013Wm1iN1ZGTmJTUWo5V0l2SGk3SFQweHNQR1RadjFnN3ZC?=
 =?utf-8?B?ajlqcm9oMEdCMEc0Tlp6ZVV3eUVFR1BSVHQwY2kvTFNuZURQWDV2YndwYUZC?=
 =?utf-8?B?MlI3T0pvWm9UWHZDN3lJVVhzMklRUUhQaWZUZldvMWlxRGZPaGtndG1Ubzlu?=
 =?utf-8?Q?vc03kDgLb2eZa5LrYL/KFyDQe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c085e7a2-49f3-4043-187c-08dc493a28f7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 00:02:12.6135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXB4ovO2uWTTPaMdY6+C89X1HxdIZ8w1VpqLL+ByHZrVbzAqECJIHWB+dUc6IH/p09eqqxd6xRhUbSCZ5b892Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7560
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



On 3/20/2024 4:21 PM, Felix Kuehling wrote:
> On 2024-03-18 16:12, Felix Kuehling wrote:
>>
>> On 2024-03-15 14:17, Mukul Joshi wrote:
>>> Check cgroup permissions when returning DMA-buf info and
>>> based on cgroup check return the id of the GPU that has
>>> access to the BO.
>>>
>>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index dfa8c69532d4..f9631f4b1a02 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -1523,7 +1523,7 @@ static int kfd_ioctl_get_dmabuf_info(struct 
>>> file *filep,
>>>         /* Find a KFD GPU device that supports the get_dmabuf_info 
>>> query */
>>>       for (i = 0; kfd_topology_enum_kfd_devices(i, &dev) == 0; i++)
>>> -        if (dev)
>>> +        if (dev && !kfd_devcgroup_check_permission(dev))
>>>               break;
>>>       if (!dev)
>>>           return -EINVAL;
>>> @@ -1545,7 +1545,7 @@ static int kfd_ioctl_get_dmabuf_info(struct 
>>> file *filep,
>>>       if (xcp_id >= 0)
>>>           args->gpu_id = dmabuf_adev->kfd.dev->nodes[xcp_id]->id;
>>>       else
>>> -        args->gpu_id = dmabuf_adev->kfd.dev->nodes[0]->id;
>>> +        args->gpu_id = dev->id;
>>
>> If I remember correctly, this was meant as a fallback in case for GTT 
>> BOs where the exporting partition wasn't known and the application 
>> didn't have access to the first partition. I think the way you wrote 
>> this, it could also change the behaviour (report the wrong GPU ID) on 
>> single-partition GPUs, which is probably not intended.
>
> Never mind. I double checked: On single-partition GPUs, bo->xcp_id 
> always seems to be 0. So your code won't change the behaviour here. 
> The patch is
should bo->xcp_id be >= 0 for all cases? if yes then I think all tests 
can be moved. (like below)
args->gpu_id = dmabuf_adev->kfd.dev->nodes[xcp_id]->id;

David
>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>
>
>
>> Maybe this would preserve the behaviour for that case:
>>
>>     ...
>> -    else
>> +    else if 
>> (!kfd_devcgroup_check_permission(dmabuf_adev->kfd.dev->nodes[0]))
>>          args->gpu_id = dmabuf_adev->kfd.dev->nodes[0]->id;
>> +    else
>> +        args->gpu_id = dev->id;
>>
>> Or maybe a more general solution would make DMABuf import work when 
>> the exporter is really unknown or not even a GPU. This came up not so 
>> long ago in the context of interop with 3rd-party devices. This may 
>> require user mode changes as well.
>>
>> Regards,
>>   Felix
>>
>>
>>>       args->flags = flags;
>>>         /* Copy metadata buffer to user mode */

