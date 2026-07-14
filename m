Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282F4C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 13:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABF9910E081;
	Tue, 14 Jul 2026 13:51:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eQhnI9g1";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F18710E081
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 13:51:45 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2cc7a269ca1so9534845ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 06:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784037105; cv=none;
 d=google.com; s=arc-20260327;
 b=WZ4enIDIFF2WsdvmjSeoWNxSDSVu6UBNcOnitatMrhG4Z7yllQrYsd7iA5Jwgwdwm1
 8Mm/pSPnudNqzjY8OEljwpxaIbQh7RP2qFluzKR9qsQY1EkYWej8xjv8w/3t39lB6Pk5
 zTOJj305DbflJLz/avZWyhCe8hMfAKFvMvhScXfrFMKX+vXsBJJV5T07hRdzUSebvR5g
 II1h7vBk3v0J/XUflbiX06WQ7uNGtDa65hLNygGHpw1yZMpT3FeS+cpEN4b5q3tfeYXR
 ADHjogIInit43G2RwrJhGxWdJqDsfxWUoXFAFByeS+7zPMt5seGXmAkHakZmJGVZRDjo
 ViVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BBlwPW3Chv3OZQWF7upXVPR9tBQmUVwhWiJsztQtsMM=;
 fh=7APGDQfHPJPqBJAU5I6RPihyHWyjyasdvHchQr/UQGc=;
 b=piuLq4BegkeeBBU1jAH4b7KRr5YGRF9FvYfIWS1e9vTOakBaD8t6MkNo2VNfLXCB/e
 U/Ma3moQhhVizrOjUBRDMV8SHt/YG05VWJb0dFpnR2WBvDbk5dbGJuoBMyluGbz9DpLO
 TMkMp1oUvRk9FMmh5cK0p5xjsFA1OpVarazgL41LEAeuOBwYuUBXxRjvY8/y7m0Dw+F4
 XFe/fDtDgSglou3evwdfYOjupxltm5qo1N7zbiK4seVGkCNSRLFdg8GzQlOPnKy3nWeI
 rrEpKg8wG801ClUM4An5f+VP/9s0RR06nzWXayS459IW0tw8E5a2XbhhW9xKuvSXwifS
 t/Fw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784037105; x=1784641905; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BBlwPW3Chv3OZQWF7upXVPR9tBQmUVwhWiJsztQtsMM=;
 b=eQhnI9g17ScRWShwG0LnvXRWEm9V2AFHMkeaBc9aNl+CIjijx8vNMoU/S5XDRN/lEN
 15m3WVaGkGXlBM/5u4IcNccwmS0E0vBaMmlWuYcr01TYB9CMJvzn4P2xGi5CYeM6P9n4
 HedSSZRGkwissaWNM41qA5QUF6RlBA4c1uPyPMA6KKp2rpWR2yIlqf/rkYBrHkfwfMEA
 ROn0R1tKH2iF4heAxeQqWki7L+L1Ydka3frDZMXE3dua7QPJyeIZ7LW4391LGUf8G+SX
 t07S4BoulSTYHLSIiSJDujpQkw+LoOlOw5TKLduPnk0svsj/ZffNDFtZ/8InFXk7noh5
 26sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784037105; x=1784641905;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BBlwPW3Chv3OZQWF7upXVPR9tBQmUVwhWiJsztQtsMM=;
 b=lmq5XxoYeOgiFWJSrTCcPWTXOwL3v1CylB7wqbijmocHUukm05Bc0OfuA0P7BwGJUX
 cSCxl8U5aRBnscwHDxLAt6aUtibOHmJ3+gVsHIBGeGjPfLIRNEsQvqn5ao8q2IVV8ruo
 OjZWkj8kRk7KVZl9b+TeQABKMLEq+umoofjVszZtvkxsdfxyCuNcXgvWGnTcWbqpD0Q0
 lGgjyQ/RtIaDcdx1gfJHQxYc962OcgsStiPwAYhsle7mMloAJBTfePQ3y5t1lDJjDw/V
 mLSO9IGQ4XFZRKWXtycCqSdncie7vBOpHV2VfT9TgQWH0iEBeE2fZ0/ym/pOq97VOA3U
 EQsw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrq09T0luy0qL+ahrsrl5S0swvs85M1H/rozPvh0BHvbPyy0Io4xDiWsZ0Gl2SYCSjZQ8ydk1uM@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYonCSHqAax+iA/ufQ03NA/3gY6V82sRZwInDpQWhPXCOrCsq6
 rgNdZFwrkeSBUnu0EX/wv2nRbSz97f5MCjyvm13jJcqLhYE2SuYvOEHvtyIJOT3Biy1SJwwgfyC
 H8nmIM1gM7ZyinDTo7vWJy+B1sPQGS+Y=
