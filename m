Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B949C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 18:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4670610F87B;
	Thu, 14 Jul 2022 18:54:58 +0000 (UTC)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3E3D10E34E
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 17:24:25 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 z12-20020a17090a7b8c00b001ef84000b8bso9268513pjc.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 10:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:message-id:date:mime-version:user-agent:content-language:to
 :cc:references:from:subject:in-reply-to:content-transfer-encoding;
 bh=Gbjcd2IgrO6L9fc9+WkTPZv76RZzps8wedDsg5wGKeY=;
 b=CCb+r6CxQcpbkaIIPO2+OFKrJm34bemuloqAiWccmWzW0dxE0dhcDaVN86XyANf2cf
 kv8i80/zkbjcsK8DcFaJO8ls4IkCCHuyokBkwaZWpQ53mnTleKA3g+pH05/wxT182Hdf
 ec0rhNnhkAEJa9wgmReQTy2uZknsTV3T16Wje1MtaxZ6TjIzeLIcKBVA4Q2ULKAlgO/S
 4MVc4nKI1aMgWpQrzmygW997CXLU2ouWUG4R41wrQS4oZUlf51zyRL+Z1U1nLE2tJN9c
 ycjfL/lSIvmuKM3wP+FzpuT5bA6CfjfykUgHHvASyTFEkMSZQvp9PLTL+FR5DXg6tlpO
 qBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:subject:in-reply-to
 :content-transfer-encoding;
 bh=Gbjcd2IgrO6L9fc9+WkTPZv76RZzps8wedDsg5wGKeY=;
 b=OzRtCg6StXD7+jeYRC462pbOaJqDdsztJQuY4uFeySPRaknx/aNLd9gdxr+WXDvk/I
 IY+8nm165A+hzT0GX3BetBFEUsShrvc2PvO8vd0FcOmJnuD1zCOFrpNiPi9eCQKLSvHA
 2yQGuQZpnGPA4y7ntoGvNeU0fvE0Adx4avht95DRjmK/PA8EfDpONVhJZmp2bI9Q35Km
 z/WkdhWNvf+jglJ3q28jVAeKJDBYabeLH7zUWhOC3nNQVzWOKOzcpUJHUQ1gsVS6qEot
 uLpxn1IVtax6aBtZjtA/uBJ+EFlL+om/aDovdGacYycRjvYy6MT28af9VZkxEmv6LL3S
 +wxQ==
X-Gm-Message-State: AJIora+7HmILeHGi+7FqssysCxzwSw0c8kv8X2kp0XMm64BhZAATRIlZ
 Dg1oASldYUiOcD1MTpHL24E=
X-Google-Smtp-Source: AGRyM1tMVmyK0B4PbANNEWw/DijnhfMre9NNZlC+bo9z31UxrNhAtoLWLzQrgiPEMW7DwZqkyO6HDg==
X-Received: by 2002:a17:902:7209:b0:16b:fa09:5d6 with SMTP id
 ba9-20020a170902720900b0016bfa0905d6mr9325521plb.120.1657819465381; 
 Thu, 14 Jul 2022 10:24:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a17090a160800b001ef869aa755sm3909452pja.15.2022.07.14.10.24.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Jul 2022 10:24:24 -0700 (PDT)
Message-ID: <6d5ac61b-b490-4f9d-6521-a4b7477d6fd2@roeck-us.net>
Date: Thu, 14 Jul 2022 10:24:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
 <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
 <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
 <CAMuHMdV9Pj9V-ZPpu=BMSkPt1uA_eCvU4+bxF8ZfHjteRk2CAg@mail.gmail.com>
 <CAHk-=wgnmaTVigBc02tjqgcZaNJiYz8Xw77P+ERAXhcYjkwd=Q@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 5.19-rc6
In-Reply-To: <CAHk-=wgnmaTVigBc02tjqgcZaNJiYz8Xw77P+ERAXhcYjkwd=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 14 Jul 2022 18:54:56 +0000
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

On 7/14/22 09:48, Linus Torvalds wrote:
> On Thu, Jul 14, 2022 at 12:23 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>>
>> Oh, it's not just this one. The lists of build regressions between v5.18
>> and v5.19-rc1 [1] resp. v5.19-rc6 [2] look surprisingly similar :-(
>>
>> [1] https://lore.kernel.org/all/20220606082201.2792145-1-geert@linux-m68k.org
>> [2] https://lore.kernel.org/all/20220711064425.3084093-1-geert@linux-m68k.org
> 
> Hmm.
> 
> Some of them are because UM ends up defining and exposing helper
> functions like "to_phys()", which it just shouldn't do. Very generic
> name - so when some driver ends up using the same name, you get those
> errors.

We can't use virt_to_phys() and phys_to_virt() because they are defined for
the underlying architecture. Would uml_to_phys() and uml_to_virt() be
acceptable ? If so, I'll submit a patch.

> 
> And some look positively strange. Like that
> 
>    drivers/mfd/asic3.c: error: unused variable 'asic'
> [-Werror=unused-variable]:  => 941:23
> 
> which is clearly used three lines later by
> 
>          iounmap(asic->tmio_cnf);
> 
> and I can't find any case of 'iounmap()' having been defined to an
> empty macro or anything like that to explain it. The error in
> drivers/tty/serial/sh-sci.c looks to be exactly the same issue, just
> with ioremap() instead of iounmap().
> 
> It would be good to have some way to find which build/architecture it
> is, because right now it just looks bogus.
> 
> Do you perhaps use some broken compiler that complains when the empty
> inline functions don't use their arguments? Because that's what those
> ioremap/iounmap() ones look like to me, but there might be some
> magical architecture / config that has issues that aren't obvious.
> 
> IOW, I'd love to get those fixed, but I would also want a little bit more info.
> 
Geert gave the necessary hint - it looks like sh-nommu used defines
for iomap() and iounmap(), which made the variable unused. According
to Geert that was fixed a couple of days ago.

Guenter
