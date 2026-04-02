Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80593D39415
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 11:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0029210EDA8;
	Thu,  2 Apr 2026 11:56:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HQUPySn4";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3782310EDA8
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 11:56:41 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso6853625e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Apr 2026 04:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775131000; x=1775735800; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8YctibcwBaos343EPy20tcq2y4ZWpcBKe/QemXdR+Sw=;
 b=HQUPySn4s6og3VOgezdYBwnIKi81uytpoyxxkpmEprQvW6zLQEliiMN9mpwaE6nbtk
 5hVW8Fs6Slm1ZBsJPliatvan8abgLIaEhftG9UNPFYkZV0K8sC7P9pd2ZChk8qntVlST
 HSsuLVNUK9pkH237nJgG75RFsugIlilFpXnwNNimL0l3yxFMvEphxx+QH+9vXhJNgs42
 d4ocdEupaKlRFS+suy1QCuVeZbPD3I6MrLrSdlwli5xu3VWKEQOSWUGutKHY68Wn4JoI
 6UpC4dJRQZLcV7WWQitfUsdce72AYoxSS1epAlsoCaFXOv1o4mNvbvwtq+COW9kgGLEC
 jD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775131000; x=1775735800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8YctibcwBaos343EPy20tcq2y4ZWpcBKe/QemXdR+Sw=;
 b=ARfL1HO8JKcb3GkuyeDERD0Yo0ko+UWv3bYKfLOp2Rn3vWdyJZAZQvJtxRxuuc7/u+
 H0fznP3GPbTUjdbWZeU+kI0Z3Q4EmTDxHTDs7pnZG1Sls4KlNNuCmnTQv/9K5VyBHTDL
 UAA6jfoCsr0iWJir4poZzisRmUWi8GWPbIgoRJoJvT4Bw2qoKX4KcP/a/SlDHSM1QyWg
 ulKF7Wdx+gMHHFSOc7BIRPznOsWXdPFvplMxOFCrFA8jgdWbzsfENJBbZlB9t4y2zZ60
 HJzxdkeZkL0Q5SymhvRnAvqEhsUX4ZOTK5RzwhoOyLNSHOrW0fe9hXJUeIOGJjwbDD3l
 IBdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWddnw226jXSHRvLgNGx1KvMUgoHktJ/LSgwvVK5HjtOGj2N9cxVuZ04IF6E8XLIkV+NL/OIR79@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1rIKUEdaZdrOqlodEBj6nHxdJIFbWJAiXU1QcI3trdTw//qni
 UzE8BcgpoJQPEk/LdIBuJisrAroN2nyLnWB2Py7RgbJMlHxZE9oVegRy
X-Gm-Gg: ATEYQzx1V4D5dzP7DsKaFy0J46M87INXb6IbU1Mvviti3xsLzziL3KnKfOLGRWB3fQc
 Iu4cvuFU7f3SkLxgGNoA6Nv84U0pI+DScDpiRBOOkiX7FS245hYk+ldZCo4K5Lmb8U921pnhO1J
 NQ4BHITuZRfBIdv93rVviZVroQX6ebSCZUT/erNkzqmzAFiLc7JGUSsRT3H3GAMm6pUXFd+eyS9
 LYgvoMi51vyhVdXbZlbAzAZ2I76tVkE9hbMcuB0dIHIq3flPeAUwduVdqD/RxNJdSUZaz/zlzff
 6XFE1F8reJP7zSST5kJ2O+HSzWNk5DpDGQP31CBRLtiXEhH1vqa1daLn3c19CAch1OUYk26UfNz
 8mW14BCLKXwG6+pP8tv+WQLRa78j9AaCgi5IfcZ5JiX69ICG6aoLGhMzZCDVuNJI0UKDNOAaGRD
 6Zr7j3EtxTnZH9kiwbccQFLRfWG6s6WU2s5BRZkj1wDSLmkGcbeCGnJ8TXi1FWsoA8tjYNBDCW
