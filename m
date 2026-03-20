Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8AA108B8E7
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 10:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F5BF10E197;
	Fri, 20 Mar 2026 10:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GpRMqa6b";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013024.outbound.protection.outlook.com
 [40.93.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C11510EAB8
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 10:02:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYyylfUUn8H3r1/Ko8lg9C/F4whm7Azgl6TSD3sdEPvfYHMkq3hs64uDSJJNGp4Hj6pDomimSeU7CMRR5e5vWU5TX5KDcLejxb4eCMUPEsIPEE29pHengB56wAO3tmcggOl1UqZPg2Qh+rUELv6H7CGlz+oOYmC3fn/toJjsl0vOnje1IPsbqdn+fEfVgw0EiL3Du7O/MlS/ZyBiVWpo7yJoCxCmcSM7bsR4vOI4qfA2veoCcIUDpiBMQEd86pfslhO8OETdsO6aP256e6asx+0S+sPbP/NDIOzNFKQdx5vr7AsY/Yph5asjPXSTKZIdKG/1EFfytPNo08dQEtrJig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1+WRWknh9teH76Tz3iPVNAhPRF6mojr5+JfF0lqx/Y=;
 b=Zwtn/5Xf865Ls7KYd49px1MwjSo4zT/9nTM/U1gCqO9CDj7I9j5jHLucXYj6tarw1ba0FCmJmvi5Fj3F+pPVUGLxFG2quUmESprkBlk6FhW4gUiAdB0d5zFMupMbrI9ptWQtRCsVzlITHdLhtaY549Mtn14Udeh3XO9stgk+0ZV6tlh3SfY1ph5i9XRgWxE3prZoXeB5Jm2vp1PyRBkmGt+DpA6WyIiBoFtLDTpdW3Ejr/lcdrQvJsh6VKV1nUVgdBYhBIKbO0bqanFSdjz+ZFsx91OoLufzHecHFPuVV8IbYE9SSmGAInTZWiyigf0GYbaoPefCh+0yfhx0SoILyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1+WRWknh9teH76Tz3iPVNAhPRF6mojr5+JfF0lqx/Y=;
 b=GpRMqa6bL8xiUhAj7QvKr3ZYP6sRpGnK1emeja9kSzdV6ZCK61n0LHkOjIrluM9r4AgUJoE0e1fHyxv48Q/SHlCQodFh556gmP9Hdy8j8QB/qAJyMwKDVlWS1tjStf3pi0Sh5w8Aw7oIxbcI7a5GYnjeb8aqJhXTWuyfp2MAYq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by SN7PR12MB7154.namprd12.prod.outlook.com (2603:10b6:806:2a5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.14; Fri, 20 Mar
 2026 10:02:41 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::2c4e:287c:8da1:4be5]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::2c4e:287c:8da1:4be5%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 10:02:40 +0000
Message-ID: <21c8b934-7973-47f7-9a13-77c7b18530d2@amd.com>
Date: Fri, 20 Mar 2026 15:32:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: add mutex lock/unlocked version of
 amdgpu_userq_put
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Liang@rtg-sunil-navi33.amd.com,
 Prike <Prike.Liang@amd.com>
References: <20260320094111.3640176-1-sunil.khatri@amd.com>
 <df195a01-e228-4f14-9e20-ecb63dc9d653@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <df195a01-e228-4f14-9e20-ecb63dc9d653@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::12) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|SN7PR12MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: 65456d91-d8c0-486a-ed00-08de8667d230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: EtTd2YKiio5Z0jpyUJFB3fPrHJuLCtSi8e+V31ZPNFEfG1j4/UXGklAyoBT1iw1a9z8JWjnDyGrokv3Oyl6nAdE1GL0O1uz9+Mloe25bJh+/P1TUhT7+/XXB72EYXKEi1pGRKbXYKgZ0k7OOtj8Qg7SXmyhvasfCj1mc5xTt5LI4Z0PnvlxsEOkdcMlmxQaAXOqCZWt+WiqOlbZi0GVur5J+vx3O1vYL20fpMrqR3ikJxEABIRUZcjKHFUYnlqKXwqxdhOYPVbhAdxuU+hmTXnueQQCJCHlBTJzGptQeOXgBGRmZCiWpZOlvxCkag/N7ZUhUWcYNRggsXEb4onUXV2qM6fSy8SUKJ9Iek+P+TvDBj6lv9wPTmArRPFKo1LJSE981yfF8pfZc6upVv6+dxt/sYnO4ckEuVI93OeWDPJCDe5ciuUeJMQ/4NrgKC8CfKi4bVFWKDNRxzu9+a7WDM7g0b6auwfxhOJaHM9E3CnWOhrmiTHvNASKY6XRwCFweavUabf4dRkCSOLUKOFqAEbAsKSqxoJUaE1cUgkGK4ENsLsh49UttInVKvspaUmPpYeKbjZCKQrmV+T5KNvwQ4KMDG1XvpckehjdfyA+XNiUXXkQmopUmDUsNZdyH88RADLqtx9KgxO5DxxY0BFYdRxLuCqPNx3UZVLjzpjpRhBVanOEBhsupZ6TU7SAmBxl4ez6QA83z5MUPmWdcGAcsfjgfuGkzj+sjX2SKYJPZhlI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cno1M2htL0NNZW9CL0MxSERaMEJ3eGJaNkhLeGhDY0kvWHR3Z0NVOGsvQmY0?=
 =?utf-8?B?Wm9ScDZ6V0VKTzhxa1AxQXR4Z3laaHhFTkRhSW15elhPeVNjWmtwK1FHU0tS?=
 =?utf-8?B?ci84aExPcStQS2xuT2RldmlJRlpEQVdKRGs0N0dZanVmTHpwZmhkQTZXdFNo?=
 =?utf-8?B?c2Zjcld4UWtpUGdKZWdkR2N4MHdwTmVxY0FvejlTVG80NWJtTm91WnMxZndT?=
 =?utf-8?B?cjRHUmY1TWpZTmxUUXZ0RklocDd6Y2Q3eVMvSWdvUnFqbEdLSXBvNkY3SnJE?=
 =?utf-8?B?TWcwRmdXT1JqQnJmamRyUlVIQmxVV2l2RmRUZzY4b3lEYzc0V3ZUU1JGSVdP?=
 =?utf-8?B?TFFDSjVSdGMwbm9jZ3g3czIxSGdNTmdNZWZ5NXF2dTY2Ti9Mc0ZqQXhrR0xu?=
 =?utf-8?B?a2U0QklYWEY1YVFSRk82U0tMRFBmTWR0MllzVGJQNGZwNCtCcmV3dXJuTmpW?=
 =?utf-8?B?eGtsZE1hU1FueFdjVVRoSE96czlrejdObHJRNy9GeGtnRGQyTXdrZGRBeEJH?=
 =?utf-8?B?VG9ONVl5ZVpuRitVcGw5dnN4WUpXdGNHZXJvbjBPcGFMZTZUWllZNWRiZWVM?=
 =?utf-8?B?d0VYOEhZS0dXYnVEV0lWZlQ3K3lpZlNaQ3NFMFVCU25JYXhKUEFMaEVuWGxw?=
 =?utf-8?B?TjRIdlh5MTRpYUVUdTFXN2puendHaVhCTHJwMHZPZUxLYzhxT1Y3aEZzamhW?=
 =?utf-8?B?WnFXNHZXaWx5dXM1K1hrZUhLREEzM1BPcVVrZ01ucEFFK00rK1lVV1V1Wk9T?=
 =?utf-8?B?STV3YXFZM3Uvb1VhUWthZ2NhWnY5Y040QTREWkUwdzJDS09PVkgwWG1zRVVq?=
 =?utf-8?B?UzlVWm41eU1IcThzUDZQTkZlNnpHY1NNRHJucTJEKzA0TzFuQjc5NkkrZ3hO?=
 =?utf-8?B?ZjhXa25ZSU1uaUlNN3cyZXNmWnB1VEpXWkdDNklSMGl4SkRrWmNqWXlPY3Nt?=
 =?utf-8?B?d0kxQVVpQmJNd0x0QUlHT3dXb1JhV0hMSDNJMisxOGpQTDVyamlWM2VlTDI2?=
 =?utf-8?B?Z3F3N0NJMGxvbHkwOER2eEFqNVMzSHV2RjBHbjFkRXAwOXNubk5TVCtzVTk4?=
 =?utf-8?B?NWk1N3g0cVJkMkRrQ0dUR0RiL2tVSklYUE1SSkpsUUl5ODJ5ZVVUYUo5azJL?=
 =?utf-8?B?ait2VjZpTWh3SFFJOFlBQ0MwMGRuTDdLU1RldEQ0T0FQaVFQUEdzYy9EbGxO?=
 =?utf-8?B?ZU9zUDlBazlDWkZEbDFmZTdhcHV6V3FZWkhKWGMvRVlHWHU1SWZLek9CWFNW?=
 =?utf-8?B?VVFpcTdtMFdzRDIxVXJ4Zi9sMFZmSlVicFlEdSsyWFVFY3hYbzBvWXQrRDli?=
 =?utf-8?B?ZU9YcXlkckZIamZ4TkNlRW5UU1Vna2FDdW9lNVZMSUV5VEhReHRlbVBadHBI?=
 =?utf-8?B?bU04ZkdIUDhzNlpzbHJIZllRcy9QaUZ1N2ZueEFJQWpkRFRZdWU0S1dtOWMw?=
 =?utf-8?B?R0tDUkNudDdVb3pCOXVhR0NlMjNKcW00MVdUVE95Q0IzdjB6R2JET09XbFFi?=
 =?utf-8?B?aFdKalZhY0lsbjFIZEVrbWRoWk9FdThaY2lidk4rZkhVK0lSL25QREsydHh1?=
 =?utf-8?B?cFlXM2MwU1IxMlhqUUh5bExxN0xxYmtVRFZneEpJelJOSG1YNDZaWEZDbi9G?=
 =?utf-8?B?b2wyREJJczFKOFRuRTVQR01IOTlZWGZ0SnNSK3I0M0w1akt3TlI0NlE0WXJQ?=
 =?utf-8?B?bFlqRVI2MG9OM1YyTUlXVmdoWXFDbTFockFHTmx1eVd0V3JYcXhGdWg5cDlr?=
 =?utf-8?B?VVhPNlpjZnVFQlFuR0dUcElwbzJuSWpnUW1uZXcwUS95WXVpSXdKZzZlSFpi?=
 =?utf-8?B?RWRtSWtPQXUyQkZBRGFKMDdISDVJVVpUbFdZWm5XSzBkNCt6ZWF5Y1NpczBj?=
 =?utf-8?B?S040UFVYMWwybFMrNlZETmR6VTMxek1ZejNES3FycVhwdUNCZHV5NjJZTm96?=
 =?utf-8?B?QWZqQmg2dDNsUDA1UFc0V2dkRnlycmttbGpLVDZPOGE0VmV3Ums1QUllRUNz?=
 =?utf-8?B?RkF6VG1XVmF4Z0k5T0FjMXhFM083MmlLamkrc3pDalFjamlYbGQ5NTlicGJR?=
 =?utf-8?B?NW9SNDRRR1FCdkRob1JkVUJFVzE1Wi9YVjdmeGt0T3NRT3pML2NQVTR6U0kz?=
 =?utf-8?B?Q1h3eXlEM002Y3FnSVNkOWIzNzJOZ0V2NkdhM25YZHBPdHpxbXhTbElnOUlW?=
 =?utf-8?B?YXF5Njg1ZnhQZDFQdEo4WmFWWWFKZlliVnU2Q0l1b0xnVlpXWE41LzJ0ZlF5?=
 =?utf-8?B?WDFwMGFjdG9oa0MycjMyUnNSclRJTkpiNkpHL2RHNWtkZU90bURHcXRybFBn?=
 =?utf-8?B?cXpSWjhtWGJKaDQxelVMNnEzNnlEYzR4bDdJQk5Wc1gxeHk0VDFEdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65456d91-d8c0-486a-ed00-08de8667d230
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 10:02:40.1011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IzIjlVy+IEOIonsQVGuDSdulglBcnzcRuzzuLZixF3+kSxy94rpVp3eZwEeCacrUEJwCFFA/7ONEb/3U9aIlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7154
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


