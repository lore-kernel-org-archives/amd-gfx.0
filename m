Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D91EC433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 16:32:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70DA61378
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 16:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C70DA61378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51E0789829;
	Mon,  8 Nov 2021 16:32:43 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BF7489829
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 16:32:42 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id u18so27898948wrg.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Nov 2021 08:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=We5XdkDVJ8SrB1OTrmV5uLfgnp46o0iTPWj8WU968gY=;
 b=XgdY4FK4yXp4GHmqVb+t1120V/F654ZX7v2Ypq5f3DLMZkeKRt8yAogMudv90zj69T
 TA+i2zdzZNecRj49/0W0Sqm5gBOCZX9RspTXwTE2uKZpWFZRvQjz2iqcZbdJQdktkaJY
 bkAZkoooyezBQ40k681batPnHUpl150b9d4uHeIJDVgPxP8JVCOQp6VwA/miQeiq9SaR
 2h2CBu5cvOAYm64A2NNMJIJ01Cj++4yk9kpSFfuu3SxVZ6lOb37PjW/7q3EwKl7aLSFd
 dk0JAfVMaq0fERKtysBL/yoMtMLi9MeaUcJxOSKbpalrSBSA+NnVBsc/jbhKHo9tD7G/
 t9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=We5XdkDVJ8SrB1OTrmV5uLfgnp46o0iTPWj8WU968gY=;
 b=rOkKlVGLyd9Q9NqUc1P0rOhm222dLJyV4tEi9wWj+XbJDsOakLFdiveFzZOvU0cVx4
 fVlaqs2hZvimnqDL6iQPxBe/VvrrYmVNG/WXuUbbMD4lXpkSMx+dvABl9tS9U9j2nIEa
 uKl08BjmqyOhM0UbbYpUUqvRIP8XWHwlz5Bbh2KOwboe62Jj+bfY4m8A9IoNBZYnDvX3
 G/JKuRNzx5zuFsZ6Mav7+fat76+Xb0XrnBNihfIxM/kVPL+QhE/VexlINFQ3QJycdxQJ
 mLMowrrpI1gvsW4MDKiaVWq5Xup9FCKmiXZ3rx2/xKsziigzCtvoYP2HLLARZd169WFT
 v1Pg==
X-Gm-Message-State: AOAM532qUqQCWNvMUdajocMVW8m2UkNEHxDSgjzRClkC/Unv3LlwfAUU
 ul4qQ1NwA235cC3ZTSc6ZV9bl0IbqGU=
X-Google-Smtp-Source: ABdhPJwCnOHoGA2XHeSPnZUDjxsc8rKS0Dt/FRH6YE2p8K4IrS4Q/HTiyE933I+acg/hnOO6CTcfow==
X-Received: by 2002:a5d:58c5:: with SMTP id o5mr501850wrf.15.1636389161009;
 Mon, 08 Nov 2021 08:32:41 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:1b4e:f085:32f:250a?
 ([2a02:908:1252:fb60:1b4e:f085:32f:250a])
 by smtp.gmail.com with ESMTPSA id q8sm17019823wrx.71.2021.11.08.08.32.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Nov 2021 08:32:40 -0800 (PST)
Subject: Re: [PATCH] drm/amdkfd: lower the VAs base offset to 8KB
To: Felix Kuehling <felix.kuehling@amd.com>, Alex Sierra
 <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211105192540.16241-1-alex.sierra@amd.com>
 <7b2d01fc-1058-e92b-e30f-98a72701f274@gmail.com>
 <f97e6a35-ac4c-2ef5-5fd4-e83fa8832fdc@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <75467c79-cba9-6083-ad7d-8a9ad5506417@gmail.com>
Date: Mon, 8 Nov 2021 17:32:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f97e6a35-ac4c-2ef5-5fd4-e83fa8832fdc@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.11.21 um 15:35 schrieb Felix Kuehling:
> Am 2021-11-08 um 5:22 a.m. schrieb Christian König:
>> Am 05.11.21 um 20:25 schrieb Alex Sierra:
>>> The low 16MB of virtual address space are currently reserved for kernel
>>> mode allocations mapped into user virtual address space. This causes
>>> conflicts with HMM/SVM mappings at low virtual addresses. We tried to
>>> move those kernel mode allocations to the upper half of the 64-bit
>>> virtual address space for GFX9, which is naturally reserved for kernel
>>> use. However, TBA (trap handler code) has problems to access addresses
>>> in the high virtual space. We have decided to set this to 8KB of the
>>> lower address space as a temporary fix, while investigate TBA address
>>> problem. It is very unlikely for user space to map memory at this low
>>> region.
>> Unfortunately that is not correct. IIRC every program run inside wine
>> maps something at the 16-64KiB addresses.
>>
>> Don't ask me what that stuff is good for, but we already ran into
>> problems because of exactly that.
> It's only a problem if the application tries to map that memory on the
> GPU through the HMM/SVM API. As long as there is no conflict with GPU
> mappings created by the application, the GPU can safely use those
> addresses for its purposes.

Yeah, it's perfectly up to you if you want to risk that.

I've just double checked with running LTspice in wine and that indeed 
maps a lot of stuff starting at the 16KiB offset.

Not sure if that will ever collide with this, but I think that could 
indeed happen.

Regards,
Christian.

>
> Regards,
>    Felix
>
>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>> index 2e86692def19..d1388896f9c1 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>> @@ -308,7 +308,7 @@
>>>     * 16MB are reserved for kernel use (CWSR trap handler and kernel IB
>>>     * for now).
>>>     */
>>> -#define SVM_USER_BASE 0x1000000ull
>>> +#define SVM_USER_BASE (u64)(KFD_CWSR_TBA_TMA_SIZE + 2*PAGE_SIZE)
>>>    #define SVM_CWSR_BASE (SVM_USER_BASE - KFD_CWSR_TBA_TMA_SIZE)
>>>    #define SVM_IB_BASE   (SVM_CWSR_BASE - PAGE_SIZE)
>>>    

