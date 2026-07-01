Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E03C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 13:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8ADE10E199;
	Wed,  1 Jul 2026 13:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TLwCuGQR";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 047AA10E199
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 13:32:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8vq1bYfOZuCJSaTNIJsn57cTpemBZdplWDxvenrQsOXan+fRhbPuvf9uPssDNpCDSd7vQiMuFZVYRJzhS4Ute3H0aYeYSmH/4njNOWUHUaw04689Nodv0+WSGstCoLVmGSPd4zjYqHbhCPA+0SqqbYhbYogDwiyx78DjMkg9klleDk4ym1S1dkQYMKRF3v8r0Vuef73CUS56dutD2pzIShLVm3/hGsKbfhcL9eJqCVJ3tDH8WnC+/4RzysGjnhdQp+4N49LrMeM2cKU0FCNIkYbdWRxPEd2VDQl3p2WlAZOe+hGON0UW4n6HWFph+jyCiIGT/we/lYs32JMHpGCdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGwwMOOQ9KOFPPMuk2zmvx1NINcVGUKxfS3/tlq2MZY=;
 b=q9wFtaCNZCGM0qXjNwtLK4Io9Y1s5DsQh+Fberi5pKZ0YUEs+RkPolC7lMFTgXWyoE8kCal97lzDg3+vuzCc0SPDeSgj88Vg1Xz3veT/QtDvS4r7DHTRosCstw+z8dmeX0/cEiti1wb2Z8v1S115IOU6mYgO8iGtCHb5t9Fgvbpc4ayx1BgX1aKdvdJ/sAkgxN/lglQr8PFpP8SFb0QBUExhCcKiTbNnZ0HpQvdd75kekc1OzTJlbhzdU7mPFzaQhQhJdwM1lFFGnITJL3q612Vvl5DgzykW0tWl/0IwTZXrK1aW2C1OCYwPwijDd2Z3MhHwCOxenyTrM3z8BZoZiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGwwMOOQ9KOFPPMuk2zmvx1NINcVGUKxfS3/tlq2MZY=;
 b=TLwCuGQRKlnkjHIiY0S5YDvQ1kgKYK5pNRAwtMb5gf/ifNp1y7LHBynp965hrZ1fxPF9H4W3NXfMc4qBfkhBf60UxhZfaEt1mya0gcRl79fZeOcuM9yoQnOIjzjVDUKnOGQ8pzsN1MjIco/FOk9IrKYlXBpfC+QKUWtdm6AE4RE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 13:32:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 13:32:24 +0000
