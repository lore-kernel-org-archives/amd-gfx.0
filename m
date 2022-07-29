Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F52C00144
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jul 2022 14:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB52110E6C2;
	Fri, 29 Jul 2022 14:18:10 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6FCA10E6C2
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jul 2022 14:18:09 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id z15so5987655edc.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jul 2022 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WpOM8lxdXPydVyixPgcr8asi8F8NolLt6W1b++brBYE=;
 b=MI5vVXY5JnYp13/U8JtXTfZbn7utQqITTLf3NqcAmOPQ5MWg/u1g44i8CWfEFn9D5K
 L2ORjYcW7WFz7VSktCqY7UxQ84AEuMJ/1OBEEwt95TP2waqFbiDYKanfMdNEmTMn49fh
 pLhjTzYTFAEiQ4XcEQqxgLdH+xKJs66w/xPx2Fgc/pNJvLMy3NOzHsbk9ZzbkEdDOS/p
 XeXZ4fLcciZUe++S5c3S1CzPoWiuo9ic9ujPPlI8gfAi/FanvwIBc7Z4KNNXIRsZeaNf
 MfGeOf3ihHUwbPyY27LPOHhSarT/OXtL5Mauc83h5uk58BLRFBxMMBINNjq1kERXWYS0
 8QOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WpOM8lxdXPydVyixPgcr8asi8F8NolLt6W1b++brBYE=;
 b=VWq1GXXV6nqL7OV4a4NqJBzU5gHV2Uz2N/OO8UD3DlGPWJglVtzmmYfypgSmh+Xzhg
 ilRBsRTkL7syoQRotIUsJUIsAnRzsDA1UvKEenHoq6OlRjXrT0AmZea6eoHs1G4M9E0f
 xFM0g8IZOvz1Vf9sB0vuXu9ga+2hntpK/Kc2Ob9RtwbwdVsPmOktlMPXwwmRFYC1WRke
 RW0irhfpOe40FdPYBfmMYusyvPt2W3VaM8J9ALlgIBKj85rYEjnNGCd4sDO7eQ7BLo26
 hAQPhEyVBLRFEhKkJw+10o7UScm8yDgy9maJ+8b5TeCnL5RZZjjkcUAHDcyA40N7J6Xq
 +z2g==
X-Gm-Message-State: AJIora/BObgD6NVcwXKcT1DKO+rkM+/zudJiOi+lypNCBUUmdwS3u21s
 xb3j3XALilg4nLGjhuQXDy4ONzqNIWz3qgC6C1k=
X-Google-Smtp-Source: AGRyM1v85ruG0wjELL626ktp+g3oDKkraiValdOHVVnYmlkaUCs4YKyP5xwgVObuBgzkf+1Yo+6dBDrsPc7L0+7VB/A=
X-Received: by 2002:a05:6402:168a:b0:43c:c76b:25ec with SMTP id
 a10-20020a056402168a00b0043cc76b25ecmr3818185edv.47.1659104288083; Fri, 29
 Jul 2022 07:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzXK1o+57sPVgPyFoQMkAyqzOko6Td8O-f-6eP_qLn0DkYs3A@mail.gmail.com>
 <CAHbf0-EHB+0e5D5cs1Br1_zhozJMhcNN3+eYfxUhk18LNgb48g@mail.gmail.com>
In-Reply-To: <CAHbf0-EHB+0e5D5cs1Br1_zhozJMhcNN3+eYfxUhk18LNgb48g@mail.gmail.com>
From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date: Fri, 29 Jul 2022 15:17:53 +0100
Message-ID: <CAEzXK1rR6WfeKXfwX9kOYGyvMhYPJJ7rxg62ijmscWWsY-A1aA@mail.gmail.com>
Subject: Re: Please consider Open-source OpenCL support in amdgpu/mesa
To: Mike Lothian <mike@fireburn.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks for the info!

There is also this Mesa candidate RustiCL which is already more
feature complete than the Mesa Clover:
https://www.phoronix.com/news/Mesa-OpenCL-3.0-CTS-Passes
https://www.phoronix.com/news/Rusticl-Darktable-Milestone
and it would be great if this OpenCL implementation materializes.

On Fri, Jul 29, 2022 at 1:37 PM Mike Lothian <mike@fireburn.co.uk> wrote:
>
> I've recently gotten ROCm 5.1.3 working on Gentoo with the open
> drivers and using upstream llvm 14.0.6, it's enough to get LuxMark 3
> running (well with fast math disabled)
>
> You might want to look for a distro that packages ROCm for you as
> Clover is nowhere near ready
>
> On Fri, 29 Jul 2022 at 11:06, Lu=C3=ADs Mendes <luis.p.mendes@gmail.com> =
wrote:
> >
> > Hi,
> >
> > I am an Aparapi project developer that has been struggling for two
> > years to get an RX 5700 properly running OpenCL applications.
> >
> > First of all, as an end consumer, I would like to congratulate the
> > open-source amdgpu driver for its stability and performance, as well
> > as the team behind it! Unfortunately I cannot say the same for the
> > closed source, proprietary drivers which have been a nightmare in
> > terms of quality and stability and currently the only way to have
> > OpenCL... which in reality is not the case, because it does not have
> > any stability.
> >
> > The open-source driver has been superior in terms of OpenGL and Vulkan
> > stability and performance, it just misses OpenCL to be complete.
> >
> > I am not expecting any reply on this, nor that it will make the
> > Open-source OpenCL support for AMD graphics cards a reality... I just
> > want to share this reality that I am experiencing for two years, with
> > many amdgpu-pro driver versions tested and also the new deb based
> > amdgpu-install drivers. None of them provided a working solution,
> > neither legacy based, nor rocr based ones. The machine starts running
> > a few OpenCL jobs, which after a few seconds lead to a black screen,
> > followed by GPU reset and machine hanging. The same OpenCL jobs run
> > fine on a GT 1030. There is also a big issue when running the RX 5700
> > as a secondary GPU, aside with the GT 1030 as the primary card, which
> > causes the amdgpu driver to fail to load and renders the RX 5700
> > unusable. I just wanted to share my experience with this card and hope
> > for a better future.
> >
> > Please consider Open-source OpenCL support in amdgpu/mesa.
> >
> > Best regards,
> > Lu=C3=ADs Mendes
