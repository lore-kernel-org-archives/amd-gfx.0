Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9198ECE7A89
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 06:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24C2E10E203;
	Mon, 25 Sep 2023 06:45:17 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1299E10E1FE
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 06:45:14 +0000 (UTC)
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c12ae20a5cso90064771fa.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Sep 2023 23:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695624312; x=1696229112; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+jhdUGiHQ1ao4PI7ygSZK70iMQgnuPd65EQR2K8bWc0=;
 b=EvmVJWnIWrh1e+RY+6CNARJ6wlC/KO/O8KaQ8oQRdBIn6vflvwJEwWw16iRtQLH2h8
 cn8I9QcZmqHvDQKRaK3/bktbFvbF2yfyWFUSyobDYoLgA4fwCiGdh4HuyOx/ezIXWJ+z
 2hsTyk53OaK3tJguFE24IhhKcxY80S45EaqLLGjoycx9vCfXAQc9KLWsX37w9DsGdNVa
 P+n/FF5ita0+g+1LfuLoC/xZvDj7Kj2ytWE7zXn9pyJyuVe80BBuNRs80jlsXkfMK7Ib
 EmjPqZGIUSpjDdjG4YcSRpHv0eZcM8pxUPt5YuPMJKMgNDD3YE9VeganXdLxm6i+SxRT
 CoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695624312; x=1696229112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+jhdUGiHQ1ao4PI7ygSZK70iMQgnuPd65EQR2K8bWc0=;
 b=OARBgGTj00gOhLi/SEN0wW1h8wrgOzcI8a3mhUsGe4o4K533iBxV3Wix+IS7rREZZS
 TER9GJXljf9hW9ftiJg3VO8PaTXvDaquPhutqWQC5C1dnaW/9qQemkVoj5fpDwCHcRXz
 ZVlOiymUGqJIqzNoe0TnvDMDjoEymJaw7kwSQN0K0XZUu+l/8AAp87f+6gVFFo1hY2B2
 xSAU3iBEF4Wc6M4h+LOE19zO8RWHykDdLVRHNWAVbwjM5HHpZgynMPfkCdc5sxhxiJ1v
 E2k1xI3oTxqW8o0LRFLNkCUMMiC3nKYfQk8BjUlQmVhF1eNSYeDkbgh7VHVe3JC9Tzhq
 QsSQ==
X-Gm-Message-State: AOJu0YylTWXQRWPgqI1PGZxUJ2VyF9OBnOsSE8RoLMR8fVSz6HHwjYIW
 CsBruWc86Ig+yY1UM+AXp+DEO3ixEFWZLw==
X-Google-Smtp-Source: AGHT+IFVYtsYZldrIZu53KiSqrDeWk2YoCKHIvKxSoYlR7Kl8vdjIYCi4tBadzuhAbxHAJZImDV9WA==
X-Received: by 2002:a05:651c:103c:b0:2be:3ca8:bdc9 with SMTP id
 w28-20020a05651c103c00b002be3ca8bdc9mr4382530ljm.49.1695624311812; 
 Sun, 24 Sep 2023 23:45:11 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.20.2])
 by smtp.gmail.com with ESMTPSA id
 gq23-20020a170906e25700b009ad75d318ffsm5925969ejb.17.2023.09.24.23.45.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Sep 2023 23:45:10 -0700 (PDT)
