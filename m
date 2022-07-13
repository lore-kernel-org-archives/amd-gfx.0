Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554E8C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 20:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C668E99592;
	Wed, 13 Jul 2022 20:22:31 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E64799538
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 20:22:08 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id b11so21805621eju.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 13:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GJflsK92JuV59E3RXCQjvHWgsAc9fN7oPHKEHYO4/Yw=;
 b=Pf5e5dY4ycmPKNE+mP4Y1lGkQifW/vnVMda6koFE/ah0VebtYYKLeXhDl0yxQe5PN8
 Ov9ax8+x8Ob7EqWRSwBhLfOhk63lN23ULz/lIIuRWUQ9ib0LZZLoZI3TgLrOhA2Xefog
 AqJViDcTGsK2uzCBoJV5UDYv+qKYmCLgZGKss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GJflsK92JuV59E3RXCQjvHWgsAc9fN7oPHKEHYO4/Yw=;
 b=GUeMaqE7HdpEy+EXQAmUANulyeIB0ci7cYM2s5Z/xLM6fNuUTCsNzZUiUNAy2WQFQ8
 idixHmxL3JkUWgKcYAwhkl8puNl4iMjICBC5lp+fhmvZ+iE99A93j9QCNDc8DdvAaQKz
 eBULfO6ZjDytY7P8pCMctGKOABY8NjF5Xzg270gClVnrgHGUIYz+s5neh+JLWy56LaeO
 uWRxOVdF67PJag3hK5oMyZLtSM/+daMm9aqD4Hc5H9YMYCPxt9VvOoTkf2M2IHB1pmPk
 7ZfWkgQGQOQHSkkvpXHQJMXD0lNzZncFWtTs63Fnpt7F9LOSC6+f69bPnlo5fUIcuEpF
 iQLQ==
X-Gm-Message-State: AJIora+88VO5eYE+51Cbctc/C/7dz0GYFUE7qC+qdkOe0+O5bJbNm0ev
 V0FzYJzxD8GE5fw4ZuWj/CDeY5pZHJ56iIBxsis=
X-Google-Smtp-Source: AGRyM1vzN8yPWiGXOG/SwjN4Q4vZmWnairmIlBvd+stvIhWRJWOrAx5eaQhahuwOu36FVrm9Q+V+3w==
X-Received: by 2002:a17:907:d29:b0:72b:4b20:5650 with SMTP id
 gn41-20020a1709070d2900b0072b4b205650mr5072859ejc.350.1657743726458; 
 Wed, 13 Jul 2022 13:22:06 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com.
 [209.85.221.50]) by smtp.gmail.com with ESMTPSA id
 p15-20020a056402044f00b0043a95981050sm793884edw.79.2022.07.13.13.22.05
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jul 2022 13:22:05 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id bk26so17020644wrb.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 13:22:05 -0700 (PDT)
X-Received: by 2002:a05:6000:180f:b0:21d:68f8:c4ac with SMTP id
 m15-20020a056000180f00b0021d68f8c4acmr5115827wrh.193.1657743724966; Wed, 13
 Jul 2022 13:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
In-Reply-To: <Ys8hqoiN5iWbslsM@shell.armlinux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Jul 2022 13:21:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
Message-ID: <CAHk-=wjNxyXQqn=k0KipzUPoBYWQhUwybxee8GTkF_Oz6RPVFw@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 13 Jul 2022 20:22:30 +0000
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
 Harry Wentland <harry.wentland@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Daniel Axtens <dja@axtens.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 13, 2022 at 12:49 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> There may be a patch that solves that, but it's never been submitted to
> my patch system:
>
> https://lore.kernel.org/all/20220524025139.40212-1-wangkefeng.wang@huawei.com/

That patch looks sane to me, but I guess Guenter would need to check
... Guenter?

             Linus
