Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4E8D10F5A
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 14:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4EDE10E650;
	Wed, 26 Nov 2025 14:31:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="fX2GVEgg";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1144710E637
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 14:20:27 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-42b2e9ac45aso4067956f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 06:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1764166825; x=1764771625;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K+mX3K4EZWXpumEvNCBx9+WunDYcwtTk4SgV9tqSlww=;
 b=fX2GVEggeIWwyylfupsU7FBjTHVurzr+2/wLA4JYqFyPpSdW1ACtsnasbEzEGi/+jk
 GV3cul1rsJwyoKSR8BbeMDO3kO1ZojVFkZguyRs0TvQRlvuXstL6CEWgPmDJiFLccD4k
 0ZEz63OjmIoeQ3osSloCV0wOVvYm1UheVQnx+cjwEmm9Hd//8Uchq6MLQ3w/3MhqzLRn
 A8Eec3RLNi80SWAiMY0hhSxw9uT3sVu0NosVmJWV2RLKFtR7pEcgSuvmpiMJlvHTmgIi
 g826fUMFIU6hTK8jSn8gLtiDO2++fSxMjw4J+yjimXdl93p8FN7Ex1Rrc0/FieleWm8d
 nuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764166825; x=1764771625;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K+mX3K4EZWXpumEvNCBx9+WunDYcwtTk4SgV9tqSlww=;
 b=QDRSCSf7WrLozUh4cD5vothXVu8zUsKCrmy7sb1+04sC7G3FspXiSebPQTVp5muvDn
 +xUEqfPpvznynQCsfbZuFw6p94eRHI5qfreUFwCNHLyWiZETbhsXinSbavfwVCXuodNL
 X9xaFuJHHZQ5DOCtahM3JDcd2FG2hsqXCpLVM/NQ451TILYt8vBL64252B0SqnMnZPnN
 UlLLcCxctCelG9SFqq36A4mwvs4ZHK8FptwXAISlq7J4Np0K6Xo4HPNeGYmfmpGR1ymc
 wjRCmiWlJXiuTzFsr5G8gHb+NqAnQfwAFOzdUx1E4XVdnvXq13pdNNntbD2h0B7Zgbft
 gsgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCF9Gdl5mBntoRVji7wmfgFRVq7BOf/Rwz1wJfsmPVsgHDuT7rMSOiG3zzYlMzNTJ4fkMNAp8x@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzEoa9oxh1twS4RqANGEp9lvELky+KnP6PMK3ykXoK9LoL3D+Em
 AhopEvEXrW59ma1VPn1M7t0dJCIy8K4TQ/3W+jL+IYSA7MVT7/CPtoQ/O9+7teO/8TA=
X-Gm-Gg: ASbGncvW7bHP7uGx0YX/j+GSUAsZh2Jch4eg7K6e6QmaxwsfkHsd+Ft+njH1diA7H8V
 JjwkHrhTScpg0h7oaAWBD5Dp8kvmLQwvKj6zxN1oYGdK4+AL3OmHfwirjHZynNCnv3g+rht8Zpg
 IfLcBx0FUzr7ANd5kd8kITYuZzuJtDdc0xj8JwGQbpSIl9hjCwP3N7JmvDr6LAsBPEWsYbHRuh7
 OabpIljZONH2JtFiKoZXI5p5IBT0LjN9dfavzBUAcO7XKkUiwzmmeXpjpYvqGilull42S4JyyVR
 dZx/vaFsXz/I+8ucYHQGdvxMNZRTwYiMu9wetnrUQ4NLOIoUae9Xgc6XWd+5RpSrL9JRTuu7vwF
 cb314F8EH0dMZxk9SDMF5u/QY81+Ww49G2LN8H9/81D+/pxsDWDpuVeTvU9FT71BQgC+NXCZPFf
 6h1UUmumrZCscT4fvZ+EdG8jrrLwgKi9xTtpDFDiv03q9dQsiyGJWnoTaWzZrS+ZN9Vrj79g==
X-Google-Smtp-Source: AGHT+IHetDpaeSCLD158eeBfnLMa77d0GWcu9KkUU/dpWWOreiarVBFn16/gIezMUQj2z9CZm6a8yQ==
X-Received: by 2002:a05:6000:40c9:b0:42b:3806:2bb7 with SMTP id
 ffacd0b85a97d-42e0f1e35c2mr7360017f8f.6.1764166825367; 
 Wed, 26 Nov 2025 06:20:25 -0800 (PST)
