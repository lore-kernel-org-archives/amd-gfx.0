Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59346C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 17:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0170710E590;
	Mon,  4 Aug 2025 17:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XfWpdUsD";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38C3410E590
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 17:33:13 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-312a806f002so788616a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 10:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754328793; x=1754933593; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jwAPZHrC2rwiSzQCsog4yhiPTt9auLjeEqv7vbKdAkU=;
 b=XfWpdUsDWadGFdoRSKOteAZAybX5J/PFv+mgf0WUbkPJ14oUYLxjBs+GqbhfCkwVvY
 dfDUiyp+nay3d0tfxoEGRqMSMP6kaUyazzKIi/JQUymGlRK5+UiJGKyMw0jX34azJlKD
 l5HwPduJcWXJIygRZqSoGst9y6VtxLk3AUQTGfuYjt3Gr+JT/0RSIt0zdXOTWK/UoeWe
 V4CGqwkJY7nuzHrUtXD9PqB1tarhpnoPfzBhQJXT85oOqrVvmmwHnzHoYfuBxShjb6y7
 +/QwUv7ZwVHnJHZVYrnD3MtTOw/D3TfybZNgy33NTPIxDXQ/jyczflEqnePJqFApAeiw
 bjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754328793; x=1754933593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jwAPZHrC2rwiSzQCsog4yhiPTt9auLjeEqv7vbKdAkU=;
 b=A1Dt/11AVJmP3zeOY3rx2OJvtvNk/7vzj8UWaJ6YTb6GEqTNjecTdu6RhK55k+T+mH
 cdGnDA3fB0D+4PODSOSldw7bwwp7e2ioGZ+078eo2HIXv3hP59SmYu+7bALvRZg3HnGx
 fnlNYbzrxBHu0w6RRsGBjruZCodNtd5jjfLtdfSdVpy7VDWbj87Ko9I8pXwtPdV4pm90
 h5TBn1S+gB681IJl9MLjl0msuIHs3qYdkgUeHdK9Il3bk3dm1mBdvZd1vaVMHGT+/G7J
 VLt4B6wxZ9QKIVK2c7u8CdS57yUhadRE6lL8XCEIcckD72ridhT5YJjzheSbK3oLXWeC
 btWg==
X-Gm-Message-State: AOJu0YxbvUMfOTV0+aIfyX/DOHn6wyBHfBjNdEDPUnoBNmNw0kXbVXB/
 oEncr9tObcdi8WTxxSecgMsoinOdO+knBywnzNLijgpBvJACeluy7GXYtRgbaqso5Y/CTYGaVAl
 yCiPQv0vcg8Q/61JzABn6MIp1Wz87ENmvWg==
X-Gm-Gg: ASbGncux4UfFkYOoKpYVUy1he61/9PinD4n1vyLrD47NX0VyoF6lym4aKmcwe+9ihfe
 WIysE9iwBoRXVaamgSmoKSkGFFzYgagyaRRhMm/CqFl4jXdD6Rg6sPXfYu3q6pD8n47dgqo26n+
 dgI+z31igqZqeSsD0E6cncv9hQvEbRCrQps19CGg12Lmy1ciST+vnW5WljwPUqMuea+GGqsCJ4K
 Zh8NQWP
X-Google-Smtp-Source: AGHT+IG+sfTX+c31jqHLEkXlo23NFPrtKxQt3d0AmfiW8bvZNOjOxcmYBy/rwOBsqN+2ENfAPSqeLRiMDUgEBD+JPiw=
X-Received: by 2002:a17:90b:3807:b0:31e:cdc1:999e with SMTP id
 98e67ed59e1d1-321161de775mr7111304a91.1.1754328792552; Mon, 04 Aug 2025
 10:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250804134154.95875-1-timur.kristof@gmail.com>
 <20250804134154.95875-3-timur.kristof@gmail.com>
 <CADnq5_PPfscSbxEhmDXzcgcQNX3RecMzUwZMsXm5Cm+g72uDaA@mail.gmail.com>
 <98b288895c31c3c94fe7a23f6694b583caae5f65.camel@gmail.com>
In-Reply-To: <98b288895c31c3c94fe7a23f6694b583caae5f65.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 13:33:01 -0400
X-Gm-Features: Ac12FXxUab0CRtGYQO5rvA-lDBpmdHMYY3HqOfkJgBV_1rMrWBnKklZAtqllbbU
Message-ID: <CADnq5_MeeM17iKa8r5h4jhrv9Y_QuHWjM=+Jc1PwzfEnQSon1Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/amd/pm: Disable ULV even if unsupported
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Mon, Aug 4, 2025 at 12:04=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On Mon, 2025-08-04 at 11:24 -0400, Alex Deucher wrote:
> > On Mon, Aug 4, 2025 at 9:58=E2=80=AFAM Timur Krist=C3=B3f
> > <timur.kristof@gmail.com> wrote:
> > >
> > > This commit fixes some instability on Tahiti.
> > >
> > > Sometimes UVD initialization would fail when using DC.
> > > I suspect this is because DC doesn't immediately turn on the
> > > display clock, so it changes how DPM behaves.
> >
> > Is this the right description for this patch?  I thought you had said
> > this fixed something else.
> >
> > Alex
>
> Yes, this patch together with the previous one fixes the "amdgpu: UVD
> Firmware validate fail" when I enable DC on Tahiti.
>
> Last week I thought this also fixed the "si_set_sw_state failed", but
> that turned out to be wrong. For that one, I sent a separate patch
> which involves a different fix.

Thanks for clarifying.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Timur
>
> >
> > >
> > > Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
> > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > ---
> > >  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > index 52e732be59e3..33b9d4beec84 100644
> > > --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > @@ -5639,10 +5639,13 @@ static int si_disable_ulv(struct
> > > amdgpu_device *adev)
> > >  {
> > >         struct si_power_info *si_pi =3D si_get_pi(adev);
> > >         struct si_ulv_param *ulv =3D &si_pi->ulv;
> > > +       PPSMC_Result r;
> > >
> > > +       r =3D amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_DisableULV);
> > > +
> > > +       /* Only care about SMC reply when ULV is supported. */
> > >         if (ulv->supported)
> > > -               return (amdgpu_si_send_msg_to_smc(adev,
> > > PPSMC_MSG_DisableULV) =3D=3D PPSMC_Result_OK) ?
> > > -                       0 : -EINVAL;
> > > +               return (r =3D=3D PPSMC_Result_OK) ? 0 : -EINVAL;
> > >
> > >         return 0;
> > >  }
> > > --
> > > 2.50.1
> > >
