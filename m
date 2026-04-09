Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7D9EA3C55
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 11:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E33510E422;
	Thu,  9 Apr 2026 11:47:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VHYlvMhg";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011067.outbound.protection.outlook.com
 [40.93.194.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA0110E422
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 11:47:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzntJC+satwdv8KD+TPBUgEokF8l9jcfcuoiDuWlUNYxzNFMH2cz54ZsadkkbpI81c2zfIRlxh/bgBRl+o8oZlo+saFo35OgfsIWIXndzYOkJXP7UmsRdsUoZEXxBpsEFysPvKvvyNqC8+uChfBLViOy0l4b9xBkdJPa473aZDGxEAyVZBMqQnjGyDe3zr26w6isT73iOmMV1EsbtD+oNCiRlUIm/W5v9zbtk+mRBatjzOLucGD6pW3lW7BmzOxD/FA62rDODwZQ27+8F6TzeOT7NZixNpZj7PTxTUNuq27VMZilSkb/kb46HaTpzHZPgVn9JlNW9l3VeQf6+wwIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lqtf6Wtz8cQi2n1Bi6JqZruTG4TJaDBPxzrg+NjeD3k=;
 b=x46VH6OzYGuz9tWSDBMTdxcgzpnwKCounA2c06HKIJqovzQYrMxS/7UX0/nGOJFL85en0Z10p2D0NIpE5axDxpPGaRfiY1PUF59r+DrlXQ0Hrb9sRkB7ukIwN43BdwLF/GoFSLpGH/uBVne9EJDjWtETpmz/CX/OOvoEuEYDCG36qC3pyeSDkQFGkzwYBbX2NTXjUSKjSC6CbEJV0A+1BGofeXjFAZDyMyeOSKsiB0Hfd+cQE76fDKXqTZXXSg+JlHVi/Avl5tL79F2nuWBPuu21TMBq7dr81Fb74QeGVJ5AAqWsohzahGnnfPWmLZY5gTqq9BVepf8GMmpwGQqVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lqtf6Wtz8cQi2n1Bi6JqZruTG4TJaDBPxzrg+NjeD3k=;
 b=VHYlvMhgJ1jU0gX1qaO0SzpjBdtDdWqJOlPArWJgad7CQ2yaQKk3zltCJicjln0t4YeNf5koyNsd6yXrqRjvPxKY2QF+NBSWRB6w3camD3TxyN84HQ+Vb8dls3VuJHa849Mv4ehpyTcvbFUjxLO/y8JLwjKOWUytk1Z6aAjkva4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PPFFEC453979.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::beb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 11:47:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 11:47:32 +0000
Message-ID: <d22e655e-45ec-41b6-a15a-23eab757d651@amd.com>
Date: Thu, 9 Apr 2026 13:47:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: rework eviction fence suspension lock
 for fixing lockdep
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260408025224.3437723-1-Prike.Liang@amd.com>
 <5774852a-6711-47bf-9e2f-764b21fe7e6d@amd.com>
 <PH7PR12MB6000EA0059F13352BE7BA9C5FB582@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <PH7PR12MB6000EA0059F13352BE7BA9C5FB582@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0011.namprd14.prod.outlook.com
 (2603:10b6:208:23e::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PPFFEC453979:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb80fad-2fb2-4783-6df3-08de962dc920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: iqHItB2//6GZuM7hLZ/VxsqZJnz9nqn/FMwTRDOvhWt5LV2oEfkNaiSBBbfdpzrDGA9avXspKNtnD0myAMXarc+kvGWo5c97kmWQulrEgUW3C2cyw2EKeJ6l8xsH7iCAdSnuKqF5MsBrnwYI/o6xKmFswQx6n0fDMrKuxCHPYOxQa3c7ucZ9WExKOUpP/RwenzkbI/vb762/U6mKHost8O6FTduj8eO93BTfQNfVVmZBmMW8au8CN8K/0DHoCMqv0uD6oLa2+hLeTXGKgeBAIB1vN54N8lTSh74y9Ds2LQwDVRrveraMobF2+P4BW/YxI6nhdmnjXgJ/lRmfjbnWLisfCqYaZdgDaRPq9PixDy/ERm8dQMtVv+Hx2yMroJ4DGuJ0FCJ7VUvIaMBOq1zmQBoDYeP5+cKWhB95r2Vwdb/N1lJj3BtHqlhHE8i9pOXl2feQz41PwD5LU+oPni1u+YQ5vOlV8qZUmkNOMc5ayP36FfVXsblx98z1GqZnFWTpQvAH6CdxNzyfzsLla4CSZC0aPcQQol+pGw1rPRS5JOTx3QnO2TMzj2+skgdeRcLxCZlqJmnJ7OONodi5yEFivFcg9nQgAgFZFwOrbKjDQgCmpcq9EIpknRKv+KzHvznkxDQxrtCA30SHXo+kdRaGb629FZfYFv7sH0BsHmb7mnrTMwcl2MBR20j3uPq128j0sIMNSJaXC+tsJT5Z3uraZjDCXpCOnnlBQLnE+a+sgLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDhleDk1a1BFUzM4bk9hdnBBUzNTdUxqdGRmcEtHOFY3aFJWZ1ZEUitvRlJX?=
 =?utf-8?B?ejNHNFNJNGowYUVEcEJtWk9CVTdZU3h0WWN5MHF1bnZpMjE5WmUyQjB1VHph?=
 =?utf-8?B?RngvbnFIMUc3L1F1RWtTRjl3dndLT1ZQd1dYQ1NqTkJUZnpQenNVMVFjUXhP?=
 =?utf-8?B?U3o4cEVYblc2bjc3VnR5QWlZemdCa2pHSE5QSS9KSFhOZnZIMmMzMjBHM2Vk?=
 =?utf-8?B?UGcxUkUzcHNDYVcrc1FBRlE4amFKWmN5SGd4MlNsdGl2bFJLUFJPWGIvZlI2?=
 =?utf-8?B?bHYvZHozbG1qUlpqZ28rOWdBeC9vbmNPZGR6N1JOdmtvYmdRclZlaUI2QVN0?=
 =?utf-8?B?MlhsbnBFNFUxcEJSZWs2SUxCdVYxR1I4WWJrWUlmeGNTSzRkb2xEcjJhWEVK?=
 =?utf-8?B?M2U2NVo3ZjBCQ25Ed01PaVhDYjZqeHJsb1J1NXpRclQrcFNTdFQ1aUVqVXdr?=
 =?utf-8?B?T2pEaUoxdWx1RmhKa1FiUXZianYvNVBYdnJyNUNUTWhBaFBpOU1VejBxS3hv?=
 =?utf-8?B?bVBROVZSaXJKbzExNWdQR2hjZTJGSjNlcmQxVlNsNVp6bHVGekgyNExDa2Vl?=
 =?utf-8?B?a2JnVHA5eStNVmo5a3VLWFpRK0t5UUNlLzgxMG43L2d6dm1LVEJ0WDl3WlJ6?=
 =?utf-8?B?QUFOK0ZMcVpBWXNoa0pubkpxTnh3NjhxdlJrRkdncU1BUFVheFVHMXRIekwx?=
 =?utf-8?B?dnZuZWpOa2hsTHI3M1h4NVlhaUhTMkdtQ0xjTkNKalZ6bHZiVERkb1Q2bzlU?=
 =?utf-8?B?UXYwa0dRT0tRa0t4M2JKZDVpOHg2ZWQyVUtMb1h4TnFoODFlakVSa1ZOTWhj?=
 =?utf-8?B?T2JYL2k0NnZDMVlqb3I4R0w0VDdSbFJGdkM3MUFSS3Ird1JWRm96b3A0bFZF?=
 =?utf-8?B?RDN4dXYvZVNlaHR0SFdFQmJrNWFuTE56Y05JWFFRQTRSS2lVM0Z2dnRzZUU3?=
 =?utf-8?B?bVpGdVF3c213MjRwYU1ZL0pJYWF6T0JMckVDVDdUdndrVnJGc0lSSVFFa1la?=
 =?utf-8?B?TklOMHIyOTdOb3BsOG91bGNlbVQreW1NSkdMaUhTb0VQRXVEY1psbnAyQ2E1?=
 =?utf-8?B?a3dxSThwWGpUeDROTmpjWGxIeU15UkhMQ01qNkpoM0lRSWpQbHBDdWRSb0dV?=
 =?utf-8?B?dEhHc2dGV0E5b3YxOHF5Rzl4NWpyNFZUMXI3ZlFvL1BmZkxyWDJlSDNRVVMr?=
 =?utf-8?B?WWd2bGhGZDdXM2R5QlpTR2VyT3FLN25sQzdaU044VkpDMXRYNkxPd1B4MTBJ?=
 =?utf-8?B?dEpkWXlLd1RLZ2VXY3gxa3dnUFBGdUhrcmxvTjF6R2J4V2RSRTBPSzVKcXJQ?=
 =?utf-8?B?NkVwUGI5MFpaNlFFVTgvcENmVFp4ZlljT3QxdU9lLzRCWE9TTmwxeGl6S3Z4?=
 =?utf-8?B?RjBXZlBZdzF5VEJ1N1hDWHF2OFIyNmNhRWpDUy9LRm1WZW9KbnQrR2xQOURv?=
 =?utf-8?B?emFpWm1FUW04Q2ovNWI1UlB0UWVLaU80ckFZSjRpcTBtRjBFZGdIaVlPd3Rh?=
 =?utf-8?B?bHVQVzkxUjZRUUNSZERSSnJrR2xVaVNMcGFiT1NQaHdwRStqYU02ZmJ0R0Nh?=
 =?utf-8?B?b21oaENoR0V6TVVLRnVWbFFYbE5kQW9lcEFKSGhtSTBha0hhWjg3d3dDR3Zu?=
 =?utf-8?B?WENoUGpWc09hUjJ4NXZ5REkrWGJjVXZvZTAveHRneXJ5QlFTS0ZwYkhjMm4y?=
 =?utf-8?B?eXNTdXVJdTZJVksxSGhodFhNdTlpQyt3dWI2M25kb1pVRTliTmJUdFluYVh6?=
 =?utf-8?B?Y1FhdEtPVk54Y1hRNWhJdE1UVlBFaWJYMVNBZG00Ny9XcTgwTzc3ZTZmNGtT?=
 =?utf-8?B?V1Q1elgzeHQ1dnJ1VUdGTnAwa2tlaHVVNEJaa1dBTXA1R2ovTXlZV1BpVURH?=
 =?utf-8?B?VmN0eUI2MGZSNG9NRk9FNGhQNzhkYzF6SDM5R1FBdUlVUm5uOFpQRjJHRVBO?=
 =?utf-8?B?TVViQXUyZkR5VnhxdlZPbURhV0MzRThPOEl4a3hqRlBhVzh2NzI2SUpBamtB?=
 =?utf-8?B?d0QxeTJxT0lIZkFHbGhpWkljcFQyK05YaWZlM2ZReE5oaThuNGtaY1c2WnVw?=
 =?utf-8?B?NXVUZEJIVE5LZzZBUEhRTlppbVdFYVdYd1BKMlpDMTZLUHFFOGZremV0dkM3?=
 =?utf-8?B?SjkwNERJSVZ3Rk1OUXYwUERud3pYYnMzWmFuTUVBZ1JpUml6ZnpERDJnZ1BH?=
 =?utf-8?B?dXRWLzRaMlNNdy96Zk92R2NjT0pMcFc0K3NCb2FVMlBqNUFFRDROMHNTK1hq?=
 =?utf-8?B?UnRnTXJac1VoZWxMN3l6SzFPeHVGOXFDRytLVk9qYmFMa0Z6RG9VeHhjYWRE?=
 =?utf-8?Q?ByPicCofnUxo9AQU+F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb80fad-2fb2-4783-6df3-08de962dc920
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:47:32.7901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lW5HxeAx7ggtfDZYR7W+AwWwh0mReWRlU/1HOobsTwt5gbxpUA9gJcOTB2yAOw8o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFFEC453979
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

On 4/9/26 05:35, Liang, Prike wrote:
> [Public]
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, April 8, 2026 4:22 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu/userq: rework eviction fence suspension lock for
>> fixing lockdep
>>
>> On 4/8/26 04:52, Prike Liang wrote:
>>> amdgpu_eviction_fence_suspend_worker() ran
>>> amdgpu_userq_wait_for_signal() with userq_mutex held. The helper used
>>> to walk the xarray and block on
>>> queue->last_fence while keeping that lock, so the userspace signal
>>> queue->path
>>> could never get the lock while the wait fence sleep waiting, then
>>> triggering 120s hung task warnings.
>>
>> And that is perfectly intentional.
>>
>>>
>>> Meanwhile, there also rework the userq lock access in the eviction
>>> suspension path for resolving the lockdep/lock order issues.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |   2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 107 ++++++++++++++----
>>>  2 files changed, 85 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> index 5ae477c49a53..00c450e31139 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> @@ -73,7 +73,6 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct
>> *work)
>>>      * allocate memory while holding this lock, but only after ensuring that
>>>      * the eviction fence is signaled.
>>>      */
>>> -   cookie = dma_fence_begin_signalling();
>>>
>>>     ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
>>>     amdgpu_userq_evict(uq_mgr);
>>> @@ -83,6 +82,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct
>> *work)
>>>      * userq_mutex. Otherwise we won't resume the queues before issuing the
>>>      * next fence.
>>>      */
>>> +   cookie = dma_fence_begin_signalling();
>>
>> Absolutely clear NAK to that. This only disables the warning but doesn't fix the
>> locking problem.
>>
>> As far as I can see the patch here is just once more utterly nonsense. What problem
>> are you exactly trying to solve?
> 
> There's a lock issue as following which is caused by the userq lock is acquired with sleep wait (dma_fence_wait())in the
> amdgpu_userq_wait_for_signal(), and this solution is to avoid waiting the userq fence with userq mutex

