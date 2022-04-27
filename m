Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01387C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 05:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A45D10F868;
	Wed, 27 Apr 2022 05:57:11 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B28110F69F
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 05:57:10 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id k27so703949edk.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 22:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=VGv89n+3B9KwwJ5zjZaM9oIa30mfDPNqbxoqSmMOQZE=;
 b=Q3H08rhOr1PgbsEvfvo6tWueTCE3YmNtQf856LLcKRng59MyA/Xk4QdE3JMqxklx87
 v6c+szZYDItD6hdWKZYA5/tNXN0qKoSs7jp4M1T72WEj6wJST4d4gdTjnNBTixyFMKft
 Isy2x3cciJi7zxS7dM8sHUbtRXmZGLtlXyTWnmPgLMiSp5PNFabK5Tyo/bvyhlaHzqVt
 Djqv/UPTPZf8x1Pjg70zon6Q4H52w7XiFzw8hMR56PjZbPTxZkf2vkGU82Cz9QEGKHjU
 Ph2RdrAUsrcR+Raw47EHfxaQsb5gn7IlrVowZA8oo+/cxaBEFYEFBlO4QnH3sWTUPdiu
 vK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=VGv89n+3B9KwwJ5zjZaM9oIa30mfDPNqbxoqSmMOQZE=;
 b=f8fH0ZhGPMPl6iznJHgppz81dwok0ezg96Odt4GaepU5kQHL5aRpc5OED8WW+Sysc1
 i75LYkfHLbdvQsfQ0YFwnkwUaBmAH50eFirJiMhMi5+9YzfynKZVHqr8vAB3py0n5eCz
 wAn+7etIxUp73+G3T3swz6RmZz0wN3nFyebQeeaZT8vhd4KwtBjwBGJIJQMmu9gwPbY6
 H5LQQBQqWS2tDr2YhqHRdr8EFZs+6Cet/5olAAproB8+EPGAb0ABQW4jmAyvV9uwOFwO
 JKbWvAgeIgnBaE15c/+GyusLel7eUPPopVwBI7pw29od/iUym94ZKuL/nNvS/gmlGGu7
 gzrw==
X-Gm-Message-State: AOAM533weRmx05G1SooYj75AEStdvsiw45fobzQqXT3OLgJFwp1CwrbN
 6uQAPxTZPVvXDnKFM0IaUg8=
X-Google-Smtp-Source: ABdhPJwNhriaG9pFgf8QPJlIDI/oyYZ+ShQFujnmqJKjs639YuRstDHL8CpOF+e6q/WACUChCCP/nQ==
X-Received: by 2002:a05:6402:c9c:b0:425:d5e0:b69 with SMTP id
 cm28-20020a0564020c9c00b00425d5e00b69mr19979475edb.271.1651039028633; 
 Tue, 26 Apr 2022 22:57:08 -0700 (PDT)
Received: from [192.168.178.21] (p57b0b9e1.dip0.t-ipconnect.de.
 [87.176.185.225]) by smtp.gmail.com with ESMTPSA id
 z1-20020a170906434100b006e7efa329fbsm6083283ejm.109.2022.04.26.22.57.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Apr 2022 22:57:07 -0700 (PDT)
Message-ID: <8c22f321-2080-8ab5-58d0-39bcd79c246d@gmail.com>
Date: Wed, 27 Apr 2022 07:57:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [QUESTION] sdma_v5_2 updates address with an running async dma
 engine
Content-Language: en-US
To: Haohui Mai <ricetons@gmail.com>, amd-gfx@lists.freedesktop.org
References: <CAHpOOhHvr1OkXJ=z9dnm7ES4gXLkWbHzLHqSkipyqCv5HR7Jvg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAHpOOhHvr1OkXJ=z9dnm7ES4gXLkWbHzLHqSkipyqCv5HR7Jvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 27.04.22 um 03:53 schrieb Haohui Mai:
> Hi,
>
> I'm looking at the initialization sequences in sdma_v5_2.c. I'm
> confused on whether the DMA engine should be activated when updating
> the MMIO registers. Some clarifications are highly appreciated.
>
> Here is the background:
>   * sdma_v5_2_enable() toggles the HALT bit to enable / disable the
> async DMA engine
>   * sdma_v5_2_resume() initializes MMIO registers (e.g., queue
> addresses) of the DMA engine.
>   * sdma_v5_2_start() is called when the kernel initializes the device.
>
> However, the driver has two paths when updating the MMIO registers,
> where the DMA engine is activated / deactivated respectively.
>
> When amdgpu_sriov_vf(adev) is true:
>
>     866         if (amdgpu_sriov_vf(adev)) {
>     867                 sdma_v5_2_ctx_switch_enable(adev, false);
>     868                 sdma_v5_2_enable(adev, false);
>     869
>     870                 /* set RB registers */
>     871                 r = sdma_v5_2_gfx_resume(adev);
>     872                 return r;
>     873         }
>
> When amdgpu_sriov_vf(adev) is false:
>
>     893         sdma_v5_2_enable(adev, true);
>     894         /* enable sdma ring preemption */
>     895         sdma_v5_2_ctx_switch_enable(adev, true);
>     896
>     897         /* start the gfx rings and rlc compute queues */
>     898         r = sdma_v5_2_gfx_resume(adev);
>
> Furthermore, sdma_v5_2_gfx_resume() re-enables the already active DMA
> engine when amdgpu_sriov_vf(adev) is false:
>
>     728                         /* unhalt engine */
>     729                         temp =
> RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
>     730                         temp = REG_SET_FIELD(temp,
> SDMA0_F32_CNTL, HALT, 0);
>     731                         WREG32(sdma_v5_2_get_reg_offset(adev,
> i, mmSDMA0_F32_CNTL), temp);
>
> The behavior seems inconsistent. Looking at the code that re-enables
> the engine, it seems that the driver assumes a deactivated DMA engine
> during initialization regardless whether the device is in vf mode or
> not.
>
> Just wondering, is the behavior expected or is it a bug?

Off hand that sounds like a bug to me. The SRIOV code paths are in 
general not that well tested since most testing/bringup happens on bare 
metal.

Regards,
Christian.

>
> Thanks,
> Haohui

