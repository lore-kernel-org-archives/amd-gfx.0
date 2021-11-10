Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D753AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 14:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A32C26109D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 14:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A32C26109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 063436E328;
	Wed, 10 Nov 2021 14:32:00 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BFFC6E231
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 14:31:59 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 i8-20020a7bc948000000b0030db7b70b6bso4800639wml.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 06:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=nlkuz+PX/o/ptbM5iGl5ND8NYsLa2FXU98Ve0mlMn1Q=;
 b=SclgjnlzGt+UCoV0JFWUwc7iIJTYD2LWv1FhOcz1KK1hEyjEKettZGV295wxZ5+URr
 yhuaU3diFXEOiVUuoXodpkZ2POQ+XWumwEi5UgdcDbYajm/36VRvPidYv/BVLRoQW5G0
 /xC6WyrQV+FtY1HdC6pjX5pbZf0Ouzdr/ixUSSgnlPrY5ouYpvlDCw+cxtbVkmBSWfyQ
 jMsJzju+RINXl5Yr4yM1HcOixxKOoShQ1xiIjn+mDrjbp2RHZnwFTkNQ83GN7mpULkq2
 CMsgWNI1zy6bwHfJumEMbGv0W5SyKNhS38b/sS6LyA/I8RqJEz9xnxAajksHlv1IQ3jM
 P/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=nlkuz+PX/o/ptbM5iGl5ND8NYsLa2FXU98Ve0mlMn1Q=;
 b=aza4LQBeU6q9tTceZfQya9CGZbbWVQd+pqgY8F0DDDtHWhFcUoVPqyxTD1tQhIRMOv
 UpyZQgQ6YPeqWBPynSlZEMTDCurKx8D3FguQR8Jf5Vm7Uh3AoWLWsvES2zYWRCqa2MeV
 T9snFT/TeRJbnJgLlfIh8tM698Jj1WnN5K0Zo7EbhvHNJEnowEMPSUrWg/HhnTKFQZUX
 ZKJlc9w3xi5TJudfvrtL+3fsYDZ2DVldmiktPvK+fKeOU3tzk1RxDLQU/+EUYJTm1Tfm
 MioWkOWwsTD4hbmxgfacvA5p2n3DGHGkhMqQZuFg9lK2sfCRPk4RHxczSkrRPl8skU6Y
 s3xw==
X-Gm-Message-State: AOAM532rAMHTtXhxM4HxgVFeKTJNnbmnjZ6uzWQ/gfFk0KIksVp+OFIW
 dD0iRy8cswXAlULJJ4DaWA4=
X-Google-Smtp-Source: ABdhPJyR77d894rO9LdnlZysGaOCa60muLfzuJqGlWcvVUfXRsHPP0PamtWTow+FOKhWjv3fq883jw==
X-Received: by 2002:a05:600c:4f4b:: with SMTP id
 m11mr1978wmq.151.1636554717878; 
 Wed, 10 Nov 2021 06:31:57 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:fa11:45ae:fadf:6269?
 ([2a02:908:1252:fb60:fa11:45ae:fadf:6269])
 by smtp.gmail.com with ESMTPSA id m17sm52343wrz.22.2021.11.10.06.31.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Nov 2021 06:31:57 -0800 (PST)
Subject: Re: [PATCH 1/5] drm/amdgpu: handle IH ring1 overflow
To: philip yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211109230432.3947-1-Philip.Yang@amd.com>
 <1862b795-3401-b89f-089b-4b544957d150@gmail.com>
 <c5855126-de94-f2b4-c912-f386b6b47142@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9e4e654f-8996-fc9a-0ec6-211a7c0ddf42@gmail.com>
