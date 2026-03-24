Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5614FF54AAD
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 13:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5F0810E5D4;
	Tue, 24 Mar 2026 13:13:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="gLofZERV";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="UGY/oR8Z";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B3710E5D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 13:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1774357991;
 bh=YPHWKwLSM9UCYHDVXK+hUGr
 O64LdMqM5Gteg/LhpMBM=; b=gLofZERVyXM41RuQQSvSOsX3nnyjVSqZDjmv89L1lV7pdrnvgg
 syxcEFADvtcddmEqoqPgy+li0F7jKJTtHwA1V0SEVBuMC76u1Gd4Emxjog5RY9EkU9Yhs75sS+L
 fbbSypmUAc/48dfzSj47ttocf+/S3ZYDn+nju7zQFgKiU77T1fmBK2fsf5VJeIGToEAqNW8HfK4
 1TS4oqH52oz4HwflLoum/l7Uw4tc+9cGciH5vbSfuHSHuak1eq5nzozmbeOW3eRaEzB/FFtrb+f
 Dga4HHgUPiByVvWYKMAbKAosILaTvhBjndofm4YEsQA+45f1I6TDwHIABr4ufnOulWA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1774357991; bh=YPHWKwLSM9UCYHDVXK+hUGr
 O64LdMqM5Gteg/LhpMBM=; b=UGY/oR8ZkT8A8lDrneHMX0B55HaEg6sDeORPvSLlt2rPwu5mtb
 40FiY1SbWBlCiQ0ztJYpawo/tWll07rlvaBg==;
Message-ID: <417ea81c-1517-4271-9a07-4acfaf9d769e@damsy.net>
Date: Tue, 24 Mar 2026 14:13:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: guard atom_context in devcoredump VBIOS
 dump
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>, "Jesse.Zhang" <Jesse.Zhang@amd.com>,
 amd-gfx@lists.freedesktop.org,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: Alexander.Deucher@amd.com
References: <20260324012618.626710-1-Jesse.Zhang@amd.com>
 <ad42e9d3-826e-41fe-9810-49824cc9a741@amd.com>
 <06240d38-2cc0-4d2b-beb1-fc7f8e5caf1c@damsy.net>
 <705540c3-f1d1-4abe-ba87-571e72118ea2@amd.com>
 <09e8488c-920d-444a-83f4-f8e751625da5@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <09e8488c-920d-444a-83f4-f8e751625da5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



