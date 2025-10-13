Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0425ACCD183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 14:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A163A10E111;
	Mon, 13 Oct 2025 14:23:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KqtQ3ycS";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD58710E111
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 14:23:06 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-79e5e17f6dfso8505b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 07:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760365386; x=1760970186; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1WsiXTdzD01+s2+2tNC9dCP7+3VPsZDgCJFRXvVsUew=;
 b=KqtQ3ycSa4ECpxbDCjUKKyn7k/rmGEs6aZOb8r2stJMDiA2xUuoi9SAYl3qm7U8CZU
 AnrWoCfv5+Hmb2n7tztqrct3TuLz1LVRT4IVAnGOAOAjzyIPMREC/Rf7yDn1vN/fLo8G
 cTSfBvzaV3ikuKQyrt+3tBZj9QNFjLX5LXwYc+ZB95Awtt+N++A1uuhb9y1iKGg7vQDF
 T7jlpcMCf1i/RacEkMKuz/y3z1ZXxnVW9Ik3VDcjr1Rmj8UEqo6wkm9J2bfflJAQefqu
 iWT2PGIpKDVNW/7gORZk24BtWVTxhYZD9EaTq/HdFIdzp+Q4xKFCmThyym2Kl8GNCQnr
 yY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760365386; x=1760970186;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1WsiXTdzD01+s2+2tNC9dCP7+3VPsZDgCJFRXvVsUew=;
 b=QHbtBNTceSNsjW2TgqNGsqpmGJq1XW1Jps+H909ZW+ibh5Gxfv+TwP9bAHuwpJNmPm
 d2VdVZcvwR3q1a7btcOo58A0PubRhRKAJFA2uhwNqvyzbL7AMebVxuOrd7me4WvdQpfJ
 mpPOdVQWG4LhYsi59KCInNvWcjW8j3duSCDevXDXH312M5Zrg4OtEm74oeUfyCSdbfOu
 eO+7zJYva+a00+OmsyUgu4gI6FLh2xNYObUQ2Rh9RaNbetCq1d39iTzV/xoQ9lTL+ZM+
 E8JUZMDH6mRjKO62k9buHwBmtgB4yhS5fESMj8NBoPKDVHBWp+zM2N3IGLTWafg6Z1rN
 tMjA==
X-Gm-Message-State: AOJu0Yxy9Xk5A7L9Lfjmx5lMYOZmYhDEVHCEy1gu6g7ZZQIWA7FaZ8FO
 l+SsSMnyqgFJrRuS941s4wPBVt8+t/plJqfmQHgBoAerwBSeZkPJupxISX1ZiTFua83Fl7dAxX2
 Urj/pELxoQZvLiPCidsmqkZplRX7don92ow==
X-Gm-Gg: ASbGncuGgmNPj7ddeSp7CBsfIvAn1tWvielhsn2uOHMGD+c/fgRi9z8Lt0uBaiQoQlm
 cBMgu/r3e8bSc396fKKXNskPEANKUDk+Jzty7VSlNjF3AQrcsgj+9otlIQ1WZ9Az1CDzmRbswIa
 8ACOZ187IFtyOV4F9+4GtDdpb6d1CDU0e+OZ7SjrYF/Fa6dP9jxhVjMoum/YmpO/5/C0BlZ/bIo
 CgzvO/WVfmoyg+uXZaDRIsmSe9Y7c/Sc7cV
X-Google-Smtp-Source: AGHT+IFLkF6iGyFJD2WSYQ7qm4oxTO01hG0ZgpDO86nxaALMHhfZ3lM4oBBbpfd0I3IssI1dMVwrx5J34Zw+qNRxyvA=
X-Received: by 2002:a17:902:d2c9:b0:269:96d2:9c96 with SMTP id
 d9443c01a7336-2902724dcb1mr144887735ad.0.1760365386313; Mon, 13 Oct 2025
 07:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20251013060642.21269-1-timur.kristof@gmail.com>
In-Reply-To: <20251013060642.21269-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Oct 2025 10:22:54 -0400
X-Gm-Features: AS18NWCmzQ_459YBIqnjJ6fkbcMG-3qxxYhiT0fRblYkgoTXUlH6e8-bTOXK1Do
Message-ID: <CADnq5_PssVdG=NksW8q95_nOHs=HTKi=M_3E0qdz3Rhq7P2Ehw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Fix CIK shutdown temperature
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 mario.limonciello@amd.com
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

On Mon, Oct 13, 2025 at 2:31=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> Remove extra multiplication.
>
> CIK GPUs such as Hawaii appear to use PP_TABLE_V0 in which case
> the shutdown temperature is hardcoded in smu7_init_dpm_defaults
> and is already multiplied by 1000. The value was mistakenly
> multiplied another time by smu7_get_thermal_temperature_range.
>
> Fixes: 4ba082572a42 ("drm/amd/powerplay: export the thermal ranges of VI =
asics (V2)")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1676
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

and applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 8da882c51856..9b28c0728269 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -5444,8 +5444,7 @@ static int smu7_get_thermal_temperature_range(struc=
t pp_hwmgr *hwmgr,
>                 thermal_data->max =3D table_info->cac_dtp_table->usSoftwa=
reShutdownTemp *
>                         PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
>         else if (hwmgr->pp_table_version =3D=3D PP_TABLE_V0)
> -               thermal_data->max =3D data->thermal_temp_setting.temperat=
ure_shutdown *
> -                       PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
> +               thermal_data->max =3D data->thermal_temp_setting.temperat=
ure_shutdown;
>
>         thermal_data->sw_ctf_threshold =3D thermal_data->max;
>
> --
> 2.51.0
>
