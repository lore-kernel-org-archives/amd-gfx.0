Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC88AC4320A
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 09:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B006A60E52
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 09:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B006A60E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24AC76EA2C;
	Wed,  4 Aug 2021 09:01:27 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F0086EA25
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 09:01:25 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id m12so1341307wru.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Aug 2021 02:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=1y2BddBgSeE4j7AmD7g4wisNFNGP044GJisTBScWDEc=;
 b=UzB6QkDKqGaD7Ij9GZcEFkFvAvC8GeTTbvyDZhqEf2hj4jO8dul0/ZdVVRztAuw1qi
 NNbiptAe2N1OA/OT4xfqSvbEBXzA9jq2E8sbk4lbXL3wKD7Vls0rjJ7v6YN2/9yWDcgm
 UWVZPzHZ4eSyxSo+Fi0Ll6HaTq1oJAJ5vgSZW3Klke7q2EoKZNAcmGEdQLwfTw5TKsG4
 cW5rtwwl7/R/vGfvcqYkC7ruOdItANU//UYUg2QoXUFLdJZjZtckfoLS7449friB44Si
 JtrAB+2zq8eTuLUFtf78Zlsw3pclrRMCYzl6QNG/M5dHSHTiMZtfTFCxwox39virFiq+
 s3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=1y2BddBgSeE4j7AmD7g4wisNFNGP044GJisTBScWDEc=;
 b=sP7PVoqqnzsW86QTMB8Ls1arHpKNVL/kZcCvfMvf+RYhUy5NtMwyx9yx+wDYpoKIFh
 oiN2M2BOyXGLVjfiGCwJla9hg6kLHPJrAVu1sdsT8a0TeM9Ph5PxEU7w8SYyow1VCth7
 U4ETjYVsLubvy46bfZwtTIeBoCcM8Eh3UFfHOU5TW6GxjzTavgW3K5OX1HsRtfyyfNHC
 RZmflezsUK34712nuzfI+CO09joNPOxGAVnnT9gSEED70F7KwvGyKAeqG5fRHgCrBzU/
 X/37ufMwIqbYejg4TVLK7naLAJcB7B75uRNWUZThJ8qAhR89sNfIXVza1x8LWKz5lwlR
 EJxw==
X-Gm-Message-State: AOAM5318kq5fqDlJagvuRz0PwH6G70xqFj65zitOuyWxJis+21EXpHCT
 tr0ntf0Cd3sHoK44/Uw4ORqBj+g7UlM=
X-Google-Smtp-Source: ABdhPJxYUIudDej/VjNlKeHcpKN6idoty41rKYvQBNorB3h98g6pFklWGgOleYCyZcdzlTpw/r8+gA==
X-Received: by 2002:a5d:6442:: with SMTP id d2mr27942414wrw.425.1628067683673; 
 Wed, 04 Aug 2021 02:01:23 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:fc63:9f41:3d77:1613?
 ([2a02:908:1252:fb60:fc63:9f41:3d77:1613])
 by smtp.gmail.com with ESMTPSA id f194sm5323549wmf.23.2021.08.04.02.01.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Aug 2021 02:01:23 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Fix vm free pts race when process exiting
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210802223308.13076-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <920b7b04-8f8d-a57a-724e-811a4c7e581c@gmail.com>
Date: Wed, 4 Aug 2021 11:01:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802223308.13076-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.08.21 um 00:33 schrieb Philip Yang:
> Take vm->invalidated_lock spinlock to remove vm pd and pt bos, to avoid
> link list corruption with crash backtrace:
>
> [ 2290.505111] list_del corruption. next->prev should be
>   ffff9b2514ec0018, but was 4e03280211010f04
> [ 2290.505154] kernel BUG at lib/list_debug.c:56!
> [ 2290.505176] invalid opcode: 0000 [#1] SMP NOPTI
> [ 2290.505254] Workqueue: events delayed_fput
> [ 2290.505271] RIP: 0010:__list_del_entry_valid.cold.1+0x20/0x4c
> [ 2290.505513] Call Trace:
> [ 2290.505623]  amdgpu_vm_free_table+0x26/0x80 [amdgpu]
> [ 2290.505705]  amdgpu_vm_free_pts+0x7a/0xf0 [amdgpu]
> [ 2290.505786]  amdgpu_vm_fini+0x1f0/0x440 [amdgpu]
> [ 2290.505864]  amdgpu_driver_postclose_kms+0x172/0x290 [amdgpu]
> [ 2290.505893]  drm_file_free.part.10+0x1d4/0x270 [drm]
> [ 2290.505916]  drm_release+0xa9/0xe0 [drm]
> [ 2290.505930]  __fput+0xb7/0x230
> [ 2290.505942]  delayed_fput+0x1c/0x30
> [ 2290.505957]  process_one_work+0x1a7/0x360
> [ 2290.505971]  worker_thread+0x30/0x390
> [ 2290.505985]  ? create_worker+0x1a0/0x1a0
> [ 2290.505999]  kthread+0x112/0x130
> [ 2290.506011]  ? kthread_flush_work_fn+0x10/0x10
> [ 2290.506027]  ret_from_fork+0x22/0x40

Wow, well this is a big NAK.

The page tables should never ever be on the invalidation list or 
otherwise we would try to point PTEs to them which is a huge security issue.

Taking the lock just workaround that. Can you investigate how it happens 
that a page table ends up on that list?

Thanks in advance,
Christian.

>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 2a88ed5d983b..5c4c355e7d6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1045,7 +1045,9 @@ static void amdgpu_vm_free_table(struct amdgpu_vm_bo_base *entry)
>   		return;
>   	shadow = amdgpu_bo_shadowed(entry->bo);
>   	entry->bo->vm_bo = NULL;
> +	spin_lock(&entry->vm->invalidated_lock);
>   	list_del(&entry->vm_status);
> +	spin_unlock(&entry->vm->invalidated_lock);
>   	amdgpu_bo_unref(&shadow);
>   	amdgpu_bo_unref(&entry->bo);
>   }

