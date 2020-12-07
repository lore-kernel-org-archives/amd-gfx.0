Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F77C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 08:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8EE9233EE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 08:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EE9233EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E6BD6E9A2;
	Tue,  8 Dec 2020 08:33:04 +0000 (UTC)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 384266E8F4
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 22:28:54 +0000 (UTC)
Received: by mail-pg1-x544.google.com with SMTP id f17so10273331pge.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Dec 2020 14:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EWXoV2CMUKwuuJ9IGyn1rKyPqeDvcvXFpNW+D3PeZwc=;
 b=kdu710mWZmTmZmTippRswW3tNYS61Hyt5bfuXqwbc5QE25E3c+yvVvbeGQ6TqFEqgv
 3C+T9eGEchPhr7810GzQMYpyW0pfwBZiSQ1noHFBdceEU+6Y5WoVfe229HyXKeEpf2Gv
 4D8IlCK2FTh0VfqN4CJAE6yOZovksKJnnH3Z27ZSTvJeRD5DTnxCFy6Uf52DpFawOfyN
 EdZLPi4zpALMCG5G5DL+0sZ3aoNXyAzskwh4ceJQGcItrZuoFIRSZUbYZSnav4dNeSRi
 /dlborW2be3RN5R3tJsHMpb+Y1Al9qqt+Y2K0ekSmFV1spS6crIvHyLQZ700qoIu37NX
 nqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EWXoV2CMUKwuuJ9IGyn1rKyPqeDvcvXFpNW+D3PeZwc=;
 b=Abu1DCcERwQWozy+Gz/vO12Uo5OG1843KyVxRjQWext8RY+Obt9Phzclz4/Kxyd2Yn
 Vi53w8HHzBDqEHioQ1niSS0/J8u3zlxrpdR8MGQWnlNh6J8VoD9OvHkaTz8zfvdJkzDI
 daiLZqrowgD2RUj6WFZIHwhd9y2Of92XZCPRVkBtjD/C/yXnKkBcuI1njV3m2IijonhW
 9v6gfj6Ca6d/AQKSNRHd/jmm5YZpaYr0/jxwfwamyOwv2RlJTCPi2itUu4ZuWPzjASyn
 bp2QFystqNZKwb/LT4CWpW5Tcmpt8V3s63/DK68/XFnXKkL9+5c6g+M9DnZgaLm2CM7F
 VNAA==
X-Gm-Message-State: AOAM531RuYnncOEcT0I4ZE2D4J2y115kGb8slKAWKp0dazqbS+MLDUot
 VvFT0k12ji3mcqFyMwjZx9iE0Dx1z1OBV/akJf+Slw==
X-Google-Smtp-Source: ABdhPJzH235ZBy2+HtgSTmZfucYCnB2ALLUQMf094BhLSCBeBGevRQx+U8bJiscjIYvbi5B1I9kNRlXmGrr1BhXaY5I=
X-Received: by 2002:a17:90b:1b05:: with SMTP id
 nu5mr898064pjb.101.1607380133527; 
 Mon, 07 Dec 2020 14:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20201204081349.1182302-1-arnd@kernel.org>
 <CADnq5_OmAVZGuz=xHRyST4hE4w1g10wNBQ6iMgfpQD16-9QSiQ@mail.gmail.com>
 <b9d7e33c-4dcd-0075-d0ca-d22b2488c354@amd.com>
 <CAK8P3a09KQS7S5-vJU7ECJh0HXUhwZW9zOOp4c32mtvM5XcU1g@mail.gmail.com>
 <CAKwvOd=-2zoc06EY4R9ZJ0M874bQv3NuT8a0q9=RoYeMMtnXVQ@mail.gmail.com>
 <CAK8P3a0gjPWiRX0yg=i6Qxgyo02AtQVVsw+=w-OvF956Tn=jDw@mail.gmail.com>
In-Reply-To: <CAK8P3a0gjPWiRX0yg=i6Qxgyo02AtQVVsw+=w-OvF956Tn=jDw@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 7 Dec 2020 14:28:42 -0800
Message-ID: <CAKwvOd=+w6vJvvq9Pwnv1EHHzwCx=o_=PbSozXpqryN6P1yxVQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: make DRM_AMD_DC x86-only again
To: Arnd Bergmann <arnd@kernel.org>
X-Mailman-Approved-At: Tue, 08 Dec 2020 08:33:03 +0000
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
Cc: Timothy Pearson <tpearson@raptorengineering.com>,
 Arnd Bergmann <arnd@arndb.de>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Leo Li <sunpeng.li@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 David Airlie <airlied@linux.ie>, Randy Dunlap <rdunlap@infradead.org>,
 Roman Li <Roman.Li@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Daniel Kolesa <daniel@octaforge.org>,
 Alex Deucher <alexdeucher@gmail.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 7, 2020 at 2:17 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Mon, Dec 7, 2020 at 11:08 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > On Mon, Dec 7, 2020 at 1:57 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> > >
> > > Right, looking at my latest randconfig logs, I see the same problem on x86
> > > builds with clang as well, though I'm not entirely sure which other
> > > configuration
> > > options are needed to trigger it.
> > >
> > > So my patch can be disregarded, but I agree this needs a better fix,
> > > either in clang or in the dcn driver.
> >
> > If you could give https://github.com/ClangBuiltLinux/frame-larger-than
> > a spin again, I would appreciate any feedback.
>
> I've already tried it, but the tool doesn't seem to like me, I never
> get the information out of it that I want. This time it failed because
> it could not parse the .o file correctly.

Can you send me a config to reproduce the .o file?
-- 
Thanks,
~Nick Desaulniers
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
