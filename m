Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1F0C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 01:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D38D613A7
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 01:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D38D613A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBBF26EB19;
	Thu, 30 Sep 2021 01:47:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 582ED6EB19
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 01:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6UrdTX+M5BArRHUIgXpk8/KVYkOax1lUDYfGVAusYwOGt/W+2tpWg7l0qv8QgSWl5lW5zYwlh6+/5KQZf1y2eQCxd31hiqi/wdMmPWUrwMqopc9CJLN9vnBE35IhGnW0/mL/hoI+5mBc3APQ++diczwacYdJKxgMErtJ0Of/ufl6qtMWkI7RKW9t1tnMqbvf09b1gtNx1L/FTPEDX2DzZm8dO6ZPclmF56KfBnQv7ghlrPdCqLjFesBE8hA/DIjc4ieXPvv1CAG2GNqsw7f2ZEDX+T0E8J6X7P7F2qAwlynsnR6/T1oAeHmHDKMA0OTYFGzPdCIZTXBO39YEq9xTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=VV4FFNxI7Kf4EYzGLusJGNlknr0JEq+0YeOvNJ5zWBs=;
 b=NiGKHKZ3zA9/iPmOPFoEu0CoycOGfLAGo45MUHghpJ1nskY8csYVPixgY435cB4wgjiREWC33OPrGhN+7pZoYeJPKiwZsJ206gJ8SR3sfpRiubdLk7aSVS0iZDSNuqjaFpRz1k4gCd+6qaKTQ7VrSGSbqYhKDNWSiM945UktCT2uXDCIDpYUA6/+3SoV4WrOjzBI6KF30GXRGueuOmWHWzfaMPe2LfyeH9MZBaptPKYJ8LubysgPUSGbLJQqpVtB7KmLOFVsrdij6/F5JM+I3O/kzePkVy1VY1yTLASLOGLbl8IR5k4t1pluLbdvLbMyed50oVNpHHA0FfhMONJQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV4FFNxI7Kf4EYzGLusJGNlknr0JEq+0YeOvNJ5zWBs=;
 b=boTTvbjZV6aMCEiyubFp957yiHOMReY2aRcqzofNXkGaN//WaUx7hgYlOQEIBVnwytRbViS7kDKuhhI1TsiCW4hlO7CcHNdcKjsiDEJN+Ciep9d2GWtuqhxbtnBMn63RZ81pC/sTfPXCsXZs4yO2y15JFTcRr7YRmJcvwJ9+w5w=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB2481.namprd12.prod.outlook.com
 (2603:10b6:404:a7::10) by BN8PR12MB3219.namprd12.prod.outlook.com
 (2603:10b6:408:9b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Thu, 30 Sep
 2021 01:47:08 +0000
Received: from BN6PR1201MB2481.namprd12.prod.outlook.com
 ([fe80::dd15:b4fe:60de:266e]) by BN6PR1201MB2481.namprd12.prod.outlook.com
 ([fe80::dd15:b4fe:60de:266e%9]) with mapi id 15.20.4544.022; Thu, 30 Sep 2021
 01:47:08 +0000
Subject: Re: [PATCH] drm/amdkfd: fix a potential cu_mask memory leak
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>
References: <20210929082212.1806312-1-lang.yu@amd.com>
 <2ccb1777-ca8e-5a39-5311-3262c1cba608@amd.com>
 <DM6PR12MB425096E4B53642BEA55FDE25FBA99@DM6PR12MB4250.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <10d28f06-42df-6b8e-6e44-a4c85ed92473@amd.com>
Date: Wed, 29 Sep 2021 21:47:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB425096E4B53642BEA55FDE25FBA99@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::19) To BN6PR1201MB2481.namprd12.prod.outlook.com
 (2603:10b6:404:a7::10)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTXPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.13 via Frontend Transport; Thu, 30 Sep 2021 01:47:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10e45511-e1e0-4ddc-6533-08d983b4364b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3219A7CF079A23C6C3140C0992AA9@BN8PR12MB3219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/3V+9MkR9WVTHaAOVcF0tSW9NbFgrV73xgAvM8iDYsbW7pJBT5f6Iu3Dr7QyG3ykPUFx6/5U4MJlfvpRk8Fkzbxd2tgewOJ9LxVEiJuLTHda6OSNOQ5jygYH4+lK5fRK4ysx95aLqBYoskf3k4v9Lm3fM8rtYVQSeBXdbIAV3YH6IgOxbZdNKsFHrYSW9RpOMAo3cEJJhhaaEOGSKIARe6BQnzEUAannNc6782OEJLnx0KlHfyJ/AScXDSAxZtIOFlkQeBsUvp3hzrjDZBHa25jaPbtaYLkCKAPMbX7Ghh/ikD9Xtue3AK3RnpcEV/kv41TqTqv9Oi1LoDk4svgH9CClGPxzyTnGjq9ZXw3WmCoefZTfZZS6yaHxYDH1/CN0Ag/Kvy8HKK6prRYz5d3JcUvj94PTwwdc1BhxiW6loutrc0HdEIXYFM7/5R/2+5XDe+X2XvKRlQteqrXqTE4VZlvEQ2TcHymkvBQKcliHPBsrVgObKBbF0kNcGjtJipYuhhmrUVMfU+39EFm7/BacjB3zrvzvKFBE6VSNibEJrdroWO8HnopMDWc9B/suLNiau0SogLU9hyVfm0PlVOe2Nqr4Igrwk639TUr8wjZp+HtEg5NVyYLXSAW+ZlhjIjsEoM1bGw1C0RYZYzcgWSp9Ysrwgkiad2/wJJgZ+xCYtFSzpqgF+SuOfFnI/ctget4exQYgYe/XYfyhxoIncKAFnb6G8L3yBsmUZ177fgsyPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB2481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(83380400001)(53546011)(2616005)(66946007)(4326008)(5660300002)(8676002)(44832011)(508600001)(54906003)(36916002)(110136005)(16576012)(956004)(6486002)(186003)(316002)(66476007)(38100700002)(86362001)(66556008)(2906002)(26005)(31696002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enV4ZmFuY3U5MmdUQWVKd01wQlB2L0NYUnJjSXM2dHpkTlRtWjM2NnNRUHNm?=
 =?utf-8?B?VHcvNGs0ckIxb2djMUo0NHN0QjVKMXVDMXNQZnpkVlFLTzlXczhPWXlTZm1S?=
 =?utf-8?B?TnZYQkczcyt6MktwZUI5VHMzSUxDS0tVeFhCZHl0eTZDdnVycXlTdFU4TU5z?=
 =?utf-8?B?Q28zYkY0cjQ5ZHFQd3o4OHl1bXh1QndGK2svbjZkRmlqYmdZdVZOVTB2Q3Ir?=
 =?utf-8?B?VWtNVzA0UVhxRXkvajVidjlnYlhta0FpQmVVU0d0TDBjL2pkVVhucnp0NTBD?=
 =?utf-8?B?NjdGZmdVc3pteUdKYmlmTmFVQldKNkt5ZDlYNGE1Nlp5S0JadmRlaEljelpF?=
 =?utf-8?B?aG5JRW03MkRkRlNBY2lNSkVERmY2R29HOEZlVG0ydUhyRjRLRUQ0UmpUMzh5?=
 =?utf-8?B?YWEvTTlDckYxOUhjU1lDZHRVTDJUQWl5czNDZE16dllpTDdtek1rVlBIMGZ4?=
 =?utf-8?B?RDJUcjBibjZqaEZrLzV3UXROdkhLOHFGRXEydFkzZ3RMcC9HcG80SlBNZGZ6?=
 =?utf-8?B?MDc2VlRJR3JuOWRSMVdVUng2SmZBY0hUYlRrRnExUTNobzlqa0JaSlNPNkNj?=
 =?utf-8?B?VWdaellGUmtkdXEwblR6MGpnNmNidVFXYzFqdUNJbUtNTEFSKzZVckl1NUxq?=
 =?utf-8?B?d1B4ODFkbnB6NlVSbHE0S2UrL3NBcG1laG4wZXJQeS9iL01vck5EVHkwSTFC?=
 =?utf-8?B?VVVvcDJicDJ5S1FYOHZPMlNtNEEwSlkzeEZYcVE3TzdrTkhNN1VRck00UWhz?=
 =?utf-8?B?YnNSNVFMTmlrUG9PSnlLVkxON3dDZ0R3SWcvNXk1OVFYV0MyZFAyRzRPVHVZ?=
 =?utf-8?B?WGVHNXZKZzFxZUpJa3NkVmFiODRMRjdIT21Rdkw5b1FLVzBPN0JzMi9KTFZZ?=
 =?utf-8?B?aVhBNExhM3JnS21ZaVhObWo2ZDAzbmFtT25XQUdYMFRuK3FtRk4wSFlXeHNH?=
 =?utf-8?B?dWovM1RJd1NKTFRNczdzSTVWMzg1VGoranh6a0tock5rbDExS2JSb0FhSk4z?=
 =?utf-8?B?MVBoOGFneU8xcWo5K3BvaXg4ZzBhNFVGVDY5KzBieEljR0JsQldUUmJkRDZz?=
 =?utf-8?B?ZUhlQ0RzVEZ2R0twNW1KL3VabWpEVEp4VTBlNFNJQ1hkNldSV2JHbFI0TDll?=
 =?utf-8?B?QkpIUWZGeEJza3FHVXBGOEh0aEpTSnhVWkZ0UGwwT1p0SkcxRXppS25yZ3o0?=
 =?utf-8?B?R3JPWlR5MlhCQnEvOTJ3N09EeEwyNnN5elJPL0pSSG9la2UxemY3UzZTSXhB?=
 =?utf-8?B?N0dya3Fsc29lNlQ4T3RlUEdKdnl3bHJQUTd2Y0d5U2M1T25wdVI4UW90b0kx?=
 =?utf-8?B?aUliYi9kYkJya29rMEI5RFJ2eFQ1NHRMbFdRZCtBSmFyZXFuLy9ibFhZYnlO?=
 =?utf-8?B?dmEwbEZsSlIySlRkemlUaXVIZEEzZktOTzVtTUFvQXFpaStqcGRXMElUeVFl?=
 =?utf-8?B?aVIxeDFUaG54Yjd6d3hHQTRBN244UkZ2OC9EclREcjRVd2dGYTcvUnVwRUdW?=
 =?utf-8?B?M3lncTRIaEhGWGtxU1NEVjAwSXUvQlJMcXV5cVhpQ1djQVVjQmZKNDZhSTJo?=
 =?utf-8?B?UmNkM3E1d0k5WE1aWnloT245emxxQStDY2FlZm4wbXZJdDVucW5TRTJSNlo0?=
 =?utf-8?B?NDkxUWU1dlVHSGoxOVlKd3B0VlppdTZiaUpSbzhsaTQwTHEvdE1laW0wQWhx?=
 =?utf-8?B?TEt2dDEyZXRvWWd3RkluL1M0MEtoMjAyNkNWbDJ6SXM5TkZPQi96VUhXaHI3?=
 =?utf-8?Q?cp31H45x263rrm+Dcv50mLS/OC2EdE83nl88ZKM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e45511-e1e0-4ddc-6533-08d983b4364b
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB2481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 01:47:08.0117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCKIpDyp2pEeSkXsGsYxZavcevYxxS3+yYlBQV4CoNNnzNJhI0d/9EqCKyKBYU4FC3XdmHP5COcuPjRNtOJqWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3219
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

On 2021-09-29 7:32 p.m., Yu, Lang wrote:
> [AMD Official Use Only]
>
>
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Wednesday, September 29, 2021 11:25 PM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>> <Ray.Huang@amd.com>
>> Subject: Re: [PATCH] drm/amdkfd: fix a potential cu_mask memory leak
>>
>> Am 2021-09-29 um 4:22 a.m. schrieb Lang Yu:
>>> If user doesn't explicitly call kfd_ioctl_destroy_queue to destroy all
>>> created queues, when the kfd process is destroyed, some queues'
>>> cu_mask memory are not freed.
>>>
>>> To avoid forgetting to free them in some places, free them immediately
>>> after use.
>>>
>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c               |  8 ++++----
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 10
>>> ++++------
>>>   2 files changed, 8 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index 4de907f3e66a..5c0e6dcf692a 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -451,8 +451,8 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, struct
>> kfd_process *p,
>>>   	retval = copy_from_user(properties.cu_mask, cu_mask_ptr,
>> cu_mask_size);
>>>   	if (retval) {
>>>   		pr_debug("Could not copy CU mask from userspace");
>>> -		kfree(properties.cu_mask);
>>> -		return -EFAULT;
>>> +		retval = -EFAULT;
>>> +		goto out;
>>>   	}
>>>
>>>   	mutex_lock(&p->mutex);
>>> @@ -461,8 +461,8 @@ static int kfd_ioctl_set_cu_mask(struct file
>>> *filp, struct kfd_process *p,
>>>
>>>   	mutex_unlock(&p->mutex);
>>>
>>> -	if (retval)
>>> -		kfree(properties.cu_mask);
>>> +out:
>>> +	kfree(properties.cu_mask);
>>>
>>>   	return retval;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> index 243dd1efcdbf..4c81d690f31a 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> @@ -394,8 +394,6 @@ int pqm_destroy_queue(struct
>> process_queue_manager *pqm, unsigned int qid)
>>>   			pdd->qpd.num_gws = 0;
>>>   		}
>>>
>>> -		kfree(pqn->q->properties.cu_mask);
>>> -		pqn->q->properties.cu_mask = NULL;
>>>   		uninit_queue(pqn->q);
>>>   	}
>>>
>>> @@ -448,16 +446,16 @@ int pqm_set_cu_mask(struct
>> process_queue_manager *pqm, unsigned int qid,
>>>   		return -EFAULT;
>>>   	}
>>>
>>> -	/* Free the old CU mask memory if it is already allocated, then
>>> -	 * allocate memory for the new CU mask.
>>> -	 */
>>> -	kfree(pqn->q->properties.cu_mask);
>>> +	WARN_ON_ONCE(pqn->q->properties.cu_mask);
>>>
>>>   	pqn->q->properties.cu_mask_count = p->cu_mask_count;
>>>   	pqn->q->properties.cu_mask = p->cu_mask;
>>>
>>>   	retval = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
>>>   							pqn->q);
>>> +
>>> +	pqn->q->properties.cu_mask = NULL;
>>> +
>> This won't work correctly. We need to save the cu_mask for later.
>> Otherwise the next time dqm->ops.update_queue is called, for example in
>> pqm_update_queue or pqm_set_gws, it will wipe out the CU mask in the MQD.
> Let's just return when meeting a null cu_mask in update_cu_mask() to avoid that.
> Like following,
>
> static void update_cu_mask(struct mqd_manager *mm, void *mqd,
> 			   struct queue_properties *q)
> {
> 	struct v10_compute_mqd *m;
> 	uint32_t se_mask[4] = {0}; /* 4 is the max # of SEs */
>
> 	if (!q-> cu_mask || q->cu_mask_count == 0)
> 		return;
> 	......
> }
>
> Is this fine with you? Thanks!

I think that could work. I still don't like it. It leaves the CU mask in 
the q->properties structure, but it's only ever used temporarily and 
doesn't need to be persistent. I'd argue, in this case, the cu_mask 
shouldn't be in the q->properties structure at all, but should be passed 
as an optional parameter into the dqm->ops.update_queue call.

But I think a simpler fix would be to move the freeing of the CU mask 
into uninit_queue. That would catch all cases where a queue gets 
destroyed, including the process termination case.

Regards,
   Felix


>
> Regards,
> Lang
>   
>> Regards,
>>    Felix
>>
>>
>>>   	if (retval != 0)
>>>   		return retval;
>>>
