Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BABC00140
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Aug 2022 07:11:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D040F90757;
	Mon,  8 Aug 2022 07:11:22 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF93A112EEF
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Aug 2022 17:55:23 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id gk3so12811451ejb.8
 for <amd-gfx@lists.freedesktop.org>; Sun, 07 Aug 2022 10:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=tH9P5Ev6KfldpgA7IyGsP6cuudklMvx95MGD8TKUKT4=;
 b=C4CL1iu+qx5rdNpY/Qdx3Op6dbE/9zKXo4LCAeV+cbmx/rvLCK+FcObJUilhM226pd
 qtTxjZWV0gQfDYjqPT/IttAiEKQ6zFvDllkAQkGzhczUFYexBZVFtNxH/hwngF0cEm0M
 jFXxpFIfpzmNNaiVAKGaWiV4JLbHqQY4j7Qg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=tH9P5Ev6KfldpgA7IyGsP6cuudklMvx95MGD8TKUKT4=;
 b=dprSLzMEk7NCk4HZQ4Si3wkbZmsJf+VuBQsMk1lqOzU7FmveCZnfGLojPJEleKO28O
 AICwg3Cv+axDJS9zEO6Y5uP0AXfLeFRlwWgO2Be1sn9dPMKzjGMLYSlTKUDmZvzd3Kr7
 bmQVpfkOZ8DKvMIfjnZr1qdjvVbuJXmu5Sb/tqSzeDaAk4J6av5n+dbGP4L6lPumTT3m
 tESlmgYoyUIu3XdcF73cscfzPRCV3sI3X7mL5BVGt6tcEN5o+qQzmWLRZMwvLzm6MPOm
 WbZUWYjaS6x2Qegi1PLjLO0mamb8N4Pgb0pfQoAClaYpAllG1p9uNEstoGPhwly23k9K
 M8/w==
X-Gm-Message-State: ACgBeo06hQUdWzZ8LafdTSmPQHSkEjFKWOkCjUnakKvdNJQ0xm2dOeEE
 ulFGXrvWiZpVxRAZeoRsQt5WJY6hjsZMyLoW
X-Google-Smtp-Source: AA6agR6q76hMaQqxbGgXyGLI8/OfilO4QRTCrjaQY5NOg0VFbiGJTEFVytDBcKXx0McXj368s/EJqw==
X-Received: by 2002:a17:907:75c1:b0:730:aa62:7f65 with SMTP id
 jl1-20020a17090775c100b00730aa627f65mr11195500ejc.355.1659894922246; 
 Sun, 07 Aug 2022 10:55:22 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com.
 [209.85.128.44]) by smtp.gmail.com with ESMTPSA id
 mz16-20020a1709071b9000b007309cc59e81sm4006084ejc.126.2022.08.07.10.55.21
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Aug 2022 10:55:21 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id ay12so895714wmb.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 07 Aug 2022 10:55:21 -0700 (PDT)
X-Received: by 2002:a05:600c:1d94:b0:3a4:ffd9:bb4a with SMTP id
 p20-20020a05600c1d9400b003a4ffd9bb4amr10178442wms.8.1659894920750; Sun, 07
 Aug 2022 10:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <YuwRyQYPCb1FD+mr@debian>
 <CAHk-=whptVSSZL=wSUQJdRBeVfS+Xy_K4anQ7eQOky7XUrXhUQ@mail.gmail.com>
 <CAK8P3a2bEaExue0OtNeLa2CVzBx-1dE9w2HZ2PAV5N8Ct9G=JQ@mail.gmail.com>
 <YuwvfsztWaHvquwC@dev-arch.thelio-3990X>
 <9fb73284-7572-5703-93d3-f83a43535baf@amd.com>
 <CAK8P3a3Fv=_+GV9r=k4jP72zZOjJowL-GOue-51EhyVDBaEfEw@mail.gmail.com>
 <Yu1bMqL5tsbq1ojj@dev-arch.thelio-3990X>
 <CAK8P3a3PAxkctN6AXOsoTBTFgwHhk7_OSYwJ4Rgk7Dbs+bc0Qw@mail.gmail.com>
 <cb3ea155c4e149eca30ca870e3f2546d@AcuMS.aculab.com>
In-Reply-To: <cb3ea155c4e149eca30ca870e3f2546d@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 7 Aug 2022 10:55:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghheK1pKhpu9SuQkjzUvu25-vTu8nyxozooarhAmaXhw@mail.gmail.com>
Message-ID: <CAHk-=wghheK1pKhpu9SuQkjzUvu25-vTu8nyxozooarhAmaXhw@mail.gmail.com>
Subject: Re: mainline build failure for x86_64 allmodconfig with clang
To: David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 08 Aug 2022 07:11:16 +0000
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
Cc: Arnd Bergmann <arnd@kernel.org>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 David Airlie <airlied@linux.ie>, clang-built-linux <llvm@lists.linux.dev>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Sudip Mukherjee \(Codethink\)" <sudipm.mukherjee@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Aug 7, 2022 at 10:36 AM David Laight <David.Laight@aculab.com> wrote:
>
> Or just shoot the software engineer who thinks 100 arguments
> is sane. :-)

I suspect the issue is that it's not primarily a software engineer who
wrote that code.

Hardware people writing code are about as scary as software engineers
with a soldering iron.

               Linus
