Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FE7C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 20:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAE5F10FCB2;
	Wed, 13 Jul 2022 20:58:37 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E33A799CED
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 20:50:20 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id t3so15382733edd.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 13:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ahgWcY0Qhtt2gptPxS6Knb/YUD/M/kyPSyAouT+Dg5Q=;
 b=eWyzJ3DkQPO8/Ucp2ZtR+aYlDD2nT9ApRtgzzfquSIYkokAIYRl2vW5b6bt/Xwhfra
 YQI4Qfok3pGM9xg+494aKlrf4c/au02ChfkaI2ab6CUK47+sfbQuj+0F8SkDyDqEUYxc
 kEmSkZbf4Ya4CAZSLIIzXiikXy/Wr2/bBFVmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ahgWcY0Qhtt2gptPxS6Knb/YUD/M/kyPSyAouT+Dg5Q=;
 b=jdagMRfDwr7DPxvvET5jts98BrP1MNVqztaSaKdLunx274Z43zWjBO6M2/FmqC/FYJ
 /lARiwBobzFXGZ955ok4jvDJcmsIgP/mq5BmzN6sYf2CWllJZaF8SkWstgVpACDAZQDO
 7jVZAEKJmzEm68JZ2mirp2g/766p0Z2iPt79xTj0Pw0ZUQ9y0k3hRZDAPMnknW5I74zK
 c7yRyfG85yoUh6hd9MQ7VT4Z0s4CH1YIDi1ysTHahF9hPMn/p3UsyE3jlAcu3zk+XJWr
 4pWeJMkj2vagCVRFHG9LJjEQQfthFMvczg2FJ3wfTzmYsSc7XxO6kw1Yuk2WgpGAvhxn
 kq/Q==
X-Gm-Message-State: AJIora/K2+yvxmFVsrODqijCU29ZVBEUE25Un8tiAbexB8+rkddmzDZf
 axDblfAuSTUeuREI0Ybo2G1RFNIpMkXi5EgWBiU=
X-Google-Smtp-Source: AGRyM1v3dbvNVTuQm/ya5clPO36wuIIVrQ9iot9Eu2rYo+xp/TpPGrO5qQ85ZAmg2PeqPX/VYzEtnQ==
X-Received: by 2002:a05:6402:2804:b0:439:83c2:8be2 with SMTP id
 h4-20020a056402280400b0043983c28be2mr7501040ede.292.1657745419113; 
 Wed, 13 Jul 2022 13:50:19 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com.
 [209.85.128.52]) by smtp.gmail.com with ESMTPSA id
 lz21-20020a170906fb1500b0072aa38d768esm5397081ejb.64.2022.07.13.13.50.17
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jul 2022 13:50:17 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id n185so7208441wmn.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 13:50:17 -0700 (PDT)
X-Received: by 2002:a05:600c:354e:b0:3a1:9ddf:468d with SMTP id
 i14-20020a05600c354e00b003a19ddf468dmr11442317wmq.145.1657745416681; Wed, 13
 Jul 2022 13:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
In-Reply-To: <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Jul 2022 13:50:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBDup4LrJBr2WPkT09e_zk8g+Uq-5P-q5+THZ4jeoWVQ@mail.gmail.com>
Message-ID: <CAHk-=wgBDup4LrJBr2WPkT09e_zk8g+Uq-5P-q5+THZ4jeoWVQ@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 13 Jul 2022 20:58:36 +0000
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

On Wed, Jul 13, 2022 at 1:46 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> It does, but I can't imagine that the drm or ppc people would be happy
> about it.

When something has been reported as not building for five weeks?

I have zero f's to give at that point about their "happiness".

             Linus
