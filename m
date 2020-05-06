Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC4AC38A2A
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 09:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517F72070B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 09:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WonYaHDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517F72070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D946E038;
	Wed,  6 May 2020 09:44:26 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8606C6E038
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 09:44:24 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id j5so1401281wrq.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 May 2020 02:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=rr1dXUNKib3PD/PhDNNQgsD3xdAeO3sMwNSpMRmQZsk=;
 b=WonYaHDX+pgQeetrQq1NEP14C/9sTHNkBv+sW7bImQRatpNUQfsyqhg7/UtiP8qh+y
 tw+8zTJnk5YFa8NQ4l1O8ruWeoTTYoshjiSH0/LTzZxOGZW1tk1gBXJrEqaz7xCVtgmR
 ln+i713VZkept1xsKaquCq4pBXdCkfKZ9TXhzFrDzsim+1e3Hh//eE37z0m5O1nUoINN
 7Fkp5kY/sUr7xV8D6P62GDfvu/33+K/q/12+LcRaFWeMiZ3NAcftUU68/p4RV6QSf1Pl
 i8mHwVkHh5//l+LYdyLbmeEpi0NnogbCMR2dqb2t5QRlQi5vqhMqvPTscAoNNucHFcb2
 krMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=rr1dXUNKib3PD/PhDNNQgsD3xdAeO3sMwNSpMRmQZsk=;
 b=NY2cpA8L/ey0/VyPm/NJLjtC9pD04rdGZWbg4NUWAtzc1C10mfQbwTm2yVmktU9YNA
 13aR7VTP3NiCRnwIOLCvP3kvrfqUrxbtCMoWlUnMvS3VAHLdcsyOwlo9oNOQkmaGtRHA
 dxSZlW+RqBIp+R4vpKbxHXXnPdbGZ+EJSDE5L4YXDRoAMlM+Nwr9YSHOjotKgP9PkWMM
 1FkwjTSjZPhE1dra8EjIzPMWkrWchuQkeTauPIQ1J4FrAcs7zzi6KewAQlwasaQddTKf
 AumVd+Dylfku7bA0hjRDKPqecAtqknF9aFStldXEolTaa+OJpJtSRYheG0hAkE6VRDkj
 8UDQ==
X-Gm-Message-State: AGi0PuZgfR0NzP7J6+nPdOWX2cJEH1R1CbuQVN+Vyem9m3CVkbYS3XcT
 u6bhgxW0m8RZ70u/zSpwk/QzJpwl
X-Google-Smtp-Source: APiQypL3C2J2vhInNXNLMC6xLICqGwLgiY+Zv6v+SNadhavvTl8/IcKh7xgHE2Kj3WkmxwSA5jYlOw==
X-Received: by 2002:adf:f887:: with SMTP id u7mr8236585wrp.369.1588758262720; 
 Wed, 06 May 2020 02:44:22 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id v16sm2166448wml.30.2020.05.06.02.44.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 May 2020 02:44:22 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: avoid clearing freed bo with sdma in gpu reset
To: Tiecheng Zhou <Tiecheng.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200506093626.13501-1-Tiecheng.Zhou@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1dba2b3b-d5b2-42a4-74e9-530658d039bd@gmail.com>
Date: Wed, 6 May 2020 11:44:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200506093626.13501-1-Tiecheng.Zhou@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

NAK, the fundamental problem was that we disabled the SDMA paging queue 
during reset:
> [  885.694682] [drm] schedpage0 is not ready, skipping
> [  885.694682] [drm] schedpage1 is not ready, skipping

This is fixed by now, so the problem should not happen any more.

Regards,
Christian.


