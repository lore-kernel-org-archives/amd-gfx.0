Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B1EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 22:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1E7510E184;
	Thu,  9 Dec 2021 22:27:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A603910E184
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 22:27:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyAE83uascyy0hVvv0OZMWzRxwzrqzzhXzT9xFExZJ1VFfo9OMd4uGKjaqszjDfRLRsjYURrCh8PCgldRwEiUcP1x3Zta1ohCesALg4ZoFm2byRZZh9ETcQKEjkoeZ+60hqL/Ibc5qJMjhR618bZndifVkOMUIauWW/ZYctqpYMcZ1LcjsbruRZpLbG/p2w0k0eakkwNuvh+nfsq2qyNKZodzRaDiZgO2UtObnTPLmL4pmACbo57S+XUTdCr7VaMPEaajWxSNV1Vc3L3uJHPKQTBzmhntV8Uz1vf/laERzdP5x++KTCpxLGYXf+uHaNt/q8LNuI2/9AxlSsOIbYsLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuGpbXKmhk6EBCIygaMPJ70UG95hmEg9jdOERKO9sww=;
 b=lfiL+0c/ffbAqmtDnGX9/h5ZgrgDbjku5wy/EqVTQIk6FHM+302sbl7nokqn7/xKVU5XNi8iu+lSZcczYj4CwThY+Q96vClqtEZ3CgOrfQyJcZWBFpvEqUxZitXDDGDONGoFOFoCA6xZT6swpBcWhEA1/C18FZY3bEvlI1mNAIQ8ULcqZQzBjTrVhLbRHLdiAWfjhhLVIKYXo0xA891TqbcGe6IiNO1lNVksWIOZraWyhUDxJb3w5LiHipLCbfBZLe0cMLd2NQ2KmUOagUi9/+5S0/h9eNV0yW5PwTxHhmoWAOHyYiaibOUmH7+R4e0GV47dVl2S7tyETfNri8Q78w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuGpbXKmhk6EBCIygaMPJ70UG95hmEg9jdOERKO9sww=;
 b=VHLJz1yfwZyyPAOu0GO7HrLhaS00aoGpRWwxSTc80bo8zhhoOrN2eButD7MZWYhL03pdWRUh4/EnfABVCm3TNCdaBVPyoKW2U9Nd8AU7giV9IUvqsvz3+wjpNlAB9/bBzAyEF8db2vBOSvbrxmt8s5TSyVAei+MH9hpi2hA8USg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5241.namprd12.prod.outlook.com (2603:10b6:408:11e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Thu, 9 Dec
 2021 22:27:24 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%7]) with mapi id 15.20.4755.022; Thu, 9 Dec 2021
 22:27:23 +0000
Subject: Re: [PATCH] drm/amdkfd: explicitly create/destroy queue attributes
 under /sys
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211209074918.1555320-1-xiaogang.chen@amd.com>
 <93fd623b-9168-09b6-063c-7ece79c9a00d@amd.com>
 <66721e5c-a5fb-9b8a-4766-e5788bee4ee7@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <25d924e7-95df-662e-7a3d-faa978c4cd6b@amd.com>