Message-ID: <f705894d-0e95-4e50-b15c-f827f12a2381@amd.com>
Date: Wed, 1 Jul 2026 15:32:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix VM status/vm_bo->moved locking
To: Natalie Vock <natalie.vock@gmx.de>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20260701113340.466177-1-natalie.vock@gmx.de>
 <ef3a15a5-ea21-4ec3-a1b9-2a6a51987e36@amd.com>
 <257de090-8c25-4158-9df3-42be3aef890c@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <257de090-8c25-4158-9df3-42be3aef890c@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a595268-dae4-4a11-c6e7-08ded7752f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|3023799007|5023799004|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: J3PUwem65eSNBYWKX6kaF5ND851wClCGSfU5Kc4D/ZZ05s4zpRNMJJGsnP8LjY85P2sU9jBBYEBUhIbv3DjDKB5Gq0DIHlTCipOOh8vaz7LOWlgNkS/FiAeIddVcuhlQNwmYHxlnHjjXN9zAkkD8jwwk6W3qSoNdWUkRFanRpp2VgvkX9T1GmpyaSbdnW6M8TfbB7uMLTlEIaz5udl9KG3nAOj09Uz8FxQRHrpviUDlmQ4wCLmEkNmjKK54sAgLOInHZqtrqr8HBwHA81pII0oSVVXlKxo0vaEn4yZWmO7pK3PebBshpR5QLudRvkHIS0hwVCytsy6AflgRU28tmBiYwPWZkHgQVErG3n01pMGDqfy+d3Tl8qMCYYMB9iPMbA2qYs6cYiTiqr8omGRYBOQRMYpaVYSJaPFMCMP4hMUY5ntKrrdEpS2mlI85FE51xw08q/qwjkD04/v14/wVt1PzTLcm+baAauPq4t9I0iNME3sGqhmS53ZuegKIW6UngRdf0qTE+Ezk0wNS1Juv6BIbpp24U6lKUFkLXB8Dz7guAITQbYbOQXeJgADcUC1sNYCs1tlI/vgQ8u4myWE9mVRHg2Qn/276zwEPQD6a4km/o6ChZ5eCRaXlJgJyg17Qx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(3023799007)(5023799004)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTZqMEF6NEs3cElBK3p1REM0UE9FSVNvWXlGTnBDUWhPRGVUTW01SzIxeW9x?=
 =?utf-8?B?d1NuTGgwQUREdm5pRElRQ2xrcnZlZE50MVFNeVBBaEhKUDVmZy9EN3VOMG9y?=
 =?utf-8?B?amhoejdwWDJTWDhQQjFROHNCbExaMzMzU2hZNTBlWTFiU0xrTDN6blFROHhI?=
 =?utf-8?B?UEJHejVhZndtSlU2eERkb1o1NEpzZDlVWG1LblNuc3VUT1BvWitKaFVLMzM5?=
 =?utf-8?B?WkhQVkIwYmxQT3RrQ0NVN0NsaG1tU3BIQTB6aEdZZjlQV0V2cmJTMmtFWHVt?=
 =?utf-8?B?Y2pTVmdKem05UmpheXRyNEp2dTJBdG5iU0tHMjg5eU9abHpZY096VTBaVVU0?=
 =?utf-8?B?eTlZc0paY2xENFFGYmdFV0JrSTBmRnR3T2pEVUY1T05YMnErQkJmRTBtRFlX?=
 =?utf-8?B?c1ZMZ1E1T0ZRWGFuOWVzek9Lakg4QlF6cjBmL2JhNmVGRXJzaVgyUXJUZlhG?=
 =?utf-8?B?QWQwUEwxNitVSjBwdmpKeStRdkF2cDdmKzBuTU1vdnZJUTlQZEhOYzNoR01F?=
 =?utf-8?B?dGd0M08yYUJ6a05LV1NWYVFBKzd1S2NuVDNaVE4vMDdPUStiTFlXdGNCVita?=
 =?utf-8?B?enBiWGpoUE55azNERm50MFhQQjZSbXcvWlFTNGdOb3R6MnU3UnQrTEE2SVdr?=
 =?utf-8?B?akp3SWJJbVpjdTk3N1BjaXBtb0xwcG43eWIzb0xPNFNxZVB3S1FPZHRNaTh0?=
 =?utf-8?B?NCtZU2NOQ2t1Ny9sKzY2YVhxVmhIYjZtT3o2UkhqK0dGUTgzdW9EUUpNRUdt?=
 =?utf-8?B?VGVWVzd0UzFNUk1MRmdIcWJ3dDNNS3FRaWt2ejd2UGhna0llbEtWejR2cmMy?=
 =?utf-8?B?MDh1UXpyVFpiU1FYbWpRQ2RySDBNcHo5OGo1MTZIT1FHU1lwaDFiaUJpbWl2?=
 =?utf-8?B?MkRHNm0rMHRuU1ZCVGVHdFZ1aXpERlBsZ0hJVGtQa1R6U2NnMmJFSzc3NWl2?=
 =?utf-8?B?aTVqL0lCMTFEY0syTXlNS2xqQTFta1B5NGRLMXZGK2RPemJzNlBUQWo1RklN?=
 =?utf-8?B?QWpGOUE4SHBockJqKzRsSVdHaWJ1V0dJcU1vaHFQbGZYajFaNW9wOGJqN015?=
 =?utf-8?B?WkNhQW1vTDFwdEhyOXJBT2FiRTJxRGx5RXJsb3F0Uk9UYkNpcUlhdVB0QjhO?=
 =?utf-8?B?VDNBVGZEeUhGU3VoaG9QaTNGUklWL2JwUEpQN2oyejVHS0FtTU9rT2ZWM0Y2?=
 =?utf-8?B?Vk56UDZOMnpDZzV1NVNBcG9XMk5rL3RQZE1qQWZKMVl1dHRqMHlWWEVaVUVa?=
 =?utf-8?B?TkcwaFBrbnRCeWpKN0p6NXNROUpKd0RHUnlnRXoweGVRVXBxQkUwQkx3V3M3?=
 =?utf-8?B?NmpBVTUxS3pRdGJVSDd2ZG0xbjFBMGdweE9KcFQzMm03UGIxekpyTXhFM3h5?=
 =?utf-8?B?UzdUdUp5TFBDZk55UmdnbGQzL0E4MmI0VGw4N3hiUHRSM1BubGVleGxDWDE3?=
 =?utf-8?B?SzNoRTl6WThnajZZb0JqcDA4NmdTWGNmK0dEN0V3cEVIUDJxdU5YeU5OQ2py?=
 =?utf-8?B?MU9sSkYyayt1M1ZpdVpINmNtT1VCQmN1V1U1VytTWmJXZTZ3SmwySTQ2RW9o?=
 =?utf-8?B?Z2lSRnRjMDZlRXRtbjJRZFlBZDF6Z0NJaWN6UFFmaFBSelErNzF4MThUQzl0?=
 =?utf-8?B?Z0d0eW1wWFhRVnYzQUVHVTJVV0lFYzVmeGFYa3NKM1M0RzdBaUtUTFJrWXp0?=
 =?utf-8?B?YlFNa3gwbTFQZTFPSDRFd01LQWVNNlFGRFFSRjlNNUtwNkdhNFgrSTJ6ZzRB?=
 =?utf-8?B?eDVWUTJEdkVTa05NUHFiN2lyU2hYTEp1ZVE0RTJETlBhdmN0Z2lKdTB2TUJv?=
 =?utf-8?B?blRxTUs0ZFNzTUdIZVlmRmVON3ErNC9MYndZc0Y1RmlocjlYdS9HNWVocUVQ?=
 =?utf-8?B?VUl4T1RzWDQwTnJNejBDS3VTT0VCS3dmY01ET3BNenlYSm5JQkdtWXNWdmVn?=
 =?utf-8?B?cVhsZysrSFgwMVpiME4yaU1pVFl4emgwRE9PcmJOZDZ2cC9zTWxQbTlES2JH?=
 =?utf-8?B?clYxWGdERC94Y2JEcWpmSkpNVFRaYnFaeEpKdUpqeldXcitLZVpnU2RuQ3Zx?=
 =?utf-8?B?TVhKOGpnNEIwVlpGYnJKVjU5M1AyeHQ0RzMrTkdSd0VndXNvL0grR0t4S2Zk?=
 =?utf-8?B?RnRHYlJQaCswaXQrM1BHWHlYSmRqUVZOdFJOcEdOUXJkZTE4UjdvOXYyV1ZH?=
 =?utf-8?B?VmpEeTJvMnU1dzdETitUTTZKTU1GRE5kY1M5NnVPekpZS0o5NVFwRFJhVkEw?=
 =?utf-8?B?M2tyaVZDam85WXVrWWNiM1ZudUNkZ0s1c0l3ekI2MDgvUHNSd2t0dzdMM1Vx?=
 =?utf-8?Q?RJwtEmagt3LcLKOArw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a595268-dae4-4a11-c6e7-08ded7752f89
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 13:32:24.5022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64tyrR80Aq5ZVcCAq9iu1GRSEu+BXsltntkvY/UohO9k2abQOjDQfoaI3MdeoQwo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
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

