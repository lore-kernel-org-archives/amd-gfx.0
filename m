Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5FC105F784
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 09:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1030210EB6A;
	Fri, 13 Mar 2026 09:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="wRmmcK/X";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6268A10EB6C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 09:35:18 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso17753665e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 02:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1773394517; x=1773999317; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X5KVDLLntEY3aBzaW52KhFCsM3B+1B+kRyqqtuMhIdk=;
 b=wRmmcK/XE4LmkVk4PtZ7/JEu7CpnmCbNU4aiuVpl/P/nU+35mxfTpgNgC8Qv9M6g3Z
 lBLoykjOMeLgV5tQ6yC5Quabve0BHTFs4UmHc/OjiE0tvhTGzo5HQdUx1D+vRgWCk86a
 S3GtjxSZ2XkLz5yS/M1xSuEwM5ho5jr5LqBmwvW7HBX3s1lDdRTpFslsvFtpBAl9j8b2
 ICSkTv0sWQFvnOlrOI0MH6OHs8VIPGczILZqqY7Lno9uWy9zFQf2Jesma2Hgp/FalBXN
 Ua3yyH1KoPIzVnH58mOYoDWpyUEthgvBR8dt1AqeXsmsJd3UxB4Jo1BJRac2o2/MS6GT
 l+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773394517; x=1773999317;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X5KVDLLntEY3aBzaW52KhFCsM3B+1B+kRyqqtuMhIdk=;
 b=gqj/aZaNjkhSTgep+F2Z/XlXzUevRez0KxOjahlgIcFq2CCTz81SzQxELl5YmuxN8j
 UXpFtN2+BnZbCVwA1r7xgXtUFnvNJHXCPrjWc6sqTFvDURJNu0jLOjBszs3YcUB0y8u7
 I9/hndiNur20i771PCv3J+iBIFM7l4WMhg0IIXtw5twafj3I0RXvufeIK+DGs2ZugLKi
 mvrhDq1HIhoYDz9theFTQmLQwr0brTApHYeukmQXxJN9XR2rFjfgGBwwvXpjGwpP9MhU
 6v44UZ8iZv1YQId/4pyP4Yp3CoMZc6jh0U/+ZtrpHtQyKSzZCDwt9ax6sulqgML/TYq+
 mLZA==
X-Gm-Message-State: AOJu0YxGD6aITG3f13PLTCjDvXbB27zFhVcSfKOPpy0tiT1TkrvmPOTS
 coZVSjEJ8I4euLJA37py1kiWiZxp0t6y7nzi2+E2tfAUJH0hDRNEdIZBD9QH6EDH9Zo=
X-Gm-Gg: ATEYQzzlZBMiZR9MJ5DJZrmXN6i8pYSm465YJ9PKilVxIudezeCwYPTHbCzvFS4O2aE
 4ZmF25anJ5hBez7kdBNLMh82xzl8fafmB99VBbJFEF1UL3u8GnutKOdaGPyMLpsywgT6j5fFjPN
 FM2/S+HLgpL5n22Me+aflrBUgKkv/GFPwmC6NT3Col3aP6VSPWTVS9fPh54WtF9dnAZ6tZfEr1Y
 9Z6s5GJu1N+EegEKtgmn2Kb5s2BimcNrXixUICuUdn2ZTNsxNpk4F6Eapp80el1ogNvCzOlF3/a
 jCfuwA7hEuXAm4TPehm9OhnRuVTY2BiAP/aG5pDW0aDj2EkfBVkYL3sRKJ5e622qUNHQP12NgY3
 0XQ8PEiFHbTmr0vcBe3as0Q7JF+TBx58Dk11aoInGNKzDDfdlvAasvbOpN/j+LVt9Al0JtGZYNm
 TMNKb39UVpKfNEEuYdXs8kAXm5GQ80SFrjgz5Xv4KGm1Q/