Received: from aspen.lan
 (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fba20esm40814603f8f.37.2025.11.26.06.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 06:20:24 -0800 (PST)
Date: Wed, 26 Nov 2025 14:20:22 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Daniel Thompson <danielt@kernel.org>,
 Doug Anderson <dianders@chromium.org>, simona@ffwll.ch,
 airlied@gmail.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, lyude@redhat.com, dakr@kernel.org,
 deller@gmx.de, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, jason.wessel@windriver.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nir Lichtman <nir@lichtman.org>
Subject: Re: [PATCH 0/5] drm: Remove remaining support for kdb
Message-ID: <aScMprMh6Eh4JU5D@aspen.lan>
References: <20251125130634.1080966-1-tzimmermann@suse.de>
 <CAD=FV=X_-t2AF5osp7Hamoe7WYE_2YWJZCaPaOj=9seSbnwwVA@mail.gmail.com>
 <aSbwWLTLe0bMhOKV@aspen.lan>
 <054f60ca-b898-488f-81f4-14eed0a1360b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <054f60ca-b898-488f-81f4-14eed0a1360b@suse.de>
X-Mailman-Approved-At: Wed, 26 Nov 2025 14:30:52 +0000
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

On Wed, Nov 26, 2025 at 02:32:32PM +0100, Thomas Zimmermann wrote:
> Hi
>
> Am 26.11.25 um 13:19 schrieb Daniel Thompson:
> > On Tue, Nov 25, 2025 at 07:26:33AM -0800, Doug Anderson wrote:
> > > On Tue, Nov 25, 2025 at 5:06 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > > > <snip>
> > > > Therefore remove the remaining support for kdb from the DRM drivers
> > > > and from DRM fbdev emulation. Also remove the hooks from fbdev, as
> > > > there are no fbdev drivers with kdb support.
> > > >
> > > > If we ever want to address kdb support within DRM drivers, a place to
> > > > start would be the scanout buffers used by DRM's panic screen. These
> > > > use the current display mode. They can be written and flushed without
> > > > mode setting involved.
> > > >
> > > > Note: kdb over serial lines is not affected by this series and continues
> > > > to work as before.
> > > >
> > > > Thomas Zimmermann (5):
> > > >    drm/amdgpu: Do not implement mode_set_base_atomic callback
> > > >    drm/nouveau: Do not implement mode_set_base_atomic callback
> > > >    drm/radeon: Do not implement mode_set_base_atomic callback
> > > >    drm/fbdev-helper: Remove drm_fb_helper_debug_enter/_leave()
> > > >    fbcon: Remove fb_debug_enter/_leave from struct fb_ops
> > > Personally, I've never worked with kdb over anything other than
> > > serial, so this won't bother any of my normal workflows. That being
> > > said, at least as of a year ago someone on the lists was talking about
> > > using kdb with a keyboard and (presumably) a display. You can see a
> > > thread here:
> > >
> > > http://lore.kernel.org/r/20241031192350.GA26688@lichtman.org
> > >
> > > Daniel may also have comments here?
> > TL;DR - I'm pretty relaxed about these changes... but I'd like
> >          to know how to test the changes.
> >
> > Like Doug I only really use kdb via serial but, since I'm maintain
> > the thing I do occasionally test kdb works on the qemu console. I don't
> > do it very often though because it's a manual test!
> >
> > I'd assume that will still work since it won't involve any of the
> > drivers above. I'm afraid I can't double check that since patch 4
> > doesn't apply cleanly in v6.18-rc7 (nor to linux-next... and neither
> > does the base-commit appear in linux-next).
>
> To test its effects, ignore this series and simply clear the two calbacks at
> [1]. This is where the debugger invokes fbcon. The series removes their
> implementation in the final patch.
>
> [1] https://elixir.bootlin.com/linux/v6.17.9/source/drivers/video/fbdev/core/fbcon.c#L3202

Thanks. Explanation in original cover letter was great and there's
certainly been no harm to QEMU.

Acked-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
