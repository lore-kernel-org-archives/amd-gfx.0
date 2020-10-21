Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF5BC388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 13:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41DA8208C3
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 13:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rtzp8gGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DA8208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA0E36E140;
	Wed, 21 Oct 2020 13:40:20 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D07A6E140
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 13:40:19 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id a72so2256210wme.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 06:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h2NBsM4M+4dUeSMM2mq7POZyrXGzcfND3LBvoxWU1Ts=;
 b=Rtzp8gGMmOSIMscZqvgEK83ESZRNEb2WkGWRsWDz3KTP5GIQV8PM372w6eXPrkKgLn
 ww6/TFVP1y5jH7kNzq+bPU1+vzhx7LAOORngg9Zk9PBtCYmCnsHV0pOB/MhIUlZB0olQ
 LjDqrqK4mp5HBMfr9IPGTRfE8WEBGpc6xUNA77NvoBGmkiQCJn8lYV0VfcY9Q2W5nZ4H
 wfGV7FSEwfrGDNMtEihPeikdYmMJ79YNij6yDB+oHFlojl5Ql0h0XZjybCCzhDQ9nor4
 eExdF1UVSOHTRMwgnoEy98gidmfEeebCdJYC98xGzMR0xOElJcn87DvZnBXkzUj92GdM
 QtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h2NBsM4M+4dUeSMM2mq7POZyrXGzcfND3LBvoxWU1Ts=;
 b=C5bOqmKxcmWS2kLOVrfnVxhUvJfeacWteI5twyLSAyGH1OPTmO5KuOYiJAgKvpAD0I
 hJVTcVSi4vZKmTcF+fqdlCdGtoDzzIwbJFyTlPl7ChHMoP0LE0VBqv1t2knODJNdT7Tx
 fr8w0vQOJVaZkxVV0Uul9jwtQWQxn4yvpgRI0uNL2qJ0LB+WUmAf0Yw2mBTxPGEq20fl
 B0DlJi3DNTacT4CHiwYPOdho91XeVIBrAmMKo9UzRwmekSkPS5rZlzHXhXHsINQAfyzo
 HFhmdhpPTaQU9x90POWpTMp01hQ7qhuGD9R+1w/z7g6b7N0prq4D7Csm8HdLygK68gRf
 ydeg==
X-Gm-Message-State: AOAM530sMgpDIFHwEjQiDV4955qn8MIRFwo0/93DG98oRvkkb7jYd79u
 Sm8jatN+1EZAiLMUNOVjt2kRa7W/OjD7CsgZ6dQ=
X-Google-Smtp-Source: ABdhPJxM6MR8soOfE9HbCM61wY0R5cnp/A3QtRDobUONEEzEe9ykpY6KYjHavJmTAQKju7cND9/NTtnkzysjD83EcJY=
X-Received: by 2002:a1c:4b05:: with SMTP id y5mr3738267wma.56.1603287618263;
 Wed, 21 Oct 2020 06:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201021064455.14935-1-kenneth.feng@amd.com>
 <CADnq5_PdS8M3i9uQ3JTUE-idGJxVCk_k5N=Sgvsj4VJGFKn_vA@mail.gmail.com>
In-Reply-To: <CADnq5_PdS8M3i9uQ3JTUE-idGJxVCk_k5N=Sgvsj4VJGFKn_vA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Oct 2020 09:40:07 -0400
Message-ID: <CADnq5_NLyQ2jOW0ZkYMXcAX-snqHvUzNRYtrDRZbhN7qe0_5Zg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
To: Kenneth Feng <kenneth.feng@amd.com>
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
Cc: Likun Gao <likun.gao@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 21, 2020 at 9:01 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Oct 21, 2020 at 2:45 AM Kenneth Feng <kenneth.feng@amd.com> wrote:
> >
> > fix the wrong fan speed in fan1_input when the fan control mode is manual.
> > the fan speed value is not correct when we set manual mode to fan1_enalbe - 1.
> > since the fan speed in the metrics table always reflects the real fan speed,we
> > can fetch the fan speed for both auto and manual mode.
> >
> > Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
>
> NACK.  At least on the navi boards I have, the metrics table fan speed
> reads back 0 when the fan is in manual mode.  That's why I changed
> this in the first place.

Nevermind, I was thinking about navi1x.  If this is working correctly
on sienna cichlid, please ignore me.

Alex


>
> Alex
>
>
> > ---
> >  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > index 496abc31b07e..27b6cade9ade 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > @@ -1171,14 +1171,9 @@ static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
> >         if (!speed)
> >                 return -EINVAL;
> >
> > -       switch (smu_v11_0_get_fan_control_mode(smu)) {
> > -       case AMD_FAN_CTRL_AUTO:
> > -               return sienna_cichlid_get_smu_metrics_data(smu,
> > -                                                          METRICS_CURR_FANSPEED,
> > -                                                          speed);
> > -       default:
> > -               return smu_v11_0_get_fan_speed_rpm(smu, speed);
> > -       }
> > +       return sienna_cichlid_get_smu_metrics_data(smu,
> > +                                               METRICS_CURR_FANSPEED,
> > +                                               speed);
> >  }
> >
> >  static int sienna_cichlid_get_fan_parameters(struct smu_context *smu)
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