On 20-03-2026 03:16 pm, Christian König wrote:
> On 3/20/26 10:41, Sunil Khatri wrote:
>> There is a possibility of deadlock when last reference to a queue is
>> put in certain situations where mutex is already help when calling
>> the amdgpu_userq_destroy.
>  From functions
> As far as I can see that is illegal to begin with. Why are we doing that?
This is to fix the deadlock that prike shared and many other places 
where deadlock could still be caused.
There is a possibility of amdgpu_userq_put being called for last 
reference from amdgpu_userq_restore_worker or 
amdgpu_eviction_fence_suspend_worker via amdgpu_evf_mgr_shutdown
and all these functions already hold the userq_mutex and on last 
reference when destroy is called it again takes userq_mutex and causing 
deadlock.

Thats why when we are dropping the reference we pass the information of 
the handled could be called with lock already taken and hence the handling.

Regards
Sunil khatri

>
> Regards,
> Christian.
>
>> So based on the thread where it could be
>> locked we pass the locked information in the destroy functionality
>> to avoid taking the lock again.
>>
>> Cc: Liang, Prike <Prike.Liang@amd.com>
>> Suggested-by: Liang, Prike <Prike.Liang@amd.com>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 52 +++++++++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  2 +-
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  4 +-
>>   3 files changed, 40 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index ced9ade44be4..9482664e9c2c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -617,13 +617,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>>   }
>>   
>>   static int
>> -amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>> +amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue,
>> +		     bool locked)
>>   {
>>   	struct amdgpu_device *adev = uq_mgr->adev;
>>   	int r = 0;
>>   
>> -	cancel_delayed_work_sync(&uq_mgr->resume_work);
>> +	/* It safe to unlock since we are in destroy and the queue ref is only this */
>> +	if (locked)
>> +		mutex_unlock(&uq_mgr->userq_mutex);
>>   
>> +	cancel_delayed_work_sync(&uq_mgr->resume_work);
>>   	/* Cancel any pending hang detection work and cleanup */
>>   	cancel_delayed_work_sync(&queue->hang_detect_work);
>>   
>> @@ -657,13 +661,27 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>>   		queue->state = AMDGPU_USERQ_STATE_HUNG;
>>   	}
>>   	amdgpu_userq_cleanup(queue);
>> -	mutex_unlock(&uq_mgr->userq_mutex);
>> +
>> +	if (!locked)
>> +		mutex_unlock(&uq_mgr->userq_mutex);
>>   
>>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>   
>>   	return r;
>>   }
>>   
>> +static void amdgpu_userq_kref_destroy_locked(struct kref *kref)
>> +{
>> +	int r;
>> +	struct amdgpu_usermode_queue *queue =
>> +		container_of(kref, struct amdgpu_usermode_queue, refcount);
>> +	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>> +
>> +	r = amdgpu_userq_destroy(uq_mgr, queue, true);
>> +	if (r)
>> +		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
>> +}
>> +
>>   static void amdgpu_userq_kref_destroy(struct kref *kref)
>>   {
>>   	int r;
>> @@ -671,7 +689,7 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
>>   		container_of(kref, struct amdgpu_usermode_queue, refcount);
>>   	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>>   
>> -	r = amdgpu_userq_destroy(uq_mgr, queue);
>> +	r = amdgpu_userq_destroy(uq_mgr, queue, false);
>>   	if (r)
>>   		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
>>   }
>> @@ -689,10 +707,14 @@ struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
>>   	return queue;
>>   }
>>   
>> -void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
>> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue, bool locked)
>>   {
>> -	if (queue)
>> -		kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
>> +	if (queue) {
>> +		if (locked)
>> +			kref_put(&queue->refcount, amdgpu_userq_kref_destroy_locked);
>> +		else
>> +			kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
>> +	}
>>   }
>>   
>>   static int amdgpu_userq_priority_permit(struct drm_file *filp,
>> @@ -978,7 +1000,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>   		if (!queue)
>>   			return -ENOENT;
>>   
>> -		amdgpu_userq_put(queue);
>> +		amdgpu_userq_put(queue, false);
>>   		break;
>>   	}
>>   
>> @@ -1007,7 +1029,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>   			drm_file_err(uq_mgr->file,
>>   				     "trying restore queue without va mapping\n");
>>   			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
>> -			amdgpu_userq_put(queue);
>> +			amdgpu_userq_put(queue, true);
>>   			continue;
>>   		}
>>   
>> @@ -1015,7 +1037,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>   		if (r)
>>   			ret = r;
>>   
>> -		amdgpu_userq_put(queue);
>> +		amdgpu_userq_put(queue, true);
>>   	}
>>   
>>   	if (ret)
>> @@ -1258,7 +1280,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>>   		r = amdgpu_userq_preempt_helper(queue);
>>   		if (r)
>>   			ret = r;
>> -		amdgpu_userq_put(queue);
>> +		amdgpu_userq_put(queue, true);
>>   	}
>>   
>>   	if (ret)
>> @@ -1298,17 +1320,17 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>>   		struct dma_fence *f = queue->last_fence;
>>   
>>   		if (!f || dma_fence_is_signaled(f)) {
>> -			amdgpu_userq_put(queue);
>> +			amdgpu_userq_put(queue, true);
>>   			continue;
>>   		}
>>   		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>>   		if (ret <= 0) {
>>   			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>>   				     f->context, f->seqno);
>> -			amdgpu_userq_put(queue);
>> +			amdgpu_userq_put(queue, true);
>>   			return -ETIMEDOUT;
>>   		}
>> -		amdgpu_userq_put(queue);
>> +		amdgpu_userq_put(queue, true);
>>   	}
>>   
>>   	return 0;
>> @@ -1366,7 +1388,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>   		if (!queue)
>>   			break;
>>   
>> -		amdgpu_userq_put(queue);
>> +		amdgpu_userq_put(queue, false);
>>   	}
>>   
>>   	xa_destroy(&userq_mgr->userq_xa);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> index f0abc16d02cc..2a496e74ec6a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> @@ -116,7 +116,7 @@ struct amdgpu_db_info {
>>   };
>>   
>>   struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
>> -void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
>> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue, bool locked);
>>   
>>   int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 18390d37a7e0..10e08cb6bd13 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -612,7 +612,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>   	kfree(syncobj_handles);
>>   
>>   	if (queue)
>> -		amdgpu_userq_put(queue);
>> +		amdgpu_userq_put(queue, false);
>>   
>>   	return r;
>>   }
>> @@ -914,7 +914,7 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>   		r = 0;
>>   
>>   put_waitq:
>> -	amdgpu_userq_put(waitq);
>> +	amdgpu_userq_put(waitq, false);
>>   
>>   free_fences:
>>   	while (num_fences--)
