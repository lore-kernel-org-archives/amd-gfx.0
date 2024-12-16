Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E13CE7717F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2024 09:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DA8010E557;
	Mon, 16 Dec 2024 09:28:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w2hA5syn";
	dkim-atps=neutral
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3424810E557
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 09:28:12 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5401fb9fa03so4013469e87.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 01:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734341290; x=1734946090; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6dMI9lFv3gZf7Rc2QqtA/lg0U1pqI/h3WDnWMJYBuLU=;
 b=w2hA5syn3KLhBPGvLfZBPcYYqOuT3TjgDTfBWmsm1VBSbwsAJUWWvv7k2zEk2c4jLv
 U8hXZQQUoktGKzEWCAIR70dpZAOFD0+nJMTRHgidRLgoNfUUAY5yBi0Q5jGuqZSqn02n
 7PJCPBU6ZE/hKtRLlzKAQwP8//FvzyzmpJ5SGxIN8G6M8V3agQNJ44TldSXu6NoDxJLM
 fxS/D79mSiNchcZefFQ+JRXBUPhLrYqbh9KRCNM+xdNpgtPqtpSItXJjduLKIfLK3otw
 sLU8uU8Mi/FJv9RH22rKWsq22Q/srM8cElsiqj9YiNBJURsX3JLbqR6F0aX+WGihPgJw
 ef2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734341290; x=1734946090;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6dMI9lFv3gZf7Rc2QqtA/lg0U1pqI/h3WDnWMJYBuLU=;
 b=uwtRYsdbi4gCADy3iYb7gjkz2zLPPiZan/EdvBXJEdsGgbGmAHXS0FtXrdM8vm9BAt
 johczSbcNVU3AzdpZkHVAw9KqQ/Em9rCNijttIoZ76xMiZx1Qe8w7M73dyphGoM/urp8
 im9cwtFkAQCMjjyrEaYL7JeuIi3MbWqkG7GI3kW8CWCdxJvkYmoIuiT1BKHEQM0CnU3F
 nLs+BmXR6jWeabT0iVBq4l5Ms9YXynGBmfaIqmr2W03VWZ6ho7393RsPlubX8MHEy7j2
 p4i9IfCe2hKZWRY3s2ecCbTN4wqy6V8XyzlE/+A6Y6vnhYRMhjPkH/OrIC441/z1je5O
 59mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUshzo94o3HsH2F8CeSie3CgdwrPrdfIiEGFd9npqHOoIcSHtx/TZ3mJNgWZYjrcgjWQVipFbBg@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLw5ewcFfEFTwjZNd+AL9thcVVBtjY16FzQVtWR2D+BSQinwBR
 YiYOOaM5wAazgqDDfakoUmCYQcv8RAJvgSC/18KMcWSYkGM/vAvD3Unkh/Iqz1Q=
X-Gm-Gg: ASbGnct47KpPD1EErf/JQ3ro2KCuULt51oBlgoX5z2aLBwDaXeNNVTVqoD39QcBtK1a
 qXHsPj3W/aScTVlB13RKyif+vO+K7mbAnFj2bfrbSwt1wm4LvrB+Vty4+C1WWHwp4WFJnQ+vVVr
 YeL8zlTuJHuXSrrlAZeKG39VYIYyrjLRGnpYMYhmoZQ1nhInj++DsT11OI4qP+ggyRQMWkUtnev
 59LoLDs6juX9k6snZpHvh2DnK5/JHUWMnFt3xWGtwQ+OIcJPCvAVUtOVDIoian9qCvTk10Wwftc
 DxkMcIOa6l/fG7jQSflmvUdzoi6D0dot/5np
X-Google-Smtp-Source: AGHT+IHs6NCnrYaNshN/ZbVXFubc/f8O03Y/ZSPJvt0rFLQtnhiIR+O8d5/vdko9ic471iOdkNFhOg==
X-Received: by 2002:a05:6512:3e16:b0:53e:395e:57f2 with SMTP id
 2adb3069b0e04-540342592e4mr4950102e87.11.1734341290417; 
 Mon, 16 Dec 2024 01:28:10 -0800 (PST)
