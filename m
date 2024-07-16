Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4A2C3DA59
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 17:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C45D10E7EC;
	Tue, 16 Jul 2024 17:25:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PBhLFILd";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3F4D10E6FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 17:25:46 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-52eafec1e84so8186562e87.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721150745; x=1721755545; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BIzlW/re+zqWdbXrMFMpZtR9RUNKkE+7zdmZJ+T5ET8=;
 b=PBhLFILdxrYYhIyDCvdLPsgfJp6POjrcRD/06ulW90QzE1nYbzp6p5lxh3lS8IoMtf
 Ib72xeuZu6yZ8E72wwPQbNolWD0DdnXQTpod+DkBWv8JmFgRr+U+8QZukcIne1BJuYIC
 3Ad0w6Jmhygq9rVAC9oNr852jaelDn1VqMjPNQHHO1xt1PW8XMZxj7gi4gAnradPF9Rd
 DVGmh8C/Xg+qeTRYei9w+iOlJWrjC7VG3YY7ZoMz4I/OiY3DM8+Y85mw8mOAXkjK93ZJ
 xciDRD+1R8w18rWcZdInJsJltX2ra6huVEP1jm6iTDbr5HfF3N9Fp54qpjoGdeYiPlDD
 suHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721150745; x=1721755545;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BIzlW/re+zqWdbXrMFMpZtR9RUNKkE+7zdmZJ+T5ET8=;
 b=MkAp9dr/1Apb+NfGNGxuWe9rqZxjYzaHJISOvZdpv3iCZzMT30Xsq8kFt+T8FXQ7FG
 MutpVCzM+8fR4oZZgwQMpVy7dLe8uo92OR2iMz47O8LT3slkSqymHuyJqmEaa4BbaG59
 eHpoWqS5UNAViR/xwTJEmy1ka/y9vRMbqixpyR9pfojRyHa49IxsOH36xNzyefUKJavZ
 VHe3DAOC1WvJVuuhxaGYObJddOKqTyQDBZFPs4xrFnq+szmthE8vWDc7e5i5hv4CuYFE
 I0xPXK/15S9JLSHXLvoLIEp0EAj9O3Q4tYFu0dr3HSSM6BZuu8paaw6u0YGg/PvrGM4X
 h+UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS92CPp3jAgN+DHgyDdPLO8rmqxp+hAEqXoUV0dF7jwqfkXPcU/mbo04vbsax78MY/GgQ6X6bhFlGFTwJ4V1txE55vxQ+JtK4O7d387Q==
X-Gm-Message-State: AOJu0YxvbNiAGxwwMjWDMp1a1oUtwKyG/zowea8Ei1s5Pcq5vtebRUx3
 qbVXjJtjpXBAS9yqQkbu3wuI4rGtfM6840BI2oHGuk8wfu5z9eYpmMpvccJd/6c=
X-Google-Smtp-Source: AGHT+IGGXs9LQIjcLFKl+/yb9bNVeYQzPggbFyrU2zP9kH7kEuX20Nqc1cSioz/zdX1LY1hUP9w7jg==
X-Received: by 2002:a05:6512:15a4:b0:52b:bee3:dcc6 with SMTP id
 2adb3069b0e04-52edf03011emr1612383e87.51.1721150744972; 
 Tue, 16 Jul 2024 10:25:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru
 (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52ed24e2a10sm1200582e87.7.2024.07.16.10.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 10:25:44 -0700 (PDT)
Date: Tue, 16 Jul 2024 20:25:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "open list:DRM DRIVER FOR MSM ADRENO GPU"
 <dri-devel@lists.freedesktop.org>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, nouveau@lists.freedesktop.org, 
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 freedreno <freedreno@lists.freedesktop.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: Re: DisplayPort: handling of HPD events / link training
Message-ID: <s6kua7scw65q2f43b6qimxjaqmm2a3giszkv4654ffnr4c7q7a@y2xqhp3mgf46>
References: <CAA8EJprfbMs_3PnpebhVg=NVrO5zc23cgx=1f4HAKLnT5b9J6Q@mail.gmail.com>
 <d3be8832-a6f2-496e-ac2e-9b29cae9f8f2@suse.de>
 <CAA8EJprA3aXHex4ctSE+ChhhWVLLdcXtppsadrNYbnHWi+gKLQ@mail.gmail.com>
 <e924c624-8664-4739-84c5-8229325f78ce@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e924c624-8664-4739-84c5-8229325f78ce@suse.de>
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

On Tue, Jul 16, 2024 at 06:48:12PM GMT, Thomas Zimmermann wrote:
> Hi
> 
> Am 16.07.24 um 18:35 schrieb Dmitry Baryshkov:
> > On Tue, 16 Jul 2024 at 18:58, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > > Hi
> > > 
> > > Am 27.02.24 um 23:40 schrieb Dmitry Baryshkov:
> > > > Hello,
> > > > 
> > > > We are currently looking at checking and/or possibly redesigning the
> > > > way the MSM DRM driver handles the HPD events and link training.
> > > > 
> > > > After a quick glance at the drivers implementing DP support, I noticed
> > > > following main approaches:
> > > > - Perform link training at the atomic_enable time, don't report
> > > > failures (mtk, analogix, zynqmp, tegra, nouveau)
> > > > - Perform link training at the atomic_enable time, report errors using
> > > > link_status property (i915, mhdp8546)
> > > > - Perform link training on the plug event (msm, it8605).
> > > > - Perform link training from the DPMS handler, also calling it from
> > > > the enable callback (AMDGPU, radeon).
> > > > 
> > > > It looks like the majority wins and we should move HPD to
> > > > atomic_enable time. Is that assumption correct?
> > > Did you ever receive an answer to this question? I currently investigate
> > > ast's DP code, which does link training as part of detecting the
> > > connector state (in detect_ctx). But most other drivers do this in
> > > atomic_enable. I wonder if ast should follow.
> > Short answer: yes, the only proper place to do it is atomic_enable().
> 
> Thanks.
> 
> > 
> > Long answer: I don't see a way to retrigger link training in ast_dp.c
> > Without such change you are just shifting things around. The
> > end-result of moving link-training to atomic_enable() is that each
> > enable can trigger link training, possibly lowering the link rate,
> > etc. if link training is just a status bit from the firmware that we
> > don't control, it doesn't make real-real sense to move it.
> 
> I have to think about what to do. People tend to copy existing drivers,
> which alone might be a good argument for using atomic_enable. The link
> training is indeed just a flag that is set by the firmware. I think it's
> possible to re-trigger training by powering the port down and up again.
> atomic_enable could likely do that. The hardware is also somewhat buggy and
> not fully standard conformant.

It stil looks like having an explicit comment ('check LT here becasue
handled by firmware') might be better.

-- 
With best wishes
Dmitry
