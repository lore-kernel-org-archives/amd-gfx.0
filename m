Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BEEC6FA82
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 14:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C4410E593;
	Mon, 12 Sep 2022 14:52:04 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F2CA10E4BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 14:01:23 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id a14so8569477ljj.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 07:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=fTmZlTF0ozUTz9FNHM8ceugdx/I4yrLTc1mvMhk+LnY=;
 b=RWwfo4yxwS8BpjmCu1LJDE/snmzdpu6oE0csDb/L7C52g/YGf04B8d3NVVrPs2ZyKm
 5mK/NNTFxTkccaD9ootPwDWKBLqn7e4V+ls2qpch3xqdUsBJBee+9CSpr7Wo3ueWcxry
 E07Q7kdXxzLDr1FCI41+8douZ0acMx98N5ulk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=fTmZlTF0ozUTz9FNHM8ceugdx/I4yrLTc1mvMhk+LnY=;
 b=BKXVBf4MzX5omEv4zUp8UMdEBADDE6P+zr8ZXxwERhNFLGVOJ1Gyo13BgX+aSbhbbL
 Nq3Nf1I/AqgKXO9nJHbqkfH9UtVWTHbXXF8YiWbObv1565nAI64EyteKNEb1tHfIgkxz
 VS0Ugn6sfMkGSKhvvaDBMhryRxJud0miMsjkXI4zND96SBXS/VCDeeYO/6umbMilKxu4
 va+QGvfNeQjQo8Cu2v+W0BmsCxr9Hm+zr+dSShMB/1Drw1LkmubHuepMvwDyMD0IByEV
 yMFP2gGbqul2euVprrf56Ichfg8UWYHVpNb9QUUDailNEy9ivNEY8qcoFWhl1Khs1/PA
 CFxQ==
X-Gm-Message-State: ACgBeo2a+tp5byzSmy6Y8XyBnESfAD38Mi7mLwg/AM8ajK4cRtWM7NSN
 72JkZpxEEVVpZ2rDap168lgNYF/zW5U2CfrF
X-Google-Smtp-Source: AA6agR6aILA6Jh55EM1fOMxzAVFU0LFvpd0XaGmdytbR2thbMLmWOyi9B1KJHZxIJmSWUUNtRO4hVA==
X-Received: by 2002:a05:651c:1611:b0:261:e11c:c2ef with SMTP id
 f17-20020a05651c161100b00261e11cc2efmr7453689ljq.340.1662991281743; 
 Mon, 12 Sep 2022 07:01:21 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com.
 [209.85.208.182]) by smtp.gmail.com with ESMTPSA id
 c9-20020a056512324900b00498fe38ea0fsm1088828lfr.174.2022.09.12.07.01.20
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Sep 2022 07:01:21 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id bn9so10678551ljb.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 07:01:20 -0700 (PDT)
X-Received: by 2002:a2e:9e11:0:b0:268:c7d0:9662 with SMTP id
 e17-20020a2e9e11000000b00268c7d09662mr7392328ljk.309.1662991280232; Mon, 12
 Sep 2022 07:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjG0js0MpsoH3-yvp05u_gXHu+uhkvqdAZDVb=9xUmX=g@mail.gmail.com>
 <CADVatmPAkS9ope2oOQHB8nKc_sx2MM9P6aSqxwdA5sgyqvCvvQ@mail.gmail.com>
In-Reply-To: <CADVatmPAkS9ope2oOQHB8nKc_sx2MM9P6aSqxwdA5sgyqvCvvQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Sep 2022 10:01:03 -0400
X-Gmail-Original-Message-ID: <CAHk-=wh5X9q_MzUHGq1mEjJ9KqFxxDMzXoETMM_gSiGoq-eEOw@mail.gmail.com>
Message-ID: <CAHk-=wh5X9q_MzUHGq1mEjJ9KqFxxDMzXoETMM_gSiGoq-eEOw@mail.gmail.com>
Subject: Re: Linux 6.0-rc5
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 12 Sep 2022 14:52:01 +0000
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 12, 2022 at 7:59 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> clang build failure as reported in [1] is still there. Nathan has
> posted a patch series at [2] to fix it, but it has not landed yet.Alex Deucher <alexander.deucher@amd.com>
>
> [1]. https://lore.kernel.org/lkml/YuwRyQYPCb1FD+mr@debian/#t
> [2]. https://lore.kernel.org/all/20220830203409.3491379-1-nathan@kernel.org/

Yes, I was hoping for the AMD GPU people to take it and have the
hardware people who actually wrote that code (?) verify it all.

It would be good to have clang finally do a full allmodconfig build
with no errors and warnings.

Adding in Alex and Rodrigo that have been involved in the previous
stack reduction stuff, and the amd-gfx list for anybody else
involved...

Anybody?

                   Linus
