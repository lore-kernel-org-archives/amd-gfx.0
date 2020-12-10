Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AF9C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 10:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 635E623A7C
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 10:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635E623A7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01B706EA65;
	Thu, 10 Dec 2020 10:28:10 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D436EA65
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 10:28:09 +0000 (UTC)
Received: by mail-ed1-x542.google.com with SMTP id cm17so4924278edb.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 02:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=UJ5jqdmqRViUPGt4OfcpfviDjV5jI9Taxajqh8cSNqo=;
 b=LKRdEIchpf+5mf7ICZwiuMPRkFpCRZlZZW84nur9w0U0JP7dFUxBQYwwjEjEfWEYpN
 EUDPfddDVg9Sz2cNY8l5NK1R5ybqN3CpqTJpZ7ASR3ZA6wkNoBHSTQ8O+ER7XZ5ps3n7
 4XrVIUQifmOw/3pn4r43kJJ69K/h4QFAl6L/cemBTJeCmZnD2oSw56GHu2MFAHVx9gx8
 X1yBoSABvDE+Gcj1g7/YI8Z5I1d+cSNfJt6ryvbTQ/aUxJg1wMkBQa9uGw6KM/AEzCpk
 31fLcD0af6oNfxwn0BvRAAUDGCvFALUfJTzKHeCteW2Y/mWH40UxIbROG4EFSOpI3PCZ
 VnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=UJ5jqdmqRViUPGt4OfcpfviDjV5jI9Taxajqh8cSNqo=;
 b=VPR98oOlELo3WxAt5eyZjFluPugzFiuUxV7nk/q5d+iM8TJrP+4xmdoWnfUI8eUoai
 dWcob+H0LyA7g4C92h2/XJWiAaau70Mfqgs4iXBFneRJlsdjeFwul+90kp60YSTmMM7U
 irRWy6hgQYKL5v3wkTFSpf1qREcetT20hFrsE2cm5K4VKjgsou+hX1TSZWVSZ4XV7YY6
 QwL7g+kLfz7Woa2g9tZ+uTr/TynumyVG1FNFZ1UhE3vS7lCS8eOY5q7l+unQaXtm/JxH
 OTGejNFBKDHkEQvrn5zBxI1PJWroPlEDnPhnMK9YwZ0Q56PvoIlNvpasOAyrEDoJFc6G
 ATZQ==
X-Gm-Message-State: AOAM5310FZaC+B2yZGsDEJ8YXWHrbUvu7qGwYgOs/S4rtA5lAYHcWJma
 lDPXLAXgnA5o0BlPu1yseENREvLJu9U=
X-Google-Smtp-Source: ABdhPJw5GJmfox849a7Ba5JvyD0YXyfFJ8vwJdqbCcwVA2W7cGbPC4ZPbPimN10SOWuLiz9KECjWWQ==
X-Received: by 2002:a05:6402:142f:: with SMTP id
 c15mr6069754edx.33.1607596087482; 
 Thu, 10 Dec 2020 02:28:07 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id i24sm3962150ejx.31.2020.12.10.02.28.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Dec 2020 02:28:06 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: take runtime pm reference when we attach a
 buffer
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201204204130.3697-1-alexander.deucher@amd.com>
 <CADnq5_PABFEnCdvnZfm832aDHti66ujdzTjUFur3FT-O-+wbKg@mail.gmail.com>
 <410bc5c9-381b-5e65-5595-ec891f0edae2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2eb41038-2e69-68ab-2f6b-017cd1bcb455@gmail.com>
Date: Thu, 10 Dec 2020 11:28:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <410bc5c9-381b-5e65-5595-ec891f0edae2@amd.com>
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

Am 10.12.20 um 05:49 schrieb Shashank Sharma:
> On 09/12/20 11:00 pm, Alex Deucher wrote:
>> On Fri, Dec 4, 2020 at 3:41 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>> And drop it when we detach.  If the shared buffer is in vram,
>>> we need to make sure we don't put the device into runtime
>>> suspend.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Ping?  Any thoughts on this?  We really only need this for p2p since
>> device memory in involved, but I'm not sure of the best way to handle
>> that.
>>
>> Alex
>>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 16 ++++++++++++++--
>>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> index 5b465ab774d1..f63f182f37f9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> @@ -40,6 +40,7 @@
>>>   #include <linux/dma-buf.h>
>>>   #include <linux/dma-fence-array.h>
>>>   #include <linux/pci-p2pdma.h>
>>> +#include <linux/pm_runtime.h>
>>>
>>>   /**
>>>    * amdgpu_gem_prime_vmap - &dma_buf_ops.vmap implementation
>>> @@ -187,9 +188,13 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
>>>          if (attach->dev->driver == adev->dev->driver)
>>>                  return 0;
>>>
>>> +       r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>> +       if (r < 0)
>>> +               goto out;
>>> +
> I am a bit skeptical if we should fail the BO reserve if we don't get the sync ? I was hoping to continue with it, with a warning maybe, so that it doesn't block the existing functionality ?

I'm not sure why pm_runtime_get_sync() could fail, but not attaching the 
DMA-buf is certainly the best we could do here in that moment.

Otherwise we could end up in accessing the PCIe BAR with power disabled 
and that's indeed kind of bad.

Christian.

>>>          r = amdgpu_bo_reserve(bo, false);
>>>          if (unlikely(r != 0))
>>> -               return r;
>>> +               goto out;
>>>
>>>          /*
>>>           * We only create shared fences for internal use, but importers
>>> @@ -201,11 +206,15 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
>>>           */
>>>          r = __dma_resv_make_exclusive(bo->tbo.base.resv);
>>>          if (r)
>>> -               return r;
>>> +               goto out;
>>>
>>>          bo->prime_shared_count++;
>>>          amdgpu_bo_unreserve(bo);
>>>          return 0;
>>> +
>>> +out:
>>> +       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> Why not just pm_runtime_put_sync ? Why autosuspend ?
>
> - Shashank
>
>>> +       return r;
>>>   }
>>>
>>>   /**
>>> @@ -225,6 +234,9 @@ static void amdgpu_dma_buf_detach(struct dma_buf *dmabuf,
>>>
>>>          if (attach->dev->driver != adev->dev->driver && bo->prime_shared_count)
>>>                  bo->prime_shared_count--;
>>> +
>>> +       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>> +       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>   }
>>>
>>>   /**
>>> --
>>> 2.25.4
>>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cshashank.sharma%40amd.com%7Cd5fccf427c34414ff4e708d89c682898%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637431318483043257%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=NpCTY%2FVKd%2FBDi1wsFC79qSUTmNHx3nBp0HUj3m0cFeM%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