X-Received: by 2002:a05:600c:3b16:b0:480:69b6:dfed with SMTP id
 5b1f17b1804b1-4855671e83bmr38061235e9.24.1773394516446; 
 Fri, 13 Mar 2026 02:35:16 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aa73easm284418175e9.3.2026.03.13.02.35.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 02:35:15 -0700 (PDT)
Message-ID: <29ce6e2c-5a86-4898-99ee-95711b6f83ff@ursulin.net>
Date: Fri, 13 Mar 2026 09:35:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] drm/amdgpu/userq: fix dma_fence refcount underflow
 in userq path
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260313072140.3327678-1-sunil.khatri@amd.com>
 <20260313072140.3327678-3-sunil.khatri@amd.com>
 <344dec42-00b1-4870-9f09-8b5fae61878b@ursulin.net>
 <86643e4a-15fb-414a-a06a-a3936413696b@amd.com>
 <a28f8697-da5a-4128-93b2-a06243cc6524@ursulin.net>
 <609153ab-f4b9-4501-8f8c-970847746870@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <609153ab-f4b9-4501-8f8c-970847746870@amd.com>
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


On 13/03/2026 08:53, Khatri, Sunil wrote:
> 
> On 13-03-2026 02:20 pm, Tvrtko Ursulin wrote:
>>
>> On 13/03/2026 08:43, Khatri, Sunil wrote:
>>>
>>> On 13-03-2026 02:07 pm, Tvrtko Ursulin wrote:
>>>>
>>>> On 13/03/2026 07:21, Sunil Khatri wrote:
>>>>> An extra dma_fence_put() can drop the last reference to a fence 
>>>>> while it is
>>>>> still attached to a dma_resv object. This frees the fence 
>>>>> prematurely via
>>>>> dma_fence_release() while other users still hold the pointer.
>>>>>
>>>>> Later accesses through dma_resv iteration may then operate on the 
>>>>> freed
>>>>> fence object, leading to refcount underflow warnings and potential 
>>>>> hangs
>>>>> when walking reservation fences.
>>>>>
>>>>> Fix this by correcting the fence lifetime so the dma_resv object 
>>>>> retains a
>>>>> valid reference until it is done with the fence.
>>>>>
>>>>> [   31.133803] refcount_t: underflow; use-after-free.
>>>>> [   31.133805] WARNING: lib/refcount.c:28 at 
>>>>> refcount_warn_saturate+0x58/0x90, CPU#18: kworker/u96:1/188
>>>>> [   31.133815] Modules linked in: snd_seq_dummy snd_hrtimer qrtr 
>>>>> binfmt_misc nls_iso8859_1 snd_hda_codec_alc882 
>>>>> snd_hda_codec_realtek_lib snd_hda_codec_generic 
>>>>> snd_hda_codec_atihdmi snd_hda_codec_hdmi snd_hda_intel amd_atl 
>>>>> snd_hda_codec intel_rapl_msr intel_rapl_common amdgpu snd_hda_core 
>>>>> snd_intel_dspcfg amdxcp snd_intel_sdw_acpi 
>>>>> drm_panel_backlight_quirks snd_hwdep gpu_sched drm_buddy snd_pcm 
>>>>> drm_ttm_helper ttm drm_exec drm_suballoc_helper snd_seq_midi 
>>>>> drm_client_lib snd_seq_midi_event drm_display_helper snd_rawmidi 
>>>>> cec snd_seq edac_mce_amd ghash_clmulni_intel snd_seq_device 
>>>>> aesni_intel rc_core drm_kms_helper gigabyte_wmi snd_timer wmi_bmof 
>>>>> rapl k10temp video i2c_piix4 snd i2c_smbus input_leds soundcore 
>>>>> joydev ccp mac_hid sch_fq_codel msr parport_pc ppdev lp parport drm 
>>>>> efi_pstore nfnetlink dmi_sysfs autofs4 hid_generic usbhid hid nvme 
>>>>> igb ahci i2c_algo_bit dca libahci nvme_core wmi
>>>>> [   31.133932] CPU: 18 UID: 0 PID: 188 Comm: kworker/u96:1 Not 
>>>>> tainted 6.19.0-amd-staging-drm-next #28 PREEMPT(voluntary)
>>>>> [   31.133937] Hardware name: Gigabyte Technology Co., Ltd. X570 
>>>>> AORUS ELITE/X570 AORUS ELITE, BIOS F37c 05/12/2022
>>>>> [   31.133940] Workqueue: sdma1 drm_sched_run_job_work [gpu_sched]
>>>>> [   31.133951] RIP: 0010:refcount_warn_saturate+0x58/0x90
>>>>> [   31.133955] Code: 74 2f 83 fe 01 75 38 48 8d 3d a4 2c 91 01 67 
>>>>> 48 0f b9 3a eb 36 48 8d 3d a6 2c 91 01 67 48 0f b9 3a eb 28 48 8d 
>>>>> 3d a8 2c 91 01 <67> 48 0f b9 3a eb 1a 48 8d 3d aa 2c 91 01 67 48 0f 
>>>>> b9 3a eb 0c 48
>>>>> [   31.133959] RSP: 0018:ffffca16807dfd68 EFLAGS: 00010246
>>>>> [   31.133962] RAX: ffff89e988f05600 RBX: 0000000000000000 RCX: 
>>>>> 0000000000000000
>>>>> [   31.133965] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 
>>>>> ffffffffa1fd2f30
>>>>> [   31.133967] RBP: ffffca16807dfd68 R08: 0000000000000000 R09: 
>>>>> 0000000000000000
>>>>> [   31.133969] R10: 0000000000000000 R11: 0000000000000000 R12: 
>>>>> ffff89e98edf1308
>>>>> [   31.133971] R13: ffff89e9d3001380 R14: ffff89e9dab5f800 R15: 
>>>>> ffff89e9dab5f880
>>>>> [   31.133974] FS:  0000000000000000(0000) 
>>>>> GS:ffff89ed0cc3e000(0000) knlGS:0000000000000000
>>>>> [   31.133976] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [   31.133979] CR2: 00007f3050081c28 CR3: 0000000117f06000 CR4: 
>>>>> 0000000000350ef0
>>>>> [   31.133982] Call Trace:
>>>>> [   31.133985]  <TASK>
>>>>> [   31.133989]  drm_sched_entity_pop_job+0x414/0x420 [gpu_sched]
>>>>> [   31.133997]  drm_sched_run_job_work+0x15f/0x3c0 [gpu_sched]
>>>>> [   31.134003]  process_scheduled_works+0x1f0/0x450
>>>>> [   31.134011]  worker_thread+0x27f/0x370
>>>>> [   31.134016]  kthread+0x1ed/0x210
>>>>> [   31.134020]  ? __pfx_worker_thread+0x10/0x10
>>>>> [   31.134023]  ? srso_return_thunk+0x5/0x5f
>>>>> [   31.134027]  ? __pfx_kthread+0x10/0x10
>>>>> [   31.134031]  ret_from_fork+0x10f/0x1b0
>>>>> [   31.134035]  ? __pfx_kthread+0x10/0x10
>>>>> [   31.134039]  ret_from_fork_asm+0x1a/0x30
>>>>> [   31.134047]  </TASK>
>>>>> [   31.134049] ---[ end trace 0000000000000000 ]---
>>>>> ...
>>>>> [   56.544104] watchdog: BUG: soft lockup - CPU#9 stuck for 26s! 
>>>>> [glxgears:cs0:3483]
>>>>> [   56.544108] Modules linked in: snd_seq_dummy snd_hrtimer qrtr 
>>>>> binfmt_misc nls_iso8859_1 snd_hda_codec_alc882 
>>>>> snd_hda_codec_realtek_lib snd_hda_codec_generic 
>>>>> snd_hda_codec_atihdmi snd_hda_codec_hdmi snd_hda_intel amd_atl 
>>>>> snd_hda_codec intel_rapl_msr intel_rapl_common amdgpu snd_hda_core 
>>>>> snd_intel_dspcfg amdxcp snd_intel_sdw_acpi 
>>>>> drm_panel_backlight_quirks snd_hwdep gpu_sched drm_buddy snd_pcm 
>>>>> drm_ttm_helper ttm drm_exec drm_suballoc_helper snd_seq_midi 
>>>>> drm_client_lib snd_seq_midi_event drm_display_helper snd_rawmidi 
>>>>> cec snd_seq edac_mce_amd ghash_clmulni_intel snd_seq_device 
>>>>> aesni_intel rc_core drm_kms_helper gigabyte_wmi snd_timer wmi_bmof 
>>>>> rapl k10temp video i2c_piix4 snd i2c_smbus input_leds soundcore 
>>>>> joydev ccp mac_hid sch_fq_codel msr parport_pc ppdev lp parport drm 
>>>>> efi_pstore nfnetlink dmi_sysfs autofs4 hid_generic usbhid hid nvme 
>>>>> igb ahci i2c_algo_bit dca libahci nvme_core wmi
>>>>> [   56.544166] CPU: 9 UID: 0 PID: 3483 Comm: glxgears:cs0 Tainted: 
>>>>> G        W           6.19.0-amd-staging-drm-next #28 
>>>>> PREEMPT(voluntary)
>>>>> [   56.544170] Tainted: [W]=WARN
>>>>> [   56.544171] Hardware name: Gigabyte Technology Co., Ltd. X570 
>>>>> AORUS ELITE/X570 AORUS ELITE, BIOS F37c 05/12/2022
>>>>> [   56.544172] RIP: 0010:dma_resv_iter_walk_unlocked+0x4e/0x180
>>>>> [   56.544179] Code: 45 31 ed eb 0e 41 8b 46 08 41 3b 46 18 0f 83 
>>>>> 23 01 00 00 49 8b 46 10 48 85 c0 74 20 48 8d 78 38 b9 ff ff ff ff 
>>>>> f0 0f c1 48 38 <83> f9 01 75 07 e8 78 ce ff ff eb 06 0f 8c e3 00 00 
>>>>> 00 41 8b 46 1c
>>>>> [   56.544180] RSP: 0018:ffffca16865bb870 EFLAGS: 00000217
>>>>> [   56.544182] RAX: ffff89e997f38d80 RBX: 0000000000000005 RCX: 
>>>>> 0000000000000006
>>>>> [   56.544183] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 
>>>>> ffff89e997f38db8
>>>>> [   56.544184] RBP: ffffca16865bb898 R08: 0000000000000000 R09: 
>>>>> 0000000000000000
>>>>> [   56.544185] R10: 0000000000000000 R11: 0000000000000000 R12: 
>>>>> ffffca16865bb8c0
>>>>> [   56.544186] R13: 0000000000000000 R14: ffffca16865bb8a8 R15: 
>>>>> ffff89e997f38d80
>>>>> [   56.544187] FS:  00007f8f8d3ff6c0(0000) 
>>>>> GS:ffff89ed0c9fe000(0000) knlGS:0000000000000000
>>>>> [   56.544189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [   56.544190] CR2: 00007f8f9b735020 CR3: 0000000117f06000 CR4: 
>>>>> 0000000000350ef0
>>>>> [   56.544191] Call Trace:
>>>>> [   56.544193]  <TASK>
>>>>> [   56.544197]  dma_resv_wait_timeout+0x55/0x190
>>>>> [   56.544202]  amdgpu_bo_kmap+0x3a/0xa0 [amdgpu]
>>>>> [   56.544502]  amdgpu_userq_fence_read_wptr+0x130/0x2e0 [amdgpu]
>>>>> [   56.544670]  amdgpu_userq_signal_ioctl+0x1f6/0x5e0 [amdgpu]
>>>>> [   56.544847]  ? srso_return_thunk+0x5/0x5f
>>>>> [   56.544851]  ? amdgpu_userq_wait_ioctl+0xab7/0xb80 [amdgpu]
>>>>> [   56.545021]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>>>> [   56.545190]  drm_ioctl_kernel+0xd9/0x150 [drm]
>>>>> [   56.545222]  drm_ioctl+0x29a/0x4a0 [drm]
>>>>> [   56.545245]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>>>> [   56.545422]  ? srso_return_thunk+0x5/0x5f
>>>>> [   56.545426]  amdgpu_drm_ioctl+0x46/0x90 [amdgpu]
>>>>> [   56.545595]  __se_sys_ioctl+0x73/0xd0
>>>>> [   56.545600]  __x64_sys_ioctl+0x1d/0x30
>>>>> [   56.545602]  x64_sys_call+0x1715/0x2d00
>>>>> [   56.545604]  do_syscall_64+0x7c/0x6a0
>>>>> [   56.545608]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
>>>>> [   56.545778]  ? srso_return_thunk+0x5/0x5f
>>>>> [   56.545781]  ? amdgpu_drm_ioctl+0x6c/0x90 [amdgpu]
>>>>> [   56.545950]  ? srso_return_thunk+0x5/0x5f
>>>>>
>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 +-----
>>>>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/ 
>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> index 146ca6d7f4f5..442c08b69f7c 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> @@ -882,12 +882,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>>>>> *dev, void *data,
>>>>>                    * be good for now
>>>>>                    */
>>>>>                   r = dma_fence_wait(fences[i], true);
>>>>> -                if (r) {
>>>>> -                    dma_fence_put(fences[i]);
>>>>> +                if (r)
>>>>>                       goto free_fences;
>>>>> -                }
>>>>>   -                dma_fence_put(fences[i]);
>>>>>                   continue;
>>>>>               }
>>>>>   @@ -909,7 +906,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>>>>> *dev, void *data,
>>>>>               fence_info[cnt].va = fence_drv->va;
>>>>>               fence_info[cnt].value = fences[i]->seqno;
>>>>>   -            dma_fence_put(fences[i]);
>>>>>               /* Increment the actual userq fence count */
>>>>>               cnt++;
>>>>>           }
>>>>
>>>> I have to say the commit message confused me a bit, but the fix 
>>>> looks correct. I say confused because isn't it a simple case of 
>>>> amdgpu_userq_wait_ioctl() doing a potential double put? First one 
>>>> when the dma_fence_wait() above fails or succeeds, and the second 
>>>> one in the unwind loop. Which means it was me who broke it yet 
>>>> again. :(
>>>>
>>>> Fixes: bea29bb0dd29 ("drm/amdgpu/userq: Consolidate wait ioctl exit 
>>>> path")
>>>>
>>>> Right? But please double check because I am obviously having a bad 
>>>> period.
>>> Haha it happens and very easy to miss such things. But yes, this 
>>> happens with that patch as it seems to be working fine for some time 
>>> when i tested before. Yes that triggered that and doing the dma_put 
>>> more in clean up too. It is getting fixes with this patch for sure.
>>
>> I forgot a:
>>
>> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> But please improve the commit message because the bug is much simpler 
>> than it currently describes. Simple double put in all cases if I am 
>> not blind.
> Sure
>>
>> Btw does something from IGT catch these bugs?
> 
> IGT Still passes the test. I ran glxgears test with multiple threads, 
> but i think a single thread should also catch this as it is seen every 
> time. I run such with every commit i push in userq since there is no CI 
> validation in userqueues yet.

Is a special Mesa build needed or some environment variable for this?

Regards,

Tvrtko

