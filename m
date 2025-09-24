Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354CBCAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 17:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6F2410E7A7;
	Wed, 24 Sep 2025 17:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LPxt7aTm";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7ACF10E7A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 17:59:10 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-269ba651d06so137865ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758736750; x=1759341550; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYxzPl4txcDtBsDgUFMQiABFR95EJgZY6ii1JhXVVI8=;
 b=LPxt7aTm2alTEcvD2E9PKlCiYu5XoV3fkdmxsl1JFPrxBHwca34UmzFWBPFW0ChYFk
 F+ln9/xl1WlsMOdug4BICiae2J1AcnK0AGPQ/IBqpTVSWWjj3wUzoPIOmYTZXA+qFuf9
 HMSCN8b5XsW2jHlEcuzhGubMV8XN16BUCu02A5A5zBh3P8V41+dCYkCj09xz69K0+Iq8
 eNNG8AZuljnIRIJeXNezSmXh8/0T3M+lzBxEObXXjQUxkalkkfTsARKoodVlczF5Ngt/
 3bJBY0Kiw9xa6zcojyxTfiPkpxmduA1TEPiNrt5c77RLCpWyt9qykccBeaEwahI+zyau
 01pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758736750; x=1759341550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYxzPl4txcDtBsDgUFMQiABFR95EJgZY6ii1JhXVVI8=;
 b=OdHdKuQJKh13XGQYNALw+Ibhd1hV64Xom6NLAqeK+c4GrdAlw0FCjVn7a3oy3SGhKX
 u2Ny+9+/YxKNVo5XgB0a3CzpcbezQZTGy9Y4RCjS56Q3ibqLPFxU2nOIO94buk4R6kVQ
 CTDzA3RiHZV2ob4mX+CglKBiOUHdY8ey0SVjA9F2hfNk26RCrMfFp8cYlCYkMXC6uJuI
 wSKNIpy16wlWgHV5+PEnnzgshyci8NSYHTF5mlDB0sM9M6iSUfLgdehsyOvdjJtdAMjE
 jvPi9tqwSMz4OL4RLA5qIiwouZYzhMAsm+OLkreTKVcJheqKtUo+3AEV3I3Iz5jaZAMs
 gAHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3IRAn8z7xF3gxNgU1n5irszvDl6EF8/BcSpQm44vpmUx4d8do7n3I1tbLhdwc0M98Fi2Ni7J3@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy3K9IArij9SaMOaV0G3Lp3BxirrqIQ8vN8+AW5N/kQOmek+jv9
 7oV7LmyeJjUpXyKC8QdUJGFvqhgsiZgJU7bdhrQbvjUYNa1kAnoXQP7Yzln5GUJfs8Nqx+pubzg
 0TFbbM7P7WpAzwTNiZRyMTVnJfbZsfw0=
X-Gm-Gg: ASbGncsq09u+PqAj3FDbsJBpGKSiiZ49ptDyWvXNSFQdpKDlpNOegty+HJgVC3Nf3fO
 gZYl6sgc0R2wi3EO3H/CtC3HBl5Nqt4L7w8VHG91SyClLwYGBPl52CsZt39MldklXH83XhjOwFE
 RIgGS2zrqUa0UtYWuYTHL+Cs7XtVEPHmuAssOACpFTSC/cAPuCQUPl72ff8puZei+YgXZtfbWIN
 Pzt2+qNx4DdVHaW0w==
X-Google-Smtp-Source: AGHT+IHtmTWOHSGgYcdz8PkfFJmwvin/TwYsBXRKFtdnnBmyjBC8YY/e52r2/3CWmsd7o/0M3YI4RSTRvcUs/JavpQ0=
X-Received: by 2002:a17:902:d508:b0:269:96d2:9c96 with SMTP id
 d9443c01a7336-27ed5b0a538mr1060065ad.0.1758736750323; Wed, 24 Sep 2025
 10:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_A8BB4A0E44BDCF1DEC33942D2144C521AF07@qq.com>