Am 06.05.20 um 11:36 schrieb Tiecheng Zhou:
> WHY:
> For V320 passthrough and "modprobe amdgpu lockup_timeout=500", there will be
> kernel NULL pointer when using quark ~ BACO reset, for instance:
>    hang_vm_compute0_bad_cs_dispatch.lua
>    hang_vm_dma0_corrupted_header.lua
>    etc.
> -----------------------------
> [  884.792885] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring comp_1.0.0 timeout, signaled seq=3, emitted seq=4
> [  884.793772] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process quark pid 16939 thread quark pid 16940
> [  884.859979] amdgpu: [powerplay] set virtualization GFX DPM policy success
> [  884.861003] amdgpu: [powerplay] activate virtualization GFX DPM policy success
> [  884.861065] amdgpu: [powerplay] set virtualization VCE DPM policy success
> [  885.693554] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
> [  885.694682] [drm] schedpage0 is not ready, skipping
> [  885.694682] [drm] schedpage1 is not ready, skipping
> [  885.694720] [drm:amdgpu_gem_va_ioctl [amdgpu]] *ERROR* Couldn't update BO_VA (-2)
> [  885.695328] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> [  885.695909] PGD 0 P4D 0
> [  885.696104] Oops: 0000 [#1] SMP PTI
> [  885.696368] CPU: 2 PID: 16940 Comm: quark Tainted: G           OE     4.19.52+ #6
> [  885.696945] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [  885.697593] RIP: 0010:amdgpu_vm_sdma_commit+0x59/0x130 [amdgpu]
> ...
> [  885.705042] Call Trace:
> [  885.705251]  ? amdgpu_vm_bo_update_mapping+0xdf/0xf0 [amdgpu]
> [  885.705696]  ? amdgpu_vm_clear_freed+0xcc/0x1b0 [amdgpu]
> [  885.706112]  ? amdgpu_gem_va_ioctl+0x4a1/0x510 [amdgpu]
> [  885.706493]  ? __radix_tree_delete+0x7e/0xa0
> [  885.706822]  ? amdgpu_gem_va_map_flags+0x70/0x70 [amdgpu]
> [  885.707220]  ? drm_ioctl_kernel+0xaa/0xf0 [drm]
> [  885.707568]  ? amdgpu_gem_va_map_flags+0x70/0x70 [amdgpu]
> [  885.707962]  ? drm_ioctl_kernel+0xaa/0xf0 [drm]
> [  885.708294]  ? drm_ioctl+0x3a7/0x3f0 [drm]
> [  885.708632]  ? amdgpu_gem_va_map_flags+0x70/0x70 [amdgpu]
> [  885.709032]  ? unmap_region+0xd9/0x120
> [  885.709328]  ? amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
> [  885.709684]  ? do_vfs_ioctl+0xa1/0x620
> [  885.709971]  ? do_munmap+0x32e/0x430
> [  885.710232]  ? ksys_ioctl+0x66/0x70
> [  885.710513]  ? __x64_sys_ioctl+0x16/0x20
> [  885.710806]  ? do_syscall_64+0x55/0x100
> [  885.711092]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> ...
> [  885.719408] ---[ end trace 7ee3180f42e9f572 ]---
> [  885.719766] RIP: 0010:amdgpu_vm_sdma_commit+0x59/0x130 [amdgpu]
> ...
> -----------------------------
>
> the NULL pointer (entity->rq == NULL in amdgpu_vm_sdma_commit()) as follows:
> 1. quark sends bad job that triggers job timeout;
> 2. guest KMD detects the job timeout and goes to gpu recovery, and it goes to
>     ip_suspend for SDMA, and it sets sdma[].sched.ready to false;
> 3. quark sends UNMAP operation through amdgpu_gem_va_ioctl, and guest KMD goes
>     through amdgpu_gem_va_update_vm and finally goes to amdgpu_vm_sdma_commit,
>     it goes to amdgpu_job_submit to drm_sched_job_init
> 4. drm_sched_job_init fails at drm_sched_pick_best() since
>     sdma[].sched.ready is set to false; in the meanwhile entity->rq becomes NULL;
> 5. quark sends other UNMAP operations through amdgpu_gem_va_ioctl, while this time
>     there will be NULL pointer because entity->rq is NULL;
>
> the above sequence occurs only when "modprobe amdgpu lockup_timeout=500".
> it does not occur when lockup_timeout=10000 (default) because step 2. KMD detects
> job timeout will be sometime after quark sends UNMAP operations; i.e. quark UNMAP
> opeartions are finished before sdma ip suspend.
>
> HOW:
> here is to add mutex_lock to wait to avoid using sdma during gpu reset.
>
> Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index e205ecc75a21..018b88f3b6da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2047,6 +2047,8 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   	struct dma_fence *f = NULL;
>   	int r;
>   
> +	mutex_lock(&adev->lock_reset);
> +
>   	while (!list_empty(&vm->freed)) {
>   		mapping = list_first_entry(&vm->freed,
>   			struct amdgpu_bo_va_mapping, list);
> @@ -2062,6 +2064,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>   		if (r) {
>   			dma_fence_put(f);
> +			mutex_unlock(&adev->lock_reset);
>   			return r;
>   		}
>   	}
> @@ -2073,6 +2076,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   		dma_fence_put(f);
>   	}
>   
> +	mutex_unlock(&adev->lock_reset);
>   	return 0;
>   
>   }

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
