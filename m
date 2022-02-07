Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D663DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 07:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 658C110E158;
	Mon,  7 Feb 2022 07:24:29 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8365510E158
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 07:24:27 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id og43so15279321ejc.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 06 Feb 2022 23:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=7DFsSmfhxx2CnAZra8+8y4ueuuIflofLuI3YXWvefSY=;
 b=c9/D5HNYGWK5QgGQEF9uueSHca8G843NjiYxiSn8aElfBAH6HsWzXFfa05sHKWehZQ
 oIJ/VNkAZ9DdxqGm6ZKhBLZ0qMelHIEV1lGwIeMsboNoEoorfgCdDefs0S/SiZ1/4Tw8
 E+KtJUZ3wgX3aXJ+6GVm9yZwYNbM10WWjNtjeZYbYRFhMyXMpqUNXUhyEDfe3LJo/T5e
 j9Y7F2cHYd4sqleUB4izmiL/0bo4+UE4NAPhBawV/XaRvalfSfX/1xZ14GJcwh5Cs0V1
 8S9aBlyen/FlawgvekgKyDmAJapFBqT7ZjfHXBmezg7VYWL99YUv2IPZTxCkP8//x5eR
 lSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=7DFsSmfhxx2CnAZra8+8y4ueuuIflofLuI3YXWvefSY=;
 b=7trhiM7je4BpfCJxOh9B/GE9lMKPOMWYcmEI5dcozSOp7WGa2IYVP3Dpe5H9GeWuig
 vKpirMo0SODUV3CklHe4HhELfPBlGRdkijCGWN27i6SrdBzgGAi5aER672Kmm4jl2Lah
 2L7IKSeD06ytoXOLGgquXNcWvh2nkT8lRqpQMIXxNS3ORdvdihFczcLb0Iv4R7R7oeEZ
 K8qZIU3WKqOnrCqbKvBe7qQlcFfHzIImzZq/sv/hwYVyFIdCIxaSpVfcePmJwuPDZANp
 RRxPP1zWHjKaiMIuXhu6ACuN8bXu/WCq6/qdThicb6xMERSdlJDlpShpSuLWTSXOy1Bb
 BeWQ==
X-Gm-Message-State: AOAM532SkNcF4aO6i0N3nGPk2Oju3C82LnnqDqsRQAe/yPwcKRILMGTk
 mr0jbLeKV/yZ+YbJxYfo3texaJKPnlM=
X-Google-Smtp-Source: ABdhPJwF/XLGkOBrDRHqag5qiPHyCOQrKy4zRHx5nepLeVUFXTGa0bM6JX8QG3701GnwaOCd6+UxSg==
X-Received: by 2002:a17:907:c19:: with SMTP id
 ga25mr9341684ejc.606.1644218665953; 
 Sun, 06 Feb 2022 23:24:25 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:880c:5e12:7231:e358?
 ([2a02:908:1252:fb60:880c:5e12:7231:e358])
 by smtp.gmail.com with ESMTPSA id eq19sm785454edb.36.2022.02.06.23.24.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Feb 2022 23:24:25 -0800 (PST)
Message-ID: <a486054b-9a4a-d628-6810-d5446c78de16@gmail.com>
Date: Mon, 7 Feb 2022 08:24:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: move lockdep assert to the right place.
Content-Language: en-US
To: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20220204085201.30615-1-christian.koenig@amd.com>
 <32b9cdf2-3d71-4228-3471-38584575f41b@amd.com>
 <668b5be7-de6c-4c47-9756-6452f316cd7e@amd.com>
 <108a3c26-df8c-c7ea-2228-25ec69afe50a@gmail.com>
 <df73c8a3-0c85-0402-01e4-38e6bec5af17@amd.com>
 <cc241e74-40a6-7b87-d80d-a338361abd01@gmail.com>
 <c8da9980-c2f3-0a8b-9fb8-2da5a3238c4c@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <c8da9980-c2f3-0a8b-9fb8-2da5a3238c4c@amd.com>
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

Ah, yes of course!

When the VM is freed we currently don't lock anything either because 
nobody should have a reference to that object any more.

Going to fix this as well.

Thanks,
Christian.

