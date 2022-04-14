Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BAFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 18:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA63D10E1BF;
	Thu, 14 Apr 2022 18:04:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DCD010E1BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 18:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhfipNaxt87EGNIJ2JvjuwSVKnbVY7y+yDlVRperkK9376puDtoX0kIW8z+yvUOoX4MicTC6uZ22eLSoqfOxBH5r5yfQKnmtoYEQ1FF6izV+XfDweXcXeKjAn8ThE0P2IbFDXuqjswSJLcsu46Rwc9H1Y5ftmEVFjTgMh8QX0uH9Uv4vp49RLkOqMxqxLkjEN9Sf5WyhMbZqwoQf5Z7Jke21MVTXuj8lzLy1IXjPvEAOitbPG7/kLYdf6WFIZXNxJLbWEEWxvfk3ugNnVxRV/FwPNziIRAuP17hoxK/yJGbh9FC8cBDInzK1FeGWdn3fV/eirjAFtDgEL/UZdkwsTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szAVaQLlDQpAJnQFRaRzF8QTk1MhFOcsC4BstFQv23g=;
 b=AAzCLJH3pob0t5EwqzolUObzN2y+SxY5XtEjVHjnpmUYWbpuMKQk0c4aHIgeqV+B2Xgys27PJ1EXwsEwHSsMmG8IZu/wawOb+dME+mqILqyNUTOFmHPHC/07cJKFsPQEw01Bl1pIZaoHoo/vAiSjg72L2zDVWI0Wzhz006HgBxOEJKJypkdG01RKyS+YzpxVHzuFS6Z7Ihw99UALUEj853r+gJBzenUXhpYX8UPTSCfkJEJ+C7rQ4tPI7C8FRA5PKVPCEZCzI2RUZhNp75MRgVj1Tzoq/0ByD5ISBSCgTREN/magA5A7M5Tmk6yFNoP9Qa7LEQlEZfMiIEf0jEFWOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szAVaQLlDQpAJnQFRaRzF8QTk1MhFOcsC4BstFQv23g=;
 b=BwQ9W6YFU9d7d+te6ofK0RrDuir/i/rNOJFJIMR04zASD8zdTNcL7vPdyw8n6RwCHl1vt4LxtdHebrRYBZWiUpGAStg9x+BPMiARBbQUrxw8QCPkkQMUbXRrYYFoYVQ3KXGa2b7BWa3r81SPCkh45b6C8sjPbpM06qshcGA9HLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CO6PR12MB5395.namprd12.prod.outlook.com (2603:10b6:303:13a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 18:04:37 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 18:04:37 +0000
Message-ID: <45914e25-5fb2-c481-fa25-96fa854f8deb@amd.com>
Date: Thu, 14 Apr 2022 14:04:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] drm/amdkfd: Fix GWS queue count
Content-Language: en-US
To: "Yat Sin, David" <David.YatSin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220413155145.861750-1-david.yatsin@amd.com>
 <e9eb2603-4997-30e1-ce2a-bd3ae0bec7e1@amd.com>
 <DM6PR12MB5021A8149E735B300611A06295EF9@DM6PR12MB5021.namprd12.prod.outlook.com>
 <370d8e9d-7050-e82e-ba46-d9716d023829@amd.com>
 <DM6PR12MB50210D75E67D9ABD0488322A95EF9@DM6PR12MB5021.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <DM6PR12MB50210D75E67D9ABD0488322A95EF9@DM6PR12MB5021.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a450935e-d690-49c8-55c1-08da1e413d06