Hi,

On 7/1/26 15:13, Natalie Vock wrote:
> Hi,
> 
> On 7/1/26 14:26, Christian König wrote:
>> On 7/1/26 13:33, Natalie Vock wrote:
>>> We claimed vm_bo->moved was protected by the BO being reserved, but then
>>> accessed it in a bunch of places without a reservation to the BO anyway.
>>
>> Can you point out where? That clearly doesn't sound correct to me.
> 
> Right, actually on rechecking it's just one place, see below.
> 
>>
>> We have some questionable uses for userptrs, but those should be irrelevant.
>>
>>>
>>> It's not sensible to protect this by BO reservation in any case - it's a
>>> property relating to VM state, just like vm_status. Let's protect this
>>> by vm->status_lock as well. We usually grab the lock at some point when
>>> we access the field anyway, so it fits well with the current usage of
>>> the field.
>>
>> That won't work. You can't hold the status lock while the moved flag can't be modified.
> 
> I know holding the status spinlock throughout the entire runtime of amdgpu_vm_bo_update is not viable, and I'm not trying to do that here. Is there another period where the moved flag absolutely can't be modified?
> 
>>
>>> We also need to remove some unprotected accesses of the field when
>>> removing a mapping. Checking for the field there was a microoptimization
>>> anyway.
>>>
>>> Lastly, and most critically, we also need to handle buffer
>>> moves/invalidations racing with amdgpu_vm_bo_update. Otherwise we might
>>> accidentally undo the invalidation without the PTs actually being
>>> properly updated.
>>
>> That's not correct as far as I can see the moves/invalidations can perfectly happen in paralell and are handled before the next CS.
> 
> The race requires some setup:
> 1. Assume we're talking about a BO with its own resv, i.e. a not-VM-always-valid buffer.
> 2. Assume the BO is already in the invalidated list.
> 3. Assume one thread is trying to evict the buffer and therefore holds the reservation object.
> 4. Assume another thread is trying to submit a CS that does *not* have this buffer in the BO list, that is, it is not reserved by the CS ioctl.
> 
> Now, imagine the submitting thread is currently in amdgpu_vm_handle_moved, and ends up encountering that BO while iterating through the invalidated list here:
> https://elixir.bootlin.com/linux/v7.0-rc7/source/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c#L1639.
> 
> dma_resv_trylock() fails, and the caller is not holding the reservation lock. Still, as intended, we try updating the PTs and enter amdgpu_vm_bo_update (while *not* holding the resv).
> 
> For one, vm_bo->moved is accessed here:
> https://elixir.bootlin.com/linux/v7.0-rc7/source/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c#L1345