Am 04.02.22 um 20:15 schrieb Bhardwaj, Rajneesh:
>
> On 2/4/2022 1:50 PM, Christian König wrote:
>> Am 04.02.22 um 19:47 schrieb Bhardwaj, Rajneesh:
>>>
>>> On 2/4/2022 1:32 PM, Christian König wrote:
>>>> Am 04.02.22 um 19:12 schrieb Bhardwaj, Rajneesh:
>>>>> [Sorry for top posting]
>>>>>
>>>>> Hi Christian
>>>>>
>>>>> I think you forgot the below hunk, without which the issue is not 
>>>>> fixed completely on a multi GPU system.
>>>>
>>>> No, that is perfectly intentional. While removing a bo_va structure 
>>>> it can happen that there are still mappings attached to it (for 
>>>> example because the application crashed).
>>>
>>>
>>> OK. but for me, at boot time, I see flood of warning messages coming 
>>> from  amdgpu_vm_bo_del so the previous patch doesn't help.
>>
>> Do you have a backtrace? That should not happen.
>>
>> Could be that we have this buggy at a couple of different places.
>
>
> This is on Ubuntu 18.04.
>
>
> [    8.392405] WARNING: CPU: 13 PID: 2732 at 
> /home/rajneesh/git/compute/kernel/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2673 
> amdgpu_vm_bo_del+0x386/0x3b
> 0 [amdgpu]
> [    8.392586] Modules linked in: amdgpu ast iommu_v2 gpu_sched 
> drm_vram_helper drm_ttm_helper ttm drm_kms_helper cfbfillrect 
> syscopyarea cfbimgblt sy
> sfillrect sysimgblt fb_sys_fops cfbcopyarea drm 
> drm_panel_orientation_quirks k10temp nf_tables nfnetlink ip_tables 
> x_tables i2c_piix4
> [    8.392628] CPU: 13 PID: 2732 Comm: plymouthd Not tainted 
> 5.13.0-kfd-rajneesh #1055
> [    8.392632] Hardware name: GIGABYTE MZ01-CE0-00/MZ01-CE0-00, BIOS 
> F02 08/29/2018
> [    8.392635] RIP: 0010:amdgpu_vm_bo_del+0x386/0x3b0 [amdgpu]
> [    8.392749] Code: 0f 85 56 fe ff ff 48 c7 c2 28 6b b3 c0 be 21 01 
> 00 00 48 c7 c7 58 6b b3 c0 c6 05 64 64 62 00 01 e8 5f be a4 d4 e9 32 
> fe ff ff <0f
> > 0b eb 8a 49 8b be 88 01 00 00 e9 af fc ff ff be 03 00 00 00 e8
> [    8.392752] RSP: 0018:ffffaf33471d7d98 EFLAGS: 00010246
> [    8.392756] RAX: 0000000000000000 RBX: ffffa08771600000 RCX: 
> 0000000000000001
> [    8.392758] RDX: 0000000000000001 RSI: ffffa08772ae01f8 RDI: 
> ffffa0800a426f68
> [    8.392761] RBP: ffffa087691fd980 R08: ffffffffc0a4e2e0 R09: 
> 000000000000000a
> [    8.392763] R10: ffffaf33471d7d68 R11: 0000000000000001 R12: 
> ffffa0801d540010
> [    8.392765] R13: ffffa08771615c00 R14: ffffa08024166618 R15: 
> ffffa08771615e60
> [    8.392768] FS:  00007f7b80179740(0000) GS:ffffa08f3dec0000(0000) 
> knlGS:0000000000000000
> [    8.392771] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    8.392773] CR2: 000055839db51eb8 CR3: 000000010f49c000 CR4: 
> 00000000003506e0
> [    8.392775] Call Trace:
> [    8.392779]  ? _raw_spin_unlock_irqrestore+0x30/0x40
> [    8.392787]  amdgpu_driver_postclose_kms+0x94/0x270 [amdgpu]
> [    8.392897]  drm_file_free.part.14+0x1e3/0x230 [drm]
> [    8.392918]  drm_release+0x6e/0xf0 [drm]
> [    8.392937]  __fput+0xa3/0x250
> [    8.392942]  task_work_run+0x6d/0xb0
> [    8.392949]  exit_to_user_mode_prepare+0x1c9/0x1d0
> [    8.392953]  syscall_exit_to_user_mode+0x19/0x50
> [    8.392957]  do_syscall_64+0x42/0x70
> [    8.392960]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [    8.392964] RIP: 0033:0x7f7b7f8679e4
> [    8.392967] Code: eb 89 e8 6f 44 02 00 66 2e 0f 1f 84 00 00 00 00 
> 00 0f 1f 44 00 00 48 8d 05 21 ff 2d 00 8b 00 85 c0 75 13 b8 03 00 00 
> 00 0f 05 <48> 3d 00 f0 ff ff 77 3c f3 c3 66 90 53 89 fb 48 83 ec 10 e8 
> 94 fe
> [    8.392970] RSP: 002b:00007ffe6bb0cdb8 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000003
> [    8.392973] RAX: 0000000000000000 RBX: 000055839db4b760 RCX: 
> 00007f7b7f8679e4
> [    8.392974] RDX: 000055839db4aed0 RSI: 0000000000000000 RDI: 
> 000000000000000b
> [    8.392976] RBP: 000000000000000b R08: 000055839db4aee0 R09: 
> 00007f7b7fb42c40
> [    8.392978] R10: 0000000000000007 R11: 0000000000000246 R12: 
> 000000000000e280
> [    8.392979] R13: 000000000000000d R14: 00007f7b7fb5b1e0 R15: 
> 00007f7b7fb5b130
> [    8.392988] irq event stamp: 1264799
> [    8.392990] hardirqs last  enabled at (1264805): 
> [<ffffffff951011b9>] console_unlock+0x339/0x530
> [    8.392994] hardirqs last disabled at (1264810): 
> [<ffffffff95101226>] console_unlock+0x3a6/0x530
>
>
>>
>> Regards,
>> Christian.
>>
>>>
>>>
>>>>
>>>> Because of this locking the VM before the remove is mandatory. Only 
>>>> while adding a bo_va structure we can avoid that.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> index dcc80d6e099e..6f68fc9da56a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> @@ -2670,8 +2670,6 @@ void amdgpu_vm_bo_del(struct amdgpu_device 
>>>>> *adev,
>>>>>         struct amdgpu_vm *vm = bo_va->base.vm;
>>>>>         struct amdgpu_vm_bo_base **base;
>>>>>
>>>>> - dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>>> -
>>>>>         if (bo) {
>>>>> dma_resv_assert_held(bo->tbo.base.resv);
>>>>>                 if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
>>>>>
>>>>>
>>>>> If you chose to include the above hunk, please feel free to add
>>>>>
>>>>> Reviewed-and-tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>>>>
>>>>> On 2/4/2022 11:27 AM, Felix Kuehling wrote:
>>>>>>
>>>>>> Am 2022-02-04 um 03:52 schrieb Christian König:
>>>>>>> Since newly added BOs don't have any mappings it's ok to add them
>>>>>>> without holding the VM lock. Only when we add per VM BOs the 
>>>>>>> lock is
>>>>>>> mandatory.
>>>>>>>
>>>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>>>>> Reported-by: Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>
>>>>>>
>>>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>>
>>>>>>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
>>>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>>> index fdc6a1fd74af..dcc80d6e099e 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>>> @@ -375,6 +375,8 @@ static void amdgpu_vm_bo_base_init(struct 
>>>>>>> amdgpu_vm_bo_base *base,
>>>>>>>       if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>>>>>>>           return;
>>>>>>>   + dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>>>>> +
>>>>>>>       vm->bulk_moveable = false;
>>>>>>>       if (bo->tbo.type == ttm_bo_type_kernel && bo->parent)
>>>>>>>           amdgpu_vm_bo_relocated(base);
>>>>>>> @@ -2260,8 +2262,6 @@ struct amdgpu_bo_va 
>>>>>>> *amdgpu_vm_bo_add(struct amdgpu_device *adev,
>>>>>>>   {
>>>>>>>       struct amdgpu_bo_va *bo_va;
>>>>>>>   - dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>>>>> -
>>>>>>>       bo_va = kzalloc(sizeof(struct amdgpu_bo_va), GFP_KERNEL);
>>>>>>>       if (bo_va == NULL) {
>>>>>>>           return NULL;
>>>>
>>