Date: Thu, 9 Dec 2021 17:27:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <66721e5c-a5fb-9b8a-4766-e5788bee4ee7@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT1PR01CA0130.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.22 via Frontend Transport; Thu, 9 Dec 2021 22:27:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f52c121-deb7-4ef1-b0df-08d9bb631298
X-MS-TrafficTypeDiagnostic: BN9PR12MB5241:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5241CF8A340518DAF64A0A0992709@BN9PR12MB5241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a23lY0HaBlWntCAvuR6JtWM1rtenAfyCWZXpp5M/3QwlijBjs+iPeVj4NPmpFUUIl6H7NwaDKzuFYZHbTFI7m8wNHTLDHqPhy4qkDrho7FrghhE+em4xLIV0pRt+jbgsZm1Hkqefw6gmJiWnc6u1ZGhBkfag1XPnxobaPZJ2gLcDMbBSdkJXEfspxVeE/VNa6NjRLRCrJf7vU2eFLW1uvLRgZsCDOcG3WM0vrVrcuwfZUKygv0f9+gKIYpLe2ZWCZKDwWRYMNM0usnA41jqCMwi/OzuZgzAzAAjAVvxG+RW95+R1Sq+HSUV/y7rXkAJR6O17jrhiTV8S+BYmtmi4lUv0mhMC/g80zXO2UDTb1wKdvriowROLgB96wFz37cIxVhiEXZAQeDclyRY9I1XCCUOBJHmDvBWZ1JXSV7YLvzTI+bTbzkNg9PmsJSsO4GyLBCvZhvl0AZ+veaMrgvMu/EJZabZ+AzshiH+YbgJKNabUnZYwJdKYpq1zTQ2W/54Uqh4ZFUBx/FZU1uzzA1mpJ4+iYXoI3BHaZdGJ2nGBGgPuz/4UPDYd7bsQRef4o6qmJ/Gz/uophIbSUqXySFBbWo/2eEAU8n+g1gwkMBbz8QhI76tQ1S8/xyZzNtMQOw2eGrySKRMpckHdpdMUVNV39CxZuy6q6J8j9oQdTD5K2oME4vCfaGQzXMHf8CLzLHV1t5iOOm791Zy5kn2VwR9HBS3/IVXlGJJUSTqBA/lDQFfT2yfpv7rdTrLgFXVlBZlo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(44832011)(5660300002)(83380400001)(6486002)(16576012)(508600001)(2616005)(86362001)(8676002)(186003)(66556008)(316002)(26005)(2906002)(31686004)(53546011)(66476007)(66946007)(31696002)(956004)(38100700002)(8936002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTBaQnh3VkovQnptNSttWGFmUHZ4clZHK05aVlJIc0FVQ3VOUzgvRkoxQnhM?=
 =?utf-8?B?ZWtpMEJTRFVaTnlyMzJzMnBJVk9ac0dvRmYzUEU3V3BCb1ZPamRBazNQcTFG?=
 =?utf-8?B?dldJa2tUaERVckthZWY1eUxsQjNGbXdHQXFqS1hmWDB5ZW9jUWRvOGdTWG43?=
 =?utf-8?B?YURUNXRUOFV6ZFc2QlNyaDJBd0ZmUDhZR3ptZ3NLcVZRaWZhVitHMTR2SElM?=
 =?utf-8?B?MDlscFkrbG5kNWJmaXRVS20rMmJMOGpUdDZQbnNRa2VYUVNWaVh2NjdDZTVZ?=
 =?utf-8?B?c01EUzNWM3dkYVgrbnloWjd4d2tmS2ZXTVkrNUJqL0RnWEYrbmZVTUE5dmpy?=
 =?utf-8?B?eHdNTlJ5dHhrbUd5V2hoNUI4N0hreFlkRjB4azAya3lrUEQ5OXBBZUpEWEE4?=
 =?utf-8?B?ckVKRjlUNTNCRS8zZWR2L0llWHppRjN5emFLOFkwdHJpNHVrT3d1MjkxWnd0?=
 =?utf-8?B?UVBqUm5DenVKRlNyV29OTXpVR1pMbTB1NHRtZXo5TGM1Y21CY0lGTXBYM0lU?=
 =?utf-8?B?VjQvMG81ZkxnSzgwYkpiZ3FpMllrVlB4WnNKN3NsWDFDR0UyNXNYQjhoNTFv?=
 =?utf-8?B?YStqQkc2KzNnTUpyTGgwSjBEQXlTZDdGUEFkS1U5OUg4RTYxWTFEVGh5ZjdP?=
 =?utf-8?B?SDB3VjFGc0htREM2bEpXZnArL0F0blRmSko0Mml0NGJ3ZFFFRUpqNkJYT0w5?=
 =?utf-8?B?c1FHVnFZRWU0T0szbCtmV0xBaW9OWVptbzRQYml2QTM4SGh4Um9qbGNCMkI4?=
 =?utf-8?B?a2NhRzZuV2txMlM0S0YrMnFQbFNFcE1HVUJKSS94YzFMdXZhZGpVK3RZYXh6?=
 =?utf-8?B?YVVEQ3Nsbk5mMmh5R1ozVkhwdENUOE1LTStCbEIyNEwySzV2SXVqOW9XNDVY?=
 =?utf-8?B?dTI5VmQzT2tTcVhubkE0Snk4TTNvWmJIb3NjQzQyWUF3OFpqKzlwVDcwY1Vk?=
 =?utf-8?B?TkRuRVl5ZkFNQXNuVm9qZUpUNGJZSVNnOGh3dHpwYm5ZRlVQT25Xc25HeGc2?=
 =?utf-8?B?UmFtcExHK1VjN3AwQ0c4eXBTbGJNTHNkY1VqTldBYVBOaTRBZDRCYXY5UmlZ?=
 =?utf-8?B?U0lRLzM0THJ6V1NqN0VqS216c09mZE1rUm1Eb0tNSmFDT1FmWS9FRnU5bG9x?=
 =?utf-8?B?WnhVUi9XRzh0U3REbWhZREJZWitubFBOSE1lSHVRNUNFRFVtWWV0ZThLMFg1?=
 =?utf-8?B?NlRNZ3lKaXZKQ2VkYXZ5RXA5a1VpUFI5TEpEcGR5Ynh5d01heHcyVTRLQkNh?=
 =?utf-8?B?K1N1M3l1dEN3WVhuUVhPY2ZieEpTd01vajlQTTZ5RHphdDRYWkNiMlJCM1Mz?=
 =?utf-8?B?dXJzWFRNMFdYbFBja3JQYXRhMDVQcks1MGR3TmxWZHhUSHBGcjV5akg1YmR6?=
 =?utf-8?B?YUc2dlJwT1RCcUhXRk1ibjhsZVc3cWdnS01SQ25QRGFDZitpSzhZVlZsQnda?=
 =?utf-8?B?K2JYdE9SR3hzeVpiZXR2RGpBdnl2bytxQS9YejlCOTJGak4rZzBqZUZETVlh?=
 =?utf-8?B?N1hyZXpDSEJKUjZ0MGQ5SGptYUtjZ0FpMzhqRFYwU2Z4b0ZIeWV3UkNQR1Zl?=
 =?utf-8?B?ajlZQmZrQ1Mrb2ZIbThISmJUeUV1OG1ZMjVGTDBuYVo2K1M3cUJiK0MxZUxI?=
 =?utf-8?B?eFhsT2dsVFpYeHBZb0dRWTZzS2lEWGtIREo1L2p2T0l2NVVyOVd5czU4QjJz?=
 =?utf-8?B?WjMxUDJnN1lOUmMxY1BUTFQ5aEhmQWxSWEk1STRseWR4U0p3TmVpbStZMyt2?=
 =?utf-8?B?TDJHYitQL0s2Smx2czFaZnZMSllUQ1V2U3dma3BkRTV2K2hLckUyTC9ZZFk4?=
 =?utf-8?B?WW1pS2hDQlZ2dGRyTWxPU0F2QlJNWTRFOE1TUERXc1RqVjVEMGNGT1paVVhl?=
 =?utf-8?B?MVVrL2crY04yTEU3Yzg2dU8vQzlVNGI2UTlZV0IvU212ZjMyaHdELzNKOFBt?=
 =?utf-8?B?Z2N4Z3JKbk8zL3RTYzJTQkh3dHFUNW9EdkJBeWx4MkROQXlYRFc2NVJDYVdm?=
 =?utf-8?B?Q0hSYkNaVzJBSnpBRE1sUy95NnhxYmtvWFVLT3BPdTViNjBOZ3N2Wmx0TVgx?=
 =?utf-8?B?elkwam1LZ1NGZGpMNHNaaHRHR1ErNjhBZkZZbU1wbmd3ZXNCUHlzTWk0THF0?=
 =?utf-8?B?VjE5YVpGdnFUQm9jckU4ODl6Z21hODdsMnlkcERRQUlkLzNubWtudE93aTdS?=
 =?utf-8?Q?K76jy4IX714Rf/9yYxXUqHc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f52c121-deb7-4ef1-b0df-08d9bb631298
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 22:27:23.8714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APz0/BaWu/Dtk1yKWU2YeBfj55CcRzDbTlmYNz4QUTnGzh8yapkflV46+tbUqqwiG/UZpG6I5UTuDLWUY2TRRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5241
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

Am 2021-12-09 um 5:14 p.m. schrieb Chen, Xiaogang:
>
> On 12/9/2021 12:40 PM, Felix Kuehling wrote:
>> Am 2021-12-09 um 2:49 a.m. schrieb Xiaogang.Chen:
>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>
>>> When application is about finish it destroys queues it has created by
>>> an ioctl. Driver deletes queue
>>> entry(/sys/class/kfd/kfd/proc/pid/queues/queueid/)
>>> which is directory including this queue all attributes. Low level
>>> kernel
>>> code deletes all attributes under this directory. The lock from
>>> kernel is
>>> on queue entry, not its attributes. At meantime another user space
>>> application
>>> can read the attributes. There is possibility that the application can
>>> hold/read the attributes while kernel is deleting the queue entry,
>>> cause
>>> the application have invalid memory access, then killed by kernel.
>>>
>>> Driver changes: explicitly create/destroy each attribute for each
>>> queue,
>>> let kernel put lock on each attribute too.
>> Is this working around a bug in kobject_del? Shouldn't that code take
>> care of the necessary locking itself?
>>
>> Regards,
>>    Felix
>
> The patches do not change kobject/kernfs that are too low level and
> would involve deeper discussions.
> Made changes at higher level(kfd) instead.
>
> Have tested with MSF tool overnight.

OK. I'm OK with your changes. The patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

But I think we should let the kernfs folks know that there is a problem
anyway. It might save someone else a lot of time and headaches down the
line. Ideally we'd come up with a small reproducer (dummy driver and a
user mode tool (could just be a bash script)) that doesn't require
special AMD hardware and the whole ROCm stack.

