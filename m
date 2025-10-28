Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C1FCCF9E0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 15:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6D7910E5F0;
	Tue, 28 Oct 2025 15:30:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R830riAp";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B855E10E5F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 15:30:20 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-29245cb814cso13009565ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 08:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761665420; x=1762270220; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GU545h0UxlVJamlV0/7LOnQgXwKoelV+QGdHxwAxcNA=;
 b=R830riApsJqx7dKmEP0vOE0u//DLosbAYMrmjXMSSaX2yqmRO222wqJSEybt7I7JvB
 mornCjq64jfMkCwW2XrfQH7um4vA9swDigroEilnr008gMpjjVtRFgvPKy4wyhZkOUgg
 l3zMRvBV1AdHoWeg7+kzcRdxsG8BTxSa4IRLyJsEs9Ader9f1Er1NQjY+YEr6bYTUjH4
 hWgsAskCYAUXtkpRhLaXdslyeYoNCq2oNWPN/YRnO9L5sg/E1BFZ7PGJCcvCLNLyARiG
 7864+AgIP6MDgFbHP0yTv49tS002zqYO54yI6k/mEepLFVQE7J6eSpUGu1wUYAulXMkB
 3sTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761665420; x=1762270220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GU545h0UxlVJamlV0/7LOnQgXwKoelV+QGdHxwAxcNA=;
 b=fVQltNAhM6IH9YOua1Ao/1i+8OvhVKQQTck2czCNGWlUZcovie/fj9ru3FQVfE9E5/
 8lqU7ZPijmbthpLEiVpMX7/WARP6l+5feVIsdJ5M2ZkdLUP8UJuBVlbmf62LP0eXK9xS
 P2aLX6anyz7IN28YIWyrdC0YmVBFu/3tQfG9eObYhTPtIRKwVphhXQaSt4hIakqsptkk
 z1vzDbBpmBi3Gh74sskxp0w08TdaiHTx9LW7Tz3w2BvzrrcMbITmvHyh2xo6QRZqO0w8
 S3eAxoMyH1Zrc6OPShV8vKW5z94yCW8RL2yn3rkOY+SNTVCgcho5pWSqcNNg2vy73Fl8
 gPiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUINqDlEEIZnlghTCeoft846bzEI6GjFpbi2fcnBTFtncQWH+nPfEQTG4ORfwnbM1IjAF+56QNK@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxucsJvk8T3R6G7ggf2iTfzMsWzUiDFxe6LKVzxQg1pAwNrw0xt
 4gu4ZXgR/1FTfzrOhgMP2m0YuaJqX4s43RcqNgIoRREbwDMgKj/BTL465kLzS/FiTd/KsXww5W3
 5kAGOJPeHVG5r4dbMfo8nq4F1doGgMqM=
X-Gm-Gg: ASbGncsZXjjfAUedplBVlU9vMQzpJzaP9UzrIE4oEZ7Ijkf9VI0qeq2nFuG9jCO+05P
 nBOTcvCXc6gC/8bW8OUUVVc6xPSU8oUcEa2oLGRKtZdkHVTrsanJpEkJzj6z38cgUhfHYrDz+Vc
 T8zpIJYA76h7EEpUUPKZ6UROZ2wsGu+fmJo8oq+WZ+jomy31u+UrVQSuoCN7mmVgRz/Mtua+xS4
 V5sC9peEn2yRdnJDcE09mA3PsRbJeTISqIFQ62OHOWAy1rG0WYzOftA/t3RhZfVdZdoCJg=
X-Google-Smtp-Source: AGHT+IH1NwzGJN2z+on5azvAQa1FpSSlFCFhj4kyylslIqUi4Y52PNSsLYzjUWQOuPPOI6wCUuiAXNWbucUTHtnJIGk=
X-Received: by 2002:a17:903:2305:b0:275:c066:33dd with SMTP id
 d9443c01a7336-294cb511248mr24557615ad.10.1761665419571; Tue, 28 Oct 2025
 08:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20251027131440.392052-1-sakari.ailus@linux.intel.com>
 <BL1PR12MB514490DCB870F296D1554C14F7FCA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <aP_fiCX8Cli2KL7s@kekkonen.localdomain>
