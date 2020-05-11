Return-Path: <SRS0=XsTU=6Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D31C47255
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 12:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC72207FF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 12:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Pj24XGUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC72207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23A3B89A76;
	Mon, 11 May 2020 12:22:10 +0000 (UTC)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 217B189A76
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 12:22:09 +0000 (UTC)
Received: by mail-oi1-x242.google.com with SMTP id i13so14877914oie.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 05:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZY5CwuQVCnYlEVabKI73ABVH1IvMEeXvCtNVZpf7Tro=;
 b=Pj24XGUuQs2GDZHSexFLKNpui+qj0s7VHxuw6NFvC0AvS2wbVsgJOvLE2Z+lvgMfRm
 nSuXG91tjVXxxeJXrR8bdbChneohaNZhXY+0Fim9wWiVQnqcxUubpu9GpMfwdp+HZFIn
 +GHIh+ZSVIl2yp0CQjYSVAVEJTIfKPJkIg0T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZY5CwuQVCnYlEVabKI73ABVH1IvMEeXvCtNVZpf7Tro=;
 b=m484G2z9Ox/Wc9fV5V7PGsGKutAOL+kF9+oE2j8jBYOZcBrjHZwGdO7sPxRktW3tHw
 Tlpl77pIQwyKBdzw78ytK0HtByMe//4KVg0NpO46/MBBCNgC7aAr0o5FPXffp50NpxCl
 fUpqWtOQA31Ym0BHRMYR6vBX5OfnK8Sg6MR17cNj65vQ0d575oZWmrYME7bxyXqquCME
 maavzLYsUqijAgMD+t5MFly436RmlM+oJPBQ7HqrGVQj9AxOaCO7wNieGzmA1gFCZEys
 85TdSMVbbQ6N9mGPZQVYr4YakWmDTliKmTj8wWM2FK0ia5RfjdcXhoM8szxQF5yqpmvu
 5OyQ==
X-Gm-Message-State: AGi0PuYh1Plu0eU6pZ34E7lG6OgUHqcAeu87et/Z7GxcK31J8580k7Yw
 Q/AJlLvoiGDrS6hH/8qTJmrAh7dBJ/JFr/+gDNkoFg==
X-Google-Smtp-Source: APiQypLaLp1Py5/HgaUPfUd3OuFGQPYOI/YIpsVKy/0b6agJW6Aa7LgGQNmlP548/YKPc72Z7/+MpSjoZcyLL3lHGH8=
X-Received: by 2002:aca:52d5:: with SMTP id g204mr19438046oib.14.1589199728401; 
 Mon, 11 May 2020 05:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <1589050310-19666-1-git-send-email-andrey.grodzovsky@amd.com>
 <20200511095433.GA206103@phenom.ffwll.local>
 <20200511114307.jfirnlvkikmulyhu@wunner.de>
In-Reply-To: <20200511114307.jfirnlvkikmulyhu@wunner.de>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 11 May 2020 14:21:57 +0200
Message-ID: <CAKMK7uGA7XHPwuS3GF9u+YQ-GRBfZzf5CCRH15Tx_qnH3Pcchw@mail.gmail.com>
Subject: Re: [PATCH 0/6] RFC Support hot device unplug in amdgpu
To: Lukas Wunner <lukas@wunner.de>
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 11, 2020 at 1:43 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Mon, May 11, 2020 at 11:54:33AM +0200, Daniel Vetter wrote:
> > - One unfortunate thing with drm_dev_unplug is that the driver core is
> >   very opinionated and doesn't tell you whether it's a hotunplug or a
> >   driver unload. In the former case trying to shut down hw just wastes
> >   time (and might hit driver bugs), in the latter case driver engineers
> >   very much expect everything to be shut down.
>
> You can get that information at the PCI bus level with
> pci_dev_is_disconnected().  The flag queried by this function is set
> upon hot removal.  Be aware however that the device is guaranteed to
> be unreachable if the function returns true, but the converse is NOT
> guaranteed, i.e. the function may return false even though the device
> has just gone away.
>
> Those somewhat difficult semantics are one of the reasons why some
> people are skeptical of the function's merits (notably Greg KH).
> See this LWN article for more information:
>
> https://lwn.net/Articles/767885/
> (scroll down to the "Surprise removal" section)
>
> I've suggested to Greg a few years back that we should have a flag
> at the device level to indicate whether it's gone, not just at the bus
> level.  That way the property could be expressed regardless of the bus
> used.  It would facilitate the feature you're missing, that the driver
> core tells you whether it's a surprise removal or not.  Unfortunately
> Greg rejected the idea.

Ok, so at least for pci devices you could do something like

if (pci_dev_is_disconnected())
    drm_dev_unplug();
else
    drm_dev_unregister();

In the ->remove callback and both users and developers should be
happy. I guess for other drivers like usb/spi just yanking the cable
for driver hacking is good enough - loss of power should also reset
the device :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