That solution is completely invalid. One of the main purposes of the userq_mutex is to prevent installing a new userq fence while we wait for the previous ones to signal.

So waiting for the dma_fence while holding the userq_mutex lock is a must have!

Who else is blocking on the userq_mutex?

Regards,
Christian.

> and rework the
> userq mutex lock and fence dma fence lockdep order issue.
> 
> 
> 9] INFO: task Xorg:cs0:2019 blocked for more than 120 seconds.
> [ 7130.223182]       Tainted: G     U     OE       6.19.0-custom #16
> [ 7130.223468] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 7130.223822] task:Xorg:cs0        state:D stack:0     pid:2019  tgid:2016  ppid:2014   task_flags:0x400040 flags:0x00080000
> [ 7130.223849] Call Trace:
> [ 7130.223861]  <TASK>
> [ 7130.223880]  __schedule+0x570/0x1200
> [ 7130.223905]  schedule+0x47/0x160
> [ 7130.223912]  schedule_preempt_disabled+0x19/0x30
> [ 7130.223918]  __mutex_lock+0x6b1/0x10d0
> [ 7130.223934]  ? amdgpu_userq_ensure_ev_fence+0x3c/0x110 [amdgpu]
> [ 7130.224240]  mutex_lock_nested+0x1f/0x30
> [ 7130.224245]  ? mutex_lock_nested+0x1f/0x30
> [ 7130.224251]  amdgpu_userq_ensure_ev_fence+0x3c/0x110 [amdgpu]
> [ 7130.224512]  amdgpu_userq_signal_ioctl+0x571/0x1060 [amdgpu]
> [ 7130.224748]  ? srso_return_thunk+0x5/0x5f
> [ 7130.224755]  ? __lock_acquire+0x43e/0x2210
> [ 7130.224785]  ? srso_return_thunk+0x5/0x5f
> [ 7130.224790]  ? lock_acquire+0xc6/0x2c0
> [ 7130.224797]  ? drm_dev_enter+0x58/0xe0 [drm]
> [ 7130.224833]  ? srso_return_thunk+0x5/0x5f
> [ 7130.224838]  ? sched_clock_noinstr+0xd/0x20
> [ 7130.224844]  ? srso_return_thunk+0x5/0x5f
> [ 7130.224849]  ? local_clock_noinstr+0x12/0xc0
> [ 7130.224857]  ? srso_return_thunk+0x5/0x5f
> [ 7130.224861]  ? local_clock+0x19/0x40
> [ 7130.224867]  ? srso_return_thunk+0x5/0x5f
> [ 7130.224872]  ? lock_release+0x27d/0x3c0
> [ 7130.224887]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
> [ 7130.225110]  drm_ioctl_kernel+0xaf/0x110 [drm]
> [ 7130.225149]  drm_ioctl+0x290/0x510 [drm]
> [ 7130.225176]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
> [ 7130.225417]  ? srso_return_thunk+0x5/0x5f
> [ 7130.225423]  ? trace_hardirqs_on+0x5f/0xc0
> [ 7130.225429]  ? srso_return_thunk+0x5/0x5f
> [ 7130.225434]  ? _raw_spin_unlock_irqrestore+0x35/0x60
> [ 7130.225449]  amdgpu_drm_ioctl+0x52/0x90 [amdgpu]
> [ 7130.225657]  __x64_sys_ioctl+0xa0/0xf0
> [ 7130.225672]  x64_sys_call+0x1280/0x21b0
> [ 7130.225679]  do_syscall_64+0x6f/0x760
> [ 7130.225690]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 7130.225695] RIP: 0033:0x7f5339d1a9cf
> [ 7130.225701] RSP: 002b:00007f532d3fe540 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [ 7130.225708] RAX: ffffffffffffffda RBX: 0000000000000010 RCX: 00007f5339d1a9cf
> [ 7130.225712] RDX: 00007f532d3fe730 RSI: 00000000c0306457 RDI: 000000000000000f
> [ 7130.225716] RBP: 00007f532d3fe5c0 R08: 00007f532d3fe630 R09: 0000000000000001
> [ 7130.225720] R10: 00007f532d3fe818 R11: 0000000000000246 R12: 00007f532d3ff640
> [ 7130.225724] R13: 0000000000000016 R14: 00007f5339c947d0 R15: 00007ffe53cb5130
> [ 7130.225755]  </TASK>
> [ 7130.225818] INFO: task Xorg:cs0:2019 is blocked on a mutex likely owned by task kworker/5:0:4873.
> [ 7130.226193] INFO: task kworker/2:1:4775 blocked for more than 120 seconds.
> [ 7130.226514]       Tainted: G     U     OE       6.19.0-custom #16
> [ 7130.226764] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 7130.227082] task:kworker/2:1     state:D stack:0     pid:4775  tgid:4775  ppid:2      task_flags:0x4208060 flags:0x00080000
> [ 7130.227091] Workqueue: events amdgpu_userq_hang_detect_work [amdgpu]
> [ 7130.227341] Call Trace:
> [ 7130.227345]  <TASK>
> [ 7130.227356]  __schedule+0x570/0x1200
> [ 7130.227378]  schedule+0x47/0x160
> [ 7130.227385]  schedule_preempt_disabled+0x19/0x30
> [ 7130.227390]  __mutex_lock+0x6b1/0x10d0
> [ 7130.227403]  ? amdgpu_userq_hang_detect_work+0x5a/0x80 [amdgpu]
> [ 7130.227660]  mutex_lock_nested+0x1f/0x30
> [ 7130.227667]  ? mutex_lock_nested+0x1f/0x30
> [ 7130.227673]  amdgpu_userq_hang_detect_work+0x5a/0x80 [amdgpu]
> [ 7130.227918]  process_one_work+0x233/0x650
> [ 7130.227944]  worker_thread+0x1b2/0x360
> [ 7130.227957]  kthread+0x11c/0x260
> [ 7130.227964]  ? srso_return_thunk+0x5/0x5f
> [ 7130.227969]  ? __pfx_worker_thread+0x10/0x10
> [ 7130.227977]  ? __pfx_kthread+0x10/0x10
> [ 7130.227987]  ret_from_fork+0x29f/0x2f0
> [ 7130.227995]  ? __pfx_kthread+0x10/0x10
> [ 7130.228003]  ret_from_fork_asm+0x1a/0x30
> [ 7130.228034]  </TASK>
> [ 7130.228089] INFO: task kworker/2:1:4775 is blocked on a mutex likely owned by task kworker/5:0:4873.
> [ 7130.228462] INFO: task kworker/5:0:4873 blocked for more than 120 seconds.
> [ 7130.228743]       Tainted: G     U     OE       6.19.0-custom #16
> [ 7130.228993] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 7130.229309] task:kworker/5:0     state:D stack:0     pid:4873  tgid:4873  ppid:2      task_flags:0x4208060 flags:0x00080000
> [ 7130.229318] Workqueue: events amdgpu_eviction_fence_suspend_worker [amdgpu]
> [ 7130.229543] Call Trace:
> [ 7130.229547]  <TASK>
> [ 7130.229558]  __schedule+0x570/0x1200
> [ 7130.229579]  schedule+0x47/0x160
> [ 7130.229586]  schedule_timeout+0x10a/0x120
> [ 7130.229591]  ? srso_return_thunk+0x5/0x5f
> [ 7130.229597]  ? mark_held_locks+0x54/0x90
> [ 7130.229610]  ? srso_return_thunk+0x5/0x5f
> [ 7130.229615]  ? trace_hardirqs_on+0x5f/0xc0
> [ 7130.229621]  ? srso_return_thunk+0x5/0x5f
> [ 7130.229631]  dma_fence_default_wait+0x1f5/0x290
> [ 7130.229640]  ? dma_fence_default_wait+0xfc/0x290
> [ 7130.229649]  ? __pfx_dma_fence_default_wait_cb+0x10/0x10
> [ 7130.229663]  dma_fence_wait_timeout+0x300/0x3c0
> [ 7130.229675]  amdgpu_userq_evict+0x67/0x120 [amdgpu]
> [ 7130.229930]  amdgpu_eviction_fence_suspend_worker+0x4d/0xd0 [amdgpu]
> [ 7130.230162]  process_one_work+0x233/0x650
> [ 7130.230187]  worker_thread+0x1b2/0x360
> [ 7130.230200]  kthread+0x11c/0x260
> [ 7130.230205]  ? srso_return_thunk+0x5/0x5f
> [ 7130.230211]  ? __pfx_worker_thread+0x10/0x10
> [ 7130.230218]  ? __pfx_kthread+0x10/0x10
> [ 7130.230229]  ret_from_fork+0x29f/0x2f0
> [ 7130.230234]  ? __pfx_kthread+0x10/0x10
> [ 7130.230243]  ret_from_fork_asm+0x1a/0x30
> [ 7130.230274]  </TASK>
>> Regards,
>> Christian.
>>
>>>     dma_fence_signal(ev_fence);
>>>     dma_fence_end_signalling(cookie);
>>>     dma_fence_put(ev_fence);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 9d3c39e96ac1..7691f169415b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -26,6 +26,7 @@
>>>  #include <drm/drm_exec.h>
>>>  #include <linux/pm_runtime.h>
>>>  #include <drm/drm_drv.h>
>>> +#include <linux/lockdep.h>
>>>
>>>  #include "amdgpu.h"
>>>  #include "amdgpu_reset.h"
>>> @@ -34,6 +35,23 @@
>>>  #include "amdgpu_hmm.h"
>>>  #include "amdgpu_userq_fence.h"
>>>
>>> +#define AMDGPU_USERQ_FENCE_WAIT_POLL_MS 1000 static unsigned long
>>> +amdgpu_userq_fence_timeout_ms(struct amdgpu_usermode_queue *queue) {
>>> +   struct amdgpu_device *adev = queue->userq_mgr->adev;
>>> +   switch (queue->queue_type) {
>>> +   case AMDGPU_RING_TYPE_GFX:
>>> +           return adev->gfx_timeout;
>>> +   case AMDGPU_RING_TYPE_COMPUTE:
>>> +           return adev->compute_timeout;
>>> +   case AMDGPU_RING_TYPE_SDMA:
>>> +           return adev->sdma_timeout;
>>> +   default:
>>> +           return adev->gfx_timeout;
>>> +   }
>>> +}
>>> +
>>>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)  {
>>>     int i;
>>> @@ -176,29 +194,12 @@ static void amdgpu_userq_hang_detect_work(struct
>>> work_struct *work)  */  void
>>> amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue
>>> *queue)  {
>>> -   struct amdgpu_device *adev;
>>>     unsigned long timeout_ms;
>>>
>>>     if (!queue || !queue->userq_mgr || !queue->userq_mgr->adev)
>>>             return;
>>>
>>> -   adev = queue->userq_mgr->adev;
>>> -   /* Determine timeout based on queue type */
>>> -   switch (queue->queue_type) {
>>> -   case AMDGPU_RING_TYPE_GFX:
>>> -           timeout_ms = adev->gfx_timeout;
>>> -           break;
>>> -   case AMDGPU_RING_TYPE_COMPUTE:
>>> -           timeout_ms = adev->compute_timeout;
>>> -           break;
>>> -   case AMDGPU_RING_TYPE_SDMA:
>>> -           timeout_ms = adev->sdma_timeout;
>>> -           break;
>>> -   default:
>>> -           timeout_ms = adev->gfx_timeout;
>>> -           break;
>>> -   }
>>> -
>>> +   timeout_ms = amdgpu_userq_fence_timeout_ms(queue);
>>>     /* Store the fence to monitor and schedule hang detection */
>>>     WRITE_ONCE(queue->hang_detect_fence, queue->last_fence);
>>>     schedule_delayed_work(&queue->hang_detect_work,
>>> @@ -1274,16 +1275,76 @@ void amdgpu_userq_reset_work(struct
>>> work_struct *work)  static void  amdgpu_userq_wait_for_signal(struct
>>> amdgpu_userq_mgr *uq_mgr)  {
>>> -   struct amdgpu_usermode_queue *queue;
>>> -   unsigned long queue_id;
>>> +   lockdep_assert_held(&uq_mgr->userq_mutex);
>>>
>>> -   xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>>> -           struct dma_fence *f = queue->last_fence;
>>> +   /* Rescan the userq xarray after each fence poll interval to get
>>> +    * newly added queues or fences.
>>> +    */
>>> +   for (;;) {
>>> +           struct amdgpu_usermode_queue *queue;
>>> +           unsigned long queue_id = 0;
>>> +           struct dma_fence *f = NULL;
>>> +           unsigned long timeout_ms = 0;
>>> +           u64 context = 0, seqno = 0;
>>> +           bool signaled = false;
>>> +
>>> +           xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>>> +                   struct dma_fence *tmp = queue->last_fence;
>>> +
>>> +                   if (!tmp || dma_fence_is_signaled(tmp))
>>> +                           continue;
>>> +
>>> +                   f = dma_fence_get(tmp);
>>> +                   timeout_ms = amdgpu_userq_fence_timeout_ms(queue);
>>> +                   context = tmp->context;
>>> +                   seqno = tmp->seqno;
>>> +                   break;
>>> +           }
>>>
>>>             if (!f)
>>> +                   return;
>>> +
>>> +           if (!timeout_ms)
>>> +                   timeout_ms = 1;
>>> +
>>> +           /*
>>> +            * We can't use dma_fence_wait() here. Waiting there and then
>>> +            * reacquiring userq_mutex creates a lockdep cycle through
>>> +            * dma_fence_map:
>>> +            *   userq_mutex -> reservation_ww_class_mutex -> dma_fence_map
>>> +            * and
>>> +            *   dma_fence_map -> userq_mutex
>>> +            * Instead, drop the mutex, sleep in bounded intervals, then
>>> +            * reacquire and poll the fence signaled bit.
>>> +            */
>>> +           while (timeout_ms) {
>>> +                   unsigned long interval_ms;
>>> +
>>> +                   if (dma_fence_is_signaled(f)) {
>>> +                           signaled = true;
>>> +                           break;
>>> +                   }
>>> +
>>> +                   interval_ms = min(timeout_ms,
>>> +                                     (unsigned
>> long)AMDGPU_USERQ_FENCE_WAIT_POLL_MS);
>>> +                   mutex_unlock(&uq_mgr->userq_mutex);
>>> +                   msleep(interval_ms);
>>> +                   mutex_lock(&uq_mgr->userq_mutex);
>>> +                   timeout_ms -= interval_ms;
>>> +           }
>>> +
>>> +           if (!signaled && dma_fence_is_signaled(f))
>>> +                   signaled = true;
>>> +
>>> +           dma_fence_put(f);
>>> +
>>> +           if (signaled)
>>>                     continue;
>>>
>>> -           dma_fence_wait(f, false);
>>> +           drm_dbg(adev_to_drm(uq_mgr->adev),
>>> +                        "Timed out waiting for fence=%llu:%llu during eviction\n",
>>> +                        context, seqno);
>>> +           amdgpu_userq_detect_and_reset_queues(uq_mgr);
>>>     }
>>>  }
>>>
> 

