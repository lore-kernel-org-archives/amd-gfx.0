Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7539DC5CFDB
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 09:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D55BD10F229;
	Thu, 13 Aug 2026 09:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P27aW+vF";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D78A10F229
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 09:32:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/7a/ZMubMBsi31MJgr1DqMxjpOWVxi/w9eA8besrqZUz5kBME33aCfskub895leS5ZVYIL3sctOgw1uWTSC4kZ5zJ2Pi2CsmOiuBLsoofkkkT3sdZ/VrU5EML6DNdpB5xMHVimB5CRq8ZWvTzywO1vPYXn/PHDeRmioboZTaA7DSI9fGMMBpP0AVSMKofdyGipX2ZwpxCl9pvENMiARDxZfOaOCbL2teUuGLkHI8eClGFo90l6y/rxiqf75xyFokQThgITs/Qw3OuRiOXXIYQhMGJCCFn7VPUu4qZxF1juFBOxRf4cojpRTrpm4YlsbIwrpUmGktlxh62RNbSDeaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k67bs+R8s+MsuePkYfQUGV4YM7amdlx5yygjSHQR2Rg=;
 b=hhCtRH7cLsyGVvLzpSyJuKuG1Qr+Anc2fw7QR5B11E5i+i+omD0QPicZ7mZc0BAcKJjlZMZe+cJSLoKIIdeFLJPqAIz1bTTZE40heyDX1a8/xihaeZHWLMbIlUl4CORTorz1wtQpzrYWCwyRijtIp6zoKRY6dR27xn4b7AlqRA/iHjo1jP9LvhlGZkHPGbSIwcwBMyyhJhMxiC1tvZl2Ez7oWRsIBXO40EhKqV4cJwb2T0EQGYWg5EHJMES0Sz8QaaydMN8z+dZgn61i95ymf5GntNTIsgTOioAUxQ4nC/f/KiZdcAjAhNIUnttvhFxcOowY78UchYAo6CwrptZe+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k67bs+R8s+MsuePkYfQUGV4YM7amdlx5yygjSHQR2Rg=;
 b=P27aW+vFf3+P27gRk72wpcnlJ30Kgfqu5s8KfnrkOolJjphFMOUznGbkqfDmsamxinWiYvrBFMwNiwiOsT7+Gk/LTUXQId5v+1dbxBjuPPV5ZyKvgzpGRFZifJkroQK2gVruMSru2TR/P47K3V8xU1TjYNtmHDd+sHhVAIntS9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 09:32:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Thu, 13 Aug 2026
 09:32:26 +0000
