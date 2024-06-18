Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EADBC27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 21:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AED5A10E20B;
	Tue, 18 Jun 2024 21:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="grK22CQu";
	dkim-atps=neutral
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16DB910E20B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 21:56:16 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-4405304d062so32162601cf.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718747774; x=1719352574;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ji2+efuOAd6wBtWA0zFIRf6hUgNxX8IdSNdDWlzGrZQ=;
 b=grK22CQuFuHJcANzPvF6+nem/OVLYqR5yXnjcvztNPz5oTMZaPv6622xU1Ku3IBrsP
 vxB8kma9Sv3fvrYieFCdhOPL4v7i2pZAsbNqgpBcMKDoQrvQjjKKVz6Q+0KKcelASEa6
 EF2KjFE7upM0UdOP0amSYXXHV4FCMsc2J40Ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718747774; x=1719352574;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ji2+efuOAd6wBtWA0zFIRf6hUgNxX8IdSNdDWlzGrZQ=;
 b=bqQveDZ9tgcE1X5MYthNMroIeWFwqF3Lkmllr6MZYercRLHv3fFjwbyB3GSnjLdmYM
 /+vjYGDoOj/z9oaNDeUDS8UpMlVIIvUqIP0T4JDxTjbcRwWkWXtpY27DaQPmkq8/Ll74
 gijqQt82zQhvajhlKm1ne/i8qI222fhwHA80CI/RQe90cpDFJXtPFI2ZfkGEwoPLnh3o
 6o9DmLIRQVII5polSSmbvz8AO+kvMLo+gxbop+HYlCGKdgpeO/mhdn2hW3NhATkD0W5u
 mKPA/OQXr3del2D3qB16XvKdvgvJ9sk0kxg0t1Cf+5cuIb+njmA89FmAQxeBlxuwvcxZ
 D2mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy7byLNlcQQW7XUPl1mFFvXQ0Ig4FO0PDns50oaxszmJo+AkC4UTT2uauzqmZZ6Nt9I5aBdBhJm7Ga9UeOfFLmbx8AxyOYzf9BPVOZdA==
X-Gm-Message-State: AOJu0YyTtZwzMe/KanyFkGrJsn9TN0xux+MiZo89Napth7SDqWyJC2uo
 qNroCX9ouy/Fur51GRRXdzgYk/Z5TAZi3G+25OGWo94ZZgDVhgAcV9C/ZSqD5pGkGXqc9naW21w
 =
X-Google-Smtp-Source: AGHT+IELsb1Furz2UkYYb0CO0MHFCg32+PQT4Zh2fH6v5OgfOtzowqAjOyLkycNCAircPmAK3ywzJg==
X-Received: by 2002:a05:622a:1a90:b0:440:f5d7:f477 with SMTP id
 d75a77b69052e-444a7a88352mr11078091cf.59.1718747774223; 
 Tue, 18 Jun 2024 14:56:14 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com.
 [209.85.160.173]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-441ef3d883csm59254751cf.14.2024.06.18.14.56.13
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 14:56:14 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-443580f290dso42591cf.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 14:56:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCW/8eeH8Q93EKS5AlFwV8BUct5HboQToCKg+/4EG/aYJ1/1s2BnaTTKI+hQ3BEtFhJO9a61yGg997KBlhgqa8cnhOozctlz1Vgfu6kIhQ==
X-Received: by 2002:ac8:5748:0:b0:441:630e:110a with SMTP id
 d75a77b69052e-444aa409525mr298631cf.17.1718746453359; Tue, 18 Jun 2024
 14:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240612222435.3188234-1-dianders@chromium.org>
 <20240612152752.v2.8.I27914059cc822b52db9bf72b4013b525b60e06fd@changeid>
 <CADnq5_PbqE0E2pP26mGD94cdc=tLZZsF10e7ZZWeC5AU-LS8vw@mail.gmail.com>
In-Reply-To: <CADnq5_PbqE0E2pP26mGD94cdc=tLZZsF10e7ZZWeC5AU-LS8vw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 18 Jun 2024 14:34:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XJAiVGFn_Tqs_JNo1fQKFys3m=hH9MwmMot93gkdg=Qw@mail.gmail.com>
Message-ID: <CAD=FV=XJAiVGFn_Tqs_JNo1fQKFys3m=hH9MwmMot93gkdg=Qw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] drm/amdgpu: Call drm_atomic_helper_shutdown() at
 shutdown time
To: Alex Deucher <alexdeucher@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Candice Li <candice.li@amd.com>, 
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Le Ma <le.ma@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>, 
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Victor Lu <victorchengchi.lu@amd.com>, amd-gfx@lists.freedesktop.org, 
 chenxuebing <chenxb_99091@126.com>, linux-kernel@vger.kernel.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,


On Mon, Jun 17, 2024 at 8:01=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Wed, Jun 12, 2024 at 6:37=E2=80=AFPM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > Based on grepping through the source code this driver appears to be
> > missing a call to drm_atomic_helper_shutdown() at system shutdown
> > time. Among other things, this means that if a panel is in use that it
> > won't be cleanly powered off at system shutdown time.
> >
> > The fact that we should call drm_atomic_helper_shutdown() in the case
> > of OS shutdown/restart comes straight out of the kernel doc "driver
> > instance overview" in drm_drv.c.
> >
> > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Xinhui Pan <Xinhui.Pan@amd.com>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > This commit is only compile-time tested.
> >
> > ...and further, I'd say that this patch is more of a plea for help
> > than a patch I think is actually right. I'm _fairly_ certain that
> > drm/amdgpu needs this call at shutdown time but the logic is a bit
> > hard for me to follow. I'd appreciate if anyone who actually knows
> > what this should look like could illuminate me, or perhaps even just
> > post a patch themselves!
>
> I'm not sure this patch makes sense or not.  The driver doesn't really
> do a formal tear down in its shutdown routine, it just quiesces the
> hardware.  What are the actual requirements of the shutdown function?
> In the past when we did a full driver tear down in shutdown, it
> delayed the shutdown sequence and users complained.

The "inspiration" for this patch is to handle panels properly.
Specifically, panels often have several power/enable signals going to
them and often have requirements that these signals are powered off in
the proper order with the proper delays between them. While we can't
always do so when the system crashes / reboots in an uncontrolled way,
panel manufacturers / HW Engineers get upset if we don't power things
off properly during an orderly shutdown/reboot. When panels are
powered off badly it can cause garbage on the screen and, so I've been
told, can even cause long term damage to the panels over time.

In Linux, some panel drivers have tried to ensure a proper poweroff of
the panel by handling the shutdown() call themselves. However, this is
ugly and panel maintainers want panel drivers to stop doing it. We
have removed the code doing this from most panels now [1]. Instead the
assumption is that the DRM modeset drivers should be calling
drm_atomic_helper_shutdown() which will make sure panels get an
orderly shutdown.

For a lot more details, see the cover letter [2] which then contains
links to even more discussions about the topic.

[1] https://lore.kernel.org/r/20240605002401.2848541-1-dianders@chromium.or=
g
[2] https://lore.kernel.org/r/20240612222435.3188234-1-dianders@chromium.or=
g
