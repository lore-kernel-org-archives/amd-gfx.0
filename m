Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D18EC30653
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 07:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 782E510E7AE;
	Wed, 26 Jun 2024 07:54:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="IIbs3qVF";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9769310E164
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 07:54:11 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-42111cf2706so8079495e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 00:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1719388450; x=1719993250; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aa2DK3FJcswd3lBlP25MRyQshT3cYKetmIItJLNJP64=;
 b=IIbs3qVF/xZn3Phsicxy6+wUnG4UkQmv+Pz9nCucpBph0XpZzAvMZgY+pKv1i0dISP
 tY++Atz6Hsb5wEeO9J3Jn4G1GZdREPsFtbscc1fAAFrNZoDs32CqIltFSe9RPVZOcd8U
 NT89X7f0ycj1wzKqfT3FaTM1InVpLTNJNYpXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719388450; x=1719993250;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aa2DK3FJcswd3lBlP25MRyQshT3cYKetmIItJLNJP64=;
 b=D2crgwAcqa5FwijrazeJyUZimzLMDpbYG4epQI37ZQqyqTArrXIrrEUaX51ZLVCR+z
 4HnsZocVBZ379W1zqZzZ6oHAZZeMPlbf4IQQua5KeRfInKtpvLNahUGpr/OrCtF0r1Dz
 ArKt3ML4bvIJnsn5I04WzDQ+3+WJCfflyFb2YndXvG4CwTu/hQ90WyXJakxucO19TB52
 B6YbY1YxH82sHyfsZj60x5CL0JN2MZharnS6Tq76CaEr9oeQVTZtlDKrlKL3fst54rL6
 JLVUlpBQxntXhMVzBQEHqNRgF6idJ7UNmhqLkNdX/mBG5aEBA/JfOu0KvZ+ptHuPLcjG
 Zfqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy0iklNmiGT5vhzQj79zclwy88JEhqcjZWqNxgzPNaNNHmPEeD2T6PkogrjG11rPrIP2JIpjnNg3pZGGILNF63jlDMMFO9G1NgEvj8dg==
X-Gm-Message-State: AOJu0YwrSOyXcPnYpKlA8T0bKkFC1VEggK9hL3BgYX0UiiijhDe5iMrH
 KCdWonxKVCgiGUxYQuZ8SWsBoA8L1yUXGPnHIcupz5Tq3e+TMZpasQrvLE7oEBs=
X-Google-Smtp-Source: AGHT+IHqaGlS+tvTfEnO1I9WHlqaGgPoVfylkGVqNci0K+5WMO+v3SflPB8hH8I8K/sNnuAh2cj/dw==
X-Received: by 2002:a05:6000:4010:b0:360:8490:74d with SMTP id
 ffacd0b85a97d-366e2a5e683mr7102118f8f.5.1719388449869; 
 Wed, 26 Jun 2024 00:54:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f693fsm14988889f8f.69.2024.06.26.00.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 00:54:09 -0700 (PDT)
Date: Wed, 26 Jun 2024 09:54:07 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/6] drm/amdgpu: allow ioctls to opt-out of runtime pm
Message-ID: <ZnvJHwnNAvDrRMVG@phenom.ffwll.local>
References: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
 <20240618153003.146168-2-pierre-eric.pelloux-prayer@amd.com>
 <c45283a1-98d2-43a2-a73c-71896464c7f9@amd.com>
 <d2eefecf-656e-4c9c-96b3-717756581cc1@damsy.net>
 <bcca41dc-8f75-4ca0-a843-62fa63636262@amd.com>
 <188b82b3-c600-4920-84c7-ceb072b8e9d6@damsy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <188b82b3-c600-4920-84c7-ceb072b8e9d6@damsy.net>
X-Operating-System: Linux phenom 6.8.9-amd64 
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