Regards,
  Felix


>
> Thanks
> Xiaogang
>
>>
>>> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 +++
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 33
>>> +++++++-----------------
>>>   2 files changed, 13 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 0c3f911e3bf4..045da300749e 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -546,6 +546,9 @@ struct queue {
>>>         /* procfs */
>>>       struct kobject kobj;
>>> +    struct attribute attr_guid;
>>> +    struct attribute attr_size;
>>> +    struct attribute attr_type;
>>>   };
>>>     enum KFD_MQD_TYPE {
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index 9158f9754a24..04a5638f9196 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -73,6 +73,8 @@ static void evict_process_worker(struct
>>> work_struct *work);
>>>   static void restore_process_worker(struct work_struct *work);
>>>     static void kfd_process_device_destroy_cwsr_dgpu(struct
>>> kfd_process_device *pdd);
>>> +static void kfd_sysfs_create_file(struct kobject *kobj, struct
>>> attribute *attr,
>>> +                char *name);
>>>     struct kfd_procfs_tree {
>>>       struct kobject *kobj;
>>> @@ -441,35 +443,12 @@ static ssize_t kfd_sysfs_counters_show(struct
>>> kobject *kobj,
>>>       return 0;
>>>   }
>>>   -static struct attribute attr_queue_size = {
>>> -    .name = "size",
>>> -    .mode = KFD_SYSFS_FILE_MODE
>>> -};
>>> -
>>> -static struct attribute attr_queue_type = {
>>> -    .name = "type",
>>> -    .mode = KFD_SYSFS_FILE_MODE
>>> -};
>>> -
>>> -static struct attribute attr_queue_gpuid = {
>>> -    .name = "gpuid",
>>> -    .mode = KFD_SYSFS_FILE_MODE
>>> -};
>>> -
>>> -static struct attribute *procfs_queue_attrs[] = {
>>> -    &attr_queue_size,
>>> -    &attr_queue_type,
>>> -    &attr_queue_gpuid,
>>> -    NULL
>>> -};
>>> -
>>>   static const struct sysfs_ops procfs_queue_ops = {
>>>       .show = kfd_procfs_queue_show,
>>>   };
>>>     static struct kobj_type procfs_queue_type = {
>>>       .sysfs_ops = &procfs_queue_ops,
>>> -    .default_attrs = procfs_queue_attrs,
>>>   };
>>>     static const struct sysfs_ops procfs_stats_ops = {
>>> @@ -511,6 +490,10 @@ int kfd_procfs_add_queue(struct queue *q)
>>>           return ret;
>>>       }
>>>   +    kfd_sysfs_create_file(&q->kobj, &q->attr_guid, "guid");
>>> +    kfd_sysfs_create_file(&q->kobj, &q->attr_size, "size");
>>> +    kfd_sysfs_create_file(&q->kobj, &q->attr_type, "type");
>>> +
>>>       return 0;
>>>   }
>>>   @@ -655,6 +638,10 @@ void kfd_procfs_del_queue(struct queue *q)
>>>       if (!q)
>>>           return;
>>>   +    sysfs_remove_file(&q->kobj, &q->attr_guid);
>>> +    sysfs_remove_file(&q->kobj, &q->attr_size);
>>> +    sysfs_remove_file(&q->kobj, &q->attr_type);
>>> +
>>>       kobject_del(&q->kobj);
>>>       kobject_put(&q->kobj);
>>>   }
