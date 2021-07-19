Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEF3C636C9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 08:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8941761175
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 08:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8941761175
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492EA6E0BC;
	Mon, 19 Jul 2021 08:24:58 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 667866E0BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 08:24:56 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id f17so20939499wrt.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 01:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=0WqJfUmRsioVhF12eo5tTdilSHmaNWccDdNr9OGHnQo=;
 b=aMbzhcPbJFEAvHAaGHWvrZjDwnT9K+hZzVFhN2A+wWjKX0Pgf3BYDg+nY3GVcdY+pa
 YAoAA9vEC3xRlYkgY9iqLuJEm4H1Qi1NIefrvP0F5vQtv6RPplcNaL0siE07/ZafP2fR
 Tl3z7yMPe7335ppukOoGVflGe7SLB2lfJ+0QSeViVLCq3PxAAQZUX4Q4Q1Vthe1o4LdI
 khhfoR/6RqfL6Y3iJNGMz6X0IUSZ3QXIi8anBLX510e5urf4H2ujkgeTbK7Zs1VsFDEt
 1PGUNJXzdlH4+w2O5oDly4haZp0ghDd+NrzNMt1uG06JsNuz4M16VLAzEphnDYwWlAQx
 YRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=0WqJfUmRsioVhF12eo5tTdilSHmaNWccDdNr9OGHnQo=;
 b=sfRzRv08ih2diz0NGizlcnm1hTFSARA/nQE835nCwkWs/xMucrbRNLrUw7oMGQaSjf
 gANn+zyDr/3eRy/hn5mD7s6YXKGqFKRCWUAS8xhNNNyvM3T/45dec97fayZBiVW6PCuk
 nf03+sn58jV93LQKCU40J6VguhHl8DbxHHl5WN7ZJW480MYEtul8aRU6eprnIhHKdExD
 r20tTWGgQ5PBDm80gkJe4nFPbO6UhtlN79o3RyEZBULOjtWuXsUHwnVwiDbE10BXZlRw
 /Uc3Vup58XMF1Rwy65j/sGBepf38AoSTr64ULbiS+1oHWv1bTQ+fkJRSDgNlvtqPbqeq
 EBDA==
X-Gm-Message-State: AOAM533eFb1CYmo5Gjh3mmCIX3zhGYBQWpcxtZ9emUWmxOD/nFDEH64F
 puFf214IwbPM7DjQDaqHk+Tgv6GBaow=
X-Google-Smtp-Source: ABdhPJyvVljOCFR+cE7UcrAA6euszrdt/nDJogbO6pH/m9KgdV/7uKdCh3AsR0BWy6Ru0PfP6mEomw==
X-Received: by 2002:adf:ed46:: with SMTP id u6mr28410999wro.252.1626683095056; 
 Mon, 19 Jul 2021 01:24:55 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:e48d:68a9:5ef4:9e09?
 ([2a02:908:1252:fb60:e48d:68a9:5ef4:9e09])
 by smtp.gmail.com with ESMTPSA id h9sm15859858wmb.35.2021.07.19.01.24.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jul 2021 01:24:54 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/amdgpu: vm entities should have kernel priority
To: Jingwen Chen <Jingwen.Chen2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210719055754.244832-1-Jingwen.Chen2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a56009a5-4793-7301-2a80-b4b051db6c0c@gmail.com>
Date: Mon, 19 Jul 2021 10:24:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719055754.244832-1-Jingwen.Chen2@amd.com>
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
Cc: horace.chen@amd.com, monk.liu@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 19.07.21 um 07:57 schrieb Jingwen Chen:
> [Why]
> Current vm_pte entities have NORMAL priority, in SRIOV multi-vf
> use case, the vf flr happens first and then job time out is found.
> There can be several jobs timeout during a very small time slice.
> And if the innocent sdma job time out is found before the real bad
> job, then the innocent sdma job will be set to guilty as it only
> has NORMAL priority. This will lead to a page fault after
> resubmitting job.
>
> [How]
> sdma should always have KERNEL priority. The kernel job will always
> be resubmitted.

I'm not sure if that is a good idea. We intentionally didn't gave the 
page table updates kernel priority to avoid clashing with the move jobs.

Christian.

>
> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 358316d6a38c..f7526b67cc5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2923,13 +2923,13 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	INIT_LIST_HEAD(&vm->done);
>   
>   	/* create scheduler entities for page table updates */
> -	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
> +	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_KERNEL,
>   				  adev->vm_manager.vm_pte_scheds,
>   				  adev->vm_manager.vm_pte_num_scheds, NULL);
>   	if (r)
>   		return r;
>   
> -	r = drm_sched_entity_init(&vm->delayed, DRM_SCHED_PRIORITY_NORMAL,
> +	r = drm_sched_entity_init(&vm->delayed, DRM_SCHED_PRIORITY_KERNEL,
>   				  adev->vm_manager.vm_pte_scheds,
>   				  adev->vm_manager.vm_pte_num_scheds, NULL);
>   	if (r)

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
