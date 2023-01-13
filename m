Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB45C54EBD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 15:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 127B910EA10;
	Fri, 13 Jan 2023 15:02:25 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E4D410EA10
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 15:02:24 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id cf18so46579149ejb.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 07:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bhz5vXzbxv2+ka9buAzRHyvZeXMKtONHqAc8AjLdJFM=;
 b=FTOf/MRXikCM4AZ9T8J+FXRgrNkEpkOMfwVS8oduacTeBywUQD2jY7MNZVCSO3IW/c
 wKjPcPKDIx39Ab0kUzaM9AjoMdUt37c2PsDfUW7r4M/n57iwsmQ5haOur09VjZGKRMvL
 mz/Hx0P/JMSVEAIbbBjFMVKIj8urg8jRgnmN7suIvUFlRoCu0Va9MH7h8cNSCNK7hOBO
 V3NUbOc1SDBPZ/SHHpRai28kUsAJu7fBw+xWCmzW2QDVqA/WeIfjrt2Z+6aMhBIf3OSY
 b3NfaEmSzgl3cURTzWrOFAIyq0K5CgxeqQmvM8WphFKt4vjqnVO/pZ7sMcBbtKWqSWqY
 bVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bhz5vXzbxv2+ka9buAzRHyvZeXMKtONHqAc8AjLdJFM=;
 b=RurFQqTABgd6tU6Ga5kCJ5vwFINRqf+uY+ezXYROR9AUfP0qTB19RSG8+buoedM90I
 HGKo8WJQuWE08RhHk9+6T1U6Cb29AjBxguRU9aWmHSSFz0Tj2q87H0PPsaAuBsb2kaZ8
 jh/JjLQ6f4A7kTNmzwXl6ifoq9u9el0Z12SGnUKLoakB6t8DDxw0y4BRxJX6pCaeNvd3
 pdYw0TJkv8mJ75B+nzVzRvkJWJP9CSuHPukdam3xKK+ZhqFOHnlYcfFrs+XesL/kWmFZ
 vO6sQY8Kx7k5bWkBQQ+oNdgFrP/Zdz2oJMo1rq2O5CrFeWb9ywuZ+cDZJNrj/QSI+vRU
 u+CQ==
X-Gm-Message-State: AFqh2krzXsV/jKOCERHQ4xysUmMh5dbr46gNfIjemTiUJ+/rjHal8Pz/
 3MdqQs0Qu9dWRpu9RUhje5myE4EEDo0=
X-Google-Smtp-Source: AMrXdXuxw6PnMvmcKfdqredMNjLcCMAoICEHVe5wlgX83t8XN21XZltoJfL2fs/a5kf00viXjBa0fw==
X-Received: by 2002:a17:907:c70b:b0:7c0:e535:13fd with SMTP id
 ty11-20020a170907c70b00b007c0e53513fdmr72630241ejc.70.1673622142517; 
 Fri, 13 Jan 2023 07:02:22 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:9fe7:7ab3:383d:1efb?
 ([2a02:908:1256:79a0:9fe7:7ab3:383d:1efb])
 by smtp.gmail.com with ESMTPSA id
 w23-20020a1709062f9700b0084d3bf44996sm7136293eji.142.2023.01.13.07.02.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Jan 2023 07:02:21 -0800 (PST)
Message-ID: <b00f9dc7-695e-bf7b-5828-efa00d56c3d7@gmail.com>
Date: Fri, 13 Jan 2023 16:02:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Is "perfectly equal monitors" really required to reclock MCLK
Content-Language: en-US
To: Braiam <braiamp@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <CAG=7Bt9ivGs8rtZx3rzZj_uoTzeGwnYRYQ6ohfpxVFMNV3YtOw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAG=7Bt9ivGs8rtZx3rzZj_uoTzeGwnYRYQ6ohfpxVFMNV3YtOw@mail.gmail.com>
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

Am 13.01.23 um 11:35 schrieb Braiam:
> Hi,
>
> I have two monitors with the current following configuration:
>
> Screen 0: minimum 320 x 200, current 5120 x 1440, maximum 16384 x 16384
> DisplayPort-0 connected primary 2560x1440+0+0 (normal left inverted
> right x axis y axis) 597mm x 336mm
>     2560x1440    164.83 +  59.95 + 120.05*   96.01    72.01    60.01
> 143.97   120.00    74.97
> [snip]
> DisplayPort-1 connected 2560x1440+2560+0 (normal left inverted right x
> axis y axis) 597mm x 336mm
>     2560x1440    165.00 +  59.95 + 120.06*   96.04    72.01    60.01
> 50.01    48.01   144.00   119.99    99.99
> [snip]
> HDMI-A-0 disconnected (normal left inverted right x axis y axis)
> HDMI-A-1 disconnected (normal left inverted right x axis y axis)
> DVI-D-0 disconnected (normal left inverted right x axis y axis)
>
> The pp_profile_mode:
>
> NUM        MODE_NAME     SCLK_UP_HYST   SCLK_DOWN_HYST
> SCLK_ACTIVE_LEVEL     MCLK_UP_HYST   MCLK_DOWN_HYST MCLK_ACTIVE_LEVEL
>    0   BOOTUP_DEFAULT:        -                -                -
>           -                -                -
>    1 3D_FULL_SCREEN *:        0              100               30
>          10               60               25
>    2     POWER_SAVING:       10                0               30
>           -                -                -
>    3            VIDEO:        -                -                -
>          10               16               31
>    4               VR:        0               11               50
>           0              100               10
>    5          COMPUTE:        0                5               30
>           -                -                -
>    6           CUSTOM:        -                -                -
>           -                -                -
>
> I have set their refresh rate to 72.01 which is a mode equal for both,
> and the MCLK wasn't downclocked either. They are branded HP and
> Scepter. Using a vtty doesn't help either.
>
> Is having the exact same monitor really required? If not, how can I
> check what is causing
> the memory clock to be pegged that high?

First of all you need a minimum MCLK to support scanout for two 
monitors, so even if you have two identical monitors your minimum MCLK 
is higher.

Then for MCLK switching in the VBLANK period the two monitors must run 
in sync with each other, e.g. using the same PLL source and having the 
VBLANK at the same time.

For this not only the refresh rate, resolution and pixel clock needs to 
be the same, but also all the other timing parameters must match exactly.

Could be that you can run both monitors with the same mode, but that 
they have that by coincident is rather unlikely if they are not identical.

Regards,
Christian.

>
> I'm using 6.0.0-6-amd64 from Debian testing.
>

