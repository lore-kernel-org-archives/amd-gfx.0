Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45348CCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 16:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB86D10EAA0;
	Thu,  9 Oct 2025 16:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hu6VVlc0";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BD0C10EAA0
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 16:09:15 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3327130c135so224709a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 09:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760026155; x=1760630955; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X/YU9FqU1HAlsM6VH5zC+NX4UIz5WrVVLhyB6grbNu4=;
 b=hu6VVlc0UsyBms38WWG5zzuw0iHmlnYJfZDJsO6+D2ckbyGiBnfTjZWY2RPmTTw4bA
 ueOE6qaO6XRyo6njILRYfmvk0oGSwF95dcp53wL6GziS8LsUthyROSeZVZEAI5O5cCcH
 yH1Hn3v3K+6DPzZWwQhLUY2lhE0pWaS2UkyuH7jgLEmlVwmKlue6oDIc42Z+7sPUr1q9
 o1SpdM3yCTQwSbPGN9XUlj8xutYkh5Mgz5f3KstoquG5d5jH4300/q5J+h1u48FK+ixY
 lSpQYwPjZ+hrOpafI2cV0AUwJPskRFAJhFYLm0cBsNmSdEih6qlhqXX3CVDrDhIk9z8r
 HYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760026155; x=1760630955;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X/YU9FqU1HAlsM6VH5zC+NX4UIz5WrVVLhyB6grbNu4=;
 b=ahG0WybC0iby+mj5OdQHttl9iFxTcfBh46ljflLFdm4wl105BztDKCMRamqux2CIbb
 PCvmXx+dy4WQqawEcJQA/TXkfwmqJI6jO+B7lOLf6t1atzX5z5Ziw4lEdApfA2jB6xWk
 IC2NGZLjfM0sWY0D5AeC9nJ2/nquHeZw23XcGgffGM/B0SaWc9/7U0239K0QEA8CjtDH
 XNas0/8afrHrOjhH67pa2crQtVxjvfylQnZxVtHu2lHPj6+p05dz1rw655fknYa6o06p
 60zVh6zcNsSPNMhVfxHiXwgcMEbUZpvL5Q+pjOGq0dH4dumRt3GeAw1MFrEV3UdSG28s
 ZZHQ==
X-Gm-Message-State: AOJu0YyL/YJrycphDMlhPnKjngGIl9wnK8tr+Sm44jAVHuRUtjhzb4HM
 NDWeQbn/YpoQgZ+0MqWRSOEWkej+tUzcVL+a0tiz95N+3aD2/4YumQLbXQGEnAqY6TQgas6ceXX
 LHQNeFb3BeVmCeaZRmSMBC3xIpS7rBRQ=
X-Gm-Gg: ASbGncv7OSxG3F22Ii7kzLWKdfTDkbCiJUqGDuHjtpE3epb6S0ujqDsYACNQyVAklW8
 4UAqWCnEakuVZ91bKUpzJX7kvxF2rYVCcSTUQGXNvhdWW8G53gX83qXaYHn6bUmMUrdEeZbLPMD
 sGZL7BbMfojAJzawVCCSDrPM9dv0FTZCMHgH9da6TYgi8Zg/UdZUyaqSZ5124me0Pg4WbN0AU8D
 IFJWgckruQSb+wGhNXEfdqlZAwRnK0=
X-Google-Smtp-Source: AGHT+IGjiTsgApzGwwlozEKE30PAN3B+vjyKOWhUq5alFOsVHL1hTYXMeSCVnMp+2d0DheztFOe9AHLo8DVHYEKl8BE=
X-Received: by 2002:a17:903:1a70:b0:27e:f02a:b280 with SMTP id
 d9443c01a7336-290273f3955mr52958225ad.5.1760026154258; Thu, 09 Oct 2025
 09:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20251008164408.850834-1-jonathan.kim@amd.com>
 <CADnq5_M_Rk9KX_5Vw+3pxPfrReKqhtF5rn+1P2LidFSJ5y7Wzw@mail.gmail.com>
 <CY8PR12MB74354BE47029963B8FEDCD4385E1A@CY8PR12MB7435.namprd12.prod.outlook.com>
 <CADnq5_PLCEEVbk4ufSnQyqzmW32iBccpk5EXf7kPwdp5=Lpo-Q@mail.gmail.com>
 <CY8PR12MB74358D5E7438A3FF6F7C873185E1A@CY8PR12MB7435.namprd12.prod.outlook.com>
 <CADnq5_OwEwRhf17gqkpEwoPd_znuuLR3KL+5JqZo8JBxqYAAWg@mail.gmail.com>
 <CY8PR12MB7435ED1163C7C08FE91D60E985EEA@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7435ED1163C7C08FE91D60E985EEA@CY8PR12MB7435.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Oct 2025 12:09:02 -0400
X-Gm-Features: AS18NWDi0XZKf5F50pJ7UwmvGyr2qVLUdexgPX3-mjMDhDATmSJD_-c-SaUJQDI
Message-ID: <CADnq5_Nuof3jSSZu72YieSKpgdTJ-xd=uG5UW4U37Bb903poow@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status check
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>
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

Thanks for checking.

Alex

