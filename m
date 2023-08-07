Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC2FC001DB
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 16:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21A0910E2F1;
	Mon,  7 Aug 2023 16:49:22 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4E3E10E2F2;
 Mon,  7 Aug 2023 16:49:13 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-56c8757d45bso3083430eaf.2; 
 Mon, 07 Aug 2023 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691426953; x=1692031753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KGmmkCXMMyEo8pM0tNNo4ZW+64gDoL7rhIgRe9x2cRY=;
 b=D010eOd3qhm+mh+wnfbojjbzNHNcJEgWAnKg7JHHoRbkZtgzPGeDjxM9B97GtJoerP
 HnUx9R4j8OJsrvaguVLGIiL68icxr4LtivDlfxekGgZkkTnDoo/Ta4eXdcUdEIoDInKU
 HKliqHBEouvohawZSwuAvXoWBt59s6bv71d3Wt+hbTCxzmwaLI0qLTymsmN0Rl8auc/d
 i8OXV7iyWqPOkMd4kiN5SF+GldxDEgZVyatkFzLuYMZuWCK3/iyk0ITTUpIn/wNMapWS
 2l1Rn2118P6dpoRyTfkme0yZ/4HLNI+w23vq2tVEoJywuU9aqJggcpIATZQlP7Bgxo/R
 Vsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691426953; x=1692031753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KGmmkCXMMyEo8pM0tNNo4ZW+64gDoL7rhIgRe9x2cRY=;
 b=UDhd+1t5xKMbkUlPbhpzJKGkN7NPm0hdXr8OSHMkkwVs8261/OAGbfBIiE5yvdfnyb
 365Qrd4TS1TBhGcRJfzQGFt8z9JJiLsYTIjO4Jm9z5TKQl49OOQdPXrhqL+BT4m8gAm6
 7QV0yaanD6rtKRS4Ccow9TviPuVEYv056fx67DsvoQtvZqPi76aZ33q2Oiu1EQ6hG2Km
 fE09iHPQH2skxLUzJ86fkNuHaITRFb8UzKBD2PWY+PjKl+ShuhxbOBSJK8pF+3tIsrIv
 OnYl/MqrsZYiySNnZ1PqSSQO/3DUi2sgXTKU1fjr6Q3EezbqE+ceJFJlQTXCb1Bo0Wb/
 l8PQ==
X-Gm-Message-State: AOJu0Yx8LsmFsbcGwbWKzo4KqgxxSvR+GyVXUTE9EDSFTa+I1E5gnEk1
 sTroTpmnjfNBEcxCmkef1CsfhkApbBQ9hFUX904=
X-Google-Smtp-Source: AGHT+IEjwMBfsazRGEFURdoYzMHl7f5vZKtC+1dPDwjp/CD6DxnxH9EHmcsQMlGT3CF3i+28DIdWOSM5HNCfb02PCv8=
X-Received: by 2002:a4a:7658:0:b0:567:92:c45d with SMTP id
 w24-20020a4a7658000000b005670092c45dmr9029943ooe.5.1691426952955; 
 Mon, 07 Aug 2023 09:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230801093832.7849-1-sunran001@208suo.com>
In-Reply-To: <20230801093832.7849-1-sunran001@208suo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Aug 2023 12:49:01 -0400
Message-ID: <CADnq5_P34srDuav4V-4kZ81y5DdsqvZ9gxDYqjGjii8c3U1hww@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in vega12_hwmgr.h
To: Ran Sun <sunran001@208suo.com>
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
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com,
 airlied@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Tue, Aug 1, 2023 at 5:38=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following enum go on the same line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.h b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.h
> index aa63ae41942d..9f2ce4308548 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.h
> @@ -38,8 +38,7 @@
>  #define VG12_PSUEDO_NUM_DCEFCLK_DPM_LEVELS  8
>  #define VG12_PSUEDO_NUM_UCLK_DPM_LEVELS     4
>
> -enum
> -{
> +enum {
>         GNLD_DPM_PREFETCHER =3D 0,
>         GNLD_DPM_GFXCLK,
>         GNLD_DPM_UCLK,
> --
> 2.17.1
>