Date: Wed, 10 Nov 2021 15:31:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c5855126-de94-f2b4-c912-f386b6b47142@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.11.21 um 14:59 schrieb philip yang:
>
> On 2021-11-10 5:15 a.m., Christian König wrote:
>
>> [SNIP]
>
> It is hard to understand, this debug log can explain more details, 
> with this debug message patch
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index ed6f8d24280b..8859f2bb11b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -234,10 +235,12 @@ int amdgpu_ih_process(struct amdgpu_device 
> *adev, struct amdgpu_ih_ring *ih)
>                 return IRQ_NONE;
>
>         wptr = amdgpu_ih_get_wptr(adev, ih);
> +       if (ih == &adev->irq.ih1)
> +               pr_debug("entering rptr 0x%x, wptr 0x%x\n", ih->rptr, 
> wptr);
>
>  restart_ih:
> +       if (ih == &adev->irq.ih1)
> +               pr_debug("starting rptr 0x%x, wptr 0x%x\n", ih->rptr, 
> wptr);
>
>         /* Order reading of wptr vs. reading of IH ring data */
>         rmb();
> @@ -245,8 +248,12 @@ int amdgpu_ih_process(struct amdgpu_device *adev, 
> struct amdgpu_ih_ring *ih)
>         while (ih->rptr != wptr && --count) {
>                 amdgpu_irq_dispatch(adev, ih);
>                 ih->rptr &= ih->ptr_mask;
> +               if (ih == &adev->irq.ih1) {
> +                       pr_debug("rptr 0x%x, old wptr 0x%x, new wptr 
> 0x%x\n",
> +                               ih->rptr, wptr,
> +                               amdgpu_ih_get_wptr(adev, ih));
> +               }
>         }
>
>         amdgpu_ih_set_rptr(adev, ih);
> @@ -257,6 +264,8 @@ int amdgpu_ih_process(struct amdgpu_device *adev, 
> struct amdgpu_ih_ring *ih)
>         if (wptr != ih->rptr)
>                 goto restart_ih;
>
> +       if (ih == &adev->irq.ih1)
> +               pr_debug("exiting rptr 0x%x, wptr 0x%x\n", ih->rptr, 
> wptr);
>         return IRQ_HANDLED;
>  }
>
> This is log, timing 48.807028, ring1 drain is done, rptr == wptr, 
> ring1 is empty, but the loop continues, to handle outdated retry fault.
>

As far as I can see that is perfectly correct and expected behavior.

See the ring buffer overflowed and because of that the loop continues, 
but that is correct because an overflow means that the ring was filled 
with new entries.

So we are processing new entries here, not stale ones.

Regards,
Christian.

