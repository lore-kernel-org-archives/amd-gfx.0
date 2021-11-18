Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7260CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 16:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E8BD61A6C
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 16:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E8BD61A6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B89546E9AA;
	Thu, 18 Nov 2021 16:39:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 732FF6E9AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 16:39:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkQq93GPh09AYNzN1F8ccyDGEtdZcG5pzTQwp9k9anOQkdcYEFSXytbaQAVPsnyH/cUPi+XVhc7V/fm+4biY0CjGIrbZ6KpcIrdq5BP3X1XfQaVpMOwomrzNx4QaNx6h4iesiQWV5onYvcPMxe4b8xQm8tH67gZ1Cai7HjyF0lrrGgRn4Ilk7xrTzdV0gFuIOqEOazrsuz2zz10ZZ/hIXkXygZAgWec0MVMCxUAvGo39jBVi+s6cJ8nfZxAS1gf4xBrskibrX2uzN7CFkHnXOKddrep089bIzHdqz7CjavLZfgE1jrsIkWidFs3tkvZXceqUTavv1X40Sslhpb5z+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TqWvTeRrRvv7KvdjvXxYwUDQ8Ni1w/Z42p5dJq53as=;
 b=YwaSb4a9xC/xOtIc/yFJLVGXOpnZ/EU9bFMCnEfUr2rDQzG7hiUfZ16tLUOW4HNdDZceCdmpv/hq9fFJ+EYRK4NX+YwAvbNzB/ZjfIfpZZcxRvDtfetBs+pl6asuFDN9qz4xeaZ5Row76zGt0NPhvwYrGM6jLmIHzkNknjvt42RRdo2EWTwgweafDUjg095LpNavJKBGsLc2KH0v+i9ArJQgjUm9q71Q4Zv1quPVNJqXOiFrBNu9PTScgk0fkb+/rVd08VsCquRpkqvI+84Am524KeoN666O2JLrSmsUFXEo2Chnre1cjfmHALnNw6F/tyhioJL+rMWRlwwd17RU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TqWvTeRrRvv7KvdjvXxYwUDQ8Ni1w/Z42p5dJq53as=;
 b=RYxFRDuOMBPyFStXL+zjqnjllVsQ1OFclcLCsUw66ffv1JJ7nQCZNBlJrvEN+PIVrcIWYEuYD8ZYrxXy2uC6yRgiX1W6gP2XeIEZs0Y6hupET543e+qtiK5ldgAPgtiuxZ+v/XeiaTZ7oKm8q8sttOHhnV0qo+yLepUuqas+KTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5241.namprd12.prod.outlook.com (2603:10b6:408:11e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Thu, 18 Nov
 2021 16:39:18 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 16:39:18 +0000
Subject: Re: [PATCH 3/3] drm/amdkfd: simplify drain retry fault
To: philip yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211117034324.4663-1-Philip.Yang@amd.com>
 <20211117034324.4663-3-Philip.Yang@amd.com>
 <71b8c251-97f3-3064-7861-d2bdb24b6ae9@amd.com>
 <eac293ce-bbf5-fe59-a12c-b0113e64f66e@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <423b2831-ba9c-3239-574b-ae3ac8ebb112@amd.com>
Date: Thu, 18 Nov 2021 11:39:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <eac293ce-bbf5-fe59-a12c-b0113e64f66e@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YTXPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Thu, 18 Nov 2021 16:39:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46856e8d-aeff-4372-1bff-08d9aab1f738
X-MS-TrafficTypeDiagnostic: BN9PR12MB5241:
X-Microsoft-Antispam-PRVS: <BN9PR12MB524159E4CCE6CC9363D275E8929B9@BN9PR12MB5241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sqoH0iIaNpxqK3kBsHYp3ZziJ69Xejdh/wWDnsy8fRtAg5IHm4niFXF44VEanWdu+G6FHaBbU0d9h1F8njpSCNugzu5WBHwpZCK0g+EGtl2tuUWK/5uCle9+lm2EQ5gADrbk7G9+X/C7vAICx66pq5ZAvKI3C/Bs93jeh7afc1svXZKpKQZciQR5hkPOUpINPfdW2jFKD0JYsZxWaJNJhju7fWLnlIs+9JSMkJ5e4DEbpEPCkV2AdoichXgFjx5cXnuYdy0ZGn5yvVAQ0FP0i2SbDU4KwDILYBTsc5tMVDy1ZWP5zchJrjWYl6mncdEpN/ANSmHiHPXxhS5+bwcNgDRc7+R0oX/TIhHbVCtDYUhzHGXyqUlFgP05P7XLHTPYmNwZ9vf3KP6XTMWOTeP9htlyfVXsm4pb6hPvOLCDUpehbjZHow4LtBAr2VIw3Mp0lKKsxlmCWYrbg8bJ/1f+oi+cK4xk9bHFHid/bdx8LVES9YD3xOvdf5N/cvc3BrednHvn6YVosZ927c4wJ95onyU/q5rJqZ2o/Br+m0SqETESB9Z+xeOoHNQRtgkScTMWWstKExnO4PKPjELHcD9pG6ZRDFPSGq0gdzwh+vYQmnOrChDfSyU6ne/zb1FA1zLsrBgHonNg28HQcFBIVWzkX4IwltC7wnJ4lMrJkmvhM0yxyk6lbvDWjmN+udHglMc4z5nxQW/jiOr6tt2jDNSo5towKO2M8EnbBAV9FLxHR//l8LS+o9dWMPSXQ3IqhB6u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(186003)(316002)(31696002)(31686004)(956004)(110136005)(66946007)(508600001)(2906002)(16576012)(38100700002)(66556008)(53546011)(36756003)(44832011)(2616005)(8676002)(66476007)(6486002)(8936002)(4001150100001)(83380400001)(86362001)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Kzl0N2MvcGx6UWJRdnptbng5amRWSThSWmtCQ3E2UHA4UjVMM3V0TENoQ1pE?=
 =?utf-8?B?Z0hqeW1sNkdoZWRKakorQ2lYVWVEb0E3UG5nUG1qUEl4MVpxYmlONDhlMlFC?=
 =?utf-8?B?SVZ3aFJzd1lGNWFJVmNrWVJ6UHR6NHFXZlVxR0VMUUg1MkxWMy9hbDk2cHZ3?=
 =?utf-8?B?UGllcWhVZWprcXg1NU1NaXpsQzBSbDltY3lFU0FVNTBOQnQvNDlIRUdlcVZ5?=
 =?utf-8?B?SGpwM2xRTFJOZDJHOFhqb0VONFBGYlJYL1hncGFvemlYcEtkTU9abzhXOFZP?=
 =?utf-8?B?ekhaWEk1cGZrVGlPa2puVThOYjBpY1gybjVPbjJYbCs5VkszNzZSVE02YkN2?=
 =?utf-8?B?bElhb2k2eXV0U1BsNW11RUhwdVNQc0tuVFVZbXZ6NmkvTkIyM2E5cURLWWt6?=
 =?utf-8?B?ZUpZaTgrbzJyeW1HT0UzbHJSN2FteHN2NjJGcXRuQ1hLTVpqNWpDWHZQc0t5?=
 =?utf-8?B?K2NSY0VUcjg5VTc3K3ZnaTZFaGJwREZFQmNMUi9oUUg0eUIxM3ZqMzkyU0xR?=
 =?utf-8?B?c1Y4T2lqamZPaDQ4ZjlwY3kxTTZ0M3BTOTZnajZnTlRSd044U1hzamIvUVZ2?=
 =?utf-8?B?YW83aEozOWgwMXloK2NFdmRUUWIyOVdTcU93RWFqblkweStKNTV1eW9BeUhN?=
 =?utf-8?B?K2VpamhNQzdiaVZISkhqUXEyaWxiZGlTcHZUTjNYN29MTGsyQ1lOSWFSMlFQ?=
 =?utf-8?B?T2grd1ZodCt2R1NMdVlPNVBFVlUyQk1Mb1NLRlpjRTI3QTlFaW54V0F6NlBz?=
 =?utf-8?B?NG9ZUVZ6bVlTQXZjRWlkOUJmd2d1d2paS0ZsUmtQUU1Tek4vWHRGWlF2Q1lF?=
 =?utf-8?B?Q2xCYzA5cEx3Q3ZxK0ZoejUrN2ZiMzVQdHRQVElVanZDRzlJV2cvcUpkczNY?=
 =?utf-8?B?MksxQ1VSV3hXTmY1QVRMcjdKdHdmZXhPYVh2NkJhdjNya055Sk5heGxObkFp?=
 =?utf-8?B?Qm4ydVNwMWE4TzFaZFlPcVNCa2FzU204T1ltV3lxYUVGNGVic3Q4aFNhdnBD?=
 =?utf-8?B?QUM2eVp1bktOQ3V5czlCTkFlQkYxMzQwVWsxTnFkUlBKTHJpSFRwNWRNcUE4?=
 =?utf-8?B?dWdyQi9MaFBONXFDcFV0b1k3OUtTSDRuQmJvQ0lLQUIvRXBaQzBTanhwS2Ur?=
 =?utf-8?B?NE1VdzdIV3dyeHFpRXU1UVBkOTE0SnpxSkkwSDN1dWU4WG1kd1pjOGNPQkl3?=
 =?utf-8?B?VGZ4UXhQV2U1YVBYU2pFT1gzRUdTRTREbXBlSVBEOERMUXl3WmlCYkNwQWlN?=
 =?utf-8?B?NSsxQ1FjZzJLS0Z1bDZMV0FoSnk5TjBpRVpPeTdzTithNktHcmIzcm5aNGxF?=
 =?utf-8?B?d1NGQXFpWjVzbkF4UjJaVCtrczV3TkNDL25lQ3I2WFIzMHpPT0JtSUlGWXFp?=
 =?utf-8?B?YldZajg2K3V4em9KN0J4eHBzOFgvQUpDY21RZFFISzlid2hiLzFHaEZyOE5B?=
 =?utf-8?B?QVdLMzY2bDV2WUZqQ1dnUTNQZTRpTm95SUU4YlpQN2RTL1VlUy9HYWtzZjZ3?=
 =?utf-8?B?YjkzMmY1VUV5ZW42UnVMNnFWVlFRSXQ4dThnVmdybUNoZzVNbUt0c0I0RGoz?=
 =?utf-8?B?ZTJJdGp0MmVVUlQvYm1DYzZweW1TNTFRSjhQWTBoclBnMEdxdHJGMXRGNzlF?=
 =?utf-8?B?NVdjSUZscmJBMWxtS2FtY0UyTGUwVVF1bG4rNU9kWFhCSGR5VTk4RUFaZ3Vp?=
 =?utf-8?B?a05KQUdpK0dudStEK1UwdzA3YXZ1UllhNHJuWFFhZ2dCRGRoL055N05SNWdF?=
 =?utf-8?B?S25hMGFGZkVqb3BKSWVCaWRDcEpDVkNBNnorODhncFRibnVoL1hycUNUWlJa?=
 =?utf-8?B?ZDYwaGZtQ0N4ZDBBZFVnNDBrNm1wMFFtRHYxelZ1UXJNUTV0TTUwWG4vNDZS?=
 =?utf-8?B?SmVFbmNaQnl1S3c5Z1BUUzRJUEk4dGVaRDdWVUtjUjJ4bzNFcTdjeWVSci85?=
 =?utf-8?B?RERJNXlUbm12SDRqODBYdnlYT2FMOVlvdGU3bHZQWjJLQk15QndQTVZDMVk5?=
 =?utf-8?B?TzUxSjlseFRXWkdxOGJZNW41VDk1bEFxdVdUNWpFRjdBWnFQRGRKaE1hVk1F?=
 =?utf-8?B?dGFXQWFkQk5weEdNaHRuck5wSVZGUStNRjFVV2ZZT08xcERkOXp2b0ZySlNY?=
 =?utf-8?B?L21ZQ1RJTVcrdHRPdjkzOW9JdVJZQU1sY1ZZeExMNUlmMnA4bTMzVStmem9E?=
 =?utf-8?Q?MOUEa5yZDe8+2AREM5NGCl8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46856e8d-aeff-4372-1bff-08d9aab1f738
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 16:39:18.6006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: og0KAYATnMUHBosvEz6mE5e8OlZ0Wz9/2E7djzYZvnPPZc9RvVY238tlT9Ei6EyPtVFcDXbUlbEInNCfHWP6Xg==
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

Am 2021-11-18 um 11:19 a.m. schrieb philip yang:
>
>
> On 2021-11-17 7:14 p.m., Felix Kuehling wrote:
>>
>> On 2021-11-16 10:43 p.m., Philip Yang wrote:
>>> unmap range always set svms->drain_pagefaults flag to simplify both
>>> parent range and child range unmap. Deferred list work takes mmap write
>>> lock to read and clear svms->drain_pagefaults, to serialize with unmap
>>> callback.
>>>
>>> Add atomic flag svms->draining_faults, if svms->draining_faults is set,
>>> page fault handle ignore the retry fault, to speed up interrupt
>>> handling.
>> Having both svms->drain_pagefaults and svms->draining_faults is
>> confusing. Do we really need both? 
>
> Using one flag, I can not find a way to handle the case, unmap new
> range. if the flag is set, restore_pages uses the flag to drop fault,
> then drain_retry_fault reset the flag after draining is done, we will
> not able to drain retry fault for the new range.
>
I think the correct solution would be to use atomic_inc to set the flag
and atomic_cmp_xchg in svm_range_drain_retry_fault to clear it. If the
flag was changed while svm_range_drain_retry_fault executed, it means
another drain was requested by someone else and the flag should remain
set for another round of draining.

Regards,
  Felix


> Regards,
>
> Philip
>
>> Regards,
>>   Felix
>>
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  1 +
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 24 ++++++++++++++++++------
>>>   2 files changed, 19 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 1d3f012bcd2a..4e4640b731e1 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -767,6 +767,7 @@ struct svm_range_list {
>>>       spinlock_t            deferred_list_lock;
>>>       atomic_t            evicted_ranges;
>>>       bool                drain_pagefaults;
>>> +    atomic_t            draining_faults;
>>>       struct delayed_work        restore_work;
>>>       DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
>>>       struct task_struct         *faulting_task;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 3eb0a9491755..d332462bf9d3 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1962,6 +1962,7 @@ void svm_range_drain_retry_fault(struct
>>> svm_range_list *svms)
>>>         p = container_of(svms, struct kfd_process, svms);
>>>   +    atomic_set(&svms->draining_faults, 1);
>>>       for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
>>>           pdd = p->pdds[i];
>>>           if (!pdd)
>>> @@ -1975,6 +1976,7 @@ void svm_range_drain_retry_fault(struct
>>> svm_range_list *svms)
>>>           flush_work(&adev->irq.ih1_work);
>>>           pr_debug("drain retry fault gpu %d svms 0x%p done\n", i,
>>> svms);
>>>       }
>>> +    atomic_set(&svms->draining_faults, 0);
>>>   }
>>>     static void svm_range_deferred_list_work(struct work_struct *work)
>>> @@ -2002,6 +2004,7 @@ static void
>>> svm_range_deferred_list_work(struct work_struct *work)
>>>        * mmap write lock to serialize with munmap notifiers.
>>>        */
>>>       if (unlikely(READ_ONCE(svms->drain_pagefaults))) {
>>> +        atomic_set(&svms->draining_faults, 1);
>>>           WRITE_ONCE(svms->drain_pagefaults, false);
>>>           mmap_write_unlock(mm);
>>>           svm_range_drain_retry_fault(svms);
>>> @@ -2049,12 +2052,6 @@ svm_range_add_list_work(struct svm_range_list
>>> *svms, struct svm_range *prange,
>>>               struct mm_struct *mm, enum svm_work_list_ops op)
>>>   {
>>>       spin_lock(&svms->deferred_list_lock);
>>> -    /* Make sure pending page faults are drained in the deferred
>>> worker
>>> -     * before the range is freed to avoid straggler interrupts on
>>> -     * unmapped memory causing "phantom faults".
>>> -     */
>>> -    if (op == SVM_OP_UNMAP_RANGE)
>>> -        svms->drain_pagefaults = true;
>>>       /* if prange is on the deferred list */
>>>       if (!list_empty(&prange->deferred_list)) {
>>>           pr_debug("update exist prange 0x%p work op %d\n", prange,
>>> op);
>>> @@ -2133,6 +2130,13 @@ svm_range_unmap_from_cpu(struct mm_struct
>>> *mm, struct svm_range *prange,
>>>       pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx
>>> 0x%lx]\n", svms,
>>>            prange, prange->start, prange->last, start, last);
>>>   +    /* Make sure pending page faults are drained in the deferred
>>> worker
>>> +     * before the range is freed to avoid straggler interrupts on
>>> +     * unmapped memory causing "phantom faults".
>>> +     */
>>> +    pr_debug("set range drain_pagefaults true\n");
>>> +    WRITE_ONCE(svms->drain_pagefaults, true);
>>> +
>>>       unmap_parent = start <= prange->start && last >= prange->last;
>>>         list_for_each_entry(pchild, &prange->child_list, child_list) {
>>> @@ -2595,6 +2599,13 @@ svm_range_restore_pages(struct amdgpu_device
>>> *adev, unsigned int pasid,
>>>       mm = p->mm;
>>>       mmap_write_lock(mm);
>>>   +    if (!!atomic_read(&svms->draining_faults) ||
>>> +        READ_ONCE(svms->drain_pagefaults)) {
>>> +        pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
>>> +        mmap_write_downgrade(mm);
>>> +        goto out_unlock_mm;
>>> +    }
>>> +
>>>       vma = find_vma(p->mm, addr << PAGE_SHIFT);
>>>       if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
>>>           pr_debug("VMA not found for address 0x%llx\n", addr);
>>> @@ -2732,6 +2743,7 @@ int svm_range_list_init(struct kfd_process *p)
>>>       mutex_init(&svms->lock);
>>>       INIT_LIST_HEAD(&svms->list);
>>>       atomic_set(&svms->evicted_ranges, 0);
>>> +    atomic_set(&svms->draining_faults, 0);
>>>       INIT_DELAYED_WORK(&svms->restore_work, svm_range_restore_work);
>>>       INIT_WORK(&svms->deferred_list_work,
>>> svm_range_deferred_list_work);
>>>       INIT_LIST_HEAD(&svms->deferred_range_list);
