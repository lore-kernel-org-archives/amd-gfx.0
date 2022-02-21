Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A5AC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 10:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60EF310E582;
	Mon, 21 Feb 2022 10:46:38 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D9810E582;
 Mon, 21 Feb 2022 10:46:37 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aebce.dynamic.kabel-deutschland.de
 [95.90.235.206])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id E3ECD61E64846;
 Mon, 21 Feb 2022 11:46:34 +0100 (CET)
Message-ID: <c3ac5d95-218f-4f36-fbec-0172af69d5a0@molgen.mpg.de>
Date: Mon, 21 Feb 2022 11:46:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] drm/amdgpu: check vm ready by evicting
Content-Language: en-US
To: Qiang Yu <qiang.yu@amd.com>
References: <20220221101239.2863-1-qiang.yu@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220221101239.2863-1-qiang.yu@amd.com>
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Qiang Yu,


Am 21.02.22 um 11:12 schrieb Qiang Yu:


Thank you for your patch. Reading the commit message summary, I have no 
idea what “check vm ready by evicting” means. Can you please rephrase it?

> Workstation application ANSA/META get this error dmesg:

What version, and how can this be reproduced exactly? Just by starting 
the application?

> [drm:amdgpu_gem_va_ioctl [amdgpu]] *ERROR* Couldn't update BO_VA (-16)
> 
> This is caused by:
> 1. create a 256MB buffer in invisible VRAM
> 2. CPU map the buffer and access it causes vm_fault and try to move
>     it to visible VRAM
> 3. force visible VRAM space and traverse all VRAM bos to check if
>     evicting this bo is valuable
> 4. when checking a VM bo (in invisible VRAM), amdgpu_vm_evictable()
>     will set amdgpu_vm->evicting, but latter due to not in visible
>     VRAM, won't really evict it so not add it to amdgpu_vm->evicted
> 5. before next CS to clear the amdgpu_vm->evicting, user VM ops
>     ioctl will pass amdgpu_vm_ready() (check amdgpu_vm->evicted)
>     but fail in amdgpu_vm_bo_update_mapping() (check
>     amdgpu_vm->evicting) and get this error log
> 
> This error won't affect functionality as next CS will finish the
> waiting VM ops. But we'd better clear the error log by check the

s/check/checking/

> evicting flag which really stop VM ops latter.

stop*s*?

Can you please elaborate. Christian’s and your discussions was quite 
long, so adding a summary, why this approach works and what possible 
regressions there are going to be might be warranted.


Kind regards,

Paul


> Signed-off-by: Qiang Yu <qiang.yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 37acd8911168..2cd9f1a2e5fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -770,11 +770,16 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>    * Check if all VM PDs/PTs are ready for updates
>    *
>    * Returns:
> - * True if eviction list is empty.
> + * True if VM is not evicting.
>    */
>   bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>   {
> -	return list_empty(&vm->evicted);
> +	bool ret;
> +
> +	amdgpu_vm_eviction_lock(vm);
> +	ret = !vm->evicting;
> +	amdgpu_vm_eviction_unlock(vm);
> +	return ret;
>   }
>   
>   /**
