Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A43EC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Dec 2022 08:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C364110E0A5;
	Fri, 16 Dec 2022 08:50:02 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B6710E0A5
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Dec 2022 08:49:56 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id u19so4513165ejm.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Dec 2022 00:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lEwFdkbtvEaDLJgWa1Adj/FcYd4AKD61eRdwcky2uEo=;
 b=CwxC35ype1LayzYNZRCjlr2GtZwphZDoLaL6K6I6TcZm+2/+jLy8zLEqSMixgqfV19
 1Z4gXeGGiNfTeCrkQVj0z99sS5nZuWz243DIFfYLtAL6P/OdKNB5cTI3aB//c6nffuf1
 EwVlXqZw3RqhT+LGhRQmlcMp/snemyAJ8BrLafnVD/lnk/ALFudkeeYUCri68Qalbj5m
 DxJgROBeuNg1VCUaHBF/m2/7Frb4hnEf/j1HHQJemJY0pHGAu4teqK93MRb5E7RtRf4D
 7L6EDa/9UZlxBubYoOepH5f/Vr00hUhsEGWNrHT7e8rq7phSVYqFZEeB/L0fi50yxk/g
 VzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lEwFdkbtvEaDLJgWa1Adj/FcYd4AKD61eRdwcky2uEo=;
 b=HcAKSbejAjSKhS1XN4yC6I128EHQ88MyQRbr8PHYnsLHYHs8TKNa1XkZXqvOerziZ9
 HE362HV94qhNRwfDUUEpeok7lSp8ZAMYQLLhW2u3agGXeeFeRRVOIrUQX82cqHd1jW/1
 awdmvzlWIektu7UAT7EOZWuW58TjpHazoS+kBJHCs/kqy4iOj8fq+htmeRqZtAII4zFD
 8EicOM5bge6Vf4fUjJv98v0pOAj4sIeIvL/rtyEX7JgCzWRkH0HSAGx42ggwhvZs0+qZ
 Ape0/vzlyfo0sgHZ4N6gK41iWPKG21Ecx3KTQjmvWyHzymD72Pg0D/7OIFeSetaajQUW
 R8qw==
X-Gm-Message-State: ANoB5pm1W2Qxou7/5bcHSJLLHasd++u3sGFr8JNMbdCENyoqW6imt7oT
 Z0aGFdZ99pJtKbA8Le0E42c=
X-Google-Smtp-Source: AA0mqf4Md86Bez9vnnXWnVUGISkOK20KN27aazCYV1UrG9NIQSSz+VcGuund4Yasym6byae35BNGCA==
X-Received: by 2002:a17:906:3a18:b0:7ba:5085:869 with SMTP id
 z24-20020a1709063a1800b007ba50850869mr26604776eje.9.1671180594759; 
 Fri, 16 Dec 2022 00:49:54 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:90a2:619d:95d:a3f3?
 ([2a02:908:1256:79a0:90a2:619d:95d:a3f3])
 by smtp.gmail.com with ESMTPSA id
 z8-20020a170906240800b007c14d4c9633sm600663eja.99.2022.12.16.00.49.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Dec 2022 00:49:54 -0800 (PST)
