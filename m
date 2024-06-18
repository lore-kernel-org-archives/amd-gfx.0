Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3618C2BA15
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 23:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 411C010E13B;
	Tue, 18 Jun 2024 23:53:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Shl6+1TM";
	dkim-atps=neutral
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com
 [209.85.166.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7D6510E13B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 23:53:27 +0000 (UTC)
Received: by mail-il1-f171.google.com with SMTP id
 e9e14a558f8ab-375e0e258b7so22672505ab.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 16:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718754804; x=1719359604;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cSMpbX3YjY+n1K6XdU7KZ18fAHLxIUowLHHewo9pUPw=;
 b=Shl6+1TM6gWopCLgYzjdrXBMElpb1FOa3CVz0yZanV2sNufw6Vw9VOF2+OtihJ9nYV
 RJ8s4JI6vhClpTcl7RH1Xoz6gNLINO32HQyXt30Ltk0JW9tY9wAxgTy95oDgeOQkWLI7
 KcH/9r8ROm2ilmOM0pYbkIQo5+NYYVk8HaW4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718754804; x=1719359604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cSMpbX3YjY+n1K6XdU7KZ18fAHLxIUowLHHewo9pUPw=;
 b=THuhnoPx2Wtu9QHASN97O5+MFtCO5Jjuu+Ny8nN4s+qz99AvzBqmwdTFrTfw9AjHd4
 jERWID6jpaRi2KqHe6QEukwd0j8U4mtvPoclHLiHhx296JD9VNDlGL4rXntZy+JhkzGk
 FqI+yfWHHaiXtYo9zBcbAR8Rr2+5IgjcJqwo4YhapOVgM1qDhf01yflL+Zda8LQ1YeBi
 B9DWsq4wSd8u1B+IaO0N5Ij3t1QkKDFKMFYEri/9t0SshLkkcE8X6INnklv22JuDJbmr
 RXxp2RWU98jlQP68V18ro6icwCmXc/tZ/MXwLo4M3dEFNIn4oz/J3STOCxAlQhN/2WE9
 cpjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyL/ZcBDEcP/GZBEbpMQX0/4bu55+d9ggZfzRrzpaNnM359SSWPKKJeMTrWKk459Fv3Ahv4ORmqftBHbfcmpLoSDSrTsJnODUr04/AgA==
X-Gm-Message-State: AOJu0Yyr6GZ9T3XuyuiS0I0hkCwamVDdpva6MhPcROvLdlk2G+XpuqrN
 RbLqbgWcn9hG7ukbEyeHxrkYDvwp9dNLPST9Au4PpVSau26uApMn9QFbe3w6uoeyZu8hi9bk6Lg
 =
X-Google-Smtp-Source: AGHT+IGc2q9edF/3OaF/uQu1Y+8LeUCQ9ClRKWxXcGjvkVzzuJhWnReCCDpk1FqhADUXh5ricUDvcA==
X-Received: by 2002:a05:6e02:1c2a:b0:375:ae6b:9d92 with SMTP id
 e9e14a558f8ab-3761d68491bmr13824855ab.12.1718754804114; 
 Tue, 18 Jun 2024 16:53:24 -0700 (PDT)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com.
 [209.85.166.170]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375d8754460sm23325785ab.63.2024.06.18.16.53.23
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 16:53:23 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id
 e9e14a558f8ab-375fc24a746so25285ab.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 16:53:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUUe3G7730/vxgHym1OOcAFwWxRmQPii6FlKB0lRh1rQ0gyVU4fMUI+a4A9OayJMa4UDlyuY0K1pxdtHXiCY+R8Bv02dSkfnHN5KrEnxA==
X-Received: by 2002:a05:622a:14cc:b0:444:9ac8:7 with SMTP id
 d75a77b69052e-444a8e53305mr1522311cf.16.1718754781471; Tue, 18 Jun 2024
 16:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240612222435.3188234-1-dianders@chromium.org>
 <20240612152752.v2.8.I27914059cc822b52db9bf72b4013b525b60e06fd@changeid>
 <CADnq5_PbqE0E2pP26mGD94cdc=tLZZsF10e7ZZWeC5AU-LS8vw@mail.gmail.com>
 <CAD=FV=XJAiVGFn_Tqs_JNo1fQKFys3m=hH9MwmMot93gkdg=Qw@mail.gmail.com>
 <CADnq5_M+H_h1Me_O3u=R3q52PgYcCwwY9Mr8_R1eX0G7HvBp2w@mail.gmail.com>
In-Reply-To: <CADnq5_M+H_h1Me_O3u=R3q52PgYcCwwY9Mr8_R1eX0G7HvBp2w@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 18 Jun 2024 16:52:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X=9PV+zbmd2S-TBBxq+yQZ2D+-cCHjFX-gm-f+DyXXiQ@mail.gmail.com>
Message-ID: <CAD=FV=X=9PV+zbmd2S-TBBxq+yQZ2D+-cCHjFX-gm-f+DyXXiQ@mail.gmail.com>
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

On Tue, Jun 18, 2024 at 3:00=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Tue, Jun 18, 2024 at 5:40=E2=80=AFPM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> >
> > On Mon, Jun 17, 2024 at 8:01=E2=80=AFAM Alex Deucher <alexdeucher@gmail=
.com> wrote:
> > >
> > > On Wed, Jun 12, 2024 at 6:37=E2=80=AFPM Douglas Anderson <dianders@ch=
romium.org> wrote:
> > > >
> > > > Based on grepping through the source code this driver appears to be
> > > > missing a call to drm_atomic_helper_shutdown() at system shutdown
> > > > time. Among other things, this means that if a panel is in use that=
 it
> > > > won't be cleanly powered off at system shutdown time.
> > > >
> > > > The fact that we should call drm_atomic_helper_shutdown() in the ca=
se
> > > > of OS shutdown/restart comes straight out of the kernel doc "driver
> > > > instance overview" in drm_drv.c.
> > > >
> > > > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > Cc: Xinhui Pan <Xinhui.Pan@amd.com>
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > > This commit is only compile-time tested.
> > > >
> > > > ...and further, I'd say that this patch is more of a plea for help
> > > > than a patch I think is actually right. I'm _fairly_ certain that
> > > > drm/amdgpu needs this call at shutdown time but the logic is a bit
> > > > hard for me to follow. I'd appreciate if anyone who actually knows
> > > > what this should look like could illuminate me, or perhaps even jus=
t
> > > > post a patch themselves!
> > >
> > > I'm not sure this patch makes sense or not.  The driver doesn't reall=
y
> > > do a formal tear down in its shutdown routine, it just quiesces the
> > > hardware.  What are the actual requirements of the shutdown function?
> > > In the past when we did a full driver tear down in shutdown, it
> > > delayed the shutdown sequence and users complained.
> >
> > The "inspiration" for this patch is to handle panels properly.
> > Specifically, panels often have several power/enable signals going to
> > them and often have requirements that these signals are powered off in
> > the proper order with the proper delays between them. While we can't
> > always do so when the system crashes / reboots in an uncontrolled way,
> > panel manufacturers / HW Engineers get upset if we don't power things
> > off properly during an orderly shutdown/reboot. When panels are
> > powered off badly it can cause garbage on the screen and, so I've been
> > told, can even cause long term damage to the panels over time.
> >
> > In Linux, some panel drivers have tried to ensure a proper poweroff of
> > the panel by handling the shutdown() call themselves. However, this is
> > ugly and panel maintainers want panel drivers to stop doing it. We
> > have removed the code doing this from most panels now [1]. Instead the
> > assumption is that the DRM modeset drivers should be calling
> > drm_atomic_helper_shutdown() which will make sure panels get an
> > orderly shutdown.
> >
> > For a lot more details, see the cover letter [2] which then contains
> > links to even more discussions about the topic.
> >
> > [1] https://lore.kernel.org/r/20240605002401.2848541-1-dianders@chromiu=
m.org
> > [2] https://lore.kernel.org/r/20240612222435.3188234-1-dianders@chromiu=
m.org
>
> I don't think it's an issue.  We quiesce the hardware as if we were
> about to suspend the system (e.g., S3).  For the display hardware we
> call drm_atomic_helper_suspend() as part of that sequence.

OK. It's no skin off my teeth and we can drop this patch if you're
convinced it's not needed. From the point of view of someone who has
no experience with this driver it seems weird to me that it would use
drm_atomic_helper_suspend() at shutdown time instead of the documented
drm_atomic_helper_shutdown(), but if it works for everyone then I'm
not gonna complain.

-Doug