Le 24/03/2026 à 13:38, Christian König a écrit :
> On 3/24/26 11:28, Lazar, Lijo wrote:
>>
>>
>> On 24-Mar-26 3:43 PM, Pierre-Eric Pelloux-Prayer wrote:
>>>
>>>
>>> Le 24/03/2026 à 10:42, Christian König a écrit :
>>>> On 3/24/26 02:26, Jesse.Zhang wrote:
>>>>> During GPU reset coredump generation, amdgpu_devcoredump_fw_info() unconditionally
>>>>> dereferences adev->mode_info.atom_context to print VBIOS fields. On reset/teardown
>>>>> paths this pointer can be NULL, causing a kernel page fault from the deferred
>>>>> coredump workqueue.
>>>>>
>>>>> Fix by checking ctx before printing VBIOS fields:
>>>>>
>>>>> if ctx is valid, print full VBIOS information as before;
>>>>> This prevents NULL-dereference crashes while preserving coredump output.
>>>>>
>>>>> Observed page fault log:
>>>>> [  667.933329] RIP: 0010:amdgpu_devcoredump_format+0x780/0xc00 [amdgpu]
>>>>> [  667.941517] amdgpu 0002:01:00.0: Dumping IP State
>>>>> [  667.949660] Code: 8d 57 74 48 c7 c6 01 65 9f c2 48 8d 7d 98 e8 97 96 7a ff 49 8d 97 b4 00 00 00 48 c7 c6 18 65 9f c2 48 8d 7d 98 e8 80 96 7a ff <41> 8b 97 f4 00 00 00 48 c7 c6 2f 65 9f c2 48 8d 7d 98 e8 69 96 7a
>>>>> [  667.949666] RSP: 0018:ffffc9002302bd50 EFLAGS: 00010246
>>>>> [  667.949673] RAX: 0000000000000000 RBX: ffff888110600000 RCX: 0000000000000000
>>>>> [  667.949676] RDX: 000000000000a9b5 RSI: 0000000000000405 RDI: 000000000000a999
>>>>> [  667.949680] RBP: ffffc9002302be00 R08: ffffffffc09c3084 R09: ffffffffc09c3085
>>>>> [  667.949684] R10: 0000000000000000 R11: 0000000000000004 R12: 00000000000048e0
>>>>> [  667.993908] amdgpu 0002:01:00.0: Dumping IP State Completed
>>>>> [  667.994229] R13: 0000000000000025 R14: 000000000000000c R15: 0000000000000000
>>>>> [  667.994233] FS:  0000000000000000(0000) GS:ffff88c44c2c9000(0000) knlGS:0000000000000000
>>>>> [  668.000076] amdgpu 0002:01:00.0: [drm] AMDGPU device coredump file has been created
>>>>> [  668.008025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [  668.008030] CR2: 00000000000000f4 CR3: 000000011195f001 CR4: 0000000000770ef0
>>>>> [  668.008035] PKRU: 55555554
>>>>> [  668.008040] Call Trace:
>>>>> [  668.008045]  <TASK>
>>>>> [  668.016010] amdgpu 0002:01:00.0: [drm] Check your /sys/class/drm/ card16/device/devcoredump/data
>>>>> [  668.023967]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>>> [  668.023988]  ? __pfx___drm_printfn_coredump+0x10/0x10 [drm]
>>>>> [  668.031950] amdgpu 0003:01:00.0: Dumping IP State
>>>>> [  668.038159]  ? __pfx___drm_puts_coredump+0x10/0x10 [drm]
>>>>> [  668.083017] amdgpu 0003:01:00.0: Dumping IP State Completed
>>>>> [  668.083824]  amdgpu_devcoredump_deferred_work+0x26/0xc0 [amdgpu]
>>>>> [  668.086163] amdgpu 0003:01:00.0: [drm] AMDGPU device coredump file has been created
>>>>> [  668.095863]  process_scheduled_works+0xa6/0x420
>>>>> [  668.095880]  worker_thread+0x12a/0x270
>>>>> [  668.101223] amdgpu 0003:01:00.0: [drm] Check your /sys/class/drm/ card24/device/devcoredump/data
>>>>> [  668.107441]  kthread+0x10d/0x230
>>>>> [  668.107451]  ? __pfx_worker_thread+0x10/0x10
>>>>> [  668.107458]  ? __pfx_kthread+0x10/0x10
>>>>> [  668.112709] amdgpu 0000:01:00.0: ring vcn_unified_1 timeout, signaled seq=9, emitted seq=10
>>>>> [  668.118630]  ret_from_fork+0x17c/0x1f0
>>>>> [  668.118640]  ? __pfx_kthread+0x10/0x10
>>>>> [  668.118647]  ret_from_fork_asm+0x1a/0x30
>>>>>
>>>>> v4: fix the race concern without introducing VBIOS snapshot state.
>>>>>
>>>>> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
>>>>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 16 ++++++++++------
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  4 ++++
>>>>>    2 files changed, 14 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/ drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>>>>> index bbb5afd67b49..5aa46480f05f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>>>>> @@ -192,12 +192,16 @@ static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
>>>>>        drm_printf(p, "VPE feature version: %u, fw version: 0x%08x\n",
>>>>>               adev->vpe.feature_version, adev->vpe.fw_version);
>>>>> -    drm_printf(p, "\nVBIOS Information\n");
>>>>> -    drm_printf(p, "vbios name       : %s\n", ctx->name);
>>>>> -    drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
>>>>> -    drm_printf(p, "vbios version    : %d\n", ctx->version);
>>>>> -    drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
>>>>> -    drm_printf(p, "vbios date       : %s\n", ctx->date);
>>>>> +    if (adev->bios) {
>>>>> +        drm_printf(p, "\nVBIOS Information\n");
>>>>> +        drm_printf(p, "vbios name       : %s\n", ctx->name);
>>>>> +        drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
>>>>> +        drm_printf(p, "vbios version    : %d\n", ctx->version);
>>>>> +        drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
>>>>> +        drm_printf(p, "vbios date       : %s\n", ctx->date);
>>>>> +    }else {
>>>>> +        drm_printf(p, "\nVBIOS Information: NA\n");
>>>>> +    }
>>>>>    }
>>>>>    static ssize_t
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/ gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index fbe553c38583..69f4549e6271 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -4260,6 +4260,10 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>>>>        /* free i2c buses */
>>>>>        amdgpu_i2c_fini(adev);
>>>>> +#ifdef CONFIG_DEV_COREDUMP
>>>>> +    /* Make sure deferred coredump formatting is done before tearing down VBIOS/ATOM. */
>>>>> +    flush_work(&adev->coredump_work);
>>>>> +#endif
>>>>
>>>> Looks correct to me of hand, but I'm not very familiar with this part of the code.
>>>>
>>>> @Pierre-Eric and @Sunil can you take a look as well? You two have done more with devcoredump then me.
>>>
>>> The worker thread doesn't access the HW but it still reads some things from the adev pointer.
>>> Ideally, anything the worker needs should be copied to amdgpu_coredump_info from amdgpu_coredump.
>>> Then the worker would only ever access its own state.
>>>
>>
>> Hi Pierre,
>>
>> amdgpu_devcoredump_deferred_work -> amdgpu_devcoredump_format() -> ip_block->version->funcs->print_ip_state(ip_block, &p);
>>
>> This accesses hw state.
>>
>> A newer version of the patch is posted which moves flush work inside fini hw befor IP tear down.
> 
> That sounds reasonable to me.

+1

> 
> I mean we don't need to copy static information into amdgpu_coredump_info (e.g. like BIOS info), but things like print_ip_state() clearly needs to execute outside of the worker since the dumped HW state is destroyed by the GPU reset.

Reading hw state from the worker causes potentially outdated data to be read.

Previously this was done in amdgpu_decoredump_read which was called when someone would read the 
devcoredump - this was wrong for the same reasons.

Doing it from amdgpu_coredump requires memory to be pre-allocated to store each IP' state because we 
can't allocate memory in this context. Then the stored IP state would be formatted by the worker.

Pierre-Eric

> 
> Regards,
> Christian.
> 
>>
>> Thanks,
>> Lijo
>>
>>> That being said, flushing the worker is fine for now.
>>>
>>> Pierre-Eric
>>>
>>>>
>>>> Thanks,
>>>> Christian.
>>>>
>>>>
>>>>>        if (adev->bios) {
>>>>>            if (amdgpu_emu_mode != 1)
>>>>>                amdgpu_atombios_fini(adev);
>>