> [   48.802231] amdgpu_ih_process:243: amdgpu: starting rptr 0x520, 
> wptr 0xd20
> [   48.802235] amdgpu_ih_process:254: amdgpu: rptr 0x540, old wptr 
> 0xd20, new wptr 0xd20
> [   48.802256] amdgpu_ih_process:254: amdgpu: rptr 0x560, old wptr 
> 0xd20, new wptr 0xd20
> [   48.802260] amdgpu_ih_process:254: amdgpu: rptr 0x580, old wptr 
> 0xd20, new wptr 0xd20
> [   48.802281] amdgpu_ih_process:254: amdgpu: rptr 0x5a0, old wptr 
> 0xd20, new wptr 0xd20
> [   48.802314] amdgpu_ih_process:254: amdgpu: rptr 0x5c0, old wptr 
> 0xd20, new wptr 0xce0
> [   48.802335] amdgpu_ih_process:254: amdgpu: rptr 0x5e0, old wptr 
> 0xd20, new wptr 0xce0
> [   48.802356] amdgpu_ih_process:254: amdgpu: rptr 0x600, old wptr 
> 0xd20, new wptr 0xce0
> [   48.802376] amdgpu_ih_process:254: amdgpu: rptr 0x620, old wptr 
> 0xd20, new wptr 0xce0
> [   48.802396] amdgpu_ih_process:254: amdgpu: rptr 0x640, old wptr 
> 0xd20, new wptr 0xce0
> [   48.802401] amdgpu_ih_process:254: amdgpu: rptr 0x660, old wptr 
> 0xd20, new wptr 0xce0
> [   48.802421] amdgpu_ih_process:254: amdgpu: rptr 0x680, old wptr 
> 0xd20, new wptr 0xce0
> [   48.802442] amdgpu_ih_process:254: amdgpu: rptr 0x6a0, old wptr 
> 0xd20, new wptr 0xce0
> [   48.802463] amdgpu_ih_process:254: amdgpu: rptr 0x6c0, old wptr 
> 0xd20, new wptr 0xce0
> [   48.802483] amdgpu_ih_process:254: amdgpu: rptr 0x6e0, old wptr 
> 0xd20, new wptr 0xce0
> [   48.802503] amdgpu_ih_process:254: amdgpu: rptr 0x700, old wptr 
> 0xd20, new wptr 0xce0
> [   48.802523] amdgpu_ih_process:254: amdgpu: rptr 0x720, old wptr 
> 0xd20, new wptr 0xce0
> [   48.802544] amdgpu_ih_process:254: amdgpu: rptr 0x740, old wptr 
> 0xd20, new wptr 0xce0
> [   48.802565] amdgpu_ih_process:254: amdgpu: rptr 0x760, old wptr 
> 0xd20, new wptr 0xce0
> [   48.802569] amdgpu_ih_process:254: amdgpu: rptr 0x780, old wptr 
> 0xd20, new wptr 0xce0
> [   48.804392] amdgpu_ih_process:254: amdgpu: rptr 0x7a0, old wptr 
> 0xd20, new wptr 0xf00
> [   48.806122] amdgpu_ih_process:254: amdgpu: rptr 0x7c0, old wptr 
> 0xd20, new wptr 0x840
> [   48.806155] amdgpu_ih_process:254: amdgpu: rptr 0x7e0, old wptr 
> 0xd20, new wptr 0x840
> [   48.806965] amdgpu_ih_process:254: amdgpu: rptr 0x800, old wptr 
> 0xd20, new wptr 0x840
> [   48.806995] amdgpu_ih_process:254: amdgpu: rptr 0x820, old wptr 
> 0xd20, new wptr 0x840
> [   48.807028] amdgpu_ih_process:254: amdgpu: rptr 0x840, old wptr 
> 0xd20, new wptr 0x840
> [   48.807063] amdgpu_ih_process:254: amdgpu: rptr 0x860, old wptr 
> 0xd20, new wptr 0x840
> [   48.808421] amdgpu_ih_process:254: amdgpu: rptr 0x880, old wptr 
> 0xd20, new wptr 0x840
>
> Cause this gpu vm fault dump because address is unmapped from cpu.
>
> [   48.807071] svm_range_restore_pages:2617: amdgpu: restoring svms 
> 0x00000000733bf007 fault address 0x7f8a6991f
>
> [   48.807170] svm_range_restore_pages:2631: amdgpu: failed to find 
> prange svms 0x00000000733bf007 address [0x7f8a6991f]
> [   48.807179] svm_range_get_range_boundaries:2348: amdgpu: VMA does 
> not exist in address [0x7f8a6991f]
> [   48.807185] svm_range_restore_pages:2635: amdgpu: failed to create 
> unregistered range svms 0x00000000733bf007 address [0x7f8a6991f]
>
> [   48.807929] amdgpu 0000:25:00.0: amdgpu: [mmhub0] retry page fault 
> (src_id:0 ring:0 vmid:8 pasid:32770, for process kfdtest pid 3969 
> thread kfdtest pid 3969)
> [   48.808219] amdgpu 0000:25:00.0: amdgpu:   in page starting at 
> address 0x00007f8a6991f000 from IH client 0x12 (VMC)
> [   48.808230] amdgpu 0000:25:00.0: amdgpu: 
> VM_L2_PROTECTION_FAULT_STATUS:0x00800031
>
>> We could of course parameterize that so that we check the wptr after 
>> each IV on IH1, but please not hard coded like this.
>>
>> Regards,
>> Christian.
>>
>>>       }
>>>         amdgpu_ih_set_rptr(adev, ih);
>>