In-Reply-To: <tencent_A8BB4A0E44BDCF1DEC33942D2144C521AF07@qq.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Sep 2025 13:58:59 -0400
X-Gm-Features: AS18NWABn1U1ZnqDyt6w4crHZgXq-GwZsjSJiYpEOu3bz9xtozY2P_noK06Meps
Message-ID: <CADnq5_PCGv7a4azG+mhv+=Jmp74-O73iUnZctLkNYKabRGcwMg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Solve the problem of the audio options not
 disappearing promptly after unplugging the HDMI audio.
To: 2564278112@qq.com
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Wang Jiang <jiangwang@kylinos.cn>
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

On Wed, Sep 24, 2025 at 7:44=E2=80=AFAM <2564278112@qq.com> wrote:
>
> From: Wang Jiang <jiangwang@kylinos.cn>
>
> The audio detection process in the Radeon driver is as follows:
> radeon_dvi_detect/radeon_dp_detect -> radeon_audio_detect -> radeon_audio=
_enable -> radeon_audio_component_notify -> radeon_audio_component_get_eld
> When HDMI is unplugged, radeon_dvi_detect is triggered.
> At this point, radeon_audio_detect is triggered before radeon_dvi_detect =
has finished (which also means the new state of the connector has not been =
reported).
> In this scenario, radeon_audio_detect can detect that the connector is di=
sconnected (because the parameter is passed down),
>  but it is very likely that the audio callback function radeon_audio_comp=
onent_get_eld cannot detect the disconnection of the connector.
> As a result, when the audio component (radeon_audio_component_get_eld) pe=
rforms detection, the connector's state is not shown as disconnected,
> and connector->eld is not zero, causing the audio component to think the =
audio driver is still working.
> I have added a new member (enable_mask) to the audio structure to record =
the audio enable status.
> Only when radeon_audio_component_get_eld detects that enable_mask is not =
zero will it continue to work.
> There might be other solutions, such as placing radeon_audio_detect/radeo=
n_audio_component_notify after the completion of radeon_XX_detect.
> However, I found that this would require significant changes (or perhaps =
it's just my limited coding skills?).

This still looks like a race.  I think the get_eld() callback can get
called whenever.  The proper fix is probably to hold the
connector->eld_mutex in radeon_audio_detect().

Alex

>
> Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
> ---
>  drivers/gpu/drm/radeon/radeon.h       | 1 +
>  drivers/gpu/drm/radeon/radeon_audio.c | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/rad=
eon.h
> index 63c47585afbc..2d0a411e3ed6 100644
> --- a/drivers/gpu/drm/radeon/radeon.h
> +++ b/drivers/gpu/drm/radeon/radeon.h
> @@ -1745,6 +1745,7 @@ struct r600_audio_pin {
>         u32                     offset;
>         bool                    connected;
>         u32                     id;
> +       u8                      enable_mask;
>  };
>
>  struct r600_audio {
> diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/rade=
on/radeon_audio.c
> index 8d64ba18572e..a0717895cc8a 100644
> --- a/drivers/gpu/drm/radeon/radeon_audio.c
> +++ b/drivers/gpu/drm/radeon/radeon_audio.c
> @@ -212,6 +212,7 @@ static void radeon_audio_enable(struct radeon_device =
*rdev,
>         if (rdev->audio.funcs->enable)
>                 rdev->audio.funcs->enable(rdev, pin, enable_mask);
>
> +       rdev->audio.pin[pin->id].enable_mask =3D enable_mask;
>         radeon_audio_component_notify(rdev, pin->id);
>  }
>
> @@ -274,6 +275,7 @@ int radeon_audio_init(struct radeon_device *rdev)
>                 rdev->audio.pin[i].connected =3D false;
>                 rdev->audio.pin[i].offset =3D pin_offsets[i];
>                 rdev->audio.pin[i].id =3D i;
> +               rdev->audio.pin[i].enable_mask =3D 0;
>         }
>
>         radeon_audio_interface_init(rdev);
> @@ -760,6 +762,9 @@ static int radeon_audio_component_get_eld(struct devi=
ce *kdev, int port,
>         if (!rdev->audio.enabled || !rdev->mode_info.mode_config_initiali=
zed)
>                 return 0;
>
> +       if (rdev->audio.pin[port].enable_mask =3D=3D 0)
> +               return 0;
> +
>         list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
>                 const struct drm_connector_helper_funcs *connector_funcs =
=3D
>                                 connector->helper_private;
> --
> 2.25.1
>
