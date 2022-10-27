Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B04FA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 14:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30F9F10E647;
	Thu, 27 Oct 2022 14:11:50 +0000 (UTC)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C294310E63E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 13:49:31 +0000 (UTC)
Received: by mail-vs1-xe36.google.com with SMTP id k67so1659498vsk.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 06:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t0hW+J5KXTh9GX5LSmTfMcGKCZ2YpHD7tUHVTP/nQkE=;
 b=JfZffURfkXufz/gtu31hKzmVnb0HhX2xL7+6E/AxsxdTAfrVCTzh6dvS/HRg84lb1R
 6CeKAiWa6r6jOA2g84FlO/ImOdcFd96L6RpU1GjnikAX7iqUs4P+KziuEr//It7X+7bh
 afhYwJu4OSCVNuq790cLa1nwFGnxYpGe393i0jpM0L4S+H4iSK0iQNK/UiElCirKFSog
 umcqoGj1kmyRDCrfbIqpP7e8P14bHC+wjWePGWymJODQaLPvD1UlE85mEGHOScE40D1U
 dHdkJmKeK/yprxe6DX6ik8AOyc/+O8TwUBo26FPwMTyxgMT+Mt7QsyMOzuuZt0jmfYmT
 3FEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t0hW+J5KXTh9GX5LSmTfMcGKCZ2YpHD7tUHVTP/nQkE=;
 b=2JoIIErkxTaEDMgQjh68JPu+N22KBKJy8epk/WOpQ5u6FjGzOJeNI7OrJAkaQ+PTMj
 dukmhrQLTDvhqo9CxDcvzJTr1raghvKAe2N3M9mxyJQv6RbYSjj0QPSj+tZVXKTWsy0c
 9zA0SFkwQVkCtv333jxcRYLwFcw1hhv5125/Jt3mebBQv6jszEoCfW5nmFm5hzLXztiz
 CMAu7GQBhyHZJ2RdIGe7g8kjgD5sQk+6HWhYrlBMUv9PYVqDy8w9KLBj96xYtGrz93jf
 7ASKlcgqNNNSyTtPGj17jApCTB3+CbQZRK+pZt0ZIf4YRQD/ztwd8ATmjmRy9nsNbXBY
 f6Dg==
X-Gm-Message-State: ACrzQf1AYzQEUaX8WN3E+GS1H78sabr3NInnS8Ea2ZBQz2U77x7dJRpk
 2bjPex7HQUa20M+LBsGEk5Ccm9gzPkZK3pDRH5E=
X-Google-Smtp-Source: AMsMyM7bXCPq3UaYR+Xsv2igO4H5R///jXz6eDIJFSBcqV3PgpqIC+CX2V4JnKh6zxvbu7o8ycEk/gQSMuStgS5GWpE=
X-Received: by 2002:a67:b845:0:b0:39b:a1c:fcc7 with SMTP id
 o5-20020a67b845000000b0039b0a1cfcc7mr23720543vsh.79.1666878570849; Thu, 27
 Oct 2022 06:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221027002528.15983-1-hacc1225@gmail.com>
 <20221027002528.15983-2-hacc1225@gmail.com>
 <c41b45cb-8a1a-4140-b7f9-08aa481a25c1@app.fastmail.com>
 <CAG9e_p3PH02ecZwVVdY8uXzxLTMNkhg-aPRjfY4aePCduc=dSQ@mail.gmail.com>
 <7de4285f-1bdb-421f-9e40-e5657400ce1e@app.fastmail.com>
In-Reply-To: <7de4285f-1bdb-421f-9e40-e5657400ce1e@app.fastmail.com>
From: Ao Zhong <hacc1225@gmail.com>
Date: Thu, 27 Oct 2022 15:49:19 +0200
Message-ID: <CAG9e_p0-R2sgqcqwFUZ_Pa7myc-MkkGWkorinOnDpDc=-iq24A@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/1] drm/amd/display: add DCN support for ARM64
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 27 Oct 2022 14:11:48 +0000
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

OK, I'll replace $(dml_rcflags_arm64) with $(dml_rcflags).

Am Do., 27. Okt. 2022 um 15:45 Uhr schrieb Arnd Bergmann <arnd@arndb.de>:
>
> On Thu, Oct 27, 2022, at 15:38, Ao Zhong wrote:
> > Am Do., 27. Okt. 2022 um 12:52 Uhr schrieb Arnd Bergmann <arnd@arndb.de>:
> >
> >> Why do you need separate $(dml_rcflags) and $(dml_rcflags_arm64)
> >> rather than adding -mgeneral-regs-only to $(dml_rcflags) directly?
> >
> > I don't know if $(dml_rcflags) has any other use. I'm afraid my patch
> > will break something.
>
> From the git history, it looks like dml_rcflags was introduced for
> arm64 support originally and left in place when this support got disabled.
>
>        Arnd
