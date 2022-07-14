Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC7AC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 18:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E764510FC70;
	Thu, 14 Jul 2022 18:54:56 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D89F710ED07
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 17:43:50 +0000 (UTC)
Received: by mail-lj1-x236.google.com with SMTP id q7so2983571lji.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 10:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aQIp8jUeV/XH0MZXLU4tEbIH8uIqKDByVIHXKyZP/oM=;
 b=S1lYzRFvIdrkIuaNzMc/xioVsE7X9wBzpEVTIMQkFWfupjKZ6kNWPumY0Ye9sveMsW
 oaCERdVafUZh+op/+O3O+X8ETitsx6/PVxlxnnZMBOKafMqdulWvuXUMSfos9vvYhfbm
 3m/NkR3E706fZqsm4Ku3yk2exNh6VL2kASg58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aQIp8jUeV/XH0MZXLU4tEbIH8uIqKDByVIHXKyZP/oM=;
 b=be/6G6r2HRzq/ZkvMW349XfO7bf6ia9oQRlxKq0E4ghGgAdT5tJqijxuvEvlP6hjfq
 JFwb0dwruKDLejEWjrQyraYLUOoNtZT9uqvbZ5B/tL6vCO/ILuxa7Q4C6+t1eG7uHFtT
 LOAyCMg+U+/H1I77ZsULe+0+uhPCMVNOL2fbZusCBT/h8wGAJ6/K8yGs+5g8NBQtaRt0
 uCgDzJ6jbYrdSArYiu8pa6t91gUCoqCn9g5veYa7m1EL5iPfQpaWCOYK8vDSclmx5pXG
 CWsaka/W7zTaOntLLsiD2vhN+EpaX1dh15AKyWz9BJ09HdmaKFgOrsqxYMygriwHKdPS
 wG1A==
X-Gm-Message-State: AJIora9hztSqxfKtz67238dRQSctA7XGqOVrfr1Vz7xjgWEYqBHZRvLh
 R8Rutclv2qe5dbFWq9+ndjHe9lRiZmlrcVqxbpo=
X-Google-Smtp-Source: AGRyM1v8WsKjoLl96o9HJ7Cnn6TlIwgI3snlCxgjBY37cmtRuQyUWSjB+t9FLtmLQvLOR972I1afNw==
X-Received: by 2002:a2e:9601:0:b0:25d:8019:d662 with SMTP id
 v1-20020a2e9601000000b0025d8019d662mr5187754ljh.487.1657820628733; 
 Thu, 14 Jul 2022 10:43:48 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com.
 [209.85.167.45]) by smtp.gmail.com with ESMTPSA id
 a2-20020a19e302000000b00489e50cf274sm455792lfh.229.2022.07.14.10.43.48
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Jul 2022 10:43:48 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id d12so3975068lfq.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 10:43:48 -0700 (PDT)
X-Received: by 2002:a05:6000:180f:b0:21d:68f8:c4ac with SMTP id
 m15-20020a056000180f00b0021d68f8c4acmr9553345wrh.193.1657820267054; Thu, 14
 Jul 2022 10:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
 <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
 <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
 <CAMuHMdV9Pj9V-ZPpu=BMSkPt1uA_eCvU4+bxF8ZfHjteRk2CAg@mail.gmail.com>
 <CAHk-=wgnmaTVigBc02tjqgcZaNJiYz8Xw77P+ERAXhcYjkwd=Q@mail.gmail.com>
 <6d5ac61b-b490-4f9d-6521-a4b7477d6fd2@roeck-us.net>
In-Reply-To: <6d5ac61b-b490-4f9d-6521-a4b7477d6fd2@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Jul 2022 10:37:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0o1-6f1skMbSh07JR+BxxZenS4ZdWuFipR-0w_Hj6Nw@mail.gmail.com>
Message-ID: <CAHk-=wh0o1-6f1skMbSh07JR+BxxZenS4ZdWuFipR-0w_Hj6Nw@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
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
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Alex Deucher <alexdeucher@gmail.com>, Harry Wentland <harry.wentland@amd.com>,
 Daniel Axtens <dja@axtens.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 14, 2022 at 10:24 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> We can't use virt_to_phys() and phys_to_virt() because they are defined for
> the underlying architecture. Would uml_to_phys() and uml_to_virt() be
> acceptable ? If so, I'll submit a patch.

Sure, that would be good, and make th uml helpers clearly be in the
uml namespace.

Another more traditional approach is to use underscored versions, but
exactly because that's the normal thing, things like that may then
clash with the "native architecture" version, so for uml using an
explicit uml namespace might be the better option.

               Linus
