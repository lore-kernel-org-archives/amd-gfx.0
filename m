Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE71C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 07:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EB9E6E422;
	Thu, 25 Nov 2021 07:03:44 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F25BE6E422
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 07:03:42 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id s13so9416065wrb.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 23:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=xakTUuBInUuaIl5s2Th7h0UuaNZZ4rgueddVOYFlLgc=;
 b=BJcba99r2yuyCzieC0H7CaDbA+y+vJ6ZNGyLlWqEsPiqquft8/DVRzmBgh2GzXXJE9
 Pw16l5FsCyAqmRofm8kwxj4xTcAsPdWv70dmXWbm0XMJdR7cbl/ewnlJwYpR896+XkGb
 TaFVvHMFAEIwRvpWOwHNNeQphHdWqeed3+aL4KdN2VVSCLO9Wyhy951synkvx8ALBSFa
 x2ldTuIg+Pw/Ki2ltJl6LoTvZI7XCLmFw9uabZ4wSge5BfoS4BLtEvY66bKwWA3zeOTB
 wLNdztncmbshbn6qGYnH00FQrZb3iYGuA6UwBru0sOc77K1a61NCs2tItZP+KIaAX0Si
 3AmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=xakTUuBInUuaIl5s2Th7h0UuaNZZ4rgueddVOYFlLgc=;
 b=gt9wmA8U74ZVG9BSEWL8U4utbbEfqzkTVfBLHx0hkQ8gQri5O/sjz8NWTm06hgjAld
 7Ivmfq3kh7aTgILp1AZkI+QBCoS8b5ZWWKVHNFbs/VKL8N6WrjynW+hz/5PILFdoaEm+
 U74zjd3cQoXNBcI27TymQum+1trUDTD9IGM8ztNBozgzGt24NH2ErJDE17IWd15lM/uz
 0IkT+yfIf673ReLxsOrjEvmIj1Rf16B8sYiwRp8lUtlkh1y3VEEL9MAzXJRl5H53d6Yd
 PLPOFfcqe4CU2fJVQBJA9wAuaPgZXygBIgqeXB6VJLe/JqQbIcidPmsHCGA3Z9VJLdsl
 vFxg==
X-Gm-Message-State: AOAM5305nBGCu3nvHfo0lB3IyEcOZ8oiCdDW93XZXnIRlni/V5YljhNb
 H9tsnFdtDatHaFkPpmuYpI8=
X-Google-Smtp-Source: ABdhPJwNhZVh72Rks5SZ9C0YE0BIFpvwHwdz/AEtqjqV80yq9iGDK7+1K0Ojfghftvm26OQf6jMrsg==
X-Received: by 2002:a5d:4492:: with SMTP id j18mr3995655wrq.397.1637823821575; 
 Wed, 24 Nov 2021 23:03:41 -0800 (PST)
Received: from [192.168.178.21] (p57b0b77b.dip0.t-ipconnect.de.
 [87.176.183.123])
 by smtp.gmail.com with ESMTPSA id h16sm2047289wrm.27.2021.11.24.23.03.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Nov 2021 23:03:40 -0800 (PST)
Subject: Re: [PATCH v5] drm/amdgpu: handle IH ring1 overflow
To: Felix Kuehling <felix.kuehling@amd.com>, philip yang <yangp@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211123192254.21681-1-Philip.Yang@amd.com>
 <3d17fd21-751d-6f87-95b9-d120db7f4a0e@gmail.com>
 <5ec42928-995f-04c6-c7c8-3d2e33744457@amd.com>
 <1d31f11a-9ba5-4973-5875-11ef6e1bcf89@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a832f0bc-fcb1-4e13-3cf7-c598e96a665b@gmail.com>
Date: Thu, 25 Nov 2021 08:03:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1d31f11a-9ba5-4973-5875-11ef6e1bcf89@amd.com>
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.11.21 um 21:20 schrieb Felix Kuehling:
> Am 2021-11-24 um 10:23 a.m. schrieb philip yang:
>>>>      #define amdgpu_ih_get_wptr(adev, ih)
>>>> (adev)->irq.ih_funcs->get_wptr((adev), (ih))
>>>>    #define amdgpu_ih_decode_iv(adev, iv) \
>>>>        (adev)->irq.ih_funcs->decode_iv((adev), (ih), (iv))
>>>> +#define amdgpu_ih_decode_iv_ts(adev, ih, rptr, offset) \
>>>> +    (WARN_ON_ONCE(!(adev)->irq.ih_funcs->decode_iv_ts) ? 0 : \
>>> Please drop that WARN_ON_ONCE here.
>>>
>> Agree, will drop it.
>>
> I suggested this. We're assuming that this function will never be called
> on hardware that doesn't support time stamps, and that all hardware with
> time stamps will implement the decode_iv_ts function. But it's good to
> get a log message if that assumption is ever broken, rather than just
> silently getting wrong results.

Well exactly that's the point, you won't get wrong results but a NULL 
pointer exception instead.

So we already have a backtrace in the logs.

Regards,
Christian.

>
> Regards,
>    Felix
>
>
>> Regards,
>>
>> Philip
>>

