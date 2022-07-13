Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484C3C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 20:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9A7199BC9;
	Wed, 13 Jul 2022 20:46:31 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D19499BC9
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 20:46:19 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id e16so1138pfm.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 13:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:message-id:date:mime-version:user-agent:content-language:to
 :cc:references:from:subject:in-reply-to:content-transfer-encoding;
 bh=tIHGf4VW/fEwq1AvVsdPyI+0X2e9Ro/7w+8ubGt0XGE=;
 b=j2W7lWqTya69RXYlcCaYeipeFckSMlpZ9ipyhy+uWLZ/3bmkXmSAB5Dh20tJu+ZdGp
 A/pkDtVvYDU0N5C+i7Q29P58If1WjlNhsEr32JwzvYtAd3oLzBEukuUhdrWYRhkbdDlG
 VROAJ2Or7X2i2lsfMMXUcuzsgzCqX4z71UUvFicXdRevXw6MFMeYtKqsUDI+wTTNwR/k
 i2dc4NGZsgyPczNJvya91wm6LY+ulpOV9frcCOtRo2lvYUYSJu+UUEm6q7NjUCDjIi0F
 +6WU9XHcQZ03YMKmgfUYUxPGRPZ4qtZ+hOIpxbotPHLdf/rH7R6ni4iyBiQZaI4a9jsq
 KDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:subject:in-reply-to
 :content-transfer-encoding;
 bh=tIHGf4VW/fEwq1AvVsdPyI+0X2e9Ro/7w+8ubGt0XGE=;
 b=SefojUmjZ9tJguhyFGgTRHLKPPkJnCgC7xEIWqcvt2YoUBbzSgQfXwpRSVDWXuYjwI
 RYIYWN4GGpLnDlIJkshvoS41MCHpIpcZ9euVWYEZ7ZEh4Bo0lA0wSHei7X9k6C1dzuq3
 vkJrTGDlT2ht4UNhQTpg10EyvWJVeRmB1hg1DCwBw7zR4pQxgTdjKgJUs6kGjFIlItDG
 jG/hbStAJtvSWiy8U8mwxTMrFDMjfbrbSzWS7SGL4FIjNA56lwHUtmISIJuX1iJsu5d/
 zqYc4/1mX6TxCd/jb6odwoHqMrN1BT0kT0zl2nrYqT1EVw0FpwgO9b+bQdayb81pqd9/
 5x7w==
X-Gm-Message-State: AJIora8eAvkgpuFbOhjwE00UPScIjIjTZL81If8PC2Bj8c4ZeW/W2mBN
 ykh+Cd9BQnURIkqeGf65Lpg=
X-Google-Smtp-Source: AGRyM1vS7zvXK/oILf0Xl/3i10B0jjfIBbeBlp28QNm71y+ud7LNyLdNrwNmzh9EkBb8+Pm6R4NJCw==
X-Received: by 2002:a63:8441:0:b0:415:d595:a7d6 with SMTP id
 k62-20020a638441000000b00415d595a7d6mr4327558pgd.441.1657745179232; 
 Wed, 13 Jul 2022 13:46:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 y11-20020a62ce0b000000b0051b32c2a5a7sm9202756pfg.138.2022.07.13.13.46.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jul 2022 13:46:18 -0700 (PDT)
Message-ID: <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
Date: Wed, 13 Jul 2022 13:46:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Balbir Singh <bsingharora@gmail.com>, Daniel Axtens <dja@axtens.net>,
 Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 5.19-rc6
In-Reply-To: <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 13 Jul 2022 20:46:30 +0000
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/13/22 12:36, Linus Torvalds wrote:
> On Tue, Jul 12, 2022 at 10:07 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Same problems as every week.
>>
>> Building powerpc:allmodconfig ... failed
> 
> Ok, this has been going on since -rc1, which is much too long.
> 
>>From your patch submission that that was rejected:
> 
>> The problem was introduced with commit 41b7a347bf14 ("powerpc: Book3S
>> 64-bit outline-only KASAN support") which adds support for KASAN. This
>> commit in turn enables DRM_AMD_DC_DCN because KCOV_INSTRUMENT_ALL and
>> KCOV_ENABLE_COMPARISONS are no longer enabled. As result, new files are
>> compiled which lack the selection of hard-float.
> 
> And considering that neither the ppc people nor the drm people seem
> interested in fixing this, and it doesn't revert cleanly I think the
> sane solution seems to be to just remove PPC64 support for DRM_AMD_DC
> entirely.
> 
> IOW, does something like this (obviously nor a proper patch, but you
> get the idea) fix the ppc build for you?
> 
>    @@ -6,7 +6,7 @@ config DRM_AMD_DC
>            bool "AMD DC - Enable new display engine"
>            default y
>            select SND_HDA_COMPONENT if SND_HDA_CORE
>    -       select DRM_AMD_DC_DCN if (X86 || PPC64) &&
> !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
>    +       select DRM_AMD_DC_DCN if X86 && !(KCOV_INSTRUMENT_ALL &&
> KCOV_ENABLE_COMPARISONS)
>            help
>              Choose this option if you want to use the new display engine
>              support for AMDGPU. This adds required support for Vega and
> 

It does, but I can't imagine that the drm or ppc people would be happy
about it.

Guenter
