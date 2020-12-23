Return-Path: <SRS0=7Usp=F3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DCCC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Dec 2020 00:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB3D206E5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Dec 2020 00:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB3D206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A29CA6E249;
	Wed, 23 Dec 2020 00:37:46 +0000 (UTC)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C9926E85A
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Dec 2020 00:37:45 +0000 (UTC)
Received: by mail-io1-xd31.google.com with SMTP id z136so13654116iof.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Dec 2020 16:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lJYVQ7PnCCXi4g9tZbq1aPKbq5Rtjx1EMaT882nls4w=;
 b=MgpenJknft7iQnN1qHONOwIUAVFGZbTfUlyKCtiqfcsBcLnq3NrDaUQR1yQeCjanPh
 rfQYLYes4Y6YYvSKUXtPmGmy2G+2QggkvkrlLkj5rcLxEhorpwhN/DUhsYzhUJM79ZUc
 xLFqtzOAKMUzX9zZzwvpUJggF8JwfDcvfNSgrnFBwLP8Dvycf280O5pesqghtwB5ZjgY
 9z/QiU4vqim8LbGZduL049k6xY+xQl49PaTiZMntmryCcHddlZj1LDxiTdR3ZZeYeGNN
 yk7sUP6+St5Qehrj65UFIUskGYdgdUm+2AIz6OV1EgKGVrTIaBAv20q7iqw7OzA/EwwS
 Kjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lJYVQ7PnCCXi4g9tZbq1aPKbq5Rtjx1EMaT882nls4w=;
 b=k1dryrKBO4uJO1JYnMMovdR9szhBtZlJBby+lbQz+RGlExtQti9Fed8zKl6DwHY7fb
 Wx/VmpOzeg80H6AoHFt5JeqyUfiFGo9/ccojoXw34gKTNunlQmXFpCr95LmT7rpbK75q
 WPjxdkyf3e/pU7quxnKC0srVVdZyLt6UkHdD4zBMGffecqHJ3V8XHxGM6891r4a4WYLX
 BNNubcpmul+wj5lLW/tKdXd25bBBeQBl77JJpWCKKVwnwrw8QW61TL3cG9/Ms1+mAkI1
 kPh34/6OmHb7rzyS1m7+RYrp86y/6X4k4JkIaN3q3C+8BJrPulAURUix4yDXQ70hdmHX
 Dw/A==
X-Gm-Message-State: AOAM531VzcuNrxZQv6f5XzxEgrBXs5R3iHMs5oCfpDTWp/rdcS5gIf4R
 K3JvXsIe/xNCScilLo8SErD1/9VFErzCju8SyQPyHg==
X-Google-Smtp-Source: ABdhPJwgP/F4pOSTeZwylZfevHgKpGaLQTIMTYwhuVVUvutNwxduuYj+sWcFRA7FaPjBrcI006gae4LV8jkA1D5swm0=
X-Received: by 2002:a02:cd84:: with SMTP id l4mr21269052jap.141.1608683864709; 
 Tue, 22 Dec 2020 16:37:44 -0800 (PST)
MIME-Version: 1.0
References: <20201222031812.67228-1-zhan.liu@amd.com>
 <1c3f0095-b76f-5107-7b71-c284b79d8a09@amd.com>
In-Reply-To: <1c3f0095-b76f-5107-7b71-c284b79d8a09@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Wed, 23 Dec 2020 01:37:36 +0100
Message-ID: <CAP+8YyGUHN4J=p-gz8pGMKkjEONwpjXwe9FMYkeK50F7-Ls8=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Do not change amdgpu framebuffer format
 during page flip
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
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
Cc: Stylon.Wang@amd.com, Zhan Liu <zhan.liu@amd.com>, Chao-kai.Wang@amd.com,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Nikola.Cornij@amd.com, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 22, 2020 at 9:55 PM Kazlauskas, Nicholas
<nicholas.kazlauskas@amd.com> wrote:
>
> On 2020-12-21 10:18 p.m., Zhan Liu wrote:
> > [Why]
> > Driver cannot change amdgpu framebuffer (afb) format while doing
> > page flip. Force system doing so will cause ioctl error, and result in
> > breaking several functionalities including FreeSync.
> >
> > If afb format is forced to change during page flip, following message
> > will appear in dmesg.log:
> >
> > "[drm:drm_mode_page_flip_ioctl [drm]]
> > Page flip is not allowed to change frame buffer format."
> >
> > [How]
> > Do not change afb format while doing page flip. It is okay to check
> > whether afb format is valid here, however, forcing afb format change
> > shouldn't happen here.
> >
> > Signed-off-by: Zhan Liu <zhan.liu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 --
> >   1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > index a638709e9c92..0efebd592b65 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > @@ -831,8 +831,6 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
> >                                                               modifier);
> >                       if (!format_info)
> >                               return -EINVAL;
> > -
> > -                     afb->base.format = format_info;
>
> Adding Bas for comment since he added the modifiers conversion, but I'll
> leave my own thoughts below.
>
> This patch is a NAK from me - the framebuffer is still expected to be in
> a specific format/tiling configuration and ignoring the incoming format
> doesn't resolve the problem.
>
> The problem is that the legacy page IOCTL has this check in the first
> place expecting that no driver is capable of performing this action.
>
> This is not the case for amdgpu (be it DC enabled or not), so I think
> it's best to have a driver cap here or some new driver hook to validate
> that the flip is valid.
>
> This is legacy code, and in the shared path, so I don't know how others
> in the list feel about modifying this but I think we do expect that
> legacy userspace can do this from the X side of things.

I think the "new" thing is that we can have different format_info
structs for the same drm fourcc (as we need a different number of
planes depending on modifier). It would probably make sense to relax
this check to check the actual drm fourcc (i.e. fb->format->format)
instead of the format_info pointer. This case would likely only be hit
in the AMDGPU driver anyway (with intel being the other possibility).


>
> I recall seeing this happen going from DCC disabled to non DCC enabled
> buffers and some of this functionality being behind a version check in
> xf86-video-amdgpu.
>
> Regards,
> Nicholas Kazlauskas
>
> >               }
> >       }
> >
> >
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
