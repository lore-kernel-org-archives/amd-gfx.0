Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D03C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 20:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C037199BE2;
	Wed, 13 Jul 2022 20:46:31 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B9E799B38
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 20:45:32 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 y14-20020a17090a644e00b001ef775f7118so5711976pjm.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 13:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=hj56zl8YkRtwkNBCOxHuxz3t0X0zHpjNDxMLhJ735rc=;
 b=YucXUkB7+XDbsZA6npj7CpMa32EHucJ7YcQ0989VM2knFEXYCiEdwIL0xXsxltWSay
 FiFsZlkNlGKsCZJMWRpXw4Zu2b6m+iEuJx6LQ6KBJ7h9joXLYlVylYNKlUlE2+yjpJ5e
 7up0vENQBTIYlY+WBp31eP8Hl51NdCfbH2TqDQOuwcEfdkuBSdk8cUbLmvz9F/XJv363
 Mjx9tkRQfkmflKHDBaQDPtHWXHpIGMh/o1OWg98SPmBNQvzFtXaqpASXlMchWQ+MDF0T
 NabQslNJiokAebaO/QXEDhcnwEtHaKiyvhVTC8Dn/4w1TMDqW6KzmQpB84Xw3DEv+XzH
 X8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
 :subject:content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=hj56zl8YkRtwkNBCOxHuxz3t0X0zHpjNDxMLhJ735rc=;
 b=VMuXz5JyYnXC6VK8iP7ke5ztRGqdEZzd1yqKzBIydOA+pvjXuquyTeUs16/qrUQSaW
 ILI2C0Hx6uwMEipqfweK7MWBMKIapX4gr/Cffsihe2+JewWYkMckZKIllef9TroychF2
 UkyElNlI+wO9/GIadES+ij4f2S0yZP9gA/lw8o3/jzzzswbc26wFfjfOAXbEZikEJUrL
 wis/5IG/hCyMdYO/uOXc4WrPPEzkOVkAQl1MY8A4a62oNpQ1kNkpKqlgHvPuKIIirKpQ
 4CzYhRr8Ef6UAq6rvcduZICt/V2zKOABFzdMB5GPZMI9DY2tbTFnEhZBGAcW38r6dFX4
 AMrQ==
X-Gm-Message-State: AJIora9L1/6w/nFYrPrC0v9PR/E7R2aDP6VCw3XMDTHh4Ai0cMwRvdIf
 PXf1Zvi9IIRZLc01kM6pUJ8=
X-Google-Smtp-Source: AGRyM1tk2dgCcN+hf4ypP8CNcErOz5P28HKcTVVtP6C8XYDSU88TKy/IC0YT5iM2VQuAZoyZDVdmwg==
X-Received: by 2002:a17:902:c947:b0:16c:1c97:16ec with SMTP id
 i7-20020a170902c94700b0016c1c9716ecmr4726986pla.7.1657745131775; 
 Wed, 13 Jul 2022 13:45:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 s5-20020a170902ea0500b0016a058b7547sm9402419plg.294.2022.07.13.13.45.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jul 2022 13:45:30 -0700 (PDT)
Message-ID: <d4b80a85-c77b-7568-dc4c-df64fbf9afa4@roeck-us.net>
Date: Wed, 13 Jul 2022 13:45:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Linux 5.19-rc6
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Alex Deucher <alexdeucher@gmail.com>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <CADnq5_Ma2oe-6+WG4ZRAm97G7TyS0Nuhdxt=7oqdNLcMP5nKeg@mail.gmail.com>
 <CAHk-=wgW-g5jAMmKjnG0_mhqtEKzbKxs=Lo8DDv1D2wZvhL-8Q@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAHk-=wgW-g5jAMmKjnG0_mhqtEKzbKxs=Lo8DDv1D2wZvhL-8Q@mail.gmail.com>
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
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Leo Li <sunpeng.li@amd.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Balbir Singh <bsingharora@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Paul Mackerras <paulus@ozlabs.org>,
 "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Daniel Axtens <dja@axtens.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/13/22 13:22, Linus Torvalds wrote:
> On Wed, Jul 13, 2022 at 12:53 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> Does this patch fix it?
>> https://patchwork.freedesktop.org/patch/493799/
> 
> Guenter? Willing to check this one too for your setup, and we can
> hopefully close down both issues?
> 

No, that fixes a different problem (I tried). We (Google) are trying to run
tests with KCOV enabled images on AMD hardware which requires the new display
engine, and we need that patch to enable it. That is unrelated to the PPC
build problem.

Guenter
