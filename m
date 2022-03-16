Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A70C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 10:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96DC210E1E2;
	Wed, 16 Mar 2022 10:08:40 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D0EC10E1E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 10:08:39 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id bg10so3069057ejb.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 03:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=+1EaKWTnQE7RuogUxf3mIK9BGlZ0wOrM+QKJ8gbqDLI=;
 b=Pay5fbNFyYUIDtP2pRkokadmQzUaT+X6vRlVZKvhbJTLkxkdKcnnIHPJoE/EBULpCR
 MhqtvygUDIF8fn9f6CwfOOrl6BRvzTXfJ262TX1pkI2kaGSZoWqX5813wtmTcB2yg+Qm
 vx9jWpUr1Vv4TVAXfLN/AsJFm9IxfdsaCInNn0HiGLghDeGYC/M4u7prsg1aX/vgd8yB
 emxw5tw7/hsCCPeJeveGTADsc5aeJFgyUYFtxxzxACwUXD0tTfXIBvYwNlfuEaaqGgSH
 BfRFAKt+3SeOyWlbrevJNcaJ8PIiek2Q9qqQ3AUgrNZaHVffCF7dvzHZnVr/Dp5LMFYR
 xtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=+1EaKWTnQE7RuogUxf3mIK9BGlZ0wOrM+QKJ8gbqDLI=;
 b=egCULccXPlE8MtUfebf/auTvIntIqfFlGABYKwnCmNIEdDNQseYCGnxZ/b6mbeq0ZX
 I3uKTguEJxmGHfqGHW/1FgSJDXbJshR+ROe22+ivR/r8a7/WcGKEnVUIT8H+pFCznB/k
 OGHz4QYrjwcSZzwI9IZMe37CQKYi6klHsZH/YeXRUPw09uvkFHrjleBLsaCzoR/I/AcR
 1BEZXmwsLt26gf8rLE+c0LjJ+NOOYBLRVCimcDySMH7JTgw+eSpa8d9aRVt9D8FpT1bW
 IMv/cwAvaFEa5RA+jwIMgk/4f6bkS31l37SgUho4QZaSkQcmmR3V8N9PrwLTkGQURFWK
 7nyA==
X-Gm-Message-State: AOAM532gF957I+ZGU6EoQ0I30gaoqN+c06FCXCDpigvDxFyDFowHfDp6
 vQRXSXCTMi5Ft1xn05fdhNY=
X-Google-Smtp-Source: ABdhPJw5EZHPpGScgbOebUZ8oEfxjpuh+p/lREQFgI98A0jlQGZO7n0eLiaUUSKnjcxnxdYRulPm9Q==
X-Received: by 2002:a17:906:3104:b0:6ce:6b85:ecc9 with SMTP id
 4-20020a170906310400b006ce6b85ecc9mr25797870ejx.339.1647425317861; 
 Wed, 16 Mar 2022 03:08:37 -0700 (PDT)
Received: from ?IPV6:2a02:908:1252:fb60:6d1e:c9c:e665:48a3?
 ([2a02:908:1252:fb60:6d1e:c9c:e665:48a3])
 by smtp.gmail.com with ESMTPSA id
 hg11-20020a1709072ccb00b006cee4fb36c7sm685157ejc.64.2022.03.16.03.08.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Mar 2022 03:08:37 -0700 (PDT)
Message-ID: <84b01f7f-5cdd-50ac-a7bd-3c14d9bc823f@gmail.com>
Date: Wed, 16 Mar 2022 11:08:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] drm/amdgpu: add workarounds for VCN TMZ issue on
 CHIP_RAVEN
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>
References: <20220314024519.2201231-1-Lang.Yu@amd.com>
 <39dcbcab-8a92-4a01-e355-6e37ac4f1ce6@molgen.mpg.de>
 <YjE9CDYjvJ72IQNg@lang-desktop>
 <c502a443-0987-6d88-1ef3-603723f04634@molgen.mpg.de>
 <YjGB+Dx4nUIOyuMf@lang-desktop>
 <aa16b25a-197d-87d5-001f-87fdfcd1a139@gmail.com>
 <36b37edb-b8e1-5d12-7683-19b8f692fbc5@molgen.mpg.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <36b37edb-b8e1-5d12-7683-19b8f692fbc5@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 16.03.22 um 10:57 schrieb Paul Menzel:
> Dear Christian,
>
>
> Am 16.03.22 um 10:41 schrieb Christian König:
>> Am 16.03.22 um 07:21 schrieb Lang Yu:
>>> On 03/16/ , Paul Menzel wrote:
>
>>>> Am 16.03.22 um 02:27 schrieb Lang Yu:
>>>>> On 03/15/ , Paul Menzel wrote:
>>>>>> Am 14.03.22 um 03:45 schrieb Lang Yu:
>>>>>>
>>>>>> Thank you for your patch. A shorter commit message summary would be:
>>>>>>
>>>>>>> drm/amdgpu: Work around VNC TMZ issue on CHIP_RAVEN
>>>>>>> It is a hardware issue that VCN can't handle a GTT
>>>>>>> backing stored TMZ buffer on CHIP_RAVEN series ASIC.
>>>>>> Where is that documented, and how can this be reproduced?
>>>>> It is documented in AMD internal Confluence and JIRA.
>>>>> Secure playback with a low VRAM config(thus TMZ buffer
>>>>> will be allocted in GTT domain) may reproduce this issue.
>>>> It’d be great if as much of the details from this non-publicly 
>>>> accessible
>>>> information could be added to the commit message, and a way to 
>>>> reproduce
>>>> this as there does not seem to be a test for this. (Also I guess a 
>>>> tag with
>>>> a reference to the internal issue would be acceptable, so in case more
>>>> question surface in the future.)
>>> Thanks. I will add an internal link.
>>
>> Lang, please don't!
>>
>> This isn't an information which is expected to be made public.
>
> Well, how are then even the AMD folks able to link a (upstream) commit 
> to an issue?

Well quite simply: We don't do that since it isn't necessary.

>
> If it’s not possible, even more detailed information about the issue 
> including how to reproduce it needs to be part of the commit message.

No, why should we do that? It's an AMD internal hardware problem which 
we add a software workaround for here. The hardware details why and what 
are completely irrelevant to the public.

All that we need to document is that VCN can't handle GTT on Raven, and 
that's exactly what the commit message is doing. That's perfectly enough 
to write a test case.

Regards,
Christian.

>
>
> Kind regards,
>
> Paul
>
>
> PS: The coreboot project includes references to Google’s internal 
> bug/issue tracker, but also has the requirement that the commit can be 
> reviewed and tested without access to it.