X-Received: by 2002:a05:600c:8209:b0:485:5c6e:8a38 with SMTP id
 5b1f17b1804b1-48883591d6amr141270405e9.17.1775130999396; 
 Thu, 02 Apr 2026 04:56:39 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1BC26F.dsl.pool.telekom.hu.
 [94.27.194.111]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a65635fsm65554775e9.6.2026.04.02.04.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 04:56:38 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Rosen Penev <rosenp@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, 
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Bin Lan <bin.lan.cn@windriver.com>, He Zhe <zhe.he@windriver.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for 6.12 3/9] drm/amd/display: Disable fastboot on DCE 6
 too
Date: Thu, 02 Apr 2026 13:56:35 +0200
Message-ID: <2257770.9o76ZdvQCi@timur-hyperion>
In-Reply-To: <2026033157-trifocals-swerve-d18f@gregkh>
References: <20260326234716.16723-1-rosenp@gmail.com>
 <CAKxU2N-CRua=kMVm8gdf2AnbCFyLsLTbf=-9NZHAkhL3sJC-tw@mail.gmail.com>
 <2026033157-trifocals-swerve-d18f@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Tuesday, March 31, 2026 1:03:34=E2=80=AFPM Central European Summer Time =
Greg Kroah-
Hartman wrote:
> On Mon, Mar 30, 2026 at 02:38:35PM -0700, Rosen Penev wrote:
> > On Mon, Mar 30, 2026 at 7:21=E2=80=AFAM Timur Krist=C3=B3f <timur.krist=
of@gmail.com>=20
wrote:
> > > On Monday, March 30, 2026 3:55:55=E2=80=AFPM Central European Summer =
Time
> > > Christian
> > >=20
> > > K=C3=B6nig wrote:
> > > > On 3/30/26 15:16, Timur Krist=C3=B3f wrote:
> > > > > On Friday, March 27, 2026 12:47:10=E2=80=AFAM Central European Su=
mmer Time
> > > > > Rosen
> > > > > Penev>
> > > > >=20
> > > > > wrote:
> > > > >> From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > >>=20
> > > > >> [ Upstream commit 7495962cbceb967e095233a5673ea71f3bcdee7e ]
> > > > >>=20
> > > > >> It already didn't work on DCE 8,
> > > > >> so there is no reason to assume it would on DCE 6.
> > > > >>=20
> > > > >> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > >> Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
> > > > >> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > > > >> Reviewed-by: Alex Hung <alex.hung@amd.com>
> > > > >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > >> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > > >=20
> > > > > This patch is incorrect and should not be backported.
> > > > >=20
> > > > > (Note that the error is already fixed upstream. For stable kernels
> > > > > IMO
> > > > > it's
> > > > > best to drop this one.)
> > > >=20
> > > > Is there some alternative which needs to be backported or should the
> > > > old
> > > > kernel just work out of the box because we never enabled some featu=
re
> > > > there?
> > > >=20
> > > > Apart from that the patch set looks good to me.
> > >=20
> > > This patch had a typo and does the opposite of what it should, ie. it
> > > disables eDP fastboot on DCE10 and newer instead of disabling it on
> > > DCE8 and older.
> > >=20
> > > The upstream fix is here:
> > > https://lists.freedesktop.org/archives/amd-gfx/2026-February/138577.h=
tml
> > > which disables eDP fastboot on DCE10 and older.
> >=20
> > Not sure what the process is here. I make sure everything can be git
> > cherry-pick ed. In that case, both should be present.
>=20
> I agree, I don't understand the problem here.  Just take the commits
> that are upstream including "fixes for the fixes".
>=20
> Timur, what specifically do you want to see happen here?

Hi Greg,

It's up to you how you prefer to address this. I just wanted to call Rosen'=
s=20
attention to the above issue to avoid regressing the stable kernels.
I'm happy with either dropping the patch or backporting the patch together=
=20
with its fix.

Thanks,
Timur


