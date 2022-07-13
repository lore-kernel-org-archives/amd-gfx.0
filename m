Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD374C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 20:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47AEC14B8F5;
	Wed, 13 Jul 2022 20:23:57 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A821910B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 20:23:02 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id r6so15534715edd.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 13:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d1P5rX72RXyRvGR7JCZ4qVZh1CiP/TKW9UtB14PFhaQ=;
 b=hp43ldtRziA5PUHZyd4RJvKAVLE41k/JKMzhpS//B1rETg03AmLcMxtVsSmgdzCMlb
 t44JOsl9PL+s6wYOQEJPZD0NHxYo63Bm3DBi/uPpvJFGrf3vZkmlu45wXZNa4Qj4zXqW
 mz1WdEdTJ8v9A+xQt4LlwhRS6fDVV8/nYc5Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d1P5rX72RXyRvGR7JCZ4qVZh1CiP/TKW9UtB14PFhaQ=;
 b=SFjgSgKp1uP3Y2fi1XxLAtE+mmntN1eNxCwxlOOvViP+UwUIzJbuLbsw5gKOJz0QNX
 LaAj+zsP/dVlBN+ZcaIG23vZf96YnizZTOUG53q1czdLxX7qYp05sxKE7XTq5f4wxr1P
 007pGG58mpNH1e05YOpOIXIwkYOTX8P8T4Zxc9LM9z2sWs1tvP+Mc4sqp29Erufmb4wU
 yrcMFgm1Zwalwj1RC3olHVKNuefQHJwed/5EIPHgwB4TAAxM95/xMRzPsdCwH7I9GOwJ
 MUSZIjlZvFIRiuIoFuzIvinK+b7NZNYpEgFAod5lbJfQ9Pm467aEIrTA9vucj0HfETje
 gaGQ==
X-Gm-Message-State: AJIora8s5C11mQ3AAUxsgA05cwwhgMgaBfv42bcbN7AV8D1nFsqebzSd
 awSa8j2D53jaRDI9+gDKp2rlhkGsIlpFfEeOWHA=
X-Google-Smtp-Source: AGRyM1tGOLTQkApGuY71xFPXwZN8oz+2H0tvUDTp6BhZBgm7MGrXD6YqC4UOimVvwPOYAYYZX4kjbw==
X-Received: by 2002:a05:6402:5245:b0:43a:a024:82cc with SMTP id
 t5-20020a056402524500b0043aa02482ccmr7514986edd.56.1657743780772; 
 Wed, 13 Jul 2022 13:23:00 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com.
 [209.85.128.45]) by smtp.gmail.com with ESMTPSA id
 r21-20020aa7d155000000b00435a08a3557sm8426730edo.27.2022.07.13.13.22.59
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jul 2022 13:23:00 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id o8so7176409wms.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 13:22:59 -0700 (PDT)
X-Received: by 2002:a7b:cd97:0:b0:3a2:dfcf:dd2d with SMTP id
 y23-20020a7bcd97000000b003a2dfcfdd2dmr11342692wmj.68.1657743779568; Wed, 13
 Jul 2022 13:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <CADnq5_Ma2oe-6+WG4ZRAm97G7TyS0Nuhdxt=7oqdNLcMP5nKeg@mail.gmail.com>
In-Reply-To: <CADnq5_Ma2oe-6+WG4ZRAm97G7TyS0Nuhdxt=7oqdNLcMP5nKeg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Jul 2022 13:22:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgW-g5jAMmKjnG0_mhqtEKzbKxs=Lo8DDv1D2wZvhL-8Q@mail.gmail.com>
Message-ID: <CAHk-=wgW-g5jAMmKjnG0_mhqtEKzbKxs=Lo8DDv1D2wZvhL-8Q@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 13 Jul 2022 20:23:55 +0000
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
 Harry Wentland <harry.wentland@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Daniel Axtens <dja@axtens.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 13, 2022 at 12:53 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Does this patch fix it?
> https://patchwork.freedesktop.org/patch/493799/

Guenter? Willing to check this one too for your setup, and we can
hopefully close down both issues?

                 Linus
