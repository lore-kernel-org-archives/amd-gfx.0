Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF25C4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 14:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EC8210E473;
	Mon, 11 Dec 2023 14:47:05 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E81F910E473
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 14:47:03 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1feeea75fbfso2913303fac.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 06:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702306023; x=1702910823; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3k8oV1J6Mhmy7dAdrAizIOTZXTTC3FDSyWhhVoePaMM=;
 b=bXqgfes2SHziCxkUONQggWGq67vH2FPUypxvSnG952kCaPXNWfeX9s7FMHE6+MjBV7
 6LCSgxdBvDN0lyKVinM6WmS0llau8IYAzc7xkq+V4c7lYXDjT49HxlQyaEjEtKU95o89
 wR1r7LOxnmABjVSbgFNQZAAEclYwkw2o/a+Ne4kTRD8xlZR7BIDQG/heOhRlOIopbLVB
 J5KsJ/fv37yyD0v2t+DQo18UwJWdYeM8p/P9MKlwywjqyFpOS5Gri+d3OE+ZRMIEFoq6
 ZdhVWKu9SVB88JqhcSkAquZgM33Xbej4fHliIIZZ/VCN0r0ZHAvpQ98JMVI8GPEUStI2
 UTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702306023; x=1702910823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3k8oV1J6Mhmy7dAdrAizIOTZXTTC3FDSyWhhVoePaMM=;
 b=w7I173vrdwTWsU3Wu6c66sN/P/VOFSuD8NUB4VnG/++FSjFeRuCRoXgloCo4QO/2oy
 csVzAICkV+a+51HDzBMr7OJSYvr39MtCWfV8KYPJH3VK1m79YFJl+GtA1qc8K9TWPBOC
 DxTO1wUViuJ9MJ3qgOiw6040fR87QFrcdCVBDWlMuyTqlJKdJvi5AiwH9ckLIpF3+ZIj
 A3uvbBGlj+M33ZpSfOHbV3MTiTexZpT95i2y/I1Fswp5RV//QwUHps1ub4HRdKdQAVf9
 APj7OIZlg5j1GoyWttAqUiES1hERurRou4oLuMOBwHvsEbCQuV8iJZSMF37o35DUPYr8
 zXxQ==
X-Gm-Message-State: AOJu0YwxyNIjQKpoUdP8ISHkIkfAgdjCarDk4ayDLSD7Py4P/IOjM59j
 LJUYf6RgX2qf3iphE98G13r8G0bHNPbGSJ2gIco=
X-Google-Smtp-Source: AGHT+IED+ePBGYeLKfKIzKuttbd8qiyKR+6xN8NeN9YFn4jfD3doBb6c1ZDoKYA6Alu3jZ/3G8SQqp8avig6EPCGJsk=
X-Received: by 2002:a05:6870:8a21:b0:1ff:a07:d38c with SMTP id
 p33-20020a0568708a2100b001ff0a07d38cmr4797532oaq.85.1702306023058; Mon, 11
 Dec 2023 06:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20231209200830.379629-1-mario.limonciello@amd.com>
In-Reply-To: <20231209200830.379629-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Dec 2023 09:46:51 -0500
Message-ID: <CADnq5_PEff3EYs97vMj-m9ft6dGe7YgvQ2VcKFTOUJn_qKcdDg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Disable PSR-SU on Parade 0803 TCON again
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: binli@gnome.org, stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 aaron.ma@canonical.com, Marc Rossi <Marc.Rossi@amd.com>,
 Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 11, 2023 at 1:22=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> When screen brightness is rapidly changed and PSR-SU is enabled the
> display hangs on panels with this TCON even on the latest DCN 3.1.4
> microcode (0x8002a81 at this time).
>
> This was disabled previously as commit 072030b17830 ("drm/amd: Disable
> PSR-SU on Parade 0803 TCON") but reverted as commit 1e66a17ce546 ("Revert
> "drm/amd: Disable PSR-SU on Parade 0803 TCON"") in favor of testing for
> a new enough microcode (commit cd2e31a9ab93 ("drm/amd/display: Set minimu=
m
> requirement for using PSR-SU on Phoenix")).
>
> As hangs are still happening specifically with this TCON, disable PSR-SU
> again for it until it can be root caused.
>
> Cc: stable@vger.kernel.org
> Cc: aaron.ma@canonical.com
> Cc: binli@gnome.org
> Cc: Marc Rossi <Marc.Rossi@amd.com>
> Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/=
drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> index a522a7c02911..1675314a3ff2 100644
> --- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> +++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> @@ -839,6 +839,8 @@ bool is_psr_su_specific_panel(struct dc_link *link)
>                                 ((dpcd_caps->sink_dev_id_str[1] =3D=3D 0x=
08 && dpcd_caps->sink_dev_id_str[0] =3D=3D 0x08) ||
>                                 (dpcd_caps->sink_dev_id_str[1] =3D=3D 0x0=
8 && dpcd_caps->sink_dev_id_str[0] =3D=3D 0x07)))
>                                 isPSRSUSupported =3D false;
> +                       else if (dpcd_caps->sink_dev_id_str[1] =3D=3D 0x0=
8 && dpcd_caps->sink_dev_id_str[0] =3D=3D 0x03)
> +                               isPSRSUSupported =3D false;
>                         else if (dpcd_caps->psr_info.force_psrsu_cap =3D=
=3D 0x1)
>                                 isPSRSUSupported =3D true;
>                 }
> --
> 2.34.1
>