X-MS-TrafficTypeDiagnostic: CO6PR12MB5395:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5395465CC8B8562D03D7DFE192EF9@CO6PR12MB5395.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zIOEd+Yo5RYo0Nt44RbYcyI1fx0o2yuCfl5e7fViTQ3eV6AHyFeHX2zUswHu+YinkJwW/RjH4IJMKSwX7W7Fy+fo7UfmoPQto7QmVNqnSPpOUCVFlabl62w19fBWvpZdzdPOl61C7Z3KkN93DnQ9OuBVPhk2e77tKQUuCjrVlNp3dXM54JeDrNmJJZeUyWVD8AHfYDNKkxU78apkS/Pkz3SLBQ3nOsqJzmjrMj+DCdZKR1snL+p5GGp2Hw9dOhHxQkg8NA24xMSxxHyuIAaz6bHongXhfVlv6tdKQvYhTiTxTWHTq/V6JM5hjlaP7Wua0L5Kg5p6K71fSLXfeOt1sWAFfhNiyn4HrkHKPveQ8bZkTc3s1Cua3N2VxZFkfZr6mooSIcAjj5IRz1tZTedaBhtNoQafd3QtKv6QTWODLPpFRS7jx62qprlXEq+FOgAwc9qnJs5eUtT5H3xjT9MU0bOm8/VCbEWtS7kUHE5kz7Du1C5l1jbTVTqFTbG7IpG4R9p1yY+zTiaEHJzBMOpx3zfshJcnrNp83g4irQf9EkZqxUKyKJZwXUf946iCxeyoV3Y7/ME3Wusc/9HdPte5hYys6UneeIfR6Ss8jmHxnJlIRQ4kR4vhdzhQ+1SiHY4tmMxSub/4mWXrQUozsWKiSL4wWSSsnpC3yzSwtEIxICav2u+/7U5AikfDdrMA5bsf0WQ+zairjxaulnqqYzaxWkuK2N2SXR0Yd2D/kD3mtK2tRRkyIqBE25OG8Co+OyB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(44832011)(83380400001)(186003)(2616005)(110136005)(31696002)(5660300002)(316002)(8936002)(2906002)(86362001)(36756003)(53546011)(38100700002)(6512007)(26005)(31686004)(6506007)(66476007)(508600001)(66946007)(6486002)(8676002)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTBJNXRjVjU0M0hRaEgzQmZZbGRibWhjQ3dJZ1FTaUw0RVVod1dLb2tvNTV6?=
 =?utf-8?B?R2p3QVVQTkpINnVmbnNDNy9VcW13VUVKQ1pYR0o0QUYzUlRlNExabGFWdEox?=
 =?utf-8?B?V1N2UktkK0RrL1VVQWF6Z2dpdDA3Nlo5TUt4SmdBRWJJZ1g4LzJrb0hlaXk2?=
 =?utf-8?B?cEFDNlMrNjM4dmFQeDdoQmJZb0RINy9lMFUybzEzdnpVQVdkeVJDSGp1UzM5?=
 =?utf-8?B?V1ZNamdwcGxHL3l4SzdCd3FYYWpxZ0JYdkdGREhhVzlSWnhBbkJXMG0wN3Ez?=
 =?utf-8?B?UGdlR3Evd1U5UjNLc0cvOEdNU2w0aXIvRnR5R3FNQjFBeTFWeFRNNllzcHpG?=
 =?utf-8?B?ampvcUJXbVlzcWhCTUxkZk9wMnJhNW02UkxpZ0gxNlVnTXJIUVpuYnArWnFP?=
 =?utf-8?B?SGdHOXBJY2MxVFRjTnBMNjlIeC9EM3g1ZjJSQWVmSXZYU1o0dFVtdUxON0ky?=
 =?utf-8?B?M0J1bTBmNE9QTU5vOGlSaEdieHg1c3p5Y0MxSWUwV1ZrV0VYZEVqbmFCMFli?=
 =?utf-8?B?dFRoRk1BL3ZwUThFbGFHQ0lMQWJ0VGlBMDVVdEJiSkQ2VDMzTHBoeURrODZq?=
 =?utf-8?B?K0lFR0JuZG1tY2x2ajBMQTcwTDhSRG5PTitGMCs2c2dqSi9hWktQVHlVaGFo?=
 =?utf-8?B?eDV3MEc4Rk9QYjhOaTZHM1pGK0pXM29wQnAxWWJHRDB4NUFCYjNycWhiSUQ0?=
 =?utf-8?B?YTNCNjQrV0Q1U0dBZk02cHZtam9tS05Rb1I5QkpwNHJ5b0ZLaE9heWVhM2hU?=
 =?utf-8?B?N1JkNks3WkdnZkJ4V2pIcXJXaTVIdkJVNVNRNkxGMUNHek1aT1h2V0p2Z255?=
 =?utf-8?B?OFE2cGRRSHYrSWFMcGJqWXNXbWlMbUlobEgzNHVEOHo1UEI5Z3VWZlZNK0Za?=
 =?utf-8?B?aDlzT1BlRlZZdzIwcHJPaiszbGhka0dpR3NjVU9tUmYrNXBqdlNoSVdWcnNU?=
 =?utf-8?B?Z3N5UllDQUd6U3Q1V3FjL0pUOE05WVRMZVRUS3lQMzgvaThva2s4NG5wRlgw?=
 =?utf-8?B?c0pENDFLMk5KeGQwTVY3NFN1R0Mvd084emZFdWZuUUM4bUNTUzFubzlqSnZw?=
 =?utf-8?B?MzVIU0JhVkVaSVFLVDUybHpNUGJDWnc0TlFJd1poMDVia2FmeXJrKzdaMHk4?=
 =?utf-8?B?QjNkemcwTzJ4clM1MGVJQlhVZ2JJOE55WnJ6NjBZejNzRWExdnlmMDVvc3VD?=
 =?utf-8?B?dGVpR0NHdmdXY21aZTJyelg3eXhPNGlmRFZuSUZ5YWZiaHQrbHZnSGJ1bmg1?=
 =?utf-8?B?SS9hUko4cUFGTVZnaFdlL1BVcDViV0ZmL1Z2OERZbEdqVnR2RjZUWEdmaDNz?=
 =?utf-8?B?QmVTT05UcCtlVmg4ZGp3azljSFlLNGdaTFBYUDNaWmgySmVlaGltK0FHTGZX?=
 =?utf-8?B?TTh2SFN4S21qYUYwRTFtMFY3N0JESjNxOTNLUUMxdllIdGFmRFEzQ1NzcEpU?=
 =?utf-8?B?UWpqNzBiZG1PblFOa3Zjd0x0VkZqaTlRNENrdjJEdnJXdE9VYmNOV1hIemty?=
 =?utf-8?B?Z0ZqQS9xRG0rVStZaDNrbS9SWmphR1E3V3M1Z0V3bzJQUVdZcE14TzB5OERW?=
 =?utf-8?B?UmIzTExta2JuSVVROS9VN2s5ejBSQUN1cHdQcFdpTFU2eEptcndnQ0hrdXM3?=
 =?utf-8?B?VnZZdWlpSE9CNWR0azJSRDE5QytNbGk3WDZQOWNwV1k3L011ejdmZHF3SGpB?=
 =?utf-8?B?REdORXE5WFc4bll5VkY4ay9GUklHWGc1dTNWYlpGdnhoZTQ3MnRZeXUxUVFV?=
 =?utf-8?B?MThVY2RTWmUxWTdVZGZ2d0l4MlJSVDdyclNicC9uN25Gd3dhTU5nUGs5Ri92?=
 =?utf-8?B?SmxBNVNtUlRSUTlzUTg5N0o3M2lxd0xlSXVhNFk2a3ZJNU1YdXBNSE14OVRl?=
 =?utf-8?B?M2p3dWxNeDVsT2tXeUg5Y1UyLzJVK0RxeUpoWHJvTk1lUUw1bzllUTVCNEl1?=
 =?utf-8?B?cmxCYTNlOTVDVnNOM0RjclN4WFN1d1pudUxyazUyVGJjZlpTUXpKUWVwdVNa?=
 =?utf-8?B?dmdDTSs2V1RCMWxiTzN4VkRxQmdYYVpGMU1NbG5ucU5WYXo0TWZqWFJyZGJu?=
 =?utf-8?B?TWFGV0k1TWpWMUVNckhMbXg1NVhGUEFLSFNJT0lOVXBzSENKcytuSVBNMmJY?=
 =?utf-8?B?TExXajNha2dDMFJRb2hOUUxkcG5lcGRXbXFlclJmdm9XUGw3d2svNWxiYVBL?=
 =?utf-8?B?NDJDWUJyWWYvN0IrcDhGQlZPUHE0TFMweW90SkNnUlR6aUl6eDRPZXZwd0Ny?=
 =?utf-8?B?emsxSEJTRi9GRVJsM3I2WjRoWXRwQ0krK3A5L1JiSzFVNmZQVUFqUzVaQkJD?=
 =?utf-8?B?UEUrQnMwV0RQS3RadXozSmRZQzh2R0M3OU8wZ25MQzJkcWlPNFF0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a450935e-d690-49c8-55c1-08da1e413d06
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 18:04:37.2816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7A6i9fnNKY6s13vE7dB1HSXFc7jQObYvhKWNkjr0RZo7xs12S3VLpmlGq1MekUpQtO4ROrb+TbuCPYFbIzOFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5395
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