In-Reply-To: <aP_fiCX8Cli2KL7s@kekkonen.localdomain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Oct 2025 11:30:07 -0400
X-Gm-Features: AWmQ_bkm5HQ45hrCvDDX3GYRAHA6_LouxAkr9B3CFX_zUGIW50pl-J-PIvTWgDI
Message-ID: <CADnq5_Pic5fsaG9WyxdNH2W0Cm1A5ZZjVqfjLnYza2Bt1EzfoA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amd: Remove redundant pm_runtime_mark_last_busy()
 calls
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, 
 "Feng, Kenneth" <Kenneth.Feng@amd.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, 
 Antonio Quartulli <antonio@mandelbit.com>, "Nirujogi,
 Pratap" <Pratap.Nirujogi@amd.com>, 
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Wang,
 Yang(Kevin)" <KevinYang.Wang@amd.com>, 
 "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, 
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>, 
 Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, 
 Liao Yuanhong <liaoyuanhong@vivo.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 "Liang, Prike" <Prike.Liang@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>, 
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, 
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Xie, Patrick" <Gangliang.Xie@amd.com>, 
 "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "Skvortsov,
 Victor" <Victor.Skvortsov@amd.com>, 
 "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, Dave Airlie <airlied@redhat.com>,
 Jani Nikula <jani.nikula@intel.com>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Imre Deak <imre.deak@intel.com>,
 Ben Skeggs <bskeggs@nvidia.com>, 
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Mon, Oct 27, 2025 at 5:16=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Alexander,
>
> On Mon, Oct 27, 2025 at 03:52:28PM +0000, Deucher, Alexander wrote:
> > [Public]
> >
> > > -----Original Message-----
> > > From: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > Sent: Monday, October 27, 2025 9:15 AM
> > > To: dri-devel@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > > <Christian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona =
Vetter
> > > <simona@ffwll.ch>; Kuehling, Felix <Felix.Kuehling@amd.com>; Feng, Ke=
nneth
> > > <Kenneth.Feng@amd.com>; Lyude Paul <lyude@redhat.com>; Danilo Krummri=
ch
> > > <dakr@kernel.org>; Maarten Lankhorst <maarten.lankhorst@linux.intel.c=
om>;
> > > Maxime Ripard <mripard@kernel.org>; Thomas Zimmermann
> > > <tzimmermann@suse.de>; Limonciello, Mario <Mario.Limonciello@amd.com>=
;
> > > Hung, Alex <Alex.Hung@amd.com>; Antonio Quartulli <antonio@mandelbit.=
com>;
> > > Nirujogi, Pratap <Pratap.Nirujogi@amd.com>; Lazar, Lijo <Lijo.Lazar@a=
md.com>;
> > > Dmitry Baryshkov <lumag@kernel.org>; SHANMUGAM, SRINIVASAN
> > > <SRINIVASAN.SHANMUGAM@amd.com>; Wang, Yang(Kevin)
> > > <KevinYang.Wang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Zhang=
,
> > > Jesse(Jie) <Jesse.Zhang@amd.com>; Ville Syrj=C3=A4l=C3=A4 <ville.syrj=
ala@linux.intel.com>;
> > > Liviu Dudau <liviu.dudau@arm.com>; Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>; Zhang, Hawking
> > > <Hawking.Zhang@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Ar=
nd
> > > Bergmann <arnd@arndb.de>; Thomas Gleixner <tglx@linutronix.de>; Ingo =
Molnar
> > > <mingo@kernel.org>; Liao Yuanhong <liaoyuanhong@vivo.com>; Rodrigo Si=
queira
> > > <siqueira@igalia.com>; Liang, Prike <Prike.Liang@amd.com>; Sharma, Sh=
ashank
> > > <Shashank.Sharma@amd.com>; Paneer Selvam, Arunpravin
> > > <Arunpravin.PaneerSelvam@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;
> > > Chai, Thomas <YiPeng.Chai@amd.com>; Xie, Patrick <Gangliang.Xie@amd.c=
om>;
> > > Liu, Xiang(Dean) <Xiang.Liu@amd.com>; Skvortsov, Victor
> > > <Victor.Skvortsov@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>; Dave
> > > Airlie <airlied@redhat.com>; Jani Nikula <jani.nikula@intel.com>; Gus=
tavo A. R.
> > > Silva <gustavoars@kernel.org>; Imre Deak <imre.deak@intel.com>; Ben S=
keggs
> > > <bskeggs@nvidia.com>; nouveau@lists.freedesktop.org; amd-
> > > gfx@lists.freedesktop.org
> > > Subject: [PATCH 1/3] drm/amd: Remove redundant pm_runtime_mark_last_b=
usy()
> > > calls
> > >
> > > pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> > > pm_runtime_autosuspend() and pm_request_autosuspend() now include a c=
all to
> > > pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call t=
o
> > > pm_runtime_mark_last_busy().
> >
> >
> > Typo: should be "now-redundant"
>
> Oops. You're first one to notice, in fact.
>
> >
> > >
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> >
> > Patches 1, 3 are:
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > When did mark_last_busy get pulled into the other runtime_pm functions?
> > Did you want me to pick these up or did you want to send them via some
> > other tree?
>
> Yes, please merge these.

Applied.  Thanks!

Alex

>
> pm_runtime_mark_last_busy() has been part of autosuspend related function=
s
> since commit 18c1fe53d186867243f4cf17f4eef60737a16c4c, i.e. v6.17.
>
> --
> Kind regards,
>
> Sakari Ailus
