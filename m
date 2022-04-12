Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24944C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 09:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF18A10E6FD;
	Tue, 12 Apr 2022 09:19:55 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A28C10E6FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 09:19:55 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id bh17so36040292ejb.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 02:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=vcoXkGmHJg8wc3e7k4rRKA4DcM0g4pj0dqh3ibneqjk=;
 b=Qdu1Z6esiueWEEyOZzG6nAhyWrXZmP9Qwd4xfmGie2KEH6RuFFhkKlJVXifPoa6X7R
 MFZeI/eK9a+ajMIPD2RHozSEgJmaotJ8IG8rt6fUfm3c8A5aFxk3YQgmbme+gqR3J3sW
 gAhi28xPDDKJzJS4R6C5f1DEr5nqmsYiTiJkQNAfy6zQOlIBA01pq/jVAJXwI8B/f8wO
 xJm/pz9yvjwywsOy3nQCoogHMqoBIxYc5qpXehfY08z1jgJ+6hE02Fqi9uRRCQJdsxkv
 usNXPRgcG0O8FzGsDZ65kXY1Zs6uZ4akjE3v/aMEcdOJAUiyeE9WEV6yH4WfaHb0XQUl
 65qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=vcoXkGmHJg8wc3e7k4rRKA4DcM0g4pj0dqh3ibneqjk=;
 b=pQxdSIYsPOhO/9ajnzp/Z5FtjsJQLlbHP+MIdyE4BGhOisUoxOMsX95Db9SPR8HCV4
 ZX+FM/AperTpW6onPrwXymD83YAl+Yx7KSu3MMrWWyJYsVE6SSs1Oj+jqyQ6EBELHtqB
 VXq/ViMCpSrEb026CEpyCo30esdYQUkAfrW89RZDxKe0DK9gLjjWK6ejHKdo54ElG516
 R1jIHml6yzo8eCpgaZC8F8UNtr8ioNh+igEk1/pNKNSANqQ9d9/zxYY6+2YbCdCc0teZ
 bJf6FY4cszIKGQu9JkoxWj/L2oaspiuPLiZ6kjhfwyuE1X2TL7I/uS68P+4+jEEMS0Fr
 z2Jw==
X-Gm-Message-State: AOAM530x3W+6nOAyaMJOLOeb94bxhCbTeveJEYbRvBwciWHF+tAZmmeS
 NexgUbd7deUgbZTgmzL43bg=
X-Google-Smtp-Source: ABdhPJylj8V8EnCZqxfUa2gAid2hLpD4EEoUJ6lOvkc37wAZQMgGEHGBJZPe9VErKJuw+U41HGpt6Q==
X-Received: by 2002:a17:906:3ec7:b0:6d6:e52b:b with SMTP id
 d7-20020a1709063ec700b006d6e52b000bmr34160158ejj.521.1649755193443; 
 Tue, 12 Apr 2022 02:19:53 -0700 (PDT)
Received: from [192.168.178.21] (p57b0b9e1.dip0.t-ipconnect.de.
 [87.176.185.225]) by smtp.gmail.com with ESMTPSA id
 p24-20020a056402045800b0041614c8f79asm16199484edw.88.2022.04.12.02.19.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 02:19:52 -0700 (PDT)
Message-ID: <676f2035-414a-27b1-95d5-41f85cffc3ea@gmail.com>
Date: Tue, 12 Apr 2022 11:19:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH] drm/amdgpu: Fix one use-after-free of VM
Content-Language: en-US
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220412071656.16500-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220412071656.16500-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.04.22 um 09:16 schrieb xinhui pan:
> VM might already be freed when amdgpu_vm_tlb_seq_cb() is called.  We see
> the calltrace below.
>
> Fix it by adding vm.delayed_tlb_flush and check this value in vm_fini().
>
> BUG kmalloc-4k (Not tainted): Poison overwritten

Shit, I feared that this could happen.

Please don't use a counter+schedule, but rather keep the last flush 
fence around and wait for it to signal during vm destruction.

Since fences signal in order you can then wait on that one and make sure 
that the last cb has run.

Thanks,
Christian.

>
> 0xffff9c88630414e8-0xffff9c88630414e8 @offset=5352. First byte 0x6c
> instead of 0x6b Allocated in amdgpu_driver_open_kms+0x9d/0x360 [amdgpu]
> age=44 cpu=0 pid=2343
>   __slab_alloc.isra.0+0x4f/0x90
>   kmem_cache_alloc_trace+0x6b8/0x7a0
>   amdgpu_driver_open_kms+0x9d/0x360 [amdgpu]
>   drm_file_alloc+0x222/0x3e0 [drm]
>   drm_open+0x11d/0x410 [drm]
>   drm_stub_open+0xdc/0x230 [drm]
>   chrdev_open+0xa5/0x1e0
>   do_dentry_open+0x16c/0x3c0
>   vfs_open+0x2d/0x30
>   path_openat+0x70a/0xa90
>   do_filp_open+0xb2/0x120
>   do_sys_openat2+0x245/0x330
>   do_sys_open+0x46/0x80
>   __x64_sys_openat+0x20/0x30
>   do_syscall_64+0x38/0xc0
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> Freed in amdgpu_driver_postclose_kms+0x3e9/0x550 [amdgpu] age=22 cpu=1
> pid=2485
>   kfree+0x4a2/0x580
>   amdgpu_driver_postclose_kms+0x3e9/0x550 [amdgpu]
>   drm_file_free+0x24e/0x3c0 [drm]
>   drm_close_helper.isra.0+0x90/0xb0 [drm]
>   drm_release+0x97/0x1a0 [drm]
>   __fput+0xb6/0x280
>   ____fput+0xe/0x10
>   task_work_run+0x64/0xb0
>   do_exit+0x406/0xcf0
>   do_group_exit+0x50/0xc0
>   __x64_sys_exit_group+0x18/0x20
>   do_syscall_64+0x38/0xc0
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 1 +
>   2 files changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 645ce28277c2..0e89f42283c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -789,6 +789,7 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
>   
>   	tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
>   	atomic64_inc(&tlb_cb->vm->tlb_seq);
> +	atomic64_dec(&tlb_cb->vm->delayed_tlb_flush);
>   	kfree(tlb_cb);
>   }
>   
> @@ -932,6 +933,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	if (flush_tlb || params.table_freed) {
>   		tlb_cb->vm = vm;
> +		atomic64_inc(&vm->delayed_tlb_flush);
>   		if (!fence || !*fence ||
>   		    dma_fence_add_callback(*fence, &tlb_cb->cb,
>   					   amdgpu_vm_tlb_seq_cb))
> @@ -2257,6 +2259,8 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	amdgpu_vm_set_pasid(adev, vm, 0);
>   	dma_fence_wait(vm->last_unlocked, false);
>   	dma_fence_put(vm->last_unlocked);
> +	while (atomic64_read(&vm->delayed_tlb_flush))
> +		schedule();
>   
>   	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
>   		if (mapping->flags & AMDGPU_PTE_PRT && prt_fini_needed) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 1a814fbffff8..4dc9f493d355 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -286,6 +286,7 @@ struct amdgpu_vm {
>   
>   	/* Last finished delayed update */
>   	atomic64_t		tlb_seq;
> +	atomic64_t		delayed_tlb_flush;
>   
>   	/* Last unlocked submission to the scheduler entities */
>   	struct dma_fence	*last_unlocked;

