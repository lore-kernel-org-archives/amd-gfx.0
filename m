Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA54BC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 17:32:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18617233CE
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 17:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18617233CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 970256E4BB;
	Thu,  7 Jan 2021 17:32:53 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C65F16E4C5
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 17:32:52 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id i9so6458163wrc.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Jan 2021 09:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=ns3knrCobRUeVGnustOcrOCTHp2ymD+OHw5Wwf+enN8=;
 b=Xh2I+dhrEkjrrM79DPTOC/+IIS9u4zL6yMPCdm4GAM6p8lWjzfT9jesKrXQwl4Yd6V
 zdZGL31IbutxG16PThQ5C9OJ18GW/VrFOelT5tL4XMGuJvnn9bvKaeqVA4PjrtUqICQM
 vuBijLR4L596mqSDl+GsZvWPq1VMqSuftXfRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ns3knrCobRUeVGnustOcrOCTHp2ymD+OHw5Wwf+enN8=;
 b=dclkdOmkQj/qiTAWViokyzqV6h/fY+BozPRewxFprc3TJAI0vayH2BOibyYRNXZ5qR
 PGFHHYn44RbgJCl9ZXiK8go7ex0H5EL1NkZu2xMrUS+9nQpRMje0Vcgta42gV2ULxEwH
 ylEjnMrBzoTbfgaBWk7TpZeSkJ7j1M4J/AZNQCHKx73lWsyWSzj3d9VzJHYiJoaahy+K
 QDtU9wNd8d1bJ94gaEljJG7vc/lxALw+JM2iQRNyTtsb0sHS2Fus4en3CnUhbEEhHmWq
 YyAt1X08NgLulzDR5BkRyzwQc97Nq2t2nkgdW4Prwxr1NTP0ktMHtl3z/x1h7fO8MMhb
 hRsg==
X-Gm-Message-State: AOAM533P2jyrLMbLGUPJhN2Ixnd1T/ai8Z+y+xpZaOphEOBcTwQnmlya
 vfofjYnZt45Csy9TYpS5alwiVw==
X-Google-Smtp-Source: ABdhPJyFFJJg8UFo8BWP9wmIXy5K3RkFEVYlehjNeRNizFdC4esnHO+39m2GeRVyiI6HvpG2gMKYnA==
X-Received: by 2002:a5d:43d2:: with SMTP id v18mr10065029wrr.326.1610040771171; 
 Thu, 07 Jan 2021 09:32:51 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id z63sm8991088wme.8.2021.01.07.09.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Jan 2021 09:32:49 -0800 (PST)
Date: Thu, 7 Jan 2021 18:32:47 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: christian.koenig@amd.com
Subject: Re: [PATCH v2] drm/amdgpu: Do not change amdgpu framebuffer format
 during page flip
Message-ID: <X/dFvzGu0lIK0mtT@phenom.ffwll.local>
References: <20201229211044.109020-1-zhan.liu@amd.com>
 <81e9467f-3498-2d6a-3822-902f2afb74c9@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <81e9467f-3498-2d6a-3822-902f2afb74c9@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
 dri-devel@lists.freedesktop.org, Nikola.Cornij@amd.com,
 amd-gfx@lists.freedesktop.org, bas@basnieuwenhuizen.nl,
 Nicholas.Kazlauskas@amd.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Jan 03, 2021 at 04:43:37PM +0100, Christian K=F6nig wrote:
> Am 29.12.20 um 22:10 schrieb Zhan Liu:
> > [Why]
> > Driver cannot change amdgpu framebuffer (afb) format while doing
> > page flip. Force system doing so will cause ioctl error, and result in
> > breaking several functionalities including FreeSync.
> > =

> > If afb format is forced to change during page flip, following message
> > will appear in dmesg.log:
> > =

> > "[drm:drm_mode_page_flip_ioctl [drm]]
> > Page flip is not allowed to change frame buffer format."
> > =

> > [How]
> > Do not change afb format while doing page flip. It is okay to check
> > whether afb format is valid here, however, forcing afb format change
> > shouldn't happen here.
> =

> I don't think this we can do this.
> =

> It is perfectly valid for a page flip to switch between linear and tiled
> formats on an I+A or A+A laptop.

It is, but that's not the bug here. struct drm_framebuffer.format is
supposed to be invariant over the lifetime of a drm_fb object, you need to
set it when the fb is created and never change it afterwards. So the patch
here isn't yet the real deal.

Also this means the implicit tiling information cannot be changed after a
fb is created for a given bo, but we've discussed this at length and that
limitation should be all ok.
-Daniel

> =

> Christian.
> =

> > =

> > Signed-off-by: Zhan Liu <zhan.liu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > =

> > Thanks Nick and Bas. Here is my second patch for review.
> > =

> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_display.c
> > index a638709e9c92..8a12e27ff4ec 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > @@ -832,7 +832,8 @@ static int convert_tiling_flags_to_modifier(struct =
amdgpu_framebuffer *afb)
> >   			if (!format_info)
> >   				return -EINVAL;
> > -			afb->base.format =3D format_info;
> > +			if (!afb->base.format)
> > +				afb->base.format =3D format_info;
> >   		}
> >   	}
> =

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
