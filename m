Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0139CC4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 15:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B36D760F94
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 15:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B36D760F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 720EE89FD4;
	Tue,  3 Aug 2021 15:39:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7817D89FD4
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 15:39:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVrEmO/TaH0W7ef4vRoZ9lsaSUl8/jNBg8tday3YY8v38H1/KBNyC4blKhG/QM0PAbXbUFrVPy7K2Tc4Mca+HML45Kd7r3O0yeC4ne/M2Vhxl3eXPudaycQ2CeAWb31hvotaaC2/ZQsZjfnddJb6JoXyb+72d+6hlQi6kddRwwOIZq5P5eqsJqhjm6whoisUnhNbNSCKrYW93ey3QuAXGINbHJsbRK5cYNcrIo8KmT5uG7b67YlAmyNFQal3aJrrW9uNZQi2RM2kpSSM9eHoaphNR9hgebfT4/F048II9OazbgAdKQkUgs1s6DYRJ5w76HFHETtM21HTM897tf2TKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAHmiezhnC6qHfvS1//dBNxl26VulxP89qWDuBkIBek=;
 b=bXt6lGPP8B0o7Dv5ix9tjaZjg4n2fQPVlUmLFtSDe5mL/g3hDhziaiHo+1b1tcKLmxq1x83cZ7WlH6AvLkYEfZj74PtQJ7x1fvoyMPHi8pCJouQEsoQGjLQ+oin29yDEszyKXfpOd0wYDs9LYXqXATKUxnJ+jC2CIqajOQ/TT6wdnx/B7ZP3zjJS0ga0oSXQaO189gII8JagWSEY2cWUaBUxMxAy3H4AwjMvTODVC9eHWR99k9kKqvaRmn/S44ltLo0Wx9Fxe0mwlR4+vdhOBnyVji0hksAc73gZhkWboMyoYqG+BAhO5ZBgnBSiQeUDQh5xo1XfJzGKrebUQBM2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAHmiezhnC6qHfvS1//dBNxl26VulxP89qWDuBkIBek=;
 b=QF7OODSdjHSSA5Z7GpzdE8bHOwKctYXQjdjQNw/yIut3hnm46ytxt5PtpEq4jJhZSkh4DUp6APP9OiC0tBX5VI3E66tmAP8rAPzI0R73Yh+xTlPP/xCwqf9u27xahFIJCF3k0IeLxkvSlEatQscTkDBuJIJi+sNj/7xd3jIgFW4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5113.namprd12.prod.outlook.com (2603:10b6:408:136::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Tue, 3 Aug
 2021 15:38:58 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4352.033; Tue, 3 Aug 2021
 15:38:58 +0000
Subject: Re: [PATCH] drm/amdkfd: Restore all process on post reset
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210728173154.834263-1-jinhuieric.huang@amd.com>
 <feffbe5c-7400-a3f5-148d-03e7d128aece@amd.com>
 <d7d80b78-21fa-1755-cd97-4c206d6f2667@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <dee1b020-0b42-f31a-958d-fb2403af2185@amd.com>
Date: Tue, 3 Aug 2021 11:38:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <d7d80b78-21fa-1755-cd97-4c206d6f2667@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::19)
 To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.144.73) by
 YT1PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15 via Frontend Transport; Tue, 3 Aug 2021 15:38:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 736f533d-1016-4a18-bb9b-08d95694cf4b