Message-ID: <0d379c05-9b29-4b89-b3a0-679d99f811af@amd.com>
Date: Thu, 13 Aug 2026 11:32:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: fix lock missing for userq fence error
 set
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260807061422.365929-1-Prike.Liang@amd.com>
 <f2418e1b-43fd-4d3d-9f52-10bd50dfe68d@amd.com>
 <DS7PR12MB6005E7C627EEB20339B7E8ABFBDB2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005E7C627EEB20339B7E8ABFBDB2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4b8ccb-04fb-45c0-dfb0-08def91dc91f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UbclMx1zgBgiPaHv8olUdS/Hif2bbv+9/Ez/njQ0YDfTXK6vVpIg1/iEM0/0jNJgPMWQWFjaRSmlcs9d1vyYjfXibnPCdZWQ/LZcx8H3lg0pqYA84foxrUzQTkLPxPU0xtLePZJY/baUV0+bBOaRr7gKfBjhvdC7fJLSEIFX8TCByAJMXGWFsL15yRl3abnax48c484JOOaut78evJGnx4vl0hvFQuC2fPKoSfrkZTLgsI2ge2n5KuWIh9KzQtBKJsPDLKUrRyc9vi8uIh2ktoihPGewFQdWX3Ssqn4vQUiFKLoBcnsMEXB8gv86wBSJbkSBIiCDU5ytGGHBk0eVRZU5D7El8qqSlFJ//z4zB3Ag8aFmfWv5aTV9R9TeopKkx+Tm6/G+U2JxHE5I5577Hrt7uo/7lgA70MvsraUT/8QsfIQot40AFBnpIBBSd/To7lThPBVgM1I28pqIMdmnPqm0AwVxCDUY9ApggI7fxRiR6AC3hzcFBUbtBYFB5DJmqc8DvuTigMxVIm5CJVmgBFhDH9xI7DQ8J6ge5DRZMqUWc+a5uUi0o3q7HKL13HmlWwaO3nUqDLtQFZVxCSnvPCFoYxFKjI0Z2MwINzX6F4fzx3hr00kIoOABLbq214neQy2XNlZG19fGsWbSoWmNwatSZs1YxsdYFW+Igvo6o4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG92QTMzU3ZoUVp6alJUbFBEM0dNZ1lkcy9BQ29HWFMxQkdjUDFxMjAwNTln?=
 =?utf-8?B?RFRTVkRVWmhDVnd3dVdUUWh2TkNVYkRDRitDd2lDck52ZTNobUdESnJVb0RS?=
 =?utf-8?B?UG41YU1ydm5SV1BaVFZsZWpSRDNpbTJnMDM2VENBRXVtMGZCSlR0WGxaeVdG?=
 =?utf-8?B?em9yYis4TU15b0xkd2dGZ0JBaFZnNExROVVmVE9IU1FGT1ZaajNLVzFCRWRM?=
 =?utf-8?B?L3JpK3JNY2JiQnUzdk9zOHZxb1F5aDlVTlMzN0tBNEFlTFBoTlZYR2RoaVdV?=
 =?utf-8?B?QW83UzgzN3hOOTNnTUw3cWhNSCtXc3JXMEU0Mm45c1RmUUkycDRLV0xLUTda?=
 =?utf-8?B?MVM5bWcrVnJwc3luZVBYS0xQdm90VHRCNGphZlI4WXNmZXM5WVgreTFoQVh5?=
 =?utf-8?B?T2lmZGRxNWFraEtNU0p0NXhJdWNzOG1iK1hPVzlINHMyR2VTNVBQcjBFU21L?=
 =?utf-8?B?d3NKbE1uSGpaQVlKYlpZTUJhOS81cTVQNDVDYUVselNOdTVQalh1QlVhVDNQ?=
 =?utf-8?B?NzlkeE9GS3JIYndsQytnY3JScTBJNy80NXBlTzIvbGVNdXJFak5sazhmN3NC?=
 =?utf-8?B?SUpLTUZwbUVlOEtTd2I1TlRiaU9oUFk1bENVU1VQeWtsZ2gxcVMvajFrZXFO?=
 =?utf-8?B?NXQwTmFaSE9ubWxIT0hValViWDhrYnBxcnA4Njh6Ti8yNEVUd2g5dDhDV0c0?=
 =?utf-8?B?MGhFbnF1dFkvYWdaUmNsUlM0ZmlaQjVEM0FvSmU3NmRiY1hNekMrTVp6SnBm?=
 =?utf-8?B?RFlyMEhpc1ErR3ovajRLYXJWZjBZTHQzUFIzWnkzUEZmS1ZWbUtFRk9qTzZ2?=
 =?utf-8?B?cXJidjFsdDRjNjd2YnZaRmd4cUJjdnZ5NTZYYnozcWlQYVZ3TmhqUkdCQ2ha?=
 =?utf-8?B?aVQraTBMN1Z4WFJtb1ZyNkZCTUpQeVhiTnQ5YzJ6ZzY4M3JjSGZRY01Xcm9B?=
 =?utf-8?B?d3BzcFd5anhwWnhpN01Md01VejYvMldKdTdQRW9FWHMyZWI4UHlDd2hEdG9Y?=
 =?utf-8?B?Q0gwSmN5VWlCd29oTGZ0R1N6SFdibVBmWkxlVG1wSjdGVFk4Q05ZU1BNdG5p?=
 =?utf-8?B?QXI3V1B5Yk5tbVJzc3dOVTJldkZPSk1pMkFRM00vdWg2WFBhV1NZUFI1UTFu?=
 =?utf-8?B?MXcvYnFBWVYzQ1creEZhQ2VHSmEyY0dtL2hYN0lnWDdKSWZ5YXNTdXBLelVO?=
 =?utf-8?B?YXpKM202L0VBd0EyeklnbUFRWGx3VWNXMk1hdHQ3YzEzYlorblorQmxoSzJU?=
 =?utf-8?B?aDdyYVBScGpzeHJHUzZhS0ZtcjJ5a2x6MC9uc25DcVBmNGFlOGxYQW9yMEZa?=
 =?utf-8?B?elRhRzAwR3hpSnQ2NDJYc21yNGRMVFBSMmpld2lCbk5PZXVnbHpVMmxycUk1?=
 =?utf-8?B?MDFKQTZrR3BDTGRkQnB5YWZPcDM1ZWM0SzNLamk0U3VpdnFEOHBYUTlVRTd1?=
 =?utf-8?B?ZFVCUEtJRUhwS3hick9oV29LUTZBRUU4YmpibUZ5UEdoWnFiNkNEMkE1bG54?=
 =?utf-8?B?bVNVM3FBeVdHNnpYcjJPNEt4ZXpUWjJpUGlHWXdpNllnNkIrSU9pcDNGVWxT?=
 =?utf-8?B?R2xsTVl6SEkrQ0x4OWZLWk5Jb0Z6dW5HVzJyMS9LOEs5SzRvbUkvUEluMlho?=
 =?utf-8?B?ZHFSY3l0Y05XSGFCQXk5aGp6QnUwV2hhMGU1OTl2WHZQNmkrcGdJNTE2QzRM?=
 =?utf-8?B?WUJ4N0ozcHpFeWNTR1krSHk2RzFiTjZCenFMd2g0NUtCdU1zYXExSldMZDYx?=
 =?utf-8?B?eFhWY3VTcnBoQ2ZxY2JHTlh5WHQ4YllKL3BDR0w2WFV2bUV4U1YzRmE3ZGxk?=
 =?utf-8?B?THZHU2VlbkRuQkx4ZURjVTFQZ3cwZ25rT3hwOFdlZTNDVUdHWVhaWFhqQVA2?=
 =?utf-8?B?cnRyVjBjcVhzZmQvdkVraUFqL1VOZitSM1M1ZGIyTkdrMTU4cUg2T1FLTEx3?=
 =?utf-8?B?bUNlam5rV25ZKzFrNDBRaUNTZ3M3bjdMbFVyb21aSkIwSm1wWUQrTU5WQzJ6?=
 =?utf-8?B?RDhQSnZYMkJYbUd0N0cyTEV2RXdMWURhckNYUk4rTW1EYUt3clNKYWIzUFNV?=
 =?utf-8?B?a3M3ckR6UzBneW1nc0NxOUJ2ZnhOZHlyTFpnL0pYZ1ZXZ0dlcUtNWWh2ZzBs?=
 =?utf-8?B?bUh3cEdKWGxkNGVHemFTM1hVS3Z1MzR1STU0Mk0yWmtldUE4WlYvVFV0MDQ1?=
 =?utf-8?B?bFRRd0tkaUY5VmJXSHg2MzV0Sm1ENUdoQUtBOUdPL3UvcUo4cXNqdS9xTENl?=
 =?utf-8?B?V0wrbDhBNGx5N0k0WTM0cUJsUitLTTZqQ04wZnBOenJ0V3VOWmRKbnNnd3Zi?=
 =?utf-8?Q?jsQYFE/osdrDukPFlM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4b8ccb-04fb-45c0-dfb0-08def91dc91f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:32:25.9418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBrqHVAm/F/01Qn5NEYE4U4oSxasAnxAksArSyQQvJZyCiKEUa9ZSjFcKpKBzV+8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918
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