Received: from eriador.lumag.spb.ru
 (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c20ac2sm767913e87.258.2024.12.16.01.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 01:28:09 -0800 (PST)
Date: Mon, 16 Dec 2024 11:28:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Marek =?utf-8?B?T2zFocOhaw==?= <maraeo@gmail.com>
Cc: Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/fourcc: add LINEAR modifiers with an exact pitch
 alignment
Message-ID: <j6tx2oxperyjzb2qukuho5jadricty7twshempdxufl5b6c6hs@ccyy6hnnrphq>
References: <CAAxE2A5BkF13bFt8_UnuiqPM8W-ZESgmKEjqqGfv=DGzSfJ7aQ@mail.gmail.com>
 <CAAxE2A77j94VNp33VhO97n3db_fZz1zUpM_VUPfkt96_Dzu9Bg@mail.gmail.com>
 <972c14f7-bf6f-450f-92c5-3f2b8390eac8@froggi.es>
 <CAAxE2A6popiaVF=u5B1swqXLGwnPxFTrqJKSEJJZ4tjVeWDpsA@mail.gmail.com>
 <893fedef-1592-487d-abd7-18f9d9ff79c8@froggi.es>
 <CAAxE2A79pOgZV9iK4fnbG0m8+vhrWej1J0jdMKwsxMSYEq3Chw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAxE2A79pOgZV9iK4fnbG0m8+vhrWej1J0jdMKwsxMSYEq3Chw@mail.gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 16, 2024 at 12:40:54AM -0500, Marek Olšák wrote:
> git send-email (or rather the way it sends email) has been banned by gmail
> due to being considered unsecure. I don't plan to find a way to make it
> work and I don't plan to use a different email provider. It doesn't matter
> because I'll be the committer of this patch in our amd-staging-drm-next
> branch.

I'm sorry, but I'd second Joshua. As a community we use certain methods
and certain approaches which makes it easier for other people to review
your patches. One of those includes sending patches in plain text
without any attachments, etc (documented under Documentation/process/).
All my patches are being sent using git-send-email or b4 send via GMail.
Other developers use web-relay provided by the B4 tool.

Next, the MAINTAINERS file lists Alex, Christian and Xinhui as
maintainers of the drm/amd tree. If the file is incorrect or incomplete,
please correct it.

Last, but not least, this patch will likely go into drm-misc-next or
drm-next instead of amd-saging-drm-next. It is not AMD-specific.

> Let's talk about the concept and brokenness of DRM_FORMAT_MOD_LINEAR, not
> send-email.

The biggest problem with your approach is tht it is not clear which
modifier to use. For example, if one of the formats requires 128-byte
alignment, should the driver list just 128B or both 128B and 256B? If at
some point we add 32B alignment, will we have to update the drivers?
Which format should be used for exported buffers? Please provide
corresponding driver patches that utilize new uAPI.

Also, please don't forget the backwards compatibility issue. If we
follow this approach, the drivers have to list both LINEAR and new
PITCH_ALIGN modifiers. So the userspace still will attempt to use
LINEAR.

It is true that such requirements are platform-specific and are usually
encoded in the compostitor. I think it might make more sense to export
the pitch requirements using the extra hint-like property, which then
can be used by a smart userspace.

> Marek
> 
> On Sun, Dec 15, 2024 at 9:08 PM Joshua Ashton <joshua@froggi.es> wrote:
> 
> > Not really for my benefit, more that it's the proper thing to do if you
> > want anyone to apply your patch.
> >
> > You should really just be using git send-email.
> >
> > On 12/15/24 11:57 PM, Marek Olšák wrote:
> > > Only for you: Attached.
> > >
> > > Marek
> > >
> > > On Sun, Dec 15, 2024 at 6:37 PM Joshua Ashton <joshua@froggi.es
> > > <mailto:joshua@froggi.es>> wrote:
> > >
> > >     You should just re-send the whole patch, probably.
> > >
> > >     On 12/15/24 8:54 PM, Marek Olšák wrote:
> > >      > Missed 2 lines from the diff:
> > >      >
> > >      > +#define DRM_FORMAT_MOD_LINEAR_PITCH_ALIGN_128B
> > >     fourcc_mod_code(NONE, 2)
> > >      > +#define DRM_FORMAT_MOD_LINEAR_PITCH_ALIGN_256B
> > >     fourcc_mod_code(NONE, 3)
> > >      >
> > >      > Marek
> > >      >
> > >      > On Sun, Dec 15, 2024 at 3:53 PM Marek Olšák <maraeo@gmail.com
> > >     <mailto:maraeo@gmail.com>
> > >      > <mailto:maraeo@gmail.com <mailto:maraeo@gmail.com>>> wrote:
> > >      >
> > >      >     The comment explains the problem with DRM_FORMAT_MOD_LINEAR.
> > >      >
> > >      >     Signed-off-by: Marek Olšák <marek.olsak@amd.com
> > >     <mailto:marek.olsak@amd.com>
> > >      >     <mailto:marek.olsak@amd.com <mailto:marek.olsak@amd.com>>>
> > >      >
> > >      >     diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/
> > >      >     drm_fourcc.h
> > >      >     index 78abd819fd62e..8ec4163429014 100644
> > >      >     --- a/include/uapi/drm/drm_fourcc.h
> > >      >     +++ b/include/uapi/drm/drm_fourcc.h
> > >      >     @@ -484,9 +484,27 @@ extern "C" {
> > >      >        * modifier (e.g. not setting DRM_MODE_FB_MODIFIERS in the
> > >      >     DRM_ADDFB2 ioctl),
> > >      >        * which tells the driver to also take driver-internal
> > >     information
> > >      >     into account
> > >      >        * and so might actually result in a tiled framebuffer.
> > >      >     + *
> > >      >     + * WARNING:
> > >      >     + * There are drivers out there that expose
> > >     DRM_FORMAT_MOD_LINEAR,
> > >      >     but only
> > >      >     + * support a certain pitch alignment and can't import images
> > >     with
> > >      >     this modifier
> > >      >     + * if the pitch alignment isn't exactly the one supported.
> > >     They can
> > >      >     however
> > >      >     + * allocate images with this modifier and other drivers can
> > >     import
> > >      >     them only
> > >      >     + * if they support the same pitch alignment. Thus,
> > >      >     DRM_FORMAT_MOD_LINEAR is
> > >      >     + * fundamentically incompatible across devices and is the
> > only
> > >      >     modifier that
> > >      >     + * has a chance of not working. The PITCH_ALIGN modifiers
> > >     should be
> > >      >     used
> > >      >     + * instead.
> > >      >        */
> > >      >       #define DRM_FORMAT_MOD_LINEAR  fourcc_mod_code(NONE, 0)
> > >      >
> > >      >     +/* Linear layout modifiers with an explicit pitch alignment
> > >     in bytes.
> > >      >     + * Exposing this modifier requires that the pitch alignment
> > >     is exactly
> > >      >     + * the number in the definition.
> > >      >     + */
> > >      >     +#define DRM_FORMAT_MOD_LINEAR_PITCH_ALIGN_64B
> > >     fourcc_mod_code(NONE, 1)
> > >      >
> > >
> > >     - Joshie 🐸✨
> > >
> >
> > - Joshie 🐸✨
> >
> >

-- 
With best wishes
Dmitry