Am 2022-04-14 um 13:56 schrieb Yat Sin, David:
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Thursday, April 14, 2022 11:42 AM
>> To: Yat Sin, David <David.YatSin@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 1/2] drm/amdkfd: Fix GWS queue count
>>
>>
>> Am 2022-04-14 um 11:08 schrieb Yat Sin, David:
>>>> -----Original Message-----
>>>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>>>> Sent: Thursday, April 14, 2022 10:52 AM
>>>> To: Yat Sin, David <David.YatSin@amd.com>;
>>>> amd-gfx@lists.freedesktop.org
>>>> Subject: Re: [PATCH 1/2] drm/amdkfd: Fix GWS queue count
>>>>
>>>>
>>>> Am 2022-04-13 um 11:51 schrieb David Yat Sin:
>>>>> Queue can be inactive during process termination. This would cause
>>>>> dqm->gws_queue_count to not be decremented. There can only be 1
>> GWS
>>>>> queue per device process so moving the logic out of loop.
>>>>>
>>>>> Signed-off-by: David Yat Sin <david.yatsin@amd.com>
>>>>> ---
>>>>>     .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c    | 12 ++++++-
>> ----
>>>> -
>>>>>     1 file changed, 6 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>> index acf4f7975850..7c107b88d944 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>> @@ -1945,17 +1945,17 @@ static int process_termination_cpsch(struct
>>>> device_queue_manager *dqm,
>>>>>     		else if (q->properties.type ==
>>>> KFD_QUEUE_TYPE_SDMA_XGMI)
>>>>>     			deallocate_sdma_queue(dqm, q);
>>>>>
>>>>> -		if (q->properties.is_active) {
>>>>> +		if (q->properties.is_active)
>>>>>     			decrement_queue_count(dqm, q->properties.type);
>>>>> -			if (q->properties.is_gws) {
>>>>> -				dqm->gws_queue_count--;
>>>>> -				qpd->mapped_gws_queue = false;
>>>>> -			}
>>>>> -		}
>>>> This looks like the original intention was to decrement the counter
>>>> for inactive GWS queues. This makes sense because this counter is
>>>> used to determine whether the runlist is oversubscribed. Inactive
>>>> queues are not in the runlist, so they should not be counted.
>>>>
>>>> I see that the counter is updated when queues are activated and
>>>> deactivated in update_queue. So IMO this patch is both incorrect and
>>>> unnecessary. Did you see an actual problem with the GWS counter during
>> process termination?
>>>> If so, I'd like to know more to understand the root cause.
>>>>
>>>> Regards,
>>>>      Felix
>>> Yes, when using a unit test (for example KFDGWSTest.Semaphore), 1. Put
>>> a sleep in the middle of the application (after calling
>>> hsaKmtAllocQueueGWS) 2. Run application and kill the application which it
>> is in sleep (application never calls queue.Destroy()).
>>> Then inside kernel dqm->gws_queue_count keeps incrementing each time
>> the experiment is repeated and never goes back to 0. This seems to be
>> because the sleep causes the process to be evicted and q-
>>> properties.is_active is false so code does not enter that if statement.
>> That's weird. Can you find out why it's not getting there? In the test you
>> describe, I would expect the queue to be active, so the counter should be
>> decremented by the existing code.
>>
>> Does the test evict the queues for some reason? is_active gets set to false
>> when a queue is evicted.
> Yes, the queue is evicted because of the sleep() call in userspace.

Sleep() shouldn't cause queue evictions. Evictions are usually temporary 
due to memory manager events (memory evictions or MMU notifiers). More 
permanent evictions can happen after VM faults. Does the test cause a VM 
fault before the sleep?


>
>> Looks like we're missing code to update the
>> gws_queue_count in evict/restore_process_queues_cpsch (it is present in
>> evict/restore_process_queues_nocpsch).
> I think this is the actual problem and the increment/decrement should be done there. I did not realize the dqm->gws_queue_count only counts not-evicted queues. I will post new patch with this change instead.

Thanks,
   Felix


>
>> Maybe the management of this counter should be moved into
>> increment/decrement_queue_count, so we don't need to duplicate it in
>> many places.
> ACK
>
> Regards,
> David
>
>> Regards,
>>     Felix
>>
>>
>>> Regards,
>>> David
>>>
>>>>>     		dqm->total_queue_count--;
>>>>>     	}
>>>>>
>>>>> +	if (qpd->mapped_gws_queue) {
>>>>> +		dqm->gws_queue_count--;
>>>>> +		qpd->mapped_gws_queue = false;
>>>>> +	}
>>>>> +
>>>>>     	/* Unregister process */
>>>>>     	list_for_each_entry_safe(cur, next_dpn, &dqm->queues, list) {
>>>>>     		if (qpd == cur->qpd) {