No it isn't. The clear flag is true when the BOs reservation lock isn't held.

So we never depend on the moved flag here.

> and set here:
> https://elixir.bootlin.com/linux/v7.0-rc7/source/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c#L1396

Correct, but that is irrelevant. The cleared flag is set which overrides the moved flag on the next update.

We could add something like "if (!cleared) bo_va->base.moved = false;", but that doesn't really matter.

As soon as the cleared flag is set to true the moved flag becomes irrelevant.

> 
> AFAIU, both of these may race with something else.
> 
> Also, the evicting thread may finish calling amdgpu_bo_move_notify before the thread running amdgpu_vm_bo_update reaches the amdgpu_vm_bo_done here:
> https://elixir.bootlin.com/linux/v7.0-rc7/source/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c#L1391
> 
> If that happens, then the BO is marked as idle again even though the concurrent eviction had just invalidated the mappings. I'm like 98% sure I've run into page faults on supposedly mapped addresses precisely due to this. :)

Ah! Yes, absolutely great catch!

That is certainly possible and potentially a bug I have been searching for ages.

If I'm not completely mistaken we need to do the status update before dropping the lock in amdgpu_vm_handle_moved() (BTW you forgot to rename that one in your rename patch).

Thanks a lot for finding that one,
Christian.

> 
> Best,
> Natalie
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
>>> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>>> ---
>>> FWIW, I'm not 100% positive on whether the Fixes tag is correct - I'm
>>> fairly certain the VM update <-> invalidation race existed ever since
>>> the driver's inception, but it may have been hidden in the initial
>>> revision. I suspect backporting it all the way to wherever the race
>>> started manifesting is roughly similarly painful, though.
>>>
>>> Also, this patchset is based on my previous one to rename the "moved" VM
>>> state to "needs_update". I think it got reviewed and should've been
>>> picked up, but I'm not sure I see it in amd-staging-drm-next?
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 108 +++++++++++++++++--------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   3 +-
>>>   2 files changed, 75 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 32719f31b6c9e..3451dca7de194 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -214,11 +214,12 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>>>    * amdgpu_vm_bo_needs_update - vm_bo needs pagetable update
>>>    *
>>>    * @vm_bo: vm_bo which is out of date
>>> + * @moved: whether the vm_bo was moved
>>>    *
>>>    * State for vm_bo objects meaning the underlying BO had mapping changes (move, PRT bind/unbind)
>>>    * but the new location is not yet reflected in the page tables.
>>>    */
>>> -static void amdgpu_vm_bo_needs_update(struct amdgpu_vm_bo_base *vm_bo)
>>> +static void amdgpu_vm_bo_needs_update(struct amdgpu_vm_bo_base *vm_bo, bool moved)
>>>   {
>>>       struct amdgpu_vm_bo_status *lists;
>>>       struct amdgpu_bo *bo = vm_bo->bo;
>>> @@ -232,11 +233,28 @@ static void amdgpu_vm_bo_needs_update(struct amdgpu_vm_bo_base *vm_bo)
>>>           vm_bo->moved = false;
>>>           list_move(&vm_bo->vm_status, &lists->idle);
>>>       } else {
>>> +        if (moved)
>>> +            vm_bo->moved = true;
>>>           list_move(&vm_bo->vm_status, &lists->needs_update);
>>>       }
>>>       amdgpu_vm_bo_unlock_lists(vm_bo);
>>>   }
>>>   +/**
>>> + * amdgpu_vm_bo_idle_locked - vm_bo is idle, already-locked version
>>> + *
>>> + * @vm_bo: vm_bo which is now idle
>>> + *
>>> + * State for vm_bo objects meaning we are done with the state machine and no
>>> + * further action is necessary. Needs to supply a locked status list.
>>> + */
>>> +static void amdgpu_vm_bo_idle_locked(struct amdgpu_vm_bo_base *vm_bo,
>>> +                  struct amdgpu_vm_bo_status *lists)
>>> +{
>>> +    if (!amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
>>> +        vm_bo->moved = false;
>>> +    list_move(&vm_bo->vm_status, &lists->idle);
>>> +}
>>>   /**
>>>    * amdgpu_vm_bo_idle - vm_bo is idle
>>>    *
>>> @@ -250,9 +268,7 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>>>       struct amdgpu_vm_bo_status *lists;
>>>         lists = amdgpu_vm_bo_lock_lists(vm_bo);
>>> -    if (!amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
>>> -        vm_bo->moved = false;
>>> -    list_move(&vm_bo->vm_status, &lists->idle);
>>> +    amdgpu_vm_bo_idle_locked(vm_bo, lists);
>>>       amdgpu_vm_bo_unlock_lists(vm_bo);
>>>   }
>>>   @@ -273,9 +289,9 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>>>        */
>>>       amdgpu_vm_assert_locked(vm);
>>>       list_for_each_entry_safe(vm_bo, tmp, &vm->kernel.idle, vm_status)
>>> -        amdgpu_vm_bo_needs_update(vm_bo);
>>> +        amdgpu_vm_bo_needs_update(vm_bo, false);
>>>       list_for_each_entry_safe(vm_bo, tmp, &vm->always_valid.idle, vm_status)
>>> -        amdgpu_vm_bo_needs_update(vm_bo);
>>> +        amdgpu_vm_bo_needs_update(vm_bo, false);
>>>         spin_lock(&vm->individual_lock);
>>>       list_for_each_entry_safe(vm_bo, tmp, &vm->individual.idle, vm_status) {
>>> @@ -435,7 +451,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>>>        */
>>>       if (bo->preferred_domains &
>>>           amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type))
>>> -        amdgpu_vm_bo_needs_update(base);
>>> +        amdgpu_vm_bo_needs_update(base, false);
>>>       else
>>>           amdgpu_vm_bo_evicted(base);
>>>   }
>>> @@ -607,8 +623,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>               return r;
>>>             vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
>>> -        bo_base->moved = true;
>>> -        amdgpu_vm_bo_needs_update(bo_base);
>>> +        amdgpu_vm_bo_needs_update(bo_base, true);
>>>       }
>>>         /*
>>> @@ -625,8 +640,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>           if (r)
>>>               return r;
>>>   -        bo_base->moved = true;
>>> -        amdgpu_vm_bo_needs_update(bo_base);
>>> +        amdgpu_vm_bo_needs_update(bo_base, true);
>>>       }
>>>         if (!ticket)
>>> @@ -646,8 +660,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>           if (r)
>>>               return r;
>>>   -        bo_base->moved = true;
>>> -        amdgpu_vm_bo_needs_update(bo_base);
>>> +        amdgpu_vm_bo_needs_update(bo_base, true);
>>>             /* It's a bit inefficient to always jump back to the start, but
>>>            * we would need to re-structure the KFD for properly fixing
>>> @@ -1266,16 +1279,38 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>>>       struct amdgpu_bo *bo = bo_va->base.bo;
>>>       struct amdgpu_vm *vm = bo_va->base.vm;
>>>       struct amdgpu_bo_va_mapping *mapping;
>>> +    struct amdgpu_vm_bo_status *lists;
>>>       struct dma_fence **last_update;
>>>       dma_addr_t *pages_addr = NULL;
>>>       struct ttm_resource *mem;
>>>       struct amdgpu_sync sync;
>>>       bool flush_tlb = clear;
>>> +    bool uncached, moved;
>>>       uint64_t vram_base;
>>>       uint64_t flags;
>>> -    bool uncached;
>>>       int r;
>>>   +    /* Everything we access in here is protected by the VM PD lock. */
>>> +    amdgpu_vm_assert_locked(vm);
>>> +
>>> +    lists = amdgpu_vm_bo_lock_lists(&bo_va->base);
>>> +    /*
>>> +     * We can't hold the spinlock for the entire VM update, so temporarily remove
>>> +     * the BO from the state machine entirely. This does not prevent all types of
>>> +     * races: We might not hold the BO's resv here, so TTM is free to move the buffer
>>> +     * and thereby invalidate it. However, it allows us to detect if we raced with
>>> +     * something that invalidated the BO again and handle that appropriately below.
>>> +     */
>>> +    list_del_init(&bo_va->base.vm_status);
>>> +
>>> +    /*
>>> +     * The moved flag is also protected by the status lock. It's fine if some buffer
>>> +     * update changes bo_va->base.moved while we're updating the PTs after unlocking
>>> +     * the status lock, since that also invalidates the BO's VM status again.
>>> +     */
>>> +    moved = bo_va->base.moved;
>>> +    amdgpu_vm_bo_unlock_lists(&bo_va->base);
>>> +
>>>       amdgpu_sync_create(&sync);
>>>       if (clear) {
>>>           mem = NULL;
>>> @@ -1343,7 +1378,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>>>       else
>>>           last_update = &bo_va->last_pt_update;
>>>   -    if (!clear && bo_va->base.moved) {
>>> +    if (!clear && moved) {
>>>           flush_tlb = true;
>>>           list_splice_init(&bo_va->valids, &bo_va->invalids);
>>>   @@ -1389,20 +1424,38 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>>>           else
>>>               amdgpu_vm_bo_idle(&bo_va->base);
>>>       } else {
>>> -        amdgpu_vm_bo_idle(&bo_va->base);
>>> +        lists = amdgpu_vm_bo_lock_lists(&bo_va->base);
>>> +        /*
>>> +         * Now that we're holding the lock again, check if the
>>> +         * buffer got invalidated while we weren't looking.
>>> +         * We initialized vm_status to an empty list head above,
>>> +         * if that's still the case we can safely mark the BO as
>>> +         * done.
>>> +         *
>>> +         * Note: We only need to do this for BOs that are not
>>> +         * VM-always-valid, because we hold the VM's reservation
>>> +         * which by definition reserves all VM-always-valid BOs.
>>> +         */
>>> +        if (list_empty(&bo_va->base.vm_status))
>>> +            amdgpu_vm_bo_idle_locked(&bo_va->base, lists);
>>> +        amdgpu_vm_bo_unlock_lists(&bo_va->base);
>>>       }
>>>         list_splice_init(&bo_va->invalids, &bo_va->valids);
>>>       bo_va->cleared = clear;
>>> -    bo_va->base.moved = false;
>>>         if (trace_amdgpu_vm_bo_mapping_enabled()) {
>>>           list_for_each_entry(mapping, &bo_va->valids, list)
>>>               trace_amdgpu_vm_bo_mapping(mapping);
>>>       }
>>>   +    amdgpu_sync_free(&sync);
>>> +    return 0;
>>> +
>>>   error_free:
>>>       amdgpu_sync_free(&sync);
>>> +    if (r)
>>> +        amdgpu_vm_bo_needs_update(&bo_va->base, false);
>>>       return r;
>>>   }
>>>   @@ -1779,7 +1832,6 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
>>>                       struct amdgpu_bo_va_mapping *mapping)
>>>   {
>>>       struct amdgpu_vm *vm = bo_va->base.vm;
>>> -    struct amdgpu_bo *bo = bo_va->base.bo;
>>>         mapping->bo_va = bo_va;
>>>       list_add(&mapping->list, &bo_va->invalids);
>>> @@ -1788,8 +1840,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
>>>       if (mapping->flags & AMDGPU_VM_PAGE_PRT)
>>>           amdgpu_vm_prt_get(adev);
>>>   -    if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
>>> -        amdgpu_vm_bo_needs_update(&bo_va->base);
>>> +    amdgpu_vm_bo_needs_update(&bo_va->base, false);
>>>         trace_amdgpu_vm_bo_map(bo_va, mapping);
>>>   }
>>> @@ -2090,30 +2141,22 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>>>         /* Insert partial mapping before the range */
>>>       if (!list_empty(&before->list)) {
>>> -        struct amdgpu_bo *bo = before->bo_va->base.bo;
>>> -
>>>           amdgpu_vm_it_insert(before, &vm->va);
>>>           if (before->flags & AMDGPU_VM_PAGE_PRT)
>>>               amdgpu_vm_prt_get(adev);
>>>   -        if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
>>> -            !before->bo_va->base.moved)
>>> -            amdgpu_vm_bo_needs_update(&before->bo_va->base);
>>> +        amdgpu_vm_bo_needs_update(&before->bo_va->base, false);
>>>       } else {
>>>           kfree(before);
>>>       }
>>>         /* Insert partial mapping after the range */
>>>       if (!list_empty(&after->list)) {
>>> -        struct amdgpu_bo *bo = after->bo_va->base.bo;
>>> -
>>>           amdgpu_vm_it_insert(after, &vm->va);
>>>           if (after->flags & AMDGPU_VM_PAGE_PRT)
>>>               amdgpu_vm_prt_get(adev);
>>>   -        if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
>>> -            !after->bo_va->base.moved)
>>> -            amdgpu_vm_bo_needs_update(&after->bo_va->base);
>>> +        amdgpu_vm_bo_needs_update(&after->bo_va->base, false);
>>>       } else {
>>>           kfree(after);
>>>       }
>>> @@ -2285,10 +2328,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
>>>               continue;
>>>           }
>>>   -        if (bo_base->moved)
>>> -            continue;
>>> -        bo_base->moved = true;
>>> -        amdgpu_vm_bo_needs_update(bo_base);
>>> +        amdgpu_vm_bo_needs_update(bo_base, true);
>>>       }
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index c1bd4d35831e0..0acd889568a38 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -212,8 +212,7 @@ struct amdgpu_vm_bo_base {
>>>        * protected by vm BO being reserved */
>>>       bool                shared;
>>>   -    /* if the BO was moved and all mappings are invalid
>>> -     * protected by the BO being reserved */
>>> +    /* protected by the vm's status lock */
>>>       bool                moved;
>>>   };
>>>   
>>
> 

