Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450CCCE79CE
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 13:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C723110E150;
	Wed, 20 Sep 2023 13:29:54 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1AA210E150;
 Wed, 20 Sep 2023 13:29:52 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3ab3aa9ae33so4649699b6e.2; 
 Wed, 20 Sep 2023 06:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695216591; x=1695821391; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vVWGEgGSEjp4k+KXLV/K8fcEJkhuenia706z3qiQLdM=;
 b=MhwQ/1qSX3Z2r5Vy+TAo6h2wmWAIAIzm++hCZ0fWcVfw+Dyjuqn+AT5zbvrO/wSM8d
 4MI6zfleZut6Q8HE01Hx9ARaAP5tiyeLrEWGUa4oRj1uZS6UDHKWyTOChoJmrJ55s/pE
 xciFIBLOiZ4nNz0M8b5m4hYhKsdB0P2VDIeFSuAg+X68jt21/tGFXd3VPNMmDW4osd8w
 WoLFgTWkLkuacm7DraMYIQHI9yM2b+BfqvHp0B0To3PIvE9g/x76gHInpNc+7UP4zz3k
 F8hCQmlX0HRImDqLpUp8H5Av4Mj6ulWfOpzXgTAfuwArtB8zO5OUMZib9VoLmWjf3F76
 /3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695216591; x=1695821391;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vVWGEgGSEjp4k+KXLV/K8fcEJkhuenia706z3qiQLdM=;
 b=cQSgkFqu5TmOjs6V1WCzS2crWmBFPvH8jtQ7WB20JRZ0niwdZkZKfvQmMCCO7Uuj/B
 rkG7IBfc2TWnXROoXKnKso5UGo5T/wN8z3euJJQPfRV5gInKvR9Suav37XBIfOj2ZikY
 6jbx9zfzx/9hrwhmQ3f4LOihR2lAiOwkVdkxDcqHhMxiLp3KFKQgsXEcbMs1jBNJchvq
 CDCXyq6FwqqHDDx7injRtYcEcMiRmQ4tvaXtp2nO0YDLI4jnakkGrGLsocAD63S4MGV0
 IJuDM2cZZXbMzLic3uRamF8PcGBg4pLW6AI6dBt/zHIcRy3jetcVD2UBeqLMN+wTZiIi
 NYRw==
X-Gm-Message-State: AOJu0YyWpxQYHiCjznOotDGkkaUNjZQsZ/bstpW9WK+fRJHDY7M2i1Lm
 G3wsMisvvgulSq8J/qQI1YOLeYGR3fHMZIpg45s=
X-Google-Smtp-Source: AGHT+IF/BUd8MrJluzuOw7ioQsv1V6pvR5BavSSty4c1W5OmAuN4YZx6qQ/56UFJNwajEHtJFgc8XNtg6sya/8m/39A=
X-Received: by 2002:a05:6870:4248:b0:1d6:6941:d1d0 with SMTP id
 v8-20020a056870424800b001d66941d1d0mr2513289oac.49.1695216591341; Wed, 20 Sep
 2023 06:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230919093318.16407-1-swarupkotikalapudi@gmail.com>
 <e1294905-b867-4141-87ff-2b7202476e59@infradead.org>
In-Reply-To: <e1294905-b867-4141-87ff-2b7202476e59@infradead.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Sep 2023 09:29:40 -0400
Message-ID: <CADnq5_Oy=f9aQDX0VE7vE0brU3sLe08zWDukcRPBEyfhdUKUHw@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: amd: display: fix kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>
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
Cc: sunpeng.li@amd.com, airlied@gmail.com, Xinhui.Pan@amd.com,
 Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, alexander.deucher@amd.com,
 Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
 harry.wentland@amd.com, christian.koenig@amd.com,
 linux-kernel-mentees@lists.linuxfoundation.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Tue, Sep 19, 2023 at 5:54=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi,
>
> On 9/19/23 02:33, Swarup Laxman Kotiaklapudi wrote:
> > Fix kernel-doc warnings discovered in AMD gpu display driver.
> > Fixes these warnings:
> > ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110: warning:
> > Function parameter or member 'overlap_only'
> > not described in 'mpcc_blnd_cfg'.
> >
> > ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110: warning:
> > Function parameter or member 'bottom_gain_mode'
> > not described in 'mpcc_blnd_cfg'.
> >
> > ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110: warning:
> > Function parameter or member 'background_color_bpc'
> > not described in 'mpcc_blnd_cfg'.
> >
> > ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110:
> > warning: Function parameter or member 'top_gain'
> > not described in 'mpcc_blnd_cfg'.
> >
> > ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110:
> > warning: Function parameter or member 'bottom_inside_gain'
> > not described in 'mpcc_blnd_cfg'.
> >
> > ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:110:
> > warning: Function parameter or member 'bottom_outside_gain'
> > not described in 'mpcc_blnd_cfg'.
> >
> > Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com=
>
>
> Thanks for fixing these kernel-doc warnings.
>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/=
drm/amd/display/dc/inc/hw/mpc.h
> > index 8d86159d9de0..61a2406dcc53 100644
> > --- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> > +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> > @@ -91,6 +91,12 @@ enum mpcc_alpha_blend_mode {
> >   * @global_gain: used when blend mode considers both pixel alpha and p=
lane
> >   * alpha value and assumes the global alpha value.
> >   * @global_alpha: plane alpha value
> > + * @overlap_only: whether overlapping of different planes is allowed
> > + * @bottom_gain_mode: blend mode for bottom gain setting
> > + * @background_color_bpc: background color for bpc
> > + * @top_gain: top gain setting
> > + * @bottom_inside_gain: blend mode for bottom inside
> > + * @bottom_outside_gain:  blend mode for bottom outside
> >   */
> >  struct mpcc_blnd_cfg {
> >       struct tg_color black_color;    /* background color */
>
> --
> ~Randy
