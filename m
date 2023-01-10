Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAEFC46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43C8610E5F8;
	Tue, 10 Jan 2023 16:18:12 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A6B10E126
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:17:14 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-4a263c4ddbaso161109887b3.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 08:17:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8aU+mKfBu8X0PaeS9GZLlFCjmJzuWowKv+EM4O20irM=;
 b=2drM80ADmgkwbkLDNJV05I/13BY3aNs2BIIUfn/JYJa2awn9Ihwtgu5TDu+ilWD83O
 /lYXlKe0IyUCiJbFICsG2pFmDLBrKzntFQxPmsBLV9tVvMl2dTCoHYxnapQDPs1I3m3e
 hVlST/Y/qSoUEHt3rlZqlh/eTycUNi4BNzDJ3JlGqp7qz1ZEbF1jALPE7TF276mD+4H/
 RbW9OYBmq/7qWnE0GpgxTOpyfd0BAuc7U3t2mFaWb1V/Oa18RVVFersEBnGdSBndV0xn
 6X7lN5D7ykoqvmqpuEzAqPSmeTnHSXvkx9S0c0wSUw1aspN38xUPjQGxhA7wvVEJkrMp
 cfGA==
X-Gm-Message-State: AFqh2kqN1X2bayqPBp4Frsvrxl1X1GHsSQpSKZFFamJmKw58iH0rNQK3
 MRlpczTqmzXIxBtrSgOU2av795ZmMAU3aQ==
X-Google-Smtp-Source: AMrXdXs5EMso9hO1Vc5DMF1jcRfS8moMFv9a4lsANCtWSJNzvjkGrOvl21Cz2QmEfbhspHtSyAPbZg==
X-Received: by 2002:a05:7500:4d0d:b0:f0:5cd5:e474 with SMTP id
 lb13-20020a0575004d0d00b000f05cd5e474mr434995gab.29.1673367432575; 
 Tue, 10 Jan 2023 08:17:12 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com.
 [209.85.128.178]) by smtp.gmail.com with ESMTPSA id
 w6-20020a05620a424600b00705be892191sm2963914qko.56.2023.01.10.08.17.11
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jan 2023 08:17:12 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-4d13cb4bbffso40261657b3.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 08:17:11 -0800 (PST)
X-Received: by 2002:a81:1751:0:b0:4bd:caff:589e with SMTP id
 78-20020a811751000000b004bdcaff589emr1813820ywx.502.1673367431195; Tue, 10
 Jan 2023 08:17:11 -0800 (PST)
MIME-Version: 1.0
References: <20230110154325.3350916-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230110154325.3350916-1-Rodrigo.Siqueira@amd.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Jan 2023 17:17:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVYrS-XUExgONr9r2pOYOddoyEifW62uZc6G6WU4k+ZWw@mail.gmail.com>
Message-ID: <CAMuHMdVYrS-XUExgONr9r2pOYOddoyEifW62uZc6G6WU4k+ZWw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Reduce stack size for DCN31/314
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 10 Jan 2023 16:18:11 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Roman Li <roman.li@amd.com>,
 amd-gfx@lists.freedesktop.org, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Rodrigo,

On Tue, Jan 10, 2023 at 4:44 PM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
> Geert Uytterhoeven reported compiler issues in some specific gcc
> versions that point to a large stack size for DCN31/314. Unfortunately,
> I could not reproduce the problem with the latest version of GCC/Clang;
> but I still believe this is a valid issue. Therefore, this patchset
> attempts to address those issues by moving many arrays of doubles from
> the local declaration to some specific structs. The first patch in this
> series introduces the new struct, and the subsequent patches move arrays
> of doubles from the local function in favor of using those values from
> the struct.
>
> Geert Uytterhoeven, since I don't have a simple way to reproduce this
> issue, could you run the CI in this series to check if this patchset
> solves the issues?

As I am just analyzing the build logs of the kisskb build service,
I cannot trigger builds at will.

> Link: https://lore.kernel.org/all/20221227082932.798359-1-geert@linux-m68k.org/

The issues with DCN31/314 were seen with arm64-gcc5, when
building an arm64 allmodconfig kernel:
http://kisskb.ellerman.id.au/kisskb/buildresult/14858073/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