Message-ID: <cd91b76c-6828-a863-37b7-6a3deaf28d82@gmail.com>
Date: Mon, 25 Sep 2023 08:45:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdgpu: move gfxhub.funcs->init to gmc sw_init
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230923111651.719593-1-yifan1.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230923111651.719593-1-yifan1.zhang@amd.com>
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.09.23 um 13:16 schrieb Yifan Zhang:
> gmc11 hw_init depends on adev->gfxhub.funcs->init now, move
> it to gmc11 sw_init. This patch fixes below driver load error on
> GC 11.0.4:
>
> [   43.928149] [drm] amdgpu: 512M of VRAM memory ready
> [   43.928151] [drm] amdgpu: 7641M of GTT memory ready.
> [   43.928168] [drm] GART: num cpu pages 131072, num gpu pages 131072
> [   43.928182] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [   43.928185] #PF: supervisor read access in kernel mode
> [   43.928187] #PF: error_code(0x0000) - not-present page
> [   43.928188] PGD 0 P4D 0
> [   43.928191] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   43.928193] CPU: 7 PID: 1278 Comm: modprobe Tainted: G           OE      6.3.7+ #73
> [   43.928198] RIP: 0010:gmc_v11_0_flush_gpu_tlb+0x59/0x4d0 [amdgpu]
> [   43.928406] Code: 8b 4d d4 48 89 4d c8 83 f9 0d 0f 87 7c 04 00 00 48 8b 45 c8 44 89 ee 44 89 e7 48 8d 04 80 48 c1 e0 04 49 8b 84 07 90 eb 00 00 <48> 8b 40 08 ff d0 0f 1f 00 44 8b 45 d4 41 89 c5 45 85 c0 0f 85 c0
> [   43.928409] RSP: 0018:ffffae24c28277f0 EFLAGS: 00010256
> [   43.928411] RAX: 0000000000000000 RBX: ffff95bf0ed80000 RCX: 0000000000000000
> [   43.928413] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [   43.928414] RBP: ffffae24c2827848 R08: 0003000000000077 R09: 0000000000000401
> [   43.928416] R10: 0000000000001000 R11: 0000000000001000 R12: 0000000000000000
> [   43.928417] R13: 0000000000000000 R14: 0000000000000000 R15: ffff95bf0ed80000
> [   43.928418] FS:  00007f2703c83000(0000) GS:ffff95c26e7c0000(0000) knlGS:0000000000000000
> [   43.928421] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   43.928422] CR2: 0000000000000008 CR3: 000000012c300000 CR4: 0000000000750ee0
> [   43.928424] PKRU: 55555554
> [   43.928425] Call Trace:
> [   43.928426]  <TASK>
> [   43.928428]  ? show_regs+0x6e/0x80
> [   43.928434]  ? __die+0x29/0x70
> [   43.928436]  ? page_fault_oops+0x154/0x4a0
> [   43.928440]  ? amdgpu_bo_move+0x25b/0x790 [amdgpu]
> [   43.928612]  ? do_user_addr_fault+0x325/0x710
> [   43.928615]  ? exc_page_fault+0x7a/0x180
> [   43.928619]  ? asm_exc_page_fault+0x2b/0x30
> [   43.928623]  ? gmc_v11_0_flush_gpu_tlb+0x59/0x4d0 [amdgpu]
> [   43.928797]  ? amdgpu_gart_bind+0x64/0xc0 [amdgpu]
> [   43.928974]  amdgpu_gmc_flush_gpu_tlb+0x258/0x2e0 [amdgpu]
> [   43.929159]  amdgpu_gart_invalidate_tlb+0x66/0xa0 [amdgpu]
> [   43.929332]  amdgpu_gtt_mgr_recover+0x67/0x80 [amdgpu]
> [   43.929504]  gmc_v11_0_hw_init+0x4c/0x130 [amdgpu]
> [   43.929690]  amdgpu_device_init+0x1766/0x2d60 [amdgpu]
> [   43.929858]  ? pci_bus_read_config_word+0x4b/0x80
> [   43.929862]  ? do_pci_enable_device+0xdb/0x110
> [   43.929866]  amdgpu_driver_load_kms+0x1e/0x1a0 [amdgpu]
> [   43.930032]  amdgpu_pci_probe+0x16b/0x4e0 [amdgpu]
> [   43.930201]  local_pci_probe+0x4c/0xb0
> [   43.930204]  pci_device_probe+0xcc/0x280
> [   43.930207]  really_probe+0x1c4/0x430
> [   43.930210]  __driver_probe_device+0x8a/0x180
> [   43.930212]  driver_probe_device+0x23/0xc0
> [   43.930214]  __driver_attach+0xfb/0x200
> [   43.930215]  ? __pfx___driver_attach+0x10/0x10
> [   43.930217]  bus_for_each_dev+0x7e/0xd0
> [   43.930221]  driver_attach+0x22/0x30
> [   43.930222]  bus_add_driver+0x120/0x230
> [   43.930224]  driver_register+0x68/0x130
> [   43.930226]  ? __pfx_init_module+0x10/0x10 [amdgpu]
> [   43.930394]  __pci_register_driver+0x6c/0x80
> [   43.930396]  amdgpu_init+0x67/0xff0 [amdgpu]
> [   43.930549]  do_one_initcall+0x4a/0x240
> [   43.930554]  ? kmalloc_trace+0x2e/0xa0
> [   43.930559]  do_init_module+0x52/0x230
> [   43.930563]  load_module+0x2386/0x2880
> [   43.930566]  ? security_kernel_post_read_file+0x60/0x70
> [   43.930571]  __do_sys_finit_module+0xc8/0x140
> [   43.930573]  ? __do_sys_finit_module+0xc8/0x140
> [   43.930576]  __x64_sys_finit_module+0x1c/0x30
> [   43.930578]  do_syscall_64+0x5d/0x90
> [   43.930581]  ? syscall_exit_to_user_mode+0x2a/0x50
> [   43.930583]  ? __x64_sys_mmap+0x37/0x50
> [   43.930586]  ? do_syscall_64+0x6d/0x90
> [   43.930588]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Fixes: c6f52f1ffd91 (drm/amdgpu: cleanup gmc_v11_0_flush_gpu_tlb)

Reviewed-by: Christian König <christian.koenig@amd.com>

Any idea why that was that in the gfx init in the first place? For all 
other generations and the mmhub it's in the GMC init.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 --
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 ++
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 42fc0cc13fdd..9c4562bda8cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1329,8 +1329,6 @@ static int gfx_v11_0_sw_init(void *handle)
>   	struct amdgpu_kiq *kiq;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	adev->gfxhub.funcs->init(adev);
> -
>   	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>   	case IP_VERSION(11, 0, 0):
>   	case IP_VERSION(11, 0, 2):
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 7d61f66625fa..d0e3583a3cac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -720,6 +720,8 @@ static int gmc_v11_0_sw_init(void *handle)
>   
>   	adev->mmhub.funcs->init(adev);
>   
> +	adev->gfxhub.funcs->init(adev);
> +
>   	spin_lock_init(&adev->gmc.invalidate_lock);
>   
>   	r = amdgpu_atomfirmware_get_vram_info(adev,

