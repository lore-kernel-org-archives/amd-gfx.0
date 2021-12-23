Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3307BC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Dec 2021 07:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91FAB10E29B;
	Thu, 23 Dec 2021 07:50:56 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 876BB10E29B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Dec 2021 07:50:55 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id s1so9774626wra.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 23:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=2sawUJv55t2zwubYgV+3fS8CDla7EdnpNrgZj8HMf1s=;
 b=I/Du/Eu0dSaQAVhXJpOAlcLuYdobKvtQEIYKeJN688V0Ai7K1EkWQb7QjlRH0KRmaA
 p317uX7C0mABbRuT7Zc+1wp+s5sjIe0WLSBWWThZNpzS1vGITRK4yrwbgkwNyNdj+hDo
 WrQoYFwL/c/ev/hhcdJ4jrfu9idLYrh7X2QQ+w3JgS1B+EcRqGJ9P5h9LNb8Qr2UQLKB
 A0dBiSPCcaPbizy7yTvTNp+KIn/zKS50px9hPFHTrueeyneKPjcryI+fsPNzf0V31UBX
 u6b+cpeFqaqPWJoA7KIGuYzTm/xNWHcnhsVVy2YSNtIfsXXIiGzdCij4mQJZVj+tKXSI
 tyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2sawUJv55t2zwubYgV+3fS8CDla7EdnpNrgZj8HMf1s=;
 b=gz9fj2w8wL4dDNgHurAwBbWyzr3p/SMPQocEHiN2Ip22/h2ZdtW3ybEUYLOfAxuq0Z
 i4WlvDDH99MzYad+2jQNfdE7p47xfb2bJFR1n5A6I1ocFf7dWmCK2PbmA/O03RB8KHqJ
 bPzGwG2asHDRWgiIaZWUbl63l5cdcXVnQVcmRUmODlK85kzBo659Fsh+TPOjdV49wl8M
 b6Mj/lLaea6lL81WYA5sT9f3BoCF7Ty7S4/qEFHLu1CmNiO2/6LOFTe4gfGgQUMcu0wY
 gLuMCxfGT86jku+ZqU7WMeSStgIYWT97zJhOvDElsPiKBbBqDw6jnb7eez9bRvr06dVh
 tG5Q==
X-Gm-Message-State: AOAM533Ty6e+a2DDANQNB+l1EX6RxFnNgfWsrULTMyfRPRTXX+tH89SB
 z0FBxPJyzsWvyTYyAsVwfouCLqVvlCA=
X-Google-Smtp-Source: ABdhPJwwIEfaZ50+aIYc3xgGZuMHzSYzHMVJoEdPDgAVeJgaccMKQ6r35D+vCqekx9EbF1hq4oGyTg==
X-Received: by 2002:a5d:6da5:: with SMTP id u5mr826677wrs.87.1640245854018;
 Wed, 22 Dec 2021 23:50:54 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id m17sm7690114wms.25.2021.12.22.23.50.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Dec 2021 23:50:53 -0800 (PST)
Subject: Re: [PATCH] drm/ttm: add workaround for some arm hardware issue
To: Alex Deucher <alexdeucher@gmail.com>, "Deng, Emily" <Emily.Deng@amd.com>
References: <20211222055140.1215839-1-Victor.Zhao@amd.com>
 <b6edb4d8-b9b6-224f-d35f-5477fc1f7687@gmail.com>
 <PH0PR12MB5417224A3CDAAE1B030BAAE88F7D9@PH0PR12MB5417.namprd12.prod.outlook.com>
 <CADnq5_Mzbu-Qmz5Nr7RoPPr4EsbAY7z2+n6RhTgR3nRxfqPgig@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e58a4577-d4a5-fd5c-6775-78cc45b9501b@gmail.com>
Date: Thu, 23 Dec 2021 08:50:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_Mzbu-Qmz5Nr7RoPPr4EsbAY7z2+n6RhTgR3nRxfqPgig@mail.gmail.com>
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
Cc: "Zhao, Victor" <Victor.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 22.12.21 um 15:11 schrieb Alex Deucher:
> On Wed, Dec 22, 2021 at 3:18 AM Deng, Emily <Emily.Deng@amd.com> wrote:
>> [AMD Official Use Only]
>>
>> Currently, only ampere found this issue, but it is hard to detect ampere board, especially on arm passthrough environment.
> Isn't this already handled in drm_arch_can_wc_memory()?

Could be, that function controls if we are trying to setup USWC in the 
first place.

Christian

>
> Alex
>
>> Best wishes
>> Emily Deng
>>
>>
>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>> Christian König
>>> Sent: Wednesday, December 22, 2021 4:11 PM
>>> To: Zhao, Victor <Victor.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
>>> Subject: Re: [PATCH] drm/ttm: add workaround for some arm hardware issue
>>>
>>> Am 22.12.21 um 06:51 schrieb Victor Zhao:
>>>> Some Arm based platform has hardware issue which may generate
>>>> incorrect addresses when receiving writes from the CPU with a
>>>> discontiguous set of byte enables. This affects the writes with write
>>>> combine property.
>>> Can you point out which arm platforms are that exactly?
>>>
>>>> Workaround by change PROT_NORMAL_NC to PROT_DEVICE_nGnRE on arm.
>>>> As this is an issue with some specific arm based cpu, adding a ttm
>>>> parameter to control.
>>> Something as fundamental as this should not be made controllable by an
>>> module parameter.
>>>
>>> Write combining is very important for good performance and so we should
>>> only disable it on boards where we know that this won't work correctly.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/ttm/ttm_module.c | 8 +++++++-
>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/ttm/ttm_module.c
>>>> b/drivers/gpu/drm/ttm/ttm_module.c
>>>> index e87f40674a4d..b27473cbbd52 100644
>>>> --- a/drivers/gpu/drm/ttm/ttm_module.c
>>>> +++ b/drivers/gpu/drm/ttm/ttm_module.c
>>>> @@ -41,6 +41,12 @@
>>>>
>>>>    #include "ttm_module.h"
>>>>
>>>> +static int enable_use_wc = 1;
>>>> +
>>>> +MODULE_PARM_DESC(enable_use_wc,
>>>> +    "control write combine usage on arm platform due to hardware issue
>>>> +with write combine found on some specific arm cpu (1 =
>>>> +enable(default), 0 = disable)"); module_param(enable_use_wc, int,
>>>> +0644);
>>>> +
>>>>    /**
>>>>     * ttm_prot_from_caching - Modify the page protection according to the
>>>>     * ttm cacing mode
>>>> @@ -63,7 +69,7 @@ pgprot_t ttm_prot_from_caching(enum ttm_caching
>>> caching, pgprot_t tmp)
>>>>    #endif
>>>>    #if defined(__ia64__) || defined(__arm__) || defined(__aarch64__) || \
>>>>       defined(__powerpc__) || defined(__mips__)
>>>> -    if (caching == ttm_write_combined)
>>>> +    if (caching == ttm_write_combined && enable_use_wc != 0)
>>>>               tmp = pgprot_writecombine(tmp);
>>>>       else
>>>>               tmp = pgprot_noncached(tmp);