On Tue, Jun 25, 2024 at 09:07:12AM +0200, Pierre-Eric Pelloux-Prayer wrote:
> 
> Le 20/06/2024 à 15:36, Christian König a écrit :
> > Am 20.06.24 um 15:06 schrieb Pierre-Eric Pelloux-Prayer:
> > > Le 19/06/2024 à 11:26, Christian König a écrit :
> > > > Am 18.06.24 um 17:23 schrieb Pierre-Eric Pelloux-Prayer:
> > > > > Waking up a device can take multiple seconds, so if it's not
> > > > > going to be used we might as well not resume it.
> > > > > 
> > > > > The safest default behavior for all ioctls is to resume the GPU,
> > > > > so this change allows specific ioctls to opt-out of generic
> > > > > runtime pm.
> > > > 
> > > > I'm really wondering if we shouldn't put that into the IOCTL
> > > > description.
> > > > 
> > > > See amdgpu_ioctls_kms and DRM_IOCTL_DEF_DRV() for what I mean.
> > > 
> > > Are you suggesting to add a new entry in enum drm_ioctl_flags to
> > > indicate ioctls which need the device to be awake?
> > > 
> > > Something like: "DRM_NO_DEVICE = BIT(6)" and then use it for both
> > > core and amdgpu ioctls?
> > 
> > Yeah something like that. Maybe name that DRM_SW_ONLY or something like
> > that.
> 
> + dri-devel to gauge interest in adding such a flag in shared code.

Eh please no. That's just fundamentally the wrong way round to do runtime
pm, but amdgpu goes way, way back in desing in that record to the vga
switcheroo, where the simple hack was to just add runtime pm handling at
the entry points and call it done.

If you look at any other drm driver, the runtime pm handling is done way
down when touching the actual relevant hardware blocks. Because especially
on arm it's actually a pile of runtime pm domains.

So essentially this is like pushing a big driver lock down the callchain
until it's actually at the right level. First step would be to push it
into each of the amdgpu ioctl callbacks, so that you can drop
amdgpu_drm_ioctl and use drm_ioctl again directly. And then push it
further until you can remove it from all the places where it's not needed.

DRM_SW_ONLY otoh is pure midlayer mistake design.

Cheers, Sima

> 
> Pierre-Eric
> 
> 
> 
> > 
> > Christian.
> > 
> > > 
> > > Pierre-Eric
> > > 
> > > 
> > > 
> > > 
> > > > 
> > > > Regards,
> > > > Christian.
> > > > 
> > > > > 
> > > > > Signed-off-by: Pierre-Eric Pelloux-Prayer
> > > > > <pierre-eric.pelloux-prayer@amd.com>
> > > > > ---
> > > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 25
> > > > > ++++++++++++++++++++-----
> > > > >   1 file changed, 20 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > > > index 60d5758939ae..a9831b243bfc 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > > > @@ -2855,18 +2855,33 @@ long amdgpu_drm_ioctl(struct file *filp,
> > > > >   {
> > > > >       struct drm_file *file_priv = filp->private_data;
> > > > >       struct drm_device *dev;
> > > > > +    bool needs_device;
> > > > >       long ret;
> > > > >       dev = file_priv->minor->dev;
> > > > > -    ret = pm_runtime_get_sync(dev->dev);
> > > > > -    if (ret < 0)
> > > > > -        goto out;
> > > > > +
> > > > > +    /* Some ioctl can opt-out of powermanagement handling
> > > > > +     * if they don't require the device to be resumed.
> > > > > +     */
> > > > > +    switch (cmd) {
> > > > > +    default:
> > > > > +        needs_device = true;
> > > > > +    }
> > > > > +
> > > > > +    if (needs_device) {
> > > > > +        ret = pm_runtime_get_sync(dev->dev);
> > > > > +        if (ret < 0)
> > > > > +            goto out;
> > > > > +    }
> > > > >       ret = drm_ioctl(filp, cmd, arg);
> > > > > -    pm_runtime_mark_last_busy(dev->dev);
> > > > >   out:
> > > > > -    pm_runtime_put_autosuspend(dev->dev);
> > > > > +    if (needs_device) {
> > > > > +        pm_runtime_mark_last_busy(dev->dev);
> > > > > +        pm_runtime_put_autosuspend(dev->dev);
> > > > > +    }
> > > > > +
> > > > >       return ret;
> > > > >   }

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