Message-ID: <4cb9ed9d-310b-b226-895a-a7346c0cf67a@gmail.com>
Date: Fri, 16 Dec 2022 09:49:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: Fixed bug on error when uninstalling amdgpu
Content-Language: en-US
To: YiPeng Chai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
References: <20221216025621.176460-1-YiPeng.Chai@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221216025621.176460-1-YiPeng.Chai@amd.com>
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
Cc: yipechai@amd.com, Tao.Zhou1@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 16.12.22 um 03:56 schrieb YiPeng Chai:
> Fixed bug on error when uninstalling amdgpu.
> The error message is as follows:
> [  304.852489] kernel BUG at drivers/gpu/drm/drm_buddy.c:278!
> [  304.852503] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [  304.852510] CPU: 2 PID: 4192 Comm: modprobe Tainted: G        W IOE     5.19.0-thomas #1
> [  304.852519] Hardware name: ASUS System Product Name/PRIME Z390-A, BIOS 2004 11/02/2021
> [  304.852526] RIP: 0010:drm_buddy_free_block+0x26/0x30 [drm_buddy]
> [  304.852535] Code: 00 00 00 90 0f 1f 44 00 00 48 8b 0e 89 c8 25 00 0c 00 00 3d 00 04 00 00 75 10 48 8b 47 18 48 d3 e0 48 01 47 28 e9 fa fe ff ff <0f> 0b 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 54 55 48 89 f5 53
> [  304.852549] RSP: 0018:ffff9afac17bbcb8 EFLAGS: 00010287
> [  304.852556] RAX: 0000000000000000 RBX: ffff8dacd37fd778 RCX: 0000000000000000
> [  304.852563] RDX: ffff8dacd37fd7a0 RSI: ffff8dacd37fd3b8 RDI: ffff8dac672a5f80
> [  304.852570] RBP: ffff8dacd37fd3a0 R08: 0000000000000001 R09: 0000000000000000
> [  304.852577] R10: ffff8dac68185500 R11: ffff9afac17bbd00 R12: ffff8dac672a5f80
> [  304.852584] R13: ffff8dac672a5fe0 R14: ffff8dacd37fd380 R15: ffff8dac672a5f80
> [  304.852590] FS:  00007f0fa9b30c40(0000) GS:ffff8dadb6480000(0000) knlGS:0000000000000000
> [  304.852598] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  304.852604] CR2: 00007f4bf1a1ba50 CR3: 0000000108c58004 CR4: 00000000003706e0
> [  304.852611] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  304.852618] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  304.852625] Call Trace:
> [  304.852629]  <TASK>
> [  304.852632]  drm_buddy_free_list+0x2a/0x60 [drm_buddy]
> [  304.852639]  amdgpu_vram_mgr_fini+0xea/0x180 [amdgpu]
> [  304.852827]  amdgpu_ttm_fini+0x1f9/0x280 [amdgpu]
> [  304.852925]  amdgpu_bo_fini+0x22/0x90 [amdgpu]
> [  304.853022]  gmc_v11_0_sw_fini+0x26/0x30 [amdgpu]
> [  304.853132]  amdgpu_device_fini_sw+0xc5/0x3b0 [amdgpu]
> [  304.853229]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
> [  304.853327]  drm_dev_release+0x20/0x40 [drm]
> [  304.853352]  release_nodes+0x35/0xb0
> [  304.853359]  devres_release_all+0x8b/0xc0
> [  304.853364]  device_unbind_cleanup+0xe/0x70
> [  304.853370]  device_release_driver_internal+0xee/0x160
> [  304.853377]  driver_detach+0x44/0x90
> [  304.853382]  bus_remove_driver+0x55/0xe0
> [  304.853387]  pci_unregister_driver+0x3b/0x90
> [  304.853393]  amdgpu_exit+0x11/0x69 [amdgpu]
> [  304.853540]  __x64_sys_delete_module+0x142/0x260
> [  304.853548]  ? exit_to_user_mode_prepare+0x3e/0x190
> [  304.853555]  do_syscall_64+0x38/0x90
> [  304.853562]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>

The subject line should probably read "when unloading amdgpu", but apart 
from that good catch.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 0b598b510bd8..eb63324c30d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -829,7 +829,7 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
>   		kfree(rsv);
>   
>   	list_for_each_entry_safe(rsv, temp, &mgr->reserved_pages, blocks) {
> -		drm_buddy_free_list(&mgr->mm, &rsv->blocks);
> +		drm_buddy_free_list(&mgr->mm, &rsv->allocated);
>   		kfree(rsv);
>   	}
>   	drm_buddy_fini(&mgr->mm);