On 8/13/26 10:18, Liang, Prike wrote:
> AMD General
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, August 13, 2026 3:54 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu/userq: fix lock missing for userq fence error set
>>
>>
>>
>> On 8/7/26 08:14, Prike Liang wrote:
>>> amdgpu_userq_fence_driver() and amdgpu_userq_fence_driver_destroy()
>>> don't acquire the dma_fence spinlock, so locking the dma_fence lock
>>> before test the signaled state and set error state.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 15 ++++++++++-----
>>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index e8de64f8357d..db5bfd79ec1f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -193,12 +193,12 @@ void amdgpu_userq_fence_driver_destroy(struct kref
>> *ref)
>>>     spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
>>>     list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
>>>             f = &fence->base;
>>> -
>>> -           if (!dma_fence_is_signaled(f)) {
>>> +           spin_lock(dma_fence_spinlock(f));
>>
>> Please use dma_fence_lock_irqsave() here and below, using only spin_lock is
>> completely unsafe!
> 
> Since acquiring fence_drv->fence_list_lock with spin_lock_irqsave() already disables local IRQ, do we need to disable it again while the lock is held?

In theory we can skip disabling interrupts locally when we know that they aren't enabled, but this needs some annotation or otherwise lockdep could start to complain.

As long as it is not some super performance critical path we should not do such optimizations.

Regards,
Christian.

> 
> Regards,
>       Prike
> 
>> Apart from that looks good to me,
>> Christian.
>>
>>> +           if (!dma_fence_is_signaled_locked(f)) {
>>>                     dma_fence_set_error(f, -ECANCELED);
>>>                     dma_fence_signal(f);
>>>             }
>>> -
>>> +           spin_unlock(dma_fence_spinlock(f));
>>>             list_del(&fence->link);
>>>             dma_fence_put(f);
>>>     }
>>> @@ -428,8 +428,13 @@ amdgpu_userq_fence_driver_set_error(struct
>>> amdgpu_userq_fence *fence,
>>>
>>>     f = rcu_dereference_protected(&fence->base,
>>>                                   lockdep_is_held(&fence_drv->fence_list_lock));
>>> -   if (f && !dma_fence_is_signaled_locked(f))
>>> -           dma_fence_set_error(f, error);
>>> +   if (f) {
>>> +           /* nest f->lock inside fence_list_lock */
>>> +           spin_lock(dma_fence_spinlock(f));
>>> +           if (!dma_fence_is_signaled_locked(f))
>>> +                   dma_fence_set_error(f, error);
>>> +           spin_unlock(dma_fence_spinlock(f));
>>> +   }
>>>     spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);  }
>>>
> 