On Thu, Oct 9, 2025 at 9:55=E2=80=AFAM Kim, Jonathan <Jonathan.Kim@amd.com>=
 wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Wednesday, October 8, 2025 4:16 PM
> > To: Kim, Jonathan <Jonathan.Kim@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Liu, Shaoyun <Shaoyun.Liu@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status=
 check
> >
> > On Wed, Oct 8, 2025 at 4:12=E2=80=AFPM Kim, Jonathan <Jonathan.Kim@amd.=
com>
> > wrote:
> > >
> > > [Public]
> > >
> > > > -----Original Message-----
> > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > Sent: Wednesday, October 8, 2025 1:46 PM
> > > > To: Kim, Jonathan <Jonathan.Kim@amd.com>
> > > > Cc: amd-gfx@lists.freedesktop.org; Liu, Shaoyun <Shaoyun.Liu@amd.co=
m>
> > > > Subject: Re: [PATCH] drm/amdgpu: fix gfx12 mes packet submission st=
atus
> > check
> > > >
> > > > On Wed, Oct 8, 2025 at 1:27=E2=80=AFPM Kim, Jonathan <Jonathan.Kim@=
amd.com>
> > > > wrote:
> > > > >
> > > > > [Public]
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > > > Sent: Wednesday, October 8, 2025 1:12 PM
> > > > > > To: Kim, Jonathan <Jonathan.Kim@amd.com>
> > > > > > Cc: amd-gfx@lists.freedesktop.org; Liu, Shaoyun
> > <Shaoyun.Liu@amd.com>
> > > > > > Subject: Re: [PATCH] drm/amdgpu: fix gfx12 mes packet submissio=
n status
> > > > check
> > > > > >
> > > > > > On Wed, Oct 8, 2025 at 12:51=E2=80=AFPM Jonathan Kim
> > <jonathan.kim@amd.com>
> > > > > > wrote:
> > > > > > >
> > > > > > > The driver currently only checks that the MES packet submissi=
on fence
> > > > > > > did not timeout but does not actually check if the fence retu=
rn status
> > > > > > > matches the expected completion value it passed to MES prior =
to
> > > > > > > submission.
> > > > > > >
> > > > > > > For example, this can result in REMOVE_QUEUE requests returni=
ng
> > success
> > > > > > > to the driver when the queue actually failed to preempt.
> > > > > > >
> > > > > > > Fix this by having the driver actually compare the completion=
 status
> > > > > > > value to the expected success value.
> > > > > >
> > > > > > This should be correct as is:
> > > > > >
> > > > > > *status_ptr =3D 0;
> > > > >
> > > > > That's not what I'm observing at the moment.
> > > > > amdgpu_fence_wait_polling can still return fine where status_ptr =
!=3D 0 nor 1.
> > > > > From what I've been told, only 0x1 =3D=3D success (the completion=
 fence value
> > > > passed to MES).
> > > > > Shaoyun can probably elaborate or correct me if I'm wrong.
> > > > > It's pretty easy for me to put the HW in a bad state (dangling qu=
eues post
> > > > remove) without the driver knowing in its current state.
> > > >
> > > > 1 is just what the driver puts as the fence value to write:
> > > > api_status->api_completion_fence_value =3D 1;
> > > > and the memory location is initialized to 0:
> > > > *status_ptr =3D 0;
> > > > The firmware should either write 1 or nothing, writing a random val=
ue
> > > > in there looks like memory corruption or a firmware bug.  If it
> > > > doesn't write the fence, the driver can assume the operation failed=
.
> > > > If it writes random values, then we have no idea what's going on.
> > >
> > > FW writes high 32 bits to status_ptr for debug codes if low bits is 0=
.
> > > So we should probably only check the 32 lower bits then.
> >
> > Thanks for clearing this up.  Please check if mes_v11 needs a similar f=
ix.
>
> Looks like GFX11 is fine the way it is.
> The hi/lo bit split in the status return only affects GFX12.
>
> Jon
>
> >
> > Alex
> >
> > >
> > > Jon
> > >
> > > >
> > > > Alex
> > > >
> > > > >
> > > > > Jon
> > > > >
> > > > > > ...
> > > > > > api_status->api_completion_fence_value =3D 1;
> > > > > > ...
> > > > > > if (r < 1 || !*status_ptr) {
> > > > > >
> > > > > > Alex
> > > > > >
> > > > > > >
> > > > > > > Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 3 +--
> > > > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > > > > > b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > > > > > > index aff06f06aeee..58f61170cf85 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > > > > > > @@ -228,8 +228,7 @@ static int
> > > > > > mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes=
,
> > > > > > >                         pipe, x_pkt->header.opcode);
> > > > > > >
> > > > > > >         r =3D amdgpu_fence_wait_polling(ring, seq, timeout);
> > > > > > > -       if (r < 1 || !*status_ptr) {
> > > > > > > -
> > > > > > > +       if (r < 1 || *status_ptr !=3D api_status->api_complet=
ion_fence_value)
> > {
> > > > > > >                 if (misc_op_str)
> > > > > > >                         dev_err(adev->dev, "MES(%d) failed to=
 respond to msg=3D%s
> > > > > > (%s)\n",
> > > > > > >                                 pipe, op_str, misc_op_str);
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >
