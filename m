Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA253FA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 13:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A2F710E640;
	Thu, 27 Oct 2022 13:40:26 +0000 (UTC)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C38FE10E63F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 13:38:53 +0000 (UTC)
Received: by mail-vk1-xa2d.google.com with SMTP id a66so754471vkc.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wdN+0/hciFT9WSd3Gl2aWlZzUTL58Rwb7IDn0EVMHro=;
 b=FYUOaX4cPr7Epo/0VwDQubTTswQUSQJKvHfc5t8UAJj7DoVEYBbmG2R1Kz2X1K44Q4
 vgiAs+TTYhyZ0zZ1rFrSGRrmajII9n+OVS2Rc7xdF3LIiua1fFPRjK5+mcpFvZfhajH0
 2/wNeN1xQuzFvuTjOwvzkvHBJfaa/vHVZLfgXFFhEkbvGkhHSP/cCApIMgXEshBHkCZs
 Agef0pCLh2sbV9HVd4QnCOyVbp6pZ+8nZQoZi/oiUgKglgvODtoGZJ1yWtyGzKkGgHrs
 uzlkDxmgz7EZvcZfysQbniodInp2ogG/VU1HkclItn+SuuIe34/z5oLXcjmjH/8qanwO
 hDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wdN+0/hciFT9WSd3Gl2aWlZzUTL58Rwb7IDn0EVMHro=;
 b=6JZ1MkausYuRGKIA9BBysl+khpS0S8cM55XXDko+owXefGE0cE8OOTK8DZmOP21uJI
 74fZjRUjubboJf4KjaDa0IpKrCpK1UjaiobKAlg6Q1oBFRuiYaRCfYRfvj0bt3YUfi9H
 q68JOAARtKwuzyDCBQnPwgBcPZGbX/rcDoyKz3zNIKigPaU0RYFgWEmEJ5aQb0pSWMvg
 3ZcTp2FeIX0+JQX7ByAm3NDxDn3x4scmTLNpOx7rpxH62sVCW4PthpNFKi8j8pU9rVRW
 Urx6EU5b1VKHx/6VC08nX6okODDYYMmKCOLmkVAk4HIgZTBazpbCtxNuA0Yk4aIeL13Z
 MxhA==
X-Gm-Message-State: ACrzQf2yIJy/Ek3nUjVphagQZxG6QocmUZUKyZFqGSTq9//mmmJlSZmV
 AKwBKCnxyuUZeOWov+kzKWf5PBOaza17CtcasZo=
X-Google-Smtp-Source: AMsMyM5jQghYtgRf73cKmHfKelunq5N0qsIu2vbVnC6JCb83OAX7wOY3e92zQmXlBpYjyTFhBsbCQNDRCicK0T4sBrg=
X-Received: by 2002:ac5:c3cd:0:b0:3a9:9ac0:f25f with SMTP id
 t13-20020ac5c3cd000000b003a99ac0f25fmr3868522vkk.16.1666877932618; Thu, 27
 Oct 2022 06:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221027002528.15983-1-hacc1225@gmail.com>
 <20221027002528.15983-2-hacc1225@gmail.com>
 <c41b45cb-8a1a-4140-b7f9-08aa481a25c1@app.fastmail.com>
In-Reply-To: <c41b45cb-8a1a-4140-b7f9-08aa481a25c1@app.fastmail.com>
From: Ao Zhong <hacc1225@gmail.com>
Date: Thu, 27 Oct 2022 15:38:41 +0200
Message-ID: <CAG9e_p3PH02ecZwVVdY8uXzxLTMNkhg-aPRjfY4aePCduc=dSQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/1] drm/amd/display: add DCN support for ARM64
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 27 Oct 2022 13:40:24 +0000
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

Am Do., 27. Okt. 2022 um 12:52 Uhr schrieb Arnd Bergmann <arnd@arndb.de>:
>
> On Thu, Oct 27, 2022, at 02:25, Ao Zhong wrote:
> > After moving all FPU code to the DML folder, we can enable DCN support
> > for the ARM64 platform. Remove the -mgeneral-regs-only CFLAG from the
> > code in the DML folder that needs to use hardware FPU, and add a control
> > mechanism for ARM Neon.
> >
> > Signed-off-by: Ao Zhong <hacc1225@gmail.com>
>
> There have been problems with stack frame overflows on this code
> in the past, how much have you tested this with random configurations
> to see if we still hit them in corner cases on arm64 that may not
> show up on x86 or powerpc? I would expect to see a few more of them
> for every new architecture port.

I just used this patch on my own Desktop and didn't test it much.

> > index d0c6cf61c676..3cdd109189e0 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> > @@ -33,6 +33,12 @@ ifdef CONFIG_PPC64
> >  dml_ccflags := -mhard-float -maltivec
> >  endif
> >
> > +ifdef CONFIG_ARM64
> > +ifdef CONFIG_DRM_AMD_DC_DCN
> > +dml_rcflags_arm64 := -mgeneral-regs-only
> > +endif
> > +endif
> > +
>
> >  CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
> >  CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
> >  CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags)
> > -Wno-tautological-compare
> > -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
> > +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o :=
> > $(dml_rcflags) $(dml_rcflags_arm64)
>
> Why do you need separate $(dml_rcflags) and $(dml_rcflags_arm64)
> rather than adding -mgeneral-regs-only to $(dml_rcflags) directly?
>
>     Arnd

I don't know if $(dml_rcflags) has any other use. I'm afraid my patch
will break something.
