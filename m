Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19166CA0EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 17:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9789A10E341;
	Tue, 12 Aug 2025 17:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JokWdvSn";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81F4810E341
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 17:39:31 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-240358f4aa2so4019285ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 10:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755020371; x=1755625171; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TgVcmyZoYzWKp4MFI1ux+f1lMSxgwEg1axZDedtl65g=;
 b=JokWdvSnoJeUsAuyy7vcS6eBleAw1pMeWRyIcyr6HaLRmPa+4o1huvsqRR42bdqwE7
 2lSNCWR0ed6Px0UZGGRk3LYIdP08/5VwkyD16oidV6h3lGRYkfIDMEWkULWzBlo97CL3
 QFVdAga6Ok1aH7VU4KUDK58NZMkyJdPSlugfK3e4YBugwUnExrelKGfQ0LElRQnAILF4
 YPIikehs+FgEvpry1HJXOM7aLTW9J0uzDvnbVQtk89Q20hXYfNeIycf4MZxMcdKu/HkK
 BSc0SDCLwXr+mXuaMAJ3lFyqNajmQy6n0vD9L5lIzfdSN3QRz2FtaO+BIoQ4tRVAinrl
 3WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755020371; x=1755625171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TgVcmyZoYzWKp4MFI1ux+f1lMSxgwEg1axZDedtl65g=;
 b=B+nuq1Hgu+OT/sH43T+s6bDHkpvaU+auUyfvOBmuT1+DxBf6VxkzceyeEsjB6BIzF/
 H4Ola4m1IjOpPLeKkLzT4a7ge6IePpHrYPDTQ5zpfA5Mm/VZpzrirdePaayKOoSB4M8P
 xY/WgC/3zUFHJ4HZYW+NqbolRkNHk0VD/8XG3hfjzsDWpl+AwZ2fDzn4a8DLMzcIHXPs
 KDAkC1nrH1I5vwz5u98Mf4QpFaweUj5z2BYe1vavSPWAytbadbjDjWIFhAVDrUxetAr/
 ZrFmyyWwzwJb3FqBGjOZCs5MWncau6zagluEMlIs+H3vyhD9r1A7gNYfEcadJX8apppi
 lJvQ==
X-Gm-Message-State: AOJu0YxMmN8E8XHfQ2krY8L+/6BP+mPS4uzlTGXUbrMsCZHRbwsOfvEU
 tAUH0UykUBUfuyfwWZ7bDK+PxZFsUljs444W7VrYaBNYxdcSgPrA7NkbBqOHRghSMEjxUFSRLQi
 3Edz6dQjlNU8RHzgP5QbCewOa+IVUWAE=
X-Gm-Gg: ASbGncv2DJAbgCbtoFd5SD8P3K4Y2kr7cAJiKetMxuOmpNLobDjGKAFXgcslvcTCABl
 PKMGAkXyfTJgQrPCBjbaFq0zLXnW1GvJqVNNAl+QMJZQy1xStH9sY0cpSncDtyxsktacgaGed/O
 /ilXdBGZDfnDar4KGxDmI7DuraWptRp6aADXRBbFgFfwZS+z5SbSNomfx+GO9aKm/44MMC0CmnH
 CCuyn4=
X-Google-Smtp-Source: AGHT+IEOPyIwFJ6DTzW+1EDCXIA0jToaWVRKjmvLEs6R6yifJL+OUU64ETBznxf1D6OhGrXvffCvsfUCk6nU8ALJYVU=
X-Received: by 2002:a17:902:ec82:b0:234:8f5d:e3a0 with SMTP id
 d9443c01a7336-2430d0c298emr416275ad.2.1755020370802; Tue, 12 Aug 2025
 10:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250808202912.2067194-1-alexander.deucher@amd.com>
In-Reply-To: <20250808202912.2067194-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Aug 2025 13:39:18 -0400
X-Gm-Features: Ac12FXx8yi_AEroBwSfcfhZFuu8VkWPcDscHmmQaCTEHm462HYVftEXRTSTWMdI
Message-ID: <CADnq5_MiUK-wPHthDU__j0e=vM7_829=CzaMXQdRHM895tzNzQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/swm14: Update power limit logic
To: Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
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

Ping?

Alex

On Fri, Aug 8, 2025 at 4:29=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> Take into account the limits from the vbios.  Ported
> from the SMU13 code.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4352
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 30 +++++++++++++++----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 3aea32baea3da..f32474af90b34 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1697,9 +1697,11 @@ static int smu_v14_0_2_get_power_limit(struct smu_=
context *smu,
>                                        uint32_t *min_power_limit)
>  {
>         struct smu_table_context *table_context =3D &smu->smu_table;
> +       struct smu_14_0_2_powerplay_table *powerplay_table =3D
> +               table_context->power_play_table;
>         PPTable_t *pptable =3D table_context->driver_pptable;
>         CustomSkuTable_t *skutable =3D &pptable->CustomSkuTable;
> -       uint32_t power_limit;
> +       uint32_t power_limit, od_percent_upper =3D 0, od_percent_lower =
=3D 0;
>         uint32_t msg_limit =3D pptable->SkuTable.MsgLimits.Power[PPT_THRO=
TTLER_PPT0][POWER_SOURCE_AC];
>
>         if (smu_v14_0_get_current_power_limit(smu, &power_limit))
> @@ -1712,11 +1714,29 @@ static int smu_v14_0_2_get_power_limit(struct smu=
_context *smu,
>         if (default_power_limit)
>                 *default_power_limit =3D power_limit;
>
> -       if (max_power_limit)
> -               *max_power_limit =3D msg_limit;
> +       if (powerplay_table) {
> +               if (smu->od_enabled &&
> +                   smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATUR=
E_PPT_BIT)) {
> +                       od_percent_upper =3D pptable->SkuTable.OverDriveL=
imitsBasicMax.Ppt;
> +                       od_percent_lower =3D pptable->SkuTable.OverDriveL=
imitsBasicMin.Ppt;
> +               } else if (smu_v14_0_2_is_od_feature_supported(smu, PP_OD=
_FEATURE_PPT_BIT)) {
> +                       od_percent_upper =3D 0;
> +                       od_percent_lower =3D pptable->SkuTable.OverDriveL=
imitsBasicMin.Ppt;
> +               }
> +       }
> +
> +       dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d=
 (default power: %d)\n",
> +                                       od_percent_upper, od_percent_lowe=
r, power_limit);
> +
> +       if (max_power_limit) {
> +               *max_power_limit =3D msg_limit * (100 + od_percent_upper)=
;
> +               *max_power_limit /=3D 100;
> +       }
>
> -       if (min_power_limit)
> -               *min_power_limit =3D 0;
> +       if (min_power_limit) {
> +               *min_power_limit =3D power_limit * (100 + od_percent_lowe=
r);
> +               *min_power_limit /=3D 100;
> +       }
>
>         return 0;
>  }
> --
> 2.50.1
>
