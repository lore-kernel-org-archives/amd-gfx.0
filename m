Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2669C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 13:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75AF410FBC7;
	Thu, 14 Jul 2022 13:23:53 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AF0D10F8BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 13:20:39 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id b8so2833883pjo.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 06:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:message-id:date:mime-version:user-agent:content-language:to
 :cc:references:from:subject:in-reply-to:content-transfer-encoding;
 bh=9PvTbOQp4n28wbO5UWAbp8/0QyOUUqCrsa8uBKcvtAQ=;
 b=QWUAAzr26QjP2JPSKabdts+BUza12kAxvwW3taUje2cLVmjdSW0KgliwhAGd3ieYpS
 Y5jBon5kWw8lbyVB2ooFMUAKSJCmjxe6kV3LdUlhs/GiwSyPbqPAT/wh1QvVVhrmZXgm
 FC0PvfUGlFzx6fZGRsjBDR+iieAhYv4o2CDGONCKASbJiQRgSeEAEruhBDghGBJc2qSh
 WNxaoddoeQXfm6N1sqvuSED1pbP8Rg7Ud7MSzhLdbhOgvk2jf+JUlNKiywzv1SLk5Cy6
 4jBebTRTUciM//hkLCMqmMbaGK4th6ajF3/+bXxG4Hbe3uydE0rjCBptazINQg/zBqBW
 U2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:subject:in-reply-to
 :content-transfer-encoding;
 bh=9PvTbOQp4n28wbO5UWAbp8/0QyOUUqCrsa8uBKcvtAQ=;
 b=SUBs6JVp+eX4munO6SH1e5Z1IenVoSFQ72h7D+e+mrCQF4zF9dqfx7AybKYhNbyviO
 SGToulNZeDtLlJCENJn8jJBKhHogbQBvNbjKFUqCzTERUKAPQai0fL6qXfr8RnWxUQI0
 5ib7zONoLEd8Q3BFSSOnYzDvbql6Nk/jmgy/WXF9+ApEpDfFev9qQAmAFMqjoSUy7e3F
 PP5OKNGCKUIatMktrGvprKxMy0k+zRkY+GSTDcm0BgxqN3gqAp0asy24f4lgi4zzjtEH
 SN6vIxv2OXt1HKgtPgy1K7d8HGrA7vd2IGNsUP+tcjWoF+sA42qM5RKyA1FVK+A8tfL+
 lfFg==
X-Gm-Message-State: AJIora8MN7J1xs8ZPl+sz2bI40KxEgE3kVxgeQYJhbAbxcBfm2NK1tEG
 vEgpET7ZjwdTrZrqX+xL5SM=
X-Google-Smtp-Source: AGRyM1vb0HH7038vVBg8ZPsgGUNBtQC2ygxC+R2UazdBAz/qMT1uekVP93JtAXiidBih+3sNVzCqIg==
X-Received: by 2002:a17:90a:e611:b0:1ef:92b6:d31 with SMTP id
 j17-20020a17090ae61100b001ef92b60d31mr16029353pjy.166.1657804839084; 
 Thu, 14 Jul 2022 06:20:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a622506000000b0052b2bf4cc42sm514506pfl.111.2022.07.14.06.20.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Jul 2022 06:20:37 -0700 (PDT)
Message-ID: <2cac3590-3e9c-bdf3-4211-8559e581d44d@roeck-us.net>
Date: Thu, 14 Jul 2022 06:20:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
 <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
 <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
 <CAMuHMdV9Pj9V-ZPpu=BMSkPt1uA_eCvU4+bxF8ZfHjteRk2CAg@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 5.19-rc6
In-Reply-To: <CAMuHMdV9Pj9V-ZPpu=BMSkPt1uA_eCvU4+bxF8ZfHjteRk2CAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 14 Jul 2022 13:23:52 +0000
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
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Leo Li <sunpeng.li@amd.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Balbir Singh <bsingharora@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Paul Mackerras <paulus@ozlabs.org>, Alex Deucher <alexander.deucher@amd.com>,
 "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>,
 Alex Deucher <alexdeucher@gmail.com>, Harry Wentland <harry.wentland@amd.com>,
 Daniel Axtens <dja@axtens.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/14/22 00:23, Geert Uytterhoeven wrote:
> Hi Linus,
> 
> On Wed, Jul 13, 2022 at 11:51 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Wed, Jul 13, 2022 at 2:01 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>> If you want to apply Guenter's patch original patch:
>>> https://patchwork.freedesktop.org/patch/490184/
>>> That's fine with me.
>>
>> Honestly, by this time I feel that it's too little, too late.
> 
> [...]
> 
>> So considering that the ppc people ignored this whole issue since the
>> merge window, I think it's entirely unreasonable to then apply a
>> ppc-specific patch for this at this time, when people literally asked
>> "why is this needed", and there was no reply from the powerpc side.
> 
> Oh, it's not just this one. The lists of build regressions between v5.18
> and v5.19-rc1 [1] resp. v5.19-rc6 [2] look surprisingly similar :-(
> 
> [1] https://lore.kernel.org/all/20220606082201.2792145-1-geert@linux-m68k.org
> [2] https://lore.kernel.org/all/20220711064425.3084093-1-geert@linux-m68k.org
> 

How do you build your images ? I don't see many of the problems you report,
even if I build the files with W=1. It is odd, since reports such as

drivers/mfd/asic3.c:941:23: error: unused variable 'asic'

are real, but I just don't see that. If I build that file, I see that
it builds with -Wno-unused-but-set-variable, due to

Makefile:KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)

The override in scripts/Makefile.extrawarn doesn't seem to work even though
it adds "-Wunused-but-set-variable" to the compile flags. And if I remove
"-Wno-unused-but-set-variable" from Makefile I still don't get the error/warning.
Confused. I must be missing something, but what ?

Thanks,
Guenter
