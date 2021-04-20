Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266FCC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 12:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B212161042
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 12:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B212161042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35E6C6E4F8;
	Tue, 20 Apr 2021 12:02:08 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 759C26E808
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 12:02:06 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id x12so37103641ejc.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 05:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=GTSmL0wEeIVVdR2nGCLglHDCj6o2/YC/Ww8JuqB927s=;
 b=mhecbE9aQ/3BWaNV5ocxb6q+EMjcPqzJEtkv4TJPWahQNBwdNJRVJSaaUgUyE4Na8v
 LG+gMV2vbm4a/9rHoCiFxHvfjhibz6yvS/fDYq+N/LrkulXkCh91k/srFeviKWokfBxD
 tbAyTG8NwjEbp+YrIrX4wx5tk1LMQWcloV+nuYZlgRswivc92Emld2VA4cX6u90Pv3OZ
 LdzYUsJa6J684yDXpsbOuDMjs19nvb7yMdVlNVbWrn2PkD3tDyEZWDzExneVM4ftVw12
 X4fCuWmj7FO2QFmWjP+EqgYagN+AmMdcmG3dBKrjOuuMrfGL3bWGMzrZGhrtv9A80ymX
 RS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=GTSmL0wEeIVVdR2nGCLglHDCj6o2/YC/Ww8JuqB927s=;
 b=CpAWquFj/LU9PCf8bMBFA4nGeJHf+7+c43QPwF4Gl8mJQgSbyohqx4Naj8N0ImicEh
 s0oydBBNpRjkAicQtwuE5JsvXdGUCYOC641YNNDUzw+W7WoBRqpEwxjH7oz78MBGD8cR
 K4gDkGVjn3Ya+kiId2+5f/1nUL9UxkC19j2Lo6nKtmkS5pwl3sqV0BHiVdDgOx5Hl8sp
 ICYSnNdLTzOs8u2iEl/b2PzZPlKIXUaqVUXFnLqVDIDzG2d+cxiKZfwWBShmZMY7v1DE
 z0raYzIg+uQyI/tMVFAU7c1/MeaLHTFcBM+R3JNAkLoWP/+X7yi+4wC0y8nR4yu7lLbQ
 C7JA==
X-Gm-Message-State: AOAM530paXEu3F23P2XThYo41Cz1zvBN2Zeb28NLSmIMxUd8Jpwq2lbQ
 xgbmudaHrI+UEoo7tFbrNFU=
X-Google-Smtp-Source: ABdhPJzJnkdtCXTe8JiqriqIRE3nrRP/cCAlLa3x3oLrYpFRRT3GjtCXlHQO7twPztQNgcIpiYsFjw==
X-Received: by 2002:a17:906:c099:: with SMTP id
 f25mr14558330ejz.499.1618920125129; 
 Tue, 20 Apr 2021 05:02:05 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:3caf:a441:2498:1468?
 ([2a02:908:1252:fb60:3caf:a441:2498:1468])
 by smtp.gmail.com with ESMTPSA id g20sm16040090edu.91.2021.04.20.05.02.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Apr 2021 05:02:04 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/amdgpu: Add show_fdinfo() interface
To: Roy Sun <Roy.Sun@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210420115148.3652-1-Roy.Sun@amd.com>
 <20210420115148.3652-2-Roy.Sun@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f092ddc7-0039-0d64-583b-bfe214038c3b@gmail.com>
Date: Tue, 20 Apr 2021 14:02:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210420115148.3652-2-Roy.Sun@amd.com>
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
Cc: David M Nieto <David.Nieto@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 20.04.21 um 13:51 schrieb Roy Sun:
> [SNIP]
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 848e175e99ff..72727117c479 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -150,6 +150,7 @@ struct amdgpu_vm_bo_base {
>   	/* protected by spinlock */
>   	struct list_head		vm_status;
>   
> +	struct list_head		bo_head;

Well I'm repeating myself. This is a no-go.

You already have the same information in the VM state machine, see 
function amdgpu_debugfs_vm_bo_info().

Christian.

>   	/* protected by the BO being reserved */
>   	bool				moved;
>   };
> @@ -274,6 +275,7 @@ struct amdgpu_vm {
>   	struct list_head	invalidated;
>   	spinlock_t		invalidated_lock;
>   
> +	struct list_head	bo_list;
>   	/* BO mappings freed, but not yet updated in the PT */
>   	struct list_head	freed;
>   
> @@ -458,6 +460,8 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>   				struct amdgpu_vm *vm);
>   void amdgpu_vm_del_from_lru_notify(struct ttm_buffer_object *bo);
>   
> +void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
> +				uint64_t *gtt_mem);
>   #if defined(CONFIG_DEBUG_FS)
>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
>   #endif

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