X-Gm-Gg: AfdE7cmNQ2pK77sgYf8hu56RIVwli2X+W+oZRtIROcl76k0562rFlFT/cbyyDcrsnPx
 h91RpSiXPPeGDJAuaMudopIzLG6lIHjDDNxgnAH65BV7Y518VId05USBEvIaDXboruNhyvmn+wn
 Bt9fBcxw0WQbGpo+n7c69EV7ps1pLQx27K/qwbZnaMDyaT2cwDrFQIeSvMhVGB5DnATvXs/Vvhm
 XdIpFil3QB0a/P7RKtj5KUuQ5IucRZwjXPFr9t5Ft4nCTrNVUviAk/gkwl9zONXbPx+U9Vz/qj7
 70mJeFZnUKgXRpY4gjse72tf+MOXeg89X19XplJn9KAgxQfT6s7EEGqqylI=
X-Received: by 2002:a17:902:ebc8:b0:2cc:9d9:b8df with SMTP id
 d9443c01a7336-2ce9f187200mr107627315ad.5.1784037105198; Tue, 14 Jul 2026
 06:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260713203850.650426-1-alexander.deucher@amd.com>
 <DS7PR12MB600589F9C41083DA5506725BFBF92@DS7PR12MB6005.namprd12.prod.outlook.com>
 <DS7PR12MB6005FB0DF535C58EAA3DC93BFBF92@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005FB0DF535C58EAA3DC93BFBF92@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jul 2026 09:51:33 -0400
X-Gm-Features: AUfX_mxuSif4U3ZjRNnCt53jXx4VLHJHMQ4X_k69TENsf4C0VXejVA3wzy46omY
Message-ID: <CADnq5_NtsmdSgmzJrFcv4dCaBdDwAoWEZ2RrRQgGdXqaXGOd_w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: properly account for resets
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Khatri,
 Sunil" <Sunil.Khatri@amd.com>
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

On Tue, Jul 14, 2026 at 3:44=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> AMD General
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Liang, Prike
> > Sent: Tuesday, July 14, 2026 10:49 AM
> > To: 'Alex Deucher' <alexander.deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,
> > SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Khatri, Sunil
> > <Sunil.Khatri@amd.com>
> > Subject: RE: [PATCH] drm/amdgpu/userq: properly account for resets
> >
> >
> >
> > Regards,
> >       Prike
> >
> > > -----Original Message-----
> > > From: Alex Deucher <alexander.deucher@amd.com>
> > > Sent: Tuesday, July 14, 2026 4:39 AM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,
> > > SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Liang, Prike
> > > <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> > > Subject: [PATCH] drm/amdgpu/userq: properly account for resets
> > >
> > > We need to increment the reset counter, force fence completion, and
> > > set the wedged event when a user queue is reset.
> > >
> > > mes_userq_reset_queue() handles this for collateral damage, but the
> > > caller needs to handle this directly for the original guilty queue.
> > >
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> > > Cc: Prike Liang <Prike.Liang@amd.com>
> > > Cc: Sunil Khatri <sunil.khatri@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > index 6aa75da27f912..5e1262636e1e9 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > @@ -146,8 +146,13 @@ static void amdgpu_userq_hang_detect_work(struct
> > > work_struct *work)
> > >                                                      queue, NULL, NUL=
L);
> > >             else
> > >                     r =3D userq_funcs->reset(queue);
> > > -           if (r)
> > > +           if (r) {
> > >                     gpu_reset =3D true;
> > > +           } else {
> > > +                   atomic_inc(&adev->gpu_reset_counter);
> > > +                   amdgpu_userq_fence_driver_force_completion(queue)=
;
> > > +                   drm_dev_wedged_event(adev_to_drm(adev),
> > > DRM_WEDGE_RECOVERY_NONE, NULL);
> >
> > If we do the userq reset post similar process here just like as
> > mes_userq_reset_queue(), so do we need to clear the duplicate the code =
in the
> > mes_userq_reset_queue()? Otherwise, the gpu reset counter should be inc=
orrect.
> > Except that, we might input the wedge task info to report the guilty pr=
ocess info.
>
> As to the first question, I recheck the code and found out the guilty use=
r queue in the amdgpu_gfx_reset_mes_compute() was reset separately before  =
mes_userq_reset_queue(), with this current reset sequence then this change =
it make sense to update reset counter and  force complete fence.
>
> But why need to reset the original guilty queue separately, should this g=
uilty queue was found by the amdgpu_mes_detect_and_reset_hung_queues() in t=
he MES firmware? If so, we may need to reset the guilty queue through mes_u=
serq_reset_queue() rather than reset separately, then we don't need to add =
this change anymore.

We still need it for gfx and sdma queues.  Those don't get reset via
amdgpu_gfx_reset_mes_compute(),

Alex

>
> >
> > > +           }
> > >     } else {
> > >             gpu_reset =3D true;
> > >     }
> > > --
> > > 2.55.0
>