X-MS-TrafficTypeDiagnostic: BN9PR12MB5113:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB51134752A9ECA452522E2E6792F09@BN9PR12MB5113.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PEGi8Drh5acw+2WtiCNCnz4VxpbamDNe0wUOZwpgdg0HMqxDh0/f/z4ZShNmCbCCMcta+Aj2ENRHc8LgwSgK2RvItIIw6IdBWlO9E9tgQVIRP8I9Brf1SE7bvYOaxK4ORJ23v/2gw0L+IKvfMbFAO/ZwBGvYjWJpf0yrzW5YEMXpMNU8p8McyerUJzzYrKH7tMC5b/DJUr10GO7QMWOANHtwlRQH6r7jyUs+KZATPHZD8gpdB9bhygaoX2oPOsHxocaBQkLR5UtsimM0pkjtEmSxHHYri3xnplOAjQG4kr+VqB+QkfRjy4D1ZKLd1te3ZCis8PyGNxdK8mb7KmgYpCtpk7YZTwgzl6irZLZMz1aKTzsSouSowXjFNKM0WGtl5b99mZsnkHG3JDpIhen5ZFrGguad+tDZE4MW3F6dJRXAYJ+9jKD+TLh2Y0jcqf0J9EKHdXq6+wexpH6IAsyyKaSfPbbTG6vmPO7Nt/Hr75nB+bo1MjUFtPdk5bh2pQCfABq19CmF4V1yDUqwBcPu2XSdOLzpWjuSBkCPnSSbkPQyDduJyc3LCL9sYIh74Jhx00RHiiC/hBkBpk7bTThPWJeaKKN+qdFH8O1rGsqWbt9X/uJEAmzqnA+IJmaylTCDbDKi6WwFoN+Nnmtg15prnyhGCp7/iNnBiUeEfF+fr8IGLcELlo+pRMTnRjqD4dY+f7EtsgO4ku1cHBH4ikaSKpxV5EhmLphZSw28DsgpKhE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(86362001)(186003)(8936002)(8676002)(66476007)(66556008)(66946007)(26005)(36756003)(83380400001)(31696002)(53546011)(2906002)(956004)(2616005)(316002)(38100700002)(44832011)(16576012)(5660300002)(31686004)(6486002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmpaOUpsRlk5SkJoNzd2bjV5bURrdUVHZlJnSVZNVmNDWWdKTlpIWmZ5dXVW?=
 =?utf-8?B?UVNhdTRUeUdTWkRnYmFiUFlEUEtvUmp0Z0RPbmVUQVIzS3hJaUVqMjNuMGpZ?=
 =?utf-8?B?MmZLZU1BcXhmSUJZTEdUZXRjU3RFQ1VaMXZEVk9CbU1XRTJVZFJONy9lcFlM?=
 =?utf-8?B?N3dqV1gzaVRrcGU2SE5NWjh2ZXp4OFJTR05MVVdsTjAxZ2hRVHV5Y1NPekRN?=
 =?utf-8?B?bmxpaEtWUFp3QytnZ09pZkR1NVM5MWphaXZOejk2SHc5RGxVb1dybDROK2ZV?=
 =?utf-8?B?WkczdEZhSVZTVnp6dzNJakh3aGxuOENuUE5FbVNKQXk5V29xeU5KTy9YTnRp?=
 =?utf-8?B?WXQwK0xKVk0wTlpUbEtiRy9pSkFaRU56cVFrZzd1QjNsNW4zVWxjOTJwdE1x?=
 =?utf-8?B?WHl5clh5NWZPRTZlYlhuNE5ZalZUL2JhQklvS21oZExjbWllSVlaMENtbXoz?=
 =?utf-8?B?TTFJV3VkNHhOOW4vSXJjcjJoUHAwNkYwWFdOSzlrTk5OVEFMblQ0MlN5UjJN?=
 =?utf-8?B?TnhPcDJrbDJnREIwSVB5cnZnTHRGZTZOK3I1ZVoyVWtvWXI3TDRJTkZ5amo2?=
 =?utf-8?B?dWtDbGZnbFJzaWxRRk9pcC8vMUFRMUd4TzlQRkN0VDV4Vm8rWXR5RVZvbHcx?=
 =?utf-8?B?QzlOdW9GUm5lbzZSdVQvaHlPOWo4WTZEWGVSc01mUU1PWE94cyt3Ym9Pd0Ry?=
 =?utf-8?B?ckIyczFzM2NLVXl2bDZubzllUnZNc1FtZFlmZFV1dFNaNzlCV3J4T2xWR1N0?=
 =?utf-8?B?UlBJQVoybWlkYTFzWmdPa1ZKSzdCNnVqcmwvMXBHV0p0T2lZTDFTSUxRcDBQ?=
 =?utf-8?B?eUVFRkNCVHAxSVhZdkZhWjRKeGR0SmNxTEd1NmVadlVkbFFNNjBqMy92OHZr?=
 =?utf-8?B?Zk9wNUNqY2E3MGFWSWtPdEFjTjdqWkpIN3BiSUZCaTVRV0I5K25sakNqN01J?=
 =?utf-8?B?dGJmRkR6WlM0dlNKWHM3VURaZGFKT0xjd3pDQldYZXBhaDVwNk82Wll0aHB0?=
 =?utf-8?B?MmgwdU1wMG9Gc3lIemFhUmdRTzhMSXdCRGFXc2JIcndHUFZBMHlOK3JleW0y?=
 =?utf-8?B?WTkvZWFxK0FQL1ZoSld2R2F2aFdtdDNQdmhXRS9pRWliTUtocW1PRHo2WWs5?=
 =?utf-8?B?WTlZWjBEUGNBOVVzcjdCMkhabU9jc25MT1IvbUpRdHhKUzhnRlk1ZjlxK3V5?=
 =?utf-8?B?NW5qd1dQcSt1ZzA1dnJ5SElQd0kzQWRWS25FbUJUNm5mRGwvUlRwMnBmZFJH?=
 =?utf-8?B?TWNXRUJ3SlhNNTBDNExBSk9RUVFmNCtId1M1cDE0UHEyZ3gyTXAvN2gxVCsr?=
 =?utf-8?B?aWhPMkRhblpRcktTL3piZHdLZ3Y5ZW9hSVhyamtFR1RWSmN5d2N3dVorcjVM?=
 =?utf-8?B?VUZJaU15UW9TZm9Zd3FvTjlROXdpbnl5ZzBZZTZCVDJkSVl1WkpvVXBLUUJE?=
 =?utf-8?B?dE5UOEEyY1hnNnNUMHpPTXlvcTBmYlJGNWNEV25QbTVuTDZTTFduUXYzUVZ4?=
 =?utf-8?B?SzVxQ1J4bnJWWDVCWkxhZkpYSnZ2M0dwdmdZRVpZNERZaFJEMDAzUXVqNXUr?=
 =?utf-8?B?VitTL2ZhU1JySjFBTDluWGU5UThLc2pmTUloUVJlK1pYMjJtZTQ4alpodXVY?=
 =?utf-8?B?NkU4ZGtFNzFUWjlmQWxuYmQ3a3d6QnNHN1hEMFUrejNtcVAwYnR1cXFLU1Rq?=
 =?utf-8?B?ZWcwbEkySHA0V3VINEFDK0oveTZuaytjYWpvbGM3QVpWNXd1YVFwK2JXZS9R?=
 =?utf-8?Q?xdFtpFVwKul9PzKQk/9YYZGCbyXlIimtFE/kiG9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736f533d-1016-4a18-bb9b-08d95694cf4b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 15:38:58.6524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Cef4fc2eXhBdRPP0bsELgSy8C/q9HypvIQBZxrL/YZzuAjiq4k41zrwmGfQFnrqvIvqojffOIxu+/+4mvp+Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5113
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

Am 2021-08-03 um 11:02 a.m. schrieb Eric Huang:
>
>
> On 2021-07-30 5:26 p.m., Felix Kuehling wrote:
>> Am 2021-07-28 um 1:31 p.m. schrieb Eric Huang:
>>> It is to fix a bug of gpu_recovery on multiple GPUs,
>>> When one gpu is reset, the application running on other
>>> gpu hangs, because kfd post reset doesn't restore the
>>> running process.
>> This will resume all processes, even those that were affected by the GPU
>> reset.
>>
>> The assumption we made here is, that KFD processes can use all GPUs. So
>> when one GPU is reset, all processes are affected. If we want to refine
>> that, we'll need some more complex logic to identify the processes
>> affected by a GPU reset and keep only those processes suspended. This
>> could be based on the GPUs that a process has created queues on, or
>> allocated memory on.
>>
>> What we don't want, is processes continuing with bad data or
>> inconsistent state after a GPU reset.
>>
> Current code doesn't take care of this assumption. When a GPU hangs,
> evicting queues will fail on it and roll back to restore all processes
> queues on other GPUs, and continue to running with unclear state and
> data after a GPU reset.

That's a bug.


>
> The original thought about this patch is to call
> kfd_suspend_all_processes and kfd_restore_all_processes in pair on
> pre_reset and post_reset. And It keeps the consistent behavior for
> both amdgpu_gpu_recover and hang_hws.

This is true for suspend/resume, but not for GPU reset. After a GPU
reset we want queues of affected processes to stay evicted.


>>>   And it also fixes a bug in the function
>>> kfd_process_evict_queues, when one gpu hangs, process
>>> running on other gpus can't be evicted.
>> This should be a separate patch. The code you're removing was there as
>> an attempt to make kfd_process_evict_queues transactional. That means,
>> it either succeeds completely or it fails completely. I wanted to avoid
>> putting the system into an unknown state where some queues are suspended
>> and others are not and the caller has no idea how to proceed. So I roll
>> back a partial queue eviction if something failed.
> Can we let the caller to decide if roll-back is needed? because no all
> the callers need to roll back, e.g. kfd_suspend_all_processes and
> kgd2kfd_quiesce_mm.

I don't think so. If suspend partially succeeds, how can the caller do a
partial roll back? The caller doesn't have the information about what
succeeded and what failed.

But you have a good point. It may depend on the caller whether a
rollback is needed or not. In the case of GPU reset, we don't care so
much about the HW state, but we do care about the queue eviction state.
That must be updated in order to prevent queues to resume after the
reset, no matter what else fails. This could be done by adding a "bool
force" flag to kfd_suspend_all_processes and kfd_process_evict_queues.
If the flag is set we don't roll back and we keep going to suspend
everything even after partial failures.

I think kfd_suspend_all_processes should return an error if force=false
and some error occurred so that kgd2kfd_suspend can return a failure. In
the case of suspend/resume that can stop the suspend process.


>>
>> Your changing this to "try to evict as much as possible". Then a failure
>> does not mean "eviction failed" but "eviction completed but something
>> hung". Then the GPU reset can take care of the hanging part. I think
>> that's a reasonable strategy. But we need to be sure that there are no
>> other error conditions (other than hangs) that could cause a queue
>> eviction to fail.
>>
>> There were some recent changes in pqm_destroy_queue that check the
>> return value of dqm->ops.destroy_queue, which indirectly comes from
>> execute_queues (sam as in the eviction case). -ETIME means a hang. Other
>> errors are possible. Those other errors may still need the roll-back.
>> Otherwise we'd leave stuff running on a non-hanging GPU after we
>> promised that we evicted everything.
> I think it depends on case scenario. GPU reset doesn't need to know
> the return state. Memory eviction may need. Does Memory notifier
> invalidate range need?

You're right in the sense, that for a GPU reset we don't care about the
HW state because we're about to reset it anyway. But we do care about
the queue eviction state of the queues (q->properties.is_evicted). After
the reset completes we don't want the queues of affected processes to be
in evicted state so they are not resumed on the hardware.

In the MMU notifier case (kgd2kfd_quiesce_mm) we do care about the HW
state. When the MMU notifier returns to the caller, it promises that the
HW will no longer access the memory. If the GPU is hanging, that's
probably OK as far as the MMU notifier cares. So this is another case
where we don't want to roll back. Other error cases (not GPU hangs)
would be problematic.

Regards,
  Felix


>>
>> See one more comment inline.
>>
>>
>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c  |  2 +-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 24
>>> +-----------------------
>>>   2 files changed, 2 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> index 24b5e0aa1eac..daf1c19bd799 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> @@ -984,7 +984,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
>>>       if (!kfd->init_complete)
>>>           return 0;
>>>   -    ret = kfd_resume(kfd);
>>> +    ret = kgd2kfd_resume(kfd, false, true);
>> Which branch is this for? On amd-staging-drm-next kgd2kfd_resume only
>> has two parameters.
> Sorry, it is based on dkms staging 5.11. I didn't notice there is
> difference between two branches.
>
> Regards,
> Eric
>>
>> Regards,
>>    Felix
>>
>>
>>>       if (ret)
>>>           return ret;
>>>       atomic_dec(&kfd_locked);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index 38a9dee40785..9272a12c1db8 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -1879,36 +1879,14 @@ int kfd_process_evict_queues(struct
>>> kfd_process *p)
>>>   {
>>>       int r = 0;
>>>       int i;
>>> -    unsigned int n_evicted = 0;
>>>         for (i = 0; i < p->n_pdds; i++) {
>>>           struct kfd_process_device *pdd = p->pdds[i];
>>>             r = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
>>>                                   &pdd->qpd);
>>> -        if (r) {
>>> +        if (r)
>>>               pr_err("Failed to evict process queues\n");
>>> -            goto fail;
>>> -        }
>>> -        n_evicted++;
>>> -    }
>>> -
>>> -    return r;
>>> -
>>> -fail:
>>> -    /* To keep state consistent, roll back partial eviction by
>>> -     * restoring queues
>>> -     */
>>> -    for (i = 0; i < p->n_pdds; i++) {
>>> -        struct kfd_process_device *pdd = p->pdds[i];
>>> -
>>> -        if (n_evicted == 0)
>>> -            break;
>>> -        if (pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dqm,
>>> -                                  &pdd->qpd))
>>> -            pr_err("Failed to restore queues\n");
>>> -
>>> -        n_evicted--;
>>>       }
>>>         return r;
>
