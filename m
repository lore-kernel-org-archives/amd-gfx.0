Return-Path: <SRS0=XsTU=6Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF6EC47255
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 14:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8732206B7
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 14:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gntQ+sol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8732206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB3E6E484;
	Mon, 11 May 2020 14:15:06 +0000 (UTC)
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D7C76E486
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 14:15:05 +0000 (UTC)
Received: by mail-oo1-xc44.google.com with SMTP id a83so149163oob.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2020 07:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qaKk+yEGj0jFQST8DEnVdOnwenk91QCipY4dq3XlJ2U=;
 b=gntQ+sol5OQ/Vbs+K1qUG9fKYz621mtFM5l05dGItrnRfss8HI6N9qWXgVu23rpLgy
 ihSIQzNzyNNHMc+QpBXwT/fLiC14NAjcI4kJD/KffuhVSyLoxUoTIdhCH4ZPth8MNROe
 6ZrOcUjDKSWSnZoCHqwh6M0bHKTgK6b4GQQjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qaKk+yEGj0jFQST8DEnVdOnwenk91QCipY4dq3XlJ2U=;
 b=QJb6xIj5jDQxxz8fY9u1mf9GzkLNSYuMWyVSQVCA9CKRDR3x1ioBGxbyU+eF7hAbZL
 tKVmADmxGLxEshlOGmJkqJbGoeMu+uaU1FOaoQkFjRPDdDen9vVRzPAE5TgAnTATGTas
 3No4fWR20dmB+r8qBA4augzJDEjIoYuy635JlBzFFu0+Lt3Ql5NStZSuRqR9t5WwaOPB
 v0KSZTNjB77va4IvzDG1zqCQud3i7Fh38Uh+gvGVZ+UQ6dKcFrrUrFzNYhSFoZwM8oqc
 Y/IZcMY9qIvC2JPFxAYfF3ESL9qUo9r2wuytbwDLZ18MNq2IyJV3Lf+DeBtEZoS+7Sx2
 N83A==
X-Gm-Message-State: AGi0Pua1YdZSCvfmAH4jx0Mbq23tJZia35YBRMezyNUSm358juEq8e4W
 /XwSK7Zka5fmgf8biMWMTb/MN6y3MSJy8CIsHzy2ug==
X-Google-Smtp-Source: APiQypKPh/Puo441x0mdTbOGGFru2eEyNnIVIYdN6JHa3U33HQkohYLKJPDp+3vStmWsaP5Cuj1PO9Cy/XtoQRetcqA=
X-Received: by 2002:a4a:d136:: with SMTP id n22mr13869652oor.85.1589206504836; 
 Mon, 11 May 2020 07:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <1589050310-19666-1-git-send-email-andrey.grodzovsky@amd.com>
 <20200511095433.GA206103@phenom.ffwll.local>
 <20200511114307.jfirnlvkikmulyhu@wunner.de>
 <CAKMK7uGA7XHPwuS3GF9u+YQ-GRBfZzf5CCRH15Tx_qnH3Pcchw@mail.gmail.com>
 <20200511140840.kd2yacwvyuaqkxkk@wunner.de>
In-Reply-To: <20200511140840.kd2yacwvyuaqkxkk@wunner.de>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 11 May 2020 16:14:53 +0200
Message-ID: <CAKMK7uFk3=iN7zdPgtX5wUkYYA2wMfSB0M7PcwpZarU6XJQekw@mail.gmail.com>
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

On Mon, May 11, 2020 at 4:08 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Mon, May 11, 2020 at 02:21:57PM +0200, Daniel Vetter wrote:
> > On Mon, May 11, 2020 at 1:43 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Mon, May 11, 2020 at 11:54:33AM +0200, Daniel Vetter wrote:
> > > > - One unfortunate thing with drm_dev_unplug is that the driver core is
> > > >   very opinionated and doesn't tell you whether it's a hotunplug or a
> > > >   driver unload. In the former case trying to shut down hw just wastes
> > > >   time (and might hit driver bugs), in the latter case driver engineers
> > > >   very much expect everything to be shut down.
> > >
> > > You can get that information at the PCI bus level with
> > > pci_dev_is_disconnected().
> >
> > Ok, so at least for pci devices you could do something like
> >
> > if (pci_dev_is_disconnected())
> >     drm_dev_unplug();
> > else
> >     drm_dev_unregister();
> >
> > In the ->remove callback and both users and developers should be
> > happy.
>
> Basically yes.  But if the driver is unbound e.g. via sysfs and the
> device is hot-removed while it is being unbound, that approach fails.
>
> So you'll need checks for pci_dev_is_disconnected() further below in
> the call stack as well to avoid unpleasant side effects such as unduly
> delaying unbinding or ending up in infinite loops when reading "all ones"
> from PCI BARs, etc.
>
> It may also be worth checking for pci_dev_is_disconnected() in ioctls
> as well and directly returning -ENODEV, though of course that suffers
> from the same race.  (The device may disappear after the check for
> pci_dev_is_disconnected(), or it may have already disappeared but
> pciehp hasn't updated the device's channel state yet.)

I guess we could do a drm_pci_dev_enter which combines drm_dev_enter +
pci_dev_is_connected. Not perfect, but well then the only real
solution is just unconditionaly drm_dev_unplug in ->remove. I think if
we do an additional developer_mode module parameter, and if that's not
explicitly set, ignore the pci_dev_is_disconnected and just always
call drm_dev_unplug() that would be about as good as it gets.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
