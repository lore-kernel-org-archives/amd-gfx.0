Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D043C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 20:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8376D999DD;
	Wed, 13 Jul 2022 20:43:02 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04E6599AED
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 20:42:34 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id os14so21940654ejb.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 13:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qj46Expkx0Fdl04B5r2M/IKERzYmwL8GKHgYErVEHPU=;
 b=JHjdAbofUWwRVhvgVOiZ0qRn5y1paVSqD7wjLfExQOlWpAYCzmmWAhpXfp4DH25Pdr
 S/tTZ8eXCpU0d90H66vv6uX6XEeZwDh9ex84anB39Nz7x206N5/LYRYEGJ0Zj7Tqooc1
 T51wu8yoaY7wBIa8QoqJgSeDtn7JAEV6eEmjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qj46Expkx0Fdl04B5r2M/IKERzYmwL8GKHgYErVEHPU=;
 b=CGwbCG6zjQEG5xOBPxDah7t8321imZPHJJssbmTcZBTi/geDkHlXLkkb9kmO17eUsw
 dq7+KdaPw6Spsnz3QlSD7ZvzEfxVZ/ggM2nocUgdYEQ9I8oyf3nfpoDRRyoCqAIqj+dl
 R5lSSfKeJSCDjD1BybQ4mvgOC+m8pexTVHmfjjPhEkGopc2l6f3HpY7bzrefHrSKSPjk
 Dzb0fA822JPaA2hK42uqK793y9RQNemSurT6N49n9H+b1i0ckTw7PaYZ81whY2fik/99
 rBMbB+ar/CzCAr/eU89gyAZZBKuM20FeO8/QiINj9t799UBvHTVKc1+hXPtltZt1eEkL
 O1oQ==
X-Gm-Message-State: AJIora8P/SasyUN8+dsvSdYpNAEJAzjEQ1MfuopNZLC157vTqM2Y3KF4
 2b89dCGOSVXMPqUFJvpcOgf5lSjAmS07KIbkYyk=
X-Google-Smtp-Source: AGRyM1uJPF25U1w6+jHC/HsaueEucnJkTyCqgHRcgXUwJO85dE+Gn8xuN8ZIKDflngXbo2/b8/24mw==
X-Received: by 2002:a17:906:ef90:b0:72b:9ce5:f016 with SMTP id
 ze16-20020a170906ef9000b0072b9ce5f016mr4502111ejb.697.1657744953167; 
 Wed, 13 Jul 2022 13:42:33 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com.
 [209.85.221.41]) by smtp.gmail.com with ESMTPSA id
 ch15-20020a0564021bcf00b0043a71c376a2sm8550642edb.33.2022.07.13.13.42.32
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jul 2022 13:42:32 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id z12so17116916wrq.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 13:42:32 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id
 f8-20020a0560001a8800b0021daa97cb16mr5060151wry.97.1657744951699; Wed, 13 Jul
 2022 13:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
 <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
 <e63e108b-c99c-9ab7-0638-367b72983b81@roeck-us.net>
In-Reply-To: <e63e108b-c99c-9ab7-0638-367b72983b81@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Jul 2022 13:42:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-SE=s+bJq_jwuQ6zfnifaAwYdXikpXo8iZ4JbbNph4Q@mail.gmail.com>
Message-ID: <CAHk-=wh-SE=s+bJq_jwuQ6zfnifaAwYdXikpXo8iZ4JbbNph4Q@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 13 Jul 2022 20:43:01 +0000
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
 "Russell King \(Oracle\)" <linux@armlinux.org.uk>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@ozlabs.org>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Daniel Axtens <dja@axtens.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 13, 2022 at 1:40 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> That patch is (and has been) in linux-next for a long time,
> as commit d2ca1fd2bc70, and with the following tags.
>
>      Fixes: 7719a68b2fa4 ("ARM: 9192/1: amba: fix memory leak in amba_device_try_add()")
>      Reported-by: Guenter Roeck <linux@roeck-us.net>
>      Tested-by: Guenter Roeck <linux@roeck-us.net>
>      Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>      Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>
> So, yes, it fixes the problem. I don't know where it is pulled from, though.
> I thought that it is from Russell's tree, given his Signed-off-by:,
> but I never really checked.

Heh. Yeah, with that sign-off, I bet it's in Russell's queue, bit it
just ended up in the "for next release" branch. Russell?

                 Linus
