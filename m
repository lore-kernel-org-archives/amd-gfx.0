Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD86C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 06:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7DEB10E437;
	Wed, 27 Apr 2022 06:10:25 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7114910E437
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 06:10:25 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id e23so704790eda.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 23:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=lhbfiayS2vZMmpuFrckcgfM08MVU2o5ZN4zUBHsaZvU=;
 b=h5ORqNVWkmDe4SO0BAhUaGwuofNQAIy2V3VCeRS4bu/hfUQwY2R34wT0ljks7LjsMP
 9qDLW3ghdK2AgPguOVv4GOa9DobLHKG2JQT3vUGEBhDmAIDgpA5f8q/9P5DN473RxTlB
 9PUzP34bpo9m6x6NDBwC3G0NoZ2lX8Std0ZKtpAupWA7uiW6e+BhlrTsKySBJwGFiliQ
 lbTnK6SmCD1buC+iehnLBWVnkTJe4rPsPuYeMD1NtnM9VFfj2y3ve3ijd7DRHfKCxymb
 J9yglsExtlpTaaosfAuvQ3p+NwJki9X6sO/0LHtCAx5UxsVJC/mzqTMehPJp9A089syk
 gZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=lhbfiayS2vZMmpuFrckcgfM08MVU2o5ZN4zUBHsaZvU=;
 b=GgL9LrMeXgWc9BQmRtrLDIWTq3cPkBY/JFoF6tBQdQBbzJ5dlwq6EYBpnr0+fDUEWp
 iRoI22B9260qZj8PA2fHvsrgMpOsUFDkjl7m9M+W4VZwf+Do0CAXFWxET9q0F72B5owL
 5suPfTab22TBy+EZkt6MCZrnAYVyiGtBVf7FtxMT7YdpDMskmhRfp63ODqQNw1d8rxXA
 ljUN0TGbgwXGnrwf4/O+iXjSaeamvmlfzVtmQC3w/pLZE+tTM0EzQEsJF8qXk3iySjz7
 u8YvW6HlbVDANoEoAeHYYkAwPVup2ZE+07LJUisK4tLhu3bpJv2jTY3O5JjBMYORFAEO
 uNLw==
X-Gm-Message-State: AOAM5309NPuThb2F82IWkWUuFA9DH+uO1m+CQYUCEb7eq+/xucJ1IOy5
 y4VMkbaEb9WP1vE6cycsmCc=
X-Google-Smtp-Source: ABdhPJwfdZ/PXDFhrq4cAyBhHFJghu/X0cG9o9sfaN5YiulJ0z9gwcnihfB1Hlbik6LSaZjwjlwqLQ==
X-Received: by 2002:aa7:cb8b:0:b0:410:9aaf:2974 with SMTP id
 r11-20020aa7cb8b000000b004109aaf2974mr28322523edt.173.1651039823936; 
 Tue, 26 Apr 2022 23:10:23 -0700 (PDT)
Received: from [192.168.178.21] (p57b0b9e1.dip0.t-ipconnect.de.
 [87.176.185.225]) by smtp.gmail.com with ESMTPSA id
 c6-20020a50f606000000b00425adbac753sm7698493edn.21.2022.04.26.23.10.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Apr 2022 23:10:22 -0700 (PDT)
Message-ID: <3aaa792d-f229-2f48-2e83-30eaa0ba7153@gmail.com>
Date: Wed, 27 Apr 2022 08:10:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [QUESTION] sdma_v5_2 updates address with an running async dma
 engine
Content-Language: en-US
To: Haohui Mai <ricetons@gmail.com>
References: <CAHpOOhHvr1OkXJ=z9dnm7ES4gXLkWbHzLHqSkipyqCv5HR7Jvg@mail.gmail.com>
 <8c22f321-2080-8ab5-58d0-39bcd79c246d@gmail.com>
 <CAHpOOhFiHWkPbWpqCY4=6tDiVszt2BfeZZWrgm+Ui_pB8LFGDw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAHpOOhFiHWkPbWpqCY4=6tDiVszt2BfeZZWrgm+Ui_pB8LFGDw@mail.gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In general I suggest to unify SRIOV and bare metal handling as much as 
possible.

Regards,
Christian.

Am 27.04.22 um 08:03 schrieb Haohui Mai:
> Great, thanks! I'll work on a patch then.
>
> ~Haohui
>
> On Wed, Apr 27, 2022 at 1:57 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Am 27.04.22 um 03:53 schrieb Haohui Mai:
>>> Hi,
>>>
>>> I'm looking at the initialization sequences in sdma_v5_2.c. I'm
>>> confused on whether the DMA engine should be activated when updating
>>> the MMIO registers. Some clarifications are highly appreciated.
>>>
>>> Here is the background:
>>>    * sdma_v5_2_enable() toggles the HALT bit to enable / disable the
>>> async DMA engine
>>>    * sdma_v5_2_resume() initializes MMIO registers (e.g., queue
>>> addresses) of the DMA engine.
>>>    * sdma_v5_2_start() is called when the kernel initializes the device.
>>>
>>> However, the driver has two paths when updating the MMIO registers,
>>> where the DMA engine is activated / deactivated respectively.
>>>
>>> When amdgpu_sriov_vf(adev) is true:
>>>
>>>      866         if (amdgpu_sriov_vf(adev)) {
>>>      867                 sdma_v5_2_ctx_switch_enable(adev, false);
>>>      868                 sdma_v5_2_enable(adev, false);
>>>      869
>>>      870                 /* set RB registers */
>>>      871                 r = sdma_v5_2_gfx_resume(adev);
>>>      872                 return r;
>>>      873         }
>>>
>>> When amdgpu_sriov_vf(adev) is false:
>>>
>>>      893         sdma_v5_2_enable(adev, true);
>>>      894         /* enable sdma ring preemption */
>>>      895         sdma_v5_2_ctx_switch_enable(adev, true);
>>>      896
>>>      897         /* start the gfx rings and rlc compute queues */
>>>      898         r = sdma_v5_2_gfx_resume(adev);
>>>
>>> Furthermore, sdma_v5_2_gfx_resume() re-enables the already active DMA
>>> engine when amdgpu_sriov_vf(adev) is false:
>>>
>>>      728                         /* unhalt engine */
>>>      729                         temp =
>>> RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
>>>      730                         temp = REG_SET_FIELD(temp,
>>> SDMA0_F32_CNTL, HALT, 0);
>>>      731                         WREG32(sdma_v5_2_get_reg_offset(adev,
>>> i, mmSDMA0_F32_CNTL), temp);
>>>
>>> The behavior seems inconsistent. Looking at the code that re-enables
>>> the engine, it seems that the driver assumes a deactivated DMA engine
>>> during initialization regardless whether the device is in vf mode or
>>> not.
>>>
>>> Just wondering, is the behavior expected or is it a bug?
>> Off hand that sounds like a bug to me. The SRIOV code paths are in
>> general not that well tested since most testing/bringup happens on bare
>> metal.
>>
>> Regards,
>> Christian.
>>
>>> Thanks,
>>> Haohui

